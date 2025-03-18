Return-Path: <linux-kernel+bounces-566324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF161A6765B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04771894C77
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966E320E00A;
	Tue, 18 Mar 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhxkeC9s"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EC1207DFD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307880; cv=none; b=bMnod2AEiEhhuXFMpqzwtxW2viOWDRctGw+OTrR+NU+wwLZwXYFh29LpJ71y7lMuzNj+kC17TQNJMigbu8SK2On4WQDQa7Yh/xyfvW2aDn4bhbbhTjceR+kDvdBQgUgr4h3T6QbT0uYuvxwya/1oYsMhFDmTPM04Grkz8PPx7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307880; c=relaxed/simple;
	bh=TN/g0dNpgyiWZW2NVZZ9bktD6tyqWPxBAJYvmhVdUAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkeqE5i76M1ir6fYg8l3omoNEbsVxk/p5zfi5wUzYcswAcLs+cxhGxbesC+8OwKova7SmcOOfdZSVhyiHpbFrsDe0sCKEiECsGbj+EDeJUits5I7eLef8l4t5Yav9ocM1oOv6R526/NpSLqLLa/49JmnNfnrulrHsgR7G80BKyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rhxkeC9s; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549b12ad16eso5869588e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742307877; x=1742912677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZSOxfNpsuHJ2r8f2irDmxZoea8ixqgNXdHmJ1iC78E=;
        b=rhxkeC9s4TjuP/hWdIvZ4OTIqlpRxmHQjBBV+PnSNUtwgsdnJbvmGFFlxE0jxyAu0z
         ikHJwc7Ul/LBxgnpeGLDeB2z0yk/TqAM9+1+NfmfMJ2Dv8xyuyhfS+c7iFzM937kb4ct
         qEnLfrzIgLk9zpedUKJcw1q73icCR1zQZQRuVtf6ua4psEw5P2JrVXZa8uoKEPquCr3J
         voImRJD/hLPdJUCyTMPYgz5GYCgVfBFXPxJIvHK6Q0WljxslBlYaPLjFX3cjWth6gmGy
         JZ8ExLw+vG3LMipng1MTMbHf9llMu1c2qvRX8YCyiWoZAY0Cfy6tjbntYEdQO46jbP3N
         atCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742307877; x=1742912677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZSOxfNpsuHJ2r8f2irDmxZoea8ixqgNXdHmJ1iC78E=;
        b=mBHTzyuH3K/Yp4jij1HGyc/zZg0D/rOSOBQkVIpmybxAJ2/ccgME41t7P9rWwqkx+k
         z+3XfGZkA537Lfk4DJtHTdSuCe3QZKqpnuI/V7w8DGoSwcSliQduobtFog34wc7smG+c
         IZtQtb8MgEJXCOd9zOzu5pudMGJEFgH8sd1Zp6W07Rda3rCJWjARzWnsUInXa+/E4mHE
         UDuidtKp/Z/y24CwktdwStTj0ry7HALlcMedI53k0+AG/IM4MKM9/DxG1fZ3jcsRsaFd
         1JE8l754Qrd0XoJro9dcX3xmh3DfJzFzADqxf/0VoG3tyqKhAABHNxwC40Gnu037dWnP
         PfIw==
X-Forwarded-Encrypted: i=1; AJvYcCXT+SQ9DhNjByvDH4ghRvA/Y1lwOgqd3+T9HstWQUBEm94fD2z54EC1blzr6aNa/zoxGOs7UO81CuQqStc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlOeuXgJ7Zcb8jV+mIlXs7oTqmIn+m6cSQsrk0aR2zNZ8hgqc5
	iItuvWnLvOSmf4N3hgAuAXwLgRFGMRc9x/s9WqjC6DZH3uYYTVB1h8+KhuhliWno5fpStnJ5o1d
	oqKF0zjAAjsQBlRDoq7NPE/8ypdYQIx7QUataDQ==
X-Gm-Gg: ASbGncutAysJAsItLR+l4/8u2lQ8lirNGjvP08bTWZabnmNZt8j5MWfeFxQBtw2BoZh
	VY7mOcroYEnozWEh/+NKi2GrrSplM5MdC2nqeznlSxvoTvdm59XVhdCVxjC6fErEGuIfXEgt/bL
	QbHyuLIxvFIlch5nMm1EOILdunRQ==
X-Google-Smtp-Source: AGHT+IG9CQGaGXwj83/CaWY1G56V+6jdIV2m+4yH9D/kfodrFtIHnTXnxFGbiTsYYiGMbs+jAqjCMmoxKtCUTvuxFTY=
X-Received: by 2002:a05:6512:3ba4:b0:549:4416:df02 with SMTP id
 2adb3069b0e04-549c396e65amr9771645e87.41.1742307877094; Tue, 18 Mar 2025
 07:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3685561e8e3cd1d94bce220eeb6001d659da615c.1742306024.git.geert+renesas@glider.be>
In-Reply-To: <3685561e8e3cd1d94bce220eeb6001d659da615c.1742306024.git.geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Mar 2025 15:24:25 +0100
X-Gm-Features: AQ5f1Jpc7dAEv3PciQ-6RFgHdOpEl7a3cOhURtVt1riqmVcpakV2QbZsA1JHrvw
Message-ID: <CACRpkdZXc1uEXspd0EYRE4zBJ-sJGV7H6hPh59ROsh8w_CSa+g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: PINCTRL_AMDISP should depend on DRM_AMD_ISP
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>, Benjamin Chan <benjamin.chan@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-gpio@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:58=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The AMD Image Signal Processor GPIO pin control functionality is only
> present on AMD platforms with ISP support, and its platform device is
> instantiated by the AMD ISP driver.  Hence add a dependency on
> DRM_AMD_ISP, to prevent asking the user about this driver when
> configuring a kernel that does not support the AMD ISP.
>
> Fixes: e97435ab09f3ad7b ("pinctrl: amd: isp411: Add amdisp GPIO pinctrl")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied as obviously correct.

Yours,
Linus Walleij

