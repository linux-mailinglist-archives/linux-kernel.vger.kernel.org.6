Return-Path: <linux-kernel+bounces-249978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C1692F277
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314131C228F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475E1A0725;
	Thu, 11 Jul 2024 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dey2H8Sk"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B241DFE3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739241; cv=none; b=IQDUofj8+JsE0xwlNkxo1RPS3aHFVYfZf9i9W+LW7Lw/YMhWBFYlYQM3UvQ65Zsp+Vo3tFahzE/XOcjzOGBijflzIPFPtf7XykMcJVEKpKs4r35OrqFGn0i6OH9n8mBXWe1Liw+0WHxzwl0MGaK3cc+7p6JpJ8Ed8o4MDrr2i8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739241; c=relaxed/simple;
	bh=3M0EY2DABXXVKV2UN0YHNuXp8d0HW8YIbLcNOsrEjeg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jICemjr02XHixeV4o8Jq1tBistddDiVvZcOUvqP9byY2r52el33hZAd9S8gxzYESCn6K+HanyfXDjo7d+xzPVeGqT8VoRjn/6RagW1OVJCno5Hwki8IiJjSWyI9AR6a+byIE7cS7vGK/7G3sfDJ7J5gOeSBCyxd/+v39C+LENRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dey2H8Sk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77c4309fc8so218417166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739238; x=1721344038; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byKCeNwRs0T1R6plp9OuqfAkOz/elWWT8jqkCBg7kkg=;
        b=dey2H8Sk/Lwg7f1Gj0Tl9fIAHdXBUnpG6jd09lksZ/2qXhbFkAlPAGjmnRcOidaYSN
         uBvqYhLY6xK7f0aXbIDW8Pjm+espz0KPrFbALST9t8XWmWwC9gBZJ7xgMrNjqS+/v6zY
         00LX2RD9pENRA1C91E7AqE7VIUaaDAZNRnek1qggppZaiy6XKatmOzIgS/+wR2tzhZa+
         S8KAgFifR/bIW84VhNCZ1TGTQvY92MDfGBuwr/vIHSTKn63CUMUIOmdXADE+gw4ftsCG
         63JGHkEyBBeogEBbMej0VWjsDTdSn7raLE7B/lcmrBj6KZsDyGWDMSvWKiB3BzTpNwLy
         yLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739238; x=1721344038;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=byKCeNwRs0T1R6plp9OuqfAkOz/elWWT8jqkCBg7kkg=;
        b=q9kPGEbyI8YxWbPTk/9AuzrVlDkfKyoCGc+RdhV7DvfSnUGG/3WC5+9yVEcXVSFmcB
         xgE+l7OamIjFgQAL4Klh5wJqYA39PcVpt5Y4qTfIu3LICOVSsNX/m2eWwYSsMPLXXGm8
         oZ03njQ/hlKwINQJgx9E9Ay+czlGd6kRE0/B0LawfaZpOs3dC4ZyR/dmRAP8MA3pY9BS
         CLd3szyYv0M//fRgL4lMfuvXHvxKc6IkuSxFCfqAEgKk8v8V5CPuZKNUQOreBJukjBp8
         rU4zwPT8M4bR0GBeronqBl0U/HJH7glvU+YH/yjECE4GnXt7Gh5g7Oh0PVm6sUyKFRCb
         UJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCV1qLFS5lp3INc+vs20wFmD6JUOHi+2HTHVYuU20dZoMwTYvBJRqh2vyrzAD/YzAaJDJs+zAGlP0EI6eqQiAo3Nx3jeioTbkeE9VSGn
X-Gm-Message-State: AOJu0YylAz5iQFON957Cn4qAsVCN0DDNj1WVP6nBOIVWUVkyxuoVChVm
	W5Nz8fzIdsgj/4xZBdetM3B9VleH4tqurQ8dGK3YPysAHDzDT3ikbwynjQ==
X-Google-Smtp-Source: AGHT+IHTbjG/RYmwHcT/Q3lMtncGYloiLd+y4K3oAC67A0D4AU6O7kPZeN9IfTq1U1PJ5DxsO9o1cg==
X-Received: by 2002:a17:907:3d87:b0:a77:d52d:5c61 with SMTP id a640c23a62f3a-a780b89ea27mr804898966b.69.1720739237926;
        Thu, 11 Jul 2024 16:07:17 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-148.xnet.hr. [88.207.43.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc52sm287890266b.4.2024.07.11.16.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 16:07:17 -0700 (PDT)
Message-ID: <4aa9b897-4596-4e2c-8dda-f24ab51e9b7c@gmail.com>
Date: Fri, 12 Jul 2024 01:07:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: [PATCH v1 1/1] mtd: slram: insert break after errors in parsing the
 map
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The GCC 12.3.0 compiler on linux-next next-20240709 tree found the execution
path in which, due to lazy evaluation, devlength isn't initialised with the
parsed string:

   289          while (map) {
   290                  devname = devstart = devlength = NULL;
   291
   292                  if (!(devname = strsep(&map, ","))) {
   293                          E("slram: No devicename specified.\n");
   294                          break;
   295                  }
   296                  T("slram: devname = %s\n", devname);
   297                  if ((!map) || (!(devstart = strsep(&map, ",")))) {
   298                          E("slram: No devicestart specified.\n");
   299                  }
   300                  T("slram: devstart = %s\n", devstart);
 → 301                  if ((!map) || (!(devlength = strsep(&map, ",")))) {
   302                          E("slram: No devicelength / -end specified.\n");
   303                  }
 → 304                  T("slram: devlength = %s\n", devlength);
   305                  if (parse_cmdline(devname, devstart, devlength) != 0) {
   306                          return(-EINVAL);
   307                  }

Parsing should be finished after map == NULL, so a break is best inserted after
each E("slram: ... \n") error message.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
 drivers/mtd/devices/slram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
index 28131a127d06..8297b366a066 100644
--- a/drivers/mtd/devices/slram.c
+++ b/drivers/mtd/devices/slram.c
@@ -296,10 +296,12 @@ static int __init init_slram(void)
                T("slram: devname = %s\n", devname);
                if ((!map) || (!(devstart = strsep(&map, ",")))) {
                        E("slram: No devicestart specified.\n");
+                       break;
                }
                T("slram: devstart = %s\n", devstart);
                if ((!map) || (!(devlength = strsep(&map, ",")))) {
                        E("slram: No devicelength / -end specified.\n");
+                       break;
                }
                T("slram: devlength = %s\n", devlength);
                if (parse_cmdline(devname, devstart, devlength) != 0) {
-- 
2.34.1

