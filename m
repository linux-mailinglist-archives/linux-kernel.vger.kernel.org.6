Return-Path: <linux-kernel+bounces-550582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966BCA5618C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875D33B4CE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258FD1A23B0;
	Fri,  7 Mar 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yvd6jZ09"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C21519A3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331369; cv=none; b=fpiRLFyP1UYXChsWxog8ArhNokt42b2shNxF9hvaX15/J6cOiRX0cSs5QfBNFCKq7w9I602rX6bqQm/0TdutIb6a+Df4ccKPjA8hKnwlB5rDtPcXWz/IaUVRocJcgjNLQIa8x6DzYHi7NFtPqyha8toxYj/+zzxn4v55Pv24UCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331369; c=relaxed/simple;
	bh=LTgmhF3yOudZaS4ugAkCxqqCzkuqv1Bqu3SiKsYRf4k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XlgRq4f9wC+BFdkAc72Dp6idtKZBnXO2tyUwVCY8XyxOPUYXKWIunfYE/EI3STAf2XtVrNu63H+LALr1CQuLh4gDbkRLR5scZbaONxfoA7Ucw77pph8pYb6YAh63ozTvLX1ybLmJ1HM4rZO+urXTFDTm/7R8bcdcd3gYwT/geTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yvd6jZ09; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso307548066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741331366; x=1741936166; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcBcclqOktLyLDuTPRZuapiSFs2PPDRarJuoClc9VI8=;
        b=Yvd6jZ098W5+XbVgyNDwkwoZqXpo0gV/wAVqz2iaRXhbGT2uLaayfHSU/gmZKDBtYl
         wyPQCXp3AXbVmDPX+QO/BlQKmpcPYJGUfLrQeGftMgQVChJXkEpedmQqsGY7CGDU2nfq
         PlzS4A/b8gjfkdtg3LdVb85T6wq7WF1/5xsfoAtr/+tutJIO18ArmDUqtFdDR0CAW/16
         yId48wLVrK6IwXr7UkH5LGQ+1abqxKIlpi41MaYLBJux3fhdtJTDsVsZUwGmrjIm1DR+
         XjZLheCiJyyyxkS43bBuWHW8aFBsm0TWLmMh7XxWBZrcobAAITRP2nl58hxvyYH3Ao8C
         gang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741331366; x=1741936166;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcBcclqOktLyLDuTPRZuapiSFs2PPDRarJuoClc9VI8=;
        b=SMSab6AuLWXvL/PamlBbxikZd+WjZPm2NYK3VXaTSEeXf796A7DX3JoCNwBa0iiikP
         2hqY+qL6WE2aV4BAw5hhfy/q/u1W/ZLMEdX0pKB9rElPfblaEikaNQL+Nygc1OFFlKRp
         18ym2T/+w/kxGXDh6clmnxxJ3Rzrx+2GyP6CxNquQfWyY11yRSL7/P3G/vxrb11hOgNX
         TqxonQ2jOcFMqh/Oi7NumrqQljour1IZDN6J0vFzs4mlE6T3UFTpTKCzY2/sG45gbQ68
         5rfSnnIzh0KjcukGC7lEC1iFvMzsZ5DP9JD5JxdgE0/2R3Bp4V1HDbA1fmV5OAF8RlxV
         Tobg==
X-Forwarded-Encrypted: i=1; AJvYcCXgwig17EdRSZuOAsb75w1DtP+K0JvPx4w4IF+xQjy4dqfy9MlA6mhx0tbiHdLuavZzxrYI/VbdtrFStOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHUs4w9l6TexBKmrM/D/q6BMuUFlOYqmEjcxhDBaGp+Yw0F7Fj
	tsPN2ouAPt4Brh5/MeWf8eCQi4HnQ7zPlpEpKc2ZqgdToZFzwgKcymaUlRb2OqpOJq6+Eqc73nK
	f
X-Gm-Gg: ASbGncs97L/2Jr+JXn4gGPcMcL1ZGdMO9cxkIs7/NXgAfG7p3terZpnVEDfnTfiSDRl
	Izcki6DcMXR7LKaCE8ps5xcWqrKp70eOJFrIcL0SmnXOsdB7G0wHa3pknfmXMxBZY003YT1/c/q
	+s4i1NBQ6AiTPm7ycSRfRyOo9tFvHBUXcdg/qLos+cA/GeNSnZCS7Q93AWb+3YQWBA/4FzmDCrp
	cEQDgMYSRpasezjCUMzq1kF638wRtKyzkVEJHNsGY6gvOfzm2kddEZcEJJDLED3Ct4cpKLlfoFS
	SaVbx/dCxFYGdSu7eH4RGRDpSRcH30lm7K5ELWlTZJlKvw8=
X-Google-Smtp-Source: AGHT+IHCo6ZPdTrEbCYJtcGo9pfcJ7SsSYhpzKnGA3RQ+J45U/uHJyVBQkADwejp6EFhQ0vIQ5q7gw==
X-Received: by 2002:a17:906:4958:b0:ac2:55f2:f939 with SMTP id a640c23a62f3a-ac255f2fd66mr146177766b.6.1741331366131;
        Thu, 06 Mar 2025 23:09:26 -0800 (PST)
Received: from [0.0.0.1] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239735b58sm223243366b.117.2025.03.06.23.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:09:25 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/3] mtd: spi-nor: headers cleanup
Date: Fri, 07 Mar 2025 09:09:04 +0200
Message-Id: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCbymcC/x3MywqDQAxG4VeRrBtIvSDTV5EuRv2tgTIOCYogv
 nuHLr/FORc5TOH0qi4yHOq6pYLno6JpjekD1rmYaqk7aaRnz8ppM14RZ5jz9EVMe2aEpm8lhA6
 jUKmzYdHzfx7e9/0DENiCt2kAAAA=
X-Change-ID: 20250307-spi-nor-headers-cleanup-e93740995eb0
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=574;
 i=tudor.ambarus@linaro.org; h=from:subject:message-id;
 bh=LTgmhF3yOudZaS4ugAkCxqqCzkuqv1Bqu3SiKsYRf4k=;
 b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBnypuj4N1C585VWieVif6aB1d60xEr77nwfCkiU
 hoEi4uTfu6JATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZ8qbowAKCRBLVU9HpY0U
 6d9WB/wLDyNAuBzjSrUuy8YbeSy3wPLoXZb87EntEFALxBUvLfVJu4/LdKjKiIr/OB5mnBJp2VM
 fAv5eqq1ukfAjmBXm+HMBm3ZfIiOptaEEBf9HitWDQZ2ZrbAZ1qfldhsgwNzAv6mP0FoJ+dVs32
 as+QwElg/2mNj3/YANxr2XEMRptIio5Dvz0y0948oP7SeFqx5SEAz06rzIR+suxABPafFG703fD
 petzNSllnfVyPbiPzRFXRCn+yur6p+IkNInLtOA6SkyVi+duxYlmFl/CDEYvsw/AoDkMmIo1R5T
 +niW5yqslADFAZqiBHRY1aGIXbmHI1m0PGZDZArpYbEGT4WM
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp;
 fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D

A bunch of header cleanups, no dependencies.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (3):
      mtd: spi-nor: explicitly include <linux/of.h>
      mtd: spi-nor: explicitly include <linux/mod_devicetable.h>
      mtd: spi-nor: drop unused <linux/of_platform.h>

 drivers/mtd/spi-nor/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 93020292fea71d62dc9749745d8ba1b44268a2fc
change-id: 20250307-spi-nor-headers-cleanup-e93740995eb0

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


