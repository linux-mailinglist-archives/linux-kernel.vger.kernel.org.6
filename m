Return-Path: <linux-kernel+bounces-433075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC669E53A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421B2169C64
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F71F5417;
	Thu,  5 Dec 2024 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AHU5l+3z"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA23206F0C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397598; cv=none; b=hd9WZFoo3SvEi7nLSGGhLOiBFagwXxpCmaa5idD/35bj4+5FAYyR+VDmNvRW8w4ktBMsdxU0REPMgO/GOmBvbaV6/rQt9AvL8GECuSrvSVEGSK9ou3vmTpXNnGUPSeAo4al73ogSbHvz5SP1VpFc5Ct0iK2Y/vmyNY2nHOuHG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397598; c=relaxed/simple;
	bh=EfuJYR878rJ4Cw+YuO97nDjgeWj+F6WJVMj2hzhOd0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAbSrd+BgfDbNUyD0cny5yZ3JQwsmkU4pdhYVcELspQQgAWVeTffIbQ61wkwel9LKo07UQsbBfF4wNjBrcnkYAv9d9saVxHy6/TLvQZgCDZGKbuVq3ww+fn1xiP+Euz08SX04IQRkVlUkCJhzYRSvjOaNuX3Y9RUaTRaDu3ol8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=AHU5l+3z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa549d9dffdso109897966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397594; x=1734002394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTseU8DWKtdHNNseUc2PJ1vcygpii+LlAX++fbmk+pc=;
        b=AHU5l+3zdG0qQuHHIARC30dJ6LzIs5IcqRVipyXDNR5KI/h+TRHMmWsk5OL9TxiHea
         bdZiXwgBVkx6zbPQlTHaDbNuhRY0qs4/EZx0d5taPU9v71EnfURuuOpFU2az7B7FSTop
         a3nsIbqT8Q7VakS0rbBQPhePs7fEDg6C4sHJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397594; x=1734002394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTseU8DWKtdHNNseUc2PJ1vcygpii+LlAX++fbmk+pc=;
        b=JW+EBMH5I+OejIal+GgqGCujlrMP86C+IpGqlxmwosnTQOZogweJu1dxvZEHoJr3zn
         7vSITWefq3+amcnp4/ksv/A3AUF9fMcyTyxbxoa7pKyste51SJLW1RPG+46IEzPjB4hq
         RZratJ7jX2KbIaxjbhMtOZk82jIVKU0y8xeb+s2QY7ROd0zpuLfjuf2Zg2mZC3CRTtLO
         2BojCm4x7MAGP3knmvKpZVrzq/RDaKav+efSRkEXlp39f1C7RNf8+6pY3WwnqKJ32b3v
         +sVglfH1PFZEOjkw3w3thZTNEALHvjSu2W5Kj7xfhcOxaGyRnXS9IL38N2uUKXaHH2va
         CZLg==
X-Gm-Message-State: AOJu0YxkX4+aWUmutpre8TCvgs3zsGrzTiDFIY3NLKIG7qO4eMrSHO2r
	6acoXAsDl3hFQjLAr2+wskR7FUWtUQB48oWHaAKemo/IeZZNhXSum7ydw0moqgrI2CgumR+vTVp
	9
X-Gm-Gg: ASbGncuu0drU+YIb29Txbh5vRQgd0FCd68bo65/LGr6GlDjQwLrvRAlVLff9kCZfHZF
	0034S6O9ffRD1yX89WyT2dtlR3uNp91SDpC3XjtCCulG/wfMaho95nnVrkkAtRdK/9QibZ1zGec
	gbcZsFKghbbKrjqsAv/kbZZRSGDguiX0nC8DSfRIXq9vzOQRnyBG5bgZKzbufAGjj4QGmD9hKkH
	ZVwLNfLlj4oz0DuGQ55iFNxsEXxROxoqda32yEwahsIHYu+P9FYszknz2q6pgKoQ5bLSMN7nC1H
	g9AURqsitPnK0UDKnWYn/9qxIyOei+GZNxlJgTynDYPP+g==
X-Google-Smtp-Source: AGHT+IHjGH80PYnwy6f3N1dyTyMHBVS5+YcXkhAFmpCzIZW/6EjpsfvTuvDL5MsErchIS1MKSD73VQ==
X-Received: by 2002:a17:906:3097:b0:aa6:1c4b:9c5b with SMTP id a640c23a62f3a-aa61c4ba102mr240616066b.7.1733397594442;
        Thu, 05 Dec 2024 03:19:54 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:19:54 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 08/20] arm64: dts: imx8mp: add anatop clocks
Date: Thu,  5 Dec 2024 12:17:43 +0100
Message-ID: <20241205111939.1796244-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clocks to anatop node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- New

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e0d3b8cba221..0b928e173f29 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -709,6 +709,8 @@ anatop: clock-controller@30360000 {
 				compatible = "fsl,imx8mp-anatop", "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
 				#clock-cells = <1>;
+				clocks = <&osc_32k>, <&osc_24m>;
+				clock-names = "osc_32k", "osc_24m";
 			};
 
 			snvs: snvs@30370000 {
-- 
2.43.0


