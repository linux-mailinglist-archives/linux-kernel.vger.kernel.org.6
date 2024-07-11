Return-Path: <linux-kernel+bounces-248560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9F892DEFB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EFF283E81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A522F14;
	Thu, 11 Jul 2024 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="q+BhkKKa"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F28F72
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670141; cv=none; b=baYUZDdT67f89wBdXn0l80KTL084xCm3zkJEDnWFDmHiQdQXM5neyF2xEYZiOtEflRyaoUMsXOjd4IPWNSVZU9llB0HEHYcRlWlHIq0HXamXuGRoO4epB30AoLueaF/wDNMAdQrbarPDadont2mrygCKAzEaUt7l8RltxAET/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670141; c=relaxed/simple;
	bh=aA99YddRZ7iO94CueHUkFDF7eExnkoXP1BCtijs9/cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JKblY9JKSfkqiMwRmPnwiu2C31DAhwG+bKc6BnWkJpagDT+k8Lquez2TIyw5T8Lpfw2O6JwXf/lZKnAD2eHH3gA+jtE78UboC8i+zKLZt2gG+1ALuDocRAPSwcbjOVsejz+AFHmhO340KPadL9OleaHyhiCAJd9cXlfPQnqcbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=q+BhkKKa; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b5f90373d4so12836466d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1720670138; x=1721274938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pIcWyjw9IYHu4kuTe0xycmZTVH8wV1vhQbU1+CkNO+g=;
        b=q+BhkKKaImvJzdNXDlJw4zWNGDW24k0nJ9FnkRXTohqXzTIerCJgc0S4Fw8HyeI3eN
         O2IV/39+X2aqnYsidE7XYw7QEM+3OkX08Oi4CvHktmGqovvH5zPJ5Y8pqNV7FdtHwY48
         tl7HVsanrwK5Wrhtsr94im02oTT1CFzZokQ/HdqyXr5AZ+RYbVyepGnQKSDRA9rxe6PD
         l/pdPJ2GACjlLr1poZOh4+YWyoACvYKmanS0iAuzBmqYqH99HNI0xrWkfYqV1vCUEilj
         jOB7uJu30sVDpoK3xGV6GnOJBHMJVdW0JkzPxVJEpsEjhaSY2QWdFuUmHLzxH+/vRuYM
         6BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720670138; x=1721274938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIcWyjw9IYHu4kuTe0xycmZTVH8wV1vhQbU1+CkNO+g=;
        b=BNv1IuVNRBusuzA3TsbfMp5WPH+QuHNMOgbXg6Z0UYOnfk5rAICZ7IDPo7vrVzB9P5
         zIu6Khrr7Uw5nPspJNhZ4l1q0/yDdwmWXl556lFVV1LkT3XW0PUHqd+fFGHKV1jt6fwv
         LsI85paryg4Qm9rLv6QhIG5DAI5/V8Qn2zM2uIRpjAKqUc4UMWYZzMoxI1ouB2mk8L8M
         vH2/xKle5c72ElLZUgVq1bceyGCKD/iPGFBfyqjm28DdbYRyOYp0Da6DL5Nlk3Fh2V1s
         OPIWzkOewhI6MqYoFJyIhjSlOhJ9QciyJVXzQIrOshR1aY0C6CiU4AZeA9ty8IPn2pMn
         HISg==
X-Forwarded-Encrypted: i=1; AJvYcCU6HbacSzD89uoETNMa6Hei9h+6C+JuulVcCc/C7+FAq/6gN3sSzqUpNiLZqoJe8pDUlG8Cll6vmSEaB9Nta2Fl0PqTdUdTsrW1ZUaC
X-Gm-Message-State: AOJu0YycM36t0xqheV2liJvDGsNxzad3qzvxgp1wrp9ZxfVnykfWabF7
	/2dHGGWVCT/gSQh0sNjkQWZjJqpIjpcBOgg4i7l8RrB88+c+hAbkOdN+L9h7Rrywr/O480o/8Dd
	o
X-Google-Smtp-Source: AGHT+IHUanKTrvxWsgutkth46MOJQAC7PEN/Ze2tgw84+rWzoMukmZ0I6dT1lwAoFOhPv04it23FEw==
X-Received: by 2002:a05:6214:d44:b0:6b5:684:2d5 with SMTP id 6a1803df08f44-6b74e95464cmr6331376d6.4.1720670138264;
        Wed, 10 Jul 2024 20:55:38 -0700 (PDT)
Received: from localhost (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61baa2383sm21961866d6.138.2024.07.10.20.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 20:55:38 -0700 (PDT)
From: Nick Bowler <nbowler@draconx.ca>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH] macintosh/therm_windtunnel: fix module unload.
Date: Wed, 10 Jul 2024 23:54:17 -0400
Message-ID: <20240711035428.16696-1-nbowler@draconx.ca>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_device_unregister call in therm_windtunnel's module_exit procedure
does not fully reverse the effects of of_platform_device_create in the
module_init prodedure.  Once you unload this module, it is impossible
to load it ever again since only the first of_platform_device_create
call on the fan node succeeds.

This driver predates first git commit, and it turns out back then
of_platform_device_create worked differently than it does today.
So this is actually an old regression.

The appropriate function to undo of_platform_device_create now appears
to be of_platform_device_destroy, and switching to use this makes it
possible to unload and load the module as expected.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
Cc: Pawel Moll <pawel.moll@arm.com>
---
 drivers/macintosh/therm_windtunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 37cdc6931f6d..2576a53f247e 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -549,7 +549,7 @@ g4fan_exit( void )
 	platform_driver_unregister( &therm_of_driver );
 
 	if( x.of_dev )
-		of_device_unregister( x.of_dev );
+		of_platform_device_destroy(&x.of_dev->dev, NULL);
 }
 
 module_init(g4fan_init);
-- 
2.44.1


