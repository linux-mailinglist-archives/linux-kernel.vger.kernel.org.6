Return-Path: <linux-kernel+bounces-351588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D637F991357
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F84A1F23F3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6CA1552EB;
	Fri,  4 Oct 2024 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRzA/qLd"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4FD14D2B3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728086361; cv=none; b=GMncRzW4O4MkAjeY49WDwK3wa4viZjaQzrzxD0LRDHfKFEY36FVeEcmgEEjQ9SEpHMPzCxCxKhRb6WtRd76yO8UDMEEe6gl51/JguO4iLGQqETo/gyhOjxoGNnZGuRXH6bqO7lnxzcxHTayPgykTlmYXtL2QlG8Vamj+RIXQHJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728086361; c=relaxed/simple;
	bh=LBxnYi6JWkEDu/s7q8rzjJg1t1F0DxG9EiKarQm6Bvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ysnq748YaKgF+J6/b50k0MSaGzh5uleWzFFAbn4XQqIKz3HOUK8M0K90/E4aUB7uzQSenuot7gzhj3yddQt8h9wQwB1y7xMFI51ZCOooArElfSdQ52pL1pVENVNqhhvdpn89Cj+nIoYd3yr4qjAJKQ4BdoHRvbN7ojH1qRjMOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRzA/qLd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b78ee6298so17317625ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 16:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728086359; x=1728691159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELTyDzpdOksZjoNrVzCSOk+1T+6UJusdniGL8nRZ6BA=;
        b=SRzA/qLdwh/G4TkatousfHl2dGr0tog7Zgs4u3fqy8EsUaAMk7kRgxfvweVNO+CGxR
         9DqimyDuqLXwoZC1MxStWMnyi6OUWUscLlDjL7gg7veeYvyIrenQMkRCH5Ed8/nUcUY9
         3NYClLoOuD3Es6jm+1bhVTYojvkbC43lsaQQE40vmCN3azUlRCiNOIsg1cTRx7rRJ7RE
         2lr0sRuuWOZgp1Puf35Aq+EN5qUYYiFqXNRsqIfeaE1g2cmUg3ttHtcaXQjGHtA4fPPA
         UIvdjdqbWYaZ3eqzEgXEWK+e8Bavg9JpyU+aYT/rHUvuYUUnGnriW0V+bjP0E4skCt9d
         Spkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728086359; x=1728691159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELTyDzpdOksZjoNrVzCSOk+1T+6UJusdniGL8nRZ6BA=;
        b=dd47YcJl9hrIneK+lIGyYljZNG63Ip1P4A0QYPzWHS4YJTCwBMnirOKMtr95gtdr37
         J88lPx6fbT4zXPRNlk1cQpBIPlsjDA+DI/iMQdY1xxLkTJSFTtleA9kuH9GRDxwXHUj2
         1GIYoHVmG5AVGXlZM84H6fibb5lUQSWtlHNiE5GJIQu2kteJ9i6HA+c0UkkVpGceyb5x
         JSg20QyZ+IMz3ke7JzpMupMoqy9atlDUhS4Pqqjegv6+UpFcoNhAef2KaEgbvq+iB3nk
         J59moJ6rP3/5VCxgT+v2aapCerqa5GfGeVTpcSCcxsZ1jD92K5YVWmT7MEsp3+bojcRV
         74lw==
X-Forwarded-Encrypted: i=1; AJvYcCVQPZFAApuZnRtXDS5l+Eu7f/zt1PuExMttCkE+x7Y+LMmrX9+lS9knL344V76aBKfixIlFWWULCq1OOzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRQELCuH3JbBEaGX6E2GjZJbuKBkFSm3z9mHOmX1qWgG5ZNH4
	nipNwMG6FhBRtcTYPrLUV6FFz0IS805xhWSBMp7pscO2pZe84MLn
X-Google-Smtp-Source: AGHT+IE4KeUCrGU0raePMGcI+7No2gZ8fga25JYXVow+n45+mMfBY6vGLyd1AwU6nr8w1On2GvMBAQ==
X-Received: by 2002:a17:902:e547:b0:20b:b75d:e8c1 with SMTP id d9443c01a7336-20bfde5567cmr72247025ad.4.1728086358935;
        Fri, 04 Oct 2024 16:59:18 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c13987571sm3841785ad.250.2024.10.04.16.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 16:59:18 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	David Wu <David.Wu3@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH] drm/amdgpu: prevent BO_HANDLES error from being overwritten
Date: Sat,  5 Oct 2024 05:29:04 +0530
Message-ID: <20241004235904.8605-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this patch, if multiple BO_HANDLES chunks were submitted,
the error -EINVAL would be correctly set but could be overwritten
by the return value from amdgpu_cs_p1_bo_handles(). This patch
ensures that once an error condition is detected, the function
returns immediately, avoiding the overwriting of the error code.

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1e475eb01417..543db0df9a31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -266,8 +266,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			/* Only a single BO list is allowed to simplify handling. */
 			if (p->bo_list)
 				ret = -EINVAL;
+			else
+				ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
 
-			ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
 			if (ret)
 				goto free_partial_kdata;
 			break;
-- 
2.46.0


