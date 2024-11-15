Return-Path: <linux-kernel+bounces-411009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DE9CF19F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637691F244DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8415A1D54C7;
	Fri, 15 Nov 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7g+fzjB"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749A1E4A6;
	Fri, 15 Nov 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688600; cv=none; b=X/waVjWm42vj3bhp7i02WA4abx+BOtT8Rzd0ebUDpfSnXvMslqvp2RuewhXMy++56sV0BaxSgFIy0sOM9vfzXlfCv3WgBfSudwVfjsJ/XYvnfIh7+nnKnUCAwOlcIx8RJWvXpgXASm+0c0cU/FPywQXsqIcAQM9rjNQfZQOG31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688600; c=relaxed/simple;
	bh=y+PbtP+vn6mx5pVaEDZFsg7iVYw3KU0kEFAepCEBgf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnJaSw4OFQxH3NpKx0r9nL+R2t69LPqAiuN5INFrVI0LED1vMwbx8+44ZBeM+s9cP10OTYuOEnay+jqcHw57HlNbaNmyDAcIJ6eyt8jR/RrY2Y8T+PM4fY4/qKdZal53NEyB2TCNtAT1dz4OQNbxT+NC/0TUVwIa6kYZ6Y9nxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7g+fzjB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7247ebab977so550334b3a.3;
        Fri, 15 Nov 2024 08:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731688597; x=1732293397; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNOdDdSV1Z0oUqfYyXXzrSfaZYOowO1TNJ4A5Rc5Khc=;
        b=I7g+fzjBYuMbZlT5DxQEGzVjCpOtiJn9tei1LaksVvFco6QgNy/8uBQDc0kIuJ75CI
         0+DaMD15giW6YUweucRNufL1UPO00t9G1KFD8vZ8BdBtjX++XXkYZ3tXahhLkc6N+Nnf
         AMyj00QqpRoJA2WMiQ93YHI1k+a3wwMIX4+rFjnhyJVLmBMkHgyQ/RJ8WsF29RWK7Pa0
         jshf4lcy+f9kTwxPcTfgNG4Z++W1Vtx/Mab0DRwwnIba+cqYutZHZT0lvbZcmmONU6vm
         CVsKKVeXIJ/QA/TalTMrSyG7rt+geQq0Wx8yRaZHaqN7VIvpLuk1rIu+al2aregw2ZwL
         KX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688597; x=1732293397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNOdDdSV1Z0oUqfYyXXzrSfaZYOowO1TNJ4A5Rc5Khc=;
        b=pEirbPrekFDWNrR2f1PySbC/Dp2Ehj11w66egrx783faQjZD6JTimraQp/9LUCHv3A
         EQZTFL6So3eau9pQ8zVYrA1ieEXUW3kAgGnEgIR/DXQrPZDextdxagv+WwVGHPk+h/rC
         4e6kmg7+5yCmdKC44FCpp1E5KEvHANG39uCYvKcTa84fh3OY8ZcZ+dj7Vs2L4cu8PGGp
         OUzBvM0KlTsIVDCcbuBvk3UwiMTWGz306VBcLsCr+EnEhbvvC4x0t0vdbTNozm0a03Wg
         WQ4iyV6Js3JHconErN8JY0RTguFJfgoxM3B7UgUV6BkRogeamnJTRqDhx4dnojQlk/0g
         mmpA==
X-Forwarded-Encrypted: i=1; AJvYcCVEWHJV4UFiC3gwLKuEe8/ujHwb756G/zpAHHiHN+QI+31LtWdIJv0B50wPFp1JKBIpzgMATVbP5a6DTIfm@vger.kernel.org, AJvYcCW+/KmHw2tJ12Mrgqaerm4YE5GGGsWZ8SaOpiSLdHKRU7fkkTdEFqQULzBYXAvrJvV4ti2Xda9QPeyhBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Da+NL2yNnlDR6G/Q1If7DDO7ns6IVABJnCsZ+MNXHtbTjk96
	PSfGqKfJiybyxBE/uSw1zu5VmefmvQM7e9qLscnk3nn/8kCNoEJliKwrhQ==
X-Google-Smtp-Source: AGHT+IHLRXUrvO/FSpUkSwIOqI4NgtwIXaRbEzAWdH0RZpCjHH+b7ipJ0iAec7vzqzNEsn/WAPz0oQ==
X-Received: by 2002:aa7:88c5:0:b0:71e:5f2c:c019 with SMTP id d2e1a72fcca58-72476b87648mr3428783b3a.9.1731688597530;
        Fri, 15 Nov 2024 08:36:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477120abfsm1538313b3a.53.2024.11.15.08.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:36:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 15 Nov 2024 08:36:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (core) Avoid ifdef in C source file
Message-ID: <51c9b886-be97-4fe4-bc22-35d1c727b93c@roeck-us.net>
References: <20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net>
 <20fde375-a88a-4279-a849-520063217de9@roeck-us.net>
 <3dfa3859-cef0-4311-b0c5-ff1c04284e88@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dfa3859-cef0-4311-b0c5-ff1c04284e88@roeck-us.net>

On Fri, Nov 15, 2024 at 08:34:47AM -0800, Guenter Roeck wrote:
> On Fri, Nov 15, 2024 at 08:31:29AM -0800, Guenter Roeck wrote:
> > Hi Thomas,
> > 
> > On Wed, Nov 13, 2024 at 05:39:16AM +0100, Thomas Weißschuh wrote:
> > > Using an #ifdef in a C source files to have different definitions
> > > of the same symbol makes the code harder to read and understand.
> > > Furthermore it makes it harder to test compilation of the different
> > > branches.
> > > 
> > > Replace the ifdeffery with IS_ENABLED() which is just a normal
> > > conditional.
> > > The resulting binary is still the same as before as the compiler
> > > optimizes away all the unused code and definitions.
> > > 
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > 
> > I decided to apply the patch despite my concerns about the lack
> > of dummy functions. Let's see if it blows up in our face; if so,
> > I'll revert it.
> 
> Ah, no, that didn't work, because if CONFIG_THERMAL=n there isn't
> even an external declaration for thermal_zone_device_update().
> 

allnoconfig+CONFIG_HWMON:

drivers/hwmon//hwmon.c: In function ‘hwmon_thermal_notify’:
drivers/hwmon//hwmon.c:302:25: error: implicit declaration of function ‘thermal_zone_device_update’; did you mean ‘thermal_zone_device_disable’? [-Werror=implicit-function-declaration]
  302 |                         thermal_zone_device_update(tzdata->tzd,

Guenter

