Return-Path: <linux-kernel+bounces-350012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF7598FEAD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A281C283990
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88217758;
	Fri,  4 Oct 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VwvMy3vG"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB153CF74
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029567; cv=none; b=aye3qD+C6Ha1Jfxp+DsXRknt5yIr2jfRZ3E1nkYhBO/C98WC17Bi+Q+oDnOlGl16CzSqeEjoZsL5kkmosZFxJXDI7+wuSqb7IV9T2kcX3dWgHQoOTibwxQ51c338t+oXnMMedOsGiu4kFNCs7ghQfqFk1GFrS0LXjxVtuJKs3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029567; c=relaxed/simple;
	bh=8/JLjzSS/BlrCEVwmUnagSnfoKX5LR89PS2pmhF1jrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxbA2wZctAaTOQjLcgD30e7l6MILX8naWRHR4GB3ZQ8uhssX3L/AD0VGeQl4L2lO9o1qKM7NnSftNinFuQvQ3LrWjemOCC6Ca/fO7kxp5hiEws6c2DTsLwbTZYSvdQHikphXCJX1Ch0lYis2y1yLzwtjSszdXF0t3XQi6i5lAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VwvMy3vG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b9b35c7c3so18594965ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728029565; x=1728634365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suc0Mn31X9HOZBvZqGf7HMOAhhfsmvf/3O/lBe/Yamw=;
        b=VwvMy3vGS28LQqGtQmGFnpQvNw5fajuKLu3bG3IrxdoBjBA5od0NTh0s3IhrgginDL
         B6cCCTANN5kTyZHk5wAlYareeQY9feRH9Pmv8+NEAhS4Q0b06OdwyrNZ/3HE6mMBq7Hh
         UcKmBE+oXsl9RGnyqIpxUpdPii9ECaIfMiozo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029565; x=1728634365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suc0Mn31X9HOZBvZqGf7HMOAhhfsmvf/3O/lBe/Yamw=;
        b=P9aqxH1YZ8MuhoZCQfHNZvtG59Vev/7igTH0fgR9ekHYd+f/1m/IbHYzWmKiokR1Pk
         t3uv8MrcDahkVqEggeUzJiOqZQvJBMW6gI1Ixlsrpq9Y+nc56rxd42U+sLaULacyNTnX
         zNjhz1AfbZKeaQ1eR2QEJYBSD4DqJebYtShtircYrQknw4mTBq2ukWe5ceaGPCiYiPXg
         GnkiYqB4iuWpdhDRxukeRbSPdmesm7PeBd96jw4GdnTdVGtnpsuXc+1xSk9PTQRS2FMk
         dBuj/2rBaWLIVJ1E6uzLm7lNLFPsCZRLnABMY3cwsgb6/il652p1sbJD80FMni7dL2I0
         9TBA==
X-Forwarded-Encrypted: i=1; AJvYcCWqZ0j34vtyPWTiy4HIMtjzaj5ST+A+Oq9HhIljtZ/1VSyQ2Pneb+vf050YraKGP3H8un8c3qaj8rp+H1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbi8dHb+3qaekdqTCT5v4eRSiXTmPK6VbofSSXEuEF7e3xIzZ
	vv7PZcMRGPjmMuKOze8y037I4MOiVNq5zm06431+08ReF1McRRIVR6H7ZkIuZA==
X-Google-Smtp-Source: AGHT+IFoAaPoa4+bOiiJGm9uVxI1PYIZfoGl659lJ9EF8peD1VPs7dE5Za5eho+/Mscv1rkg0dsNcg==
X-Received: by 2002:a17:903:2291:b0:20b:b610:bd06 with SMTP id d9443c01a7336-20bfdfd323fmr24619985ad.19.1728029565579;
        Fri, 04 Oct 2024 01:12:45 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:73bb:cecf:e651:2ce6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefad264sm19401305ad.205.2024.10.04.01.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:12:44 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/9] Add platform supports to MediaTek MT8188 SoC (part 2)
Date: Fri,  4 Oct 2024 16:11:52 +0800
Message-ID: <20241004081218.55962-1-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series is based on top of my previous "Add platform supports to
MediaTek MT8188 SoC" v3 series[*].

There's nothing to change or address in that series at the point of
writing, so I decided not to resend it and start this new "part 2"
series instead.
(if I need to update both series next time I might consider merging them
into one)

Specifically, this continues to introduce the following platform supports
in MediaTek MT8188 SoC to lay the groundwork for the board device trees:
- PCIe
- MIPI DSI
- video decoder and encoder
- JPEG decoder and encoder
- vdosys0 and vdosys1 display pipelines
- DP-INTF
- eDP and DP TX
- aliases

Please have a look and feedback are welcome, thanks.

[*]: https://lore.kernel.org/all/20240911143429.850071-1-fshao@chromium.org/
[v1]: https://lore.kernel.org/all/20241002114614.847553-1-fshao@chromium.org/
[v2]: https://lore.kernel.org/all/20241003070139.1461472-1-fshao@chromium.org/

Regards,
Fei

Changes in v3:
- add the secondary MIPI DSI

Changes in v2:
- add linux,pci-domain to PCIe node
- add power domain to PCIe PHY node

Fei Shao (9):
  arm64: dts: mediatek: mt8188: Assign GCE aliases
  arm64: dts: mediatek: mt8188: Add PCIe nodes
  arm64: dts: mediatek: mt8188: Add MIPI DSI nodes
  arm64: dts: mediatek: mt8188: Add video decoder and encoder nodes
  arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
  arm64: dts: mediatek: mt8188: Add display nodes for vdosys0
  arm64: dts: mediatek: mt8188: Add display nodes for vdosys1
  arm64: dts: mediatek: mt8188: Add DP-INTF nodes
  arm64: dts: mediatek: mt8188: Add eDP and DP TX nodes

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 668 +++++++++++++++++++++++
 1 file changed, 668 insertions(+)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


