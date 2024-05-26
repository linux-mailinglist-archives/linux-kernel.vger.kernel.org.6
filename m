Return-Path: <linux-kernel+bounces-189723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E598CF412
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 13:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A017C1C20DA4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613141171A;
	Sun, 26 May 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsqxck4D"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67AC157
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716722449; cv=none; b=UdW4PAtWlk6RzPjhjeaJtkP6T4Gh9n8X5uo6r+FQXE4FTnkK5sUwwtbgfyqerQSM0SJ9NRe25EftAylValM6fTEoc10Q4f2lJ/HPo9bGjn9WvCl1OFxMyG0bkYKJm+4whMtzcccraa7siNM1OQH4vK3s3i0uhTnK3hNvGeRH1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716722449; c=relaxed/simple;
	bh=PNXgIt3Wa5nCdip+L1XbGJL1MjVLgBWcHtWc57wozJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzys22nCoqEdEiEYe8M8o484KQ+zejkHrkrYxXR311Xzmi+smO4Ll+9ZrU+Atn2A14a6YeDFzbqXAY4z/4VNAi3ELXcRIxmUeHRR/YQF9qcpZep0jZsCDVUhd2lWnzOiXsSJbhHtdvwDtydJRaslihFx7001TzRnZfj58XhrZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dsqxck4D; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59cc765c29so526049366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 04:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716722445; x=1717327245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMeY3O7seoqjcUFeqW+QpBJu4jLGTaciPn8DhAqDpcw=;
        b=Dsqxck4D1xpU48qAU03y0L7mWib+BvRYz7Yz5vYBWtrZ9EN+DsB1shm661tUndYETi
         lSKc0w+ne0UQNTBb1MXuVWys9DLq2bFYZf90gwaQoKjSX4qGrvOpA+aVoltAWGhSGbGq
         xLcWIOIi5yAlNqj7NIrHe21F6JDJvIUDhAba6i0BeMyAgE2q6LX9EcYMF7QANQs13DLO
         9g57Fy1gPL6vUtFdW9tIA4FB7R5jj7VKhhVeMWNMM2Ml33tNfc/RL/SQWL6bzqUMI0sW
         Rol+XdR42wYSsv4fED5JB5ceGSK/vicZM+0mp0jv0AfMqMR5dG+TiOA5aUsNpsNYPRtI
         Lxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716722445; x=1717327245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMeY3O7seoqjcUFeqW+QpBJu4jLGTaciPn8DhAqDpcw=;
        b=Hg+fz+5OBbJqkJ7asKOiEsAE/p65PHSnl9T7dS5y30PtcbfYD+SUQwcpHzjY9sFZFc
         kL253XoZifirh7nYnALDeyrB6UiaN+V4PNe6rnpTbY65tGUcI91FjuaAu2j4Mguwl/ra
         xu7mIQhNzweeAt5a/d18ypOxKdOzBH6kPbFdsHLOGnxmFEpkDjCCJcCWw/Fb8U/JgTx3
         ZYKCSEuuyQwo7LdfteTFDJ81JrQ5Pm/V+jz0ZvotXmBOGOn2pcAqeAfMGAlxWzcMny/K
         RxfKhoK0AsHG+kXcMbffS7xbCfxVRwlFmIfuUVAS2NmMC7tjvxvcL8YwACYcPg/oUGLs
         JIdA==
X-Forwarded-Encrypted: i=1; AJvYcCV0atzGiutkXsEs0C/T9Hrn9r+C5nIujvWQy8gze06vHc0mIJbvPF/n2eSaQqYrbhwxktQupTxKo59Z8lBiSeK1ySjVDRQgIQkqFk9A
X-Gm-Message-State: AOJu0Yx2mvf94gMdFe8fOBhPJyaD+UgBpieP5jxfJ7LYYujjA3sOJpuW
	ggwMNxAobnl8qcwX0EDnIXLzj0nkdlRgOk0bOzAjcKSqFqQZEnJfCn9TjQ==
X-Google-Smtp-Source: AGHT+IFD/6dFxk1qtUrHDVrEqJ7xiBgSakazac4QIdCJw84Y9ymI0JHD5eii0l03scgu6UvGCxsJnA==
X-Received: by 2002:a17:906:c59:b0:a5a:5b8b:d14 with SMTP id a640c23a62f3a-a62649c0862mr447888266b.40.1716722445282;
        Sun, 26 May 2024 04:20:45 -0700 (PDT)
Received: from localhost.localdomain (ip-77-25-34-87.web.vodafone.de. [77.25.34.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e534sm373983366b.170.2024.05.26.04.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 04:20:45 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8192e: remove dead code
Date: Sun, 26 May 2024 13:19:28 +0200
Message-ID: <20240526111928.14574-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240526111928.14574-1-straube.linux@gmail.com>
References: <20240526111928.14574-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove two else-if arms that do nothing.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 5392d2daf870..4e03eb100175 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1370,9 +1370,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 					tmp_sec_rssi = cur_rf_rssi;
 					sec_rssi_index = i;
 				}
-			} else if ((cur_rf_rssi < tmp_sec_rssi) &&
-					(cur_rf_rssi > tmp_min_rssi)) {
-				;
 			} else if (cur_rf_rssi == tmp_min_rssi) {
 				if (tmp_sec_rssi == tmp_min_rssi) {
 					tmp_min_rssi = cur_rf_rssi;
@@ -1426,9 +1423,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 						tmp_cck_sec_pwdb = cur_cck_pwdb;
 						cck_rx_ver2_sec_index = i;
 					}
-				} else if ((cur_cck_pwdb < tmp_cck_sec_pwdb) &&
-						(cur_cck_pwdb > tmp_cck_min_pwdb)) {
-					;
 				} else if (cur_cck_pwdb == tmp_cck_min_pwdb) {
 					if (tmp_cck_sec_pwdb == tmp_cck_min_pwdb)
 						tmp_cck_min_pwdb = cur_cck_pwdb;
-- 
2.45.1


