Return-Path: <linux-kernel+bounces-232953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA27291B06C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C9D2843F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE9819E827;
	Thu, 27 Jun 2024 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="CZc8lIi7"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB08319DF9F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520299; cv=none; b=PjoLAXYY5Bw+zHXNzEaB5HNKpW5nQhNdTDzGMBge0mYuRQpIROVx5B7TtVj3B1FEmfDVYzzY9JKclJRhe5zJdsKt8PRnMDtQKDeNRZiPypDnG6nkSzYR/I5k2fpfYpi2x/75qxIR4HdkMGvNIxkBF8Ya6y7eTLh1OPwt/Q0Cin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520299; c=relaxed/simple;
	bh=+vToUt384X/YLee2duLmghnbpUCboHGj/KJubnYF3t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndqAfqcn/QcKZh6utZL1zEYxblh92XDspqD24IX/Vh/o5pYUlfguEu21Wj861W5R9rwJhJ1AfSkAy21GCTmszqDk5lRc7fYP2/YIdxH/pIFpmUli+Un+GUeCWSZpMV/9IptFy52Ok4TmdX7nEkIrgOXmiDi7rQ5C75ZeqQYt2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=CZc8lIi7; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25d5333989dso1507257fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719520297; x=1720125097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IORRBfp0Ewdr4NJXGZVsVL9mCEVSyuiUr27OIsqu6N0=;
        b=CZc8lIi7wsGV9H9cDJmO4LwJeHhcQuiYeO5IF/CfGiJjsildIC8XBlSFnmyvUJonG+
         8gMhraU6WLuWBINOVxhqjmMyiggbXGWw3cvojk/su2GNPT6LVq4FCKoMvPxcE540awfZ
         wqp7P9pKcYhXOdK/GBnzMvf9E9pKo8h2joVnQpMnaLMYooLf94fiH0HreDNywHqENmuJ
         09wCShPeZNcCTIlEkYJdhMwp9L4BidgUMx5MYY51r6IW+kNj0S79LXkqmhjxrzoc07Nw
         2sAoalbZclAl+W9ZqxKnkQGj8Uj716H4cMSLRMrySZ+pfueThlfuTnEBBBN/n+YFlYOV
         Xtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520297; x=1720125097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IORRBfp0Ewdr4NJXGZVsVL9mCEVSyuiUr27OIsqu6N0=;
        b=tviWq/A+c4l60223MD8kfaBJweqeFT51t25R+Pl/yklbxve6/YEwWDNj9IYNgKE8HU
         jpqUWkj6S31PB5VXBcfnmYRHMSDagXc6DP8h7NKiDfvCKM3X+sLmPnj6cIqRyGexd8LP
         z4S7yThk8ZlxSpF9bJj9Tw7h3tgu2iITHYcADAYhSKZZNJLS7PaoM8v3sEmivim4rCKG
         AIiTpsQY7WwS1GqF+EHOUGr3hRpgjkpPF/bPyZO5e4Sa2gp+WdcG7Q8qtGP6EDh3Z1H4
         MTDPrhIIfFdksDsybLwppyGYtPUfFm4Wh+UhxjAjjX3ecH2g1+8dtWeyx/OtnQhVXGF4
         K/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWzsd5dtAlGuY4rBh3bcMF+aM6CNMRg0TPXhyWwgKEN0zuqubZGBunfiFuRiXr3eco4P0XdgOdB77I+qhR/9d3JOw89q3auLGZTbS1x
X-Gm-Message-State: AOJu0YxTnYC3pDgHplllPFnxc9wndvwbyT8hAjbIFA0vjdAJsalO7kg+
	Ig+zTP4v0d/pA+RDmeGfdSsq6XeGfPN5yvh+qviSsZaoLNrKV6k1ytd2bChh5g==
X-Google-Smtp-Source: AGHT+IEBJYSCM9h1b35iPFvP+zkfebU7K58zBaeRlZZJLp0lbUnbdhB4vQ78TWCJKZsLanCWzd/izw==
X-Received: by 2002:a05:6870:71d4:b0:258:3455:4b37 with SMTP id 586e51a60fabf-25d06eff0e4mr15152508fac.59.1719520296945;
        Thu, 27 Jun 2024 13:31:36 -0700 (PDT)
Received: from aw-m18-r1.. (syn-023-241-237-137.res.spectrum.com. [23.241.237.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e63250sm140514b3a.29.2024.06.27.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:31:36 -0700 (PDT)
From: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>
X-Google-Original-From: Matthew Schwartz <mattschwartz@gwu.edu>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: John Schoenick <johns@valvesoftware.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Hans de Goede <hdegoede@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <mattschwartz@gwu.edu>
Subject: [PATCH v3 2/2] drm: panel-orientation-quirks: Add labels for both Valve Steam Deck revisions
Date: Thu, 27 Jun 2024 13:30:57 -0700
Message-ID: <20240627203057.127034-3-mattschwartz@gwu.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627203057.127034-1-mattschwartz@gwu.edu>
References: <20240627203057.127034-1-mattschwartz@gwu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This accounts for the existence of two Steam Deck revisions 
instead of a single revision

Signed-off-by: Matthew Schwartz <mattschwartz@gwu.edu>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index ac8319d38e37..3f84d7527793 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -420,14 +420,14 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galaxy Book 10.6"),
 		},
 		.driver_data = (void *)&lcd1280x1920_rightside_up,
-	}, {	/* Valve Steam Deck */
+	}, {	/* Valve Steam Deck (Jupiter) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
-	}, {	/* Valve Steam Deck */
+	}, {	/* Valve Steam Deck (Galileo) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
-- 
2.45.2


