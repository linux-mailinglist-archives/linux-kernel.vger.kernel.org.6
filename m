Return-Path: <linux-kernel+bounces-425745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D79DEA14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFD028160D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298801A08D7;
	Fri, 29 Nov 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJFi1XSf"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1519F131;
	Fri, 29 Nov 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895947; cv=none; b=c8V9GD8F0UBBdipAHzrwPOALuFn4fliMaI4t2lmGDgMQ+WCcEykfWoURkMNEP7JvsYb4Rdl9BlAq9N8iONSFIsel1GWd9m0x41QGdeuHW4g4T3zoM1oUz5mBbRhNVYS6M2LTMsxYACRPfw2B5ifLcVszDr0qj5aZhQr4M24ljU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895947; c=relaxed/simple;
	bh=rqkHtD6EwjRJGXY2csY/dazWRa4QmRqhNcTNC7LvMmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBnX9exF7KWpsZ277zPEE5/SHQAog1rSJKgYYsRHBPt8pky+tapxdtjBHr1x+GQGQsc1817NiDYTApjzPW4gvdPuZzJaXGbSCUYWnAFURgJYE10tVWqy/HxGbjx5uNT2alluP+Du8UcL+2ga/OTn2pob/HR041vdwKvYhI3+c+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJFi1XSf; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f1e573e65dso653603eaf.0;
        Fri, 29 Nov 2024 07:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895945; x=1733500745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzoMrkJxZaCg7wBkCMRChgW/WckCWeGemOGQ3ada7SQ=;
        b=aJFi1XSfRSm5GVUcXDt/ts7X7WXxRA1kZjBfOGZqegl2TYrt7KED/gImmNrN6upQ39
         gfmcKPo0NDRPenjMJmniCg9cvHNXAERAyAdn1q96YpNCxBmG/wNJIrdXJ1vrOWw6AbjD
         vzfk2GBvIBM+XNUWMey9U2Qbmc+VlQxGPjokjmklOmFyPX9WZXDcakuJLusSvrGcREM0
         sd38VAtm+oRniPL31njXMEoGyKEU8vafy/4JHCknGx2mR59fYOYDxd79ogTNGYETk2pV
         ZsS9uTtKicCfPwMJDcacAVnAxXOKpRUlUnKlk1rdk7G30/ATfp7EdEOklEknINfextlC
         sWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895945; x=1733500745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzoMrkJxZaCg7wBkCMRChgW/WckCWeGemOGQ3ada7SQ=;
        b=us/0RWdSvhcSTHO4FzgOhUfrgBHANb1nukTOKGoWFgOe3i3Q9WBKEyaGbJTZSOAlLw
         lWqZrDHYg7xBy69xDIoocfX78NRORdfs4SsJbp8xLEodqcdRwyfFFBbYR+djv155k/uN
         JmW8nwQAiW1HfbKfmdNUkQDI2dZjWJQWtrYsgj6ODnHnkM6nbwP1YxaJeEAFQI7AyjH/
         230u2qIe+PmtyLFZajX3zu8gTlWcDpXmHm6rN11MsNw/+JeOBVLy+FW/XBulDBaCvSeI
         MzmrXh5a+BNNA1hHXXAVAVW6in7gkC9X4JokQTrPLpoz/ks8fs3YGAsrQ1h2uEd63Q5B
         upxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPnf2PY5zJMEA5CtdcHkWcMaSSk8tKigqDwUS8dNVHR/jxYYkYHpWSPfYxH+qQqQqofHGYvkuO/+LsgIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9qgwlNkrG19EAhZKv8oJFQnZn/HNb2Tt5x7uEb+3lAWZodpF
	+vUhrBgMkh2bOD5kjZ3HTlS8wK6PAflChE/4QcA+0d3wginFqSIWGYtMEw==
