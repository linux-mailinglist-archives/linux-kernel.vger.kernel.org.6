Return-Path: <linux-kernel+bounces-399903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A31BA9C0611
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F471F24112
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59920FA9A;
	Thu,  7 Nov 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg3mTxD6"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0A20FA88
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983359; cv=none; b=PzrRZRWf/FUC/RUUXsSJTFGfXRHDzDbMKOdz+7a7tE4exUizh9oypf+5et7c/pbblgwucJlgirqre6h0U8lIOXi/cYbkpLSB1VvO7VGTyS3n+LwJddSa3feMoDALrCdj1XJZmI0skEjd+Opoef6tqdUaW7+PwN9Q43OTtWf4/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983359; c=relaxed/simple;
	bh=tZWPZIBFNyJAub/jDcRLdT8aGLksimO3f48XR26/or4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9+vLAo8V3s02Voa4w47C1aXucD4weKH1vNIrPkUrQqsjhIC6Ix7VMeYXPGZ6/SpZkIzRTsOxFyfjTcMctLpQ62T/QhuLeaEjwGAFqabZzisSGzOjOIJ7eEEC/X2ublWc+wD1fXSyDlSlcM1vJhaaWGe3gh1Qep4MqQgkWYqffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg3mTxD6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso685025a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730983358; x=1731588158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6XukK893HP9+ptbCvVbs++K6tcY7RyjJVyyz2/LIxnM=;
        b=eg3mTxD64NY6GQZs1jqHoOp29WLmjXxY4vZ2mhkfSUJ9bWiqSsJkeXV7BACgP8Ks0y
         Z+SEyrLqi4CuRwU17NiZk9yR7P4tQmVEHhiBWP2qokVnyfERDAJX23BeDHIYPtwceX7R
         s7VCWwTSb7NQWiZs37fDgaVYNMTmOtwHYxMh9+uSvXu9oy/Z6BDUv4IHqf+T8lrQxfpn
         uGUKhxwIslz/BEQQ0tb7mgDKEYI55Kj5qFeIX4EI6xTNZGOFQyazpQ4lfQa+URha865F
         lqNrnv+YryUQHB7ZDrg6OuTKNJIj9Mwj+I9kSzTtvjgP1MMXOcK/muI65COTjs1hjdcw
         +bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983358; x=1731588158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XukK893HP9+ptbCvVbs++K6tcY7RyjJVyyz2/LIxnM=;
        b=UMyDyUkrYEH5Qnns4glSiR1+cvpEaYtbOe4lNSbydx22UYCiCvlDJTGJ7j4lCkD9oT
         kr8YhQgEF3UoWVwXOQI34+Qd+0n/BlzJcSpYJnxfj3HzrOVaJlZhg2x19aAPdnTIMiWc
         3nfjhVApV+maM/GPE03dqRwmqzK86qTK7N8WYc76OTpCEFxHQju+JlALBFHNoJfC7IEZ
         Zana+cMwMBCbZHDIW8acd6z/X2AHBGl8eWOSIbkFCVJQY4skIj7pZZ+kesEdL1Wo113g
         IN+H/SoJ7a1xUi4fB0M1EA3WoJcDjMkjXNekA8pK4WAeXKIHXWAS+TgUImCsfqQo1ttX
         2HZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC2fb2d9buL+holf9irlqO6zEdM/FklXOyyKWq6XquIIj/HYtYAu9mHdhaW8Eg49LHMgyKEevzYOaNKto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdw7qVr+iCVaXBMPsH9HpprPBTNFVHrxSwAcmXYf/Iwrt/XpP
	5XSME09PRqNAgi8P1LrcyNSJD4+/hRuH++pSK+9JBpNc8LFsfB4N
X-Google-Smtp-Source: AGHT+IGNTAtUBXhypqIJjmPnOugt5P3/iXjjduB5Y7dldZIsMfeNybeLcTMA+JOJr1R99VJJrn96Ng==
X-Received: by 2002:a17:902:cf07:b0:20e:df57:db50 with SMTP id d9443c01a7336-21175b193afmr51468405ad.18.1730983357619;
        Thu, 07 Nov 2024 04:42:37 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5e7350sm1299710a12.44.2024.11.07.04.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:42:37 -0800 (PST)
Date: Thu, 7 Nov 2024 20:42:33 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Fix signed integer overflow when defining
 LOG_BUF_LEN_MAX
Message-ID: <Zyy1ufS/n8JxhagZ@visitorckw-System-Product-Name>
References: <20240928113608.1438087-1-visitorckw@gmail.com>
 <Zvvch303oFPCZnJ-@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvvch303oFPCZnJ-@pathway.suse.cz>

On Tue, Oct 01, 2024 at 01:27:03PM +0200, Petr Mladek wrote:
> On Sat 2024-09-28 19:36:08, Kuan-Wei Chiu wrote:
> > Shifting 1 << 31 on a 32-bit int causes signed integer overflow, which
> > leads to undefined behavior. To prevent this, cast 1 to u32 before
> > performing the shift, ensuring well-defined behavior.
> > 
> > This change explicitly avoids any potential overflow by ensuring that
> > the shift occurs on an unsigned 32-bit integer.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Looks good to me.
> 
> Acked-by: Petr Mladek <pmladek@suse.com>
>
It has been over a month since I submitted this patch, and with only
1-2 weeks left until the next merge window opens, I still haven't seen
it included in linux-next. I'd like to check on the current status of
this patch.

Regards,
Kuan-Wei

