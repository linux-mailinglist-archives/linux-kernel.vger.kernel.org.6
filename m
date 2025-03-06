Return-Path: <linux-kernel+bounces-549791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FEEA5574B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F721894636
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40A270EA5;
	Thu,  6 Mar 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euhcaooe"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC5C42A8C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291732; cv=none; b=gviwBBQi9ts16cJnutQdwlWFwzTLqus1U4fd+u8njQ9VVdVPfL6ePvojUzUBQ7WxVKhdX4iI+6GB34ITWqdowUx1IfJRkGLYC6i9VjfnY7lznhf44t3hNuT6X3FCqyb+tir6xH+8/ekHRZ7Bjq8rLvhfvCCiwnq8gQ3GI4554qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291732; c=relaxed/simple;
	bh=4ANQ6jxnMVqPUbO8KxS0IbrnE06KdtXQZKCpH/+k1M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcFdp0PbhNATy+BcMjdIQ3hdfUT3QuuQ5jIwXljWjEoSNW5eLt2P3qkJvJphyhCpVLzwVyFwGu5AcjRohz6zyn8wB8qtBSutnyL79PMRuT6FJTJPOgclEOhx6hgGbZfHhBDoOdtc7SthrCZ8tSSGMQVm4o8EnP1TLT8c0wVob4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euhcaooe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390d98ae34dso857115f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741291728; x=1741896528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vu6Nb3Ka+Nd4QHA4BCCuDDi+MFoZySYQiXMqKDLBjpo=;
        b=euhcaooeRrLJfc8iV0QsMELCxV+j8/zxsrPUDsIiqjTESr2tj0ZUvH0+eeqpaNaw6Q
         ZZXgll9XMjEJMnLyXF6lbuI3lYlw/gnlFF495tAkjkg8JRlisrCislRwfH6NckD184D4
         V+eeCOyGvS2b7eheTyeAwYnuQo5aye0lbrNmUfE/F3fKv/87dVfEZVl2kMmdz+T81Twn
         SVZERV1QP9p3vz9dGub3yYNvp3C610M0zpsMSAd91Por1od3avTdvSHmrbOHcvKL70M+
         ODNqCcbax0e64QDnk9RSRujP0iJujQMnuSN9SMUlcpTAf9Bj6nzAEG3iOuy+qYsoATVu
         l/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741291728; x=1741896528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu6Nb3Ka+Nd4QHA4BCCuDDi+MFoZySYQiXMqKDLBjpo=;
        b=ukE+CxjYhQuyRuTOoXw8hTtRO8UHurdf+6G+an6BWEpnA0gO7kMLt320FCYeuk3Kh0
         wV44rVQf67ZtgVzkHFA3cAaG4JGpT6YoucGamXEAHHItCwhaKq6YqL0SxCxcvKHw8uva
         tjPn8MZvh0lw9wxIQyWh0zS1p0NM3PqAmT/Ixx43Y6IUelkV3qCeFG4HZWINRYbcUkHL
         gYftGD/I7RmVgQRBXLjjmMNPDhv/r6oyVL9fSEUt9tKZcp/qsL5qJc0VbVfLt8g+icXH
         rTTHE8NlHexnobEf+4OU1eG5GfAtbyKTHeiN0qyYrU0w6BcH76DvyxNQE47MDUcMVIg9
         Nkew==
X-Forwarded-Encrypted: i=1; AJvYcCVAUQLdQyowmWG56H5WT2sPbdVMQyzof/08SqiTaxysxxHkBnYa0/z64+mPHmjdy2iUpZw2u8a0uxfxbbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf7t8WNZ7+sPViZlly3d7hNE9KFekw9hjvIf2YGXNyxpcPp9zV
	EJh8DykEj73cb5pQdGdjtPLWRsc7pjPruS0eZzfb6Ywh9ab0o8LBSl5ErFSvAMQ=
