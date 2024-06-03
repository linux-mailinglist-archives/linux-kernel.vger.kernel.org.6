Return-Path: <linux-kernel+bounces-198519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E678D79B1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01D4B21187
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE2023CE;
	Mon,  3 Jun 2024 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm5uLn6e"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C715C3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717377682; cv=none; b=bWXdxEnSkFLkhhtLWllEcjbIHjb3ujkxxmEXH/cvyWw6kAy8RgjPHqfAAUovVnMvH9hUf9FAA0anp4pWmbVT12zm/CunC7SPn6wj6+V8ZH1QdMjcv9GG/QLCk8fpKEeo4EkUDQPdo9vC/5/sIyR877l2iJkX69GK29eR+BGkkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717377682; c=relaxed/simple;
	bh=RB/1U5likLlZjGcsFz7Qbp0mPYupPUtUbQd1IKDqaCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gd+b3UmhLLni+MQ7F150vpTxzWdi8BMr29CBGcIdZMzhMhxDFL6Xo4ngtoqlT5iVGIje3moDvrkpHWHpuOYsqas328UaN9rwnBxN3AdIpmKCN2DzJ6l/gPDNKQLEPnAnW+9A9gnT5w0gMQiAx+0BTFvqd4PRE2I4aU3KhBd9mBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm5uLn6e; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c1b39ba2afso466508a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717377681; x=1717982481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB/1U5likLlZjGcsFz7Qbp0mPYupPUtUbQd1IKDqaCc=;
        b=lm5uLn6euST553wGN7wT75RRmQfAkrs7PlKA7x364UAOvoUwTfP0KFgVVOnrcf6jI4
         iywe2asDTqqgaLlfMcOrn7NIAzY0RmL7qAb5Sf0oj+jLtmBr52w3mgtUNnnD9T/VYP03
         hiPs/ihcaXqVmdi9uatan3b8qtMrkM7E+Vc/BagxKJjjiRu/5vt61ypmwEGbXoBfr4zR
         zlL7xZMpRUDQJrHeLL9N43ERHEe3/ZGOj4GsKTbJYRxZ6TVEj/ss9dZeQylp86ejTPih
         vKaSwTHVa5EJsX8jfT5GmSHzXCGvnb+CaSIiC7p0Ah7aqTjftkSGBwrHM/iHkmaHNYjS
         xgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717377681; x=1717982481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB/1U5likLlZjGcsFz7Qbp0mPYupPUtUbQd1IKDqaCc=;
        b=l5+h6cKv5CinDXKvCyqVHiDIrF0Yni396wpxipfeQZouZr35u4euL0AeNvw4jJxDw7
         310viKl+K3X3lmXBm0c9B/82Zboz0LIkLnCjgzX9Bv8MSNh/ZL7vPJyceMLSlJR9KakY
         zpr+v44Jz/7jQnVdpv/REilcwJ/OBHgj+tdJ2nmg1gQODqL8cdbk4vbK+79XVugq2Hm3
         4CH0Cve7RLTjwWLY0jp8mZ+74yF+uEV61qPIryBRB1o4SUlFiJbPRocQDcAR5KWLchO0
         JjGBWNIjgKWKQbo1ZnTfhZNBcr9mCpvMp3eipGowGmcJDoAaNvcHKLES1LdySOkge9Ol
         PAbA==
X-Forwarded-Encrypted: i=1; AJvYcCX1+op5G3MGIeflVihm9q3r5ktNBVzz6yWRbagsIa4XSVFOriw2/66yDNQYCudCuKLyFyeHiJXUsdwE92COHCT0HSv/vL3UXsp98U5g
X-Gm-Message-State: AOJu0YyGlvnYsIpUgqTvZrGual8AoFAxS+B2J1hIED2+yz+Bm3yYK7Bq
	J/xq5+STp4UC5AKd0hO+OEOrMt3TI8zUTvesunMAgV2/k5j+9J1SvVNaap11Swsx1jgm6k2N+H6
	SoxTRqwh5reMIl9A0Gc2l6xZTEupsjrF5
X-Google-Smtp-Source: AGHT+IEQ4+gCYZIxRVWNCVYikIHZG2pVsK+cvUdVg3at5qIdoRKL0iaJ+Kmr2owcl9LUQ1cw6e48s4phWMuKRNK7xmc=
X-Received: by 2002:a17:90a:5984:b0:2bf:eddc:590b with SMTP id
 98e67ed59e1d1-2c1dc5608d0mr6801201a91.1.1717377680705; Sun, 02 Jun 2024
 18:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603-imx-sii902x-defconfig-v2-1-a39e442011ae@linaro.org>
In-Reply-To: <20240603-imx-sii902x-defconfig-v2-1-a39e442011ae@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 2 Jun 2024 22:21:09 -0300
Message-ID: <CAOMZO5BSPzeZ-uY5bnkf4DV6YZvdm+jgwWQS9AESgx3Jx9dhyw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: imx_v6_v7_defconfig: enable DRM_SII902X and DRM_DISPLAY_CONNECTOR
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 6:09=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Enable the LVDS-to-HDMI bridge and the HDMI display connector drivers
> used on the iMX53 QSB and QSRB boards with the HDMI mezzanine.
>
> Cc: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Fix subject and commit message (Fabio)
> - Link to v1: https://lore.kernel.org/r/20240602-imx-sii902x-defconfig-v1=
-1-71a6c382b422@linaro.org

Reviewed-by: Fabio Estevam <festevam@gmail.com>

