Return-Path: <linux-kernel+bounces-309525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CBD966C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D881C21575
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C9A1C1AAC;
	Fri, 30 Aug 2024 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nn0UeF1P"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE9171E43
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056822; cv=none; b=K351LNijxn+kE1i/s/jm7WXsxkaMeQ6O9xH0hsBHW+a1cPI03wsEb7vq9kl3u7FN9xmNWo8xknfauaeM6s3DxBlDBIthBa8TcW1A61YQuiHtxxAQ/2Am5v299xc/ukCYUgwIT4daP9QrmWAdWtwtr6kPM8tgSyUwg6ukMxsOhEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056822; c=relaxed/simple;
	bh=8Lh24hus0rjK7CUq45NF9mCCDtg3veOIjr0iAiPjUz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OC3T9oLHW3YGGBeCG8pGmdvnEd1QasMwALgiqBRZT9Rva66uk0BJktwhDkHOuVgsf/Q7UD/MLiOnB8Rp2BXx7UTfWq+U2ujtfPX3Pc/W1xMrFPZt0PgN8aJCfNb7zH57FgphePYNfzVwJP4J0K9PTSLfqwOltKXN1o23+c0jynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nn0UeF1P; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1161ee54f7so2540017276.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725056820; x=1725661620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIIwaTSE/PgqTY8DMhEtWq0YA4uZMo8qA/f+VT8tu04=;
        b=Nn0UeF1PFzViXJf4hdf2VPr/FzBoM6EGpCBkUb+1TyXJ8KIdwP4Yg61J+9tQ38vdr5
         ebZUCk1A33XqMDIqbqeG6e0Fp9vAhdtaOCkMig3eOK2PlFMJ6IabbDf9HRktTyxtmnWM
         meplxwinznUCA8F4ERv8ykbgGTVRhJuvKMPmcIYuOodK6QDGS/mEmbkQAj7c13Fn0GWo
         A7hpI8eKiOKbpyb3821OJEapqZxrzY16noMrwV54UTVdQfYPAC8BtfIFw0gbLVBHrH8M
         cUb12QJtWTcY7M5LOt1vYYQFYgzPi7M1xgB24HEVak+sSSb6SDUbmPplydVWL0MhuHmB
         nlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725056820; x=1725661620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIIwaTSE/PgqTY8DMhEtWq0YA4uZMo8qA/f+VT8tu04=;
        b=rAOjX7docoA7p1YiTbjrNuu4nmHg9qtcJG6wdVtEL0fTVBP8uJYB3ZsIrSLXDdL8fg
         ZZUajoSa/Y0c2SNzHwLCSpYIHNjVBvSWkiqeEkE/0bzt1QDFteELOOgxhPqJG/5M3tp9
         wZO1iccD/QO7D6LsYeucRN16XM8hUre8ua9NXFvqfr03oUnXIIWf1Z+d4lWEEVSAQbO/
         kUN4D5ef4bUG9RJcQYbIseV0TR3IJjgMSiSgtw/iL2cFjJ+uBNl3CgCvFpc5N8XslBlt
         gGVcUPrGU+3Ym/E2pfjh0hJI83/Iotihz5S5WQZmegL+2dODxxoyk8E8eJarPr+Ve+0K
         kGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEVTqlhhSZV7o3yk9GteGyLfTIdkZwNMXGDp1KoosAkGQRQ/d8Szs9ePgOTi5pG+huN53vElt/l+sIVNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQg2bc3TWU+lu7eZpJvnguVvjh5qRliGS72HzeZ1x8V+v7K9H5
	EyGgkQmvB5y5GLXRuEBPFQ92KdYj9uId6Xdl+ydJFUICAB15bQiVjGtMupMoYD2U1nOWOy8LEUR
	0CH1qIPeRA3rCUY8bvqrcrMe9Pe9yGtzfwO9egknnUfcnK1EI
X-Google-Smtp-Source: AGHT+IGKz7xVnVfvTwXwQfWoEKUeTBFpqw9xJkBDAzZD/dsSS6r6zfs/JeF3YhTWw+lmD2/UUtq/r593P4hnq4uLa+U=
X-Received: by 2002:a05:6902:1886:b0:e13:dfdc:d83b with SMTP id
 3f1490d57ef6-e1a78ab4d17mr4208907276.0.1725056819690; Fri, 30 Aug 2024
 15:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0ecf4f4-94f1-2efd-b05b-fc117c62e516@digi.com> <Zs4m2xZ9CTgPBGX8@lizhi-Precision-Tower-5810>
In-Reply-To: <Zs4m2xZ9CTgPBGX8@lizhi-Precision-Tower-5810>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:26:47 +0200
Message-ID: <CACRpkdaiSX6zbyqUqKPwApS-zQ8KYMCqHs0F7Sx17jGN1bpJoQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] pinctrl: ls1046a: Add pinctrl driver support
To: Frank Li <Frank.li@nxp.com>
Cc: David Leonard <David.Leonard@digi.com>, linux-arm-kernel@lists.infradead.org, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 9:20=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
> On Tue, Aug 27, 2024 at 12:12:24PM +1000, David Leonard wrote:
> >
> > Add QorIQ LS1046A pinctrl driver allowing i2c-core to exert
> > GPIO control over the third and fourth I2C buses.
> >
> > Signed-off-by: David Leonard <David.Leonard@digi.com>
> > ---
>
> Why not use pinctrl-single,  please ref fsl,lx2160x.dtsi for GPIO/i2c
> recover.

I'm not so sure about that. Since the 1012 need to use a unique
driver this will be confusing across the family: one chip has
registers and values defined in the device tree, another has
them in the driver, if possible I would advice to keep this
consistent across sibling SoCs.

I can't stop anyone from using pinctrl-single but it's a bit
seductive in it's simplicity, while not always so user-friendly
with all the magic that ends up in the device trees.

Yours,
Linus Walleij

