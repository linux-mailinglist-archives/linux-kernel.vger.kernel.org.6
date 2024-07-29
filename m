Return-Path: <linux-kernel+bounces-266412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B7893FF89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0701C22729
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1818C327;
	Mon, 29 Jul 2024 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRVOJSzg"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89518A952;
	Mon, 29 Jul 2024 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285062; cv=none; b=X4aRKrv9FnWbK4kngMIcBUSGjyuVLhhg0/UGxkVQJ710j7xjCZQtkKJi8++TbM1gXRo/z0VfrQ9O2xBc9Xw9ZOhIhOLN1hizLrqQnW1Rpp6JLDZui83XR3SquTYds+CZ79zjabUFc/t3YyC3zA3FSAvmvTAkh47Kx+G7wzhZxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285062; c=relaxed/simple;
	bh=BSoRj75es4wloghJ2NUvSnLE/FHCzV5x64+tkcmLEug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDLnnVkD4MPNpYCfLbrc2CvVTI4S92qkI0q2gMBpTSibwowzXOjc1tElpl31nV7PC1DhTE8TQCpcRhr0ZcDXFQOKdFPEX85HamIq2Psyk1Rf53Lm8dO++2tdML30LX8LvRU1m4PNUABk4tqRgTwzkjdfeYrG6rwBNyrxPIbk//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRVOJSzg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso2899186b3a.0;
        Mon, 29 Jul 2024 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722285059; x=1722889859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAcrmpJG3WgIqb/hoYI/E7IiNyFNvmrDkaWV4Iwhnl0=;
        b=eRVOJSzg5Tiyo/3A3jlO1/Bxzx8pA1AhSo/JwwhKHm4Ul2Lpg/Qyu/26v+ZnLJ2B0t
         69x404QbP7Fy5/og4H4mv0M20ACbU1izwI5Y2+xxf5rTu0agRn+fm2jG5fKZcdeJKHaw
         SbzEIV2Gr9+zfOpI1F5XoMUKaFO02ik8YKuwzODLZ+MOQjVWeV12/X+yUJzGY08xrRwX
         tm0mDCg7Y1/VuYYvPpPQ1VnrBWTlGU3Zj61Q8mQ6Mts/gVj12oyOFWBgm43LvU4tPVwd
         vFCnvTgai0j9S0AHZ2udp5J85B1eYqGB5SnH4wD+YKaCWWPV4oplITquAZG2aQsO8Ixc
         5Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722285059; x=1722889859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAcrmpJG3WgIqb/hoYI/E7IiNyFNvmrDkaWV4Iwhnl0=;
        b=UjVR6wTf3+X/FxPAu5Q953u5MCQxpvHSjTRxMSIZbTpY5rSePPjpsLOvaDmmy1eBHU
         9D/pCmBdxd3RozIliZDqdYi+Ru7Fr9sPj84T+M/qL9h8pS5yVpcQO9DCwAmx0u2+dIBp
         Oqubput7Az8SaJHtUTe7E/m5PC7DfmLk3yoK089NIElYDpEdZ4pclfcrXxFi2nLWebrh
         IK8nUaBT9Zy9JWmoAzkhDKc1eym01mPZHajyD6FlZpoQYthFfQKmKKVJxpMJBEcAyLAd
         /mb8nSUeZ01P2rqwhRDuMKt7UCBSnN/cJx6CCTdsy3BkqmVeLvDrDxUcx05WYc0/PbQ6
         456g==
X-Forwarded-Encrypted: i=1; AJvYcCUi1YuJ7Md0xMRS9V2P8fEfBFGpPEQd6PwoBWcBfXwKCDdr9/OHgRC7mKFIrnIozhW0M8dOQdakoTls2q1yfIxF3E3w+1kU5gB4dHkqt+8NV69w89HXGXQbGt8nXOUChNEB4ciso0X90w==
X-Gm-Message-State: AOJu0YyH2mh6Iv37iGzf7czuZXrCxeBQejY+BERl8Zct2vyfNAXWoYgp
	9aQPtomlD5OR7ps2lU3/czh3z3qy1TktmBtqPKxX7J50SWJO4WQj
X-Google-Smtp-Source: AGHT+IHu1WjRq+e4goX2kbeKYztE5DX0B/faU+/NMUOkawkO5r0UFEKbZQMS651ttHa8yhUJIzwKdA==
X-Received: by 2002:a05:6a21:3406:b0:1c2:88ad:b26d with SMTP id adf61e73a8af0-1c4a1511353mr6406879637.48.1722285059190;
        Mon, 29 Jul 2024 13:30:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead87a991sm7483346b3a.176.2024.07.29.13.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:30:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 29 Jul 2024 13:30:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm/arm64: dts: arm: Use generic clock and regulator
 nodenames
