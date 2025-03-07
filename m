Return-Path: <linux-kernel+bounces-550583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDB5A5618D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB15D3B4E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B972A1519A3;
	Fri,  7 Mar 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxWaCuGx"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9E71A2564
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331372; cv=none; b=cn6HUNAu2TkpnV04TSXJh8+F3QMNWmZUM1dYj6uPiNZ3QXQlqYYYfefG0aSkqCMnj/p0U3CP2ZR0Wbe1HQjzNaHr7CwJ73hu8+GilXXLgbEfJ43NSx438gaNEdoNAhz0o1xLoyFurB/J8e5AJ62ui3N8x6Tg5E4n854XzSRYmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331372; c=relaxed/simple;
	bh=4gFhXFCrCygOdMKuGJHrJPlZjnoFSyXVQ1pz+gtMBG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dr8BOA4JZAUTRCA4q4WUWZOw+6c5o7eQ14G+jNL5ouyFCcsieXfR8zibVmmxLiY7WNSKyJ63gsAExvbmvEReZcMgv1MN5EV1QcxJGe2e+E5hs/ApQStdM/fM79fso/ApAoKlWKe2MlMTKY5LkOVApIX8UaevLgLt1+2iRny1wpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZxWaCuGx; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so1471376a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741331369; x=1741936169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yg7karDvLMJmPNzW6MxWPIC6y1838H20TbkfAL9Gibw=;
        b=ZxWaCuGxNgOnwjJeN04wNMwy07tbg2VtksLmBi7elIZKXULH10K8TxJYyWxPvVuFw6
         4y1H0BA7mNg4gOlgvM/jk6323I/x/zwcFt4EzReQecXYoDhIaAuHmCNqI5DPed/Cq0q1
         3PXL2ITbOukkCRHdBiOkz8IoF5fCiNyumfmdQsgU7py1LG/QgUtpvnFJkBFVFfkZflXQ
         Y3CZvCFzNUbERDe1qWVrWeUnGzc6GcuLxpNGyQi1gJwkLffvBaezCTKr0uQhYyHX6S4i
         bXxLTzvIiHM0tP7pbUeJm9YRHIQBs53M0fzuomgZsqIS8LjNUCvNqw6RFES8WDcpt9JB
         RDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741331369; x=1741936169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yg7karDvLMJmPNzW6MxWPIC6y1838H20TbkfAL9Gibw=;
        b=ujqamtU1eo4Ue8xIFu6PNVuxpus7ZyNyjfz50RYU88LrRTjIiYLqJAIHyTY/2h+am3
         cO6jhxH8h9dS0x5vZoK4mkmbxgTv1gd6H/7fXlq79R3LtAxQqAJ+YF1DOMJ5hrdDbQte
         9Hn6BuFDpTgg4kGCiE57g3mcfApssCyjz76RbS1YwvfbLLG/zW5iZCFYuuWzDyhpulTm
         VDPNjfIcFNAeq/cT+hG/z8oZbbdxbVoQ1zZtW991qjhzLz+ZbvnmFLeeertIz+FOqxts
         oFUAxZ4+eZUdlL4vZOIQ5EYuN09O1T7wbvUrkEDX77Hde+eFEJc4kYNv7Avmcyll4SSy
         cH6g==
X-Forwarded-Encrypted: i=1; AJvYcCXFMdgL7f5KiDfXOgZJPonzC11XOChqHFyTO6dCEZQGzbVS3ATZHUL96UcDDkF2dewjEGOMWNZwzon/w9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIn8bKkFPz+W392cbMBAGUiulZGXhj7RtmWeodyvjpHtY3d9g2
	XOwHrrX7pQ08uVW9J47GMWyNNGnQ2YCI0GzR8wE/diM0Xtw3EZJQzblHPe7E2H4=
X-Gm-Gg: ASbGncuMQSxo8+aZBYMKPaVxuvfTptCd3FR22qTmH08nwcnqAO5wT7+J/v6a5VzM7jQ
	uLnnjNFcLiv/AH8zRzPyfdvMtMLfC80y6t0syUnM467GVjbnEGiY/es6P/2aFaHsNTWUPyDS2m3
	XmLEBGGM1wmw7GAguIhpeVk6/8luNHIzrAuEj8OdF2SwaHmnnAcJuWJAyJzC3oNthmWOt2XhxBe
	fW94qRseMvEbroD4zY8cZwShts77X4E+hSjH9U2m6vst081944Bk5CR1vfkiCNJNcdSMjHUVJdR
	01sZZybLAG6rxGcxNzWKRAkkhJkQut39Vs0byc6QhdlB+Ng=
X-Google-Smtp-Source: AGHT+IFb45mARFX0qP0YlJsK5jevlrLSXeiATCG1e3cn4VFCzms2mMZE64ROEDh5mbg9biN6kWp28g==
X-Received: by 2002:a17:907:3e16:b0:abf:fb78:6743 with SMTP id a640c23a62f3a-ac252fa0fedmr230862666b.35.1741331368142;
        Thu, 06 Mar 2025 23:09:28 -0800 (PST)
Received: from [0.0.0.1] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239735b58sm223243366b.117.2025.03.06.23.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:09:27 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 07 Mar 2025 09:09:05 +0200
Subject: [PATCH 1/3] mtd: spi-nor: explicitly include <linux/of.h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-spi-nor-headers-cleanup-v1-1-c186a9511c1e@linaro.org>
References: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
In-Reply-To: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=985;
 i=tudor.ambarus@linaro.org; h=from:subject:message-id;
 bh=4gFhXFCrCygOdMKuGJHrJPlZjnoFSyXVQ1pz+gtMBG0=;
 b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBnypujjrfr9giAXetmsb/ytpbqhMbjmbXMIi8d0
 t0BN1PInlSJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZ8qbowAKCRBLVU9HpY0U
 6eHpB/91R+qni+lmkln2NU5TlE9N7S2KDocb0p7KLq/1c5gBDDeewQejt/L4T3ryHbDKdckzXUB
 0dEr8Xk4L+NxdWmZfFvUXLliCB+whQlpxPz8V5TYlVdtrviW985x+vR9CCzuUy7eXaY6KuhAtxu
 nDewbXrmAQUJ5fS4bN3DYFQv1irAKsLsYRfZun3hayY4/O75mp8gYoSEEsepUbqq6NY6SVx8cKD
 fjM95x872K0KhMPZB6ibqdWCZ3FBToy73SSALaJeJ4+ae4cgqu14Zrvsg7S4nE3IbiAXxLpMKh7
 /SWQGtQmHtq20MDuk3nIpJTlgJkKoyMfRprstLmOzuAtv/Sd
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp;
 fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D

The core driver is using of_property_read_bool() and relies on implicit
inclusion of <linux/of.h>, which comes from <linux/mtd/mtd.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index c9b970f35c6b23a962011ee3c543ee9f4df711d5..1091c83294fa33393f27f914efb254da7a7524a2 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/task_stack.h>

-- 
2.34.1


