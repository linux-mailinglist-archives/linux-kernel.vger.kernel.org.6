Return-Path: <linux-kernel+bounces-240665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6979F9270A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08493B24B4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DD11A2FD7;
	Thu,  4 Jul 2024 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="R4r5ELeb"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85E1A4F02
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078238; cv=none; b=DfA1Ze8gfyGgTJ31oiu1zqA3WDHxFYpYapLWhWBR4NrthqG5KG2vBkZORyXpdcNx8qxEITBYmEsAayihnyqoXtZgBtyA0xiUH1TA1zz1rTmVz8ibZfoujUiET7RAzGIl8lzcoZJsQpkSQx4p4nE4usaJT8GuE70EIDLNO0Lja0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078238; c=relaxed/simple;
	bh=6+f1swP1YdwqB1i3dzZOL7IJCaejh55q6JL2/J/Ruyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kku8ERi8fa0izbQJ3PbCcvJLCLcGjVoVUj0Q9ipbj867LBcYHM4iIXQvXABX9C+IF9limFDinedPuXBvWK4sjxvviTxN+EEyjquNFyoFsVIYboLrsvlFBijeDL+JRsnifRYWOu2l94rd14aaNHNGPviT5OPdkh/SZ7TFRLXf1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=R4r5ELeb; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7021dffc628so220508a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720078233; x=1720683033; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gez+/xg5x89cHTUJX/6pSwjlIxkC+n3eo9Js8x2Grp8=;
        b=R4r5ELebfQ2FNXkLXqX2pTkqRVBPxFAmdCetSMn4nwtFT38apjLSVfe3WJglXr4rXq
         3Tv/mAZJpaUiatLRJLBCtUZOJPr3k1TAY6QU7ObOOtoZggd7EBD9DCCQKhPn03S9eU7F
         Hf+VAN7X8nqxLFZTyrOYgjheRBNASWX+lZL2BrX78/smG/JZtLvv2t7TpM51woisk5vM
         3Y+ngWqMxD6v+XfvQMrlYOBaHJC2rzkA2wfpf/Ev5dmdm84LX/I3SSJdbkEmBhzla4I/
         EwxRRESqDfxf8F8g+O9b7RuK4LcHK8QxRz2pMpFDSQdetSX4xK0Ht6qrleUDP2qNhAzb
         CO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078233; x=1720683033;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gez+/xg5x89cHTUJX/6pSwjlIxkC+n3eo9Js8x2Grp8=;
        b=bZ4Ae+Gf2pbcjF/+1nGrfFTDEbATue3SI5YJFrP6BhDAdnu7MaMmNCfDMUO0I4rSZe
         6p8u+EzxNhlvgNF+z8TsQSkC2xCNqX5JbI4iIfkEjLicxlmGXrJxvAk5ZWsY1Qz9Gnv7
         F14ARFKdAuj+qkhOGE+MOHihfXWY8RF6TGNp7oQKwOnA4qU6Rug1rW4Vd5wEE3RFns83
         9tOKdEVJRbAEfAj5kJrly3BN+S2axw/22KZ+rGU3TK40hQE7SsJE5v9mZ4Bq2V/mEsaX
         9xtrWhBRSPNrMxojMuGSni0q17p6EcSYvjAhxJyuT7vfhoUmZbwhnfmEKY0rsf6IffNj
         bwCw==
X-Forwarded-Encrypted: i=1; AJvYcCW4QCnMPY82xeW4LyQPTI50c/Ua1cPWuNhsMtGWFhYv6qI8tC44zGNvQY50pWiwjXsLNtGVTYujphSS6o5XmNm/TwpGSCZupMIS2zPb
X-Gm-Message-State: AOJu0YwTyjoVdKq3+8MGH25BIqhjJBnMxwPTL7ePklolLNPm55n5TaXI
	TvvXAPE/MzvOXkPNBYXMceeUDp4eHh41q/LToyvKRbJ5MVpl5AcCIXBVfmeK44U=
X-Google-Smtp-Source: AGHT+IE9oc9mef5bJzitlz52gI6K7JpWaoYTJglYjkfbp+OKpC6f75RXlbWHBIi2Dk2L4x950xIz1A==
X-Received: by 2002:a9d:3e02:0:b0:700:d550:5c50 with SMTP id 46e09a7af769-7034a7f79e6mr809555a34.24.1720078233014;
        Thu, 04 Jul 2024 00:30:33 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm7735699a12.31.2024.07.04.00.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:30:32 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v5 4/5] dt-bindings: display: panel: Add compatible for starry-er88577
Date: Thu,  4 Jul 2024 15:29:57 +0800
Message-Id: <20240704072958.27876-5-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The starry-er88577 is a 10.1" WXGA TFT-LCD panel. Hence, we 
add a new compatible with panel specific config.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V5 and V4:
-  1. We are compatible with starry-er88577 panels in the boe-th101mb31ig002
-     driver, so add it to the "boe,th101mb31ig002-28a.yaml".

v4: https://lore.kernel.org/all/20240620115245.31540-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V4 and V3:
-  1. Move positions to keep the list sorted.

v3: https://lore.kernel.org/all/20240614145609.25432-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
-  1. Separate the Starry bindings from kingdisplay, and add it to panel-simple-dsi.yaml

v2: https://lore.kernel.org/all/20240601084528.22502-4-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  1. Add compatible for Starry er88577 in Kingdisplay kd101ne3 dt-bindings.
---
 .../bindings/display/panel/boe,th101mb31ig002-28a.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml b/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
index 32df26cbfeed..2f251703a121 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
@@ -17,6 +17,8 @@ properties:
     enum:
         # BOE TH101MB31IG002-28A 10.1" WXGA TFT LCD panel
       - boe,th101mb31ig002-28a
+        # The Starry-er88577 is a 10.1" WXGA TFT-LCD panel
+      - starry,er88577
 
   reg: true
   backlight: true
-- 
2.17.1


