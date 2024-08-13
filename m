Return-Path: <linux-kernel+bounces-284171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213E394FDDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B264BB2227B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525C23A8D8;
	Tue, 13 Aug 2024 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWbJVFxa"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75143AC4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530654; cv=none; b=ZDqQAxkhZudUIC/Sq00NEUdbznUgMyLOUtGW5IDkzZ0oQ5Np1010Q5c5IwzEqawfRdo5O33N5fjtmyecw4KtBhknYQ+KnD/GO7oGmVS04yFRJHuBUTDoxQzkTuY5JIUFgyjwLmYJvS7LcXJTeATZ+7NIy7cYVS5oLI9fga6RoEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530654; c=relaxed/simple;
	bh=qXiURgqLTvJ+d5IZLkl//G3kYa5RtZWyUJigTgrTOzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWEFkU/dooqmAjhjvST//qtZeI5Zc+gOyZAbvETDtyIinpxAlqLt1SkML5V2g0CMhZO5nVnw+SJFDjmXSjKFpe4suG1TfSl3+hjj85SiaTq0ekMbWq9X6Oe7IB5l5in/KcpKf7iKH7wCEYtlsOMkJQ8dj/cK0bfECaN67aH1RHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWbJVFxa; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db1657c0fdso3491341b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723530652; x=1724135452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5RjnB2Ejjysk1p3v/3xpGaZLkpRb/wTvNBtiPCwne78=;
        b=TWbJVFxaXtNhPvTPPajwPk1BwCIO6FqMP/l/UQB8SMF3mkTvF160oIJzEwgVwpT2V6
         39rpOOmVWlypPJzO8tgot/5blXjMJ/apdPlzpnBGyOgBqEtfJGvegVAvbUlAK44DEGiU
         +nknNZALWWa4SVCmN/GauLbAjKkb5iB57Zs7bj4tfU9Jg5VmVlDPdFWiPzL35nB6SALP
         rerfUMRw1VhFO/GIb02D0iy55o6cO0GoOe665B5nyuw/g4CJfpiUU8Z9TKwdwgk1BN9P
         RC3dXxXkFzg1MNbiak8UdjhPrvX7OJY31oytl3chs5+sPaQOzNHWYkuL5HB2O1VU53h5
         UNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723530652; x=1724135452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RjnB2Ejjysk1p3v/3xpGaZLkpRb/wTvNBtiPCwne78=;
        b=ESI/k/1I/+yDayiek8sTYCK7jGMtEpsx6JgRajKyPMpA1OFtaRrnODUmgSQnfVCLjg
         s3zYEo9Eqaw8ZRvcJaVD+EneRi5vdUjx38zwZiMhEIw5Pd7KcFFKkRbra/Nzvgxt8hqt
         MdUAAHcw3uneQ8HXVSfGHVrSj5U6B5dID93fdlxDYaNr9I4EFpk3iutgKDL9RigdMUoN
         IyhxZZKpQT3CNGCsOWtZAUqBHxVoKZRtpNuvWztO+XO2Ti9SyPKQimECjgCDZSKEsQqH
         ZH8eynW6Ijq2ukuOHxg4hqyHBERImLgce6WmsO3avslxWVOmqugBfUVNhYSeMolXNxQj
         f0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUcUkqGpc5h/r6RUjYGOnlucG/huaNMyEL4rr/TYUhddmxWbczQ4FTKLBoQtm2VRtSbHFPEWNnF+CVZwaG0XSwJMq5oafXPBKeFUZ05
X-Gm-Message-State: AOJu0YzkV3mkiwSDs5IaKGu/5KmPc7ZQefr3qppD8qSthvEo0SLY+MRP
	wwS0XzE2BzT9yXmW2YwXRhZacAUjgzMvTxYl/rcyPWicZ9XyTjeV
X-Google-Smtp-Source: AGHT+IGWG6T741zNdayCHhZwDY54mzMFQZL/0A6jqcyQWCSStl0xCaWHAMs617lXXlsj4XM6ZDSe9w==
X-Received: by 2002:a05:6870:4597:b0:264:956e:6207 with SMTP id 586e51a60fabf-26fcb6b53d7mr3102946fac.27.1723530652220;
        Mon, 12 Aug 2024 23:30:52 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([2401:4900:6325:9539:8b89:ebee:b1a0:5ff9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5874ef7sm4991965b3a.38.2024.08.12.23.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 23:30:51 -0700 (PDT)
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
Subject: [PATCH v2 0/2] extend "multi" functions and use them in jdi-fhd-r63452
Date: Tue, 13 Aug 2024 11:59:10 +0530
Message-ID: <20240813062912.467280-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds mipi_dsi_dcs_set_tear_scanline_multi to the list of multi
functions and uses it with other multi functions in the jdi-fhd-r63452
panel.

This patch uses functions introduced in [1] and must be applied after
it.

[1] https://lore.kernel.org/all/20240806135949.468636-1-tejasvipin76@gmail.com/
---
Changes in v2:
    - Fixed return values
    - Removed extra error messages

v1: https://lore.kernel.org/all/20240810045404.188146-1-tejasvipin76@gmail.com/
---
Tejas Vipin (2):
  drm/mipi-dsi: Add mipi_dsi_dcs_set_tear_scanline_multi
  drm/panel: jdi-fhd-r63452: transition to mipi_dsi wrapped functions

 drivers/gpu/drm/drm_mipi_dsi.c               |  31 ++++
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 150 ++++++-------------
 include/drm/drm_mipi_dsi.h                   |   2 +
 3 files changed, 82 insertions(+), 101 deletions(-)

-- 
2.46.0


