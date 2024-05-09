Return-Path: <linux-kernel+bounces-174366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C018C0DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5861F21CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C5914A62D;
	Thu,  9 May 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nxq+O6Cd"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0014B07E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247781; cv=none; b=JzD2FF4CZIMahi1tEQS08YrtlmOTrz3bmwRVqeErfMAwt3GSs8In/gmuAzL4HPCbkAmCqXDYjhsNzY6oQzHVMbhFkR4Vr9pCnm5UhFGmB/1I4BFrkXKMNytCpIGbqZ/o7Caut3YsKukiXnKMZ7xCMcEFjvYkE5lCm0OooznZvMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247781; c=relaxed/simple;
	bh=EchUUZEpVdxWYG9v+X//dgumXbpbfNfvzZDvSwBAEE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KmRUrnzpbXIJkTQrc4W3Yyiei6O/rEqXzGcgGKGMoZ0gm5MswqrEs7MqMU1cJuxMaKmjcSIaVNYgCYLY476sRke4Gn+zejvB5QoNbT40XAr470Wb1pq29vph3yUhrnD650FSfdmrkJe2YV7jKUjRKrecgUgCF/W0ABM/2aK3Kvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nxq+O6Cd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59b81d087aso157572266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715247778; x=1715852578; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTkicR1sEV3OBfABjggaUsI0evFUjsUoA4bSTSDfcsE=;
        b=nxq+O6CdlViE4nhSJHhkPpGuJ3o1UZ54hoixOuNds2kZbLDIF2tyfoRGF9GjwKqvhR
         wKcIuEdh72RR7xRoYFQ+fB0aL9i580Y0eWIFtIaEkvG7ErY8QapDDbg37w3mHO1qiaTa
         04uqXZ46+ocSfOA39OOl7N+qBp7+a7Eyk42WCbjOpUgjY5fcdPlW4UGc809h+FcJka+w
         XWnhVEuFnSCXZDWAykFTRkncGVjyk/xjUxZkTCPDw0bY6ifbSnpjQwtHQIWFDw7ru9RG
         MD2vTUg1swQc3aLfNknLP1lPXnk9yz6VQxDcwAxzmtnbsmA68APZlfJgqL2fwdB2Ce08
         vTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715247778; x=1715852578;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTkicR1sEV3OBfABjggaUsI0evFUjsUoA4bSTSDfcsE=;
        b=wkJ/pGNlbPgQzmNGm9x4zbdQEC94Es7YWOUWi/1BdKZuqlFkmOVmk8NIzg3fB4l74h
         FxpdQ/4I5MVb1WXuA4vs5I8A4p3lZzVsvx1bfu6zp7uwPMvQ6wMslcdPyLN03mIGhCXM
         9bQMa1Qizv5KCygRyswbLF7pB+5UskvP2AW+33pW84kVtydUCUSveR+SL/aJSJtUWLax
         LLbnAo0NnLuGV3d86MSlkTSopvLUae4Mk6MJ09uA9qiJ/WRei6/ADTsmWLx4Cgj1aDKD
         R5S55/pA5YndJYc2qPDqAxd1COYHHoP/JlFrwgFsgnkT+jhafuPsbrEnT8SHWQqUbcn1
         Y3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCWU14+Zjkx/Rdf/1y4Em2ogd/rO97flSYFDCfi7YDlnfyHRBUPm/QLSWv4S40YdnJDCLqLyBTe4jCqDlK6I4FOR0D44ia12hHRgRB
X-Gm-Message-State: AOJu0YxXuqUFehIn4wX5qbZv7887aOC1PigdTBF/hdgCWLnt4k/YsIxM
	q2Gm78Qy6nTiRViWH7vTMREUn3eXDJLjmkTv8TRPn3TpSuXhvbRSqyiJeyd82sU=
X-Google-Smtp-Source: AGHT+IGYafgKWetCTM0mPDVOlm9Q00r3PzQyFYjo1XX4/CRG6bjQtVBFTqgbss40dJcGNs/5PPddDw==
X-Received: by 2002:a17:906:33ce:b0:a59:d1c0:3df with SMTP id a640c23a62f3a-a59fb94b473mr396836466b.24.1715247778273;
        Thu, 09 May 2024 02:42:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7deasm53835666b.103.2024.05.09.02.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:42:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] dt-bindings: display: panel: constrain 'reg'
