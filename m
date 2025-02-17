Return-Path: <linux-kernel+bounces-516930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159EAA379E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A69F16CEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF429148832;
	Mon, 17 Feb 2025 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9nmIwlm"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA63646BF;
	Mon, 17 Feb 2025 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739760288; cv=none; b=WKB33dYjUK3eseAArBBbuwwHchECXQnE3Fg0VsIQDVKa61Xi00p4TDT/uYjgQfpOtG4fo0/FbPmuQn+8pc6qRhGLKzkup7u+aYd39wJPrg9VI4tf8JphOCw2s3+4U38rvVvInhwAU00b//4LDNx3jVVlFg7OZzO05UhUVIIkJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739760288; c=relaxed/simple;
	bh=fOVz3dNJ7Mqyxy6xFYQY62gFXdpQafh/b98Sl0sKjd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjA4ke6frLD1UruVPIgf0Pe+C1PbrusniJYX8fPhlcEE+14PkyRCGgNuFLI1yYfJanFRyA+YR+IzwxNTBeFg36nbPclHQk9bpqn80CSHa3jkbvKGOCCyvzN0Lh1egAYF96+V9ZCtPQl5n89U+eZjrBw0xa7WejozzRHnweyiYN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9nmIwlm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220cb083491so7942345ad.3;
        Sun, 16 Feb 2025 18:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739760286; x=1740365086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AER0Zup4p13T8PV8KU9Nywbmtgf/uR0O/WZpg95sLMw=;
        b=P9nmIwlmpXoTKqxKZoNI2+8PMZEY3zF95bRZhYFMhvtUO17j6XdUyS3G3uKdKbOGKC
         pVRerGAwNgyjrRQ0HWzU8nccXi3VktGz608Cf/y3TT+bhsNuBd3/9VIdGi0RCDhWx5Ov
         82Mwn4ulJyrSkkAKfHnkUpYFkBeSz+7Hso6TBrtqSjTW3MB6CcY6q7awR2sYlxrV3DFo
         y4hmSAjDwaeCV69PCnOCxaXPJwCW0Ebjzyg5ZCB0zlJ1AXnwsONkoVjM0bISGG2GtNeY
         2ERDyRyF03f0OuuI66bY1ge2s+Yv+FrH+94tIMV5EfknwgD+j76iVXuft1llXljh/iZR
         qcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739760286; x=1740365086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AER0Zup4p13T8PV8KU9Nywbmtgf/uR0O/WZpg95sLMw=;
        b=TU431dTv47YDhgJPk+WT9su40cEoGHESqidiQj5t/g3782PiMQk+8Zw6hs1HLn3Xwc
         M8zyiReYdIfsANWDrPVD/Cs0/rbJvqrlTXlTNjsUL4ws6Qhi4g3C4J5X0OZfbkClt3Di
         Wa48H1u8H4eN7xLuvfCP1l1PwGWHRoLV+DU/zlukpPP6W+iu9Jqmjkv9zqx1GT9jESry
         N11R8fd36ZE5XLOvLiqr7MHX/FzvEdLuqHV/7Nrv8zk87AUsGS3cOdcxNnd7+z0IyFJ/
         yezNjIDbxA3uAUKI04/coxCqkz258J9kOpWAoCnN9R7cn6BnOO4ajETiyy0K9w6z0eLG
         OY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDX64XJw0k/TXQ/OYjcr9OLESQjp92RtqVrLIcVfSqETJlf6Trtriczm2YvpUqw1V/3dsZVXvYEz/vrGTX@vger.kernel.org, AJvYcCXQnJYihusOphrupJ0KQWNJpAWYysnjB9PN6cbQ/ogiV0bswe3klCL/svS4riL7eJ9IYT9xqis909iV@vger.kernel.org
X-Gm-Message-State: AOJu0YwSIB5zcTHltA2XRKmZ8AL0FYnxKxkmStbqOuQbGaSidPNwOVoZ
	mvCbDPROdifx4rM0EpZdStVR8I+RBgaVy5VXGmIr6eeg+gFamjPE
X-Gm-Gg: ASbGncuci7detBTUZBSo+GWBYzWp6ve0epdGFCyTe5jE+Js5HbTLWbpdyx4iexLXjSZ
	YivRZZzlBudAoukVqTGAIfGovPRmerYqlsRFRWSF0SAp31gDfcirA0FXPRnaH/2NPvuz9ZYgmYf
	c3+xC6W2Su00MLLLt5wpGiUGmtK2gmeyiCMkKA9KwobzGbEAg8qHcY84IawjTyMEACoMfdnOcCN
	VSD8VotiE1HBcsBNJ9mLgNVichlsKPstWBsHTJ+dX2+3FZ492WDRxSYIvD1hYSgfsK62ZDHysNH
	9ZIifGLPOgHnTasgWf1i
X-Google-Smtp-Source: AGHT+IFFkuRjjsUfRuK1JlJi9Y9I+z5IPJ8tmFVOzZ4eyJmlUKG0o/RiAA34cdX7ng6bdHkr98gAvw==
X-Received: by 2002:a05:6a00:2d8f:b0:730:9467:b4b8 with SMTP id d2e1a72fcca58-732618d705dmr4381994b3a.4.1739760286043;
        Sun, 16 Feb 2025 18:44:46 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324278011dsm7014915b3a.180.2025.02.16.18.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 18:44:45 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: cristian.ciocaltea@collabora.com
Cc: airlied@gmail.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	robh@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re:[PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source to VOP2 on RK3588
Date: Mon, 17 Feb 2025 10:44:37 +0800
Message-ID: <20250217024437.35155-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215-vop2-hdmi1-disp-modes-v1-3-81962a7151d6@collabora.com>
References: <20250215-vop2-hdmi1-disp-modes-v1-3-81962a7151d6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Cristian,

On Sat, 15 Feb 2025 02:55:39 +0200, Cristian Ciocaltea wrote:
>The HDMI1 PHY PLL clock source cannot be added directly to vop node in
>rk3588-base.dtsi, along with the HDMI0 related one, because HDMI1 is an
>optional feature and its PHY node belongs to a separate (extra) DT file.
>
>Therefore, add the HDMI1 PHY PLL clock source to VOP2 by overwriting its
>clocks & clock-names properties in the extra DT file.

There are boards that only use hdmi1 such as ROCK 5 ITX. So there are two
choices for this board:

1, Enable hdptxphy0 as dependency of vop although it is not really used.

2, Overwrite vop node at board dts to make it only use hdptxphy1 like:

&vop {
	clocks = <&cru ACLK_VOP>,
		 <&cru HCLK_VOP>,
		 <&cru DCLK_VOP0>,
		 <&cru DCLK_VOP1>,
		 <&cru DCLK_VOP2>,
		 <&cru DCLK_VOP3>,
		 <&cru PCLK_VOP_ROOT>,
		 <&hdptxphy1>;
	clock-names = "aclk",
		      "hclk",
		      "dclk_vp0",
		      "dclk_vp1",
		      "dclk_vp2",
		      "dclk_vp3",
		      "pclk_vop",
		      "pll_hdmiphy1";
};

What do you think of these two method?

Best regards,
Jianfeng

