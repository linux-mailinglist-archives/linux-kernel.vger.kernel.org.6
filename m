Return-Path: <linux-kernel+bounces-273427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4494691E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43571F22D05
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1F14EC56;
	Sat,  3 Aug 2024 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+cQvfFA"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B6413957C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722681711; cv=none; b=FBsQkt2tdSCy3p4+OYSNV4YwMAd9S5aPmtD4e/maty7K6whnFND1qHqi52Azn00hNViiNhBUmBcB+hicWhjOnXwMMDmEc3RS5fHtLWTFwJI7MCyHjIVLTO2D9EVnbqFka8ECkuGSs4T5fuCBmvaaFy2+tDjtXRfJhBxvpm2Xe/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722681711; c=relaxed/simple;
	bh=8swDYCKlHMm/RjEDI1jjvRnoWAi33eYa7CllXV/57qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ebthaX2ixQMRNAX4YJe6U3bSj4mvlUhbF24C39hifE4uMGW5cynz/fRNt7CV/ARCR3n/rY7jCGSokOUOSApH6LxU+0Bay5+aAfFlf0iVd/KUoP2WoLzYmrq8Gm+nrK6ZsRFl/yicR4JaUkTeIcBb/u0I4iyixKHhsb5j1WOrkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+cQvfFA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a975fb47eso1222323066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722681707; x=1723286507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2P5CUm71nRXIdibIz1zY1EQPaX8kSIUbjLIcJ8FN4Y=;
        b=j+cQvfFAKoUJVj/EbdjFfbDZ23FnLF/JmUTZqBzc22AEzxWPZkGMLcR6XzDFUEg07d
         O9zIzs2j5kUKFy4ZvCjwtu2FehhaDO6I7S7kQzum7SnZLyFJ54MnwaqByrHK6JlcX2ut
         OMcbjcFjepguGzuQY9dsZ1WCZCQe11ARaLiqGMa4u9RM8CIUXQz4yL0abDTqqzMIqCpz
         VHTy/TZB0p64pz4w4oJFAS4YWHVLVjPMoHIYJm8D7LejjUNW5W5dLWiA4xD9yWN5yMJP
         SRyEMFv5jv+FgfFXr43TBzRij5EpBLQsRM/iEN9/w1ClINQnnw/+opu5oOn/Ju08u3OS
         3sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722681707; x=1723286507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2P5CUm71nRXIdibIz1zY1EQPaX8kSIUbjLIcJ8FN4Y=;
        b=otXXKU7DwdQv7AHYiw6fbacokwK1Z7CdAOMhrp5r3g6H8U1agEcUsE8z8OtkTxJyL5
         Y4S1yj9TZh3pXlx1HxjFMiVBnl3IHKkDUXPDoN+3qVejNpaKCCvifKnNS5xQh1qZbVHF
         7xJRAcToEai/mvsjabFWc9RB6QZLE+96+PlaEgClQuuXfKsrjRgIBUOs35h3K+YfVjCw
         K3Sq9assbPoNqFBpSsT+wKKEIGGDqrSf0u16+4MbljTHy1CyT17bl82I07/S0ZywQUIW
         jCoBQkevCN638aGe2TmEOJDPAFZ6AnvU41jjyqke3L4r7nGSbeCH6h9an/lfUwGidNBo
         XiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY73XZRsDSRNYFyGbiK/yBD71lLSzTeURGPeARDAR5dhV5xVbfywXHQjJEFqSbVKOzvniG/3j1sjM8czGE0ExtoG43W/6nSfHKl/5G
X-Gm-Message-State: AOJu0Yxz0sObyv4fR5jzHI3TGFWlHBcNChy+/UfucRPZPb3oMFIkF8wj
	3IIReR240YyFlTHR8NLJXln+h/t2Ae0FmYvwswrEmucm4LLxKVCAK5wHfhaeTK8=
X-Google-Smtp-Source: AGHT+IGx8JIglmqEtvVOloITy2p1V5U6PesAEG1DHceXHVPF+dkLXz1ocl5KFlVXTMxUWNwK3835aA==
X-Received: by 2002:a17:907:6093:b0:a7a:a7b8:ada7 with SMTP id a640c23a62f3a-a7dc4df97f8mr402428566b.24.1722681706827;
        Sat, 03 Aug 2024 03:41:46 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e7feecsm202086366b.176.2024.08.03.03.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 03:41:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 03 Aug 2024 13:41:41 +0300
Subject: [PATCH 2/2] ASoC: codecs: lpass-va-macro: warn on unknown version
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240803-codec-version-v1-2-bc29baa5e417@linaro.org>
References: <20240803-codec-version-v1-0-bc29baa5e417@linaro.org>
In-Reply-To: <20240803-codec-version-v1-0-bc29baa5e417@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=8swDYCKlHMm/RjEDI1jjvRnoWAi33eYa7CllXV/57qw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmrglnQf2eSPxhCPoW50YyCE1b+UmchLkcoNa1+
 dvwTlj910+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZq4JZwAKCRCLPIo+Aiko
 1VfsCACUeTsaUC8cUzv19Lh7pPQnhShgpW6Nj2314n5dvpeCHe4zpggfLbi8sxpB6rdB/mz6e9H
 ILm68xJuIZXE+HtM5m0JwHucNwU7sNeTWqPL/vhcgNKyH4jZeoyAHwMYutMqkeXoIuspg36KcU4
 nMqEIszCdROdPeJ7pzaXs7pP05lW67SDv9bJi6u4YTCPIJuhlMVcpEl7nEWKHJ8xbRsDghHhf0T
 sQM/WWIddmjWKwEG298mvWjM6wsDDjfMLlSMkmH65C+EZctbnxD+EijiFMdjHhpRN6wJ0qUDUMr
 OhV4HE4+/VdZBtnQLKlXKDH9paR4HGoCR8FGMNvgSJPsfQxN
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Warn the users if the driver doesn't know the codec version. This helps
in debugging the issues with other codec not detecting the correct
version.

va_macro 3370000.codec: Unknown VA Codec version, ID: 00 / 0f / 00

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index b852cc7ffad9..cdc090418d74 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1483,6 +1483,10 @@ static void va_macro_set_lpass_codec_version(struct va_macro *va)
 	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x80 || core_id_2 == 0x81))
 		version = LPASS_CODEC_VERSION_2_8;
 
+	if (version == LPASS_CODEC_VERSION_UNKNOWN)
+		dev_warn(va->dev, "Unknown Codec version, ID: %02x / %02x / %02x\n",
+			 core_id_0, core_id_1, core_id_2);
+
 	lpass_macro_set_codec_version(version);
 
 	dev_dbg(va->dev, "LPASS Codec Version %s\n", lpass_macro_get_codec_version_string(version));

-- 
2.39.2


