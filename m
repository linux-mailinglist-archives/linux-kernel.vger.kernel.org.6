Return-Path: <linux-kernel+bounces-224002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7078F911BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E6F1C23B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134F11552E3;
	Fri, 21 Jun 2024 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ivbd5374"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA915279B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951242; cv=none; b=AARpP5nTMvWIZId0+pMarvPFJzAK4d2mXDaAghR+Zqr/XK0DATU82Ublodmnl1ttv4loClquF+21RWQKVhQNXzgfsM5sqANbXNUVoYE4+WJe2cxAQQjiMErBu0MuouIf11KNe44583SHMX5NPZNYFJnjxbW90dY3LnNbd8oyC3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951242; c=relaxed/simple;
	bh=O6MjZswWxwntHXClsDM9YbpgAlLq+nr38VNJ9W/j6i0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nv5V07lDz/kVdzqQiw+Z5vydyYCpJNd/tm8mODUC23TEivPsPsZh26O3GF4GN/dyh7l2y96eWWnDRfqSb5QsWYZekg6CeXyuJTGRFTODwpUvrWtYTvyHDaW+3dUqxLrPluYKmTV3emwIAzBNZEDj9H1zn5Yj0RF56GRA7EYVwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ivbd5374; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so1600420a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718951239; x=1719556039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRT2G8wEhc6dH4aHQrzIOLEXVG/hN2dtlzKi2u99ZHg=;
        b=Ivbd5374tDuC37JxjpomV/E2UDG/THeUhfRqkigOXwCsPtsIylemiMaACr6zgqTZ/e
         3NdjXRIvAw7eJPLa8vPVmlTRw7mraK8C8G5PbCQesD3AaepBq7cCTlNZayNiK9c8lgz/
         J39gCLbVFyF64C0+xYlmkNJneYnYrjA0BwUA65uEA0fYSz7AZvm71NukDb4Cyo64rzKL
         O3xXDoWwutlMbgODid/nlWNpEc9pdcoB6V+tioIPriq2rx1dYWD1dGnc8tiVUIyJgDih
         +SkCgfKgcv+L+rDfGZqO+5PIzLa8zsd6lxc0gPQ0hMnvn8HoxZmDEJ/EL63rGHxuYovu
         RnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718951239; x=1719556039;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRT2G8wEhc6dH4aHQrzIOLEXVG/hN2dtlzKi2u99ZHg=;
        b=XvahDyyqHkNjS7vhp1VszC+a1GyYd+WLpIKxrQ81t7LMPxtxnzogJTwbP2+xybjZRj
         bZUDuTjCTWLpCu5bpt1rRZHCow1IUT//wmCaEwIzEZIoxySzS+9fgFHUn59XP6Z9oyi7
         tvdlb1jl2QPR0uJI851rj2fvD25AzkGiUnPSzJ9z98V9uOSB2lnSB+p1s+clxt8hkfJn
         1/rp5+S9R8SlUhunms08RXM/g7I0XEESIFCuTRFNwaWTIhlDp6Om3+NuIKmBLTlDcPYX
         7chfRGCiHIjohWkMdq1j6viYJMCrqrpWeyLbfnNF1w5Fo0fMQs0N5WzuqyOsxbSIfbFp
         bcnw==
X-Forwarded-Encrypted: i=1; AJvYcCXWHpiDdR4fXyi/Rj7Dt4Lr8ixMpsICf8kSEksW0wNeSA/jEsUkOATRbZ+GQfl7l/0pk2xy6c9VAw7cr9vH5kHGd2Ux1XQWp9JQq9PQ
X-Gm-Message-State: AOJu0Yzp7ts16sfLyNDTknUac5JsEQsvN2lHCGDCt6gCrSHStc0bl30B
	y1UHqvkk/41TBvaYM3kzkLverLPK/MK+8cdJzs0Yqn+mO7i65iC2B1Nlrq53vg8=
X-Google-Smtp-Source: AGHT+IFAv88TzuxiL/3SxR316E/tKMIQkz0tc9LuhcKrKV31IpsJ52gkEFzP/J41BcbE1yC4bD7EVQ==
X-Received: by 2002:a50:9ee1:0:b0:57c:abf9:e6ad with SMTP id 4fb4d7f45d1cf-57d07ee3198mr3680772a12.42.1718951238856;
        Thu, 20 Jun 2024 23:27:18 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30582262sm470860a12.94.2024.06.20.23.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:27:18 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Sebastien Laveze <slaveze@smartandconnective.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240528151434.227602-1-slaveze@smartandconnective.com>
References: <20240528151434.227602-1-slaveze@smartandconnective.com>
Subject: Re: [PATCH] clk: imx: imx6ul: fix default parent for enet*_ref_sel
Message-Id: <171895123748.3617543.12435143750010864537.b4-ty@linaro.org>
Date: Fri, 21 Jun 2024 09:27:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 28 May 2024 17:14:33 +0200, Sebastien Laveze wrote:
> The clk_set_parent for "enet1_ref_sel" and  "enet2_ref_sel" are
> incorrect, therefore the original requirements to have "enet_clk_ref" as
> output sourced by iMX ENET PLL as a default config is not met.
> 
> Only "enet[1,2]_ref_125m" "enet[1,2]_ref_pad" are possible parents for
> "enet1_ref_sel" and "enet2_ref_sel".
> 
> [...]

Applied, thanks!

[1/1] clk: imx: imx6ul: fix default parent for enet*_ref_sel
      commit: bb2c2aa7db67d0e13adde59c823606eba7bb06a4

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


