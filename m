Return-Path: <linux-kernel+bounces-439052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728249EAA07
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30ACC283008
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B68622836E;
	Tue, 10 Dec 2024 07:52:27 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132B233123
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817146; cv=none; b=PWaS7JY+cAsaWopkIjk60ulE4eoITjDakBAPtoCyxxflLeWGxiu9uJihAD0Tb08uyHOKkg99Byxik4R6YI24Xd7e6x5wYbx5oCUiblI26Mzss5KT2YkBR/7GquY1QAwyecC5YjpNoU+m4VkVnfJvceggbwYr+VXhrShOCyx1pW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817146; c=relaxed/simple;
	bh=fb9XBheC5AF6NuNLIs6+iRITBsPUYizJNiY0NNOZSbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xw0Nt5fqVZnQGixfwTShJXyRIsTkgS1/kFGXHUo/1XXnOaxdNPA8Fw6WtieemOZv/hEqav5qVumZ40Kyh263K+SlGzEYrHmhN8Yg3TA+7QaEaDQ+pwBG2grB0i9jfgM5BfVUufpQIdRlfLQBuLqHYsstXl6XWIBX3pRMKuzaYK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5187f0b893dso460131e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 23:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733817142; x=1734421942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd5kJW4NoChkFf/vXmMTY/HBELzUe+qzSNYi9IJ5t8E=;
        b=V7uU2QdYYsu6MmFyUb4X+0EkFmxE3avrUe50ITGr7ZxfzOUYbsJD3kR+2lB19CAOlh
         PCeT525SFl/B9Tf7rRN+bshPEfL49Be4te6LSaTGG4wbhcIrmR1+rw0Nuydoifkt1tYG
         Vq6ENGbk0iYHKc7s9kddEGwayAr8+7Eh45u6WfiwklcHc4p5V4vCxo8xF2WJ46zJu/F8
         nJAdJmZCEjtgZR+o2LbNAsmdlrfkZxD6VYCDuc7HcBHJmmcf7IQ3xW+FalCtC1T3IvuM
         8DniGDzAp2M8fpFzpNcU1xBoSrdFtHkGILCb/9A+3umMgx+DAp/tvi8o2Cu/911CuqD6
         mKkw==
X-Forwarded-Encrypted: i=1; AJvYcCWIpzWS+3C1jv87V79GZen/ONuuLHgU1Cesy+CPYhLctFzYTVutG1mcth4HpZe1BcJ333MyYrA9WUKkRDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQcmofcXY22HsKSYcoQpyC3CTZydHszhVJv2mgZ72XJX+rFsY/
	hIJSyrOQ2zvkexgTGVPTewd0ku9PXZ+qovu/NRCl5pOB4W/PM0VSxNbIrAYS9rs=
X-Gm-Gg: ASbGncsA8Cc6yLDZJymgvkEbabGWXxEtov8m2bXO3nan8o8xFr0227T8bl6g9IFMRUG
	AVeexQw4IqfZWQ1/8U3jLcV1N4b7pXU8b+71b2zXVhq2jd+XbJxZ1rMFWMRtIAanQ/hFTXJwej1
	OyG7UmQnM9laGERObKVJJUSG1ntc5OnnrmEsXL7ai/17qK4XpGL+uYSCkKSwwdZ4m4Rm86wYjcP
	yD8jU2gr8c0LchrvjDEeC+AcvuxVHMTkCn5BgC4wKxbnX0LJAQY2ksKN4LWBmyrNCEIO9F4CH33
	vvX2jvg1TXsxnNbv2QIf
X-Google-Smtp-Source: AGHT+IF3O0OPsIoY9PjWaY21xbj6AeNW67SISXEzzBoHjcM9rYx8s7tIKI5YykbYgRAONOVn+ZHIjg==
X-Received: by 2002:a05:6122:2087:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-518882ec754mr3640558e0c.2.1733817141585;
        Mon, 09 Dec 2024 23:52:21 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5160abcdc9csm624059e0c.10.2024.12.09.23.52.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 23:52:20 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-518954032b2so65875e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 23:52:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7myjOUatUkDgvWnPk1etoV1/B3C8oQgniusUINrfxVeSBUVynw9btrlWKm45d9o67V6Zj2ip+CqAiZGA=@vger.kernel.org
X-Received: by 2002:a05:6122:3806:b0:518:859e:87ab with SMTP id
 71dfb90a1353d-51888540275mr4084739e0c.9.1733817140651; Mon, 09 Dec 2024
 23:52:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204162128.25617-1-dpenkler@gmail.com> <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
 <ddc720b2-8bb4-4a07-8280-dadeb2de5b26@roeck-us.net>
In-Reply-To: <ddc720b2-8bb4-4a07-8280-dadeb2de5b26@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Dec 2024 08:52:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUb-tpmTiKV5BFopCWoY96D_HYNG60Kv+wVRKnDFF+COA@mail.gmail.com>
Message-ID: <CAMuHMdUb-tpmTiKV5BFopCWoY96D_HYNG60Kv+wVRKnDFF+COA@mail.gmail.com>
Subject: Re: [PATCH v5] staging: gpib: Fix i386 build issue
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dave Penkler <dpenkler@gmail.com>, gregkh@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

On Mon, Dec 9, 2024 at 5:18=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
> The underlying problem is that the code uses a pointer to store the physi=
cal
> address. That doesn't work if sizeof(pointer) < sizeof(physical address),
> which affects systems with X86_PAE enabled. I have not seen the problem
> anywhere else.

I could reproduce the build issue on ARM, with CONFIG_ARM_LPAE=3Dy,
which is not enabled by allmodconfig.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

