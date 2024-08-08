Return-Path: <linux-kernel+bounces-279958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E694C3DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443A81F2215D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187801917D9;
	Thu,  8 Aug 2024 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4jJ96iz"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085891917C4;
	Thu,  8 Aug 2024 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138978; cv=none; b=L0Q1rJcPQWPKf9AhB5ygMWdJyyc/zyppFL+VR/K6JysOZZYxNQmYzaA7yG14ca4apBA4PmCjjwyq2rmUfTVPazUZRfdOMWFjytBt5pRd8eE6p2xDvtizOXEtCL5PLCuxEZp+qN+5fcbZ7vDEZlY4m9H+/L1RBJ2bRL0uFP6PiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138978; c=relaxed/simple;
	bh=/x/GCpUGs1ftk2R59xqPZXhiosBrNlEUyHkv9BnhTVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1xMnD0WkjRGjUX/JsTsYZvN5WOf7Ew+XkoB4zfLTJKO/6C6jf4pBeLxUmh4ZXgrB0Wj80NUOHf/AQ27I8vTMKPw4NQ6tXsM7p3dCLbKhf7qeZsP/Gy31VeA/UtxBdPE+G8NsWU6PRWb22Lr1wiapiPt8+Yyxm1cb/H2ouzf/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4jJ96iz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6bce380eb96so791167a12.0;
        Thu, 08 Aug 2024 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138976; x=1723743776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgUjbjxEgBMHqGe4yMa1OEWmwGmO34nRyalLE55xTRc=;
        b=M4jJ96izykUnQCiIDefFVZKZxOyBBpo/8ry+Mt1xuu7Fz2UkqDg77V7gNAFbsJ93wf
         RwA+sG8NL+MdwcvGQMxy4bl8CwoOpP35seQ2IaNEa/976PW2GXqShlzHYhb33LURJF5m
         ztjeNUUksk2Qjx3lQ3mHXmDkObfovx3m6sAXeO+nOx8+mS6EJSR/yOyjusw41AUyNXPW
         VHm6XIumLCvgDz1HqBuqgmlsVNFhsM55efP8imhZ4I5uDKa8ZSCNk7ZWgyhRNDTo9X2r
         24/XhTZItl9SP8RL77Ul+U8Axsrn25Vu2QyW1hTk0ARlEa/ZJYyqj7FluiGzUpUN83UE
         EumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138976; x=1723743776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgUjbjxEgBMHqGe4yMa1OEWmwGmO34nRyalLE55xTRc=;
        b=S63aHQH1fE2fOJ9TavAQY0VBlGnkIKnEkZ5IfcipnAYhoobnYetDWp31pARk195M8S
         UY6ixwSghqZqnWYzNkeLv9j8mGw7QyeDX+m3FSKGSYv6l77MIGU7IgVMA3dPEHv02OKI
         u5w8qPq76hi/pwNIw/H2zhkXBRE6PGyZ/CVh0Gud+OB+GAzwjP1XenQtgc9QQLI2ZnCN
         R8T31GW2J534gtNT2HzmA/0W7Jgs0J2Z+WZKa4xSSpi5VdFhAdjDesXAKMc2Cu8mkcve
         avATJS3PevuQeDMbh0lmR9rewRrYwM/O3MXX026M1BD/cdVxiRGmOritcZ5vomH61LKh
         IT4A==
X-Forwarded-Encrypted: i=1; AJvYcCXo5REsG2R4nrhpW3tdB1D/QEjAgTWizIEcfSnLEUThddL1GHRfkwn8iN5D8+rklBPulQRH7QnXcIzHEOLTs8BscFjasMyqYZ3zZFHfVBkCWOBCIzoFcJhG6Q4bf1ozidMaqE/gz+zFb2k=
X-Gm-Message-State: AOJu0YzYFVTT8J6qTQTnZYgdNQa5nYs/Llc/pC0C9AqWtud92wDZyjhz
	+eOCUMYoibDpETg+BDvpmASOGXJcFfxSGyCIWyFbWd2GIHMIrPvb
X-Google-Smtp-Source: AGHT+IE2Whix2iRuRVCvGmEQbKjesFBkdadz1VWz5QmdV/xueZHYDCKRwPjKk1N5gUmnCly+nVWONQ==
X-Received: by 2002:a05:6a20:a107:b0:1c6:a65f:299 with SMTP id adf61e73a8af0-1c6fcedf133mr3313532637.21.1723138976056;
        Thu, 08 Aug 2024 10:42:56 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([110.225.178.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2e7405sm1366964b3a.169.2024.08.08.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:55 -0700 (PDT)
Date: Thu, 8 Aug 2024 23:11:01 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (lm93) Return error values on read failure
Message-ID: <ZrUDLVhjH8uKflCN@embed-PC.myguest.virtualbox.org>
References: <20240807181746.508972-1-abhishektamboli9@gmail.com>
 <bdca4f35-ec3e-4fac-bbcf-ed5326feb6f4@roeck-us.net>
 <ZrQqhOvt3zCHNh38@embed-PC.myguest.virtualbox.org>
 <e03f91c4-c25a-4c9f-a0f4-2774f4019f54@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e03f91c4-c25a-4c9f-a0f4-2774f4019f54@roeck-us.net>

On Thu, Aug 08, 2024 at 09:54:40AM -0700, Guenter Roeck wrote:
> On Thu, Aug 08, 2024 at 07:46:36AM +0530, Abhishek Tamboli wrote:
> > On Wed, Aug 07, 2024 at 11:38:34AM -0700, Guenter Roeck wrote:
> > Hi Guenter,
> > Thank you for your feedback.
> > > On 8/7/24 11:17, Abhishek Tamboli wrote:
> > > > Fix the issue of lm93_read_byte() and lm93_read_word() return 0 on
> > > > read failure after retries, which could be confused with valid data.
> > > > 
> > > > Address the TODO: what to return in case of error?
> > > > 
> > > > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > > > ---
> > > >   drivers/hwmon/lm93.c | 10 ++++++----
> > > >   1 file changed, 6 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> > > > index be4853fad80f..b76f3c1c6297 100644
> > > > --- a/drivers/hwmon/lm93.c
> > > > +++ b/drivers/hwmon/lm93.c
> > > > @@ -798,6 +798,7 @@ static unsigned LM93_ALARMS_FROM_REG(struct block1_t b1)
> > > >   static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
> > > 
> > > This is still returning an u8.
> > My interpretation of the TODO was to address the error condition while keeping the 
> > existing logic of the driver intact. I understand that this driver is 
> > old and that changes should be approached with caution.
> 
> Those TODOs are, at this point, pretty much pointless. If you want to help
> with improving kernel code, it might be better to pick something from the
> drivers/staging/ directory and help improve it.
> 
> The only thing that would really help for the lm93 driver would be a
> complete overhaul, and that would only make sense if someone has real
> hardware to test the resulting code; the driver is too complex to just
> rely on unit tests. For example, the excessive retries might be because
> the chip is really bad with its communication, or it may have been
> observed on a system with a bad i2c controller, making it completely
> unnecesssary today. Either case, if those retries are really necessary
> due to chip issues, they should be hiddden behind regmap (which should
> also be used to replace in-driver caching). And so on.
> 
> Really, if you want to get into kenrel development, it would be much
> better to help improving code which is actually being used, as mentioned
> above.

Hi Guenter,
Thank you for the feedback. I'll look into the drivers/staging directory
and see where I might be able to contribute effectively.

Regards,
Abhishek

