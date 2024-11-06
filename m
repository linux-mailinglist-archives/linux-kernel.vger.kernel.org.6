Return-Path: <linux-kernel+bounces-398783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051739BF608
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D241F21FB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08D720897E;
	Wed,  6 Nov 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDWRRiOb"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FB208986;
	Wed,  6 Nov 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919943; cv=none; b=kw11VT8ApwJ1Cr1tHizIav2DYZENKTreNVCXJ1kDihrCw1SRVRDvdhby75y8qscvc5iAU5W5XjC8/lO/KH4YeGaUwXxZntLCevqF9Au/UDnKMxm9nbC7gl9nXL6RpreA9CE6mgcum+152/D67985UWAzfpZ/x3PAA4BOUyTi82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919943; c=relaxed/simple;
	bh=9r0V1J2EQyXidV4afCkuzjCNPAUbGbv7Eyis2kUadqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9jwvl6gjQUfmYF6HCJ8uix3xCJlccVn/g2/aj+7STlay2H7QPpnprlk53aWtA6KIIo4ZlrRl1NQ63h88nMlMcZ2mb+Xh/ff/JEToMR9GMFpEphEN/euE//cyeVDOUqpxoqB7NDBlNyNVdZKEcBco40884XF18mYU5SYsE7JmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDWRRiOb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a628b68a7so11401566b.2;
        Wed, 06 Nov 2024 11:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730919940; x=1731524740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhKxn9mh9La978hmxe7Fc0A2OJRby56llbTMDvsHyfQ=;
        b=gDWRRiObU4Jom7J7WBaP2Dozpa+kQuoKhPzNZZFLCPoih2IgcRQ1nF1fzW5bO+8PZJ
         JSXx9XtNe5DPxVn9HhralHlM0dD3KHyvVl+qlpe4iOW0TXMvcbGzMB++K7yns3A3oCHJ
         YdZv5rQh0zobuBDZnZTlIT63CzET4kWh1uDKWOd0ZB58mVVVIPqNuLwyge8cCqM+tnbj
         MysHUzCZkzGKpSm8R4e6oU8o6Al07Z1jtLou5gmgfBXYqQ71XaZSpNfTUg7VprPH3gv1
         2ELg3kteUI/fP9uRTJPGXGpKX6VhfqyhbmeXFJ/PPtOdGgKOpVESrDmiR80XuVfua5Un
         PVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919940; x=1731524740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhKxn9mh9La978hmxe7Fc0A2OJRby56llbTMDvsHyfQ=;
        b=MlienL5JiaNEpN83cJQ4th6Gojfe8Wz6S1on8ENU0vNqWHCqMRTDxB+XFY+2W1fuLr
         S//Mf1x5HOXzIBiSSU/r9HkOP6zGhMlIVpfQJ4ZTNLO96gpj6iUYkuyDKmWSKJgRzyp1
         OX1Ok4WgyMz+N3o8Mq1VYf2ip5UV6JkSjAJIXGKz1gtt3KIn/S2hR6v//SwkdoDdCcfY
         0kMDyzLjfDQpuvPhl+yfP9B1mtlJji9HHag2WlI7RyYBGa5T0WxuR9vvD7G2+cutUM3C
         GFra3ULXS4Iu74siV7Qqsa2EZOE+Yu/69Y7zuZ/9/OLif+j3tV54pOX/Mc/PxvYICIZY
         FGjw==
X-Forwarded-Encrypted: i=1; AJvYcCWbJ7zcirLjf+PLkfnE+JZuy2tgVMBrZzDTPuUq2Rtls+iIHG0xJosvTtLp/mxmPYSx/l40ye1C0xv/EWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5ff1/izHuUizrVb0d/985VT/5h0qFRST5Qcyfy9OTecMcy/E
	bhx1syf1gMxHLc2JLt1D6AiiaZ3iNgMTsHjn2j4Qy4MSxtZT0C4ZeOoPuA==
X-Google-Smtp-Source: AGHT+IGI4oKgg7PABJwD5X3tevlDjTR+OfQLY6lSEUSJtjKLD8YmiD6b4oSzu+h3XfqjcTwDMlXWrQ==
X-Received: by 2002:a17:907:9602:b0:a9a:420c:d1a6 with SMTP id a640c23a62f3a-a9e655b998amr1755144366b.48.1730919939703;
        Wed, 06 Nov 2024 11:05:39 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d67bfsm316574366b.56.2024.11.06.11.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 11:05:39 -0800 (PST)
Date: Wed, 6 Nov 2024 20:05:37 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] arm64: dts: sprd: sp9860g-1h10: fix
 factory-internal-resistance-micro-ohms property
Message-ID: <30d7ad167400764b6fe37f63276c07d3e30d931d.1730918663.git.stano.jakubek@gmail.com>
References: <cover.1730918663.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730918663.git.stano.jakubek@gmail.com>

As per DT bindings, this property was missing the "factory-" prefix.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
- new patch

I thought about squashing this with the 1st patch, but I wanted to keep
Baolin's R-b, so I kept it separate.

 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index cd8b1069e387..94af7700f3e2 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -72,7 +72,7 @@ bat: battery {
 		charge-full-design-microamp-hours = <1900000>;
 		charge-term-current-microamp = <120000>;
 		constant-charge-voltage-max-microvolt = <4350000>;
-		internal-resistance-micro-ohms = <250000>;
+		factory-internal-resistance-micro-ohms = <250000>;
 		ocv-capacity-celsius = <20>;
 		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
 			<4022000 85>, <3983000 80>, <3949000 75>,
-- 
2.43.0


