Return-Path: <linux-kernel+bounces-525670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D052A3F2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0934232D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2A4207E0D;
	Fri, 21 Feb 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzyagziK"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB71BD517;
	Fri, 21 Feb 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137482; cv=none; b=Bczj5TI5MyIasipftS7FVR3s1/75JxkHrx2OHufW4WKSyddrqhMDMrwMFFuYzhWpAmFjPJz6rhOhbFz+Uj0MmeMnfeB+9bUol8/JOFK83KS2zpDnaouIKICe4ywuLIh+NjYJ4NCrtAQpqSa4jKB0xYMSvAk2bK/cdgut+yEPE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137482; c=relaxed/simple;
	bh=2sYSAvls+4ReyVP1ib+1dhbqf+0o0BnL1erhUxo8L90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9fmtbpHfSGYYQLDgYDj1lxmu3JNY8YqOPt9i2cEQwVbWDzWdb/aeDSyW9S2h9FtTmrAkth/NbMXPkmTAXkcZ7Xxfr3dkHodA9zbRcZsHeGx8/WZDlUwODUWxFdEZgyIEQtcDi94Nscx3/WMct3G9kVSAaYjmFmgnT99gDiDkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzyagziK; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47210a94356so15711151cf.3;
        Fri, 21 Feb 2025 03:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740137479; x=1740742279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLzzEgvqFE7GbnZ2AxDXQJUzBi6py5ZBkycvuKHjYMY=;
        b=lzyagziK+mToDxY663klDVwt/N6Wh7egIvNBlVSca8Mn7/UhSqeGMa+kLhTQU3LJM5
         F0uZIjee5AJcr0/KryTlggKtw0oN8DSrRjt6nokZOwvqQW2l3Y8YKme2JbNfjVJbsdun
         YznWeM81vq21Rmk+E8U4fWjAe2tWHIBvOMtOzD+2DbkvRK5O8GOS6LdKqepwS9OuUceM
         wBEmHAL8ZpSDNH+jZZbgn0NZj5OKovavxc+H8cHqBiaILGoWJBV+euAvdNww+D/1AazM
         O+kciyVx4837RvOualzn8mg4R8/HEJQdgkS+g+ZMpZ/SmCqDr71IasejxFAuZWLYJzt/
         N4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740137479; x=1740742279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLzzEgvqFE7GbnZ2AxDXQJUzBi6py5ZBkycvuKHjYMY=;
        b=SgLSvJ2NfQkXEyr2/wQr3/JzGYK2W2gQQQ4HAKtFZyysItnL6qduAfTyQBuFgDwstv
         lSIYvgRo+YX0LMASu+0juT5L8Z+u6k+UvZrPGXNI/SDhLJbuVaTraVW02dkL00p9jBUv
         gsIqV9UozYAkHwzTAD69Dz/cEus3Rj9GMAYF26BeHmLKFtCcWoT2gpSz683Y/sBLibxc
         HcfGlsfif8KbktdWIKJ8h1DtvCfmcHNWRw32J/8hFHCemO73NyWNfuN7EPU/lyVAOVSh
         0DLdco6pv9qbVjCKWDEofS3yYBIBXGau3RMUPm1FW5IkUG1dMqBljc5/ozqpkBJXmeQ+
         tH0g==
X-Forwarded-Encrypted: i=1; AJvYcCUVpbDYv7caoNj6VZ+IQ3RMJw6M9j9fHApYFm9gHR82DviGmLP2LvS90lnNXeqL6LgxdgXSST1f9Yvk@vger.kernel.org, AJvYcCV8uG0sw4kdn3jMM25qQR/TVUL8CYcyVl0I8Kd7Qjp/bUL3LZk6X20klAIEjJF1C7Mivjw0ON7Yh0K+eNQ=@vger.kernel.org, AJvYcCVmk+mfpZZyA5bheItvqrboWXZX7AftTL9/Io/BGVFrL2iJQLvkU9LYNv1hO07lJzwf1YpAI6p1q6Y5pi4=@vger.kernel.org, AJvYcCW04WuDvqpkon0bY/l+JLQU8qVzYm6G5iLGP2dcdzM/YvV9Q76/nte37XcVrBM5wTT5GZvbGxvGqWOmKnyM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb2R6kEI5r37hfhig0v1AS3i+bQoYCRpGrMT2eXGoSuMXAUboI
	Va1Pq5xxKjU58UqoH57AbYy81tlLb6hBM9s6SDKuJPhG7INfGA/gGBLNtSDrWSeGaqIm7b1MCN6
	JseeU3DAPdtkoPujJGPiUUJuxYAQ=
