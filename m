Return-Path: <linux-kernel+bounces-527624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50517A40D65
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1964B7AB926
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13D1FCCF7;
	Sun, 23 Feb 2025 08:29:49 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B018E1DAC81
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740299389; cv=none; b=QJBJ5t5ke8msj/7BglKst/pK5O51Ieb9yqeswkk2KsDRSxZNLELyh3yJxvj2kWEje79l64x9bYsiKpDiMxQKk2Ma2uuudu1txVl2dfpsjYtT8PJMPHvO9JSu/GS8gi/VfXGXd4d7+Xx1KNFqvBoygBnDbpeIQVJNFcYJi6h5yvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740299389; c=relaxed/simple;
	bh=oDgntAFl6wS5FYg9pbhP/ZNsiY3sual3N75erMlK6Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxedD950h0AA0i6JgM7MoP44qjDPmXMpKGhp9OLfrxObaRLWxvfCJNTWwnSquzps1Te/yt0Ozx+wci/3pbALo8hH6brzWfzYPocsWE5vtMYAeyMiYTZZNgKU1+q7vQyN7LnlTMYEbedJcby7rqYpejCgkYHCvDpEhqsqP/TfRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-866e8ca2e07so841510241.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 00:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740299384; x=1740904184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ki/B4ELY4rZob+oGFNIp8+cpQQDcjVNezaRSiDE1TE=;
        b=DBMxVqM+agiXMhzEcahKyT548M6ezUtPRklIR4j8d0ijVzDKujw4CBPerPB4a37VCE
         Cykw2BGaf25CsX2E9N3TRb1ecDc4NRYDQyOGoqxyUpgsnT4DuSpmaL+u1SV6XyIfdiDS
         pb1MtzwfW0W/961TIR4/5E3bIca2W1QAlb2P0RkbLb+cSrktR9cYQgrvxr7k8WEJDiXI
         C/+zfp7KJ6GAz85m8PSF4QsUsoiPsXLVJiXtgNUF/W7c2nD6h3f1EYd666PBFmNBPhos
         fPnNboHA5g2BNIR2hlyDL0aTfuaFvNRlL3c85lsyweO1cM6K6pBukxnW6Pb14y2xk8Ri
         7oow==
X-Forwarded-Encrypted: i=1; AJvYcCUlvCnYkKy8GcNe7WLsY0RAeZ+NbAQCbgSNqPoX07tPUnlbvOrW3Y/Toz2r6tKlL6vjRQvUUviyQeILrXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkOJcqSn9qGCfXoYRzLjH0cksPQySEBonWp6SLtVXfLSkXOPk
	+13e2UZUh+u1QkZIm7qEVvWslum3oRjG+voJwSIQW6vYEjbPI/Z2D7VhtRSD
X-Gm-Gg: ASbGnctXdPmtf0xiEHW1S1MxigX9WjS920tsVWlyLlHsJEzatygFMw/75I076CTtE4d
	AZQ/S0wF7wpEMa5IV+btNNnQbQTysp8m6GFBSgaTD7AXgw2sYVe0V2uoroaGpHzYIL+GnuEXfSk
	A3XY+IpuoSYRWF17QHnTFl2q15B9mtVU7XnE2USlScFxPeFIS3v7OMVMsrZjGRbOtvZjRy16rJ4
	TyirYOm/8XNNhM3tx/jHHxnt6yZaIpB7u7+Ovk346ecs0sAfzSedAErMdYJTN/ittWGSkY7pwHK
	1rQl44G6hA826E7o8s0E9BNDyIgFZnpH+oL3LBpDGfXyKK9KozwHL8vSjM4CjZ3L
X-Google-Smtp-Source: AGHT+IHkUH8sb0dB+i2YqPnNBakB9BImL2pKzhtFwDq07xf6d8Ad3F8FkU4Sq77rtTSBnOenTkjCcQ==
X-Received: by 2002:a05:6122:659d:b0:51f:3eee:89f4 with SMTP id 71dfb90a1353d-521ee468b8fmr3910671e0c.9.1740299382720;
        Sun, 23 Feb 2025 00:29:42 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52093cc9f02sm4084572e0c.9.2025.02.23.00.29.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 00:29:42 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4bbbaef28a5so1121870137.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 00:29:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFUymzks8xd0F7NU3MX//TI47gDW9QeeZZgueotJlvMk5965X2lzs1j4gZ34TX4GOQC8MeEkQmk4fFD0o=@vger.kernel.org
X-Received: by 2002:a05:6102:f9a:b0:4bb:eb4a:fa03 with SMTP id
 ada2fe7eead31-4bfc01cf2d4mr5204466137.23.1740299382047; Sun, 23 Feb 2025
 00:29:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9638976432d8dfcb0c4df9d454b661f9022a2d7b.1738766259.git.geert+renesas@glider.be>
 <Z7rMdg7+m6qa0Hft@dragon>
In-Reply-To: <Z7rMdg7+m6qa0Hft@dragon>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 23 Feb 2025 09:29:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=ZH7D+m54rh-25nFShCYhRhEjkjaB1LtOrRF5RyrXiQ@mail.gmail.com>
X-Gm-Features: AWEUYZmS7rXgq0ILXCQzgoTNJCt0MsAd5CmZz4lNsRJMvj13mGrXdUP0DGSg_yA
Message-ID: <CAMuHMdW=ZH7D+m54rh-25nFShCYhRhEjkjaB1LtOrRF5RyrXiQ@mail.gmail.com>
Subject: Re: [PATCH resend] firmware: imx: IMX_SCMI_MISC_DRV should depend on ARCH_MXC
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Mark Brown <broonie@kernel.org>, soc@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shawn,

On Sun, 23 Feb 2025 at 08:21, Shawn Guo <shawnguo2@yeah.net> wrote:
> On Wed, Feb 05, 2025 at 03:41:43PM +0100, Geert Uytterhoeven wrote:
> > The i.MX System Controller Management Interface firmware is only present
> > on Freescale i.MX SoCs.  Hence add a dependency on ARCH_MXC, to prevent
> > asking the user about this driver when configuring a kernel without
> > Freescale i.MX platform support.
> >
> > Fixes: 514b2262ade48a05 ("firmware: arm_scmi: Fix i.MX build dependency")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks for the patch, Geert!  But I have just picked up the change from
> Uwe [1].

Thanks, but mine has been upstream since Friday ;-)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be6686b823b30a69b1f71bde228ce042c78a1941

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

