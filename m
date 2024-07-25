Return-Path: <linux-kernel+bounces-261938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA393BE07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D2F281372
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52617D37E;
	Thu, 25 Jul 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="zJwvEGz+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFC17BB1B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896393; cv=none; b=HdhNlahafLU91SRxRa3FsZHfCP5JIX1YgTk/icRMKEzoiSZpJNcNELtHd8+rfwTj+v85XlkNsy2zmrajY5PcxnHq1IM9UPj3gAuM0D31J4w2zcd0VIHB53NHi1iiy0SOm62egPgTNMM5cy8zcgACZZeFMZsKtz0wm3MVpqxK/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896393; c=relaxed/simple;
	bh=NysROWiy+W2KMYMm8JGHDd5bcezbhKyQ4VazOsAOR4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=A+LhAgsMImTKal/5iyjKzZ/f2sPjIIAi2/e5m6kWQn3iQYX7akd/H6ySMuUhJUNasQz1hv2X9TvNwqG7R7CiMw4kpsAROvpCnVjv2sic7hf9M7pTtBTWY7dBsANB6reFQ1owrJvPr/R/uHe2H+sgMbyedVqxHeY+ix2BgvMM+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=zJwvEGz+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc569440e1so6055535ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721896391; x=1722501191; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=30WwC7xF4wqRXYdTsITwiTq4M3u3wouKo8DLJsogsOg=;
        b=zJwvEGz+teFY/jGTxIlGXFYsbjf0XnUxW1kuIOB6LemxQlLFWB/eVSdXXebyI+q/g5
         MKyE2XN9uxoUcIL8IRwxNypNMXf0kqOo3D3Hwy824SP1X6rtAUJEpEb2AczgezByUhTt
         773cTHGnhvdYuzve6Tl1/VAQzyJ4gpWhUL8sMc6vvWAv1Bftk+iU4q9iX6a/xQ7xC//1
         StXWxOi+j2+ycj1tP3Zwo8usZ7Ue3ksp56c6fYUb1R9V9vq0q+8tK2KGTyuiUvHa2HrE
         bCVmP2t3C6k2akZ83l1dbMTjfg9JKfQ11lo/GUvQa9WJ25L8ncEFa7sjyD9GLOUbpY1u
         Z20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721896391; x=1722501191;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30WwC7xF4wqRXYdTsITwiTq4M3u3wouKo8DLJsogsOg=;
        b=YbSksqqXQwVaNB3KC2kicZOyLaX3RpR8+B7QBk9IebPhUGA8IxDedUcmHBUnN3NVs4
         QtV2T0rK4SNsd1wKKgzlWZU0YLAtGJVtyVe6xBDYgc0Ylishzz5Ktn1hknNggRVFLHdl
         ZHIsP60ebBLmVpNcxtLjoK7QJsrT8MC0FekYuHVX4AoxBEou3TdhRXkqbRrO+9KTFxTw
         su+3AED6EKQ+Gd6WwgLG7j5AK8b+iVclmK15fQaOklo2Ha2kVFEdIRYPHtrJwSun16xO
         kjqM7WHRpHUkGcxbDiijNvEmCoVI8a7UIUewstNxJx6Mg+8ISxrMBDTCBnTxd/PaHVUH
         i8eA==
X-Forwarded-Encrypted: i=1; AJvYcCWntt8vEAW2z1FfkBpF07cquc27cE+3Mn5piF+K8ivg5cEQhxmYGL8VWNNvZxF+emBBJKWwPC6CTX7j2xMUbm0urGGPHoLhpAQG6SwU
X-Gm-Message-State: AOJu0Yx7jIyMhe58U4h5/DZJi3mE43pWt1w4o/vxwxxMBKekWC68PATc
	Q/EyCJbGZthb166z7h0dR1V/Yf25pwX3TZ9E52vOJkI9B+iWy3wsTH7manKXNn4=
X-Google-Smtp-Source: AGHT+IGbr51RozlEceTw/4wKNvo8hmR6J1IdnMHUkKsnQG6xKcoPWLQWQeH1Q/3w11hGQOdfvdL1MQ==
X-Received: by 2002:a17:902:e746:b0:1fb:a1cb:cb25 with SMTP id d9443c01a7336-1fed3aed419mr25323835ad.40.1721896391372;
        Thu, 25 Jul 2024 01:33:11 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff9086sm8595595ad.302.2024.07.25.01.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 01:33:10 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dianders@chromium.org,
	hsinyi@google.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jagan@edgeble.ai
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 2/2] drm/panel: jd9365da: Modify the init code of Melfas
Date: Thu, 25 Jul 2024 16:32:45 +0800
Message-Id: <20240725083245.12253-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Modify the Melfas panel init code to satisfy the gamma
value of 2.2

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 78 +++++++++----------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index ce73e8cb1db5..44897e5218a6 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -873,22 +873,22 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
 	jd9365da_switch_page(&dsi_ctx, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xbf);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xd7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xbf);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xd7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x70);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x2d);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x2d);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x7e);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfd);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x28);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x12);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x7e);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x7f);
@@ -899,47 +899,47 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x8e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x6a);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x09);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x2e);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x1a);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x15);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x69);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x59);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x4e);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x4c);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x45);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x4a);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x49);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x4a);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x68);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x57);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x5b);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x4e);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x3e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x31);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x24);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x12);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x69);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x59);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x4e);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x4c);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x45);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x30);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x4a);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x49);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x4a);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x68);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x57);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x5b);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x4e);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x31);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x3e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x31);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x24);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x12);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x02);
-- 
2.17.1


