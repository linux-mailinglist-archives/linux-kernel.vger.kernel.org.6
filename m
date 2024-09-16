Return-Path: <linux-kernel+bounces-330945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB52897A657
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D387282213
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC6815B992;
	Mon, 16 Sep 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VR1ZGriI"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA915B98F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505913; cv=none; b=XNjJ5rUMCKqc0dw11iltcPcK6geJRviFeRjaFq+wVHNwlHT2iUBL4WZIkEI/1IhlGQ5Xg0Jj/2w7SWLAfIFpLzz5lrPpSBOiy6SvXETjNBYkhJ3lTPNsrAP/4WC0Xcedl8hIcnVGdLimegRgUhkUQyzveBrFMXJbmHr0Z5kHbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505913; c=relaxed/simple;
	bh=Ss6gV6KoFmAdg0J9ELwBTb2pxCTiB9/8V66BGMLwpSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kc1oDLnBMUJybaPjSJ8RKj93KkboOOU9uiYkWUOR//SglChbVRWmJ27XS6duElADhiWj97xm0cTo5J7tvrhQwDPg0jlPPdqbVWZs/dd4F6AyEHk4LsT64hcsF1/iTcFyV7r5xnfuxc9HSaezLRZrXQFaOztvSCneVSDbB3r+770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VR1ZGriI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so634059066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726505909; x=1727110709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkXSCl90OLgwAeRvpNGzT2qKg9IVxF5VpqwKkA/VtMo=;
        b=VR1ZGriIfF6n8mZYz2dFhv6xDsUc0m7rLKucu+yYzSKQe25KzRk804DnA9JmOhqmAn
         kBezIaGGg2inE2lBRc5RjB16iXhEcmi2Sd4DsowQbeLNCRTbDBtEjjh5mfApfHt7Ph7O
         Lip86U+18D+vQbc7FwPsqKa1pHUYkvqsk9r4qhc8Exod00Fkskfd9KXPx5o17dFkdw8B
         Tjv3PxKjsPFT+LTZWQ5reXOIuYXaja+BT2+m6ZJOLF+tdSo8BL+XBhpdNHRwDnflyQWS
         SWc8z5KTQa/t0uGVo2eiIpGQsKw+GAe6SExNRMg7snLWD+fAnKjGPIM3Gk05taW9vMG6
         Nd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726505909; x=1727110709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkXSCl90OLgwAeRvpNGzT2qKg9IVxF5VpqwKkA/VtMo=;
        b=tJH5I+ouxoMZ4rnqd4GDk5n3ZPiWhIsZLJNj1lbyw8TaSzKLbSgeVHVD0VRJXS1nDj
         ysuEvTHzwIdhBR/yaaeAKdymC3HNZ4uNnUvJqp4vwJXxKtNforlrlTdtXzoVtavDZP/n
         CiTOOvog+Hp5AjL+zjsZm0rPPF1osGN8EoXhLB7NGvuDjSVQONDUBLQYcpt07KS0e26C
         6598PV0OcysEu6oDCf1N44aad041MTw4ITbGJl58wdCpC/7kZVdzVCMhv9YrKitBwulw
         y8h/Th88R/oUE6/UGAu1KcnNdAPI+ByjcVi3CmUAckeD+flnxVYqdWcUgaLQah2bzEyI
         oczw==
X-Forwarded-Encrypted: i=1; AJvYcCUP2pZfNbl6Hf23sj7Z5dMoK7nME8OCkguqUkBxfCo4IV6ve6qCXhz1fwoTFHBWieWPYO4xLVDOuFq0MHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0+p/Rco+rUUM5XiCFUlLWsQBKbGrPCNfmbpYhO74OqOWO/Ml9
	24pSDfvi6QZE7GKl7qkF+gE8OG/PJLasKYpwdWi0GsxEaU17ZbEHvvUkj7Cd3+E=
X-Google-Smtp-Source: AGHT+IG8dh+X7wZY1cb84r7WJlZM+YVfRmpBzj+gbX68DS4yZ1mEVHyrVMiyu3tma0D7kvq39y4DbQ==
X-Received: by 2002:a17:906:d555:b0:a8d:5e1a:8d80 with SMTP id a640c23a62f3a-a902961ab79mr1721767666b.40.1726505909325;
        Mon, 16 Sep 2024 09:58:29 -0700 (PDT)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90979ceb67sm32992966b.219.2024.09.16.09.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:58:29 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 16 Sep 2024 17:58:28 +0100
Subject: [PATCH 3/3] MAINTAINERS: add myself for Google Tensor SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240916-max20339-dts-v1-3-2f7ed7c24e83@linaro.org>
References: <20240916-max20339-dts-v1-0-2f7ed7c24e83@linaro.org>
In-Reply-To: <20240916-max20339-dts-v1-0-2f7ed7c24e83@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Add myself as maintainer for the Google Tensor SoC alongside Peter.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cdd7cacec86..b6edb21b4f2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9669,6 +9669,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 F:	drivers/firmware/google/
 
 GOOGLE TENSOR SoC SUPPORT
+M:	André Draszik <andre.draszik@linaro.org>
 M:	Peter Griffin <peter.griffin@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org

-- 
2.46.0.662.g92d0881bb0-goog


