Return-Path: <linux-kernel+bounces-528401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428E6A41764
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D8A3B64A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E6918DF65;
	Mon, 24 Feb 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZejnnRJ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA741AF0B8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385646; cv=none; b=Bv0IuzVvV1ABLFI7sY0/k+hibIjbNvfO7NCK6EvBsCtEqdK4YhPcsZoBI6GrQbLgDUcv4wrQsaJFIpkyvw+qDIFfbATzUMptEEFfCiIFTht/BjkH+OletaO4VSlbXPb2u36EBUgnMvyVJjT+AHoEeONjtILgwMLAKew+anPFUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385646; c=relaxed/simple;
	bh=Gd0AsB4MDJqJrTBiMBmfW5sN6pr/39RogZ00/SCGwSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KRfRJf9zLqSDyrWPI8IkF0yaTItVhKsO/CASNWOfY3IYXACXc9PmvsikLh6G31iCKsg5Q4lJ5326k/YF43kvkwwPKt0KNm8iLtZkegNtHxFrBmm2TUMMEVqWz2Xg7UvNEnEC8VG4sx4e91ijLrmWdxPGvOYKW3ui2y41YqDj7S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JZejnnRJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f286b5281so1966372f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740385643; x=1740990443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmrEY3WJOxkwx04Dfoi/hh1YEUUv40j0mnJA+Iy5ldw=;
        b=JZejnnRJU8e8VlTTkKsW5r1Wuk7b3O21i6DwQy/Xr5oYoz+cZMqn5ar/9wp+slZURM
         MgTGJna7TuZLwgCsBtCGpnrZZOL1iK4PikbUaP12tYAmFILaGUlqDN6rTTLxjxwN7EnM
         DSNmmiCUa7hYlabJcQC2atOo7It/1kWtaDf0/Gj48DA+rlC8jc8gJmUGQ3H0PvcBCdfE
         3SKvmn50N5mjuQaOeuq9LplXT2blVujLAUaK28MBAKuE5mV+g2x8XolIL3qMQ3ioRb1m
         B6kVGkKMpbo8qD/Wqv6BwtuMFGU3C0u89/Eg0r6ad570kPhw0Hi9RS9Id1TIut+mdJ8g
         4EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385643; x=1740990443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmrEY3WJOxkwx04Dfoi/hh1YEUUv40j0mnJA+Iy5ldw=;
        b=u8B8xxlWNlTEP1x+5qYIF/Lqxx6bUQ11nwZ7Dgl/OVRZhPKhzr3Z5IrV464mq0BLo3
         hQl3iXAPXdRydS3wd/5zvgP1qsaRdH4URUgGD7P0ff1GbNPQTXnaV8V7tNZYKRr2dyoI
         ilh0gyi2JXGKeTK980VE0hWWCEcbEE0UVX9X/d2nuk9nB1/uVB9Wliw3PB0ogWNj+kIy
         4Pv60PGqnDBfdJtYNquZ/1/Uh4znRlyw3s0X6K3Zm/I6cEds9cMxNBKYmA1juDnJttso
         pE1CWBLbmDjzdWbUEc0+vivxFtXlQm0dT0zxnjrvNGipUeODBtbZGCCqgBGyFghDH5L0
         n3fw==
X-Gm-Message-State: AOJu0Yz6g9WRZ2rm0PbaGSZ6DjHARRpzKP/TMCs3lLP4ejcNYrlu1Uu6
	0jdgFNIxAmYFevUvBqJprWyT/gwMOAl1R6+8j52xrB0HtRJndYsl4gNIl39/6EQ=
X-Gm-Gg: ASbGncv40iYNBsCtOeqZzQnZ2IXGRBzLNv3Gdv/cvDcU+oQu8jcikAasHNXrqoQ6fa+
	YtKqhb/og0pjnOwTAYHlJeFEqFTIQ+DfTz42CzecVdJpYSHnSVGLXohJXX1qZoU+22Cwxsavhbc
	UvWD1j5LF+WmM6kgaBSqOPdX1j6e6LXxI6Ne3RGVKitD1oNO5Xe0YBKPbc/imJNB1TIQfX0p88H
	ITK7Xz61FR/C9XEyJpSfMz8BkacpnTenAUYqIvS0v9mK0hKSS2lfi9/yHjihrbviOEH6EHJvc/o
	1EFEGlpkR+uxjytiHSEaRfXPEv+5zimYuRgDICRU+9vV3denUbKtWWf7MYWckfsuBDRtOgz+1dg
	4/abQLQ==
X-Google-Smtp-Source: AGHT+IEJEKFpeJYvKv06leQw9wcqo2Q70UNfL8ohmFub5mnVp+G5VXXa55IvFzh+hxNQhs1kKIhwoA==
X-Received: by 2002:adf:e612:0:b0:38d:de92:adab with SMTP id ffacd0b85a97d-38f707a9c30mr7054960f8f.29.1740385643274;
        Mon, 24 Feb 2025 00:27:23 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce428sm101226065e9.5.2025.02.24.00.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:27:22 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 24 Feb 2025 08:27:18 +0000
Subject: [PATCH v2 6/6] MAINTAINERS: add mailbox API's tree type and
 location
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mbox-mutex-v2-6-9d699148fe4e@linaro.org>
References: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
In-Reply-To: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 peter.griffin@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740385635; l=688;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Gd0AsB4MDJqJrTBiMBmfW5sN6pr/39RogZ00/SCGwSE=;
 b=UV5W9I8qx2LKXZRy+5vNYtrNiE7l5y6zkn9rhEFzJy8kY0k5yeuNtCl2MrtNVOarrhPTnsp1U
 FiVZqN2UqvED103TzA0mu3bzJ3QMJZhkm5UMvSU4r5yqxicSwmiXQGe
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add mailbox API tree type and location. It helps contributors know
what's currently queued.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20163d8a8d90..94f8f59c71e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13735,6 +13735,7 @@ MAILBOX API
 M:	Jassi Brar <jassisinghbrar@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git for-next
 F:	Documentation/devicetree/bindings/mailbox/
 F:	drivers/mailbox/
 F:	include/dt-bindings/mailbox/

-- 
2.48.1.601.g30ceb7b040-goog