Date: Thu, 09 May 2024 11:42:50 +0200
Message-Id: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJqaPGYC/x3MSwqFMAxA0a1Ixi9Q/+hWHg6qiTUgURoRQdy7x
 eEZ3HuDcRQ26LMbIp9ismlC/stgWrwGRqFkKFxRudp1SAeOoiQaDMkEd6+8YuSAvuGWutKNVTN
 D6vfIs1zf+z88zwuREpIUawAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Konrad Dybcio <konradybcio@gmail.com>, 
 Del Regno <angelogioacchino.delregno@somainline.org>, 
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryskov <dmitry.baryshkov@linaro.org>, 
 Shawn Guo <shawn.guo@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5962;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=EchUUZEpVdxWYG9v+X//dgumXbpbfNfvzZDvSwBAEE4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmPJqcGhCruCDuYDreXxVm+1U8k0Zrhd6+VfqqK
 6VWZEFkKp2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjyanAAKCRDBN2bmhouD
 16GQD/4zCs+NVDuDmQcEXJhpko0VuGgLNGl3D51YjJWflRjKMYJBwP/11V4eh/sQfhN4A1WoLws
 K4XZTnEMJJqA1IavgPdac5/XEZQAV1g1sFy41sproyTZOhbRQ4CxIGEjJZI2G9NABAFGlfUvPX1
 AOYuTEsFWJth8kYEo5cusam6P3FYq1CAKsjlgJtT58XCP5eRgghcLSLrY/P5OS491XsccBEbltQ
 u52TM5iwOqEDE8UPCSkjsm5uLQjoPQSZkQrs//5+68Q7hlTPa8lyG7+YzvmPnX8XS0ozvyL7f7e
 7JYmcaA0GJFNzgtAGoqHduXEClBPlFFFRkT24VW25FQ6psiIB+OFgez1/Qn5qnSQtGfHaCpJn0c
 Dh38yBVoYYTRQnLFgDl+cd+mMserE7S7WjPKL8r2qTPXjiUU/li7VQ7gt/IX6kkv7ksdIuvztSK
 WAT/Bz4uPgIo3K5A+hgtLTKbEZPrfUp3XZSIDSzYVOnUDxQXn1uRcjtK9GHje4gdEOMmRmV7ohi
 qtCwMWCZPzLuaOQ24yza+CcwF12kln9rXOAhExhtnbGE+/31+w44VPbNsa4UHpxv6IAcWL84opt
 YLC1Q5+CdzWeH/Zy4r/yrALq3Icwvd/9nMmEBtnyf1QF3V70I+d1jIbsZt8gQiMr7yhUbmOj2Bo
 uxv8otB4IN2Otyw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Cleanups for display panel bindings.

Rob, maybe you could take entire set if it applies? I based it on
linux-next, so letl me know if I need to rebase on your for-next.

I actually do not know if devices affected here take more than one chip
select or DSI virtual channel number. I assume DTS and examples are
correct here. Worst case this can be fixed later - maxItems:2.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      dt-bindings: display: samsung,ams495qa01: add missing SPI properties ref
      dt-bindings: display: panel: constrain 'reg' in SPI panels
      dt-bindings: display: panel: constrain 'reg' in DSI panels

 Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml | 4 +++-
 .../devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml  | 5 ++++-
 .../devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml         | 4 +++-
 Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml | 4 +++-
 .../devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml   | 4 +++-
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml         | 2 +-
 Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml | 5 ++++-
 .../devicetree/bindings/display/panel/fascontek,fs035vg158.yaml     | 3 +++
 .../devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml      | 5 ++++-
 Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml | 4 +++-
 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml   | 3 ++-
 Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml | 4 +++-
 Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml | 3 +++
 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml | 3 ++-
 Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml | 4 +++-
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/innolux,ej030na.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/innolux,p097pfg.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml       | 3 ++-
 .../devicetree/bindings/display/panel/jdi,lpm102a188a.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/jdi,lt070me05000.yaml         | 4 +++-
 .../devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml | 4 +++-
 .../devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml     | 3 +++
 .../devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml     | 5 ++++-
 .../devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml     | 5 ++++-
 Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml      | 3 ++-
 Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml     | 4 +++-
 .../devicetree/bindings/display/panel/lgphilips,lb035q02.yaml       | 3 +++
 Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml | 4 +++-
 .../devicetree/bindings/display/panel/newvision,nv3051d.yaml        | 4 +++-
 .../devicetree/bindings/display/panel/novatek,nt35510.yaml          | 5 ++++-
 .../devicetree/bindings/display/panel/novatek,nt35950.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/novatek,nt36523.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/novatek,nt36672a.yaml         | 4 +++-
 .../devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml     | 4 +++-
 .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml       | 3 +++
 .../devicetree/bindings/display/panel/raydium,rm67191.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/raydium,rm692e5.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/raydium,rm69380.yaml          | 5 +++--
 Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml | 2 +-
 .../devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml  | 4 +++-
 .../devicetree/bindings/display/panel/samsung,ams495qa01.yaml       | 5 ++++-
 Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml | 4 +++-
 .../devicetree/bindings/display/panel/samsung,lms380kf01.yaml       | 3 ++-
 .../devicetree/bindings/display/panel/samsung,lms397kf04.yaml       | 3 ++-
 .../devicetree/bindings/display/panel/samsung,s6d16d0.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/samsung,s6d27a1.yaml          | 3 ++-
 .../devicetree/bindings/display/panel/samsung,s6d7aa0.yaml          | 3 ++-
 .../devicetree/bindings/display/panel/samsung,s6e63m0.yaml          | 4 +++-
 .../bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml          | 5 ++++-
 .../devicetree/bindings/display/panel/samsung,s6e8aa0.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml        | 4 +++-
 .../devicetree/bindings/display/panel/sharp,ls043t1le01.yaml        | 4 +++-
 .../devicetree/bindings/display/panel/sharp,ls060t1sx01.yaml        | 4 +++-
 .../devicetree/bindings/display/panel/sitronix,st7789v.yaml         | 4 +++-
 Documentation/devicetree/bindings/display/panel/sony,acx424akp.yaml | 5 ++++-
 Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml | 3 +++
 .../devicetree/bindings/display/panel/sony,td4353-jdi.yaml          | 3 ++-
 .../devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml | 3 ++-
 .../devicetree/bindings/display/panel/synaptics,r63353.yaml         | 6 ++++--
 Documentation/devicetree/bindings/display/panel/tpo,td.yaml         | 4 +++-
 Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml     | 3 ++-
 .../devicetree/bindings/display/panel/visionox,rm69299.yaml         | 3 ++-
 .../devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml       | 5 ++++-
 64 files changed, 187 insertions(+), 60 deletions(-)
---
base-commit: b010817abf0197596fbfddf1957bac968facb991
change-id: 20240509-dt-bindings-dsi-panel-reg-a6e7d930b46f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


