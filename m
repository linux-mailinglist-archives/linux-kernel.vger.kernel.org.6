Return-Path: <linux-kernel+bounces-526503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6721A3FF9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E3A7AE9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB83252916;
	Fri, 21 Feb 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb0lQbBN"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8072512C9;
	Fri, 21 Feb 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165590; cv=none; b=sFUPTquAS+S6EGUSMfP7J2qnrIkwy149AJG5/PKaL/Y6NaZKr9+0nW5pnrhr5xQVBNjZxP2k0YkKCdN6eNNRSuCbNpRy7/lnFDO/C/kkSq7uRlC3BN9sG6B+Xd8R5VYhL81FL0meQZa3u5QQ7tgkVrKy3HsYrqjKdouw0NQx2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165590; c=relaxed/simple;
	bh=RPDPvXXCdl5OOS5xVDWyVGfRoFTm67EFsfdf8l0PY2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KTJ8mh2YaWZcU1VKeWrnq2TOUEnboo/FrCKMf/wYwF5R6/4mN2AfGldzLV2/NlWKC+AXsAwnZ9WBQ8g4oaFFKRR15KeEZM+ff3zcpts2lX7ZZI4K6tVPoxmHZoxaTgz7fSPYB/Ap45r4mopWeYNVVyBbDhtC0TR+ThINiaYQDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb0lQbBN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbd96bef64so395401866b.3;
        Fri, 21 Feb 2025 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165587; x=1740770387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/2Y+JVQ+n3qognQWqPMWeNlR2lyIlTcpQrbV4OKmFc=;
        b=Cb0lQbBNPPRRgn2tUSHky3wJ4UzhIFDOghRsvNNB1fAO6Z1QK5kgWMHC7zHWLB2jFL
         N5Hs75aCuqSugT2wPJWwcKu9mYPBbp8tAK4QfOkhJPx9mdu7qTUuum/7DWCin7h9F9hd
         E3v4nRqma77VpK/pL2pLtHSA2H74WkR31NlJrCn5f4FjbK7uqEPB5dr0FA3ZuDfzbTbA
         OnhrWF+NEUqOEgnqBfXeGhb4+rbatHHstqa89cxK1Fhh5MUkOLKc/LIM+0/Vr229wu/n
         vwe6L7Yc+5QuDeEoga68DNXSUGSY8YQbG3K1jGE7xMx0p+J8FKg/3W5tELCxNgjaWF2O
         gNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165587; x=1740770387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/2Y+JVQ+n3qognQWqPMWeNlR2lyIlTcpQrbV4OKmFc=;
        b=HscrX3asKg4wNev2YdD9UxazHSXiW/7qDzQuFkUQXRb8ypMTNapK0BhrSi9+SHRUH7
         gRUcWPfrVNW6YO7V/okijdihqarzWrO1cWWZxu5Hm1ja88JnQVJsBEo5bNtzy1kIrUP8
         TNNjwTnhH2j6p8jW3O9o0VC2P5PlZzs5rvzXVUoefylrMRhYQk+IYxqu/iHlZd/z87zW
         4HuxI1eLGVINmuPuwlS2qn2BnPJ4wQM6MIdImlIwSWuksEIxgSsyqfciqpPZfCMm8QqR
         vyFrXNy7ok5+NEq5P1EzzHt/Xg7bcaLHoqDRso4U1hBiJJnqqwyOYclm4rN6VL+2JcEu
         eWBA==
X-Forwarded-Encrypted: i=1; AJvYcCVYGM63Z1MWntf4NWLL01xoA1ONXMZhx8v7eD39NBf66Oap9dmR1Ky4eGxIar411oaVvaAGpXc3cxehdClR@vger.kernel.org, AJvYcCWCuHZmI4zBUS36RsP0ouWqVxwT+9A4QU1Y556ydOG2rkpeisZi/0pd4cme7P1Bu0VG9WV15wp+FHE+@vger.kernel.org
X-Gm-Message-State: AOJu0YxE09qfyNl+Cmqlzp0a/8ZhJOIwZy/pk0tbzkFfIuX/7ZJMrVWr
	VXuMjOFatYJ0UJIofJnCv9h0tVgRjrkThIP3AZIU0fPJOfQJ7Zpg
X-Gm-Gg: ASbGnctnu3tU0czx2OvcS2z3vJb5ppeb/2clRPvOIqypbV2Qzd1zSAAqTme1BJoxSOk
	/1vu/07fCPIzPl6jNaz8t8cPrGOKfdo2NNrsoykqhB6WnVgnHe6TfgnYRabWVgFGqMXLGBNlmo3
	89/9Oqdm+P++GfsXswXSgbeUUyiTtIDiWq+lRBr88vSEThfk9hLOWVDu3lBmlb1Zr/Oo8RKf5R+
	hJVgh/a1s1+zUkBHk9qeY9Iqajg1vuKXBqHO/Wg8ivin8ykCyM+7diDNQhlrmhChYmoZ9byeVyT
	pk3oheetXbhP2dNatt7AzBG04qnsHFE3KgSuQ8S9kHGHyOf9wEZDs/INHfM=
X-Google-Smtp-Source: AGHT+IF9tApOtHa/eVZuK45pBA9WYfu0ZGkbzV+G11JP6nOVObxv/pxkKji13DPey3g2T7mpP51GsA==
X-Received: by 2002:a17:906:c113:b0:ab7:8930:5669 with SMTP id a640c23a62f3a-abc09a43488mr529740466b.18.1740165587254;
        Fri, 21 Feb 2025 11:19:47 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9cee79fasm995276266b.129.2025.02.21.11.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:19:46 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] imx8mp: add support for the IMX AIPSTZ bridge
Date: Fri, 21 Feb 2025 14:19:04 -0500
Message-Id: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The AIPSTZ bridge offers some security-related configurations which can
be used to restrict master access to certain peripherals on the bridge.

Normally, this could be done from a secure environment such as ATF before
Linux boots but the configuration of AIPSTZ5 is lost each time the power
domain is powered off and then powered on. Because of this, it has to be
configured each time the power domain is turned on and before any master
tries to access the peripherals (e.g: AP, CM7, DSP, on i.MX8MP).

The child-parent relationship between the bridge and its peripherals
should guarantee that the bridge is configured before the AP attempts
to access the IPs.

Other masters should use the 'access-controllers' property to enforce
a dependency between their device and the bridge device (see the DSP,
for example).

At the moment, we only want to apply a default, more relaxed
configuration, which is why the number of access controller cells
is 0.

The initial version of the series can be found at [1]. The new version
should provide better management of the device dependencies.

[1]: https://lore.kernel.org/linux-arm-kernel/20241119130726.2761726-1-daniel.baluta@nxp.com/


Laurentiu Mihalcea (5):
  dt-bindings: bus: add documentation for the IMX AIPSTZ bridge
  dt-bindings: dsp: fsl,dsp: document 'access-controllers' property
  bus: add driver for IMX AIPSTZ bridge
  arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
  arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'

 .../bindings/bus/fsl,imx8mp-aipstz.yaml       | 62 +++++++++++++
 .../devicetree/bindings/dsp/fsl,dsp.yaml      |  3 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  9 +-
 drivers/bus/Kconfig                           |  6 ++
 drivers/bus/Makefile                          |  1 +
 drivers/bus/imx-aipstz.c                      | 92 +++++++++++++++++++
 6 files changed, 170 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
 create mode 100644 drivers/bus/imx-aipstz.c

-- 
2.34.1


