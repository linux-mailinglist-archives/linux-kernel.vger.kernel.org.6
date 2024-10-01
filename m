Return-Path: <linux-kernel+bounces-346359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0345998C3A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BDD1F23A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66771CB522;
	Tue,  1 Oct 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTWTauLP"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9DF1C6F70
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800961; cv=none; b=bQS7a+n/48yH8AbtElrn/Oe47gz85ZCeSEVxYgjo7frN4wZ3hNntDVSoKQqmxUk5FABEaYbRX0isKbdb6hurimKKWfiYCD2NkA0b3doBdTpqV2V+9ySVGZpiPhZ5AYXjjdRSD+8wUYIHQAtCTTZGDegpXB4cDeY8FY3WsBGu1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800961; c=relaxed/simple;
	bh=qDk+Xk5T3BmfKW2hoygle5OjFf/fDlqRm+H/1l0P5yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGf72snR7Nxo+oIHiQ39p60mELcsWRQjjg4vL7U82Z1KIT7nfQWP7+NMhsR0Pzz0+lmMYHlwTDZ9cgcdb5bWr5ufgWhQsy6UWHiFbDjESH6b3M9rJeG463KoaRpXOyppoExGm1gLizwb4xiUSDQRKbXT2RL0LhEO0N2So8fWh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTWTauLP; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539983beb19so2616584e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727800958; x=1728405758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6i7vWcWmPggAvHHEAieW2NuSXRKfSov4TjQFiR69WU=;
        b=fTWTauLPdJLtrOBuqLRE2BSEOGKaH3XbIhnga5E9ziKE9094yjgRFDjdbwCHnkVntl
         8sx/fS1IcMmQniqo2j6igb52Dl1g7PiAzYH3XDyuygM0FHOGOYa9L42F7Dx1u4XXb7C7
         LvEeTHmvMQq7WnMGL7X7KKkdrWOwiULxI/yvHV+OZtdn1v3gFnKsMnE8zO07OUUj3xyD
         LaVTaVlRgJ6icKhv2sxQyFeqW3hsp4rbJYGyOIw3sIeGAiVlrrUeEQIz8LPH5WR8P/XA
         At0lWAZZmLKd1gF+9unPEePAdMNyTQVWfRnIeZvsf5EP4faeEyczpWhNjMelUlcE2OxG
         fLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727800958; x=1728405758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6i7vWcWmPggAvHHEAieW2NuSXRKfSov4TjQFiR69WU=;
        b=axQWwoan71bHgiBLuRPOAcZFuFiCDDinOYLIra2t61W3m64I74Kj3tlgp6hzj+lZd+
         qg8Nu3W4/wHEbnpjw8Gfks6kKlsu2gBLfIw7I1urgzTRLo1d5zB0pHhPTtWtKwposOmS
         IRKKL1Ycqb7uFgDukfzvz+2E/bO+LV5dNh8V9W2ZiAKjZRC7LtnzXB1gFs+swmBkgpdR
         eeuZmuG6Zo2ShlKN3m2rEsnQYfDobKeNoZR74/BxpB/TilBPm6Tk4wVzHcFbF0dM/OrG
         z9v+C8pQg4+xTOkPr27/UPwgx9YRSiR0GBvDSC19dfBDA386wgtcIFM4tROCh89/2FWv
         nZTg==
X-Forwarded-Encrypted: i=1; AJvYcCU41fHlDodkN2bNmtw7MOvbtQ/67PJTbJ4f7BAulLFV26vyS0XR926vtv2H9juoNtfJnFWxzzWMWPNX2DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Z33MiCep22okTFDASA3oDtl8tLSCIGK+SEkJlUV19MxbXIwo
	Rn/rONDU6hFSdkljGEyli8YWB0euWmGey78sF8ZaLbGRuq0UeCC6ile/7I+5bHlIuDDVbHTX1jG
	FPUHOMiC9605RKHoAO484g+X8ORQ=
X-Google-Smtp-Source: AGHT+IHrY7301UmnL2Imcx/jn4R4Bb+f9nqvndhDoNb5KoBwiAbH01vr7CF3mvxGbkFApgIhoFOuXGohXFlDj85XM5c=
X-Received: by 2002:a05:6512:3f11:b0:536:54e9:3a63 with SMTP id
 2adb3069b0e04-539a07a339bmr7710e87.49.1727800957816; Tue, 01 Oct 2024
 09:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001163106.4169421-1-han.xu@nxp.com>
In-Reply-To: <20241001163106.4169421-1-han.xu@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 1 Oct 2024 13:42:26 -0300
Message-ID: <CAOMZO5CsoTAPHBkuDw_zgArRX0g=aUNeVJQPzD=dv9qTtjXU1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: nand: raw: gpmi: switch to SYSTEM_SLEEP_PM_OPS
To: Han Xu <han.xu@nxp.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, imx@lists.linux.dev, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 1:32=E2=80=AFPM Han Xu <han.xu@nxp.com> wrote:

>  static const struct dev_pm_ops gpmi_pm_ops =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(gpmi_pm_suspend, gpmi_pm_resume)
> -       SET_RUNTIME_PM_OPS(gpmi_runtime_suspend, gpmi_runtime_resume, NUL=
L)
> +       SYSTEM_SLEEP_PM_OPS(gpmi_pm_suspend, gpmi_pm_resume)
> +       RUNTIME_PM_OPS(gpmi_runtime_suspend, gpmi_runtime_resume, NULL)
>  };

You missed to change .pm =3D &gpmi_pm_ops, to .pm =3D pm_ptr(&gpmi_pm_ops),

