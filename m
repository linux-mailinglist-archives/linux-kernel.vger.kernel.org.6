Return-Path: <linux-kernel+bounces-176383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2674B8C2EF0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8B01F23795
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0F23F9E1;
	Sat, 11 May 2024 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="paGTtbpf"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762C41A94
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393645; cv=none; b=d4RqXAy2VbTXDMHo9dJK0j/B/C4pMMMF1vlUQFyFT8tnPF+gaIx10hWRalTOgg4qJ+Pv5wINu4FqG+nYYhQQqqCD4NoTSUcuDxKiEHNaUKeQfCeQieaet59m54S78Kx2GUIuZyCENFZ8AsBph9oez53rydUst/ljwo0mesTqi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393645; c=relaxed/simple;
	bh=ErUqvhhZEPiaGGFr5TpTmGZyBY5YYzifSQxB3H+sU4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSfSobNzSDToldpyttdzazfg6aeM5HDl/0b92f6k/6fR8ChdywzCT3AhLyI+Z55SX7P5All4Tj+YSczd1bWeuPiLnX4S+kVx8tzmzjF3XEsFGWzyArIkrWFPE2Ba2na/zjAA6sl6v8GWlogrREsuZ8yuiF6BcQv0eUc0s4q0HDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=paGTtbpf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4302187c0so2610520b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715393637; x=1715998437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buSGGfA578U0qsElcZ/pKHG9pDlMNRoK5dVeaixkId8=;
        b=paGTtbpfqWFM0aQinq/VM9WAWSuOYuN0B9vqcjjtl4VS9QT1QbaSBBTvtd4lZLcEhd
         cIOI4DXgHiHfsnZpw6zx6xnXGa4CVavqBQeaOZMND3++VLhTXPGTw2GdKTYhJfnmklbo
         777WmJmSdb31nBMisx3Zw2YO5kZz9Cfidggx49xb2s5o4P/hJAKm6EJhO2lYFJ7SxLVh
         J6gDgQDDOvMYnsGFskB4UOI4AbN4oZBWc4GS0iCtxP/yxv0FyCe42mDhCPE2DEE+3omQ
         JfFrAw+qya5EDeP7YwbALVcBCaF9ZaRJiHs4YdT91KnychQ62tXsNvRzFFhx4NO58A0F
         CRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715393637; x=1715998437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buSGGfA578U0qsElcZ/pKHG9pDlMNRoK5dVeaixkId8=;
        b=VoLAjQUaTI+FzEgB3zmDa0+90HCx2Ok9+J3HaKjZCJjnLtV8mC7mCm0l1BJLx07H/o
         UL1vwI9RMfjvgTimdYiiveTwNDMWKnCF/VqJSbeR3+oWoe7ipMLXx0GyP1hlL/84uk56
         z5pHrP2WKFY4/PqMgi9TYL+HSkwZJXRKmcunM3PcRVz95PIzcVPcfvn3IIQItqA2DWgq
         nZdK6rryEDMbr4GuFYW+7rNPTvdS51+CyCgTKeS5YVoCh9Cm3aeFzVZthEYhUbFlDjfr
         QPAVVFp0U6MlQQblFM9/ej92kBeit84eo3rd6FKLn8l16fkJmW+7gOdBpdaQcJdim0rf
         fLWw==
X-Forwarded-Encrypted: i=1; AJvYcCWTN/ZBOULv84vyZqk/nLW268jluk6JJ/OVL4AXJjAQkyav/3UWL7xcBz/NtfknrWaCWwnSYS/hXbh/ilCAg1U94O/Gh7LAUXpH1j4Z
X-Gm-Message-State: AOJu0YwASlk9xjm48MD3GOKhzWZeW/YauoPUlFeWe8iMnttHYYdaKLrw
	p+daKJ/XFj+6N6CXX2QWUmRHa/efbH5pQ+SMfdZGSDJmAWgVjkeDspFJUTNdB1U=
X-Google-Smtp-Source: AGHT+IHaDoWAAKehP+RA170JBuXHI0YWJevK2pZ3NDo17cxsNB8HHsCuonhvsfus8qnqVKaezmsR3A==
X-Received: by 2002:a05:6a20:8411:b0:1a7:a644:4485 with SMTP id adf61e73a8af0-1afde10f892mr6903617637.18.1715393636997;
        Fri, 10 May 2024 19:13:56 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a9d9acsm3680340b3a.90.2024.05.10.19.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 19:13:56 -0700 (PDT)
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
Subject: [PATCH v6 6/7] dt-bindings: display: panel: Add compatible for IVO t109nw41
Date: Sat, 11 May 2024 10:13:25 +0800
Message-Id: <20240511021326.288728-7-yangcong5@huaqin.corp-partner.google.com>
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

The IVO t109nw41 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
controller. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
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


