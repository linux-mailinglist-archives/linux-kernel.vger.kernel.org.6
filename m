Return-Path: <linux-kernel+bounces-543767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D19A4D9BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9A47A3B74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD211FDA8E;
	Tue,  4 Mar 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISrkCSe1"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70261FC7DF;
	Tue,  4 Mar 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082608; cv=none; b=EJjKYx7Hj6Xb9pHdB09JDfbX2j+C+bp6ZJwMH+5AS+BV5OunGi3kgQaVr2vvrPEsQwdVn0GFXHENpCGSU0xZRypn9eEsZ3zHmKBSZDyeIrKBgOEuizVQVbiQBpRzB/I/Oxl1r4i5SYSfFfE74wWQhEjAi3tvwhTL7V1KSTSPeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082608; c=relaxed/simple;
	bh=MXox0Lyz/NoUGq4Jv82B/uOjxdzyOFGLNxekjNLbEFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdG0Wd+0Mcz1ja+HDMRalNBpaJugXMWMiMWyDHOP/r6tkVsUusyqh1MnMF5RT1cxq3joc5iqzZiR1x9vmthxG9whAiqHFCva+HynFrCqGxVauVHdCvJ55su0ibZgoykEc5PZbzgvTBAgbX9fK6g2UPjzA0MvhAUiPo8oNMrdNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISrkCSe1; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86b2aaf84daso2157280241.3;
        Tue, 04 Mar 2025 02:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741082605; x=1741687405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75uugYjxElZY6x8Po32ybV6WWPPYny1t3+5VwBk+/6U=;
        b=ISrkCSe1UhBN+6cYExYpKDrLT/GVjwPeH60/vWLB6OIzdBGSpnWcJv6e4nkjOosRpf
         fVXX8I+vExQ4rIRsBO2ZkswAzplDDl8TwronGdafsvmhyy2he/z5KxMbovRmcRRmQpu4
         JFlFljHhyEMrkf0cOGMoFuYY4yjxDCSNKg7AXIdL71QkT9+JrQXuzO/W+B947uXzbUSX
         jukFU9LjbFZOd8ou9OcJvRH7R6ADXsqlIV2wRMGVSgjy2pHP7oWl3shxbRO6PxbcBoUW
         A1mZ2u0eZAVFiBibqOyfDIcnkjYgAA5W0WdNRAF5N4YLDipvL0IrNqKx0zBD2FgwasA8
         eCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741082605; x=1741687405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75uugYjxElZY6x8Po32ybV6WWPPYny1t3+5VwBk+/6U=;
        b=VsQO14ZBl2cfGbcUx9eL0zoIwv3jq6GjEAiEWTdaqZRWpjT+jg6j8C8FJ62lXdCTKV
         QpmKPhrtYkLrJ7w1vdnbBdCmri/6vSvBxYaNzift1EGMk57A/I61rHUSQwg7LTXTILt0
         qx85/Qh8dIVzej1bUN8Zj65b/ombkM7jTM+c1M38S2s/+NRYuuIAK2JpOn9begyw6+Pn
         pW46bqj2mED/bRTXgDxJm4zWU7Guc4mpGUa7/YRm9lnTQenqabCAROmz7CMZIYRZT9ZU
         4YkSdFGyJgdGVEcZOM5J0O3mW6EP7r4KlhwTCv7hHbzUrFOj9VCyNq99vgcYi/F+4CHt
         20KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNNIuQFA98F0P5eek/ypvagQgpWyU9tQcnBzUEtxdJ6mkKMz1ysg3YSpFck+OeKgGvGSfOjOlvMeB5qqNK@vger.kernel.org, AJvYcCXpcwAHEWaMqaE2vJmdiWWnVvCWA/vC1EUxIwtxFCZf6G4mdyhyK2IFhMQbZ8OYNDU82PP8Rp6NQSA=@vger.kernel.org, AJvYcCXsjmUB+SLCZ7NX0ajjjkviIl2Rb/2fEcwbCBsbr27jqBVyh/gRfJ/QWXkEpEURDM1L93GjQ+OvCJ0XhzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6k2cumniMSLtPf3ZX0atJkTe9c2LKpJxGERiqjUz1QcmIZAdL
	AvTjU5xbfKBEy3/IeXc9ViiSN9sx10O6vwMWVUkpZTwVfoUMsL62Oue4xOiXkHVoB8v5l3eMslO
	AEXf4PxR+E7lov4CyRW8hNN77s8g=
X-Gm-Gg: ASbGncvnfwqMB05xu6vCxrgjSx4Q/bi1BdteucLeBr0ckXloEDcrL2kGOvw0Kz0UzwS
	AqoLRoHY0mvINURoA/0EMxPFFA+FwdmcAufJ5naSTwNP31OnKG6L86JcyBIMpKkqxqe9MeZrqhO
	jeom1dlAeCIZMVgAe4f7z40+0k
X-Google-Smtp-Source: AGHT+IG+l9JR7fV93u9Wftn467Q+GhPebXTmpF9gNWTUd5YaEYIBbL1NcauvJnyntcvnbgg6Igo6p/7SkTGXmZ/cnq8=
X-Received: by 2002:a05:6102:3f0c:b0:4b6:5e0f:6ddc with SMTP id
 ada2fe7eead31-4c044d3e523mr9610629137.14.1741082605651; Tue, 04 Mar 2025
 02:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-initial-support-for-max77705-sensors-v1-1-2be6467628b0@gmail.com>
 <f80207ca-da38-4999-be16-326490396d18@roeck-us.net>
In-Reply-To: <f80207ca-da38-4999-be16-326490396d18@roeck-us.net>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 4 Mar 2025 13:03:14 +0300
X-Gm-Features: AQ5f1JqfkBpa9tRJ6UHWa1ECypAj07rjeWpfg4UZnrHKGSeHTTg1zgLlm1qy3Wc
Message-ID: <CABTCjFD8yozABXGVMtxhHTkpkAVis6tR=LEN9jNpvurTe_0iyQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (max77705) add initial support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 26 =D1=84=D0=B5=D0=B2=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 16:5=
3, Guenter Roeck <linux@roeck-us.net>:
>
> On 2/25/25 11:11, Dzmitry Sankouski wrote:
> > Add support for max77705 hwmon. Includes charger input, system bus, and
> > vbyp measurements.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> > Maxim MAX77705 is a Companion Power Management and Type-C interface IC.
> > It includes charger and fuel gauge blocks, and is capable of measuring
> > charger input current, system bus volatage and current, and bypass
> > voltage.
> >
> > This patch add support for mentioned measurements.
(...)
> > +
> > +struct channel_desc {
> > +     u8 reg;
> > +     u8 avg_reg;
> > +     const char *const label;
> > +     // register resolution. nano Volts for voltage, nano Amperes for =
current
> > +     u64 resolution;
>
> Why u64 ?
>

Resolution is in nano Volts, and VBYP value is typically 5v, which leads to
u32 overflow.

(...)
>
> This is unusual for an mfd driver. Why not pass regmap from the parent
> driver ?
>

This limits access to shared device register map by using readable table
with related registers only.

(...)

--=20
Best regards and thanks for review,
Dzmitry

