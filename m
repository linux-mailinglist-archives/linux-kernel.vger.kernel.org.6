Return-Path: <linux-kernel+bounces-427057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEE39DFBB9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDEBB22913
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A51F9F49;
	Mon,  2 Dec 2024 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iERyl+iD"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB1A1F9EA7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127378; cv=none; b=Knf2fnodYf2PueJruG0uTeriobSsluhjJ+spfncwNU7vrT5FDYJquqNUw96sZl3p/uSt1F1CPrw3/TtOJJopmNSygb2eaYzWiR5k2kTyu3qOKPb3rmJ42rYRVi9akohlQky57Kl+79Qoh/9u1XXuoVwUUA3JCnCi61bhb8+6i9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127378; c=relaxed/simple;
	bh=wyRBTDJhchh2VRwMqvWdPrsDGYSLS50T4XeRr0/TSKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYij4M1wZI5P3nexwZTymjQPIPJ+Yo46bi6wE+sTfPLpesN+7+kifPYtrnv2Db8XWX+IB8ZlvImj9lVzBTtdu1bzviVqswlBIt8fy1hN6MKAO+0hw4hyqmdyKwoHk5P8/1ZYO8WyP75rQfEoThnOGcHHXI3ruJAVnD4lntyGCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iERyl+iD; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so1988475a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 00:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733127375; x=1733732175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFwz407Fv/XwMseJNTNI7dRyydn8B5G2ldLHp0TZ1PA=;
        b=iERyl+iDp5FrZNcCyxogxqh/5MFzkP8MTuGNjQgWatdpo3G78veboJ7oQxzUa8vxDz
         +Qh/gBQFrWHBz10293+gIwzNkFTeHoOSNwUn2dcZxyZhM6gopAJHhwqrqJ3VmF+yztTf
         MYpRppABgbp0IbSrYVBqD+5uyTvX+0c6C2HuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127375; x=1733732175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFwz407Fv/XwMseJNTNI7dRyydn8B5G2ldLHp0TZ1PA=;
        b=jxEPMNXVQ7Les/Tttj7Gy2ndHkzPcgQAJp6iasnjhqwqsVby470BDEWpiLpuq81hgI
         hAuU8LYqdN6UuanQjk/Kmw8RgIQLz+nqXfxQUrnTorHGGSvlnQScinbLUwSCdvLQQJRT
         W6w+pS3KUcKTeSKr2M/TaG3Tw4J2AB0dkSdMROQN29eOToMoU+SM3EExnyhwDB1ZLzJe
         u9+1HDYPLcJlO7groGVVKiMCz6ANWnzKhnFq6TGGZuWdUc/QdJuPHfXLDm+Nb2znpFh7
         IqpECh+7EkJelGVy04mIRrh9uglDzjA0JKehdi0PBbD5rcqMzW53Va19uLYwn49KLcJ3
         vWOA==
X-Forwarded-Encrypted: i=1; AJvYcCWWNObMrVIIuAfykk+CJgRxKgcDac3Vi/ZElyOC1a58ZzkIx3JKE1OUn82jwoL0kpbvqs7nkCR0aq03dAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQyb5ZAidAT79AaRueR+BMRsqi0PECrvFMJNGWqJ23e7GkW82E
	jLiwPltlruMAPsouKIWOVoMDthCEuzoWt9u4u2EYBQscXyMxwzrdTydsq3HELg==
X-Gm-Gg: ASbGncsED8dvmzQYL4W5qrz7/KkANbkQ7C2aVZZYw/1UoKu9pvmlCPO3w/HNiV7mb1h
	B/Xk+ga6OJBHxxNxWAD3olQNgyENbKaVIDIfuH0NmFD/SpGS57/DWp7K4ApeTs/bE0PXuRA+2bd
	F3RkXlkfAiFXgGctHSTt1a3j/RIxmrE03ljPEmRNm7IM/Ybf4vKQaCgq7kOt3GF32HyaRPlt+8/
	2wwqYLoL4Vcbw/Pa6YipW0qbPVzdblZZR+Or3E/iBT2EFTaQQ7+w3VwlA4gW4JoBLYt
X-Google-Smtp-Source: AGHT+IGVKJH1h0FeZuaxYpdL1EkQ7vtbsLObgOmtsoxPqtC7AsSUKW71maa+1Cg0tbmdqz/W2Hd3KQ==
X-Received: by 2002:a17:90a:fa45:b0:2ea:61c4:a443 with SMTP id 98e67ed59e1d1-2ee25abf59cmr26106958a91.4.1733127375376;
        Mon, 02 Dec 2024 00:16:15 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:94c8:21f5:4a03:8964])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848505sm7891833b3a.178.2024.12.02.00.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:16:14 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Koichiro Den <koichiro.den@canonical.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH 6.6 2/2] arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
Date: Mon,  2 Dec 2024 16:15:50 +0800
Message-ID: <20241202081552.156183-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241202081552.156183-1-wenst@chromium.org>
References: <20241202081552.156183-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit 09d385679487c58f0859c1ad4f404ba3df2f8830 ]

USB 3.0 on xhci1 is not used, as the controller shares the same PHY as
pcie1. The latter is enabled to support the M.2 PCIe WLAN card on this
design.

Mark USB 3.0 as disabled on this controller using the
"mediatek,u3p-dis-msk" property.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
Fixes: b6267a396e1c ("arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240731034411.371178-2-wenst@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index b78f408110bf..b21663b46b51 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1296,6 +1296,7 @@ &xhci1 {
 
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
+	mediatek,u3p-dis-msk = <1>;
 };
 
 &xhci2 {
-- 
2.47.0.338.g60cca15819-goog


