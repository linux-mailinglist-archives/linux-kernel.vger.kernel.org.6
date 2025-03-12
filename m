Return-Path: <linux-kernel+bounces-557341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAADDA5D78F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC617A8DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8CD22E3FF;
	Wed, 12 Mar 2025 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cgwC2U0i"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E022DFBB;
	Wed, 12 Mar 2025 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765605; cv=none; b=MPcDGfbqoo+ZNUrZ+Ousye/XM8hHb9MSWSSdwObAk5w4DGUNjEmWppITmHNBulPyEFSc5YRk/zpFsz5MjK/lvghAvBl3CtAuEsX0AhX+zyz31+fn3S/ZKgJQXjuYAcndUmDA6hKrPNHVCXa0acu3ZJlrV7IP2a9yI+Ji9s75YNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765605; c=relaxed/simple;
	bh=adWIKMDlfJTotuX/HTcAW6PD6togYcePxv8XqoZKdjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+U21cZHmjpg3nHGd/5GoKsvGyJsVXQpr243Zo4IIjgT/UJRNaqWjTMmQR4DUSAuVb1qAGnCPNAAlOEyiLCTLYJdMrgbbxW6fxlqP7NT5AWSCL5EPCEEQXDI3AoyOC9L4wXZNfYlRO3QHKPHN0q0ycEChm7Lxe8kY5Ug0aeZJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cgwC2U0i; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ur2tbQAbcimaNbP+XssBtS/OZ76LbdfCjF3sZqEV5Ok=; b=cgwC2U0iZk5pei3L+TO5WGFFti
	ZsATKDWSLnnO4mgcQUqeVLmJERQ/51B6Ws5lgCqhS8sdINheBqNEfi5ZLuupPnP8uqpvezAoPgXV2
	r/YvFXJSHZMTr6s7utzxalhqgbHy8viu2GRPbuOOfOxSKIn6Y9NWHtS713/LWk5RKo2IAY26IL2y5
	k0kBq+FfK8dxEJxTnWDZIiPEkJecZ+XBvOUZ29NAkLvhRR67fiEva71kw8GaWjGnDrDUY47yqmLmp
	7pm8rAjmDbmaEk/eZRxP26sIcRsu0F2OtB8nwJvPdbxnCZjII7NWOK5xL44FQmgjv+uF9vXBHa5N8
	z7FM8/GQ==;
Received: from ip-185-104-138-79.ptr.icomera.net ([185.104.138.79] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsGnU-0005zY-Ot; Wed, 12 Mar 2025 08:46:36 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix pcie reset gpio on Orange Pi 5 Max
Date: Wed, 12 Mar 2025 08:46:00 +0100
Message-ID: <174176555627.249409.15245635322576159789.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311141245.2719796-1-liujianfeng1994@gmail.com>
References: <20250311141245.2719796-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 11 Mar 2025 22:12:39 +0800, Jianfeng Liu wrote:
> According to the schematic, pcie reset gpio is GPIO3_D4,
> not GPIO4_D4.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix pcie reset gpio on Orange Pi 5 Max
      commit: e79abd605edbd45eb61a251c6b0d6e50e605a14a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

