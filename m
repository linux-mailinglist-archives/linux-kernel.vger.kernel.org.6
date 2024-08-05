Return-Path: <linux-kernel+bounces-274273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 596159475F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76B2B214EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10791494CD;
	Mon,  5 Aug 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg2kHs7v"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4E6A01E;
	Mon,  5 Aug 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842611; cv=none; b=hdB1VNdTLIQETSZOC3z6DUhavnfTaPM91YPEifvA+TO2rkokrQVXc4p9DFSO+6bUe/55cybEugGp+7urgje5IdABzNDUE0Mpnr3Gc1QNRT58pLGQN6qnWAOZ0y2aLXjPrznrqJynE/y6ba9NiiU6jAOiO3zUygygWvkn/N06eSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842611; c=relaxed/simple;
	bh=bE6vT1oz47RyP1ZKna/Yjqooigkh/AXkqnqjBHKb1S8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Os2vWnE+gMZoEkvSyKURBKJQRX9zLjzwOiTLLDUjD1h4J0XruaaLEwr4iEjJK220dy5oyaVXgbOfnJilH0Y8Wk5zqH3Gn8twecnroGN1pzTM2bhTU6UfJkB7jD44tw+n2y6BB/+zyadH61MUfLyfm+Nzs7372Hb69E+oYlV9590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg2kHs7v; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso833957866b.3;
        Mon, 05 Aug 2024 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722842608; x=1723447408; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VL4qgfbSXzVItgj0R+x3HYc3wNe2y/gTIFslMYwu46I=;
        b=Dg2kHs7v5Jv/XhJKEMilJwmPv5BsI2C6JXLp0OfS6LXrqN2E+ypE7sCyWbK9okcxxp
         AC2i1lEhorDVxqqfq2h89e4mBahCo8JlC8mtiGNVQfuzZYZig2QoRYAmqdJQcvsknnmr
         vbEfLQ78p6YUtfNGxScIouk+QoNzgEiV1js7PdgyOjabKzqPGkUskHroMr1Fkb++wfIU
         jo2w71EznNq6k3gCSxaZ9bVUVJF9C4JtXK97/aN9QIz6ZI/+3udMSBzeAWKhQZ0YwVRA
         iZ4hHf05uyvJQFlBPss0ti+YKs4Ei7zksjCGq5K3T/qNN6IajKDSFbGIT3ZZOugLA0Uk
         j3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842608; x=1723447408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VL4qgfbSXzVItgj0R+x3HYc3wNe2y/gTIFslMYwu46I=;
        b=NumZ8+JjfHYroGVdWpFeuKznfGTiyh23dOR2RvRsjd/tkN0VUbhNdKPCRDZ759MIKZ
         cA8lMsaWxtfPIht2oGi8lljhj1CYLioFldPNKf6ei4BEExErJWF+pQwGIbDlT6XG4gZ+
         04pxGpd+BjDJ/bxfaUj1WbyggdLxALMoltaOtH8nSMqvPR0OaKnTqQg6DXVsSA5GWtIv
         HCbYxTg1jXOHXuhobHRHNgw1zebnhjJDJ+XDM7IBDI+4u5Q8cVbBexCekDDiFw0WypPT
         bWaal9P5cnP5EOQjVQR5pC3jSty8LEtZLIVfK9TwzxOb0Nv01djJq/Eh1ogi4QK/JhS5
         dsvw==
X-Forwarded-Encrypted: i=1; AJvYcCUn9xHcLU4dkZu18JJSWI2wMkDlN+VSrFeyh5yaRL9IEVd4UeedheBqn/o3lna0ElqacNPua/pOxH49Ondos7upQDooGCz8cai8eaWY
X-Gm-Message-State: AOJu0YzcVt3apGkgHHEP6DPFzV+HcW+xHxWMcHYzdbJEr5Zw1FhBLR71
	O4p6OoHo62l5JgDcKiBglhN3CRMl9fU3qBNLkIO+/KRsBkXTkfmc
X-Google-Smtp-Source: AGHT+IGxJTB4JXUUeXI44cYYcr/O1U0o6tduXjCfmkAS6HYqaXjObCqNXM+DDrBzgd7UeQHP4eiNQA==
X-Received: by 2002:a17:906:6a13:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a7dc4b3a665mr707202866b.0.1722842607639;
        Mon, 05 Aug 2024 00:23:27 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3bccsm420199466b.16.2024.08.05.00.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:23:27 -0700 (PDT)
Date: Mon, 5 Aug 2024 09:23:25 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Cleanup Spreadtum/Unisoc ARM64 DT
Message-ID: <cover.1722842066.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series contains various minor cleanups for Spreadtum/Unisoc ARM64
DeviceTrees. Also contains the 2nd patch from the SC2731 MFD cleanup series
to reduce unnecessary noise and make these easier to apply.

Changes in V2:
  - add 2nd patch from the SC2731 MFD cleanup series (1st patch was dropped
    due to not being correct, dt-bindings will have to get fixed up instead)
  - add Baolin's R-b
  - rebase on next-20240805

Link to original V1: https://lore.kernel.org/lkml/cover.1720112081.git.stano.jakubek@gmail.com/
Link to SC2731 MFD cleanup V1: https://lore.kernel.org/lkml/cover.1720957783.git.stano.jakubek@gmail.com/

Stanislav Jakubek (4):
  arm64: dts: sprd: rename SDHCI nodes to mmc
  arm64: dts: sprd: reorder clock-names after clocks
  arm64: dts: sprd: move/add SPDX license to top of the file
  arm64: dts: sprd: sc2731: rename fuel gauge node to be generic

 arch/arm64/boot/dts/sprd/sc2731.dtsi          |  5 +--
 arch/arm64/boot/dts/sprd/sc9836-openphone.dts |  3 +-
 arch/arm64/boot/dts/sprd/sc9836.dtsi          |  3 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi          |  3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi         |  8 ++--
 arch/arm64/boot/dts/sprd/sharkl64.dtsi        |  3 +-
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts     |  3 +-
 arch/arm64/boot/dts/sprd/ums512.dtsi          |  4 +-
 arch/arm64/boot/dts/sprd/whale2.dtsi          | 43 ++++++++++---------
 9 files changed, 36 insertions(+), 39 deletions(-)

-- 
2.34.1


