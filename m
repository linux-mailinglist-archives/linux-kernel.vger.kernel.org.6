Return-Path: <linux-kernel+bounces-180698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E970A8C71FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C16B22083
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E8E136648;
	Thu, 16 May 2024 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="peMnOZ5q"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA512F580
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844089; cv=none; b=ejw0YPvci83x6Aazwb5EEcNR3+Y5mxzN2kNbUh8THAGFurdEfuOWhwMigenZ3YkKtsoGoh5qMBfjIORBVB+lneH4J8EtMXyDFFCq1I42mtGfUZe4KPAzqTEv6WSJZLPHsWeSxJinmePTW19LZGyo3BU+CVdMbpAYxc/1hiEQ19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844089; c=relaxed/simple;
	bh=Luql+krZmdgHvLPp1Q0NJYL71u7YP89WorhMA3gjZP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foeszRvR603b1WVZrvbPbxhwiDtQGr5p698uubpwNkPIuE3QALK/zFSrCysEY8uSnXfrh40h+iflC7uiSYl2V7z98qqL2UrokktUmkhyrLPA8ZN+3LtY2qut9NehaXUTM3tFpauSSHMH+sYgf6Cp+SpzFC+xZrjmDrHo9+gWn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=peMnOZ5q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso6625268b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715844083; x=1716448883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ykc8X+nmmZoVxXuDzZ7nDLHl9gXoWIqf3Er06OJcnc=;
        b=peMnOZ5q4ZkZCmQPPDLXyOLXVdIMBIv+Z2Tcw44DMg19yLeqe8pDVn1RUGadBDIL/v
         QmQDjlNF2YTQWK+hJgQx4CcnDLw9TG7nSCkpCeiZfiTUv5Pr+nYxe5NEPIC5CMhOen63
         gsyhD5/l5Cjfow1OnW0waTcL0Y66x7UKqiCzlPxNiY6VwHTOGU7Fv2tW2dP0fmP4LEKy
         HoTb5jCisgwKp4Usrwm8qtX2BDPqWQDv46iS7wMh68m4Uz7ylS7M5lL/2bC/c3Z6o4Lb
         6Vm044c4sGFpe03zAtmABRFwcFxCgArkeFNtC7sdT0i23vpEdFLmeQVv8IdNo7M9QVm8
         +vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715844083; x=1716448883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ykc8X+nmmZoVxXuDzZ7nDLHl9gXoWIqf3Er06OJcnc=;
        b=Tnz+ORhNI0WF20gR2GNbpGMVQ+KjEkCNZXMaxg8R3J50Gnmn9BrUfan7o8e/Mhq8zP
         eObhmhN0FYJyuq4v/PPVHYCOwWiiCDNBBiJvGiRPCY/6Nny0KBjrFtluUgeMknk60kNp
         MqXcbm8X51ZuUoEBRygt7HnOm0mbSOirnSJSPYoA7nzzM0ovVk9lK6qEmcoQQQwiQgjj
         Sf9KrmxAB2+0sn4D+inYuqR9Q7F4I17oJZV/vIjXjA6RF4s6TAphQDx4fPcUXYW0gAto
         TVgT4l9MpRcONxBRYOfAJGj0cTb5FaFLiRiqta0UutwP0aWs3TGu09gO3BpC1eaCEqIE
         teNw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Zrn75bk0Tsv0BSOJpg5blVy9v4qeldvwJ9xOItUv83Qn8IT5EuMtsA6bzxQ6io6z+IPJyQzKfR0ZD0SEIFBF7md2kE3Yacuu6CGm
X-Gm-Message-State: AOJu0YxfrouP2urT3p/Bii216P+B2gaPuQdIfJ5C/akErKwJW4wIEhc4
	FnEkl8Hzlg+LfkjrhVboDZWlcu00Pf8GXYReAVg2hkaBHczKSb/G59vznClulzU=
X-Google-Smtp-Source: AGHT+IGgE+hx8R/pCPucaQOs4aOObgTlt+Rwb1dunW29jhy/EcKEoe+E1JmASK4+sCVMq054NdIOPg==
X-Received: by 2002:a05:6a00:9284:b0:6f0:c79f:cd7e with SMTP id d2e1a72fcca58-6f4e015fa18mr22748069b3a.0.1715844083133;
        Thu, 16 May 2024 00:21:23 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a663a3sm12318724b3a.41.2024.05.16.00.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 00:21:22 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dmitry.baryshkov@linaro.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 5/6] dt-bindings: display: panel: Add compatible for IVO t109nw41
Date: Thu, 16 May 2024 15:20:38 +0800
Message-Id: <20240516072039.1287065-6-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516072039.1287065-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240516072039.1287065-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IVO t109nw41 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
controller. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Chage since V8:

- No change.

V7: https://lore.kernel.org/all/20240515014643.2715010-7-yangcong5@huaqin.corp-partner.google.com

Chage since V7:

- No change.

V6: https://lore.kernel.org/all/20240511021326.288728-7-yangcong5@huaqin.corp-partner.google.com

Chage since V6:

- No change.

V5: https://lore.kernel.org/all/20240509015207.3271370-7-yangcong5@huaqin.corp-partner.google.com

Chage since V5:

- No change.

V4: https://lore.kernel.org/all/20240507135234.1356855-7-yangcong5@huaqin.corp-partner.google.com

Chage since V4:

- No change.

V3: https://lore.kernel.org/all/20240424023010.2099949-7-yangcong5@huaqin.corp-partner.google.com

Chage since V3:

- Update commit message.

V2: https://lore.kernel.org/all/20240422090310.3311429-7-yangcong5@huaqin.corp-partner.google.com/

---
 .../devicetree/bindings/display/panel/himax,hx83102.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index baf8b053e375..c649fb085833 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -18,6 +18,8 @@ properties:
       - enum:
           # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
           - boe,nv110wum-l60
+          # IVO t109nw41 11.0" WUXGA TFT LCD panel
+          - ivo,t109nw41
           # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
           - starry,himax83102-j02
       - const: himax,hx83102
-- 
2.25.1


