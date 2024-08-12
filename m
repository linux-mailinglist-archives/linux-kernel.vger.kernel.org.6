Return-Path: <linux-kernel+bounces-282951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF6D94EB31
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA1E1C21773
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF83170A3E;
	Mon, 12 Aug 2024 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFneBiXq"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB97170A1C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458770; cv=none; b=cmPVqyoxE6SFEviWllNnRLm9E+/Eb/YwzCsPyZ7N+b+A8eMI08f8sUJpg3BEK6IJr3Zz/a+qZOUjqbWgbweLQ1fKP0D9YR4cZPUQjubcpGvbVxNMhdlksFubXO5DwGnDJ8WSIykljszS/NvIue1vCd/UPB1nUHk3SSENxPiGacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458770; c=relaxed/simple;
	bh=rSCBaIXJPRajVS8xJXyFx6JrCeK2HqadPitU/xd6N7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CeDL3jB2nompQ9bkKsTuEF3Kq/6vrmJCpDAWpOuwRC1Yzng7dY1IYnrfpws1sQTHFZjdvQxYi1pDJGtzZ+kuObSeOCobRJqRq8GvxBsf1FqjTOt4IsbVd1X5FstT+8mJkrW0iZ8C3nkZgXYu4ehllRxmR1HrNvbHYyy3xlrqXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YFneBiXq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efa16aad9so5351870e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723458767; x=1724063567; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1IfJ9u3yUX0iZ4jMFGItrUi/pvd+46Zvfr+ViX5sCk=;
        b=YFneBiXqyMRD4q8pRqG5qxENFcul71xLC1DuNdGfKSUE9TsZkOrRUhuP4jHuD2x3Y6
         x0NRGs97rn9D5TrV7p29oUoMHFyGShc1H+y32pIiJwbqxzkRIgTUEjmjPpXPylKAl2/F
         A0zyV8p3ywc/ZPGB3geyFi+V4N4j94L8znNc5tZxfzH3bkO/Hp4c4ytCyu0Y2WtBhL8j
         V1AwEIp5h4kRGb2h8dwbktmEKwYTKQ4oUVKqXD1d7wiB7aRNUxZg4YyUB+baG2ZWplfc
         bj6cBbu5nBF3R+d4KPchJAtQ5jMb300PGLB8QeVbZ731DL4xt8hgdVo2PSAGkyQISpBZ
         FfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723458767; x=1724063567;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1IfJ9u3yUX0iZ4jMFGItrUi/pvd+46Zvfr+ViX5sCk=;
        b=MzZCcppmaRvh+goz7uTEaIY2WKtIYY4/nzM9thJFfs9leMziDfIJxu9WGTcNEnrFdA
         4e8mMtTq2rlrEKnyt+vTMsSI0Lg3oB36S/ySUaH+UcuCzl689M2yt/LeMl2XELpAfKjf
         9cYkNOCrKr40FIfFW7wa6YszF3Iyw/XUHmTkmmQwQrGvJe0mASiEVov6x7sLhmHowuqJ
         7ezGypHVz3qVIp8/5o1HIyzssTChPGqMxMo2GVzD0/LAc5Y95HFQvZMWE+Uf7agd3Hm+
         ITlDM4XGKU+ueSxPv58ju2xI6BZG5c7NYWMSDeBC7hJ8qXFQ9Sep0IJpc1pYlleDXnpD
         M33Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnYclAd2iMmSXp95Rb8iXDhTlUYE5CBC/e9UihWty0ZutbHRuwnfIWbFwrA3jfRLup7u9dPHIID/eC1tH6sBadfRNM59EEYWbYz28l
X-Gm-Message-State: AOJu0YycGMaERNCQ70CH7Ava7fEpyncj+agI9bkFBvQEbVlfez2UeLso
	TR9xCEnidWD8X5NTmSAmLn+1RYJfW+CyiJ2OKYmnOr+auJBihhIt0a1JBb7iKLU=
X-Google-Smtp-Source: AGHT+IHzgJxlWNmlpbcyADFmPoi5Gdg+YYXbOVyXdQhr3/VvVj6WyK6nEwaJnWhwJoNlT7DEw3b1qw==
X-Received: by 2002:a05:6512:ea5:b0:530:da95:b54c with SMTP id 2adb3069b0e04-530ee985dfdmr5817998e87.23.1723458766440;
        Mon, 12 Aug 2024 03:32:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a602da2sm2158926a12.93.2024.08.12.03.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:32:46 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:29:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v3] drm/ast: astdp: fix loop timeout check
Message-ID: <1ba8da25-2d09-4924-a4ff-c0714bfbb192@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code has an issue because it loops until "i" is set to UINT_MAX but
the test for failure assumes that "i" is set to zero.  The result is that
it will only print an error message if we succeed on the very last try.
Reformat the loop to count forwards instead of backwards.

Fixes: 2281475168d2 ("drm/ast: astdp: Perform link training during atomic_enable")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v3: V2 had the same bug but just without the always true if (i) statement.
    Remove the final sleep.
v2: In V1, I introduced a bug where it would msleep(100) after failure
    and that is a pointless thing to do.  Also change the loop to a for loop.
---
 drivers/gpu/drm/ast/ast_dp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 5d07678b502c..ca022c287785 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -146,18 +146,19 @@ void ast_dp_power_on_off(struct drm_device *dev, bool on)
 void ast_dp_link_training(struct ast_device *ast)
 {
 	struct drm_device *dev = &ast->base;
-	unsigned int i = 10;
+	int i;
 
-	while (i--) {
-		u8 vgacrdc = ast_get_index_reg(ast, AST_IO_VGACRI, 0xdc);
+	for (i = 0; i < 10; i++) {
+		u8 vgacrdc;
 
-		if (vgacrdc & AST_IO_VGACRDC_LINK_SUCCESS)
-			break;
 		if (i)
 			msleep(100);
+
+		vgacrdc = ast_get_index_reg(ast, AST_IO_VGACRI, 0xdc);
+		if (vgacrdc & AST_IO_VGACRDC_LINK_SUCCESS)
+			return;
 	}
-	if (!i)
-		drm_err(dev, "Link training failed\n");
+	drm_err(dev, "Link training failed\n");
 }
 
 void ast_dp_set_on_off(struct drm_device *dev, bool on)
-- 
2.43.0


