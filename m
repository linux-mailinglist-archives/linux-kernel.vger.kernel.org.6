Return-Path: <linux-kernel+bounces-293496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640FB958086
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F870284A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B3189F4B;
	Tue, 20 Aug 2024 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jpJmUfrN"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC41C6A1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141230; cv=none; b=ZIKyj1qcJ6YQ0wGjlyjPdRgx26GrxKuYreItovfLHBOifKkQYoh3OCHIy/Sw0QVidnZbXuG0Uc2EZOpWmxi1lKwssTPpxAibxZgA5Zvi4VQTCJVkGQxiHLv9yT/SlGEdYdKOSO+MUzNrE41zx/m5XKzC7+/Y6zgRzEnDEZYIsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141230; c=relaxed/simple;
	bh=YjQggNK3a1c5Nxtby5Wzg4cKRlAk1TEEfQVSC7mhJF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIcxNOUwJi5vYhc1jI37C5vamN0XQzSYAcF5FAryw+OI8Ev44z6cDzXJCHTA3H6uqu3yGfFIaN+6CBkiMVBcGAvYlUMwJEfqak4aRpzBLd0AW4No0NSvZ4cst4T46KKx12vK9j14CnM4GlUBuKTVPctK+aMZ/3rTGgNtML6YLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jpJmUfrN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-710ece280b6so3911528b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724141229; x=1724746029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2IqJ1+bkvBcuO0rX2Lm5C4OmqxXFYhn4ccngQPHsmSU=;
        b=jpJmUfrN1HehffPPNS89CZVvmntTPQqMFUs8YLJmER+I6X5QQbsVJYI1IvVBg5ZzGl
         8QCT43T0t0emWHxKeCaF6gMguEfdrg7yVlBRbUHjy2tlMtBydk4eICkPVrtpqfD4pdwT
         qHWqwX35F8QTZ4njmUFxWaeWETOcdY/7aYn1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141229; x=1724746029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IqJ1+bkvBcuO0rX2Lm5C4OmqxXFYhn4ccngQPHsmSU=;
        b=jz+PEJMDu/xXBaoiHW6PjxZnxxYrJjGRNKw2nLb/wEVxya5MuBY/5O8V/fw05E/mwV
         joeh2fQ67OaMH4inn6wQbjX1O+vlPM4KxKYMRxpsCVcuJhUBr226lMxM1F8uj5FTDOlm
         gmBY05XbtDVv8Riuiz80swz+0lEbTsKnVd0Qdgb5Rk3oTWPKLvSKt3kjozT66oC0IUT6
         /pCxnTZlYYJBuTjNiHbOG9QkIx/XHrdEgCOCaQCSmQGi4J+ojshGQAQPzQ3rlxMe8+HK
         EKvVIThoYRfdQaYDy76k370xCIj42Qv8msK5/ub8TSmUkLhGlsekgq9rhxCxvnOSKJ1i
         PGgw==
X-Forwarded-Encrypted: i=1; AJvYcCWrMxCIV+e4VyFJx0EgFB8tzYposkQPMC28Y9LgTdsmNceEJOtvcinMd9QhyGftww3ZXXBLoI031j/llxXJLfXSy+eyASMhvlg/RBta
X-Gm-Message-State: AOJu0YzmpsgeuJ2sApPBPj5DDSRBTF+9VRQupqrZqJ7aN5MKHomUutEa
	ON/38n1hcjWKAeR5dVtI6CeufPyNKxM3FrdDFDM2xqMQit1DPGhygNH+iqTwqw==
X-Google-Smtp-Source: AGHT+IFsp879gvOCuiWqNYPlJhONwAUWVejcI/mL94YGseUTQfzsKn3hYBaN2GBrQLgP+qt+XwaKyQ==
X-Received: by 2002:a05:6a20:e68d:b0:1c3:ff89:1fc6 with SMTP id adf61e73a8af0-1c9050586f7mr13067519637.53.1724141228509;
        Tue, 20 Aug 2024 01:07:08 -0700 (PDT)
Received: from localhost (185.174.143.34.bc.googleusercontent.com. [34.143.174.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f0303435sm73051755ad.42.2024.08.20.01.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:07:08 -0700 (PDT)
From: Rohit Agarwal <rohiagar@chromium.org>
To: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com
Cc: dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rohit Agarwal <rohiagar@chromium.org>
Subject: [PATCH 0/3] Devicetree updates for MT8186
Date: Tue, 20 Aug 2024 08:06:56 +0000
Message-ID: <20240820080659.2136906-1-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series updates the DPI node to add power domain and
adds the Mediatek SVS node as well to MT8186.

Thanks,
Rohit.

Rohit Agarwal (3):
  dt-bindings: display: mediatek: dpi: Add power domains
  arm64: dts: mediatek: mt8186: Add power domain for DPI
  arm64: dts: mediatek: mt8186: Add svs node

 .../display/mediatek/mediatek,dpi.yaml        |  3 +++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.46.0.295.g3b9ea8a38a-goog