Message-ID: <b53e17ec-fec4-4cf6-9c61-41552188c670@roeck-us.net>
References: <20240528191536.1444649-1-robh@kernel.org>
 <20240528191536.1444649-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528191536.1444649-2-robh@kernel.org>

On Tue, May 28, 2024 at 02:15:32PM -0500, Rob Herring (Arm) wrote:
> With the recent defining of preferred naming for fixed clock and
> regulator nodes, convert the Arm Ltd. boards to use the preferred
> names. In the cases which had a unit-address, warnings about missing
> "reg" property are fixed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

With this patch in the tree, all versatileab/pb qemu emulations
fail silently (no console output). Reverting this patch fixes
the problem. Bisect log is attached for reference.

Guenter

---
# bad: [8400291e289ee6b2bf9779ff1c83a291501f017b] Linux 6.11-rc1
# good: [0c3836482481200ead7b416ca80c68a29cfdaabd] Linux 6.10
git bisect start 'v6.11-rc1' 'v6.10'
# bad: [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
git bisect bad 280e36f0d5b997173d014c07484c03a7f7750668
# bad: [0434dbe32053d07d658165be681505120c6b1abc] Merge tag 'linux_kselftest-next-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect bad 0434dbe32053d07d658165be681505120c6b1abc
# good: [cc0f7c3f97bc6e888bf4be28a9da9dbd3735d2b4] Merge tag 'soc-drivers-6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good cc0f7c3f97bc6e888bf4be28a9da9dbd3735d2b4
# bad: [462eeb978db8071722a3a546039943d42a297114] Merge tag 'mvebu-dt64-6.11-1' of https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into soc/dt
git bisect bad 462eeb978db8071722a3a546039943d42a297114
# bad: [f01448addcb9ede2d5d2762229cd26fc2540813a] Merge tag 'imx-dt-6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc/dt
git bisect bad f01448addcb9ede2d5d2762229cd26fc2540813a
# good: [aff39a02b5b12fffa75922fedeaf133d1cb7213e] Merge tag 'v6.11-rockchip-dts64-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
git bisect good aff39a02b5b12fffa75922fedeaf133d1cb7213e
# bad: [35b94a99fc67e1886e3be68179cc7477370f0b2a] Merge tag 'amlogic-arm64-dt-for-v6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into soc/dt
git bisect bad 35b94a99fc67e1886e3be68179cc7477370f0b2a
# good: [1443b6ea806dfcdcee6c894784332c9c947ac319] arm64: dts: amlogic: setup hdmi system clock
git bisect good 1443b6ea806dfcdcee6c894784332c9c947ac319
# good: [c5003718cb5ab71b75139a237741f413a147876e] Merge tag 'v6.11-rockchip-dts32-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into soc/dt
git bisect good c5003718cb5ab71b75139a237741f413a147876e
# good: [659c0b4444b24c872ab19e5fa4b96d32043a0a6c] arm64: dts: renesas: Add interrupt-names to arch timer nodes
git bisect good 659c0b4444b24c872ab19e5fa4b96d32043a0a6c
# good: [ade990619444234d96ee5a79ca6305474c6c687b] ARM: dts: turris-omnia: Add GPIO key node for front button
git bisect good ade990619444234d96ee5a79ca6305474c6c687b
# good: [3a94fa4cb86e96103657ba3550ee68b424269613] arm64: dts: microchip: sparx5_pcb135: move non-MMIO nodes out of axi
git bisect good 3a94fa4cb86e96103657ba3550ee68b424269613
# bad: [04f08ef291d4b8d76f8d198bf2929ad43b96eecf] arm/arm64: dts: arm: Use generic clock and regulator nodenames
git bisect bad 04f08ef291d4b8d76f8d198bf2929ad43b96eecf
# good: [7f8165eee188536e3ca9f65564d4872dc1c2df06] Merge tag 'microchip-dt64-6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into soc/dt
git bisect good 7f8165eee188536e3ca9f65564d4872dc1c2df06
# first bad commit: [04f08ef291d4b8d76f8d198bf2929ad43b96eecf] arm/arm64: dts: arm: Use generic clock and regulator nodenames

