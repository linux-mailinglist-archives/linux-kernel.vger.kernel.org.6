Return-Path: <linux-kernel+bounces-376409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7579AB0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87E2B23223
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355B1A0BE5;
	Tue, 22 Oct 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cb/mlrbN"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF31A0BEC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607785; cv=none; b=nfwPa2tVd3ADksf8voFL0S4MWiLiylC2p2ef4Meyp21VH2jEkXap8ebKPl/M69gyb0SZVraNRGnwSF5Fn1gdhYYdzk719kCXBoRV5GQkCvUyXmviwVOSgPA3Mn9ojJsaJ/noK2KmsC43FM4mTcn7KYo7QBpoOqN24bMEpOijD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607785; c=relaxed/simple;
	bh=XPTt/DRcxaXM3jq+HjKo66FdsyRj2Gi2+pHUZZljpsY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pt+jKg5VfIV5VCNYq1bxUbEt24E66kzHqmjiSHJWrU8VMMCd5Bz7CEgzOXVe/j6IuExwAf4EKjX6CSF90wuI2Pa9KfbDFF0gi9QWyK39G2wIkB62g/vKVxHnsPxmseR/iil9aTMrFyIaoddZFSGbcFq77phsuLRxiEpD+oTLgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cb/mlrbN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so63010645e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729607782; x=1730212582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrUWXWfzIj5zJMMGxBfqh3qOh40//ZAdcEGnfXtiphw=;
        b=Cb/mlrbND1Pa/nKp8ElOnPSNjq1przHnZgJHUbzUL2QqqyLNm6PXZSa/1QMPFPA1jM
         ivYSTZGdhtHAxl6sZ4QyWv6L3krWAjSaVVQMvwOlaRdXZ49dHt81tSoETuzbq2KQsIkC
         Gj9IeiIiRn987DiE1/BU4z7PzH1xXIzpVA92Dq0mJtHftEsZ6UFrmQqEYRK+9dKbkZzQ
         WLniMhNEr1jVwLrdUSJ8rCFMHVo6OSdG0S42y5HK5Xfgx23RpCXOYOPGDIJBv1Q0UMZ0
         QBpl+6NsTkmVIr6d/XIpBpxDg13TTFeLWo5JzG2ZjUHupeoPX/kC8Z/i3+Pt3gZOwy0L
         zT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607782; x=1730212582;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrUWXWfzIj5zJMMGxBfqh3qOh40//ZAdcEGnfXtiphw=;
        b=hts0EI15Wh7+g/p2Dk8OT+zVNeZeSgtJAPdI6Zarc7sMUXFPtH5MVwP0oXBQ5yOsYW
         7GFG4gg0IXbhAy9SrwyVqyNVwe67u9+F+jwG+ezlYT1tVtnqtx+GhcmRzJsovA/T2efb
         6PyR8PkHA8f4ADwnoU7At/mXcutWvBicmxoUjWEwfuHZ+Y/kOnMtBoGs3E7zwcH7CcB+
         Pgq5aCo7EmJJVYJKq9U0rr+2JCcanepi3AtLJgMVpKOlgawhoSxW5IUjT6ZQYylL+o+A
         72Wic0gPbP0o+gxl5I/bbPZ9byIvnJH7zMlfvWrdGxwZ8YfWGDoEMRvCU3gzG/wy++pR
         TYVw==
X-Forwarded-Encrypted: i=1; AJvYcCXleZYP/7fUAOxWDZnkL7iuyDM8fD5jSurb1VHuOTwD3saXDYQhswCfQ/PHPutu7/Vb0L6Dm5uNffuyQR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAKpgIRl/VrrvncFwwaDvsDVHwZ+97qsjHLlVIlDkq5xIM79A5
	zuUR9iqNvjjNpwGzdcZCGCopAp6RUy7UhIlRuJpXjhc6x/FI3MtOJ0s8979qZ0Y=
X-Google-Smtp-Source: AGHT+IH1gDK1/uDRHCxw8RYMyjPcimj1r1WhkfVOpVJ9j0PYqU0pkA6VBIa7LJdkDoJQNlhbE2+Oig==
X-Received: by 2002:a05:6000:c85:b0:37d:4e74:68a with SMTP id ffacd0b85a97d-37eb5a59780mr8701399f8f.46.1729607781629;
        Tue, 22 Oct 2024 07:36:21 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a47caesm6723587f8f.28.2024.10.22.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:36:20 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
 sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 festevam@gmail.com, Richard Zhu <hongxing.zhu@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 imx@lists.linux.dev, kernel@pengutronix.de
In-Reply-To: <1728977644-8207-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728977644-8207-1-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v5 0/2] Add one clock gate for i.MX95 HSIO block
Message-Id: <172960777824.2281007.10515356955760469298.b4-ty@linaro.org>
Date: Tue, 22 Oct 2024 17:36:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dedf8


On Tue, 15 Oct 2024 15:34:02 +0800, Richard Zhu wrote:
> REF_EN (Bit6) of LFAST_IO_REG control i.MX95 PCIe REF clock out
> enable/disable.
> Add one clock gate for i.MX95 HSIO block to support PCIe REF clock
> out gate.
> 
> v5 changes:
> - Rebase to v6.12-rc3.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add compatible string for i.MX95 HSIO BLK CTRL
      commit: 731237359d83bfb4f27eea5b7a8935af5c72a5ac
[2/2] clk: imx95-blk-ctl: Add one clock gate for HSIO block
      commit: cf295252f0d88410d5793fa6db56a7192a65d66f

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


