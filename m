Return-Path: <linux-kernel+bounces-326739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FCE976C68
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9791A1C2384E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2161B9834;
	Thu, 12 Sep 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mab+uNUQ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E181B5801
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152280; cv=none; b=uMjBrUexgHio3scbn3h0+E29qXsKCLAi2tWk1O/CC6uNYvaY531L63aQr7Elpn32EXC8fBmwuhmxn57s/6ctzkP3SD+cwSH6uDs6PtJcH3u5Tdf1prf57wI4i7khaonOro4DkVv/G1yFEUFYO6lVRBhEmKrazEwLjGo176CpdJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152280; c=relaxed/simple;
	bh=ailPSFTxMrNMGHA7HZ9l1aBMXWsllhW7RSR3xtvRlgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKp8162x73NzLyhAlDtgSTky9mWkO6auW8S+PjENJF4Dfb7hls++J2lLAD9wzyCWX6iFPPCgI5HSp8NiIU1aCYSq6rGyocYjiAl2I9SmSvSMoVk8e3zeS/myTiwyY1K+PBE0jpwWdr/Rkxv1v6fB1fLECIRR49HUMSMP2gFmcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mab+uNUQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7178df70f28so776735b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726152278; x=1726757078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SnjQo2l57VNy0/9b9V7jPtL8zuWKJeeYd2oBfdE66r8=;
        b=mab+uNUQPU3h3IBtI8kmp9iQpEIsMxVBb/poFeaP8Mwmq2vKz+nKTFvo8NfxByz3bm
         0z8J4PZSuWiTFvS1umPRyfxMry+OX4u9KQ67ptv78k1FaLlaQoKdnue0TZRtwIFTGdDa
         OznG+JrrJT4nxGzqWuFomejbhNWXrUJKBhPhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152278; x=1726757078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnjQo2l57VNy0/9b9V7jPtL8zuWKJeeYd2oBfdE66r8=;
        b=D52NFIarm9EnLiJ1OpgmM8KhWwIkr9AIX5QvRjOd2Xt1ltsVjR60zU28ooCz8w46m/
         jvLoiKHlYm08VMPqvcBzz0fEun3h5X3F3nrEwzedWNRuZRmkkqfyVXum6w3b2XoKiKJI
         YlXzkx+Wap6uj6zIsV9KkiTf/eRONytwq4xunPKkllnaCsb1AE3O+hvrFmmjKjQkCO5A
         rQMqlCD0sz54Zg3TFv1vIUa8okPmGs4YGZqMP9IUHSh68GyJXOmVHcIL4TCUYy6+NJgB
         RzlJ1iExbvPlZ0JMRp9QFCWj5s/Xl3flvi/TonMl8Pyg5WCDvfoVXIxhg23H87cpv4DK
         5cxA==
X-Gm-Message-State: AOJu0Yxi2Q5A39CvQ3LDQ8eYxkGGLLqAom7dPRUTe4ol1CttVnC1uBAY
	lBI2BfCdX0+0Gtvz2nCiGQ3pewXUN55Km7G+jF5d4LEl8WLPziFl0S8l3gbpWw==
X-Google-Smtp-Source: AGHT+IGe8UZsXDErTlsFVsKEqocto9ktULRfXcWaq34cYE7rYYe0pLbf4dzAsufnELC8pqE5fNjDew==
X-Received: by 2002:a05:6a20:ac43:b0:1cf:36f2:21e9 with SMTP id adf61e73a8af0-1cf76358fdfmr3795202637.32.1726152277655;
        Thu, 12 Sep 2024 07:44:37 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:8638:897f:b6cd:8c44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fdee186sm1826269a12.85.2024.09.12.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:44:37 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>,
	Fabien Parent <fparent@baylibre.com>,
	Jitao shi <jitao.shi@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] Fix dtcheck warnings for mediatek,dpi binding
Date: Thu, 12 Sep 2024 22:43:57 +0800
Message-ID: <20240912144430.3161717-1-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two binding schema errors in mediatek,dpi binding.
The first patch adds the power-domain property to the binding, and the
second patch adds the port node as it's required by the binding.


Pin-yen Lin (2):
  dt-bindings: display: mediatek: dpi: Add power-domains to the bindings
  arm64: dts: mt8183: Add port node to dpi node

 .../bindings/display/mediatek/mediatek,dpi.yaml           | 8 ++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                  | 4 ++++
 2 files changed, 12 insertions(+)

-- 
2.46.0.662.g92d0881bb0-goog


