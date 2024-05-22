Return-Path: <linux-kernel+bounces-186421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9D8CC3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD18282052
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937887D071;
	Wed, 22 May 2024 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O5agnHKn"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B012B9C3
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391098; cv=none; b=KPvxcs6W/yA4sBinr+F+tMHhyPnaSyfKD3ZaPilnw419rInYVc5uzfSUvxm5rq8bXaFcoTGRm4+qkq4B9Sm9z7kvbE9Q+hkyN3Tds5g+/hgIX8WkBfFR9sfl/4vrzG6aNAAJduYm2vPokcYqYBeisbBzWpQDMg0lWsUkW2nyv34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391098; c=relaxed/simple;
	bh=sYIrj0Iso+GkGLJvhkjsCdF5mUygCRp/pk2z46+PRps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nadJnM7WKMuBfjVTeinaOXqruFH8rQtvpxr3R1r1zpdI+3p+HrcNMYQtlX93inOm8OW7OPPrgY3pQ8wXzLPOFAdMjcwFU8ts2uSqmP7opGwIqKTCFyt4hCZlA0FY1rKEVXQGupofudFNuaWnmoJ/8TGKiUn7cXQY0IhzbMTo6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O5agnHKn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so8323887a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716391095; x=1716995895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VaHGLRs/J+Fd8zTYkJgbyVxa4bOKjtKO0wVzh6qgxg=;
        b=O5agnHKn6hK6uZz19BkSlwfKfZF/bIBLNaxr9/rZSo3TimocCvdv2jd/A22G9gotqU
         xOxscx4ry2cv57rz7lAwTy80hcRH+J1fDHzvME/d9Ou7ZvSAXU3rxWA9X+35LHg7Zz87
         pszvcsErJy/gdYhexy6WF2z8CJC8A833Y+0zXYEFSXs31UHMy0z8vL5rWiOx+PZIauM2
         zEkkijD9zzLgXf+M8lohCBGAkS+j3iz0mjxCAOIUkWA4SUCkxUxBJViasHYMY0UKOeGr
         J92K0nTT8TCMq77igMot+zOPlc4BHVuwg6+V5BZYVdrH8VP/k/xscQcz1p0iY9ygbHmc
         J/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716391095; x=1716995895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VaHGLRs/J+Fd8zTYkJgbyVxa4bOKjtKO0wVzh6qgxg=;
        b=ObBe+6Jyd7xCdaWX4ZNaedWn7/t7RpYkK0QLku9NBDt7vcYmGYMKFYEJ9A+L4QAVNm
         divUAC/dqPC39lB20F43RlsAJz+fhQVIynqQOWehOBdo7M9WgZ7G0VS4gkpHR8SSI3+j
         vkw+/KB3NKL5aqW0mRcTyLfgVMRCgM9T64VXvExs0Za6yUeJ8fD2j+A0quGot2moAU5F
         jH4rhFnIdrAk2pqEaOoYGmqf4kIL3ezehWMxonRVg/0YqvFqoDuodx0j3D0PqwD7jHnQ
         WY0HdmHrrO72IVvowa6ey/VGSlTOIz2jUx0bomQnf1/sYshux3ClS+ZbvLhBVQBSUljO
         ru5g==
X-Forwarded-Encrypted: i=1; AJvYcCV7ut2CQ8PD4aAmyVAz3TWf5o+MWNmUMB+pscJ96D8nWpppeqfu+JxP0Gil1+RjmeGuG4nLJBrIeFGAh42lhRXbW/z9HUcKA01bBWO8
X-Gm-Message-State: AOJu0YwkO8LqRAiJMNZLwa1UXG5+7RvSdKMB58/34g92OSjVWbHIypMV
	yRvZMUqGYIBAddEnhMBuEYqcEDVrgzqbFcnNe92NUR07guzNMIbbBuQDDYWzsVM=
X-Google-Smtp-Source: AGHT+IGhVrh0vkrvTvfbs3er6vrivFWDI/IQXfXpBK+NV3F9Nmm1m/IafyZ6ElTvE9ivt0/9AaegMg==
X-Received: by 2002:a17:906:cc12:b0:a61:42ce:bbe4 with SMTP id a640c23a62f3a-a62280d6253mr228842666b.27.1716391095199;
        Wed, 22 May 2024 08:18:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm1789227566b.31.2024.05.22.08.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:18:14 -0700 (PDT)
Date: Wed, 22 May 2024 17:18:13 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
	anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v6 1/2] printk: Add function to replay kernel log on
 consoles
Message-ID: <Zk4MtXxbzGrQhSFA@pathway.suse.cz>
References: <cover.1710220326.git.sreenath.vijayan@sony.com>
 <90ee131c643a5033d117b556c0792de65129d4c3.1710220326.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ee131c643a5033d117b556c0792de65129d4c3.1710220326.git.sreenath.vijayan@sony.com>


On Wed 2024-03-13 15:50:52, Sreenath Vijayan wrote:
> Add a generic function console_replay_all() for replaying
> the kernel log on consoles, in any context. It would allow
> viewing the logs on an unresponsive terminal via sysrq.
> 
> Reuse the existing code from console_flush_on_panic() for
> resetting the sequence numbers, by introducing a new helper
> function __console_rewind_all(). It is safe to be called
> under console_lock().
> 
> Try to acquire lock on the console subsystem without waiting.
> If successful, reset the sequence number to oldest available
> record on all consoles and call console_unlock() which will
> automatically flush the messages to the consoles.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -4259,6 +4271,23 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
>  }
>  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>  
> +/**
> + * console_replay_all - replay kernel log on consoles

It should rather be called "console_try_replay_all()" to make it clear
that it is just the best effort.

> + *
> + * Try to obtain lock on console subsystem and replay all
> + * available records in printk buffer on the consoles.
> + * Does nothing if lock is not obtained.
> + *
> + * Context: Any context.

This should be:

 * Context: Any, except for NMI

Basically only lockless code is safe in NMI which is not the case here.

> + */
> +void console_replay_all(void)
> +{
> +	if (console_trylock()) {
> +		__console_rewind_all();
> +		/* Consoles are flushed as part of console_unlock(). */
> +		console_unlock();
> +	}
> +}
>  #endif

Otherwise, it looks good. With the two changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I am sorry for the late review. I have been snowed under tasks.
Also I had healthy problems.

I have seen a mail that Greg has queued the patch in tty-next.
I am not sure if it still can be fixed. It will be perfectly fine
to change this by a followup patch.

Best Regards,
Petr

