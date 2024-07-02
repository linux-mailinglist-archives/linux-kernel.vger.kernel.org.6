Return-Path: <linux-kernel+bounces-238421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87835924A46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25726287072
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0FF205E13;
	Tue,  2 Jul 2024 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxt0rJiM"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AE205E11
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957497; cv=none; b=gIuOagWeytan8JFFLU7k6tz5IxKTUuY+Ch+SDcvsOdJUjBrQ1lGtXLucKTCIgd6yEYaDN6xtSLhKn8g+PHsoY92yd+c5x58TT4/hVzpQi2n7i13/aql9xvZfxWyTrvUncF3zpp+pvCWchHwc2NkMgkH/MAazJjfZeZuNnkDUrMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957497; c=relaxed/simple;
	bh=wKsffOuXjQz6csIEgiqYbyUo9lvjHQdEP0b/s+bAJ7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ib9Z68nXD7fRV1jGrnTI0JsUYSVirQKBwW70esfeUKZ/L/gs7kBILDpOnvSTf1zY6oan7XJRQ8Bdczx9r8IRkLrILR4Qq1n2N+8NiPKMu8RM6ZOu0N7GHWW8NEwXY+ODlsNsIEGO8E6KiuNoeVcez5072vHOd09eMTH0NHKC3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxt0rJiM; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f64942fc54so88535239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957495; x=1720562295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R1ZNEsygnLGTQO2NIWkjU0SF7pc6VSZuM8NRzidmQA=;
        b=Yxt0rJiMPCXQE+CTmDJi3n2OijXY++ygC1NrxQrSduTxJmoghZDevNZDL6zeTobiWM
         a2QmNaWmsN4S4ok2uLgX5t1HoaviIhZ+MoUmCXdJ0p0hBenzv3B7L5gC7ATfeClS+apC
         o5nliP/i5KaXRql8kO/04ozZ/Q4sRQWkaQ8c0YKgh7cyIvOHCxiplctcRnr3JoS4QH5Q
         kV1Z7q54dGgrnRd0z1gjxtqFTgucnozFVpMHfYNak4062CeAvjPLDokJKPLDDJBHvmmM
         EwNQC8jUg5bgeJDFTX/AiI+pdCDUhLjGgHYwQ4nK+X3bNiSbs5noCQDsscvhnRj5wq9z
         Y68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957495; x=1720562295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R1ZNEsygnLGTQO2NIWkjU0SF7pc6VSZuM8NRzidmQA=;
        b=VHNqHx3EyCOdMMSbct+l1ndfUEawRQ/7eUajHCp9abYFHBY43ukg9PmM0XVqMT7RjJ
         eNHrJp/HujJhs+ha6kavz1xtctd9niNa8/OkMCl0yKhvELIRmXSrolmKFF4gnz9aUhlk
         5rJJoGi0qbNIqq4FE6chTVzqns5+AF0WJya1FzIkPFSmYB5GJ3AQL1luUhotKvK7UnJq
         H8V4DgtZUit5jJlhFVK6rBq3w5iNu8/yxyaGY+GTfF4ii87poAk1gkfz3jxNrylu4K0q
         9BLu2FmNXrOzmHn/b1UZtvwKAVlmvl5AHPXKZXkSi5FqqnEbSoXX0EZmxk/k3OZlG8SO
         Mr6Q==
X-Gm-Message-State: AOJu0YwYoJGzHXZ+YBFRrlEkUoVmyaSF9XPEH89bglg5Be0Uyo6bNM5d
	Iru7yKX1knzU8GwrkQeTISDBZT4Q9n9ALSEs1ummauXZlNFpGHa6
X-Google-Smtp-Source: AGHT+IE+ttIbCy0SMKnbv8P5dir5+2/h1iAP1anhrhtyYoJ/ag2FDZflxmfE4svH4Uxez+4Zs/MseA==
X-Received: by 2002:a5d:9541:0:b0:7f3:cb2a:a1b2 with SMTP id ca18e2360f4ac-7f62ee85397mr1239939539f.13.1719957495211;
        Tue, 02 Jul 2024 14:58:15 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 01/52] docs/dyndbg: update examples \012 to \n
Date: Tue,  2 Jul 2024 15:56:51 -0600
Message-ID: <20240702215804.2201271-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")

changed the control-file to display format strings with "\n" rather
than "\012".  Update the docs to match the new reality.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0e9b48daf690..6a8ce5a34382 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -52,12 +52,12 @@ query/commands to the control file.  Example::
   # grease the interface
   :#> alias ddcmd='echo $* > /proc/dynamic_debug/control'
 
-  :#> ddcmd '-p; module main func run* +p'
+  :#> ddcmd '-p; module main func run* +p'	# disable all, then enable main
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =p "    %s\012"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =p "    %s\012"
+  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =p "    %s\n"
+  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 
-- 
2.45.2


