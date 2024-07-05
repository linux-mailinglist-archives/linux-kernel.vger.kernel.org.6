Return-Path: <linux-kernel+bounces-242294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36652928654
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60E2B2145C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA391487C4;
	Fri,  5 Jul 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2bHSvnA"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49F146D7E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173844; cv=none; b=GPbD3zXxsXAU+HnqAjP7k25yyoHfDI4RvT7PSGQhzUYLIn+K0MoXOImDPbYNOvhb9B+GRhwQJDqVqHeQo/pk0LwzeTPJtZgUfgpiuBL4TbAk/RY7v4FG5uNIPh8WKf/QdfDzUhhb/kFC0EMHDhgM/tQjPJpLOMovqk9BBkYUZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173844; c=relaxed/simple;
	bh=EdIiu3QR4PD7CuFhUBn7GwZ4l7hFYUatchpzsMd7uMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbhSrDau1jygdd/Zz4+SxFVLDRxTHmQd8Z4C1SRWlEZDwEzwaEbPkeV0jgD5+otBWDm/O2u/h0N5GM+x2fMy4tzBt7i6zn7BG1GcjjDhQjll7npBocp1tt6RUDmLazvn7960xxZANYEtgmCM09Ui6r81sCSCYGJAym9Q7CVGm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E2bHSvnA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea33671ffso938081e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720173840; x=1720778640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OAAC9qEu7VDBRfhEoRtlZEYyIrj1boXAy6yDu78l+Vg=;
        b=E2bHSvnALRBcixs2VccweYUy+kpQhHWOtoxD6Z7B3oFoVpdeWTJBYZkTGznwZnGtWk
         2UP4UEjpWYYeqxesqPKYlOuomoALtprmieX6ZsIOXfEbC+wf19Y/Rh09vpXxT9LaHiT0
         CMggrPqlB8Y00gk/yhGw0268hGwgvLI7Lp2U7vlt3ibi/OL6CoOsR7jRf+sr/XIcgu+J
         cGFAPd6qo+OYYejsSW0CByOVouBYWE8LNxHd9m/4sPA4MXkrM8nB3MTa9HhKy3iBvQ6p
         jISha6v0D3Rb5VSvK7Tc0NZn7yY7/EDwVvQ2xYxQ9pdLcKL3MEZsWGXK7TPCRA2BgwKN
         5lXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720173840; x=1720778640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAAC9qEu7VDBRfhEoRtlZEYyIrj1boXAy6yDu78l+Vg=;
        b=Npz1Qknsq8Xa/EkE/0sbQMr6OEHjKEQDizOj1Kkafh8zUBpKyYbhqd/ZssNF9PEx9q
         e9YVKU4AWqKeu/mLxbDupPqnIVya0Yn9ILoPd7dsZ0XLY1ffvitoyaHL/SMeiRtSRfYX
         BnmbV1YGZsHxivjfVrbTBx4bBdM5g+ReTZbiwI5VCh4eCOKabakAwmj61s7chCUVDwb9
         uGTbBclvX8SCZg7AeymEIsijse81r3F4ox04y1BC3qKWgWFXcCZHD1SIrFHYZmJMb3h1
         Tyty5fHWgCwE4San8Ny3AdD1AZj2ApouqV40NWLZJLTTrOnp29EyjQh02j0sceoeHW3C
         zXoA==
X-Forwarded-Encrypted: i=1; AJvYcCXsfXtgtTajIKvqAR1NfwvO8nt+3TEMIwcqjOsnA3xw0528WbHDIduf7lZLw4wzT/0WUaSdg4cTxJnFXhVjO7SqiQi9Vls3LdBGF15A
X-Gm-Message-State: AOJu0YwtT+pJQQE8654HnzR0nqOiJG/eFvOG+G9G6EobJ67s8LQeUGVv
	GuP6we5LOxNIWfClJ6VxwA7z8Og8Eg7okk3Y/Ru2CKlwjmiZgioOTpaB2XGgD3Y=
X-Google-Smtp-Source: AGHT+IHPOjbR5uUNSh3csI87eapOhWclY7lK6S3loPta2smbTrcoLjDX3VlsKvC8xM9csmg2iVBKeg==
X-Received: by 2002:a19:6a1a:0:b0:52c:f521:9423 with SMTP id 2adb3069b0e04-52ea064ee3dmr2510107e87.26.1720173840519;
        Fri, 05 Jul 2024 03:04:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm41467835e9.16.2024.07.05.03.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:03:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] MAINTAINERS: drm/sti: mark it as Odd Fixes
Date: Fri,  5 Jul 2024 12:03:56 +0200
Message-ID: <20240705100356.16760-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches to STI DRM are not being picked up, so even though there is
maintainer activity, it seems that these drivers are not being actively
looked at.  Reflect this in maintainer status.

Link: https://lore.kernel.org/all/77b4e4ad-2b1e-4b6d-bc3b-0c7b339bc295@linaro.org/
Link: https://lore.kernel.org/all/f207b481-f530-4f54-a482-218908869050@linaro.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8e16a649a0e..f284cb8db544 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7595,7 +7595,7 @@ F:	drivers/gpu/drm/rockchip/
 DRM DRIVERS FOR STI
 M:	Alain Volmat <alain.volmat@foss.st.com>
 L:	dri-devel@lists.freedesktop.org
-S:	Maintained
+S:	Odd Fixes
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/st,stih4xx.txt
 F:	drivers/gpu/drm/sti
-- 
2.43.0