X-Gm-Gg: ASbGnct0lKTW171ibb0tzSmjZg+//czpdPdFnN193vsD3vVwpoyPSm3KKcOt7hwDKFJ
	XbFkPJ9YcH/xCcspwJAY16zhVZUMGBHW2GBYxR+v3M8jFMFqD5d6SuTKu/iPCMUFvfz2EscBTWi
	RGX6UTi1pvIrQFqBLELXontrZw3h/CGx+/rmh2rPRMPJhSRZzOYcLiAvzXo983UDHrVt604LF6i
	LzdSgtwazgI/iCCSPPp60sZMujboJPOCXDxb0rJ+d+sDjt3ideKTJPc3xY05x2kp2YH5EfEA1N6
X-Google-Smtp-Source: AGHT+IHElCuQ7DTZuarRABOdNaEJRHlZAVzd59Mo0eflwDJQsa9mJo3giajm3aMDABOGIB6aqwEriA==
X-Received: by 2002:a05:6830:6d16:b0:71a:21c9:cd62 with SMTP id 46e09a7af769-71d65cabfbcmr12593507a34.17.1732895944806;
        Fri, 29 Nov 2024 07:59:04 -0800 (PST)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d725f2251sm794385a34.68.2024.11.29.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:59:04 -0800 (PST)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	avadhut.naik@amd.com,
	bilbao@vt.edu
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH 7/7] docs/sp_SP: Move development-process to top of index
Date: Fri, 29 Nov 2024 09:58:47 -0600
Message-ID: <20241129155851.1023884-8-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
References: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All documents in development-process are now translated. Reorder
development-process to the top of the index for translated docs,
matching the layout in the main Documentation index.

Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 .../sp_SP/process/development-process.rst         | 15 +++++++--------
 .../translations/sp_SP/process/index.rst          |  2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/sp_SP/process/development-process.rst b/Documentation/translations/sp_SP/process/development-process.rst
index 5430c4cc001b..261bcdea3ffc 100644
--- a/Documentation/translations/sp_SP/process/development-process.rst
+++ b/Documentation/translations/sp_SP/process/development-process.rst
@@ -1,7 +1,7 @@
 .. include:: ../disclaimer-sp.rst
 
 :Original: Documentation/process/development-process.rst
-:Translator: Avadhut Naik <avadhut.naik@amd.com>
+:Translator: Carlos Bilbao <carlos.bilbao.osdev@gmail.com> and Avadhut Naik <avadhut.naik@amd.com>
 
 .. _sp_development_process_main:
 
@@ -9,14 +9,13 @@ Guía del proceso de desarrollo del kernel
 =========================================
 
 El propósito de este documento es ayudar a los desarrolladores (y sus
-gerentes) a trabajar con la comunidad de desarrollo con un mínimo de
+jefes) a trabajar con la comunidad de desarrollo con el mínimo de
 frustración. Es un intento de documentar cómo funciona esta comunidad
-de una manera accesible para aquellos que no están familiarizados
-íntimamente con el desarrollo del kernel de Linux (o, de hecho, el
-desarrollo de software libre en general). Si bien hay algo de material
-técnico aquí, este es en gran medida una discusión orientada al proceso
-que no requiere un conocimiento profundo de la programación del kernel
-para entenderla.
+de una manera accesible, para aquellos que no están familiarizados
+íntimamente con el desarrollo del kernel Linux (o, de hecho, el desarrollo
+de software libre en general). Si bien hay algo de material técnico aquí,
+esto es en gran medida una discusión orientada al proceso que no requiere
+un conocimiento profundo de la programación del kernel para entenderla.
 
 .. toctree::
    :caption: Contenido
diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index adb2cc845928..cff972fe0084 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -10,6 +10,7 @@
 .. toctree::
    :maxdepth: 1
 
+   development-process
    submitting-patches
    kernel-docs
    coding-style
@@ -28,5 +29,4 @@
    management-style
    submit-checklist
    howto
-   development-process
    maintainer-kvm-x86
-- 
2.43.0


