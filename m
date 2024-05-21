Return-Path: <linux-kernel+bounces-184424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525E38CA6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E900282092
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01437433C0;
	Tue, 21 May 2024 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="e+vCBsBx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BE20B20
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261445; cv=none; b=J08xsTX7L+6M7xQexEKlr0GlYOjaviLa5sMY49gYpQRIDAxiJwpVGCIYhvEG0bnQH9FKfUyTRUHPOmRDn5gDr/GXyJtzgZ4xvOeV2gklM8hBZjsR/kbWTSoHDkqSz/wt7SCjDaO5H5o/rf2nT9Z6MU0us2MTxCl4P7VzX+ZP8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261445; c=relaxed/simple;
	bh=wUKoaCTHzLDDjFbhF0PGI5yAQPN1+rFJl7SEuLinulY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqOnR4PeRQukDN4N2DnnvVUVemtffjpux/y6IgFc1xPYMMeJXuWYuEmeY4tnhO+n/2rsAN++HzWHhrDhpqAHC2xkt+njZOUMu9yW45wd46rWREEslFtMTz1FBZ0u+/GB5A7M6HPX5d0CNuiMub7n5sZGoAXkhVS53gmZXX7KpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=e+vCBsBx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee954e0aa6so65209115ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1716261443; x=1716866243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAeUQPv6s9JrE6X44M25yrVX3F0jSkau/eRXgFLNcZw=;
        b=e+vCBsBxoNnRVlKiB5Dp0gQjkQbj3eUkrtMbllGrjepML3iAJQ6R+jU2E1BAs0pnNS
         wN+zAbY65bLCTST4bafn0XMdaWdP5sqa0QHa6ny28469RyeL79J/jOiBOEr7vlX3C+/k
         oLHzo+z4Iqkdgv6G8/1/0BnsWUezp6d6x43rXRst09lDECNxye4J1Y7t/y5UqILULZQq
         h2CFDLdpo7yrw2dM7mCWLe3ICSVSmQR2zAsoeFqnk2oEF4BcPYX9OXJvH7TLAPTJmLEn
         JMdgWuobYi/XLVICNFDGQgvVkEWJjABe2R2eHBgD2+ODic42K9qDjt/n3smMb8qk/+U+
         rflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261443; x=1716866243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAeUQPv6s9JrE6X44M25yrVX3F0jSkau/eRXgFLNcZw=;
        b=JSP+fdjwFg0us+YBLEYvMLhfYf4aQsbpaYEsGBU6fk1a1OU1PIJEZruf8b5By26ykw
         N8cDhU181L4nyFfvcjRuMNDri1smMlh1rqQ/IvDyFYH0mOhvo6GYKtnpgGRSSTd9WVXa
         5Pnow2vlU+3j059Tt7lNg8PPfbyjz5o35dv4TY/sdxplOXnDuZyic7AmlfipZymJuzUP
         qxYGtASy23tyi7lXvdDd8w8wx+tjQfQf8VLsHeHlICa/Gl97v1VCD3VXqTDj1Pd4ddYR
         SpBF1wXW7+aR6UiH/2+PnmFhKsPACladXz/BDmQJ2mzyNqZBD83TeWAfIbS40F5DspYz
         MSCA==
X-Forwarded-Encrypted: i=1; AJvYcCWXovru28WM+XOkEKMLZOcwFULsd1lzeAr4+n3m+UgbpsE+doZk9u644VUB1X+TiVgSAQJYh6VsDmfHmPCgXjwKhy/YXjHCyylkuizH
X-Gm-Message-State: AOJu0Yx2e+3sszf5Z1A0lQwDaGhOr6Fjx+uDszP8Cxui3m+py+NcKoTI
	Ta0R4gpHBKLWUs2b+FjfE6wpiRZjXJmeek7ovCb5AYAR+nzWEUEoGDYzsZV1sYc=
X-Google-Smtp-Source: AGHT+IHszlUz6OA/dUOeyg8tjnmbeh5iEFUaZGSDgL5C2iBiVC1BxXHS4d2GbPVB6NFN5UfSrcXH+g==
X-Received: by 2002:a05:6a20:9f43:b0:1af:f514:97cb with SMTP id adf61e73a8af0-1aff5149931mr28164789637.8.1716261443132;
        Mon, 20 May 2024 20:17:23 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm214885415ad.134.2024.05.20.20.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:17:22 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 02/31] Staging: rtl8192e: Rename variable CountryIeBuf
Date: Mon, 20 May 2024 20:16:49 -0700
Message-Id: <20240521031718.17852-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240521031718.17852-1-tdavies@darkphysics.net>
References: <20240521031718.17852-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CountryIeBuf to country_ie_buf
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: No change.
 drivers/staging/rtl8192e/rtllib.h    | 2 +-
 drivers/staging/rtl8192e/rtllib_rx.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0809af3fd041..8a84d61e6912 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -950,7 +950,7 @@ struct rtllib_network {
 	struct rtllib_wmm_ac_param wmm_param[4];
 	u8 turbo_enable;
 	u16 CountryIeLen;
-	u8 CountryIeBuf[MAX_IE_LEN];
+	u8 country_ie_buf[MAX_IE_LEN];
 	struct bss_ht bssht;
 	bool broadcom_cap_exist;
 	bool realtek_cap_exit;
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 4a0db2dfd5e9..dc0db6fade0f 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2184,7 +2184,7 @@ static inline int rtllib_network_init(
 	network->SignalStrength = stats->SignalStrength;
 	network->RSSI = stats->SignalStrength;
 	network->CountryIeLen = 0;
-	memset(network->CountryIeBuf, 0, MAX_IE_LEN);
+	memset(network->country_ie_buf, 0, MAX_IE_LEN);
 	ht_initialize_bss_desc(&network->bssht);
 	network->flags |= NETWORK_HAS_CCK;
 
@@ -2343,7 +2343,7 @@ static inline void update_network(struct rtllib_device *ieee,
 	dst->turbo_enable = src->turbo_enable;
 
 	dst->CountryIeLen = src->CountryIeLen;
-	memcpy(dst->CountryIeBuf, src->CountryIeBuf, src->CountryIeLen);
+	memcpy(dst->country_ie_buf, src->country_ie_buf, src->CountryIeLen);
 
 	dst->bWithAironetIE = src->bWithAironetIE;
 	dst->ckip_supported = src->ckip_supported;
-- 
2.30.2