X-Gm-Gg: ASbGnctVqcrRHST+wHsJvwpbup+VjdNK84uwnj3MwdZQSCE6LiIUfiOkV11VgaeAWAU
	+m+kWrbEjKV9nQv4YQVWP6U6u+boByOo2esEMuzeCY/igY6m6rRDBma+tnDGPLFZTfzL4F2fUSC
	fazdlUwtQfprfY4NbsBQ66LSRwFSQ30kuBrzw9ZA==
X-Google-Smtp-Source: AGHT+IFXgBHzvJE7xTARImFvwXCJFuJ53+r7HKxZ0EgS/TsYE76YhhfXmNth8OohHrtxj5r3VNLo5+k7NxnowBJnZyM=
X-Received: by 2002:a05:622a:101:b0:472:1b70:ee35 with SMTP id
 d75a77b69052e-472228b445dmr33601771cf.3.1740137479508; Fri, 21 Feb 2025
 03:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-14-932760fd7e07@gmail.com> <4e0e2ae0-c53d-444c-9d8a-d465be690232@roeck-us.net>
In-Reply-To: <4e0e2ae0-c53d-444c-9d8a-d465be690232@roeck-us.net>
From: James Calligeros <jcalligeros99@gmail.com>
Date: Fri, 21 Feb 2025 21:31:08 +1000
X-Gm-Features: AWEUYZkxOvXOcjPt0xQT1Ig8EoTQnHW-sw6rQquHl8P6f2lTyg4bCTVsUynHGrI
Message-ID: <CAHgNfTzfK4HnYs+LDH7kcR+pZqSxT9YBZYQ=c+Mcpva4Vx=D_w@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] ASoC: tas2770: expose die temp to hwmon
To: Guenter Roeck <linux@roeck-us.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>, 
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shi Fu <shifu0704@thundersoft.com>, Jean Delvare <jdelvare@suse.com>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 1:20=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 2/18/25 00:35, James Calligeros wrote:
> > +static int tas2770_hwmon_read(struct device *dev,
> > +                           enum hwmon_sensor_types type,
> > +                           u32 attr, int channel, long *val)
> > +{
> > +     struct tas2770_priv *tas2770 =3D i2c_get_clientdata(to_i2c_client=
(dev));
> > +     int ret;
> > +
> > +     switch (attr) {
> > +     case hwmon_temp_input:
> > +             ret =3D tas2770_read_die_temp(tas2770, (int *)val);
>
> Type casting a pointer like this is never a good idea. This only works
> if sizeof(int) =3D=3D sizeof(long).

I will rework this when dropping the die temp sysfs interface. This
was mostly so that
I didn't have to change any of the code there, but since we're going
to drop that
anyway it's redundant.

> > +             if (!ret)
> > +                     *val *=3D 1000;
>
> The calculations in the previous patch suggest that this is wrong.
>
> Either case, this is redundant. The temperature is already displayed
> as device specific sysfs attribute. Displaying it twice does not make sen=
se.
> I would suggest to either drop the sysfs attribute in the previous patch
> or to drop this patch.

The calculation in the datasheet yields the temperature in degrees Celsius.
hwmon consumers expect temperatures in "millidegrees" Celsius as per the
sysfs interface documentation[1]. Regardless, as above I will likely rework=
 this
when dropping the die temp sysfs interface so that things are a little
more logical.

Regards,
James

[1] https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface

