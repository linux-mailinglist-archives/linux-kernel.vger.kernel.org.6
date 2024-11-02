Return-Path: <linux-kernel+bounces-393330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F339B9F50
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58681F21F46
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF8C185920;
	Sat,  2 Nov 2024 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2WzONt8"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FEC177998;
	Sat,  2 Nov 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547244; cv=none; b=iH54wp4cPvkcc0XEyI+RjJG9WQVAP2o9Tp+zjyl11E4u0fRmVGd8Vuw5qHC3AKkKG5AWM8J8dZBGeYS/WfMb/bhehzOGnyDgTh1AP2z+Aqzr9Li/jHa/jHBtvJ8HDBo7RDA/Gbp6ocVItotoGtMIgEEh84NFDVbC4utJteDyCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547244; c=relaxed/simple;
	bh=dusEQMxV54XohT/++ghB1iOLg+9EkuNWqwhLGTg2Qkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGF5is53WlEgPjXD2CNhhqC5JRNzN+G0grSdLP2FY9sFrgNuNIxyyli+T7l13rDHGxiaT2HxgTZsu/zC6TAYjy6DwtaYI3CM3xZuUrJA9znZaGTzG1YfsvJKc88C7GjUe+n0uGt5or6b5zFPQYQi/UIXJBPMVtv2HLU8jED9DJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2WzONt8; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea9739647bso2050783a12.0;
        Sat, 02 Nov 2024 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730547243; x=1731152043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJwVRqFiaLvbfZMx0epyTUOxfCpcBzEpVcmmFC1PExA=;
        b=a2WzONt80YR2sF028T4bdjlr4O1iVQOlsFdMRk5kZ8wcxErHIGod8PcD4tGliFKhuL
         RsLWvkkHHpAlnqLq3qLHlQTGtRLWNpGQ8Y/8k10z29qCzm2dpHzgPeyFGzJQcZOiwEYx
         6IGIvgMfUtgKHw8uFZRdBy+ceQrEH1KJLE07JG+HyXfunD+hRRflAqy+DFRSDq7QVAwX
         pApJ5fo5+5RkeASGBZoBfo7vWjSLw3CrE/xICHIGPOyOYDqTBuUpLKynFJSam8z8ws5B
         A5fJ+sIMSDHXT8I+s8h3TCMtg+1S8ABOXi0+4KbxQ520jOl29NNg9LP1tGyNoEJqReOb
         LSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730547243; x=1731152043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJwVRqFiaLvbfZMx0epyTUOxfCpcBzEpVcmmFC1PExA=;
        b=FPxtyMT02yhK2UKhTDlQfTK6GEcCPxGxQoDj4e2sJeyKlRaitnMxD4TxCx5umFAjLd
         db9pHOYgggqlVXNw3jT2n1vn/oXIYqNWZy4tVCSQIDJ7RGIKaiRVceILEHLoJahizgML
         Xo41bp45W+Y1URrVIqPS7CnPOvcT6b6ipleFk5bcv4k5qtIhYMMv/WomjDzdqXaKTtPy
         +5F0hbJaPRvShpYKiaMh+j2PKuYUXYeG0CjHYLjEQPJYdMGIApfLasguWPfHmWuQW3qj
         mwAigS/VlIRrmWkh3U/NrqYYoqAWlBXc4pi3i+YIs6EiG0+zKh66nK2lF4t8Ys8jygER
         PEUg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ72a4rqgm9Gx7rmso+SPtEPj45Jn6tlPkxOUyZuwUsrdkVQDdX9mXUItEPHxSC1U4DhzUoiu/LlHS@vger.kernel.org, AJvYcCX1O9FxWDAUJMVldFq5fmPPaCAVvUaI/0ex20DZGTN4hm1FfSxIIxvOKPBDULwuhJX26gvXQfoPFfhBryVy@vger.kernel.org
X-Gm-Message-State: AOJu0YwQl2z4fR+r4psTrNbuTAoBA7W2GdgDbW4b6pdzCkE/6/7cEA9R
	cXolRYBtSRF75EPmcoV0oOtV5Eu3fWvi84J3YTLlSPBqneV07Qyx
X-Google-Smtp-Source: AGHT+IHjH3YaQv/7yAR/oDJWHwHW/7AX5VV4a7rQxUbdRITTCl6mcEEMRSpePQiSUvKPeNoACJHiRA==
X-Received: by 2002:a17:90b:278d:b0:2e9:48d0:3b59 with SMTP id 98e67ed59e1d1-2e948d03d29mr7841945a91.8.1730547242689;
        Sat, 02 Nov 2024 04:34:02 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daac455sm4681492a91.19.2024.11.02.04.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:34:02 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: fix pinctrl base-address
Date: Sat,  2 Nov 2024 19:33:26 +0800
Message-ID: <173054635856.778838.205612154809931860.b4-ty@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>
References: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2024 11:43:24 +0100, Thomas Bonnefille wrote:
> Fix the base-address of the pinctrl controller to match its register
> address.
> 
> 

Applied to for-next, thanks!

[1/1] riscv: dts: sophgo: fix pinctrl base-address
      https://github.com/sophgo/linux/commit/44196383a26fcacbd6dcf5a1ab2dd8bf8e4132c0

Thanks,
Inochi


