Return-Path: <linux-kernel+bounces-304106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226EE961A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAC01F24E97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C11C8FB0;
	Tue, 27 Aug 2024 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dktET4mf"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A81D417F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800363; cv=none; b=EjKgme4tkX+rQoLj1pHHRN0jrQV9gchwRdO0fDrwN7z6VU/LJjXYbNve0TdPY2jGRhpbnfxOnjhGKxh0GsxoFmIcdWuog+ix2ClXf3UP0IBSxWc/voEWd8bs4eAQ+gkUP5j3Gei6DD2Kw7Cn3PuCzc4VeujtZUfecexzXJbqa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800363; c=relaxed/simple;
	bh=GD0A4TPEYjATzBkKcTtoqywA1zBBEQMw9GL0OoeNNZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHTkkjSqMUm3dFb3AQvOpaL+xeGU6ggf0pn8pLQ9wyIEWWczlCwPF+Esxz4AnjatfIsC7/xnaHdCwGRZhGx/E93cmXrBleMOpjll9u4Ch2a/eM9y0v0umPbg8tzFtJY9Ok7PcXxRp9m9p400ci6W10hwqQANXR9dj4WWLc040zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dktET4mf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71434174201so4976263b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724800361; x=1725405161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pv/ufdYKY+CmjhMEr75QBezIaND5j1qCC0DSQMSozsk=;
        b=dktET4mfslvA1SJW4v2i9VkKPcQlLYahTgW+U3AWuHMNGvDXOJGlwPXS4ew418R0SV
         mkuNzi8zTWnevq+ZJ0XXpRIT58WtyzOIByoOLnqgHTOW0ucYGOAfS/5X4zhFSEbLFNi8
         pf50/b0YOdWHPl62OAKMhTx6TwuO60cg2msVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800361; x=1725405161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pv/ufdYKY+CmjhMEr75QBezIaND5j1qCC0DSQMSozsk=;
        b=jW8r12s6gljiRIo1Lm6EfY7xgPDaUVHb5/Vc76KYGrnPQPYpZOJTwKO7NPh5rq5Yek
         gh/1hAZhFtJvZqDZnQOY9OSlKN/pOeTI4dpdcN6VXKHFr6hjciZM7izOeKpcOkKbDIRW
         gPmPtDkVeKw9cQHMl/ZiqZAJB7aMcTi5HOGsfEUbGR2/pauAwnNr7kjcpAXYVwh29iIT
         b4Vv2OJKpdw5/prriPo+GusWsTDTIKVUK0oIebphzAuE8v8irLVs7Vam3LpSld1Wwe5x
         T2HAh7PhjXKYwhRAi0UjbN29zfyAHF/Ta0iQgK2V0drCicOkjK+H4xKHVnLEhuN5WBEX
         XshQ==
X-Gm-Message-State: AOJu0YwWL58xlIBGRviBfGaltMyp8d8sMKNHlWOGTtX+7bQliNLFCnie
	uqHzvSzBvBzkcBjF0pI01ep+06G6IJvejdBpErLtGaKNacCiHxAKinWdxxTITQ==
X-Google-Smtp-Source: AGHT+IH+n08Sk8Vd2lCCcbwAL0bOTX/nA5NdiPgGvH28H6kVXqenmkkshHPtYDCVpMQVH6rWErsfbg==
X-Received: by 2002:a05:6a20:6f01:b0:1c4:231e:8ee5 with SMTP id adf61e73a8af0-1ccd2899c54mr110535637.29.1724800360717;
        Tue, 27 Aug 2024 16:12:40 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7143424a525sm9016824b3a.49.2024.08.27.16.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 16:12:40 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	linux-clk@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH v2 0/2] clk: qcom: gcc-sm8550: Fix shared clk parking breakage
Date: Tue, 27 Aug 2024 16:12:33 -0700
Message-ID: <20240827231237.1014813-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amit Pundir reported[1] that a recent commit 01a0a6cc8cfd ("clk: qcom:
Park shared RCGs upon registration") broke USB and audio on sm8550-hdk.
These two patches fix the issue by skipping the parking bit of the
shared RCGs for all clks except for the ones that were causing trouble,
i.e. the display RCGs on sc7180.

The first patch is all that's required, while the second patch can be
applied anytime to simplify the QUP clks that don't need to be parked.

Changes from v1: https://lore.kernel.org/r/20240819233628.2074654-1-swboyd@chromium.org
 * Revert most of the bad patch, except for the sc7180 display clks that still
   want to park at init
 * Re-order series

[1] https://lore.kernel.org/CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com/

Stephen Boyd (2):
  clk: qcom: dispcc-sc7180: Only park display clks at init
  clk: qcom: gcc-sm8550: Don't use shared clk_ops for QUPs

 drivers/clk/qcom/clk-rcg.h       |  1 +
 drivers/clk/qcom/clk-rcg2.c      | 36 ++++++++++++++++++++--
 drivers/clk/qcom/dispcc-sc7180.c |  8 ++---
 drivers/clk/qcom/gcc-sm8550.c    | 52 ++++++++++++++++----------------
 4 files changed, 64 insertions(+), 33 deletions(-)


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
https://chromeos.dev


