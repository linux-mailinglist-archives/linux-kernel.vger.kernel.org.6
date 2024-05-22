Return-Path: <linux-kernel+bounces-186157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4CB8CC072
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D34B1C224DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF182D98;
	Wed, 22 May 2024 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="hxEHxwZ+"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873682892
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377992; cv=none; b=KY2H2I6zAWTX/p1oIfG+e4QCOCB9DGehYMY8MRaZWuClRfj4KP7YWAmImUvlZ0VbjZPh/Lh9n92bnfAOXsJrueL26FStTw7CBMsQId3fGPW5oSHaQwhM2rRoKBbkkKDSouwVwDXgPm7dWWcbVp8usQCs4q+ZY3C+kG0W8ThaeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377992; c=relaxed/simple;
	bh=MQ8ogqbdBV8RZmAUgmzDzsT3EVuT+W1pGsTbPr9rvrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NFLovzCEbVHlZ4/E1ghXGhTA03Ff6xoqVqRxGXpGFLG/uFb89LwYOlMqTUCuMRmAJECXVdjFKzbKqbLNsvD5s5YaDEPxK9jUsMkKRWFzqvIviHHYy0/x/fl5kCcfrRfiklELYWSA+c2gKvR3KNjGy6ilIyISsfxhZ19Y8g+tm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=hxEHxwZ+; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b2cc8c4b8aso3398257eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1716377990; x=1716982790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIxX5cYsFW4f3fFIPe4gQfExTk/C+UC6nEk+3Rg1xtA=;
        b=hxEHxwZ+0CFbCyJLBlsvK1GedaNe54Mx+XlJ6FHs4S2J2aMOetVgywsfTTzO1DJu+S
         B+mBXr0CqR8GFTZOdcWXro8AEE438x9rKg21g0k0HTRuzHpHKxYSQRy0hWKzMooOYuJQ
         i4CT0Uczl+D/+L08/5Svki7pAg/Hq+6oQ5OQ4LmUETO6A5f+44GXxoOBTdpDiaYiods9
         C3/gHE8//CzSyY96L3wcaI+l665UUvDNiljVYr0yTLv+5ZzCVrk0GT4YNlBRo0VtMzc3
         0PZPjOeo2l9GrakyjMPUOdNaH9FKh4fL2W2itrTlu0wKLdPvgFg22d5v7mQU2pki8j71
         AXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716377990; x=1716982790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIxX5cYsFW4f3fFIPe4gQfExTk/C+UC6nEk+3Rg1xtA=;
        b=pX53gAPi1mS82D6IrktHdsCvKXS/GO45z2Sl3Pv5ezW6LcUDQ7Cbmx/mYAOfC43QDM
         4grUgNngw2gE7bnC0862q6rV2ieJgIPl/n5DndjO7NgUtlz6yEWQZ4cNYk3RRHd2PBHq
         SjgUhVpwOlWOMBxtVh3a8ibGVMiu21YyZzqC9L+UiuJ0wnXvCORKzxE8lwy+ICRICq0R
         z2NItND+VmQGcGjf2rLymiUDeVFsjSepwxf/gfawE5ylRhcNtM3VaOcMJsGKvFL4lKSN
         F6+assGZGHMG3dUGniN90e8FUgnkG96au0OyNwBS7rleVnyEZrcBWcMCEgd+xK35ZsEv
         ildg==
X-Forwarded-Encrypted: i=1; AJvYcCUOixBVMtBt3XbXGiYhbhcjhlhwF0eCTj+6P76O7oIbT/nHuxyCbae0VR6Ug8ayBJbPMz+ATbPTYmPFeMIzh8FOu8NaQ2dBLpafIETy
X-Gm-Message-State: AOJu0YwQFSlvOYyQbld4oKfGRE0aBir2wYLrSxBcVIeZFPqjwdMhLpXj
	1G7hymkN+LIfF3wLZZSrayl9qIVu/O+KJVMLCr2oPCI9UHVnOp2XTMpQ8Kyi4hU=
X-Google-Smtp-Source: AGHT+IF+P4KyA0qjF0rkpmEN0Vv2c2+hJAzEpAN3LvQxG9cmwuN9k2OO7RBXuctIQ6eYQkrLtbRRkA==
X-Received: by 2002:a05:6359:678a:b0:197:3d6f:ccf6 with SMTP id e5c5f4694b2df-19791ddc7e9mr183809255d.1.1716377989841;
        Wed, 22 May 2024 04:39:49 -0700 (PDT)
Received: from zhk-CBG100025892.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-676fc4c98d6sm924437a12.81.2024.05.22.04.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:39:49 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: dianders@chromium.org,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add CMN N116BCJ-EAK
Date: Wed, 22 May 2024 19:39:24 +0800
Message-Id: <20240522113924.1261683-1-zhouhaikun5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the CMN N116BCJ-EAK, place the raw EDID here for
subsequent reference.
00 ff ff ff ff ff ff 00 0d ae 60 11 00 00 00 00
04 22 01 04 95 1a 0e 78 02 67 75 98 59 53 90 27
1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
a6 00 00 90 10 00 00 18 00 00 00 fe 00 4e 31 31
36 42 43 4a 2d 45 41 4b 0a 20 00 00 00 fe 00 43
4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 4e 31 31 36 42 43 4a 2d 45 41 4b 0a 20 00 98

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9cfa05c7d193..01e26b5a2388 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2067,6 +2067,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1157, &delay_200_500_e80_d50, "N116BGE-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115b, &delay_200_500_e80_d50, "N116BCN-EB1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115e, &delay_200_500_e80_d50, "N116BCA-EA1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1160, &delay_200_500_e80_d50, "N116BCJ-EAK"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142b, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142e, &delay_200_500_e80_d50, "N140BGA-EA4"),
-- 
2.34.1


