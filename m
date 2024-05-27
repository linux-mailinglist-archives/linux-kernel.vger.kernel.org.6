Return-Path: <linux-kernel+bounces-190436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17398CFE35
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36A61C21D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DFC13B5AB;
	Mon, 27 May 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="nLsveh6t"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5B13B299
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806241; cv=none; b=W7MMsAxsa4FMjp1IoyCwK1wGY9tiaB0uGA7AFbAYHAQo0AWJFkX5QmLkLGaVp1tspbG9XrMGqxzOsaWCyo1Dlk9rnzaKr8pYlaYutf2NNeeWaDYFIAZ/S/IWhid/4wTci32+NteOA7IyhMiPXjWCIx6XfNN7x9W+lCvKiKJQkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806241; c=relaxed/simple;
	bh=BGmd38XxGSdKDMMcN3G3XiQIcyOv9DXSluGqtKQy9+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHfjLroHXQdPcOCQHE+dn7qymcb08g31ikHzc/IzIH+EvRwPJhi2snreCXrhz+exifRQa4mu5ELjVKx0Y5aj8dLCzIcouAtnJy3IuPJhwJ3vtpchdrD2dYSKcH7tjF6tb6wYep1QvQmtSWIRftlfu3n+cyRiiFhi7MGLN5T15Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=nLsveh6t; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57883b25b50so1924027a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716806237; x=1717411037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dO0AvFL5QwePC2QZ3gqTYDM4BcsHQKgOykoeZh92DyU=;
        b=nLsveh6tAbZJL4bicjOJ+RVpjPLj4fH507GnAWwY2BdwXg/C4CtH7brjzp/AE4ISLM
         OAZwBDKo354WnSasjw+SVTevql+5gTWy655tiuou0W9EPqpQLpjXRyl29/bRaxNY6+PZ
         oqoJpGHQ8epYzwZ/Skcd0KhZeiRR8WPbt7FdRiI1fGrLpZSCwEHluYME3PnsQjm0NZPc
         Gz6i5Ucv9WwjZvmB9uxWIFHTl8l5p2GXWloug08NtpcqVlSjE7fZitPH24gp3lIh+5BC
         /y1MIk2IzmmcebQ+OC8VEDfG1RUzecul+Dubj0kxINx0vP17x9Ir8/1BhHVWO/MAPFgt
         f1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716806237; x=1717411037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dO0AvFL5QwePC2QZ3gqTYDM4BcsHQKgOykoeZh92DyU=;
        b=MH4mBVPJlgs7mphBJ0CP64TsrC0/rG8nY9X/J1WzbHKci1mi+/4bQ6YbULcEZrMXik
         8IGlDtiGIzCBSehlvXDt0u8dtB/PqG79zEqdoZD6qNKCSsj2krGyKB8D9n0dwsDbqEir
         6eVhhDEE2z8sWbdv+ZX9Z92fxkB7a8hHWyx4ug3Z3Du0OkjadIe/s3mYavq6r1iGLYza
         Ze2/FTA+cKf6CQmRyPoJN4vUIEU+0Z67Mg6289xCu9+NqjfoN6gNuOOIMOU7HL7XHwfA
         rnNgSnuWKM59CZX6cUa9UTy4zEWew69TuTChTQCFeQ3fKH21NdjBP1TYNr5sH6slc3ej
         fyDg==
X-Forwarded-Encrypted: i=1; AJvYcCVVcpfBNdn4F36BE5ukYJf6Yi9rHVbmpoxOEt1KHrX/kq84KWbD52aT0IUDg5qGPrJG/FQWnq/Vn1WG4HJlQ0dggrAvyN5HgWcdXbYH
X-Gm-Message-State: AOJu0YzrEt2e4TcU9sr6rTtrteBLYApUD3u57tArkV0qCAbtPBDAqHic
	Pd3BSoxyzp8rxBzlJ0xYvYb3l2HwuGcZ8vuDukSi4cpIhri/FM6Qr2rY7CU7jfkmq1/g/kR53nD
	sz50=
X-Google-Smtp-Source: AGHT+IGxcPe6uT4yc9jWNU7ehZJr1E6b4aaoClrPA8u7hsmcPOTrwWBbPYZS8ijvvtGcf2XiujMAjA==
X-Received: by 2002:a50:ab5a:0:b0:578:6c19:4801 with SMTP id 4fb4d7f45d1cf-5786c195f95mr4162253a12.22.1716806237244;
        Mon, 27 May 2024 03:37:17 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578f47126f0sm3208478a12.91.2024.05.27.03.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 03:37:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net] docs: netdev: Fix typo in Signed-off-by tag
Date: Mon, 27 May 2024 12:36:19 +0200
Message-ID: <20240527103618.265801-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/of/off/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 Documentation/process/maintainer-netdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index fd96e4a3cef9..5e1fcfad1c4c 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -227,7 +227,7 @@ preferably including links to previous postings, for example::
   The amount of mooing will depend on packet rate so should match
   the diurnal cycle quite well.
 
-  Signed-of-by: Joe Defarmer <joe@barn.org>
+  Signed-off-by: Joe Defarmer <joe@barn.org>
   ---
   v3:
     - add a note about time-of-day mooing fluctuation to the commit message
-- 
2.45.1


