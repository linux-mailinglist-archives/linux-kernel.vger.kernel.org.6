Return-Path: <linux-kernel+bounces-259152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AA49391F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1051C1C21572
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DDB16EB4F;
	Mon, 22 Jul 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP5yirmN"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21916E88B;
	Mon, 22 Jul 2024 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662782; cv=none; b=PDUWXZXGwnlpu84RP3Ru9QFtXiIGGSepZmYhkAyWw5eN6D5P7lOmRiVIEJ/RVI99kCtt3cI8evNlxQsN6SCQNdLL7YT0i8yo3QZH7ep26ZyGxSLzfq50xSFez5o8ZwNsBYxskWaNkH79Q56hyS9P/h2k+Gww8sFk7uIcnZOgPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662782; c=relaxed/simple;
	bh=HoAu3Q7YXEdfSInSzOu7vZeJB9+zbcTyotdzvCM1fPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DlSapqJ11Sikaorqd8RfkRT3dmpukhNF/jbbR8bM91Rh9dQu9gISoIGLAdS6mNUScd9iadxZiYeFA/Py/KBCbNtbCNSDGu69yBxT1Cu0apKTs5tSc/gKqymWTP9COsaikdqllE43JkeYtAtVz1BBMUeFTQ9ONmGlAVEj7MD6mdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP5yirmN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so66933401fa.2;
        Mon, 22 Jul 2024 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721662779; x=1722267579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jALI6UyYbNYiJLxWXhrO5w7i6Qk20r5OJVMCi7IoOuI=;
        b=OP5yirmNOI5DdSX7zFbRhs3ouG8fC6hvKmFxOOaPGIGik0NZB9uQdIdogWrXP1KS5Z
         wTt9MPqmidclMsunGcwe8TNu0jiZsKgK5krIZ3yF5I4U4fNHaoRv97csvW4JMk9JTN1g
         XJGZ0UD7zAP505ZcnSD/7IimTWzC86xI7CDZHZvo/VAWfVnv31em91baBuKZjNR7cuLO
         UEalDYlJRAf9NypD+k6EpNVz/j1W73DvQwmrwidrLFfMZSmVmiJsJEsR/X6W/YdgTb2g
         ayF7DM9Lv/Tv/TM8/q0zgmOtLW/+BQtKpAQfSpcxqYtD1zDJGSXGEA5DUfVQOdjU49MB
         KpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721662779; x=1722267579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jALI6UyYbNYiJLxWXhrO5w7i6Qk20r5OJVMCi7IoOuI=;
        b=nw1k2jTbdSK6r/r46015Zfg71075y2Q6wW8uFbEavBY8cPkTQMrnBYtj684kxGsBqe
         m7hbpTMYnkmjX0Baxt0Uuf4J32ZY+D9uzFzHZgSCZKBAB0BuTr2XAZc/ovbEYysUes+z
         XU8jPakae+kSrGM2cEScGUjnzIkSmg/2rQRwI+S6eETHG9+7YmD8m7AufAM9kK8+GlFc
         qjXkgIUxid1DBIRORT0JVfOMOSJ1+wCuRnn3f1k4B86A1oWb77AR0XPwyWjr78LEwbuV
         BjkTIH75/oQ5fj+++8w5cXtr/m3nLnAcdaupoS6WvC7jh2t/L+yKrV4UXP1AC0M3IjjZ
         ZPUg==
X-Forwarded-Encrypted: i=1; AJvYcCW1k+sM6ZO2ntoHPI4j/fsMXy6L4tShtE97Sj2CFlztCsYVzHtDJ7seF4cujRNBWWmjusUrY/RavHHeyAmcRM+xRAaV+of7J7NMysIg
X-Gm-Message-State: AOJu0YxstSZbqEPRiL/GiglDh6BRo2lAHrLmGP8DW+hq+msp82tQ5Rsn
	t3M2f/JcL9AZDnJK3INBjUizajUzjxX0O6ZMIPZwEDtNWT8wd++g
X-Google-Smtp-Source: AGHT+IEhKUeP+/D9FQONxFDVZjw8vfePr2AjP+B5tksegFlWs6Qyu1RK+OOhND9kOEGL7YES1M1u1A==
X-Received: by 2002:a2e:7a04:0:b0:2ef:2eb9:5e55 with SMTP id 38308e7fff4ca-2ef2eb95ea2mr24921191fa.13.1721662778449;
        Mon, 22 Jul 2024 08:39:38 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2920313sm117230425e9.0.2024.07.22.08.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:39:37 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/dp: Make read-only array bw_gbps static const
Date: Mon, 22 Jul 2024 16:39:37 +0100
Message-Id: <20240722153937.574819-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array bw_gbps on the stack at run time,
instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 59f11af3b0a1..a082ed8f5464 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3434,7 +3434,7 @@ static void intel_dp_get_pcon_dsc_cap(struct intel_dp *intel_dp)
 
 static int intel_dp_pcon_get_frl_mask(u8 frl_bw_mask)
 {
-	int bw_gbps[] = {9, 18, 24, 32, 40, 48};
+	static const int bw_gbps[] = {9, 18, 24, 32, 40, 48};
 	int i;
 
 	for (i = ARRAY_SIZE(bw_gbps) - 1; i >= 0; i--) {
-- 
2.39.2


