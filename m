Return-Path: <linux-kernel+bounces-535586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F5A474D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40DF57A62DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70A61F5844;
	Thu, 27 Feb 2025 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dq8MLF08"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686A22DFA3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631081; cv=none; b=p1atu2zyklmOLc2qL8UodLYiHeytqkrcHRA++AW++BmWMibhSu0GopQziSJ2v1GK4SiUi/n0lHbj+B451GJO+16jh4cRKbECB3eEBcYEnyhK57VNKByANdGDw3SbvudjelQ57BAqywWV2CSBUfPSCZchH1nowbLugGqey8p7+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631081; c=relaxed/simple;
	bh=+FtkdcKwebMwwWijXZdGjuw30u68u75GZtx0tF0H7xA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ej7Bh2aeQJUKjFGfzx36rkqhwx0ZxK2lYxAvJeLOBSRQ0TWs617F2lCXcxCDOwzCtyxszozu8EU0AWQvo/MB+NFZmPBsogRDjXgn+VfFdIUf9WoOiXAnmvhbJCcyjOsy5QmssYYtTC2qEMdOE6IbY47t1KH+re83G7UFV6KOvlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dq8MLF08; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-547bcef2f96so517141e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631077; x=1741235877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UXkglY36wWDlWtl/BHCk6udvb24Qtv5ABZXv7WU9qc=;
        b=Dq8MLF08Sodxfh5rH0TE+MnAknCMTi9Zv4ooZpGA7C8t/GhmXXp+I95gRf/xYmk/o9
         O/vI0CYMwQHVN/BEYVfLkti9KO0TOGCDDqw8VeBsJ0l14uEHGfDMslZowuOX7AwfaOjr
         z1O0ihy6A20FHop7hpCQEMVFat7n9G1iSGqnYLvComJPdPZBefl7UAzJkmhhDujsHVdD
         jNQMHnCOgkLPAANkOdkhO6hsKhGMs/4tMVAIwEh6sxkLwJ9+dRkGNhaJUu7rRayEBea8
         xoXwi1VPepV6/oNNUjRdPlxCTJPJsEhtYueSEavpdjXu+6+CQoTXojHmeBnTz1SaEhLS
         RFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631077; x=1741235877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UXkglY36wWDlWtl/BHCk6udvb24Qtv5ABZXv7WU9qc=;
        b=TtpElXEbdN1WuBtpnJNYfQPJIRFVqQzfF8/bzh4Gmwg8HuA9SCXLp3w4td73bCI/Lq
         hLzuk+09sH+3+pxxJtkrBBjMVTlGznT5s2igPlfCy3xPZrCX0UFkTiDSIwrY/dJg0cOJ
         yYl87cfsVbQtyJXPP+QF7a8nXrrWYJYsLOqo4ESSxglWuuLzrsTQ/MQHtNEyCtAinGo0
         Szm3+nupu8rVSrkmXJjZwDGnqk1r6oOC+JDBRx+bNR5hOMGI16I+Av53qVLV7rXNCkgR
         1T+9/kMuiRuXefPtoY1W/6vXV1an3+nfflxL5A8ZqpjBPVlr/PSXP/Ny+l7ATCOiIBr1
         MwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE22zn9O5LiKfprfMId8NJ9ucEnJDxyWTDNoVnUUmIrGU0dRJql5LvECMtTbOMCbM+W40KcDf84fjVj0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlq/gJon9VLkeGqSYrTDoWmaw97VsG1ZwT2ShPCVhDvYgBtVA3
	PLZUeC+eCXQT9BU9MZ6CeTeXU4jybKdUnTC2Xu0QNXzN8LDP80eDLlgbrFLz1PI=
X-Gm-Gg: ASbGnctw2peStoiEPxCw8hMBLLZ4rgG3lPmqDhvJIt8dAmyzSg2nBYN6JI0QRg09hkR
	32DEYh2X4NIwS833LzDs7e6xZtYV7D/hcEzF62UxVP3YUKA64cZzu3UjZxFiYkYNqMwyl1xKM62
	O5edNbyoUmNB4dBytiaTr3viYdjvLi4HchtT0xm+UkmHmcpbqxLYKYA+M7RP7l0oVPGZf3nJPtK
	uRAYub9u5YJsskYk0Hg0pI6NzNVjvkvfeNFtIbALjYoBDR4AnLgTyxfMNyX1KtynJzs73QZ29ca
	PJ4lXW5aq+/D1CQ/62RwxWlTnJxoXH7ocJHaunJ3tw==
X-Google-Smtp-Source: AGHT+IFGmZMN8HiHF0dUQ37JUE6cIWIJ4a/etc3Mst5jjknmhWL9hK7goaPc0rslMBYFrA3hJCn4bg==
X-Received: by 2002:ac2:4c4b:0:b0:545:76e:322 with SMTP id 2adb3069b0e04-54838ef895emr12381337e87.31.1740631077556;
        Wed, 26 Feb 2025 20:37:57 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:37:56 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Marek <jonathan@marek.ca>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v5 0/2] drm/msm/dsi/phy: Improvements around concurrent PHY_CMN_CLK_CFG[01]
Date: Thu, 27 Feb 2025 06:37:30 +0200
Message-Id: <174063096227.3733075.7538565845819141467.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219-drm-msm-phy-pll-cfg-reg-v5-0-d28973fa513a@linaro.org>
References: <20250219-drm-msm-phy-pll-cfg-reg-v5-0-d28973fa513a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Feb 2025 17:23:31 +0100, Krzysztof Kozlowski wrote:
> Changes in v5:
> - Drop applied patches 1-3
> - Split part touching pll_7nm_register() from last (#4) patch to new patch
>    - Thus: new patch #1 in new numbering.
> - Link to v4: https://lore.kernel.org/r/20250217-drm-msm-phy-pll-cfg-reg-v4-0-106b0d1df51e@linaro.org
> 
> Changes in v4:
> - Add tags
> - Patch #4: Add mising bitfield.h include
> - One more FIELD_GET and DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL (Dmitry)
> - Link to v3: https://lore.kernel.org/r/20250214-drm-msm-phy-pll-cfg-reg-v3-0-0943b850722c@linaro.org
> 
> [...]

Applied, thanks!

[1/2] drm/msm/dsi/phy: Use dsi_pll_cmn_clk_cfg1_update() when registering PLL
      https://gitlab.freedesktop.org/lumag/msm/-/commit/de36ea80b303
[2/2] drm/msm/dsi/phy: Define PHY_CMN_CLK_CFG[01] bitfields and simplify saving
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0699018b41d7

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

