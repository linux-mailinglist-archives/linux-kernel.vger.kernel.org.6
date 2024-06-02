Return-Path: <linux-kernel+bounces-198255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C498D75A8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9294F1F22B3A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DC83C092;
	Sun,  2 Jun 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnUASOQl"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDAC20332
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717334502; cv=none; b=jIQc7858sSkJ5tnqaAnhZYE/kMJNNl58lMmnOBBRUJDKdFcQ7wg3yCvRbq3akrs/c+m8xY/gCwoC1M4G9Ke87N+4ofjgCDlud03NN6kVr17QOPqNtH88nUNL3cMP0dq4h8XoQ1k93yLvzMZIpPW7GYCd2ryDkuqWQVuoR0psLiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717334502; c=relaxed/simple;
	bh=w9qAtj/Q6OMUm4l3FP+hub4S5StaD/SWZRWY3ZBKnIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRjAPqWOgNL9DovJhje54BkPDO8KXq7yIPGgGtdJwR/m3IJSx0HH7fj00KweaOoMdncq6WXTD3n5rlrDQj6j25bonolApXU0H0v+xZEBU8roWh/cw+TpuRGGgGAiTXTB780gavLCvGgP66nIgqKjpaVmgVPRrZlXMWN5Xm+Hfp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnUASOQl; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c2083b00cbso105415a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717334501; x=1717939301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9qAtj/Q6OMUm4l3FP+hub4S5StaD/SWZRWY3ZBKnIk=;
        b=VnUASOQlTeSx+61K95tAemOpIWm2oB40EEnOIQWlVWp9dDiRNjzs6seRhDMS8Rk+7i
         cOWRlh6sm4RrNj0EMeDwExZgyDzI5tfKED285jwrCIytMHt4dCXeE2nxt4ETkDX+43RF
         AFY0UYWY4tOAYQ3qm5xSORrXQD/r65oef5BtD+Fh+el85IFzo8EKapJXGuyOmdv3kegQ
         mqqGbi2CDNeg7C0joxLctb3fHS78/sXslhoKhV+9/JmqZRlF2LgVYy0+UYH13v9CU4X0
         z+faj78ttnFVH/lHweijKWdLvQ50qy8Nxbu8kbuJ1EZdXadyK3lve2kBUf/he45p6zki
         qqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717334501; x=1717939301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9qAtj/Q6OMUm4l3FP+hub4S5StaD/SWZRWY3ZBKnIk=;
        b=YBxnNZEAu3pxdrfbX6+CtdXstHAH2zy5PNG9LImMYYRXGTh6tKKw8W43Ei2Xekqzz4
         KlBNoyrGpiaBb2eViPDjQD8WSRJJEfqw5XVQteRwILjZCeQazDAOGzrudyUKHewe/Kx9
         euSgmKiPggLVatyGnPAjY5j0XJ5wBz2Ow4UCwYknO8MDXR6Nb40ESoqswjGuX1JhhVBd
         1JKZJe7mpNCK7N/stNXtOR2uE1pBUtbEaoeDTDrXgZt3L3kvy5NHIrpUS/qi9xSJm3fk
         iE8LUO9x3qTnvdApXbFBOXA26qeC4LOFbtGR3K9QzEXx9jpY9xXgG1FW8lBh78VtDmhU
         xsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP5DOC6P1mdM5cYEBcJHMPfFZxHUMisM3gGuEvDKeT8deTk2fLrqpiHpKtGtf3hjorpx0vno2h6+E2o9TzUxc5R4j4CXTv5LzUIQwE
X-Gm-Message-State: AOJu0YykdAd9KQ6mH7M1btf+ETAcP8dtkTQhOTUL8EyYvSk2oPLr3Ii7
	bAQjkCW4Ro9AL5zytGaQnaWulnk7DZonWLswI/fhTkQji/wr2OSR4MHgzA2xfPUjc4UZ4AdKDEf
	5j26RuS857EmnJGa627hIKN4Ld5cN7bMMl60=
X-Google-Smtp-Source: AGHT+IFxFx9jMlGIxkqoDIJGkMsPnJnWQKdTJk+XxjFR4fcHMa+VR6s2lNNgn+Px80s2ZL4pgkP7iwiMERFEMa04H3k=
X-Received: by 2002:a17:90a:ea85:b0:2b2:4bff:67b7 with SMTP id
 98e67ed59e1d1-2c1dc5da0a5mr5628590a91.3.1717334500480; Sun, 02 Jun 2024
 06:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602-imx-sii902x-defconfig-v1-1-71a6c382b422@linaro.org>
In-Reply-To: <20240602-imx-sii902x-defconfig-v1-1-71a6c382b422@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 2 Jun 2024 10:21:28 -0300
Message-ID: <CAOMZO5DgB6g7wydECav35wfAQ+p+XuYrOC2=8oksj7ALeQTOew@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx_v6_v6_defconfig: enable DRM_SII902X and DRM_DISPLAY_CONNECTOR
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Sun, Jun 2, 2024 at 7:47=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:

There is a typo in the Subject line: s/imx_v6_v6_defconfig/imx_v6_v7_defcon=
fig

> Enable the LVDS-to-HDMI bridge and the HDMI display connector drivers
> used on the iMX53 board with the HDMI mezzanine.

"i.MX53 QSB board".

Reviewed-by: Fabio Estevam <festevam@gmail.com>

