Return-Path: <linux-kernel+bounces-557339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C3A5D78A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB89C179CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE098228CBC;
	Wed, 12 Mar 2025 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vcjeeP/R"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA8229B01;
	Wed, 12 Mar 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765597; cv=none; b=k0epHJlWhW7UV+/zfLqUcfLbOQSne3P76kMSsGJupuZphZozAD9cqhxYbV+He+r1DIbjOO3QYOexiRdQyg4jDJy0m8Z3HpSErrLFPyWK/tFJNGPaqRxtWyNT1yTaT/9FRdk9l3YDxlthKw4oe52jpztJHpdvKOjBHNN+F4JGK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765597; c=relaxed/simple;
	bh=FuNqiDDZLA6XzYyYHRO8Ky3rEJzuFLHAXYqyx3TNvtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exbHsB/QpN0nGTVXRdMhxo/PONaUNcPIIAO4L2yTKc3AJKfGma37vsYk0TyfuflBiBOs4YBZnNRkGe3F5cQhnDynmtFq6e90yQEkADOT3sxvpbcmyhvzgjlOc0FH9ptUztzBlWs6s/E8BzEuYtVKRwX2ycCVXfLfWIurFMtrpyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vcjeeP/R; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3122Wo2fSfR2TPlv6KJp3UkaT4U7LmFi/eDScIdI+bw=; b=vcjeeP/RFEc3s/ROSIdpdnOSAi
	woidRou28FgDEniQ7+tfNBWNfFTWEu7vvnJ3sJPsejwTIdyYm6p2nacbWrTWyK/qX4HPL4cJmHAtF
	/JhVuBlQUmlYSZ/ZcwEdDDfKIG5NIVOImnzlnXypkTuQqJ6v3iIBcs7lgNZfCFEekhLSOVMYU6I2v
	QAV62zHyavflDcEmXi35GFB0VJZX2QuIMqRi2OQOVMVxr0Tpl6kIR+WogJr0r1UtbFgauXRt1NNGh
	fJcdNBzhE48/GVnArXBduvYINw0RV6ZQ0D/ZCbU5E2nX8ZnS6GhekHG/4q0c00XhstUbDAa9qt8tS
	HaoaTuBg==;
Received: from ip-185-104-138-79.ptr.icomera.net ([185.104.138.79] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsGnM-0005zY-5X; Wed, 12 Mar 2025 08:46:29 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add AP6275P wireless support to ArmSoM Sige7
Date: Wed, 12 Mar 2025 08:45:59 +0100
Message-ID: <174176555630.249409.3989831081874397806.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311142825.2727171-1-liujianfeng1994@gmail.com>
References: <20250311142825.2727171-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 11 Mar 2025 22:27:50 +0800, Jianfeng Liu wrote:
> ArmSoM Sige7 uses the PCI-e AP6275P Wi-Fi 6 module. The pcie@0 node can
> be used as Bridge1, so the wifi@0 node is used as a device under the
> Bridege 1 similar with Khadas Edge 2.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Add AP6275P wireless support to ArmSoM Sige7
      commit: d6166ea4cc4943cbabdeeedb13f3545fdba3ebf6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

