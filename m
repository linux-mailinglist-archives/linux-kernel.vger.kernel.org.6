Return-Path: <linux-kernel+bounces-253746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350293264B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655B41C21CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E38B19A29F;
	Tue, 16 Jul 2024 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="LwUOpVOP"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273551CA9F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131884; cv=none; b=L40i+nsI4MR8SUZplyLktbbirW19suH3U4EfER3/fajzS3PCZqB0gJ9HirO3ZpGqbBYVpOTg0WB0FTvEheRQNGEKaaGYCHGkRH9vpOkWoCZeXIRISdQ4EECU0FdN8YtQd0cVZHXijUFxKWUWIKYHfxbYXyJ5RzkzUvspyna4ESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131884; c=relaxed/simple;
	bh=OuYaRw/e2BUIpKew36qzLtdkzG3lgHXSgQcxBzEFdLg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eqXP3F2J2j/kw3aLcV1wtiMYwOtAkucW4YbseFQc2yWCPfnwXFk8z10N9AmOY+dPyZlPKuHcB4/oUxCXruLdGHIzc+jYpkZK1i0g2wPRSLkLVChpQB26purSrsbXrRjwjEaf/FBzRHrBXvXqMAvfhd8ip9KJUNzEXdU9G4MxU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=LwUOpVOP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70b5117ae06so3927103b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721131882; x=1721736682; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWy3QUylzw0ayHlV7QU3L87cEvQwTf+7VJ7LitrTlLg=;
        b=LwUOpVOPb63fiZO7vd9hXAGIMgmM/2XTHofhJaPFbGEp2yKLEa2A+35j55LzyL0QXf
         NgZ9O+xJ2hkQIPgo9Ay3Sg9SNJ+aK9JqMQjFuBP9EUgaCp9NJLB5KfBgyFAjbk8+NGyI
         8t8yF+URBwOr1Pocqy/zMZMG0NRnytRPaPP/Q/TfQqkofjsJVL0m0ZKzF+LpDkJ3Ywrk
         1dsHRNxvEDPL2vZUC5p6VMnmY2VWuLNJhahALCsk/Ele/TiY4KA8ZqObZpPwqpXhZ6Kg
         6JLYoH2L1d320oNEsL0B3elABEAfW+NQpDjMlAQw5lW8zzxjy+kcZs8SY3wvDPsAQG8t
         HrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721131882; x=1721736682;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWy3QUylzw0ayHlV7QU3L87cEvQwTf+7VJ7LitrTlLg=;
        b=cjafgjHgFroeDC8y1Vw6MN9GR5+U8YI5uHC1hpQKJDelevA4CADH/DHua3cjyDiuGn
         +z6u0Aad9yUrG7Fz2HhoUzFA43lkYxxrVKeA3BujnvlGZ2eULsJG/0D9z5Y1GwDk953Z
         +9wyEbOliibi47RWjlVwhY8gEmp7ItkZr1TvSG0yOwEZv7pM2STttJwavNbg5VFXaDGk
         fwMBNvh/YcGkvs6VYXaGQHs4khtbIXS0vDNE2yuVIwy5F/l0v3VFTN14mpjCiB5P/wU+
         QqlI+QK8b2RWDsK5aBtwtlrJBjeVRbK6fiFvkC6mJ5ee9kg3cD7lEmp3pMzr8vPufrIt
         YouA==
X-Forwarded-Encrypted: i=1; AJvYcCXMKYSMzl8s35xFtd52P5042rR+x8m3vdSWI73oD5A/UVI8t0EqUxmU74i/qg9RfLudRDvuzEcBbLgpbfYS9eswtS3OFGYSwYOZ2xi0
X-Gm-Message-State: AOJu0Yzn8Qm1+gXJA3gU9CbNXDxY4U4azZCpisIaeQ7dmFzHy98RJHuS
	ygo9ysFG1iDhgzPbSzYwhS6p1bSAOI/KJ4hTcsefo7pL/nEw8B68gNhB1wdRcHD6a8vqz3LT6R6
	aMzA=
X-Google-Smtp-Source: AGHT+IF3q060DbGSBRTI8U3NNaLmQh66o0p//PgKITkDQ8npkjIZNbEwzf5dS0d5vcSWygTQX79NKQ==
X-Received: by 2002:a05:6a00:4b42:b0:706:6248:949 with SMTP id d2e1a72fcca58-70c1fbe181emr2435528b3a.17.1721131882394;
        Tue, 16 Jul 2024 05:11:22 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eccc48bsm6114065b3a.203.2024.07.16.05.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 05:11:21 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	mripard@kernel.org,
	dianders@chromium.org,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v2 0/2] Modify the method of obtaining porch parameters
Date: Tue, 16 Jul 2024 20:11:10 +0800
Message-Id: <20240716121112.14435-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The current driver can only obtain the porch parameters
of boe-th101mb31ig002. Modify it to obtain the porch
parameters of the panel currently being used.

Also switch to the drm_connector_helper_get_modes_fixed() function 
to get the porch parameters.

Changes between V2 and V1:
- PATCH 1/2: No changes.
- PATCH 2/2: Switch to the drm_connector_helper_get_modes_fixed().
- Link to v1: https://lore.kernel.org/all/20240715031845.6687-1-lvzhaoxiong@huaqin.corp-partner.google.com/

Zhaoxiong Lv (2):
  drm/panel: boe-th101mb31ig002 : Fix the way to get porch parameters
  drm/panel: boe-th101mb31ig002 : using
    drm_connector_helper_get_modes_fixed()

 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 29 ++-----------------
 1 file changed, 3 insertions(+), 26 deletions(-)

-- 
2.17.1


