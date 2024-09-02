Return-Path: <linux-kernel+bounces-311281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495DC968718
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0021C22EEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CA20010A;
	Mon,  2 Sep 2024 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zerv2uSV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wKdFbhGU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157E185939
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278859; cv=none; b=X0TMbl0vIXU9vd5LNZO+22mHcaQQ+hiISn/8Bzj66Jim1CBiMgSxXm9snhECzKAjZ7+B4nlT4Cj60h+JUObbAmQ47hrOrunikpvpSzqq28BY0U8CQUquv5sthcolwggW9v3VNqKjuCRDzi6vS3lbUVn891TGzZIk8T59Ztapqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278859; c=relaxed/simple;
	bh=3RKhMpMoMpoERW/E0jf7hvgk9k9TjBxRCuln/UbJfVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tlYjDA2fLc9eQINnQRcMmmEliCxwLKyN+cc2JRcrdnrVdIuG7ooVPO8i6BkWEBoaI+GDBd+qoxaYn4xDnTkJmRB4cO715sPKVYRITXJjEhh9U40g40FD4wtJ1I+D+weyKX5lIZVjh6rvM/ojOD008Qjmw4xrY+K1LVw0LWHE4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zerv2uSV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wKdFbhGU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725278856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIRPmB7QbQaJVZ3PwlY1SyYg5vG2mHbfWm12wEhfRks=;
	b=zerv2uSVKfkxSnHxAHzESOiQ4YhLUWe67BZGLGOney0aXKwcxhc1ufmqO09GmuzgcoUfzH
	Q5hLBQKDECS5wZdkk7avK9THy76EkziKrEE7AKSUCvgadehCIT3vE+A07bSgOJZmLir8ys
	UsTFXqdjHShd3OTCl8dyni4TVse0gsjO3YJOI2uJkPRFPIKuVaXi1D4nGp7vxlrmaLXjig
	2CsNHRmChO96cf103oppwdAgsk+FXW+eNYrX8Q67qktDC45rUrLKpTGQsJXdMJpj0/TkA1
	B4LAYvqsEfwX1C2S+CJXt1UpKSQHCo6pMo073TgkhfDx7OHZftO4JYObVoeLWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725278856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIRPmB7QbQaJVZ3PwlY1SyYg5vG2mHbfWm12wEhfRks=;
	b=wKdFbhGU1gm/V4v/3gDUtbaVdNukhmykxqUx0ZmXDdUFRKW9Lebznb6SocAYFycdeNgjko
	nqoXnzojMs9uyuBw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH -next] printk: Use the BITS_PER_LONG macro
In-Reply-To: <20240902110903.2686082-1-ruanjinjie@huawei.com>
References: <20240902110903.2686082-1-ruanjinjie@huawei.com>
Date: Mon, 02 Sep 2024 14:13:36 +0206
Message-ID: <87y14auulz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-02, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
> variable, replace it with BITS_PER_LONG macro to make it simpler.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/printk/printk_ringbuffer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> index bd2a892deac1..7433fe477e08 100644
> --- a/kernel/printk/printk_ringbuffer.h
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -122,7 +122,7 @@ enum desc_state {
>  
>  #define _DATA_SIZE(sz_bits)	(1UL << (sz_bits))
>  #define _DESCS_COUNT(ct_bits)	(1U << (ct_bits))
> -#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
> +#define DESC_SV_BITS		BITS_PER_LONG

We should also add:

#include <linux/bits.h>

John Ogness

