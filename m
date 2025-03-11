Return-Path: <linux-kernel+bounces-556711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A82A5CDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263A83ACFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5165263C77;
	Tue, 11 Mar 2025 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nHAbOzJY"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333B25F7AF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717458; cv=none; b=rLQQvZAgEIBICrlPPSn5XUrnt0Taiz0Aa1KaksUo+1P2zkO6F+t40/z125zvE917MUYM4bZ8VsguFHthHzbJzDadPDV12gNPRM0kWenp8LQlwFufOhx5F5GPFxVDHMaqG2+n4QSi6+woB85Rg5sLzojrNq4rOTx6xFIlo73kTu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717458; c=relaxed/simple;
	bh=tpf/mDNfeil7F8O6YAQ5U8g/fjc5ETa+OCrb7g/Uo6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jksc3JJOAafbrt4GL0Fd0ZSQE1DOQFG0a85XNdAwpq4lj4F2am6nx0nY3SlTe1vrLgnznP6IdkIJvG3afOJa+/vGMfIder95JLELMh5uMU9r9HppZPcBaVgKZ2KIDry0q+dp/VqJRjqoHqqVbj01C02SnBuQ5qeNV/VV7jIJGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nHAbOzJY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso9111714a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741717456; x=1742322256; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7KpDa/DEzb44vSpz/EoTHsPUYlYrzw48Wo3fhhLmVV8=;
        b=nHAbOzJYBLcXeFjiUB8Z9wsT1pd6dk5DZnuvRMwF/WHoNrtV0CmFrwwkCM9PusIiGz
         tADYmwLQV5JtAqEmoooDRUReM1IX5aMCNIQx1/e8mQZNGNNumgmVaQzNNaWUsBJBwB7c
         MqxOhknAYyUh7piolb1VdpH0ZofEXxLnEP5Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741717456; x=1742322256;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KpDa/DEzb44vSpz/EoTHsPUYlYrzw48Wo3fhhLmVV8=;
        b=Mnf12zyzYFCRYa1palVwUvE1jqOhLYIdqLIw7gCREcQA/7i4b5PwW4E6+UpHoJgTVB
         Rann4lBnA0f1j3Bbs6I6f6eAGJklh6TRMCMzSPWB6kRQvy0HT9BiDdOx3h/WfyzJJlf3
         1G2dG5WOZVzzPDdO9zJIsn+9TSaQ4IIaldueNZhXltUDd+tjInykB+e+9z9fCZmk2/5a
         3hqkK8dF3eBX7a04iz0kEtpalDo1HXEbnc04AWzzw2JCapCHX5bYgA8uU/T5i0AMu/ZB
         ywQppWQuyYw81F7Nkj0V3O3rx+Ce8FM3mAv087UbwFFG6f4Ui1rqpyS81vUskDdGXI+I
         2G+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWG5NbQi333XW0L5DFApmCO0+NERX1IEaNMNH3kLOW3nvjS42wCxRltxfPzx61pskj1QvKNDVlM6pTVOx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdCeG7b0DImhUCZWz1B7tmRWLKiTXjbmN48IeTpKrT18GAVsiL
	0cAHMLLGp8zsn3+73wdbnUXikR2fdGWAdDiiGXJmd/1oJSLHzMSNJx+KwUjzdA==
X-Gm-Gg: ASbGncvYka3VtpnsEuf3ksJR8YzlPoIaTidCt5LbxYayU2VjAg0qvwrsjUvloHA2Vld
	VuPu3TPnMKF8wKzLGDrHpCC/tD41/xrf7rx3YR+p4rPRG4owAc3xh1Hrbu8KcBG0yV7Q1yPVQPt
	WeyAEShdiLOyHzTm5XkfFlLNG4WXLqxvQbz84I/wkl/VMVtNsiwwQJjNooUDSpjjsw5bU+X1cJe
	OV0A6ijtSxpaq0mTAjr1s0tMm/90yuP3TZ89Z+JOCd2kOOFee9zaXvzfVciCCzSIqDB8Hj98y+W
	g0EjRjhJQEFYaZUCgdnnOhVUb0q3VzAs5POEO24FvSm24R+NzKB6KjwBkRSoO3QL+xSOiiGHxcD
	m590MlvdKwmzd8BP1Rju66gv9
X-Google-Smtp-Source: AGHT+IHJIFBe2sp5aefvMU/+B+c+/u+vycxKjjJCB5yGBHEUo079bEIqZxKID9+1kXvZn7DFB3FGYQ==
X-Received: by 2002:a17:90b:180a:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-300ff105730mr7049629a91.18.1741717456043;
        Tue, 11 Mar 2025 11:24:16 -0700 (PDT)
Received: from zipper.pdx.corp.google.com ([2a00:79e0:2e13:6:ea1:ba82:2605:7d4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e773dddsm12265383a91.12.2025.03.11.11.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:24:15 -0700 (PDT)
From: Fritz Koenig <frkoenig@chromium.org>
Date: Tue, 11 Mar 2025 11:24:02 -0700
Subject: [PATCH] Documentation: ocxl.rst: Update consortium site
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-dead_site-v1-1-7ab3cea374f2@chromium.org>
X-B4-Tracking: v=1; b=H4sIAMF/0GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0ND3ZTUxJT44sySVN1USzMLYxNLQwMzM2MloPqCotS0zAqwWdGxtbU
 AKoOjYVsAAAA=
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fritz Koenig <frkoenig@chromium.org>
X-Mailer: b4 0.15-dev-37811

Old site no longer associated with consortium.

Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
---
After mergers the OpenCAPI Consortium does not seem to exist.
The github page is the only seemingly relevant site, but it
has not been updated in 4 years.
---
 Documentation/userspace-api/accelerators/ocxl.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/accelerators/ocxl.rst b/Documentation/userspace-api/accelerators/ocxl.rst
index db7570d5e50d..5fc86ead39f4 100644
--- a/Documentation/userspace-api/accelerators/ocxl.rst
+++ b/Documentation/userspace-api/accelerators/ocxl.rst
@@ -3,8 +3,8 @@ OpenCAPI (Open Coherent Accelerator Processor Interface)
 ========================================================
 
 OpenCAPI is an interface between processors and accelerators. It aims
-at being low-latency and high-bandwidth. The specification is
-developed by the `OpenCAPI Consortium <http://opencapi.org/>`_.
+at being low-latency and high-bandwidth. The specification is developed
+by the `OpenCAPI Consortium <https://opencapi.github.io/oc-accel-doc/>`_.
 
 It allows an accelerator (which could be an FPGA, ASICs, ...) to access
 the host memory coherently, using virtual addresses. An OpenCAPI

---
base-commit: 0b46b049d6eccd947c361018439fcb596e741d7a
change-id: 20250311-dead_site-e96834910663

Best regards,
-- 
Fritz Koenig <frkoenig@chromium.org>


