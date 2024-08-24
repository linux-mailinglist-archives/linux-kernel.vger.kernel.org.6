Return-Path: <linux-kernel+bounces-300129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA395DF21
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E661C20E01
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1194E3FB3B;
	Sat, 24 Aug 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBfyNLeh"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D6558BC
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724518798; cv=none; b=GdNphH7kcR+jwBAyGfxJSY/bzz2tGfByHo5bwlXerYW83vlRkASIdh/VaeFx0dAp0+xgsbafR9eIC7FoXC8QBJVE2SbF9cxJYLYA3fEV90gbJ3tW12s/J1RpTMXo8trpmkHNO5bhrt4k9ehALyLismof/hXhqe/CqSj0DtjC+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724518798; c=relaxed/simple;
	bh=lXeQCgFqCwc9junnPX+UHRGX8JYyp8g9h937WdAwc4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6MJl/3MAN0CMUOE8cizbwJeW0D8cZGNpvia/Ny+Au7Gk//fJkU6287U0kXVjADrl5haZkedT5f+c8vljaBF51ytBvzXUsoS7vWyTXopH6/XYqNg7Ne1jzVURXL7nxoXQqJt5Nnc7UlcRX0KCc/QhtlyPK7a+OXnUdSviQUyF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBfyNLeh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021a99af5eso27393045ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724518796; x=1725123596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuHiveji2iGcXAoGZFjQjnvmuv4HXmCovzfcy4zrYNw=;
        b=fBfyNLehaakrXLrZ79ia/iBjazaNg2RE2UazklB+iCHf/a3KeR3+9Nvu76WuPWnnSV
         SK0YIRCYE0Z58YdHX9XzX4kAXwXGQAhMaO0YGO7OQ/so3e155XwZNOOEF+fORrHQCuWS
         617QjFu9RTMO2gtY2pLiuon8HXMu8u7AU2czx8bOUoHoaEkXT1z7z31Ic9WYhs1ygIvn
         9FcMyH6fYO6NbMUEXEPEqiykfBcOX3XmEpNzzo03I6u4LrR50eV8EomPgGKEvkBwIuTx
         Wgkm2Fxsc8wRo6ZkDhaO51EwRzHDTGjGU9IDl50F6wmaJIz86rUdeXxNfD8RtN5fuRB1
         ZwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724518796; x=1725123596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuHiveji2iGcXAoGZFjQjnvmuv4HXmCovzfcy4zrYNw=;
        b=lqA8fFraj+WibTMtUleULIF0kXLdnhG5gGZ0i/N5tUZnU9WoNRPMkSFTpeB5G3GBw4
         BEsrMcffTPvhR1Hx+XbFchrb2EqiOcbgPKbqm9mraLaHaFo9pRV+DnNYOapbUlz/RCiX
         k2TfB7UOcp1IqsbGBHB36rI1fRBIrJ9vTyuMLkbKCRgaja/PbDRXooaYbai2IrWE8ifo
         Y3qAcouCLFQ0NcLq3ybMJmZ+ssWe/7GiP4ww4YuClJIGJId/rLJLa0DVvmlJTVoGZCjA
         w3/mhs45mWW2yChEQb5trFVXWZ66oN118aV6SGSK9PRq2jjEmfnsplH9tw4uN76kZgyq
         IwyA==
X-Forwarded-Encrypted: i=1; AJvYcCWN4EInGIgYFSeILA2eY3lIll/987Ju8G8LmO2jZmgV0XKN+6AizGVSzef7w95Z0Zdq3YNj4x90JkV/2ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6iUcy/KHE56cWkZoJEpMIoYMyUq+hQP7YGyw8i+uReJM2xwpX
	4NSKQxIquXFWAmd0iLLnSy69fO7bvCuiW7l7yhKUBvWkH8WhZPh2
X-Google-Smtp-Source: AGHT+IHvJPCSZ1L4NU2yIrRUj8XWrmqpuqmf6ZlTkB+V89y0EIDEkUyMOsWqefDwmDw/BaSZMb8nBA==
X-Received: by 2002:a17:903:22cd:b0:1fb:1b16:eb7b with SMTP id d9443c01a7336-2039e469e8amr70973515ad.16.1724518795941;
        Sat, 24 Aug 2024 09:59:55 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.233.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385bdc663sm44275575ad.273.2024.08.24.09.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 09:59:55 -0700 (PDT)
Date: Sat, 24 Aug 2024 22:29:49 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tdavies@darkphysics.net, philipp.g.hortmann@gmail.com,
	garyrookard@fastmail.org, linux-staging@lists.linux.dev,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	dan.carpenter@linaro.org, christophe.jaillet@wanadoo.fr,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: Replace strcpy with strcat in
 rtl819x_translate_scan
Message-ID: <ZsoRhYeQb4A1yepl@embed-PC.myguest.virtualbox.org>
References: <20240823153411.74142-1-abhishektamboli9@gmail.com>
 <2024082430-unlatch-antennae-0ea7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024082430-unlatch-antennae-0ea7@gregkh>

On Sat, Aug 24, 2024 at 01:45:00PM +0800, Greg KH wrote:
> On Fri, Aug 23, 2024 at 09:04:11PM +0530, Abhishek Tamboli wrote:
> > Replace strcpy() with strcat() in rtl819x_translate_scan()
> > Also Fix proto_name[] buffer size issue to accommodate all
> > network modes.
> 
> When you say "also" in a changelog text, that's a huge hint that this
> should probably be split up into multiple changes.  Please do that here.
Sure, I'll do it.
> More comments below.
> 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> > Changes in v2:
> > - Revert the use of strscpy and replaced it with strcat.
> > - Remove the 'pname' and replace it's usage with direct
> > operations on 'proto_name' buffer.
> > 
> >  drivers/staging/rtl8192e/rtllib_wx.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> > index fbd4ec824084..ec0c4c5bade7 100644
> > --- a/drivers/staging/rtl8192e/rtllib_wx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> > @@ -23,14 +23,14 @@ static const char * const rtllib_modes[] = {
> >  };
> > 
> >  #define MAX_CUSTOM_LEN 64
> > +#define MAX_PROTO_NAME_LEN 10
> 
> Where did this "10" come from?  What sets this limit?  Why not 100?
> 1000?  2?  You get the idea :)
> 
yes, I got it.
> >  static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
> >  					   char *start, char *stop,
> >  					   struct rtllib_network *network,
> >  					   struct iw_request_info *info)
> >  {
> >  	char custom[MAX_CUSTOM_LEN];
> > -	char proto_name[6];
> > -	char *pname = proto_name;
> > +	char proto_name[MAX_PROTO_NAME_LEN];
> >  	char *p;
> >  	struct iw_event iwe;
> >  	int i, j;
> > @@ -59,13 +59,12 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
> >  	}
> >  	/* Add the protocol name */
> >  	iwe.cmd = SIOCGIWNAME;
> > +	/* Initialise proto_name as an empty string*/
> > +	memset(proto_name, '\0', sizeof(proto_name));
> >  	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
> > -		if (network->mode & BIT(i)) {
> > -			strcpy(pname, rtllib_modes[i]);
> > -			pname += strlen(rtllib_modes[i]);
> > +		if (network->mode & BIT(i))
> > +			strcat(proto_name, rtllib_modes[i]);
> >  		}
> > -	}
> 
> I think the } placement is now incorrect, right?  Did you run checkpatch
> on this change?
Yes, I do run the checkpatch on this change and didn't get any warnings
or errors.

Thanks, for the feedback. I'll do the changes.

Regards,
Abhishek

