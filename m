Return-Path: <linux-kernel+bounces-176381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5489E8C2EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC265B210ED
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC62C683;
	Sat, 11 May 2024 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="EQeBCrz9"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B49224DD
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393634; cv=none; b=sI7MEkDTdDiNKbiBk00ivs5/Vjb5sL9QZuCORXkznQMGaZz9BXInjjEDKOcB1bmloNa5Y34AVuDWVsYjEf5phPL73TwE3M+JmlpiCoHIVZWeG7w+6QKkbFVAKOYvbU1qLVYYoPJOaJL6gr+AvOLDnAUGKX3vvWCATlk7INReE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393634; c=relaxed/simple;
	bh=Lgw7uRnvgXG/u1WaCmK4tejmRfIXensfiTyFmxlWN6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qo2FvIabbqrGSKEyy2Ng6ArIgShrrvplFlNvgtu0nVHYIU6T5R5VTohJD1kK9ivVCPg3WMpziHNsIyl/Q79wdvg+nDEb8U60Pr1J7lxVKlBqndjD47NR136iUwnJDkHCuEcNkVPGX4qrXJkCv45BQ6d/lLfJ5s9CdOrilqWXKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=EQeBCrz9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1870002a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715393631; x=1715998431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQEZxsQcXbFNRud/9tqyFt4L75N7/HmoYq1WCcfvWzY=;
        b=EQeBCrz9V4dk8Kmag19lw8qAWhRTUomvrF6GWK/xtBv2vtpULe+NC1ihZdAIdbYlj6
         5P1ONCuotKJh5XQIZ0BIQL2ky2s2Mpg2q10cnFC7j3I0+hQKT8zh6bHfs43SeKL+agUs
         tAr5KHWHVOCCitpKVelP2M9pDHTPEHb+0EhyQwVYUjaK6ZcHmSj//w/2aOAGFLIA+JKl
         gOmQN+VqSwVNSy3Y/ezTXk8YjOXNPBZeHhyVgw3y8hKVSWKiNFGDMwY5XHplZtDevG+7
         zFttA5XPTuUqD9GyRgrCr3lVnCRFI19GDZTWEp4qTUjxlddqCcl9XmduBXDNHPWTvY+p
         9yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715393631; x=1715998431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQEZxsQcXbFNRud/9tqyFt4L75N7/HmoYq1WCcfvWzY=;
        b=bZlGYYbUIHhw7TnXq4G7zq8QXYcCHtwDaIwvn9CH8jfH8VRU/cGHIrUElsDDnWbcXP
         zKHy0kMTM7Yqf6dplQAHw3BwpO7b/h1v2vueuyUm2ojaYb9vfiCHG+A6tPuT58Ry8aTY
         qzhJnJJIUTHmejjUqTqmxcpL2euaCKrEPXSbtqnapW/OPDB8zEIHkRMqdvGC8CQKksI1
         w+GQ6UBu3rjVgTXz/xso36+tvD0C8uY7fEl9aTEnc+du6wif2DKyVnrhBgbcSOaPCVre
         5FWtVIbK3EX7NXBYBaP06zy6phfM5wcp2lPL+agUFQUBXhFdDxnChckLoPrkcs2qJpLh
         QtnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+BDg+kRy0QVStD4g2a/M+WFFYHyi9bI7TJ14YEMUDagdKsWn5X5YvThNAnLvvg33hO/PtLjCS6Sp5b9EHA9D3rdboaC912GLmAVyP
X-Gm-Message-State: AOJu0YzIL3Em3lzcrVlpEgmzDr970SKAYV7pnAIDOcAylo5BMv8uhGCy
	N291trwOUdPkWfO044p2ImbyBlkH/lJoAlFL/zeXnLpCaruQE29bP6kv578PxjE=
X-Google-Smtp-Source: AGHT+IEEE3ACyk/EL6MmyTvESNdeNwSQRq5IWG++U8g1EgwnOiinICb44Nd5g4szui9OS+r/6cpMgQ==
X-Received: by 2002:a05:6a20:7fa5:b0:1ad:6c5:4ea1 with SMTP id adf61e73a8af0-1afde1b6fcbmr5902294637.41.1715393630666;
        Fri, 10 May 2024 19:13:50 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a9d9acsm3680340b3a.90.2024.05.10.19.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 19:13:50 -0700 (PDT)
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
Subject: [PATCH v6 4/7] dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
Date: Sat, 11 May 2024 10:13:23 +0800
Message-Id: <20240511021326.288728-5-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
controller. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Chage since V5:

- No change.

V5: https://lore.kernel.org/all/20240509015207.3271370-5-yangcong5@huaqin.corp-partner.google.com

Chage since V5:

- No change.

V4: https://lore.kernel.org/all/20240507135234.1356855-5-yangcong5@huaqin.corp-partner.google.com

Chage since V4:

- No change.

V3: https://lore.kernel.org/all/20240424023010.2099949-5-yangcong5@huaqin.corp-partner.google.com

Chage since V3:

- Update commit message.

V2: https://lore.kernel.org/all/20240422090310.3311429-5-yangcong5@huaqin.corp-partner.google.com

---
 .../devicetree/bindings/display/panel/himax,hx83102.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index fc584b5088ff..baf8b053e375 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -16,6 +16,8 @@ properties:
   compatible:
     items:
       - enum:
+          # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
+          - boe,nv110wum-l60
           # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
           - starry,himax83102-j02
       - const: himax,hx83102
-- 
2.25.1


