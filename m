Return-Path: <linux-kernel+bounces-272181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBEE945858
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2195B2331B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB586487A7;
	Fri,  2 Aug 2024 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="0qAoeX4Y"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA211CAB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582369; cv=none; b=PeBaqxr40I9Fa6WGPTqXfmIJ4oaYy8AoQ7nN9VnztYQVFazOrEkEPXyDwY3HGFjHNx7qWLGroro0uTYm2BHu9UscWXLnVlosV4muJTojoeCiQLL/BwgtT3x7VvHlpEHX7EYrxzoFChHkEWWXQpw01BUm99/zeSp076SYHgoimVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582369; c=relaxed/simple;
	bh=rrOoJjeIUfr/0okgX4QxNifRFF/wj+7fTHdWyOXutVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XUq6+A/MJb9V+jBrDjqeavVxweDGa7anEI0QoEDH5uZLkHRKVQP/MBc/fHFAE4m/hA49IZqQj6h93o0e7KlJcJLH3pAdnisQ3mISg0d4KHtaO6difnEF+TYpgMU8SQlOLJ5uulyWYQbFeOjKDwdziRaz3rILVHkbQsfWo2Ihk6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=0qAoeX4Y; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d607d88d82so2786306eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1722582367; x=1723187167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTIBsGPtfu1Pgb8/bR61xHSHCNQbyXzi1cZXpHVQwvs=;
        b=0qAoeX4YrOWQf79njlsBpcytdtV36rjIQlmdcht5gcGHO+54Q+5Q7mmI6qprQH7234
         5SuD0tgkAjWKjPumBdtbhDSo7AWhZOURRsrNq7vW7zyMN5vtur2ZbJ1v9+UOzkGwPZwa
         0cxZmaIMvqzoBAgyfQ89uf62UqJAa6X5y4w1/vEAQRRT3kRnYv2HDl5ldxej46KKvqfV
         GKV/jrxkXL1D2lBkKWByVddxTeyUHYQjmqBcPVUI1+6JkmmYwL8L6Zg7tNwBvKH8dB06
         XAiNPHgxr7fIT0WGgw/Bc0Dd2sH+wdHYUxm7aMt9pCatJs7yYSp2D5DIC52nuG34FXBQ
         oabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722582367; x=1723187167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTIBsGPtfu1Pgb8/bR61xHSHCNQbyXzi1cZXpHVQwvs=;
        b=VWs/R6zfa2NOIuPziNPZHwZI1hXEP1uF6j8zjl8DWJOuSctaUYaj2ulQcIPKQaLl8r
         TyyxQ630mpmgwE1FW1Ir+fzNgj00WxCDylwXoc4J4ClFR2e+ZuHksNe7wmWF1LsxPkZn
         zWSUuJatPoXjJcdD65Q44o9ytaEKfYDL+A4BMyZ+6kuJsxTzAXmx9jx/POy1+U/YSdN7
         xghkbr4C4Pp936b6Weg/wMBhUzqVZFVLi5Q3BRnzEhwCHOBDlM4DR+N6IehmuHRXwJd8
         olcnUibhnngWXLNzt0qgcP/J5klW2p1R6dCrhO2MAYhGXnjCZS90aO5x+UFKi1r23FyY
         zU5Q==
X-Gm-Message-State: AOJu0Yz0fRKgg3c+Q1pfparKW1+OrTq9DbBgut3UGXoEI+lfUyWkIUZa
	qzhdY7VDcgSvsg8yuNG16Z55ZWNcPp+iF2vlAxzr1+zcrxpKNqwq5dEFmc8zhtua5T9jt/VUVz8
	2aioiFg==
X-Google-Smtp-Source: AGHT+IGRXSlWnciuqQZfC3tHOqc0cfNVLuu5sQUtWmYqcOy51Kd1bHWfac9G4uWn7rTTZ4G3ZYP9+A==
X-Received: by 2002:a05:6870:a550:b0:259:8805:b634 with SMTP id 586e51a60fabf-26891ee302bmr3133273fac.49.1722582367067;
        Fri, 02 Aug 2024 00:06:07 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. (2001-b011-2017-1033-1725-8ce9-24c5-cfd1.dynamic-ip6.hinet.net. [2001:b011:2017:1033:1725:8ce9:24c5:cfd1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed2abe2sm805654b3a.189.2024.08.02.00.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:06:06 -0700 (PDT)
From: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Subject: [PATCH v1] drm/panel-edp: Fix HKC MB116AN01 name
Date: Fri,  2 Aug 2024 15:06:02 +0800
Message-Id: <20240802070602.154201-1-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename HKC MB116AN01 from Unknown to MB116AN01

Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 2733366b02b0..7183df267777 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1948,7 +1948,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50, "MNB601LS1-4"),
 
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d51, &delay_200_500_e200, "Unknown"),
-	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "MB116AN01"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5c, &delay_200_500_e200, "MB116AN01-2"),
 
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x048e, &delay_200_500_e200_d10, "M116NWR6 R5"),
-- 
2.34.1


