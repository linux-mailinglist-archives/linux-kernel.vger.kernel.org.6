Return-Path: <linux-kernel+bounces-361842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D3E99ADB4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645B31F25700
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18B11D14FD;
	Fri, 11 Oct 2024 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PzooTAUb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydmvuoZ1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA811CC162
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679781; cv=none; b=riI4KzU9QHLdRynyIBgt5uHPnElfSkf/80uxuyau0AZ+74O+I+3aOcpg8sQC+xmuzYn0Zix0qC9VZqUkYdZFCoe3XL7tyPcxsSSFWK06zgJTwoc7GSnuKWxZlX/VJ3h+S21PoYjmQRjsi8sVtjbiUiYT9trlrZshv+xPJ8xiAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679781; c=relaxed/simple;
	bh=dddfydH9lgFeNzimXr4CKrQ4MWViN3/UpE6OfE30ztM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bCbXL2gS2ooE98mFsaGnLDvt5UUeb3/8jrC96L0ruK8O6P7H9yAFrX/6Gcb9QhAH7r0oUXV2Xv3/ABYSd/7z+5EgPZRpVWJdHtPaP5t9btMxPqbdlhvhfMfIW2vzk5ae8OHJWhJE75L8FSomFrPkMo0ygM48GT+OrhsRpRzQrBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PzooTAUb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ydmvuoZ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728679778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZYA9CRf78mwtC5Rolgn+7gfivG0Hlf6HJUfGo8sSyc=;
	b=PzooTAUbD16aRTNrXd/W1Ex/SaJkiRtLqCw8Og8aK6DBIHnoJGj+9uCqFca0MNmnf8SAHA
	DX/QgBYaFQY6TVhcGcRMoM+hf04d9ZCdt4Wa7Ysma9R9ink3zWIymUO18MEzP+coHaYC6p
	ceKvaDk/P+5E2x0FoCKOOvqPxI6ij2RmfK9f2dydNikreX3tE+rGgxQ1kCl5KOywOBmNrY
	ZAdqRJSd76o7jdmxXo70Nc74AT9h4lqHciu2UtXljlCoQycUuoJ3IN/pon77ltMuBy/WMy
	qQAAhbawgyyO006XQVYH2xG4IaTmQmt6jr4r0wPc6JPo6CvfvpmcK0ezMcesRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728679778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZYA9CRf78mwtC5Rolgn+7gfivG0Hlf6HJUfGo8sSyc=;
	b=ydmvuoZ1S3EZ9wdIuNCX1TqPze6DVWXxXi3eVdO6euQOCTQYlcIGmrGAp0D9PHCbzTKgPA
	e/HdNUXDOmL+HoDA==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Waiman Long <longman@redhat.com>
Subject: Re: [patch 24/25] debugobjects: Refill per CPU pool more agressively
In-Reply-To: <73661d9d-0fb4-08b8-aea9-e54fffba4027@huawei.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.439053085@linutronix.de>
 <73661d9d-0fb4-08b8-aea9-e54fffba4027@huawei.com>
Date: Fri, 11 Oct 2024 22:49:37 +0200
Message-ID: <87ed4mgyam.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 18:02, Leizhen wrote:
> On 2024/10/8 0:50, Thomas Gleixner wrote:
>> +			/*
>> +			 * If this emptied a batch try to refill from the
>> +			 * free pool. Don't do that if this was the top-most
>> +			 * batch as pcpu_free() expects the per CPU pool
>> +			 * to be less than ODEBUG_POOL_PERCPU_SIZE.
>> +			 */
>> +			if (unlikely(pcp->cnt < (ODEBUG_POOL_PERCPU_SIZE - ODEBUG_BATCH_SIZE) &&
>> +				     !(pcp->cnt % ODEBUG_BATCH_SIZE))) {
>
> It seems better to swap the contents on both sides of &&. Because the probability
> of the current right side is lower.

Good point!

Thanks,

        tglx

