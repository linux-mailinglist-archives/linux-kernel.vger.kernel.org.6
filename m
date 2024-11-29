Return-Path: <linux-kernel+bounces-425878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41FF9DEC1E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572DDB224FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C51A08A8;
	Fri, 29 Nov 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XyVbdnU3"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F419F419
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904990; cv=none; b=o7ICYOHqbT1CD6Jw9kKBFNuFTUp4Lw2Wz5eJwfSsEUbYGz+vx37fxR31aEQXPkj6TyUXlUmm+QwJSK+IBxTJBJHjncBhAsqeBq5poFoms+yuG+PirbfB0c9qvYphDe8l4dJdkP0PEAo9hVqZtkLIRk8qiWuRYToVq2YoFmyBM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904990; c=relaxed/simple;
	bh=7o3dPXXYzy/jqYfXlNc1DoLW36c00qph5d+kSyrAx2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l7nFUeqd1jALRJwQEAwADXogaN6b60fNk9EmxGj1VOwLtamyT7sLRZtufpZKBdxKnE4s/Bv9QjXAZvNZJiaVFXDQ1aBr+9frmJPWG7e+qtc50UC7LPFIeCSYJgasIvFSFbo5UZJOqs5DrckeU51mKpWsTO5m6beA1Mgr1DlGVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XyVbdnU3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46694ca7de5so22293901cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732904987; x=1733509787; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QsGkq0TgYPWhbtZ+yoEmD4Y+iHxFQMMwCwAQQxSHSG0=;
        b=XyVbdnU3Q4B0B9JJ5msXueiLMgKg9kPC0cqhl48+Q0IwgtLhaZ0nsORkKl1qY0tUkS
         02oDbNGtJicU28agiKzOTjQ/SRcg9uEWNrgxPOWPTNhIj2s3O1ZepGXhSbJYrLqF/Z9Q
         cchFvoXv7wdObENPja5+KYV8rpjYKKhDUZuXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732904987; x=1733509787;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsGkq0TgYPWhbtZ+yoEmD4Y+iHxFQMMwCwAQQxSHSG0=;
        b=Q4n0q+IJtTq3ZyrSugRCoAtVIG+6/N/u2uB9bjLst/CBTSEzYwNhYXS8pV/7T/zsOt
         jVbx17/FKaDi/6L2p/6e3MBpuz1BG2mnQmCVmhm6Gqp5KkE+ZFy+rXTKMkUOpkG76+nV
         UIwHqlQS9+78gW+tx3U5CnBDoXC+neXdVQaTa+otgMIZiEQTIsAqyrk+6rMqnR14jrbB
         scJl1U7wBbn69Avm+TvxrzfN/RdeHM/JT+qfPfBjRw2IgGwfq2po2kTr/tsyrEjOcrkw
         hNN6YLbcKD7PwWVF5PxRJ10Rzy0JUl0ipdAoRad5WJPv7orku/TIEq7n4PdPrEwE3+7a
         UXhA==
X-Forwarded-Encrypted: i=1; AJvYcCXGTm04DZX9s9uUTJxX/Lpwmuw2MB4mX5Gqt4l9ZtoRqhVS38Z7eP76kmbsZkmrbiJvk+nYmZ1HWk8DwMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCoJniLcmgHKkQUHKBi1XNO/+UBT8VqMzCrz7LcZPqFAsMA0wt
	n+Bw2uW5jYRdsMitYJhAqxPotONcF+eWEV0UI5LEwTLF3ta+to4+5strYE+V9Q==
X-Gm-Gg: ASbGncs1jsa2fEjFkd1ZVGlEsWZf9Q+HjqpjFqTslWQMp4QGJcicja0u8PlhKSr/hrE
	PXIzI7lLshh9cyyHhPH5PFEvMU3VpDFY+ZQj0jt0biQ3Znc5Jl85HtAg2nsET1H6/sThhgVzfaK
	a9PuVrL7qkb5A+DV8XqdPkbWSWo5KGPB60s0wo7BevjaNC7Kg/c9BW6vweKeka2N0VXBZ/AW+qg
	y+9EUrSbw8m12uNNurGCdCEtmJUZhfm8TbY6Furbg/Dhr70mXSfzoJx/JfweopV3NFfL3koII9w
	7I+0IDSw6qMo/cM2pqRsR529
X-Google-Smtp-Source: AGHT+IGUlm3S5aBJeVhw4npdkqy+q8slOMllM3yCxxu2APty0Zw3Rq2h/hxnY0IAhbTKexgxOjuKoA==
X-Received: by 2002:a05:622a:1908:b0:466:8780:5b24 with SMTP id d75a77b69052e-466b3516861mr199090791cf.18.1732904987444;
        Fri, 29 Nov 2024 10:29:47 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c421f86dsm19329161cf.69.2024.11.29.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:29:46 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 18:29:44 +0000
Subject: [PATCH v2] misc: Kconfig: Make MCHP_LAN966X_PCI depend on
 OF_OVERLAY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-lan966x-depend-v2-1-72bb9397f421@chromium.org>
X-B4-Tracking: v=1; b=H4sIABgISmcC/3XMQQ7CIBCF4as0sxZTkBJx5T1MFy0M7SQWGlBS0
 3B3sXuX/0vet0PCSJjg1uwQMVOi4GuIUwNmHvyEjGxtEK2QnAvNnoPXSm3M4oresutolB6l7iR
 2UE9rREfbAT762jOlV4ifw8/8t/6lMmecqfbijNRaGenuZo5hofdyDnGCvpTyBbj+5EGvAAAA
To: Herve Codina <herve.codina@bootlin.com>, 
 Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Drivers should depend on configurations that can be user-configurable
instead of selecting them.

Without this patch, OF cannot be disabled this way:
make allyesconfig
scripts/config -d OF
make olddefconfig

Which is a typical test in CI systems like media-ci.

Now that we are at it, remove the dependency on OF, it will come
automatically from OF_OVERLAY.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Depend on OF_OVERLAY also
- Link to v1: https://lore.kernel.org/r/20241129-lan966x-depend-v1-1-603fc4996c4f@chromium.org
---
 drivers/misc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 902c306bc972..d617105fbda7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -613,8 +613,7 @@ config MARVELL_CN10K_DPI
 config MCHP_LAN966X_PCI
 	tristate "Microchip LAN966x PCIe Support"
 	depends on PCI
-	select OF
-	select OF_OVERLAY
+	depends on OF_OVERLAY
 	select IRQ_DOMAIN
 	help
 	  This enables the support for the LAN966x PCIe device.

---
base-commit: 7af08b57bcb9ebf78675c50069c54125c0a8b795
change-id: 20241129-lan966x-depend-8bc69b4954e5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


