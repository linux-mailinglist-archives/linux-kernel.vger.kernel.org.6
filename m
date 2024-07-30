Return-Path: <linux-kernel+bounces-266818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C545940815
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B07B2187F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3C0168481;
	Tue, 30 Jul 2024 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajwx3zDg"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34598624
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319636; cv=none; b=HasTwXFiXsXbgu2QUIMSdqm3sOUoCs8qYZ/jJBoj6YhLg6zWTlykotvHdGn6oWvt2wX6HfaVItXCMWhgcoqtf8B1YkD7Yb0iBJc/+Dz8IHsI49Cjy3fQ34gmFpyOjbS+AfuFz83BvX7kPwVv5UsTT6uMJan5GHTnlg7Tqh4MAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319636; c=relaxed/simple;
	bh=xx7l0osf5pbVBoH/iG0gF21Z8S+D1bCYbRoAPrGLdM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBvQcWhvhM1Zd3gsqNMMPXU9PQRAAIl/AbARUL6+IHS1A+MJHKKxm1qfnT3gQR5jnhUSgey/1v/uYGZusMv+EgloWu2LiZ3WMskx4tJJWWZrW9zvnWlYa7iPKUKg339doNyK/4RmI7s+ls2BC4NhHCNB9roiB8Q/zfrwfm6KpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajwx3zDg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d333d57cdso2771453b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722319634; x=1722924434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JaL7FYBtATcRvs5LgUdqFH1RdIwqFz0K1+6W3wtHTYY=;
        b=ajwx3zDgYUQ1O5W+Fe1lNGwk6nvkg3bl5dZnSlb0Uz3Rr3QZIdZ0KIDxXEOxqkEUaa
         WDp67J9+mvYrWJ/e7V+0tQZD7JhIcBG0d7Yme4IwFUB9iqEzblu0iG7h3qce0EvD8F06
         2TGBSyWFWChrTa7IrJkM37eNdCgjwcBOh42mD0k8MkVopqNiwoWfnUXq+qV2tgF97ga5
         2lpVnwDkjTbxk1CrVJpS3StKinMfK0WCYZ7c5GUw5if3V6g0E5s/ZE3ZbzcMAJIUee6q
         QH6MDjpHPfQIRT5JaJaGEORIsuQephULt4xvQmDgXeOFJ8I18ov/lIuwHnUVlJgUAvaY
         WvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722319634; x=1722924434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaL7FYBtATcRvs5LgUdqFH1RdIwqFz0K1+6W3wtHTYY=;
        b=xBGfyXn5hBd094M4fa56InXcJl5mbJrPg/X19MD9szMIBwBaa5dAKYqyboUwdHPPh+
         si37U2hxjiqouFt6ZM/U77rS0v2Lu4VV9ItutAPqRaHHv8IQfZ16pxOa0dSQUJH22nti
         lwn+H7v3X2xDyphAIlBpty4A3SUR2AVEW2v1UwTP1c1lk7qRqFgLdM0I1RqjdXLlix/H
         GQxId0ukycv6qN4G2OlkHIPxsSyQPtc0nzw82Y7jkUdMgkim4XDl2xLmuAO0XHBYNawv
         BN6es9vVc3N+gMoVzmSSwUVlLFcuBR/RZMm0QvXvMARNJ9em3YYYCtHP+CrQTLZYATQG
         ZScg==
X-Forwarded-Encrypted: i=1; AJvYcCVCjWx5CTislzvaA4zeevh3Ye+dWno0ld1WMhxsMcaFaQJM7p5HWnK26GcWWWs61msnfeigKbUW3e8lDKcWVPqxp5tuAa9h62OKpx59
X-Gm-Message-State: AOJu0YySgYOUj9Gi0yTRL6YSfTKZ2ibnIlScUwD12ZKBwblOKbYz4vmu
	gNFc+hQHJltPDEb78ce081F0DdToMYrOYOCxGWYk3sTbdY0E1MHb
X-Google-Smtp-Source: AGHT+IHp1ixJxVULvC/EjTzN36eJCUG/wCIgrvEOGwgtOAcQ6vK1PryRB68wQtoNU8MJGCpNv2KE5Q==
X-Received: by 2002:a05:6a20:6a10:b0:1c2:8d33:af69 with SMTP id adf61e73a8af0-1c4a13afd31mr8807135637.41.1722319634443;
        Mon, 29 Jul 2024 23:07:14 -0700 (PDT)
Received: from distilledx.localdomain ([2401:4900:6320:5c5f:a09c:1e46:e58e:e6c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7eef4f0sm93589375ad.178.2024.07.29.23.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:07:14 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: dianders@chromium.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2 0/2] add more multi functions to streamline error handling
Date: Tue, 30 Jul 2024 11:36:57 +0530
Message-ID: <20240730060659.455953-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds more multi style functions and uses them in the 
startek-kd070fhfid015 panel. Additionally it marks the older functions
as deprecated.
---
Changes in v2:
    - Improved formatting
    - Rewrote hex as lowercase
    - Marked old functions as deprecated
    - Added more functions to transition
---
Tejas Vipin (2):
  drm/mipi-dsi: add more multi functions for better error handling
  drm/panel: startek-kd070fhfid015: transition to mipi_dsi wrapped
    functions

 drivers/gpu/drm/drm_mipi_dsi.c                | 226 ++++++++++++++++++
 .../drm/panel/panel-startek-kd070fhfid015.c   | 123 +++-------
 include/drm/drm_mipi_dsi.h                    |  12 +
 3 files changed, 277 insertions(+), 84 deletions(-)

-- 
2.45.2


