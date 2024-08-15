Return-Path: <linux-kernel+bounces-288014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9934A953050
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182C4286846
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A064419EEBD;
	Thu, 15 Aug 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vtFlbMjn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="69CflsgF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6A19DF60
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729287; cv=none; b=XhfShcu2JxE5R6IHK2oFtkr6nsVL1nTvfwG40v0ZCAMjIbHUTF4oZBDs6d7rl7cZVD2tTxlt0oPRWwbCqQzrTUNTELy1u3R8WQitu6yhlN5lQFn2Qj3fELXDCvbVSacetGnX2Vwm8zcBgUAX1hrR/ltuPTQjnHrHl4HbnJxtBtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729287; c=relaxed/simple;
	bh=HEv3T2OJg63ZWuoNiRtvUM0qIH1Po5TBb51QSabocZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K31X7f+PyCzvilgvV7rbfblqFn1BqwRzPIvLskEJ7LeogHvQH2X6jBl+e3xyz8QhQITle+ij45Mgpe2vOthFj4l4xspulEb92l/YIdLH6mCneoFtTcfZKWuxIgcafiwo1UbawoYmCl3F2mLhNPBnE/Jqo94JNjFHEasrhq6hlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vtFlbMjn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=69CflsgF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723729282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nUPq7nTcZ/5rB57N+BBqv8C/kYVFpDlbnSC0IU4n96M=;
	b=vtFlbMjnttTNEK6DwcBO/ep/1+D5odt8EKylE38aUyYa6fbrCocecsx9NQuPf6y5yAVv/8
	el6JhM4lL8oeQ/FGZ0J9tJmMj3jIl1QefPLFaFufjSfHp++orcg4w2UOtmDuVliXpclK3N
	hDEaXwAOEGzFHwH49JX54vsHHjvTulvXGhtBlBCTnJHvBi8MAAyyQ2dj+X04eIdOwuViyg
	ItLeyE1iq2S94j9j1VDFHxmXi2MxwPaHnlWaVnxpQAdCRefc7mtY+iBI2HhH3ay2GO9xwr
	3zhwuShYns5oWv/hwhKhfXmW5z+5Su9OGa7M+TfrYaaBr6mn0q4Ah+UBuwQsFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723729282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nUPq7nTcZ/5rB57N+BBqv8C/kYVFpDlbnSC0IU4n96M=;
	b=69CflsgFp4EQ2HSJQhGLkJXTsuc003qsFjiyDb0DxnOcAGXsvfATfmFrWCKigUDGMiA0Ep
	9/Mn8wZyaWjPQ+Dg==
To: Christoph Hellwig <hch@infradead.org>, Alistair Popple <apopple@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, Max Ramanouski
 <max8rr8@gmail.com>, x86@kernel.org, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 jniethe@nvidia.com, jhubbard@nvidia.com, linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/ioremap: Use is_ioremap_addr() in iounmap()
In-Reply-To: <87wmkjnqi4.ffs@tglx>
References: <20240812203538.82548-1-max8rr8@gmail.com>
 <Zrwyh9bKGVzkLzeA@infradead.org> <878qwzpfbi.ffs@tglx>
 <87le0zmhdp.fsf@nvdebian.thelocal> <ZrygJqIAz_AqqjcT@infradead.org>
 <87wmkjnqi4.ffs@tglx>
Date: Thu, 15 Aug 2024 15:41:22 +0200
Message-ID: <87jzghnbst.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14 2024 at 16:11, Thomas Gleixner wrote:

> On Wed, Aug 14 2024 at 05:16, Christoph Hellwig wrote:
>> On Wed, Aug 14, 2024 at 10:08:23PM +1000, Alistair Popple wrote:
>>> I would tend to agree and had the same thought when we found this. At
>>> least some kind of message (WARN_ON, WARN_ON_ONCE, printk, etc) would
>>> have made the issue we were debugging much more obvious. FWIW I have
>>> tested running with a WARN_ON() there and it never fired except in the
>>> bug scenario.
>>
>> Various architectures had either an early ioremap variant that got
>> silently ignored here, or magic carveout that don't get remapped at all.
>> None of this should currently apply to x86, though.
>
> So I'm inclined to have:
>
>        if (WARN_ON_ONCE(is_ioremap_addr(addr)))
>        		return;
>
> in the x86 variant then.

Max, care to provide that with a reasonable change log?

Thanks,

        tglx

