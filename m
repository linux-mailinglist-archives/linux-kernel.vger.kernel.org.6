Return-Path: <linux-kernel+bounces-335197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF7C97E279
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077121F2118C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA72576F;
	Sun, 22 Sep 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ouR5fHQ5"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8FAD26D
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727022428; cv=none; b=rfzbtCfRZq+6dW70dNzyuUxeWyl+6kEulrW0lWp3RYq3WpKVhL+REa2xk1adxAnyRek2e+yy7Yk1ES+B62bxRqHoRqa5m2QjRsI/AVIC//KBcxgnZ3o4KrpUifzIMFxBuxM1EjSDTGsuUjjRcQ5rLAbq5K9+ugH5QKAPKdkQua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727022428; c=relaxed/simple;
	bh=xpqEnlxsDOwETVe3NJrlbuyVCvIju2wa1IVxLowOk5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XO4qzRthdXS8+ZNvbqY73rq0I3Gx5lm8i0LiZjsLhdbxMUZjiK4D3PIY4g20grNa+K4Zj+TuuuocJ1ATVMDmKvTMwhJPa4Ei1gUgajJW7TqU1YXavjwSK5kGysXaTVNzo+QJKTTOXiW3mXWOPbNeu526OBGqnn+MRZ/keDntIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ouR5fHQ5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75e5f3debso33306501fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727022425; x=1727627225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDY1Rx685xpsDxEMUUtRILc2NYgU/miULZ3NwVaniyE=;
        b=ouR5fHQ5EwcIsYthxLmVyxomt5fToXpPTOCiqmnmA69ZnDn0weQsdbPcfKw0EzZs8B
         zqobZ6zvNVQt3teU43wpaQ1dm2dxXXRZZvtQvw48VFS6bNjB2ppvDc8sohw7yMdHeklG
         TvIRymsNSKSjTTBjSm+TV+Cj5t3b24C5DFlxNKmASvtNt2MRVL+lRN5gzIgr3JsAEKbp
         oQe0IZ+kvIlRQSKtQAGXp9M9ZxhnmpVTEF7IwEkp1i/+wnkse78jBRdWzK8O/MwmupKu
         wd1pVHvs5fkzTS/14fBQD78kw2ozvaLmxxhiCn0LhUaK9riBqM+fAa2bpImSh2N5L7iC
         3h0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727022425; x=1727627225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDY1Rx685xpsDxEMUUtRILc2NYgU/miULZ3NwVaniyE=;
        b=H7ao0+ZbnJR3GIx3BQS3CnshEAxRuO7iKOZ6oK0hn9PT4nJHiFIv51kp1Y4DAdpsRh
         91fL7rd8kYdZeNRW3errAxu1sqYEUtGcY95dkuQWxgUQNtEmQbHPdSUHeusIxCVMlTj/
         7ODR4mcl85fxn4FcxiOtqqR12DqlV9MYt2SiMLzFaOzFolChVYUSTeMWhbYyPGWAYlVo
         5m6ABNqFlRuWvbFrMMUxzCMxmwA4YP6YXYHEy73apR6lk/wOAfVjlWXboBiYRyVqMrhp
         1lEytKxgyXSBATej1CX8UHfucs+ftOBSsu0h7HR0cyx+tWIwrh9zlqx8oijeuh72Q7+N
         wCbg==
X-Forwarded-Encrypted: i=1; AJvYcCV32TkyhtzlE3SYmpF7G76lUylaIBWUry/AePF9jo0rtwdXXKteaAW05N8M/hpJaj1orbWGcle8ddrg198=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoyJSTz87OGYcb1hYgOtMHpe1v+2+Eg3aqv+WhBy0dHIa/VpK0
	8Y4NgvSdnzvbmGRkyoEB9vlhcpWku3hWlwzA6YrcQifigqSPACZbPm4QqfmTfwk=
X-Google-Smtp-Source: AGHT+IFzgViXl1baLryxjIB8pfU38892fW+VxPd/yZA9ZEMdkgBX/TKTyO/x2CPBHUOhIGucSPYPYg==
X-Received: by 2002:a05:651c:1548:b0:2f7:52de:9a35 with SMTP id 38308e7fff4ca-2f7cb342edcmr32442021fa.42.1727022425010;
        Sun, 22 Sep 2024 09:27:05 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d485f11sm26541611fa.111.2024.09.22.09.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 09:27:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
Date: Sun, 22 Sep 2024 19:27:00 +0300
Message-ID: <172702205091.1380824.2685575625082150622.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>
References: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 06 Sep 2024 08:38:56 +0200, Alexander Stein wrote:
> When drm/bridge-connector was moved to DRM_DISPLAY_HELPER not all
> users were updated. Add missing Kconfig selections.

Now that drm-misc-next contains both commits...

Applied to drm-misc-next, thanks!

[1/1] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
      commit: f673055a46784ccea04465b9213e999f7bc5187e

Best regards,
-- 
With best wishes
Dmitry


