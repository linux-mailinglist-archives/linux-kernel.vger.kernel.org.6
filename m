Return-Path: <linux-kernel+bounces-230070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19791780A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAFE1C21CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9768714D71E;
	Wed, 26 Jun 2024 05:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTtv3ysl"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDB14D715
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379376; cv=none; b=mypeTk2I6SMJ07nOaLynT7VjsibEmn+yM6gVUy0fa3gYn9oHfhFu3Rq6vOutvqgdvv+zaAnvkzIZetDkqwJP1zOoFdbzyogO1q9o3jQt9/Qo/hGLoGzjNAo9teUfdm/A2OCFXk+RKqWrU97hBGtFPKq9lN/HNnTUEKdquD6tv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379376; c=relaxed/simple;
	bh=AFul6/rVxErYdfibglKP3IwBx5NV3GxUyi2GHxTd6Yw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o9xJJ2h5OfdmC+387Nsal/pa5I5CrmV2oI6P1MD8jPXY188gQqQBRjyB2mW1lYQ4ArEv7LbgPclCJL7O+We/bLfDehBhZAddJkQSaXRuQaviuhFiN1EbJtUxBmvkwXlFo/B9OsCHR3gkLF1EvGc++n5+iQTom9eug9x//y0pej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTtv3ysl; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dff1bcbc104so11292276276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719379374; x=1719984174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJp+j3ZA1th5Jj4gYDkzEc/kDoBtu3dOqn1pl2+YPAA=;
        b=oTtv3ysl2Hvu3r6Y6RsEHQKekU5YTEn6hw/ziLsaLdC/MPz2ijQggLPppY5tVRJgz9
         tIGjm8zOHsIS88MTm8DCb3i3Y+D6nEaTIPLEIfI27RaeB3sMR6u4R1bFTShJoYlwktXo
         gucDI5H6V754bN3MLXUXp4cO07kuMfkrp2iO3plp/y3IYbRgphIRIHMSALZ4nRZf3P61
         1cOl0RBEKdKB7pkMzSmfa7PA6H178GwgC/OgGBDhfNLdcmvbeWoPtidpHYVC2nhg+cJs
         R9iFWeK5GLiwvbq1DVd8jtwnH2v0URDdiiMDnxAiqhRx8sFQvhB0AZj6IxoDSApU2ggW
         IU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719379374; x=1719984174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJp+j3ZA1th5Jj4gYDkzEc/kDoBtu3dOqn1pl2+YPAA=;
        b=r7a1DvCIPmuIIxcrrBjmzmWpzaWmcKZflnvwODDiSYQgFPwXS7H8Gh+aoaIFvpXXTL
         YumF8XUHVdkYvO471wRz+0BzKgfxuFnvZ7S1ownCi0siOcMvyp5EZn7EBxvw8zBUT+X7
         3NkXCnAcw9tmUgx0HJ38oCceSFH0HJo6ARW0V/f74nbE1XfF6k9MnKdrE4EgmXEWi1Ey
         KjZF9V+LtlG2tPResKVxjb82oT1zbq7U5UErQIJxuEOZJBPkpfQIJH5CQHSR68OTrvxK
         lbSQU9TLGVJ08TrAA7cNP/dn8+JybCmePSX3gpBUG9rP59lx72koO3bD4MUpPn9jDjao
         9PwA==
X-Forwarded-Encrypted: i=1; AJvYcCVTfUrv2Fq+T7XvNcyVzt97XbfsGoeTMkX4TV3MxMDr3NLz4p8Z+3jYE4Ikr4tMl/3fW949ON7O5an9olpNiqLMF/kaRSvKZO4EvCk/
X-Gm-Message-State: AOJu0Yz/NgO+Nc81DJdyg8y9iK0PjhJvjq4bx3F9RGxeaejTzoMStRkm
	1VJeWLmbmfTu8Ptbo1z7f29CTlnsphOk+5LT4R+8E3bmQzxV1RMP6VlIajD19r1TLaGiB0240yr
	oGXErYM0MigXZ+RqN07ySzA3tSA==
X-Google-Smtp-Source: AGHT+IEAEget9B2vSdhGeLcEtW2e3iM8MJIc4bsMLsrXaEbRkZRTj4Qt0WXm1du3qsvVE9pndMPWkZy9XMdUDczBICE=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:1893:b0:e02:5b08:d3a with
 SMTP id 3f1490d57ef6-e02fc29cc0emr62562276.0.1719379374381; Tue, 25 Jun 2024
 22:22:54 -0700 (PDT)
Date: Wed, 26 Jun 2024 05:22:38 +0000
In-Reply-To: <20240626052238.1577580-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626052238.1577580-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240626052238.1577580-3-aniketmaurya@google.com>
Subject: [PATCH 2/2] i3c: dw: Select ibi ops for base platform driver
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

The AST2600 platform driver can always select the IBI ops.
We also need a way for the base platform driver to select
the ibi ops. Hence introduce this DT property which can be
used to register ibi ops from the base platform driver.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/i3c/master/dw-i3c-master.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 77a2a1c3fd1d..dff4f8e4e44e 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1547,6 +1547,9 @@ static int dw_i3c_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	if (of_property_read_bool(pdev->dev.of_node, "ibi-capable"))
+		master->ibi_capable = true;
+
 	return dw_i3c_common_probe(master, pdev);
 }
 
-- 
2.45.2.741.gdbec12cfda-goog


