Return-Path: <linux-kernel+bounces-275474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B2B94863C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA931C22189
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F115016F830;
	Mon,  5 Aug 2024 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NP2dt79m"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186616CD12
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901158; cv=none; b=IyVY0rXYqXhqULXjiNsxw9s7UZz9deS2FzgVoo+8hzoChD3L10Q+IZkUsmiOOHkJOk0c7pSG+HER4KoOvpL8zDZJRFfsWER1VLOaIV2XT10h2AkeWw1L7jyZMTfhe9q+KyxhOt6c/bEijKQDIFMRhUH1C5FjAayuuzZCGEgtKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901158; c=relaxed/simple;
	bh=fQs2VJ8lfyMR9SmNHWMLjdsigTfsq4Jxqit4bVCGBXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8YvYhGg//gds2ikLqkKt8xhNfVXC6I/hrP5z8qRhL2cmyGN46jKalTpB7ppfCej/tVcODBv0oUUgAQ9pzuPyuhIdplMIHgBOWetyFVL7/k6ju36HmpJLYrjykryRQwTdSAUZvvoBMnecPcsAsXi2v/VNsRwMWC79AgIKOnBfBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NP2dt79m; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc60c3ead4so75435ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722901156; x=1723505956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnncB28XY0s0oOAoP5k3joEIwhuPT0nv/d7oPA6DHTI=;
        b=NP2dt79msT8sWw/KJgxCSQJRidYU9LRfGW56YaT9Wk1qyACNTrvRpD/8z9fpNQVElY
         VCK2Yf3VoEwu1CKscmfV+sS82lL3ytrr+EpyUsNKMkE/Td9M4tElUMmXV+1qRpjUAe8v
         poJ2j06WfrrLHSe0MgprMzXY717G+KwXBBE8hGQ6mXYqVpc423hRrSkVfaU6aCRlWAHt
         HYczuOnt+2PauD9kWMgsIEM8WK31YGsgCoQ4L/fYldwiTt/XQ1TwDWAn7BSq2ANNndDh
         NkSkGMmODW1j31mPENLUQywUtEPm3eQyaXcJu95/cZUSQDc6wuw/WCIndcAtaVBbvtoF
         Wc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722901156; x=1723505956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnncB28XY0s0oOAoP5k3joEIwhuPT0nv/d7oPA6DHTI=;
        b=G0UyCXDw4s/B0V37t4tJkUJXlT1ZTgXXoe5XnkskuDY4EracgPvtzBMeCkLGbMG/eN
         qjbtiGjToqTdjX9OgzQBr0OA+oMSkzCPabzcVrMP8AkCyI9tFJK0Sy7EwOhZoOKgc67H
         O4jO1kC1rgWOq8rE/Xhl+JdtbjihfG5dB4F1Ioyv45PA1X34W5kQv6vv/1djpYSnd3pb
         /yAGTB83iWOQl5lgD46vOKkGG4tZtvT0/Rqnl1M/Pi0wvriaUy4yU2yMIG6OXu9OMSM4
         dySGLDWAJXBw1M13pMkGmYKrFoGNYOvUQ3+EQO/53CJ9Ouc5gJfrKm8WOBrJsiHOa3tO
         DYSA==
X-Forwarded-Encrypted: i=1; AJvYcCUS/g0oY+YPVJtVJLi1Xnf/6jqCYmD9RjNlRShTsAGg80kAA/63Ca6eufUt7mvxuPP/o0itWt5Y9UXuvnlm6CBu9tqOMbnsbERmrp14
X-Gm-Message-State: AOJu0YyxsyI3WNe6wXIbt/OtzEGAyehhmTrWHgRTA4KyLuVxG74n8pV1
	so7uCY9vKj6MRdeMJ/bMv0qxFnci7JMJ8142zfaOWsjOW/x7sPO/wwB56woWawQ=
