Return-Path: <linux-kernel+bounces-516441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3AA3718C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 02:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF157A3F84
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 01:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C633379DC;
	Sun, 16 Feb 2025 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvBSl+b9"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D94C70;
	Sun, 16 Feb 2025 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739668103; cv=none; b=fZIBtAHsC+yMPrFekV/jJXa8Uj4d4EqLo9x4myajOqo9f10G4cwTCVPcR+lAxEh4EKHAOByrEv++Z4BcdnypQFqr1Citydzk9FZnGhkoGhnO/4BDDYf5n0Q8TH4B4tiIIV4ZNMjCTmeO4km7ThJJdTASwj8pChsfaSFQJ1LT7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739668103; c=relaxed/simple;
	bh=VYVUtvPTqYR1OgPro7djmzeJPEH2PetO89zR5ZuN8hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvbZyYw20IGWOusdhr9rhUnsg2/hG2p62/HTBvWWfzfT41k4nY4zFWj4Nq7L7EdU+CONgj1wL45Hb+worl/+iAFoH8bVIF6xn+5HjymHSe3E6LD4Nz+rHbStHagrYAACTexfg5+mOgC5Bdtrbl7cHM8XV4u2aThV0htGY08+YaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvBSl+b9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c3e25658so7689425ad.1;
        Sat, 15 Feb 2025 17:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739668101; x=1740272901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaG1ejkjjP44pGEgXrg6pmu19/GDuXtS2tYJ56ktCw0=;
        b=QvBSl+b9svYGpMXeN9/byiDmZ4BuHA2E/dZxNqf140VXoCf3ThRxkqaiGbm3yW4gnZ
         AtTCbbA4hzHwy/LA0IsbmwwB3JeIqEiwQO3j5qAOtUbnBsTdcKglfYMPGOIvTf9y/z9Z
         QdR4VbwlW5TBZolHQIY3ie35Qjojd/KEpNTJUvly0vqXaja1GxwoPRaVAT0HngozwuEX
         /2AHYic68lTBPDEYN7PxdqA2pSVZBA9oG2dmHnh3kuREBRIKdCXwhYie27Hd606avkHm
         LsL95cluP7wDWLC2NPUceQJaRZTTWhmm/4DNg0fFTnpM9I3aPtxuJ9GvDzuuZ3kNdE6n
         SJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739668101; x=1740272901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaG1ejkjjP44pGEgXrg6pmu19/GDuXtS2tYJ56ktCw0=;
        b=lvr21QIAomB56vfHXNeVXY9KvyJcYMCSuGzNpJ7trWPxe4Hupr/vD3J+Ja1QkUe8OY
         IPaT7yCqz8MvDcb5RZ2au6aFbNY2oqcuatI+A0rdOyJAsmZmwOlfcHf4LoINwkfhcCet
         To2wftBgFckfO7iDBdeYlPUo3nPHEQYvYcb16olUCQUf164/I40F40Hy/UI3WFVhC+xC
         +Ol24+RLqqkmZF5t3Ijzyi4hMSvJv1F046r9C/nJud363cZuib1tcK66Om7b4tgClMjb
         ep/LmqdTfDmQ7O1460EWDP7y2hhWQzVxjTa2Ig7YvD8CLk5gPvHEoGiKH+OeooQ8JFSM
         VbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkhUfVjvDSKPOaoPz8xuFBO+umIciQkxcd4tcEj9ZI7/KNnfK+cjhPFFvY9SY/AvXIH/UjfX98W92M@vger.kernel.org, AJvYcCVx5st/aAZzr7bO6tRBgk1jNtd+5gLQ55Z4gMWmGUwhTMU918piToGGS48lwFZQbt4sQd2VSiLN5bo9wVZ9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qBLeQBuBJ8sPDAh5arYgPGuNFnquMqz1qktY9+3SGUO93Yli
	xO7rttKKe1LlTz/3AgmJTY6f4VxXrPNpPQQ2kqn9fNLf+LZZ7HG8
X-Gm-Gg: ASbGncvcU7D9N57iXDBhYxHvgZsEcdoAeSNKCGllq1GXVFGAifVfe1t7AMTJa+5Q11p
	gTSeV+qrI2fyQHONtSwAxusRJCQ1B4Vi9naLUfA7aDLBaXsXon1WGAkD0BZ86iF1ZfHYrV1e4Ur
	4GXBnF5I/ph7di44rqmgyWKAMEUZg266EjiBqgobtcNAyRtH4UZBZZgA2ZlMxq1EYK6HYC4P1MD
	PqmFpaZ3kILVUK9KbQo1Sg5L+SaEveyHDI7LUYNdE43NyPaU1Bb482oGQ8D9PyW5BvtSE5vooTj
	CEiXqtVcw6ekjTbIyC03
X-Google-Smtp-Source: AGHT+IH/+mxdcBT6whVFWrHxgZ6a5u1nwOwVnd7fAtlQA3wZRira0RXbOVdfvGoGi405l24/1SuaIw==
X-Received: by 2002:a17:903:2f88:b0:21b:b115:1dd9 with SMTP id d9443c01a7336-22103f0b0b3mr28232985ad.5.1739668101056;
        Sat, 15 Feb 2025 17:08:21 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536455esm49672045ad.74.2025.02.15.17.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 17:08:20 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: sebastian.reichel@collabora.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	piotr.oniszczuk@gmail.com,
	robh@kernel.org,
	sfr@canb.auug.org.au
Subject: Re: [PATCH] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
Date: Sun, 16 Feb 2025 09:08:14 +0800
Message-ID: <20250216010814.375313-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ltuyyul4vqyavsqvaue25tdbtjzpwkmq2smtsedidgyomu7d4w@rxsxbdgzheba>
References: <ltuyyul4vqyavsqvaue25tdbtjzpwkmq2smtsedidgyomu7d4w@rxsxbdgzheba>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sat, 15 Feb 2025 23:22:27 +0100, Sebastian Reichel wrote:
>&hdptxphy_hdmi0? That looks like a downstream thing and also for the
>wrong port?

You are right. I was refering to the patch of rock5b from mailing list[1],
in which there is "&hdptxphy_hdmi0" so I assumed this port is merged
upstream.

Although ROCK 5 ITX only uses hdmi1, vop need &hdptxphy0 for pll clk, so
this node is necessary if we don't change the vop clocks at board level
devicetree.

I just notice that there is a new patch series[2] to let phy of hdmi1
provide clk. I have to add both hdptxphy0 and hdptxphy1 based on this
series, or I can only add hdptxphy1 and change the vop clk like:

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

[1] https://lore.kernel.org/all/20241211-rk3588-hdmi1-v2-4-02cdca22ff68@collabora.com/
[2] https://lore.kernel.org/all/20250215-vop2-hdmi1-disp-modes-v1-0-81962a7151d6@collabora.com/

Best regards,
Jianfeng

