Return-Path: <linux-kernel+bounces-346262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DED98C202
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12ADB1C22419
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D111CB300;
	Tue,  1 Oct 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bFKd7NPQ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE861C3F01
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797737; cv=none; b=jwUxl7hYR+6zeVhnvgvey+0ChnE19Pizfp3NNZ2XNpZKQ2pwitI94tIV5x0D6Poi88KiAG0OJ+vBj3UgGNS6V7RQUlHL7ysAnXi3Z7rebroY08d5Wkl582ZEotY43YXK9QG8MRHgxdZEP1Xfn+AxMxEGCZkSEwn25ERgysKwQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797737; c=relaxed/simple;
	bh=ss4yCbbmkar5kaDMEkNctEWmQjIonRes8lVMiAbQ3Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs6KOtFlMVVsddpvX1V/rBxEuDvpW9q6QwJiknVdPT4HBfqhRhO/bbCl0tv+ZpX6ilXhnOgwkSA5P8GAfI1ppuUpvhk1CaOe4hnP2iGtePrUqCBOvp8sAGy+RYoeQEeSkJ9/M7q6hwbTILEtWToZUdBDDhl8e1nmcJpTR4wnIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bFKd7NPQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso1061176666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727797734; x=1728402534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnKqVnOlGzVf7DIKlhXVw+vfc7DgmmSbKTD4MYoSGxA=;
        b=bFKd7NPQI+/g9jWaAxRh26BffgMO3+b4brKiY6Ar8F1QJntvEEUJPzz2fgKWa3sTd/
         veGUlQ85xO/uh9fDtpbJjylf0JRlpwIncwvQJxiaxqq62WCV5rdM46ZijfV4064wg3wR
         J5IJpSh6aZF31PBlVmvmmmVYqQMwm8hXno2FWq+RK9CssMpfcjLiIt+l98ceXuihTgAS
         Bcgq66qzcbLOK+MatgyNBLwhBrsxI1NRcvIbyBfUmlUPMyB8lx6NNoMTwZcEAjvUmh/e
         0GNvXeZzjm5G+mZuaKooPbRq9KxVzCjbHPZrI4+4rCuQ0q7uM3mP6L3rUOczmOhuJMXp
         IyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797734; x=1728402534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnKqVnOlGzVf7DIKlhXVw+vfc7DgmmSbKTD4MYoSGxA=;
        b=t9gYwpwYtsPqjGbJl6NYOqhm34WdS1RcpIkqqiVeWNavHFuYC/Fm3X48Zpbg98ORjK
         fTn+cy09jM3GgcABthQD7PPFV+aSKD7D9kyzULlCQCOTTEpxMA8ihLTFH8cUdNvypANQ
         TN+32U9iY55owLqD+3Ry6pn2aucAUhajo/yZl9HmTFvGUhK6hXmIBRWdsSPKkdQzxeHV
         DVlJsCla1vqT5ktyQL1OwAjYbEyIBpTxjmR/c3N88WnHljnpp0s2OvWiktPG0EmwJsgq
         gBHA1mr5nI5Du+voVkbZLOhhBrH1INOoDampFxH/5CyTMP/6RuIGc4AwH263CWTfLJ3t
         JPnA==
X-Forwarded-Encrypted: i=1; AJvYcCWqqUgaxsTK39UuvA2TFiwVa5ZZ6YBTkP/QfOUMmGZFpd0+2/Db0MJv3X0vFNkD2ueg17Ug9psAr7Qs7jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygqu6nQK91KXyczzbaAjCsvltFz48eeCSWfy9tVbCr2qTqCH81
	x6FT5fNh1nInCmC0zNmOAZRtPa2nfnEqYCsCinO/q0SUdE+fQJUsAE22lFz1NsQ=
X-Google-Smtp-Source: AGHT+IGOSKLcYAoMFsYdkTg44m/rneBNcxQfRzRde+j6/9uVp+a/QjVJIR36//aWL6ybhQ4PV2Jo8g==
X-Received: by 2002:a17:907:6d21:b0:a8d:4cec:fcec with SMTP id a640c23a62f3a-a967c083971mr354846566b.26.1727797733929;
        Tue, 01 Oct 2024 08:48:53 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bb69sm743500766b.171.2024.10.01.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:48:53 -0700 (PDT)
Date: Tue, 1 Oct 2024 17:48:52 +0200
From: Petr Mladek <pmladek@suse.com>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, surenb@google.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] printk: Improve memory usage logging during boot
Message-ID: <ZvwZ5Ci8o0xJ8TcL@pathway.suse.cz>
References: <20240926011203.1472798-1-isaacmanjarres@google.com>
 <Zvqp5jNa7XCRfSu9@pathway.suse.cz>
 <ZvrvEF5uLAP6_4RX@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvrvEF5uLAP6_4RX@google.com>

On Mon 2024-09-30 11:33:52, Isaac Manjarres wrote:
> On Mon, Sep 30, 2024 at 03:38:46PM +0200, Petr Mladek wrote:
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -1156,6 +1156,17 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
> > > +
> > >  void __init setup_log_buf(int early)
> > >  {
> > >  	struct printk_info *new_infos;
> > > @@ -1186,19 +1197,19 @@ void __init setup_log_buf(int early)
> > >  		log_buf_add_cpu();
> > >  
> > >  	if (!new_log_buf_len)
> > > -		return;
> > > +		goto out;
> > 
> > The same information is printed twice when the default buffer is used.
> > We should do something like:
> > 
> > 	if (!new_log_buf_len) {
> > 		if (early)
> > 			goto out;
> > 		return;
> > 	}
> > 
> Thank you for pointing this out. I'll do something very similar to this
> in the 2nd version of the patch, but I'll use "!early" instead. The
> rationale is that if I use just use "early", then the memory usage
> stats don't get emitted at all on my machine (arm64) when it uses the
> default buffer, because setup_log_buf() is called only once with
> early == 0.

I see. setup_log_buf(1) is used only on x86_64. Great catch!

> Using !early in the check there should fix that, and also emit the
> memory stats only once on machines that invoke setup_log_buf()
> multiple times and end up using the default buffer.

Yup.

Best Regards,
Petr