X-Google-Smtp-Source: AGHT+IHobvQnstPph5Yb+ux00NdxLtNlQ9qF1pXoXFjnb5XD56fo2xQmXa90/jkJt5RoCFpipa+Xlg==
X-Received: by 2002:a17:902:e84a:b0:1ff:39d7:a1b0 with SMTP id d9443c01a7336-1ff57495cb2mr144665765ad.50.1722901155669;
        Mon, 05 Aug 2024 16:39:15 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5928ee8dsm74218375ad.230.2024.08.05.16.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:39:15 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Mon, 05 Aug 2024 16:38:40 -0700
Subject: [PATCH 2/3] pmdomain: ti_sci: add wakeup constraint management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-lpm-v6-10-constraints-pmdomain-v1-2-d186b68ded4c@baylibre.com>
References: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
In-Reply-To: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 20240801195422.2296347-1-msp@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=fQs2VJ8lfyMR9SmNHWMLjdsigTfsq4Jxqit4bVCGBXo=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmsWKggzNV78j/AecMl1EMuzfzjzwYnxTYwr5x8
 x7D5mlMcnuJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZrFioAAKCRBZNxia0/vG
 ZW/ED/9MaNuCpYxFfobOqYpMTwSVORQik9ViMNI3YunHM+6xvl2bejNcU/Z4/VLi71VgnPkiE/S
 +3fHFhryjLo6CyDnG06Tx2NTFyvzJ1LWU7D2IGgu04Oif1ZkCtTLnqF/bT7ef5CMiM5n2GTkCCV
 MwPfleDsab5aeKMGq7wqjiw5USlC/QpkV5sXFViEvl4lcBfC9/2PAeEMFloZZyrqBd88wPxoaBU
 QOQ0u3CaLwDMrfRzv7bf1qtbiwF5IaUYLOUUbADewasZMakk9OBG6MsP16c1VgIJx+zar2YEwUn
 e3+lvuPJy7zsnnkgGKxlgjMaA58yTaug0tuHfAb8bHQRp/v/UyPCLUSiKXtk2UDKocyTXlk+wqC
 jEcVJSEWUK6IqFRhAMndi/BmrRUuD+r+n4oOQVJV9tvfOFirZNAWrZP7Zcg8ng1i8NDzBfCLTcZ
 maEyngcANbznb48ts2he44FewEQFwfbnO0UIb5mXcb3DmcpZGKMX9Wd2bV/koMpyKRNO/0GjrUM
 cZkb0xfy6E0R3enQK3twcCJUvNRbM7gckNenDS7YoWeG6zl20T8McPPsZoJU+mjF8cMJV1O3NXB
 Jl9AZkcX5UVjKe9O0eV1MUTU9G6BN95yY0TK1R0DuQaX382qjPZJIcoOb/XMBrCdG39Gv+U9V3U
 90oy9xdSJYM4VHg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

During system-wide suspend, check all devices connected to PM domain
to see if they are wakeup-enabled.  If so, set a TI SCI device
constraint.

Note: DM firmware clears all constraints on resume.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 4dc48a97f9b8..7cd6ae957289 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -51,6 +51,7 @@ struct ti_sci_pm_domain {
 	struct ti_sci_genpd_provider *parent;
 	s32 lat_constraint;
 	bool constraint_sent;
+	bool wkup_constraint;
 };
 
 #define genpd_to_ti_sci_pd(gpd) container_of(gpd, struct ti_sci_pm_domain, pd)
@@ -87,6 +88,26 @@ static inline void ti_sci_pd_clear_constraints(struct device *dev)
 
 	pd->lat_constraint = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 	pd->constraint_sent = false;
+	pd->wkup_constraint = false;
+}
+
+static inline bool ti_sci_pd_check_wkup_constraint(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	if (device_may_wakeup(dev)) {
+		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
+							       TISCI_MSG_CONSTRAINT_SET);
+		if (!ret) {
+			pd->wkup_constraint = true;
+			dev_dbg(dev, "ti_sci_pd: ID:%d set device constraint.\n", pd->idx);
+		}
+	}
+
+	return pd->wkup_constraint;
 }
 
 /*
@@ -158,6 +179,8 @@ static int ti_sci_pd_suspend(struct device *dev)
 	}
 	pd->lat_constraint = val;
 
+	ti_sci_pd_check_wkup_constraint(dev);
+
 	return 0;
 }
 

-- 
2.46.0


