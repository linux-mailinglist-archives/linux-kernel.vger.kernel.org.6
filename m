Return-Path: <linux-kernel+bounces-202115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDBF8FC7F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A931C23AF8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7D8191471;
	Wed,  5 Jun 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jThfrU1f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A6218FDB0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579948; cv=none; b=TzCLwZrtCa5XSSxSmDQA56CDPQrNjvEOuft4qvFl6Y9ajDSVc/2mGBPsVVGSdTKJ/8s5NA6DzsHx6Yp+C/1Q8OCJCXtVCPtKHGKI670oMtn8PAHTjgNsjW1ICZP/MKSS3tpaGvbukGufBd3lc0dFP9qoMUvq0KvrtVMrSiFu7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579948; c=relaxed/simple;
	bh=A/gOzPUwckRQSfrNHNR843u/F/x3yV4eQiL9bWvwnB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1a96zF0M9QYxLefNwFVzlbkfAX9upL13ycjbGWhLhoMJCE7TUnTS+q4hNAkN+BEMVZhX3craOSl+fnSDz+78NZ5TUjnAHUPCvKeKtHZt50R1Sd26vOdOZZhXkcRHBA2Ww0raZe5TXqApMs+UAVAODQmGvdWG6t7XIwto3e0VY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jThfrU1f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717579945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EIHWoHv/QvLBTsW9LF2D/X7toxaXXwp5mTAPZT4vSL4=;
	b=jThfrU1fUmKUCq+aasAAt+/WKpb24lhdanEP4K5zA5y+GFMBG9GlW1n1VivC578D9yFlEt
	kE5dyBKYu8NibNmyV8ot+mBXqf0fIsbg9uTLBJw+zekuyNISmBQBhx2iidFGwm4yb65QBW
	ee20ih2xHkNygHhymOKuHAIR8TNSHtU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-2qNonAO3N--pz8xTvsN-BQ-1; Wed, 05 Jun 2024 05:32:21 -0400
X-MC-Unique: 2qNonAO3N--pz8xTvsN-BQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ae19130518so23337156d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579941; x=1718184741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIHWoHv/QvLBTsW9LF2D/X7toxaXXwp5mTAPZT4vSL4=;
        b=n7fXcPaqoK9koaVUlAN42KEb9GZ6xpDzfGgY6z827sE/LvsLJFt5XPImDUDGslPd0k
         Uknj/BETPgEVhiRT+tZ5tcCc81AAvd0jaRnIbInTJTtAddK+36swEBTC/O9V8XdaBWkl
         XrPhB+gVlTu0qrdETi3t8f/b4P32FoUFbUn+KBRrpWRu8xKHs1LHgo/PWx97IjX5wXV6
         8bJ81D3Q97rHz9Zk2htiseuuCgJzSGMERokbYUj+0XhMA1N6kw5vUvCEESEyhdW+DvxV
         BjzSXk4h/e0Q5GwMbibQeR2oqaIpr585euNGKHKXbklnffkeRW9p3GPRh7HH9HJPKZZr
         xcIA==
X-Forwarded-Encrypted: i=1; AJvYcCVGHR5KT57TqIm1W3dqYYujh3bZpsL4trpZK87rNJ8aevJ3GIzbo5yhDqlkYQ3LXMdlaxgNvn0CP80RSxYa7wi2guWEBPOZBtKPVgE0
X-Gm-Message-State: AOJu0YwoBHLxsj8wWSelS2djSJXC5vPNrK2pTer9Gjel3ynNPl3n+gc6
	Bg3KlGWnctrQ0+DZ/8UMVj/hLqSU0cA8rT4APY2kJKA1GzLKNDo/ZDJHR8jt4p/J9MSJvbTGBU1
	9LB6CI4q21IsCZM0qzIF5Jh5adFUJtmzyVWnhTEiWrBKenN+5vDcHvyH3eMOxYg==
X-Received: by 2002:a05:6214:3a89:b0:6af:2676:1a67 with SMTP id 6a1803df08f44-6b02bf749b2mr20745146d6.28.1717579941394;
        Wed, 05 Jun 2024 02:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5ikW1FE7KKc1M+K4oFqEtBv+CXhwGrhdL4tT32ka2r1ldJIrtTLooEIM1RfE/m26z2wnCxA==
X-Received: by 2002:a05:6214:3a89:b0:6af:2676:1a67 with SMTP id 6a1803df08f44-6b02bf749b2mr20744926d6.28.1717579941039;
        Wed, 05 Jun 2024 02:32:21 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.3.168])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b405e14sm46658136d6.80.2024.06.05.02.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:32:20 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:32:15 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sreenath Vijayan <sreenath.vijayan@sony.com>,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>,
	linux-doc@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH printk v2 00/18] add threaded printing + the rest
Message-ID: <ZmAwn3pc5wpyA8fm@jlelli-thinkpadt14gen4.remote.csb>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos>
 <875xunx13r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xunx13r.fsf@jogness.linutronix.de>

On 05/06/24 10:15, John Ogness wrote:

...

> Yes, that probably is a good candidate for emergency mode.
> 
> However, your report is also identifying a real issue:
> nbcon_cpu_emergency_flush() was implemented to be callable from
> non-emergency contexts (in which case it should do nothing). However, in
> order to check if it is an emergency context, migration needs to be
> disabled.

I see.

> Perhaps the below change can be made for v2 of this series?

Yes, this seems to cure it.

Thanks for the super quick reply and patch!

Best,
Juri

> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 4b9645e7ed70..eeaf8465f492 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1581,8 +1581,19 @@ void nbcon_cpu_emergency_exit(void)
>   */
>  void nbcon_cpu_emergency_flush(void)
>  {
> +	bool is_emergency;
> +
> +	/*
> +	 * If the current context is not an emergency context, preemption
> +	 * might be enabled. To be sure, disable preemption when checking
> +	 * if this is an emergency context.
> +	 */
> +	preempt_disable();
> +	is_emergency = (*nbcon_get_cpu_emergency_nesting() != 0);
> +	preempt_enable();
> +
>  	/* The explicit flush is needed only in the emergency context. */
> -	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
> +	if (!is_emergency)
>  		return;
>  
>  	nbcon_atomic_flush_pending();
> 


