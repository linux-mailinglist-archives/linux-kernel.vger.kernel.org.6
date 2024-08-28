Return-Path: <linux-kernel+bounces-304557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE239621C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89524282647
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A715B0E4;
	Wed, 28 Aug 2024 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1CHnnIg"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29617159596
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831470; cv=none; b=pm8wC2o68nLCUSWIRKyijhEtbLUtD03NHmQMHwrp72riy/U6ff3RlcbmmZiC2Qkli8p3xzBIlwdcBHNQwwa72ZRG5viqxYD/K3uk6x42bWP2WJX2y3L9t16D1xBN/You147M0rxoPex2KQS+4S0nKl1kStMuBZT4txQ3UN7VqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831470; c=relaxed/simple;
	bh=1xVOh7u4bz7vUsAW3b8MvsNa+VA3R5snTgO/wuktJs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbHE1KrdDeT9q+pm0uHsZFB3j1F81h7ne6t8GB3lKDjfi9zQosexAUhXFQK32b/C/KS26SG5ijgeNwV1HmBdfk6GWsL9oJEJvbgEgIzIgQMwwFAQWJOiSrqCbWDPvHTRbI+Gr+wjTR2NB+4rP+ePZZ8Qp5SigjHvs1bu5vwEQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W1CHnnIg; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f401c20b56so2985411fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724831467; x=1725436267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xVOh7u4bz7vUsAW3b8MvsNa+VA3R5snTgO/wuktJs8=;
        b=W1CHnnIg+1pfhvm1yyiGHdp3opVk6FzD3C0lcByNHg3tGsbyAjz8wQkaBxnmHaguA1
         mnuG3BQLxE3uwW/tLRfCDqT/AIWd33Zo0zKAR8GrRl3HyaxzQ8FsfKmHt9I3GLYlM/m7
         UTnFqc8dyBIGrgATB2vHJpcS0jSb5dk0M4g+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724831467; x=1725436267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xVOh7u4bz7vUsAW3b8MvsNa+VA3R5snTgO/wuktJs8=;
        b=RBtL8CgwAJl3aXMB4LPdUAS5Vbit4eslirKg2RcayQl+KZHO3Mh6MzwgAG8PnWDJ0u
         g77L1+TPgs18PQVxJwkPDbOdfP9tfPx2V7ifDQWj7PnZVHXs0RhdjVweRZYaSDgrCfyW
         E1p8sanHn3knWd0REqCcRQehP0DJnNIZk86UrM4ZzQuok2WvVBdIoya5oorEgzq1cEq8
         1yUShZBazKzM69QsabSrGAuJ+PiirViDWh8Ivo99EPaP5h0UC9DpcWBvHrm0tCQr45Jn
         ATW3mEyvWce3Cprs+aV1uZdt+uF7YqAHpj1j0Sg81edRwhF4tp9w9Jyp3L6qNIzTUDBd
         ITHw==
X-Forwarded-Encrypted: i=1; AJvYcCVCMKj/yoU5skZqYG9n3Unrx7VRZXvTiMIu//hi2UTdchkICKCF11V/lnfaGx1fADnjuUSzViS8vKbbAoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoqfb4PBqK/MLYh6xfEOs8XOtO7bXg5t/LzgmB3NPdcmkiZTAj
	0pqNHk15cPaxrRskQ6/LZjZSbajQ23pj/XSbRgruHLAPSH+1cl9nYmYZkVHiTpTl46Nj/PUw3Fh
	o5JLWN5vXeA/nbCCbl7zCYMUB43MBM+QlXJaL
X-Google-Smtp-Source: AGHT+IH0LjY1WJEtfV7bBIXxyU8519V5C9eqCvjcTi9KSiJsKRT2mboVsXyhUsIpn8kBH00TsJ/Oqxo+cW+z/fvgG9c=
X-Received: by 2002:a05:6512:1150:b0:52f:413:7e89 with SMTP id
 2adb3069b0e04-5345675cc1dmr450928e87.17.1724831466960; Wed, 28 Aug 2024
 00:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827095550.675018-1-wenst@chromium.org> <20240827095550.675018-9-wenst@chromium.org>
 <Zs3mP547BolU4MRt@smile.fi.intel.com>
In-Reply-To: <Zs3mP547BolU4MRt@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 28 Aug 2024 15:50:55 +0800
Message-ID: <CAGXv+5FSt=8yRBa0ZqVQs_27wTGDedJiLdhMfGzzSySQYXbctw@mail.gmail.com>
Subject: Re: [PATCH 8/8] regulator: irq_helpers: Add missing "Return"
 kerneldoc section
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 27, 2024 at 05:55:48PM +0800, Chen-Yu Tsai wrote:
> > kernel-doc complains about missing "Return" section for the function
> > regulator_irq_map_event_simple().
> >
> > Add a "Return" section for it based on its behavior.
>
> ...
>
> > + * Return: 0
>
> "0."

Ack.

> > + *
>
> I don't think we need this blank line.

This actually changes the output. Without the blank line, they are treated
as the same paragraph. With the blank line, the next line is treated as
a separate paragraph, and put in the "Description" section.

Strictly speaking, the only return value is the 0 integer. The other
"return" values are output parameters that have been modified by the
function. I believe those should not be in the "Return" section.


ChenYu


> > + * Actual regulator error and notification are passed back through @ri=
d.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

