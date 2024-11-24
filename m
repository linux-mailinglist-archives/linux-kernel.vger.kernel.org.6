Return-Path: <linux-kernel+bounces-419369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F227F9D6D06
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92498B21324
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD09154430;
	Sun, 24 Nov 2024 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejc5JpM7"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B61FDA;
	Sun, 24 Nov 2024 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732435383; cv=none; b=t1M+Ocs+fNne6oB5zdmtEv8ToWIKJicTZA2nR2AuP5NyCBuLE9bQMxojEEz6zsjNBcbHIyVcwe2hepNBwcbsZKNexcLQRXf1cgKjalqvxUHS8EXjGtVS7nWQpvvqNuN9n1T2hFnpW3wsJrXBBPxWGAD1WDXL9XG/U9UG0/TpF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732435383; c=relaxed/simple;
	bh=yc20nLz8V7uN5zp1ghLp7wDSq/oWJTT1AFi9ZmwHwSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNgNk2H3Evrogjlq6JabcOxn5CuE/fxSbG0kgU8yBmTLtRdyDZhAn980T0nAVn9KA703hs6bVULFpO6kiL3cUXsfShe4/FCFhfcqNDKaW3CKbpq2fiaItU7EYnFRbTAdAp27E83ga9m0gf/wFgaCIiOP/zMtaUw14uMtqaO0u5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejc5JpM7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc2dbee20fso71213a12.3;
        Sun, 24 Nov 2024 00:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732435381; x=1733040181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=okZX6pXA4mfS/KAXJ+4rw/o+tdcSDmzhi/SRAL4gwz4=;
        b=Ejc5JpM7KYInPB+NzdHpKCAMa7RqVp+iPCtO5opwbxVstF8KihxFiGPYyf0idvTxls
         0AhAxY/WIAVhid2hgacnmm6VwAQNSB9TOWVCtdwJ6xKNu1QDP+ftOPBJu0noVmfhPlYY
         bzRo857JjtSKfNZRLx/KoLKz4tzZiMH96EBrtuW5Y4v2SHj8wvOYCk4Px3YwaUX3APL3
         5wtTocsQnYNAkMAfnClYoFhHP0IXWsbhcFWartwyHHvDYxtyY6USsOiMCoW0LKT4s3Bb
         JWDi1lCQX7MKq1Ay18SGmgRgJUdJnOEtSiL18LqQanHmuX0BMfgtwaDyKpCsY5Ve+otK
         QTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732435381; x=1733040181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okZX6pXA4mfS/KAXJ+4rw/o+tdcSDmzhi/SRAL4gwz4=;
        b=YK2yIg0X0ybPPWBPFkc9S6/D3AddX0qPi3V7Nt6Yjp+ZJD4fV4TPoO3Cj9m3IOElaX
         0ksDB9dm7/zaSpDCr4PXc1TTwv2DkIFjvwPY4ak/AFyrpJ2o0v1vQ5D9MsLgTHYsIw1t
         6fHOhbKnPIKCuRsguU2GKJhdgAa8eLQIxseed61gbsWnY1Fkh2RKC193t12wiGAXZKrt
         ZYYPuxAUCCJF91vMo6dYHSvrLLGpvnPPFqiT7FZJ5FhOABqwr/qZV1ONQ/x40OkkytFa
         hcvdL1F5K4HtRBmGli5vcIh+waQPePmuWC+gFH1hUVy0IQa4AsoEK1NqIhWwe+LFSGGL
         20xA==
X-Forwarded-Encrypted: i=1; AJvYcCWjTP0xj5UngdH+ky2rhAHZTxlMfZPN3t30PSj5N75IrCEEh7w+8QtGFYF/aLYLzfz/yjRrWojz+yDU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/rEbhuHGH1XW6gKdi6FTlAV69smFALBv3HlOeXYXCElo7Ar+
	iTmNe3f3TAFGpl5uACgE7GAVs7KmquPn6bcmv0Yx7I4a5q2ZeRVI4bieggY94P8=
X-Gm-Gg: ASbGncuZYbnD+6wU0TyBxtve10/SBsKuKYFmQxxvtg1wEDKa4RqpegiG9NQbemnygDy
	jjEkCcGoUd0vYGr40JvRv9WFJrx3Bt3dpWg9ECY5u8o5WC33aztDopiyGT0kh2bNlXtbZj3DaWm
	ffkJQARmqtVUbWJDeGHHwy5U8WeHZp1+VXR0BnRRNBxmOK+7t/WTXyIKRJh96lzGPEvIuvYs3pL
	LrjWX8w8rwezMOU7xiVnH1xuK99YiuP6EPa/xRI9GbrbRhfxAikkwZZUmgQXfg=
X-Google-Smtp-Source: AGHT+IFpKGhehrzqjP+Je2lUITne1F2+KG/GZH3kSIJmjMcz3C+YkJc34BMHDi5B9s701wdNb2J8ig==
X-Received: by 2002:a17:90b:3e8c:b0:2ea:7a22:539c with SMTP id 98e67ed59e1d1-2eb0e125416mr11955627a91.7.1732435381155;
        Sun, 24 Nov 2024 00:03:01 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de6f6sm7956708a91.34.2024.11.24.00.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:03:00 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Christophe Branchereau <cbranchereau@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/6] drm/panel: nv3052c: Add support for new Anbernic panels
Date: Sun, 24 Nov 2024 17:02:11 +0900
Message-ID: <20241124080220.1657238-1-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for new panels used in the Anbernic RG XX series.

This patch series adds:
* YLM-LBV0345001H-V2 `anbernic,rg35xx-plus-rev6-panel`, for the RG35XX Plus (Rev6)
* YLM-LBV0400001X-V1 `anbernic,rg40xx-panel`, for the RG40XX series
* YLM-LBN0395004H-V1 `anbernic,rgcubexx-panel`, for the RG CubeXX

Hironori KIKUCHI (6):
  dt-bindings: display: panel: Add another panel for RG35XX Plus (Rev6)
  drm: panel: nv3052c: Add another panel for RG35XX Plus (Rev6)
  dt-bindings: display: panel: Add a panel for RG40XX series
  drm: panel: nv3052c: Add a panel for RG40XX series
  dt-bindings: display: panel: Add a panel for RG CubeXX
  drm: panel: nv3052c: Add a panel for RG CubeXX

 .../anbernic,rg35xx-plus-rev6-panel.yaml      |  60 ++
 .../display/panel/anbernic,rg40xx-panel.yaml  |  60 ++
 .../panel/anbernic,rgcubexx-panel.yaml        |  60 ++
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 588 ++++++++++++++++++
 4 files changed, 768 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-rev6-panel.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,rg40xx-panel.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,rgcubexx-panel.yaml

-- 
2.47.0


