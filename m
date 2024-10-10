Return-Path: <linux-kernel+bounces-359617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C35998E20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAD51F24E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FA21C9B64;
	Thu, 10 Oct 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4dgAcIU"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035281C2424;
	Thu, 10 Oct 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580330; cv=none; b=S8gDPqzaYntL9A4cTMPgQ4/hvnQGfzZSrlKG8wqf8cQwqP6oBN17JHTkVuhzpeIe49tqjFpyuVqCz4148wTnQcXBuVllLad0kqK/ZiUXVqO2rT72fKf6pHxLpUHizUxThhwRonp5ErA/+zfyl1pzmmL4FPNfVvIY4oR3TgmkSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580330; c=relaxed/simple;
	bh=CfmdVIigFTKsaKjDrRwpPj9TS/i40iXdRpwRsaOLI80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOIdbd7liN8xn1FW8F9zQrfAfmPDmhSf/8YvTJtkrZ6jaenZglykACPK5DYyNdhByAGuNlkdUfugYuohCf68hVQQDU35x6fVkEQerRVLB30cYRvbdDu9KEZBaXS46e45072QIN8aAT9SHxzlY05XD6WiKz5GDFAL7dGrdniRMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4dgAcIU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e9f8d67df9so854728a12.1;
        Thu, 10 Oct 2024 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728580328; x=1729185128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRcjJSkFKBATdPZGwqrgjzHhU3cecH79PFdxY+J/PZM=;
        b=O4dgAcIU40A4mbXCEs1NzGjPOU1mRkm4XYpvtw90NZ2dJcjhYpHngb+ToiHKckcifC
         YHrWKPqMEKzZAqeC2bpuR1XB+hVWiO1Kfjoe+5NwDk+ZfIUF2Mnx/msIg2yAelKy43ht
         Y0L13e2tzxLctx64aP7irmL4KBqnOx/quJDNxTbASE387QUbE3Ak6DW3rR+FgO/26s6C
         ZlicLu+f1o74Z/VD8gtYZO9w1N34U4PCaAk1W0b7NgfdEQMVHRMQeKvSJjLzJnnPlQiQ
         v58dyTQ3VrtgaJxZucUh1u5uBs6GhgkodPTfvJe8lw3XxoQquLCl+npDaru5P0wrnlhZ
         zKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728580328; x=1729185128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRcjJSkFKBATdPZGwqrgjzHhU3cecH79PFdxY+J/PZM=;
        b=T+ppNUoZnvaNMHotTmEqqPOTQ80yTh+/Nj37LnyBLKSzvmV9K3pyci+I61o6jYQys7
         TKCY8uLLLjA67pkkkmyJzrNMJbmKdcv1bF6vUgP4u3/odHza0lKbx8A0oHWw7EJuaukA
         GGX6b7KTXG1fwxtYAXUE/1s8b0T0biDP3C/gZV3Tp+cw20wTSb2Dgg3biFajSSdLJM07
         WLUdmEsknbSU8PociAeSWISK9rQm+TEb7SG/lGvF4ygz6HKcyWeqwuU5ZCm0msEYT53P
         n6PG1kodTpzfHD0AG5OBIwxuJSLcgP3bmCTlcdODJyJQJr76WmGkQu9p8dcPzrb/drso
         LVEA==
X-Forwarded-Encrypted: i=1; AJvYcCUuzjiGeiLHXtlqHGSf4Qjk9+gH6cIp7n3vMvobpEA1TwZSMl67LUWdaRyVIHxg9Pj2al3xwbeX1vGJ@vger.kernel.org, AJvYcCVt3KztlCDeZkmM+bCUEzfhjjVxc9DFJUdyGb5TGwfKU+tvltU0DcyGdCdu/ugA1ixGAm7qdZ2MAXkg+0oM@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ5H5MHikSQk+jG3X0IfHp+JGtjBj+sarvgjPsqOkNv+T9i2f0
	Bdn0rOH8I9z0haWvxUSfTKWV0h6aMveKclJHY1Wwd0AfCah53YLQ
X-Google-Smtp-Source: AGHT+IHjnmf2T4okdHTFLwxXmUly4FlC0XC+124pl5lRssFpr8SRSvJP1wR2VBn8R34KWSjREBTO9A==
X-Received: by 2002:a05:6a21:3117:b0:1d4:4a69:a0dc with SMTP id adf61e73a8af0-1d8ad83c775mr6714607637.33.1728580328297;
        Thu, 10 Oct 2024 10:12:08 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b5d3sm1251245b3a.198.2024.10.10.10.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:12:07 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v2 3/3] ARM: dts: imx7-colibri: Update audio card name
Date: Thu, 10 Oct 2024 14:11:28 -0300
Message-Id: <20241010171128.107819-4-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241010171128.107819-1-hiagofranco@gmail.com>
References: <20241010171128.107819-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Update the audio card name for Colibri iMX7 to match its specific SoM
name, making it compliant with the other names for Colibri iMX6 and
Apalis iMX6.

While this is a breaking change for userspace tooling, it seems
time to implement it since no ALSA UCM or related configuration files
currently exist and we are in the the process of creating them.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
index 62e41edcaf1d..8666dcd7fe97 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
@@ -120,7 +120,7 @@ sound {
 		simple-audio-card,bitclock-master = <&dailink_master>;
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&dailink_master>;
-		simple-audio-card,name = "imx7-sgtl5000";
+		simple-audio-card,name = "colibri-imx7";
 
 		simple-audio-card,cpu {
 			sound-dai = <&sai1>;
-- 
2.39.5


