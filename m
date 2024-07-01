Return-Path: <linux-kernel+bounces-236808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F26291E755
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAAA282035
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C59516EBF8;
	Mon,  1 Jul 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAYlA3SA"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16816EB6E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857998; cv=none; b=VLOMokKwQlDy0p2NxpAuNRaHCWxQVrQOqZnA/Br8gIKYJ3oX9malnyGbqJEA3xV8B6E9KSqsuoMJ0rKU9oaC3SZTnb9O+AJF0woyGuTKjtQb+CD2/oTQkBYqZlhlW8593wZq2TI1EFfDbmOhj9rOOe4WG8nfta57p7kDj8xc3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857998; c=relaxed/simple;
	bh=ylhHcMcrV547eodmRYkpw1mRL3EmELvfcMwfUScqkIM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HyOBUO6ldEBqqy2okQD2N/Pd/NGWZ65lf50nm0m+5NjDJXqqBJpvJeBafH0dABkhZHCQwElsHXfTjzJuMsVKiQe5u7u6kyhOtmtXynUzpqpbPv/xGu3fMTgu9WZlxfv+p1AnOaxa1ZgJ7ZfwlcszePv7driV+pVgF59DxmNQk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IAYlA3SA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e8037f8a5so2952466e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719857995; x=1720462795; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc8qe8OV1S444E4eAxywBVqkh1cFkYHUloMOx0jwCMU=;
        b=IAYlA3SArwJmqeqE/X74HrzfyxSVKe0wuESCerXanrh5qoNlywmZ9NIW9pYrIUPxmn
         IAczv++wt9+0p1Q2b4ZtWFo9dFFcGScy4uYjQe+dOSwcPq8IwQjxf5BrEQxv9yUI6w7f
         +WRqzVJhGV9MAischb4nOrDkY1Bg0Fab0P2kRKpCQeip3zI3pOmUW7Py2NptubJUWN5E
         UdxXCL2caHtfiprRmSiLj7DQYjQ1knlqcKvxcgh7kHhi4xQS1dwnl2tLo3BxnCIW4yrD
         jVpin/ADqVnbK+U3uyh5zmGqwl2ttJDaGVNvsrAqH6BEsaTPlJNb9veh/zeWsZMDUwKr
         x+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719857995; x=1720462795;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dc8qe8OV1S444E4eAxywBVqkh1cFkYHUloMOx0jwCMU=;
        b=szj+7i1Con65BguHyGeNN1Kmbq5CKPuNK9z1ikHvINYtmQZwfBdVPN3X3fb8EsOp5v
         pdZMdXL5Bmgf1ITQAnhRh2wPZJVA6qzmk2BMHPFtelieUS44ANW1i50SAWtd2KG4xMNE
         s5uIH8MWzSVPRQXGUR4DE4sKdr2fVCBkmDWMPQJtOt3gYKjZBFcZpvvQ4acJn6D70Gln
         GR1f+UgoZUh36rBpc0pIMcMWBwHKSoSYW9iBqE1TRS2qWAmU3OsWaihtKRUsoeP2EBIL
         OpcDbxN6LsOIHgLPaWnsWiSlzNKv3mnmsYMrJ/V6P5YyteaGjq8NrcklwLUIuvHQyp9i
         Ko8g==
X-Forwarded-Encrypted: i=1; AJvYcCXRnasVtHJpKu2STLmbNICbcbP5b9Z+7Iyj1EA4m/iNrDhO4c4hDIK2ZOIg8jJC2uqenTcajWS8TinDa/SuGOPOQsMHR83IxQb7y5oS
X-Gm-Message-State: AOJu0YwN8qm2e5Qb4DCQfroRL2LEF4flkzx1sXE8c7ffmLr9oy3ulEd3
	W87g2dAc5xEL2SdUe/51CT3x/gc5BzW9/gJOzY38C5zbt10oUtaWoKWfyP/regI=
X-Google-Smtp-Source: AGHT+IE4IdVlZK7nZQIeEVkkvUvINFjYJUC7b47ExpSB23jlnenL9jSphPJ7dU2iRcVHdNJHXwSzsA==
X-Received: by 2002:ac2:4c4d:0:b0:52c:d76f:7f61 with SMTP id 2adb3069b0e04-52e82747e5bmr5232300e87.56.1719857994731;
        Mon, 01 Jul 2024 11:19:54 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2f8aasm1516931e87.236.2024.07.01.11.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:19:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] drm/bridge: lt9611uxc: require
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date: Mon, 01 Jul 2024 21:19:51 +0300
Message-Id: <20240701-lt9611uxc-next-bridge-v1-0-665bce5fdaaa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEfzgmYC/x2MWwqAIBAAryL7ndBK76tEH6VbLYSFWgjh3ZM+B
 2bmBU+OycMgXnD0sOfTZsBCgN5nu5FkkxlUqaqyUbU8Qt8g3lFLSzHIxbHJUt2p1vQLtqtGyO3
 laOX4f8cppQ/yk2+PZwAAAA==
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=761;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ylhHcMcrV547eodmRYkpw1mRL3EmELvfcMwfUScqkIM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1rTZ88pt9Y2V86p8u54kdJ5r5j3wsJdWR53+Mr3W2/fE
 l48wUm6k9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATUdJg/ysgfrKgcXH/zwPN
 F6J2CXvNCtzwxvRIatjrd+uWrKlQXpaRMT0u/1T0g+OrONiDe8++P9OpafWwJ0TspY5P6HRrx23
 T7J0KejQXNU04yOaYzvD4YVyYrN/qjnqrP53xDe/lTzx9+GeVc7lYrJOK5k0RgfhPP/eE6i+PVD
 6d/kwwvHJJyxUT2f7pou8yf2oriPm+kZ1ZwrNQ1e3V1pk7bx+4xvIqoldaoaBM9ITPXoPzC1sn8
 9bfdt3t3+nZIftctcRuYydLkHZ+9aLvMRuDDz4rVrL5eUGlouPCJ+nS0tcPU1PCrd+4bFn7p6ei
 vXGNRMovk1PtL+LKkkuK5QVCtBfNnzL/ZmK5x6FzYZmbAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There are no in-kernel DTs that use Lontium LT9611UXC bridge and still
require creation of the drm_connector by the bridge on attachment.
Drop support for !DRM_BRIDGE_ATTACH_NO_CONNECTOR by the driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      drm/bridge: lt9611uxc: properly attach to a next bridge
      drm/bridge: lt9611uxc: drop support for !DRM_BRIDGE_ATTACH_NO_CONNECTOR

 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 103 ++++-------------------------
 1 file changed, 12 insertions(+), 91 deletions(-)
---
base-commit: 74564adfd3521d9e322cfc345fdc132df80f3c79
change-id: 20240625-lt9611uxc-next-bridge-5827d9b17fc1

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


