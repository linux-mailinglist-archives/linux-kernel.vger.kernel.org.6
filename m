Return-Path: <linux-kernel+bounces-343976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA22298A1FC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2761F24D35
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843E118E023;
	Mon, 30 Sep 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ewoo6LbA"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43059155312
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698535; cv=none; b=tnwHYDbRUW0KSzetV/oYOrNiI+uokvg2xfoVcibMNJQguViWd9hiaM/yM/WYcrwyPCzl7kJyb+OINZZdDQ6VKfAIH1Wqy0UwKRqR1DOKx/7BtxjHWsXQs0Umysh9t+ofOkuqtR4NTxtYwm3vCwAVqNhlj0TdvARlvb+LCzwCndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698535; c=relaxed/simple;
	bh=KTTTdA0AHVTbXipDjzirYEG7erz3pumcVb2p3ykYriY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FQtYk4VVT4yipLlqhh2pl17gj8OWKDrnWqx/RtO9ZuhYyQXUPqN+7xj76bd8mZpbObkKEJU3pXpypTBTMjFBK1rzRfOrw+i8KnDADQY2o8dvdEIGRhFlCZOAGsz6dJ5cyL5Zo08l1vGH4MaXQTrU05unubAIDMRjkECCWe3QbIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ewoo6LbA; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727698531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CS5+mNybhONSDgWqLEn/GrgAS06NWUK5v4oao/KVKIM=;
	b=ewoo6LbAXnP2C1Ede6RPVeaXxB4awfOKP/bw+CFmXabdW2v/FMmREtzMNUvt8Uch8Rqqd6
	75rtjCq18xHSb5QZDU9HaSE5WziLyZ812qHRzTQMIoAWspegkiG2/UcHFkyPDWAlOdJ1LI
	vVq4N8HvCwaViQGLc6Y5pH71uP702oY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] w1: Use kfree_sensitive() instead of memset(0) and
 kfree()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <fc0c13df-a0a6-4cf7-badc-c08a9a7054f6@kernel.org>
Date: Mon, 30 Sep 2024 14:15:18 +0200
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <581388A8-4FC3-4FC0-9D5B-9F13DCB90073@linux.dev>
References: <20240930114404.80910-2-thorsten.blum@linux.dev>
 <fc0c13df-a0a6-4cf7-badc-c08a9a7054f6@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 30. Sep 2024, at 13:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 30/09/2024 13:44, Thorsten Blum wrote:
>> Use kfree_sensitive() to simplify w1_unref_slave() and remove the
>> following Coccinelle/coccicheck warning reported by
>> kfree_sensitive.cocci:
>> 
>> WARNING opportunity for kfree_sensitive/kvfree_sensitive
> 
> So are you fixing coccinelle just to hide the warning or actually fixing
> issue? Why this structure should be zeroed?

No issue, just a refactoring (+zeroing out) to silence the warning. The
structure probably doesn't need to be zeroed out, but why is it done
for DEBUG builds?

>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> Please note: this change assumes that #ifdef DEBUG is no longer needed
>> and we should always zero out the memory.
> 
> But why are you assuming that? Your patch is not equivalent and I do not
> see any explanation in commit msg why is that.