X-Gm-Gg: ASbGncv26lUqxXkpGZ0kJgCe6ebWv6Rx7P4llvvlhfZ2SzBWyise4egp1xd80IPSI1Y
	Ld/UGf997Qxc2msixXNFmsS3U15hH553q4bIXiWSs+zL8hLDiq9ubEiZBqh+eEZZ/6eXb/bm4zB
	BhN76SirHnPv+EWVHzIyDZEIU+Ed8aeHYSehwbcqpGifW3zMK79u+KkV8MokFb2WJIw0r76e4f7
	JfMLOH2nTIPYsT4PROB8cvlNRMbJ9Lgyfdrgy1Zxb8abmXdr9vYClH7E0jcfrIic//wefSQTvsW
	STi//NllL0uvk5ttyD9i0JP6kPD/HYq0ScD9/xjxk5PNtpPztg==
X-Google-Smtp-Source: AGHT+IEUEM1THRDjnKYSch5Ww+/6WcBAoHn7/OHeW6aQR2tMBEMKVdYUpqjgGMl6Rqo4PDPLKLMO6g==
X-Received: by 2002:a5d:6d8a:0:b0:391:1218:d5f7 with SMTP id ffacd0b85a97d-39132dacbd3mr295375f8f.40.1741291728288;
        Thu, 06 Mar 2025 12:08:48 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfe0004sm2942613f8f.40.2025.03.06.12.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:08:47 -0800 (PST)
Date: Thu, 6 Mar 2025 23:08:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: sm750fb: Fix CamelCase variable naming
Message-ID: <b500aadd-e273-4434-8219-6e5c04f7c8e9@stanley.mountain>
References: <20250228162359.14029-1-lima.gabriel.luz@gmail.com>
 <ba45d980-c6b1-482a-8bfd-457a92d3e24b@stanley.mountain>
 <635f849e14854b0db1f53a0d0bf329c3070e5859.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <635f849e14854b0db1f53a0d0bf329c3070e5859.camel@gmail.com>

On Thu, Mar 06, 2025 at 04:40:05PM -0300, Gabriel Lima Luz wrote:
> Em sex, 2025-02-28 às 20:40 +0300, Dan Carpenter escreveu:
> > On Fri, Feb 28, 2025 at 01:23:54PM -0300, Gabriel Lima Luz wrote:
> > > Adhere to Linux kernel coding style.
> > > 
> > > Reported by checkpatch:
> > > 
> > > CHECK: Avoid CamelCase
> > > 
> > > Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
> > > ---
> > >  drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/sm750fb/ddk750_power.h
> > > b/drivers/staging/sm750fb/ddk750_power.h
> > > index 63c9e8b6ffb3..33e852fe6949 100644
> > > --- a/drivers/staging/sm750fb/ddk750_power.h
> > > +++ b/drivers/staging/sm750fb/ddk750_power.h
> > > @@ -3,10 +3,10 @@
> > >  #define DDK750_POWER_H__
> > >  
> > >  enum dpms {
> > > -	crtDPMS_ON = 0x0,
> > > -	crtDPMS_STANDBY = 0x1,
> > > -	crtDPMS_SUSPEND = 0x2,
> > > -	crtDPMS_OFF = 0x3,
> > > +	crt_DPMS_ON = 0x0,
> > > +	crt_DPMS_STANDBY = 0x1,
> > > +	crt_DPMS_SUSPEND = 0x2,
> > > +	crt_DPMS_OFF = 0x3,
> > >  };
> > >  
> > 
> > It seems these are not used.  Just delete them.
> > 
> > regards,
> > dan carpenter
> > 
> The dpms enum is used in the definition of the 
> ddk750_set_dpms function in ddk750_power.h file and
> this function is called in ddk750_display.c on line 158.
> 
> If I were to delete it, what changes should I make to 
> the function mentioned above ? 
> 
> this is my first contribution, thanks for all the help.

Huh.  Using a enum for shifting isn't the right thing.  It should
be unsigned int.

The enum does serve as documentation.  Maybe just change it to
a comment or something next to the ddk750_set_dpms() function.

The ddk750_set_dpms() function does a weird thing:

	value = (value & ~SYSTEM_CTRL_DPMS_MASK) | state;

state is something in 0x3 but SYSTEM_CTRL_DPMS_MASK is
(0x3u << 30).  I bet it should match the on both sides of the
if statement:

	value = (value & ~SYSTEM_CTRL_DPMS_MASK) | (state << 30);

But I can't test it so who knows?

regards,
dan carpenter



