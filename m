Return-Path: <linux-kernel+bounces-415950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B1D9D3E71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D231F245E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA31BDA8A;
	Wed, 20 Nov 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V22efuLh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229F1C1F11
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114466; cv=none; b=dIRBKx9b0+8ciiQ/cktX/pdTx9L7u9UJ9kOYM3VWys1xkAjdeK43oBmUp+TWUbm4c0RfOOazzn/X0UiJCJSLx5JZeRJq+6VdAFNBhx+1Zm0c9hirvHF5UcwPAreZ4OxO3mVGABqQLyxed03bHI6XlXD+zalIv6Zcn9T/j7TRNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114466; c=relaxed/simple;
	bh=+IBp4/mjnKTPpeerE1KBjykMT3Q8waxXevFTUgQU2VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9zVD8jYh8wCpgzoRBfwb1TKmPydJFPtUim95RWgS0RVBETgl0TTHSLLhRpCwtArT91vZm7tfh7TZ5fxLRPTk6PXOmQPbuvhsjDynH0hVraaq67LFKo/hT7FzWnWy8u62sCqeYukSuSQmFXZxa/TniWQepd7BbMsbrt/YsmJe9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V22efuLh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314f38d274so59952155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732114461; x=1732719261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3X8EvBZcglG3G3y/PY+m6JzHpXCgEpZdkFsrUAh0Gw=;
        b=V22efuLhPG3sFIO0v058/LtfM7Cou7yQt9laG8hJu9ElHJl8hwEf4ifxzF0mwGQSM5
         +Ar4owwheei3LOEVtIYlgL7kUC4h+DohbwGJYRKMSKHAzuAI4aK5Tlm1awmGjnACXwod
         pt7YtBNC32/2rSaMpsQ3o7AiyztsMhvcQ07lMHq5wvp7eDu1L73doV3Jn4z5UMFdcPcr
         me2vWs230iQo9ieEE0iu/1/SVVWegGvtolVxkUC4C/8afNaMnlINXax1+N4qEDfowQH3
         gViiBDd/p0eKdiclUwJNdf/P5shHrO0Xl0lodsFN+pcckQrcjiIQks1XnavZZLtcp9Kr
         cSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114461; x=1732719261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3X8EvBZcglG3G3y/PY+m6JzHpXCgEpZdkFsrUAh0Gw=;
        b=j37lgeMnydvfCP1dxOu8tDLuXI5xEspW3vfbCogvz+VHQNzw9Hotmwp62CHLhxpTF0
         0GyroMdN21HZ0WwIihQu08oJmSlE176r1XDQoNiRsfV3XiKzcWwWtcmdlyurztuqJoNV
         QdFQxkkVuDujL1Or7ChPWfKBNMLATK4liCWq5JuONGZkEd05NkEn/q6g5H4Ul2uAYhB7
         I7L3dBEzcRNTEIFacTf/YybsB7N9pzYXH0hmz4PX45acFsY9LrKQ8mdQYvDV2bVrxPYT
         1cEwEpMLulycV2+SQ1QZ6SQljHePrBC5bqurC0zvmbkpqwP0RIWNZSIZWUhvPZXKmIKb
         UNhg==
X-Forwarded-Encrypted: i=1; AJvYcCVQEJyrlCLv2IC8YNGNLaKaBC46cry9STn2u8tYDOcrDkCn3YZRIlJjdiCJhU6Xc6poob5jNssYluuwGTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VCNrNooMSjbd9+FtTi//Gmcj46oEkUIUMi1EriNYTENQbMrL
	Ly1QQNPQruZU7g/MgDCDkLCrSjPPjwLrHwAvaMzF3jjCTroe84dM0xxQRT3GB5U=
X-Google-Smtp-Source: AGHT+IFi1TKB6lZ7v+YT4VtiSV0LnHSOQ/6l8OmuJTtWBoIuIMfezbIIQdy8YVWrFvr/BbOc/zL94Q==
X-Received: by 2002:a05:600c:1394:b0:431:5533:8f0d with SMTP id 5b1f17b1804b1-4334f01d780mr35116405e9.30.1732114461062;
        Wed, 20 Nov 2024 06:54:21 -0800 (PST)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490c850sm2267700f8f.35.2024.11.20.06.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:54:20 -0800 (PST)
Date: Wed, 20 Nov 2024 15:54:18 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Chris Down <chris@chrisdown.name>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 06/11] printk: console: Introduce sysfs interface for
 per-console loglevels
Message-ID: <Zz34GgmFbuZKQOzG@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>
 <2024111508-native-subtype-2990@gregkh>
 <Zz1tOxW6PO_2OeSA@chrisdown.name>
 <84frnms3c3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84frnms3c3.fsf@jogness.linutronix.de>

On Wed 2024-11-20 09:49:08, John Ogness wrote:
> On 2024-11-20, Chris Down <chris@chrisdown.name> wrote:
> >>> +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
> >>> +			     char *buf)
> >>> +{
> >>> +	struct console *con = dev_get_drvdata(dev);
> >>> +
> >>> +	return sysfs_emit(buf, "%d\n", READ_ONCE(con->level));
> >>
> >>While I admire the use of READ_ONCE() properly, it really doesn't matter
> >>for sysfs as it could change right afterwards and no one cares.  So no
> >>need for that here, right?
> >
> > From my reading of the code it looks like we need this to avoid
> > tearing.
> 
> I cannot imagine that any compiler would perform multiple reads to read
> an aligned field of 4-bytes. Particularly since this function only reads
> this one field.

I believe that the chance is very very small. But are you 100% sure, please?

Honestly, it seems that everyone agrees that the READ_ONCE() makes
some sense. I do not understand why some many people wants to remove
it. I personally prefer to be on the safe side.

> At most it is kind of annotating lockless access to con->level. But
> since it is not using data_race(), it would still trigger KCSAN with a
> warning. I recommend removing it.

I actually suggested to make a wrapper similar to
console_srcu_read_flags() and use the data_race() there, see
https://lore.kernel.org/r/Zy4368zf-sJyyzja@pathway.suse.cz

Best Regards,
Petr

