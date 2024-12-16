Return-Path: <linux-kernel+bounces-447384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C49F3174
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31931887BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33C5204F6B;
	Mon, 16 Dec 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OCq5KQT+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EBB204C2C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355534; cv=none; b=h5FrGanquAi1hU+4Cz2/Ru1L3VUcsyPNphJwOk6lDiFQRTmWnzonARm+12PhZVc6AhblNuV2MvbMWRn8sG6FNsRx71BvDnZ+YfmQqXc1j5p5ViX4OjDbGMjW0KAqXDmMdrO46TU42vviPhWnfDWOtdEdehC+nokUnEA5ekI8bJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355534; c=relaxed/simple;
	bh=7ULigbOnnScbT/F4dUWjmj84HHqc3JQtskvaGcqB7D8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UlLmWaTprtGqpl3tfa++vHe5eAY+RjSGWEN2Knpun8E1BvrcK4Vdc0YndwRhPjbyDGvebqHcYiNivfnpvsn4nHkg4SiD34mivUnx57PhQwUP+GQCNUooxW7i1w1UEnUxpwgsxceF5M23EG4vtrcdjFyr5xxRThsFXXW55MdxC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OCq5KQT+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436345cc17bso17577065e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734355529; x=1734960329; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+mqcC4nUfs+PmDPNc0X6w6K0gFUO863U6TSJc51xeI=;
        b=OCq5KQT+qO38W7l3itxgjkRyrMvcatXrITT4hxtvSPxmQTBGFbSyN9JE3QGXSdxRJr
         y1Jx0u6A4ThPIW9fMEXb+UKxPaZjC0EGhRS0wPUBZsNvCZzNzWHhVnFo7jOgfVkLpCQ6
         /+C6PYUplV2Qa+ZJgkNJzFB5hUjb/mOXgdoORsj0YW7kwK0JyZFVlS/ziH3t7EzY4llv
         C/8/IcGZvwjhal5pnHclD/vY251aXPeke5QkhB5VJw9mO8gMx04vD3R/YLaOX13T8+z5
         Nx27VUsPkbT5q452wbAPmim6TsFKpuZf2OVVrT7nVGVUlyB1MLYiXXym8YBb/LWtCNam
         TL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734355529; x=1734960329;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+mqcC4nUfs+PmDPNc0X6w6K0gFUO863U6TSJc51xeI=;
        b=e2GOu0Cz/8lM4lwuQPtuC7cH2L99rQ2qgKHEYToemR5m3FuOmjOIOtB5xaPDNIm8S2
         vZCVHgoVX5id6Zra59OiwjwKXdR8Exyf2G9GNfitrtujHF/E0OF3yv3CSm0sl2iQgoXD
         nEEMucdfNxWeHUXDdYa6lcFBlU1Qy9FI1rdtwN2f0U2u/DvalTKFvXS2gNTq1XdSmbqw
         5A/OCM3ckJi2EGLpFYjKG9Zf8Jo8xx7jRCH9Dk5MEaws6wAQWNaQq1r2Q+7efPGHLAMW
         mw0lo9MHO9lEd96+Dy0+JqB+iJQJczya42a/3Cn0uYg/wf0w9Z3anPGomAphmKUjYE2O
         y6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVPDlk41pPpOpajyjnwiOPVIuHRTrP+kE0lO6e4rMmq18TyfhypHnqxIqcwJEEFyjtUhCPRlzw7zPdI5H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycbvuNeE74gePGmvqYJW+V+nRnPkeQZ4+jGAK0dHWyRLge/MF5
	9b8lXBaOAj7I6NXc/nf4neLAxeyNZabrQQqenFJKQhPEOnsB5sYetGw+Hly0UB0=
X-Gm-Gg: ASbGncsSjBGlh55H6MB/6oKGE6L89U0zUMSHzrXKv6so738ekHkWKFuGJdpRoXy339A
	oD3rSgCV4dr9aF+uAzDB8QuLufjiGoeKctT6IwLxgbTM0lmdTq4+T4SDatNqdZrodFM38QKq4xR
	uPH8y70Yd7rQ2NbBhf2nPFRqwBL1Ass5DFLCSmAc1WJV3YnuHba6eY5H29a0532Ny5FkXSgwVmf
	aFVbC9IVlZkTh8SHi+YX4XbC3kcTp6KEPi9SAFW0pn1+yvXRL+E6ciu
X-Google-Smtp-Source: AGHT+IGIyE4iqHy6qjfXtXiJhLI3MnMB4y90ql3yNDbrxX8BJ9U/zPgLvNusMt/FrTysNv6gm8bzUA==
X-Received: by 2002:a5d:6481:0:b0:386:4277:6cf1 with SMTP id ffacd0b85a97d-3888e0b5977mr11178475f8f.39.1734355529380;
        Mon, 16 Dec 2024 05:25:29 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:1663:6fb7:239c:2f51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80601desm8136387f8f.90.2024.12.16.05.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:25:28 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Jiucheng Xu
 <jiucheng.xu@amlogic.com>,  Stephen Boyd <sboyd@kernel.org>,  Arnd
 Bergmann <arnd@arndb.de>,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] reset: amlogic: rework auxiliary reset support
In-Reply-To: <20241209-meson-rst-aux-rework-v1-0-d2afb69cc72e@baylibre.com>
	(Jerome Brunet's message of "Mon, 09 Dec 2024 17:04:33 +0100")
References: <20241209-meson-rst-aux-rework-v1-0-d2afb69cc72e@baylibre.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 16 Dec 2024 14:25:28 +0100
Message-ID: <1jmsgv220n.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 09 Dec 2024 at 17:04, Jerome Brunet <jbrunet@baylibre.com> wrote:

> The current implementation of auxiliary reset controller, with the
> registration helper in the same module as the driver code, does not
> allow to properly decouple the registered auxiliary driver from
> the registering one.
>
> This patchset removes the registration helper from the auxiliary reset
> driver and changes how regmap is passed, to simplify the interface a bit.
>
> This patcheset depends on:
> commit 5ae1a43486fb ("clk: amlogic: axg-audio: revert reset implementation")
>
> The above removes the only user of the auxiliary reset controller, restoring
> old implementation as a temporary solution, while it is reworked.
>
> The commit has been applied to clock fixes [1] branch and will eventually
> make its way to an rc release.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-fixes&id=5ae1a43486fb3febd5ce78da13eb354f16d049e0

Hi Philipp,

FYI, the dependency above has made it to v6.13-rc3

Cheers

>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> Jerome Brunet (2):
>       reset: amlogic: aux: get regmap through parent device
>       reset: amlogic: aux: drop aux registration helper
>
>  drivers/reset/amlogic/reset-meson-aux.c | 85 +++------------------------------
>  include/soc/amlogic/reset-meson-aux.h   | 23 ---------
>  2 files changed, 6 insertions(+), 102 deletions(-)
> ---
> base-commit: 3d99f9231bedcf9acfb965a97645a8ecfa93a40d
> change-id: 20241209-meson-rst-aux-rework-e26c716c6762
> prerequisite-change-id: 20241127-clk-audio-fix-rst-missing-0b80628d934b:v2
> prerequisite-patch-id: 8bf55ab8ba9db1abea5df2554864a2f4f9c72e77
>
> Best regards,

-- 
Jerome

