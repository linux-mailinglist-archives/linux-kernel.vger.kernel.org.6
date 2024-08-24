Return-Path: <linux-kernel+bounces-300132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB20495DF28
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B62B211BB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D544384;
	Sat, 24 Aug 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbkNTk0D"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928F8F62
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724519397; cv=none; b=PZTMOcoc9BZvul1IDAsfN466KTGke3mGe2r84ZNGJSRPu7XZ7v8b4bA9diILyxGsfRhZ9IPyYO4STEletXdbGBxSBt/+XiVdpAI9m+Hj1kEk1eoLhtRUgriOPatw+BbhTaPkkFdQ1Sbp5XWLrd/ToaEH3yC8W9YVjsVhAXl050A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724519397; c=relaxed/simple;
	bh=La036WycZQy3mqYzLfhylb4KkfjLHAUpK50Cg8o1hp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqdMpUnNMW3Y4JM4J8uUeEwLj+J1efSy61gx4oEQpQcXxSxscQjZFbf+5IZtJ117M+rMBVWIDnK0waZKUb325OibUDtg/wCUNVzzNZ+rHHXZvSTAmtbahW/I/HzH5YSvS6gGpylwxvocJutfqSig+303zErZFAGtuL3rqSiw2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbkNTk0D; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71434174201so2529001b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724519395; x=1725124195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPJk8EyuuRtmKqUwvIeHzU/+eqZnjDPiW4lHYi002sw=;
        b=nbkNTk0DGzL6WmdemAvpJnePIrN0EPX0l5loBQwT4Jpqq+pSL+euROQFC+DgJKq92A
         pBY2RUqH+k4l2EYGmjb7/RQfVoq0ttcyYLFPwgmiGW+TYSICSOhInv9wLVlnlep2Z265
         TFVCbfg6RuVjo8ur9Dzc7blBVWH+Jz0S4tAWzYIuUvB1VS4LDNXe29upyKIh3/lpgvFz
         U8f4b7ljEUTWV3poqxbXXkT/fkc5y4BWFkKqEbFZbOYo5Lm72+OPMJ4cU261c7He0WVc
         aEFIDmzuvy24RXNOIuSJ8cym3o6yyUMWF0NTahGLFrSe4VkspTDtHOf279mrdqYxhzp6
         2pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724519395; x=1725124195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPJk8EyuuRtmKqUwvIeHzU/+eqZnjDPiW4lHYi002sw=;
        b=LKMF5ZjqRZSdUrzJcf6jmrjbaUTtRu2pHkdPAe6y74IDIhuvcIhpAH2rnH1g6ffdty
         YdWu2EsyJX55+6k2jzSmJc6evdTEmxLJRSGhW8HZcI7XdljF6x7/BnlJCh6V1BjrPJQz
         PyPlwRs/jAlyh+R23+V8yoeB8xZe3p3eIhRzajy5tbfIErcKB/wnT8OUOV/Mxhw0GfcO
         6JYtt/hVxbt8dsIZCQg2ayNLdJd2JWbzm6V7MLCUv29ygXLL6cfey9B/gA1+YMss47ci
         lmZLNp504EZPnYKaiBKybqI+SMicDF3+FTuBhIBEroJeowWzeZ9B0Wx8IWk/uVcBUODA
         iyLg==
X-Forwarded-Encrypted: i=1; AJvYcCU9SbrDYqWgpNoXV7Z6US53uJH4oEu7eibagHWujyq/Fa2voyTQEp1fETOPC4fArPqgpHdb779fg//SQwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2HnuvocXTZjyjS2kSvYNWrNXUaR8iFmNZbXmJGdZbZ5FhcVx
	/cCvDaxxvxsMLdk7ioD41HpxxDKM77/FLpECFmQcjtQVrQ7A+2C7
X-Google-Smtp-Source: AGHT+IGsTpC0pTthXoZnHjqhn53xX6WlH/J3bzT8ObofnPMW8MYz5akRV1EXCigvl6F1amd2VZsX9g==
X-Received: by 2002:a05:6a00:3d10:b0:714:2069:d90e with SMTP id d2e1a72fcca58-7144588dea4mr7293669b3a.26.1724519395389;
        Sat, 24 Aug 2024 10:09:55 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([106.222.233.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ecedsm4714403b3a.25.2024.08.24.10.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 10:09:54 -0700 (PDT)
Date: Sat, 24 Aug 2024 22:39:49 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com, garyrookard@fastmail.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
	rbmarliere@gmail.com, christophe.jaillet@wanadoo.fr,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: Replace strcpy with strcat in
 rtl819x_translate_scan
Message-ID: <ZsoT3eQq6muDPh5Z@embed-PC.myguest.virtualbox.org>
References: <20240823153411.74142-1-abhishektamboli9@gmail.com>
 <1c640c3d-c5db-4eb7-8a22-6d9886a1412a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c640c3d-c5db-4eb7-8a22-6d9886a1412a@stanley.mountain>

On Sat, Aug 24, 2024 at 02:21:47PM +0300, Dan Carpenter wrote:
> On Fri, Aug 23, 2024 at 09:04:11PM +0530, Abhishek Tamboli wrote:
> > diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> > index fbd4ec824084..ec0c4c5bade7 100644
> > --- a/drivers/staging/rtl8192e/rtllib_wx.c
> > +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> > @@ -23,14 +23,14 @@ static const char * const rtllib_modes[] = {
> >  };
> > 
> >  #define MAX_CUSTOM_LEN 64
> > +#define MAX_PROTO_NAME_LEN 10
> >  static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
> >  					   char *start, char *stop,
> >  					   struct rtllib_network *network,
> >  					   struct iw_request_info *info)
> >  {
> >  	char custom[MAX_CUSTOM_LEN];
> > -	char proto_name[6];
> > -	char *pname = proto_name;
> > +	char proto_name[MAX_PROTO_NAME_LEN];
> 
> In the end I think we don't want to make this buffer larger.  But if we did
> this define is really vague and slightly confusing.  I assumed it was something
> else when I read it.  It hurts readability.  It would probably be better to just
> leave it as 6 instead and add a comment.  /* Large enough to hold "N-24G" */
Okay, I'll revert the buffer size to 6.
> 
> >  	char *p;
> >  	struct iw_event iwe;
> >  	int i, j;
> > @@ -59,13 +59,12 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
> >  	}
> >  	/* Add the protocol name */
> >  	iwe.cmd = SIOCGIWNAME;
> > +	/* Initialise proto_name as an empty string*/
> 
> This comment doesn't add any information.  Every kernel developer knows what
> memset() does.
Sure, I'll remove it.
> > +	memset(proto_name, '\0', sizeof(proto_name));
> 
> Normally we would just say 0 instead of '\0'.  The other way to do this would
> be to initialize it at the start:
> 
> 	char proto_name[6] = "";
> 
Thanks, for the feedback. I'll do the changes.

Regards,
Abhishek

