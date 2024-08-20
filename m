Return-Path: <linux-kernel+bounces-293604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4290F9581E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751FB1C23E79
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC30618B49F;
	Tue, 20 Aug 2024 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB7LrRJ8"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AAB18B497
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145365; cv=none; b=V5dvcbOYvbIpKfIRwKSU7+YePsnGx0KGXf+N0FfuLIM3h/XGa6EB0ClLjQTUwrhl8hq7IxOoprOx70MnBSrlkHjKNTg4BugckQnE0Lq/MqlCQcVHOHla7Q+/qj9aJSyt94MmH/1hoHJyaThzzdSUs+bHX+vC00UkVGkUWlpQsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145365; c=relaxed/simple;
	bh=rk+eNG5Dsjw9doih4G4jchv6L/Zq0rXyNMooY+3Sghg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW1zRu3BJ3fUczM4Bc4Xmgd4u9gHyJSieHgrrvPhY5qBU4txiWksJpFrN8VLYcIZSY4mclvVRpq/UYHOTONJTuUkM8DNwiKgETJlUo7+MYpG0Uga6j/IevyKmqJjyYu2qbkZzp/dXAAKBxjLHoJOC8U/8cNJx/8MDogBbRMenZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB7LrRJ8; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db504ab5f3so2847231b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724145363; x=1724750163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEzsuAyxIJQ2n0K0P315etHjhvAYDi+x+2AtvQWPcYQ=;
        b=nB7LrRJ8dw6NCGKSZBNWNO7Dhd9JKkbFK0vO/8Q/W/v5HFVXWtT/zP/XZMhbG5mFaR
         9ioSBp0MeKBYj7abPdyXKj4NTY5r2p+f/iBNelIb9JL2pdnuW0oO9zLNF2vfkRAxaspV
         QfC5sbLTEPF64NXGcHyMHaR54YIzq42P1dR3aAakSeUx6IPv9jEob8QqIYOMuigtQqXi
         lC5IA/lw6Zutdupw9tIpvO9BelHEBkQnpYTRD3h9Sr5Sm/p7n0wkqUR2tmkabml15lG1
         BxW2BLyQNCRRuNuCS5tsdKoApsCiYslp2ACAHNsvFCwxsKRnIRHL3C04NFawbAeMgI9n
         RloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145363; x=1724750163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEzsuAyxIJQ2n0K0P315etHjhvAYDi+x+2AtvQWPcYQ=;
        b=EFbJWRR/stY/pFwGoPNF3XPkrUjFnSdNZdLXtHSxwjiqgiYd/W2hZX5nxnht0xnNjN
         tXvaS3chk+OZ7Bm2lSl0sK6DTsVPz6A+QUZ4YUy2RHLT80r+AP9whePA984e7xyuawY6
         k8iJY1xx+gwDICaxx4qD23WyK7rlSBMOS0Ag/alqgB5sTBggQSAKUcumMgz1eoE0Sqhw
         dQSPoa6VYn8WdDQWT83+b4wL64nOoiRyoKmoF6fLHsD1XS7TZq77vIcQ2HmOSqkwTgCJ
         EaO9Nty4M6YoqTEDEqqWZP7za07a6wmk8z6WbvYHLeB9po21qtsQO8tyEY7zhML5uPiv
         Exjg==
X-Forwarded-Encrypted: i=1; AJvYcCUc4iJ6NYpqsNH/colCfhXdRd4fJeOICCugc/OmkgYbiknpEjxD8VC9wp1wVgtA6SBFZwCbNEICy++AUUZ7nTVtH/1esmd8L6qbpU9I
X-Gm-Message-State: AOJu0Yz62vgf4l1kfPm3o5m15A1By10iak2ZibKLJNrRgC5zSNFmP/HZ
	/UbTWVOtTGsUm4Y63unvvLfA+4kXuyFHNT2dHTcZT4tHo8asagft
X-Google-Smtp-Source: AGHT+IH5K7IcdwKnFaD0T7b4kkiNPFD/N1qEOXmHqQcQDA9rgegaxQpq3arNpu62aADXtOOwqoqmWQ==
X-Received: by 2002:a05:6870:c113:b0:260:ff2f:9d24 with SMTP id 586e51a60fabf-2701c522a26mr14798077fac.33.1724145362725;
        Tue, 20 Aug 2024 02:16:02 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c6f12sm8998575a12.35.2024.08.20.02.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:16:02 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: agx@sigxcpu.org,
	kernel@puri.sm,
	neil.armstrong@linaro.org
Cc: dianders@chromium.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2 0/2] convert mantix-mlaf057we51 to use multi style functions and cleanup
Date: Tue, 20 Aug 2024 14:45:52 +0530
Message-ID: <20240820091556.1032726-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uses mipi_dsi_*_multi function in the mantix-mlaf057we51 panel and
converting uppercase hex to lowercase hex for cleanup.
---
Changes in v2:
    - Split cleanup changes into separate patch

v1: https://lore.kernel.org/all/20240818072356.870465-1-tejasvipin76@gmail.com/
---
Tejas Vipin (2):
  drm/panel: mantix-mlaf057we51: transition to mipi_dsi wrapped
    functions
  drm/panel: mantix-mlaf057we51: write hex in lowercase

 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 79 +++++++------------
 1 file changed, 27 insertions(+), 52 deletions(-)

-- 
2.46.0


