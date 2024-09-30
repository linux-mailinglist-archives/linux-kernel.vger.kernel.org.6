Return-Path: <linux-kernel+bounces-344633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644EB98AC19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCB11C22B43
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AD7198E92;
	Mon, 30 Sep 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhWDIFeD"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B346197A87
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721239; cv=none; b=Y0jM/7WCaWU8Wcfylabe1Dulfcf6njT2Npn+OeoJ8pQTxOUBg9R3XQBbPlKrRfNaW1uzuUP+yI14zMrEweMvXL4IxJlempv1oavqCgK9h+Gc4oP1sopFQ5hqehn/1gIDqBqb0iMoCCkCTsaij3mjbMrHr290FH9p3mEOq/VXJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721239; c=relaxed/simple;
	bh=lnx6PpivuK/MOO4bJIt2CohbvuyaYVB0DvVkxq7lfPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6vJntxPJu38OjVYMqqlFax2NJQaKWo9B0JEHRa77bcWo/ldiezWHp1SzaSWn1gGL/2VfcVO8LfXvzHT36ygFTR6U87/EQLYm4/hE8qPWOZ2gkKzatj4FaOtQ3MCGFXG03DJU5ax7BuR0f6w7VOEU1pZiB+aSEdcGFgKwrZMOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhWDIFeD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b40c7fd8eso28955ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727721238; x=1728326038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJ4Q1k4Ki8jd2TYdBhQU7OxvV7AmfzdWuuyGNWZiVcM=;
        b=MhWDIFeDg1IzESEInZWpIiJIo2wLvtlkmk15TmHzl4lcgJIJvSydWgPYvHQ4TN4Iyd
         KvG6SFruNxW2r44+Vz32ZwYwelsL0VK8bwZW7Sg+0un9tAbZUbqTiYng0XlqBx0h9HfJ
         qsePOtE2X0EkQdsTJmm/UVCsC5Z0ncIIlHTPjlbBeQknZsPBn6IvAu9TEB7ESZCGzpxT
         mHPNl7HaNnf6UPePD7DFXAvO878jGp9dBQRA9kfIpRVr/u2bAZta2aTztXhtA87KtlTD
         ZbfJIv1sFfq6kxRbhWLyWQ2djAe2xbl67gDZwWhpA1uzZmna1TOfDuW6s7cBbvf5+K8Z
         DiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727721238; x=1728326038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ4Q1k4Ki8jd2TYdBhQU7OxvV7AmfzdWuuyGNWZiVcM=;
        b=VyWmhAzDkHAG4aMZvJYTowFYag0PjZ+OJ4vUQBoW+A4rD5Fcrhb0eS0uM7Ztb6rDNZ
         vFnCnb/AHm8T1cSuWdJ4cvZyZsPhXShtBI1W4yaFoZfUe1mS8k7GXJvPzDWudo818xN2
         l50RHrZ3nzvUjh8qwEj9UiezadEMEip3jZvGwjgsw2YZlGl8CQ+OaQcGs3uSq2YyrQYu
         Yidybyl6sNjXpCewX3Toumo0TJs74mAbLzECm0dvHtm+ydElSMXnXkRtlkq9g7ziG5AD
         zGk6LDZ93bEleR3J/GXR+GTKsAQudJuiWcw9cCZSy3BJKOgV114uFnQaLUX0k8QhMNAO
         44tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvVzL513WYXqqQ04ucd8qHUReCONSO7MR22f0us6S2tJHPGObBHUITI4Iia4nm459OADVMxOH+v7A1FyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWm+cwE9waeISRqFIVGSefwHZ8iLFlj9vHmAOC+aZ38zuQIfVK
	DHPEnTKUifsoaypo31kuQyrsfvL50N6q+GtCoVpnkWVmWXklmix5d/nojq+/mA==
X-Google-Smtp-Source: AGHT+IH/CbpVJ6J25TV+iE8ijiZTM+aXARwyXBG+wHMFey670JgVGH8BU0+r06ca6Y9Si9vJpjDSng==
X-Received: by 2002:a17:903:2441:b0:1fb:2924:5c7e with SMTP id d9443c01a7336-20bad69ebd5mr183005ad.11.1727721237580;
        Mon, 30 Sep 2024 11:33:57 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:179f:eecf:1162:3e05])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc7fsm8221963a91.1.2024.09.30.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:33:57 -0700 (PDT)
Date: Mon, 30 Sep 2024 11:33:52 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, surenb@google.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] printk: Improve memory usage logging during boot
Message-ID: <ZvrvEF5uLAP6_4RX@google.com>
References: <20240926011203.1472798-1-isaacmanjarres@google.com>
 <Zvqp5jNa7XCRfSu9@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvqp5jNa7XCRfSu9@pathway.suse.cz>

On Mon, Sep 30, 2024 at 03:38:46PM +0200, Petr Mladek wrote:
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1156,6 +1156,17 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
> >  
> >  static char setup_text_buf[PRINTKRB_RECORD_MAX] __initdata;
> >  
> > +static void print_log_buf_usage_stats(void)
> > +{
> > +	unsigned int descs_count = log_buf_len >> PRB_AVGBITS;
> > +	size_t descs_size = descs_count * sizeof(struct prb_desc);
> > +	size_t infos_size = descs_count * sizeof(struct printk_info);
> > +
> > +	pr_info("log_buf_len: %u bytes\n", log_buf_len);
> > +	pr_info("prb_descs size: %zu bytes\n", descs_size);
> > +	pr_info("printk_infos size: %zu bytes\n", infos_size);
> > +}
> 
> I would make the information more user friendly. Also a single line
> might be enough. Something like:
> 
> static void print_log_buf_usage_stats(void)
> {
> 	unsigned int descs_count = log_buf_len >> PRB_AVGBITS;
> 	size_t meta_data_size;
> 
> 	meta_data_size = descs_count *
> 		(sizeof(struct prb_desc) + sizeof(struct printk_info));
> 
> 	pr_info("log buffer data + meta data: %u + %zu = %zu bytes\n",
> 		log_buf_len, meta_data_size, log_buf_len + meta_data_size);
> }
Thanks for suggesting this! I'll do this for the 2nd version of the
patch.

> > +
> >  void __init setup_log_buf(int early)
> >  {
> >  	struct printk_info *new_infos;
> > @@ -1186,19 +1197,19 @@ void __init setup_log_buf(int early)
> >  		log_buf_add_cpu();
> >  
> >  	if (!new_log_buf_len)
> > -		return;
> > +		goto out;
> 
> The same information is printed twice when the default buffer is used.
> We should do something like:
> 
> 	if (!new_log_buf_len) {
> 		if (early)
> 			goto out;
> 		return;
> 	}
> 
Thank you for pointing this out. I'll do something very similar to this
in the 2nd version of the patch, but I'll use "!early" instead. The
rationale is that if I use just use "early", then the memory usage
stats don't get emitted at all on my machine (arm64) when it uses the
default buffer, because setup_log_buf() is called only once with
early == 0.

Using !early in the check there should fix that, and also emit the
memory stats only once on machines that invoke setup_log_buf()
multiple times and end up using the default buffer.

Thanks,
Isaac

