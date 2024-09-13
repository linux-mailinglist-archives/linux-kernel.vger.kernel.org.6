Return-Path: <linux-kernel+bounces-327434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66039775EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909C21F24B33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4830563C;
	Fri, 13 Sep 2024 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M57Nx7I3"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209B173
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726186323; cv=none; b=OCkxAT0SUicawsEk0ArSh2aBVTxMLvj9+UYagOusKXBf9d2ovGX9yF+b01+51XhuDEmq18xpy/4d4oNo/CeqXtuc/+n7azzthWSqJppPkmPNInKIinPRNM+Grc2naAHzqQwTbkoWQ94SkDAvcinKZMLAF9TN2T8BWFA4BFLTTtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726186323; c=relaxed/simple;
	bh=4bHlrLT0Y7h6kWcNBhSiGo39vtbFz9lZoVnlBXyMzFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PsyLei8FZGemoX2eEagvUUEhpOOiN/Mwti6JBVeLJyiYFf4TD6m955j9tFXsACPEs4JxIWJEZMJ4CFH9ua9DmO+B57aBfSkwgKHuRo5hujY4csUPlLvtpSvPk6k0e5apPEYs7jVj5YDk4BFHke184+NEnKUJxyP6HDGZXvcEtwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M57Nx7I3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso14661575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726186320; x=1726791120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1VVC89CjtWo5QJDEpjt4COs8h+KH+eSP/sYp+7PqSI=;
        b=M57Nx7I3Qm48YBaRk3UY50oERbW1axiak2F8jct9CDmcEIG2yl3DfPIAlWYYxg3Z+4
         fAufndP6IobumdO9FYFNJtRhBZdQaUjSbtbuzT4O1a3xobMVSlJVt/T4VdzBzd7e6AvF
         p2F1qvJyByUFBNzZV8TXedaSZrb6u9E/pkCXR9MtmqKUzUGrBU31zzX50QLoj8vXWjOd
         LVbIO/P7nRRs96Atl89mFnlPxyna3dI//VRYzOvZ9NgFTmkFJ3mMfhcXewoqTydZUjgn
         BSgZRK/6VLcjnuQ8PuIeJSxGH+9rT5qkyGhQAJQj5usHbirqXTjlKOqpksQ6KcPZQGJP
         rhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726186320; x=1726791120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1VVC89CjtWo5QJDEpjt4COs8h+KH+eSP/sYp+7PqSI=;
        b=WYfogjDIJckZ7xDkF6YsoUN0Ct9UBUXVdzSVES/gaLFgLcRQzqpWkJVhFSATGwx+2G
         +hiOYUf1WsX6jnW42jSEIRy/sIcUUWuXekB0xZYl/9theoTfIQ7qOOp/an7GqDl/Pa4n
         PKntC3PYQ6bysV4na0B0qWJyq1+NwEPQwA3nYJ8ENAc1TUT89Ul9ubX1MZOVNNsMGCbU
         LDyZiXFZL13aR1CQXZvQSigXy+EP5U+qpiYQn3IvqUJydpYYy5S1TABCh79GAdp4Wlwe
         R3XkU1aKMu9rYJwhpxBwA95SuxH0ymQvnwkZwZpoikUKvI1kLL44bObtheo4g6QMg6m3
         UjNA==
X-Forwarded-Encrypted: i=1; AJvYcCU+ldHFNq07YAvROSG/S1uP1cuW8tXZShTlVvgUVyNvaZ/ik6GB0hGVrUf6KJxveK+3EgsK8jdjKSlrbEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDRsHYbQjrhslrlipDMZ3qDCISb8Bm99vJiZpXgwIKHAkT41x
	AooGAvKrkqzPQQtX/KR3VaNMUGSqcg7MdITvHCQIQWXQ/h4aJGIu
X-Google-Smtp-Source: AGHT+IEGzAmYspOtVt8nmwDG+Sn38HCQP1W9OJHEufd1QFajnmY3ZWK0gmu6itOTP3RzmCrv9irZ9Q==
X-Received: by 2002:a05:600c:1c91:b0:42b:af52:2525 with SMTP id 5b1f17b1804b1-42cdb54dd62mr40724645e9.16.1726186320227;
        Thu, 12 Sep 2024 17:12:00 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b002a9asm6433075e9.0.2024.09.12.17.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 17:11:59 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: linux@armlinux.org.uk,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org
Cc: tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 0/1] Use functionality of irq_get_trigger_type()
Date: Fri, 13 Sep 2024 02:11:55 +0200
Message-Id: <20240913001156.56634-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
        - Split patches to subsystems
        - Add tag

---
v1: https://lore.kernel.org/all/20240902225534.130383-1-vassilisamir@gmail.com/

Vasileios Amoiridis (1):
  drm/i2c: tda998x: Make use of irq_get_trigger_type()

 drivers/gpu/drm/i2c/tda998x_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
-- 
2.25.1


