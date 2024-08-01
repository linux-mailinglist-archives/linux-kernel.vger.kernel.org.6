Return-Path: <linux-kernel+bounces-271314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF77944CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A58B1C26919
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B21A2C05;
	Thu,  1 Aug 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4GfojMM"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81684196DA1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517418; cv=none; b=OkEyZUUjmdzg7hhzz8lot+fbzcv19BdObW2TECtySeLeVBvQGppgmB7i5iA1rrKnWG9hTq2kekPrMa9+TGSlC97ecNSIEvioj89y/k9WhW131RoRiaRKh/CKAaNMfq5QIfIJU9YBdIEG/UTokYUQc0QEwmqI7isxRekFvCpZeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517418; c=relaxed/simple;
	bh=NWEKfNp2nJu1MZiOT26PCpkD/q7P2bCxg5h7/0fGir4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WzgDsf2eaCnXuw7FXOrqIu9gFpfaiBIhsuQo2v3wWOd9QHJuPeKZUIxL2vNCw+mPz8zgiY13q7dOCyIWTRJQo/rMGHENJC9tn7dx3h5aUPBmoj9SRvyNcJdrWiwFeYKVTnxKsHRZLvpXFkh3bkt+TVn1BEC9RssJWZK6sGJN5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4GfojMM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2ae44790so4965966b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722517417; x=1723122217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/80Ws2dZKJyd/nQCETf7KVjiCoNcpFK0kEqa0MrzWA=;
        b=Q4GfojMM2f15d1VrO9HE0wQEJh/S05ReYvj0kxgAMuOCUNe1wCPT0JhhvaLqYhh7Am
         aHoOP557PCpr7QfFDjdngkx/hBSL6wg+XPt+SW249oQQMd5WV3bIVAXrU21AP1Ok4002
         804jOUEAXKT+JI0X9xuFNjecCaFndSPASJAgO6gO2hvgI1WLZDsLl12GLt0s498/8oOZ
         fy3dFV0UqdDfdJzZZ+utgY8FIpi7rd4v0otEJLGW+2jg9xBrs7rGpJ5kIGoc5jqgcolm
         LucrgGSHehHhEX8fP6HFqSICUbZhMQtDFGT+DJ2JKs6f4vL6rl25Wl1HwcwOC1r8PMrE
         UaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517417; x=1723122217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/80Ws2dZKJyd/nQCETf7KVjiCoNcpFK0kEqa0MrzWA=;
        b=JQL2x+mFWkv141/Y4nGKYdBihQb6LTnpXgm4+wmZ96CfwhpSeXvoxSS97pn04jax+s
         gtjTCmlqJ19tJ658evjXoh1Zcyvj4zwBDwDVhIXrZCx6VwpIi60c0rrMmDX8srkMfDB0
         kJj3uBErpT3lOD1/cBgPp2WM/IYg2SDSbRtoHxthOrUYzb1HkFBIYi65lnZSpYs/gV03
         gR83f1SMADKH7j3VyawdZaRUCs4F579WZnelabhF88hnGE10G4Np8OGSH8m6poPDXIhO
         G1wRUfHn7OTyWFvuLRvGfFq9Zch7ZL+Z7GEBjuvw/Ansgkz1IhVJugF+LZhnV65HRyHC
         NGUg==
X-Forwarded-Encrypted: i=1; AJvYcCU+HxAmQWEtTNmXCxmSABPOmaqO4rJR1N5u1x2c0AkXILpC5cgotkRF/allUuf54QFXj0124REnd2fbTkiBHkKeHBykvaogPkEo3l0n
X-Gm-Message-State: AOJu0Yze7UkKkMxWP68TZbk6rkRn2sbuqVK6jPa5XvH5rIoHB9bni50i
	Fe9YhlGOkb2TVvt9aQgYjRPAhk10vAk2/q0B4ShpH9TX4++KbA6E
X-Google-Smtp-Source: AGHT+IFpSlVTarED15EN70bhN1qHLsuGdh4wsVbq4jNZJLyHvLQOLiKM57H2lvXCF+RQQ+gZdSBOyQ==
X-Received: by 2002:a17:90b:4016:b0:2c8:8a5:c1b9 with SMTP id 98e67ed59e1d1-2cff94143f4mr130012a91.13.1722517416525;
        Thu, 01 Aug 2024 06:03:36 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cb4:cece:78f6:191b:3e2f:ac7d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4e3d88sm3210577a91.55.2024.08.01.06.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:03:36 -0700 (PDT)
From: abid-sayyad <sayyad.abid16@gmail.com>
To: airlied@gmail.com
Cc: daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	abid-sayyad <sayyad.abid16@gmail.com>
Subject: [PATCH v2] drm: Add documentation for struct drm_pane_size_hint
Date: Thu,  1 Aug 2024 18:31:13 +0530
Message-Id: <20240801130112.1317239-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed warning for the following:
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member
				'width' not described in 'drm_plane_size_hint'
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member
				'height' not described in 'drm_plane_size_hint'

Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
---
My sincere apologies for the spam and the patch subject error
Changes in v2:
- Adress review feedback regarding indentation in the fix
- Link to v1
https://lore.kernel.org/all/20240801102239.572718-1-sayyad.abid16@gmail.com/

 include/uapi/drm/drm_mode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index d390011b89b4..9d398335d871 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -864,7 +864,13 @@ struct drm_color_lut {
  * array of struct drm_plane_size_hint.
  */
 struct drm_plane_size_hint {
+	/**
+	 * @width: width of the plane in pixels.
+	 */
 	__u16 width;
+	/**
+	 * @height: height of the plane in pixels.
+	 */
 	__u16 height;
 };

--
2.39.2


