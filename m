Return-Path: <linux-kernel+bounces-234536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F4F91C7AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1C21F237C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240707D07F;
	Fri, 28 Jun 2024 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="KbDEyhCw"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE77BAFF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608340; cv=none; b=Cf/xntZvWO+O80BHrRQX4MRwBh23SJiyAF5RwTw9P8isFdUh6k3PJmqIckubszOFKsxlvrwasyVbglcOsuBMCqz0Ch87YZlVpkRrdzpHbJ6z18TzCBQ0C2sdnASh52gThYJwv2rL4h7nDX8sqQy3e0xiAbecdl7auJrDhjZ5tFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608340; c=relaxed/simple;
	bh=PTuMJPBBEF9CC2+fUC+V6BOrRePdBquP5IMKpAMmDLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM7+r8P2bqp42L47YkKr/emGgsO1NEQXhF/RRTfu58O1g+wbCPRmS+LLdJ/sUchRX7+uxwbv7MJPjKlKfddvykhj5GBClY9JKu2xu3Ov4bCRTS3YKV/DPrO/NePeDYYV6f+Ov8VZ+t4cjmISP8O+QuRonJ8y/HHxzVJrzfRi3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu; spf=pass smtp.mailfrom=gwmail.gwu.edu; dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b=KbDEyhCw; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gwmail.gwu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwmail.gwu.edu
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso634510a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1719608338; x=1720213138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rye0EiFm+y+n48tR08Db7FMxQ3LsbJVQj2rHhzZ+sco=;
        b=KbDEyhCwnBqgZMuNM+LHplZaF62nU+iBcVX9nzepn4sf/4Qe/q+1vtA8XAq51b4V5M
         TIFosRXPIdXwwMj5kDi+WgfJHZsnu3MmXqzgcf19P7/ywWq3qjQEFzFNF8jGqpWCVXiy
         LCVulo6ZO3HMo1HOfQTIHte7TdJhQGSPM8gp46JmDVUvGPjHeW1K3019Pe0RnCQ2gEyT
         0mpQYesHLUrGCXd3J14tka8p/x1JL7jh2dQr8IPUQAMuYXrWGJxE3QSIFNh7aKILf+n1
         nsSfkPIw2EUgGUU5dCCmTtAzzvt/5itUiJYG+xdCh/ka1MfICohWjiACjYBT3S0TXDcb
         3qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608338; x=1720213138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rye0EiFm+y+n48tR08Db7FMxQ3LsbJVQj2rHhzZ+sco=;
        b=aG5KTujsUhFJTozrdLYmNtvEvZV+iKsISCTS7p7pu+PKPvISRv8xsIFOIEvhIgCE7I
         DDoIrXkrvawnvO5lQksvpqH0uj17QwcQ/mOx2C/+uBQRxgq7rkOpLh+JZG9OkZ7IM8DH
         HK1OO6D8FU1pyyXxXf+aqMmOw7DmnqzBf7EBzzSuwSUKmYa7DTxQQ9x735dve913DUDZ
         SDsSUeMA56mh6PTVchzOyDNOA1jnQioBcqI+YG6NMTdTSTCLJUFXoafPTnpAJ5AV2YE5
         4oVp9AFwAJ3qIKc/8LDupkDKZl5AekKhj6rZPqUzh4tM81XTenYvBGsJUOdvW+2MazfI
         zsRA==
X-Forwarded-Encrypted: i=1; AJvYcCV7lFhhjI/Xtmw3ScD44Ou8VbXdVveCufWxL9wtomlqEzp3v27mDo8gysV4sPyu50HIMEpI0WE0sN+snFNVZDf77S6y9m8NbqV88Z3+
X-Gm-Message-State: AOJu0Yyy5wLoBjGWiYJw11vdVjIK8lV0BCken3gPdz6294zHG5nW23fJ
	5Er+YT5SygVL9t6diiwiLKL+5dLwOngZhtPasIFeh00kAntN/zAQiw5EaNnu+PsWfXctrmBgM72
	RTw==
X-Google-Smtp-Source: AGHT+IFxcOZjCVKeJGUxY9sk7tLOxg5KrpbtDuxwmb3yPHYRKFjrg4zi+5dpufDNlzWlKN+XkJYPEQ==
X-Received: by 2002:a05:6a20:7195:b0:1be:c81d:7314 with SMTP id adf61e73a8af0-1bec81d7620mr7419100637.8.1719608337668;
        Fri, 28 Jun 2024 13:58:57 -0700 (PDT)
Received: from aw-m18-r1.. (syn-023-241-237-137.res.spectrum.com. [23.241.237.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568f4esm19709635ad.191.2024.06.28.13.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 13:58:57 -0700 (PDT)
From: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>
X-Google-Original-From: Matthew Schwartz <mattschwartz@gwu.edu>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Hans de Goede <hdegoede@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	John Schoenick <johns@valvesoftware.com>,
	Matthew Schwartz <mattschwartz@gwu.edu>
Subject: [PATCH v4 1/2] drm: panel-orientation-quirks: Add quirk for Valve Galileo
Date: Fri, 28 Jun 2024 13:58:21 -0700
Message-ID: <20240628205822.348402-2-mattschwartz@gwu.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628205822.348402-1-mattschwartz@gwu.edu>
References: <20240628205822.348402-1-mattschwartz@gwu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Schoenick <johns@valvesoftware.com>

Valve's Steam Deck Galileo revision has a 800x1280 OLED panel

Signed-off-by: John Schoenick <johns@valvesoftware.com>
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


