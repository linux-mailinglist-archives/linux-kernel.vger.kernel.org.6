Return-Path: <linux-kernel+bounces-232850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E9391AF08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10451F241CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151019AA47;
	Thu, 27 Jun 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="VA4SpBYt"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664B1CD31
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512836; cv=none; b=f/cQsQSQxcQ2dFblqG/z1691Xc+/s2Kv/NGs+BuutJLN684WJjX16I5DSEF0un8XemK/9EbDzE1LBwT9AcTH1DdlkSp9j6pyLnxHtnErBlcOsN9nCp5eoAVueH65Lo30TTErxUgwVHIufUazkpZ+9t7dgatxsVN2jTbqLfwza2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512836; c=relaxed/simple;
	bh=qGmZ54javUBer9i48bf17GmuVyc0Ot8E5Nz9k8mzUBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRV+ZvGrGrmtGWOzk42IPzikXgQozPaWVHyULDpHggcvdMxrEvQen1iHDe1C4SXm2ZnAJXHMQDchPBrHFBKhKaSYiWUdY3uQlRoMin+0c1cF+wgN63Vk/VgJnf5JipW2kIldmbL+XbHF/6GWS7FrIzrb4FHT92dCAatAhqlh2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=VA4SpBYt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f9e2affc8cso54117355ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719512833; x=1720117633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puKEntbYEmMEidhzP0NA7FT52xgsmmmBOCRFF0y7bVk=;
        b=VA4SpBYtlan5nirASRC5+KW85cp1liH+UukJbHGHuIeSSzDRdwvcfaGKIZ2iLaVEzp
         udeMRxRRseKmdgSANlDFnXO5OhkdouyAI75ygRt3wunIjeyA4CeKaVDxSeGeBsK+PSUQ
         oM7Ah+Jq+MqOqCLoSqlHqlWhx6UfpKYRFzbqqRRjsQO9gY8PHb/1IZPEU1/K3isTdoFZ
         WfJT52Gv24Gyhz6obr9XVpty3FHPRst35bbZM3xSd5fRdIjllQvs/exbcDFcgKezx3Ov
         rU8FnigAmkqbO1LqThohRaKzTP4doWLaFlESbSkLHTeJCNWIZEZL7RXlBMRO8pVS19Hf
         W/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719512833; x=1720117633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puKEntbYEmMEidhzP0NA7FT52xgsmmmBOCRFF0y7bVk=;
        b=m+DcsDPDeHBtYgvoofI5iDn/DhFop7y2Gu/8l8iSHVGRaguuSCwQOiOSRrYcDjVfeV
         GwoTXelhDO1XBDObf687Aa5YnFFKYsR2J615evLD/WmVMMKaIkvC3LLjCUr9gpHgy8T3
         eO394gCBjjUgtk/9i2N1bbfhhe1Mdv46vW9RRCOQxoiLYzDVfZgJKijswxGmelJj8Y26
         icl6H2YxNiWqh7ZyEe43nS3T6Rxf6yKKtSvxO2+cnhjSFm+a7cnVxEuZD/MLDvSFMV1V
         qUWruuOicXX1q/BodRmYi2f7wgW48jhibonvSaYnuDiXy/huhgCPV8eS5JS5S6xofACX
         W3oA==
X-Forwarded-Encrypted: i=1; AJvYcCUxSds+CDiW1ag4NsCeOesMe2zatQi9Prx0/o9ckscZRjsqJFLff4orsEiZQbiclDVj5qGnr9TynOCS8pAjx1YISjVAoe2CTyoSAb4h
X-Gm-Message-State: AOJu0YwzlwXLN0sjtXWJ6YB1VFuZ2N5wKgaXvsuVdiK7Fax31vANw+ed
	99rYxLmzMsLkDvWK0akY8ht2eKAuERDpSqpgvxmL2LuyukwAJCW2ai/5zde41Q==
X-Google-Smtp-Source: AGHT+IE7K7ae4HNLZS6+iF+fFNm5LOjTtJFBS3YMKiPav776AhwOPxZBhDFhHhh9h1LgNxSHFxIFWA==
X-Received: by 2002:a17:90a:784a:b0:2c4:b515:46d4 with SMTP id 98e67ed59e1d1-2c861224475mr11183473a91.3.1719512833539;
        Thu, 27 Jun 2024 11:27:13 -0700 (PDT)
Received: from aw-m18-r1.. (syn-023-241-237-137.res.spectrum.com. [23.241.237.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3eb34bsm94490a91.56.2024.06.27.11.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:27:13 -0700 (PDT)
From: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>
X-Google-Original-From: Matthew Schwartz <mattschwartz@gwu.edu>
To: mario.limonciello@amd.com
Cc: dri-devel@lists.freedesktop.org,
	hdegoede@redhat.com,
	johns@valvesoftware.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mattschwartz@gwmail.gwu.edu,
	mattschwartz@gwu.edu,
	me@kylegospodneti.ch,
	mripard@kernel.org,
	tzimmermann@suse.de
Subject: [PATCH V2 1/2] drm: panel-orientation-quirks: Add quirk for Valve Galileo
Date: Thu, 27 Jun 2024 11:27:02 -0700
Message-ID: <20240627182702.85260-1-mattschwartz@gwu.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <a160a3b4-1193-490c-aa25-8761142f4e08@amd.com>
References: <a160a3b4-1193-490c-aa25-8761142f4e08@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Schoenick <johns@valvesoftware.com>

Valve's Steam Deck Galileo revision has a 800x1280 OLED panel

Suggested-by: John Schoenick <johns@valvesoftware.com>
Link: https://gitlab.com/evlaV/linux-integration/-/commit/d2522d8bf88b35a8cf6978afbbd55c80d2d53f4f
Signed-off-by: Matthew Schwartz <mattschwartz@gwu.edu>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3d127127e7cb..ac8319d38e37 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -427,6 +427,13 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* Valve Steam Deck */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* VIOS LTH17 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "VIOS"),
-- 
2.45.2


