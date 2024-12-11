Return-Path: <linux-kernel+bounces-442359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C233B9EDBC3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217E6280ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6252C1F3D33;
	Wed, 11 Dec 2024 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WssAM4Tm"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DCB1F37D2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960102; cv=none; b=RfhwXEQUbH/AtXRdR0RVzluf1b2YBjC7Io/r2vI+NAEXkbCMrr3x/53oQwpbSVOm5JGW6i1WPc0i2fcclN8OYFWI31+AKyHsCB+QsfWJdQyGDtdLOsvFuqumipvEfiQ2C95FoDR0LTL9fOcsJxzD8qk9fujaX3G8VK9mlY8vM3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960102; c=relaxed/simple;
	bh=rnQKE1RTYE2iSp7z3LJOQTY1avxrZxMWdJEvkL0s4RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQFLgOmqdJhV9YKNvOmb3lUJr9L6spZJIH2yYWGM2RffxCdyRPTdwtmz8zR1fwWGy3L+sfUCFiFr5L4A4kEPb17t2zqZuyNE8RYV1c3p/GjJvJA1/n5DSnKnfJWyZwh25FplTuiyRt7vlYFqbdIfyxNiHKn1WlPb+mYMMf+Ns1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WssAM4Tm; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea8de14848so32777a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733960101; x=1734564901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2J0kh/C+Q2Vqlr3kPJfElERrbZFRIeOwOwK3EB/PmQ=;
        b=WssAM4TmXyvlbqE+cYZKYsNREaQu7CotNEhgu1uWWgNfLUeodR80tHhmBLj7fuUsi2
         LLcCTRnxSXTQAlCz5QakzBoxOLqhdAaPzXYxweckrnDRMcx8VhjHeTYTf1QTUfJ7MgCS
         pC8/ZeRB1BqcGy88jQBRNk11uPVZKkrMGokitEDMEbyq6KN6bgjTbreTChCQYJDh6t/x
         Sc56LEKmC590U2lWhA3Bgo94g7ig1Gb6sPPNQmDajGArp7z3tL2R5Dt4oWm2hj8OJrnq
         XHuXQLjzAGlJP16r6vfx9wiOvckrzXF5/T/8eHXnb4Xn4klMBQMy6NvMhe4ZCRJgrisQ
         9nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733960101; x=1734564901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2J0kh/C+Q2Vqlr3kPJfElERrbZFRIeOwOwK3EB/PmQ=;
        b=G85d03jzKWHGENolW1SRAQIyI6YuPd3PPInX+Efn/6eAMPv+60qFmYDJtOlr+mOIyq
         vAYrAk2PGexhF5b52YVhN+5GY5GQz/LlQ1BY9XawAcf3DIiU0LtnE0WHK+dh7FhJVGAG
         BV7sWmyxbRdZIxKeduEUV5ATJru2pNT0w59EM2FtIvRb8+mCno41OlZ4D7S39q0VpoaV
         SK/lb3SgpViHJIpXAHGvaUWlidyomxv4uTZeA5RDSfZpu79QsfFjM9Rc2OqmsjvHjUZn
         P1u0AYnwLC1LQ3JF3w06j6KVxIA9hf1BOOjKoHJtz/rnOYlvfsiRg8bORRaWcYvz9Ycv
         bpBg==
X-Forwarded-Encrypted: i=1; AJvYcCX8EySqHCAGpVFOBiCRRPJmL3cXySo9VaErc1nBc/TY/Ex/oqx5ZTSRTPIE/B+rI7IwERo/j9+jM7qDu8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1upXAZtsHZbayi4zR6U8l+eMXVWf/l3HIdQQgxGaA49OfUMrz
	u3xYNs+aTroqjRnpEN/7NYTHMJl3gposFCZwwZh2l8MUZae/tdI7
X-Gm-Gg: ASbGncv5CHa6w0UHeBMpkOkI9XeyU+nCwoIxEEET/XvjVAuyo0oBzsdhkZBgm+i5zIX
	z3ApsGTRQSafV1OZRGbNZTc88os2nxsgqjDe1CW1MVkK8kL+sawaPhzgc9ncNPjnjsKy2vkQz/V
	p5YcQfPcKe9XzvEBzzsVt66FbSBSht2sqL02BSrQVtF7zCVMPgJapxSCVk9y17H1H0ET2TsJCmF
	l14kcj2Vw2gz/2pwMYUYOTnkCFmVzo3b7idoTpf8y6uLd6eQSNOoANc8ZyACBaB3KuiS/AjdlLB
	NPL0
X-Google-Smtp-Source: AGHT+IFnc82dqozPBaLWZCaqdNgLRXLt2WJ+FjtNGOWGP+BFdNpaCkKzoL8v5JfEpNyLeMM9x2HLFA==
X-Received: by 2002:a17:90b:4c48:b0:2ee:d024:e4e2 with SMTP id 98e67ed59e1d1-2f127f565bbmr7814542a91.7.1733960100523;
        Wed, 11 Dec 2024 15:35:00 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef8a933fdbsm9229485a91.41.2024.12.11.15.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:35:00 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] staging: rtl8723bs: delete HAL_DEF_DBG_RX_INFO_DUMP enum and caller
Date: Wed, 11 Dec 2024 20:26:40 -0300
Message-ID: <20241211233415.37702-3-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211233415.37702-1-rodrigo.gobbi.7@gmail.com>
References: <20241211233415.37702-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After removing code isolated by DBG_RX_SIGNAL_DISPLAY_RAW_DATA cflag,
HAL_DEF_DBG_RX_INFO_DUMP enum lost it's use. Removing the enum
and the caller.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 1 -
 drivers/staging/rtl8723bs/hal/hal_com.c       | 2 --
 drivers/staging/rtl8723bs/include/hal_intf.h  | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 317f3db19397..952ce6dd5af9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4959,7 +4959,6 @@ void _linked_info_dump(struct adapter *padapter)
 					rtw_hal_get_def_var(padapter, HW_DEF_RA_INFO_DUMP, &i);
 			}
 		}
-		rtw_hal_set_def_var(padapter, HAL_DEF_DBG_RX_INFO_DUMP, NULL);
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 1803c0cd3a7e..b41ec89932af 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -682,8 +682,6 @@ u8 SetHalDefVar(
 	u8 bResult = _SUCCESS;
 
 	switch (variable) {
-	case HAL_DEF_DBG_RX_INFO_DUMP:
-		break;
 	case HW_DEF_ODM_DBG_FLAG:
 		ODM_CmnInfoUpdate(odm, ODM_CMNINFO_DBG_COMP, *((u64 *)value));
 		break;
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 282e141616b0..85de862823c2 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -144,7 +144,6 @@ enum hal_def_variable {
 	HAL_DEF_PCI_AMD_L1_SUPPORT,
 	HAL_DEF_PCI_ASPM_OSC, /*  Support for ASPM OSC, added by Roger, 2013.03.27. */
 	HAL_DEF_MACID_SLEEP, /*  Support for MACID sleep */
-	HAL_DEF_DBG_RX_INFO_DUMP,
 };
 
 enum hal_odm_variable {
-- 
2.47.0


