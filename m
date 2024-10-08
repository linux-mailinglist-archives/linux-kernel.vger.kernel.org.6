Return-Path: <linux-kernel+bounces-355827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6599579F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4306B21BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB930213ECF;
	Tue,  8 Oct 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cZ1f3rj6"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B01E0E1F;
	Tue,  8 Oct 2024 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415754; cv=none; b=E7ordF+wgTPQNuQoFj+DDgn6h10OadBdNyXnPRq1J9K2DrQ3CRCGZy6rx70OMVhS2fjYzFhyQIW4eL5t+9Oh9zTKykZkqGF8/Bb1UZE+64d94tAMk+KN9gLCp1drkBHOKYKIUqBpFWJN7v/eM/vWIk7fwsLP5ojTF0vsYNGFKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415754; c=relaxed/simple;
	bh=LrSotCG1unYOPTZ2QurWOTfNeB/6GwOJpyfHuvaxIt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POXVOHBUWqWB8cnmgdBISal0WVbfBOx94PAzO1r0JLu/erL5XG0d8oPtimnLLVDAn8KTKnVP8PWqKSExkBuGFi6XVMKpKFc882VcNX39jcwcvl8EQx8I6jGXEr3maKQReIf0a6B7nd4h2uZe89kZ9i7iFtHqSP84ixOUI7ZNc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cZ1f3rj6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vp+mxQr1K9SZ25DVot0Ui/tUkTJldDL067EXZplCYD4=; b=cZ1f3rj6eDRY5M2QYGSimczWkM
	EZfUZAHX2N87TzTp/L05sTqVd3Cqmw9SB+nEtu5CeykrehJe9+a5a6axBXfAr7CkgMGeN65SX4aJj
	4paTYUcx5nqNMtP5K1awWFkMAPYfk84iREtyo4ex5SGgQ7H/pqsad9A8c/ibp5LS3FoLpTgWIsbri
	ABnUfXTmNclaxfD5ozhN2lSa4HWcGPchnTqpAE7PqB+U6cNKK/XPMzVR4Yk6yq1Ns3hURl91ViQI4
	yG7TcuUyl7zsOih9g8mzFMpJEznKr6MiNJkLoBY52B8OVHld5khs3oW3XsYSExiMNy/JuQxs1ZzlH
	TVCBneYQ==;
Received: from i53875ad9.versanet.de ([83.135.90.217] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1syFtG-00072O-Lb; Tue, 08 Oct 2024 21:29:02 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	Samuel Holland <samuel@sholland.org>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Riesch <michael.riesch@wolfvision.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/4] rockchip: Fix several DT validation errors
Date: Tue,  8 Oct 2024 21:28:59 +0200
Message-ID: <172841572989.2562611.18254512768409976284.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008113344.23957-1-didi.debian@cknow.org>
References: <20241008113344.23957-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 8 Oct 2024 13:15:35 +0200, Diederik de Haas wrote:
> This is a set of 4 small device-tree validation fixes.
> 
> Patch 1 adds the power-domains property to the csi dphy node on rk356x.
> Patch 2 removes the 2nd interrupt from the hdmi node on rk3328.
> Patch 3 replaces 'wake' with 'wakeup' on PineNote BT node.
> Patch 4 replaces 'reset-gpios' with 'shutdown-gpios' on brcm BT nodes.
> 
> [...]

Applied, thanks!

[2/4] arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
      commit: de50a7e3681771c6b990238af82bf1dea9b11b21
[3/4] arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node
      commit: 87299d6ee95a37d2d576dd8077ea6860f77ad8e2
[4/4] arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes
      commit: 2b6a3f857550e52b1cd4872ebb13cb3e3cf12f5f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

