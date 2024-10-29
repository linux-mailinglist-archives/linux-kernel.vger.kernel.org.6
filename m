Return-Path: <linux-kernel+bounces-387485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B5A9B51DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DD91C22C59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994AF2076A4;
	Tue, 29 Oct 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0P2r1IT"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ACD1F80D6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226648; cv=none; b=DzekTsKVVeQFZQfMUPZAbjmp9Yk96jMsQicBBsf/uT8sICKRHwKMVup8rQXSIVLyaytkI/yUERy+BVN4EW/YqLQDTf4WpL1Y0Nccb1cQDSP0CiDfzabI/J0WRxBTe/grm9svR1XWLiPbbuXlUJ//92z8i6i7A7WwNK75PkX0ko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226648; c=relaxed/simple;
	bh=5x560lPtRBjP6lv93v68Ju6qw2twrxKvDropBUCsbbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VEfsehYqTG6xYKuSIQQgzuTarPBz6PWEZzbWZm6+Mt9/1VhvTVVaL7pFPySuoDH0a6wRf7rgizdngf01gco5UPxr0HynNQdqpKC0DkZ+b42/IIOA5AanjMd6B9FmX2pbaPOXVKMDdA5S5/0qbcI/bGSAG69K2lV7qAC2UgzRhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0P2r1IT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d447de11dso4153109f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730226644; x=1730831444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6tchzCWGrJlSX3rW/FyPve/w/cSyAJic1zkZ2Qkuh9o=;
        b=l0P2r1IT3EOJOw6+kYRpJgAXHjR1AuBzG4qt3Awzaev7xIEU1kmkMVUUcn3VXJAS6h
         5sSgZL5XfIrKCJhsTq+dEE3M1ClwO2teZtoPCk+eSMQXeKEEd7dk9/IU//YfztLiSA/z
         YyIh4c2E8J231/vtfOMcp9/H2u6klFgEZVMHJwJ4rCSCRfSXumyV0TqTuRCCHuTfOujc
         bAoaD7eFjXBc85tfvAwvlmy+nxWLI1tIl1DeZfze7EPAgGHY+dw3mzqhHxS6PDhojN/k
         c7yY6LKu0/qtgKhLzkphU65CGbuJoe9lzMIano+MZvPXgbpAhbM5CvtQS24bGqL/bzCR
         4eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730226644; x=1730831444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tchzCWGrJlSX3rW/FyPve/w/cSyAJic1zkZ2Qkuh9o=;
        b=QJ+ooxB+utDkW53oEkzJTzSlBfnB9J0v5HHnV7U+WIMwET4a6d8Y1Kv5TGMsGkEwQs
         T+h5fFkn1YBxflIU//8wvcZoncUwl/8S31co30kJrEbg7N2494UIYDIenuNuhqagiiN/
         YxtTxUVik8Yfk5p14bTt8kVt1/AiByAjB8i3lBVp6r9Lk6iWOLQm8h90Z6kipVlqcSzs
         4PO3cGfAiJS34ddH8/rX01UmdquVlXLU8FS1oYHRw4SL0BqSj1d1OBrVY8y5cRHXPWHL
         iWgqYtUP2Wc0j+YjqY48igORqR7SlVJCdT4tiZkDtYx0A+b6qmPmHmKmurlO/X/gfEyr
         HHLg==
X-Gm-Message-State: AOJu0YxvdeW+/0bCR17gsg5ZFn+nDuimgzDCy87LtC4rurz+iD4W/N6T
	WEpdD3MuY9AT/y5q9CweIqmcj8tU8FiZnCX64PElzvOOfvNBrw6E
X-Google-Smtp-Source: AGHT+IHT1npegBHS1gJiTwoB1Yq4A9pNPGgqdHqSHieML//oJyPhcNNxGrIiMxMWbjPVZkn6vVz8NA==
X-Received: by 2002:a5d:4f04:0:b0:37e:d965:4e1e with SMTP id ffacd0b85a97d-380611ee9ccmr9645279f8f.42.1730226643592;
        Tue, 29 Oct 2024 11:30:43 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b91d36sm13181811f8f.95.2024.10.29.11.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 11:30:43 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alain Volmat <alain.volmat@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: add Raphael Gallais-Pou to DRM/STi maintainers
Date: Tue, 29 Oct 2024 19:30:41 +0100
Message-ID: <20241029183041.137414-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as a maintainer for STi driver changes.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 71b739b40921..0e583aae590a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7477,6 +7477,7 @@ F:	drivers/gpu/drm/rockchip/
 
 DRM DRIVERS FOR STI
 M:	Alain Volmat <alain.volmat@foss.st.com>
+M:	Raphael Gallais-Pou <rgallaispou@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-- 
2.45.2


