Return-Path: <linux-kernel+bounces-236479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BD91E2CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07985B23BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42316C852;
	Mon,  1 Jul 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KHzcdJpF"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639316C84D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845435; cv=none; b=u6oZXnwPZr2wOEsvPewO97Kyjbuh+kGldzwukT0Mm0tH4YhvvXZTOKDBr8tZj4dVzdZ4zFS1uJ9CBGyz9H2fia7oF6iFEw8LgUwgxpc6ZujbUhPQe4ugbtODD00N8QBZppVSnBFRkXcEkc5Kyhn3R2c2BBBGi5beYO274674vys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845435; c=relaxed/simple;
	bh=nPQmSRmxFkYAvEGstpdrhUEr1pwYwydjFr3ilUsw4pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVKa5idzU8DfXwdpBaz5h0E4IXv0KZ8RRq9mpougtCoFl+zIPWkHHYA8oPVgcdkiU5Vbh20csh6S7eVKw0ZLtZGzGQQZtKKNXe2sCmREXFmP4Zbwkxkpegm+bnkaB2OUY42TMDzZFurgpQW6pRhklK42/BV2HS0L+GyY8wQZlTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KHzcdJpF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec58040f39so29893281fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719845431; x=1720450231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5R4veaHrLsvPru62XryR93QLDpwVMbkjxlXAZklEG+E=;
        b=KHzcdJpFQ7avgOk/XaL+JzWHNuZG2t9zPZ9NoN71aG9+2yLFvsF6W4hNhpjNNLfDd5
         fSYwBBOrq6TcCDux1T6GKsC5mpGX/8/CVuUmcmS1TsWfKIdjvg/r721fGsw+mpU0eI4H
         2E/EIJupT9Ueo4iZdq7PSaipbGJK0FrIWnnw4XZ03yQwYxlmcMy/CRMAq4lIu5+UtWUF
         I8d3FvfmGwvikd6WVQdQORTuzf5EQ6JKa9qhcn8TvXfA9p8fGMITqGYFA2TFVH0mwk1z
         vVdue47A/vGSQP3zxXWqYqrD/7wqlIZ6ggr+AD1zaNqLLw/b0a0WKPRF5N0IKal3vvEx
         N75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719845431; x=1720450231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R4veaHrLsvPru62XryR93QLDpwVMbkjxlXAZklEG+E=;
        b=wNuGVIMj+MznypAB6eT8jX92F5YJ042wlayjOPZEqIbxPO815g2KhXIeNMgEY1Yjph
         PheEWbR60lQ+9clSREHiseRmHo1DOAgYXtIKWiwp0xOd/tg0tMXxLjnRsG42KoiHNz22
         O7/MTgNp3bVV1ACdACYOKpRqZEeWj0Wa1juMiAqJZ5AHgznsDEFcV0g6yjFm8QwTTWq+
         5kEmj5/xVkIwzxDly+G1qdlibkfPgrE3n19dtOjb5VYebS+DH7iH7uOpYqpGW57ZrhUw
         iNUTlGJMjTLBEUTsVk3XKyFB49r91cv4GzU5MlLuP+onBBSwQ+gyo6MqVJTA9dEPmXwU
         WkXw==
X-Forwarded-Encrypted: i=1; AJvYcCVo5WALdRA2w+FyTst5Dlj3Jl9ilnyyRGFDDEza1oYFqIs91oW3RkIHbVLN9GaPi98QPFMDeI0eLLN6js8S49K8amfHY+pCYO3TpK5F
X-Gm-Message-State: AOJu0YzA29LoroZ2InVYJzCav4NZ/Pb45m2ewtruff0QFnNoYJeBF8E0
	kqFbIitbtuxsHiqVkY0TbzKEKZCRDEt1YD6SsNY3kwXBVf2g7OyveWHXrDAcBtI=
X-Google-Smtp-Source: AGHT+IHwkxVgbDOc2mGtkSQedZ9W7zvlkiig3t1b8tLqhN02hzaaH8nczeygbiuw3+GjYgY4xXCHgA==
X-Received: by 2002:a2e:a984:0:b0:2ec:53ad:464 with SMTP id 38308e7fff4ca-2ee5e6cd723mr47832101fa.34.1719845430983;
        Mon, 01 Jul 2024 07:50:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3b9f2csm6839982a91.35.2024.07.01.07.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:50:30 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:50:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 12/18] printk: Add kthread for all legacy
 consoles
Message-ID: <ZoLCLfcIjQ6FbgR0@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-13-john.ogness@linutronix.de>
 <Zn6iq3n2ggL138Gs@pathway.suse.cz>
 <87cyo1xnmw.fsf@jogness.linutronix.de>
 <Zn67hDCEHdgtYPv3@pathway.suse.cz>
 <877ce9xim6.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ce9xim6.fsf@jogness.linutronix.de>

On Fri 2024-06-28 16:17:13, John Ogness wrote:
> On 2024-06-28, Petr Mladek <pmladek@suse.com> wrote:
> > On Fri 2024-06-28 14:28:47, John Ogness wrote:
> >> On 2024-06-28, Petr Mladek <pmladek@suse.com> wrote:
> >> >> @@ -1494,7 +1508,9 @@ void nbcon_cpu_emergency_exit(void)
> >> >>  		 * to handle it.
> >> >>  		 */
> >> >>  		do_trigger_flush = true;
> >> >> -		if (printing_via_unlock && !is_printk_deferred()) {
> >> >> +		if (!force_printkthreads() &&
> >> >
> >> > Is this correct? We still need to flush the messages directly
> >> > when the legacy kthread is not ready yet.
> >> 
> >> No! If force_printkthreads() is set, messages will never flush directly
> >> except for console_flush_on_panic().
> >
> > But this is an _emergency_ context! This would be inconsistent with
> > the nbcon consoles where the messages are flushed directly.
> >
> > Is RT sheduling quaranteed when the system reached emergency state?
> 
> No.
> 
> > In fact, we probably should not check force_printkthreads() here at
> > all. It would be only for NBCON_PRIO_NORMAL context.
> 
> On PREEMPT_RT, legacy consoles are not allowed to print from
> non-preemptible contexts because they use spinlocks (rtmutexes).

Ah, I see.

> This is a disadvantage for legacy consoles on PREEMPT_RT. If people want
> a legacy console to gain the reliability attribute on PREEMPT_RT, then
> that console _must_ be converted to nbcon.

Makes sense.

Thanks a lot for explanation.

Best Regards,
Petr

