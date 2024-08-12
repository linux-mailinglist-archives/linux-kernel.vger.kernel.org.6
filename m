Return-Path: <linux-kernel+bounces-282660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D9794E6F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43F81C21CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9703152E17;
	Mon, 12 Aug 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VT4tMO74"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747714F138
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444983; cv=none; b=ioIXOdCfQfGc8MSTUc4PWrBXcqbAf2YiffWuWN11LUAJe3WJdGRlYGnDS6sAqANepOJ20q/MLC7s9mgxRdQf8sDiXNWgmxMgQTTvmGtUSmVmWD97mMGcWYi52M6ZF5Vz9hk/yOKWw8n1pZhMsijOTNnDsOXr8fMkIH27biHOvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444983; c=relaxed/simple;
	bh=7pJScExz/bX9a0EvfggCOgdyUzqAQkHIeR9DnHAbxa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NUUnr/XfMik+MRvJboy6RaQNgC29wTNwhjkCG2UXz4Bb545wlEjKq7BZLq5a126vTC5IiFsUoJqbxVDwWxx0b0OuMuXd6vdHN4szjY6jYVLsBSZY52tYv+ehxdd8z3L6f46bFKeRT1nKbv8hReaOKTr9yVoPk/uPzGXrEURzQy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VT4tMO74; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so5436389e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723444979; x=1724049779; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbHIy+o48Z4/7AHlMrZBoQctzcikg51wtZVN0gnDpss=;
        b=VT4tMO74E/FdV8l9X1akeLadkjIL3egrZgweVx2bEx5iyfHqqJg0xkX4duXwaSXFIo
         bG++ZVqbRTp7i65IfDprpveDDS+985mkF06upXmRNGKLLxJHam/2gVebdv3bpSYeZBBD
         lDK7wSSv7VB84Xyzn/gXezQhiE6/7J6HCRWButemcy3j/8Ow4yIAi9hAh3tcMRzS8lnh
         vvXBG6BLtfGSP99Xc7kAJ22avKpc3Eqfw39nIKcWs3N1jYJZKjGLaDpy0P4XY+wjcBbr
         3fL2Rn0RV8U3ItVNes7GVhnr5+r2Yv/1ABxcQR2Z+PYz9+oTDsBsfaEL1vMmY0L2vPPM
         bFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723444979; x=1724049779;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbHIy+o48Z4/7AHlMrZBoQctzcikg51wtZVN0gnDpss=;
        b=htjSr/aovsgEgCKFkWDtCDfNAJkOWBbJaMl3SG2IAoEPi7Nj4Lx82lN/pz2HSxCEX5
         SvdEPHywGYAsBW/+CBA9QIXu/ijyTYgG+2prZa9S/KRNwQehz1pAIwMswBzxDwLM0URC
         lk7sQYuvJGQWO+2nBxN9zpk4VgRr7Hs+0Efv1Dk1+FHyDhjRUe6JmG0EeA82r/UVZjGf
         wHIyPuKCHYVEEyzrj661m8IeYcu0hgJZYGxgaueagCutwX4WNQF3GhOlRvYtu8IiW/ku
         w+QYUYrT+wOXA4YP6GSFrylKiLQI7SDw1VLZTI2j5zDJr8rO2YM5JoxJDSU3mcgnsjci
         k3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5dJA34GvIU4rHJAhvxOereBp3Dq663Be0gax6u6gXIR1BjN8HlyZPnkJ4cZQcBgmHIcW6kYrkLBc57XLLoWZ+bhV59Fc7hDBhHrU
X-Gm-Message-State: AOJu0YxE/3Y0RaS26FMU5tvkutJC+uvyTG3uS4sSzMArFqCdl0xFd8kw
	LYRpUbldu3DLMh30PJzn2evRY8cruh5hkx12botH59cPq7Z9QNsEJbiLXsXG1Co=
X-Google-Smtp-Source: AGHT+IEk4ZnNIsnzZV7k0SJFKSmS/31tiOmiB1Iz5IztkYLjgc9jdDjTxOdK5wP8Zh9WscuTC77ptg==
X-Received: by 2002:a05:6512:10c9:b0:52e:fd75:f060 with SMTP id 2adb3069b0e04-530eea70162mr4660900e87.61.1723444978819;
        Sun, 11 Aug 2024 23:42:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb212bd2sm205048766b.176.2024.08.11.23.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 23:42:58 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:42:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v2] drm/ast: astdp: fix loop timeout check
Message-ID: <9dbd4d2c-0757-4d5f-aa11-7d9e665e7633@stanley.mountain>
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
v2: In version one, I introduced a bug where it would msleep(100) after failure
    and that is a pointless thing to do.  Also change the loop to a for loop.
---
 drivers/gpu/drm/ast/ast_dp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 5d07678b502c..9bc21dd6a54d 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -146,18 +146,16 @@ void ast_dp_power_on_off(struct drm_device *dev, bool on)
 void ast_dp_link_training(struct ast_device *ast)
 {
 	struct drm_device *dev = &ast->base;
-	unsigned int i = 10;
+	int i;
 
-	while (i--) {
+	for (i = 0; i < 10; i++) {
 		u8 vgacrdc = ast_get_index_reg(ast, AST_IO_VGACRI, 0xdc);
 
 		if (vgacrdc & AST_IO_VGACRDC_LINK_SUCCESS)
-			break;
-		if (i)
-			msleep(100);
+			return;
+		msleep(100);
 	}
-	if (!i)
-		drm_err(dev, "Link training failed\n");
+	drm_err(dev, "Link training failed\n");
 }
 
 void ast_dp_set_on_off(struct drm_device *dev, bool on)
-- 
2.43.0


