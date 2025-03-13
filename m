Return-Path: <linux-kernel+bounces-559437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9B7A5F3CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EFE165B35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B151266EFE;
	Thu, 13 Mar 2025 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TtUwTCOb"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC916266F02
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867592; cv=none; b=k8F5XPN1qTDP8P4d2D1A4QLP3t6QkJj112LDlseO2Sc8ZDfwrsZUFHNGaPhveFeFbWrPPv2An81k+oW+ajMAWk2+HW1qd55Pg4JB2soPetQCsOkqVjF7m7PlE7a+r21KCr4Z0cVJ7HX6tf8weO8wc/D/Y5EQP1bkKmdN2IiVe1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867592; c=relaxed/simple;
	bh=TGrzXI9YKQDJkjN7BUp5Wnd1Z6+rVPCgyfw/0NpdSaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7dlY44kSdiOaxvhpMYBl+Q1JXvoWn7m7YwSqzisWTlXxQJDWiu8TfCuLtCDqehgw5zyRXIejpmPoz4wLY0wFB4fXByUkrX8NIvo7CBRCYWIdXsJAG59VoCCrCq13exLtOp9IxRAPi/QmoLlkRxwUfSL5AmFedrA4y+V8SgCcR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TtUwTCOb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c24ae82de4so81913685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741867589; x=1742472389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVRqh3UaN3gOziVXPfdmS+tvyHN3C6l0olhTDl0Ea0I=;
        b=TtUwTCObajPMc534x698CzZdI9MrxAH2nDJaLQGQNgnialL+2hlCu/MtGzpaWCeyDk
         rys/6twkY52MAfOs1kqdD7Q0aOlbzycVPKYnNoepLx5ZgnxNl4Y5gveyYreoVACq3+a4
         MKhvkvUaFbluXraugO3YQFUuGC/u5I5iq0gGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741867589; x=1742472389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVRqh3UaN3gOziVXPfdmS+tvyHN3C6l0olhTDl0Ea0I=;
        b=u2j19D7Lzvy5E7Wgw+dFh960b+gQYsIuzHKcAGuXobnESGjcVAFVkFuvZYA2xaAfAE
         8H1U+QDne7EyUhk86lQHRDK5pyJlmTFSk0xHRqkpnj46oeEq3W8aKbiObFEgqH6jAA/Z
         Rda9j5HDnTEPI/PDHliP/exaD3Y8DDgGsap+xQwMCjsin7mFMWopxF1TZq69O5CD2cQj
         evHqN6nXliY2cmkFXaLSV1qJ3Kr8/+LGnhdzlsK8Pr5FmyGd/HpHGhu0ZvTslFhfjs9T
         6RlCsvnF8SBMRotpNi1szuXnfcL74WEkX4QTDwnkPNeX+CWVJmSPcoxBh3izZn8Aqsyj
         IRGw==
X-Forwarded-Encrypted: i=1; AJvYcCU5FH0zVG/s7MZFl5GC7E/c88tnUjtZuMbpBCSf8M0dB9LJipfzM57Tu1SvDg9+mQpe/a9wu9MhcDSHClI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSb3F59teDsyc+pDl0iawvXzErE6GHGN3sqB/3NBfgbLLKiKh6
	0oLyPqnrSuSd9O21SzUQvfwkOkV60HiCBcR31VZ/HpeYrkLyEW/QhgxoPi+Hi0T1yhvxyu+RatM
	=
X-Gm-Gg: ASbGncsIbJO04Di+okF8C/PLFWB94DjrSGkhCrPSbo5WglhMWOUgnyZzIVuHvSisIva
	tSmyVhXzQ/Isytp4Kdbhi2rgQeKynFy7tzq3ATMzMzsZS6NeXPDZbx4i/9PEBpW70/fDGvp5Hls
	OqAffvbZj86bTUamJ7RHi4FkBxDtaVd3f35p2Mi9H20r2EzfzetmXp7r/AbNo5Wdkb+ODj6xeUx
	Ta9Odvwbg0LJ5XnOf/vmRKI0IiNHLeqHRIwmda+zvuPhp/c3NIaoKt78ppkP3MWAP1+s0GDCMvp
	v4lgv8PfkSSlsaMByloksOqnP3ExfTx64+NkTQ3FiRDpaMgG8JaZs5HT395AxLyP/sZDx8lsTw2
	0QBKrSTmJWihUWUF+bNivQQ==
X-Google-Smtp-Source: AGHT+IEImbQ+B32WsIFxGlRX2mY8st8KTjcmYXJFgpAh8j9I46osYfnpEiMBC+CME+WXzL8jHZgt5Q==
X-Received: by 2002:a05:620a:2b47:b0:7c5:4949:23ea with SMTP id af79cd13be357-7c55e968257mr2170930185a.47.1741867589598;
        Thu, 13 Mar 2025 05:06:29 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4db57sm92117685a.8.2025.03.13.05.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:06:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 13 Mar 2025 12:06:26 +0000
Subject: [PATCH v3 2/3] media: Documentation: Add note about UVCH length
 field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-uvc-metadata-v3-2-c467af869c60@chromium.org>
References: <20250313-uvc-metadata-v3-0-c467af869c60@chromium.org>
In-Reply-To: <20250313-uvc-metadata-v3-0-c467af869c60@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The documentation currently describes the UVC length field as the "length
of the rest of the block", which can be misleading. The driver limits the
data copied to a maximum of 12 bytes.

This change adds a clarifying sentence to the documentation to make this
restriction explicit.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/userspace-api/media/v4l/metafmt-uvc.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/metafmt-uvc.rst b/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
index 784346d14bbdbf28348262084d5b0646d30bd1da..42599875331c0066cf529153caccb731148023b9 100644
--- a/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
+++ b/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
@@ -44,7 +44,9 @@ Each individual block contains the following fields:
         them
     * - :cspan:`1` *The rest is an exact copy of the UVC payload header:*
     * - __u8 length;
-      - length of the rest of the block, including this field
+      - length of the rest of the block, including this field. Please note that
+        regardless of the this value, for V4L2_META_FMT_UVC the kernel will
+        never copy more than 2-12 bytes.
     * - __u8 flags;
       - Flags, indicating presence of other standard UVC fields
     * - __u8 buf[];

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


