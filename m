Return-Path: <linux-kernel+bounces-381326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A3E9AFDA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C531C25422
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A2D1D4359;
	Fri, 25 Oct 2024 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HsMv9IQI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1E1CF295;
	Fri, 25 Oct 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847155; cv=none; b=QZ6+S7n8eubIcwV4c85xwbT6gXOp+zzFpT0LzdfnyFBHGsCEX/z+vDDVUjHqnO/T1c6FVzI0EIFhMbtcs0LmfoAFgrWqynhQ4C6q4Zqt3XzrvNBLealIc8L//1AucFX0tBpZORUEFCeNtIDnhUJWjSSf26nK80sC8gqxyhN3soo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847155; c=relaxed/simple;
	bh=COW3lk8+Bc9EJwhzhAxrKQJP6hCqWZJClySSSooP5M8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G8AYyOCPPwqpnnEiSri2SSPRi/c1ZOp1CCtWcxB6vKXd3E4/RZ8NQI89l959GXWkW+I6/Z2be79/9r5WRQ33T6wikMtsB3wb5MEQY7WTnY3oJOes8sGcNvhSaSIJGNR5V1dhdgCntb4bGoa+DOOu8bamcJdcXxx88uwn8K6MWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HsMv9IQI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729847150;
	bh=COW3lk8+Bc9EJwhzhAxrKQJP6hCqWZJClySSSooP5M8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HsMv9IQISHMd8sUoNSI5iL7aDJPkZyKKJFfVFa/GPon4VDL/YCTSkRf8HSYfNK9Vo
	 tJC/sf8O9b0BLcAgjYh3BGuH6N4EYMSZInI6cXCH0nEXNSPZf/Qpv9Y5UT4Mvi3Icv
	 KQlR7SQBay2G5qRkk6sQ6880/jS3xnH2OxASG78wN8eajJyc2CIxTYjEXiHFi095VS
	 Rbxlv6ojXyldiusH2ZUUZTRHfvuXYxHK8rK+LdHP+d9Sh+etZqOz4Z6h1jgxAiJeny
	 yE+gRG4Wo4p+7DdEcl+r9hbYXVF4bib48mGOZF0A80YaOgvab/+m94GIctgQKhW+Dy
	 8O8dgIcCUCxOw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 61A5217E121F;
	Fri, 25 Oct 2024 11:05:50 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
In-Reply-To: <20241025-i2c-delay-v2-0-9be1bcaf35e0@chromium.org>
References: <20241025-i2c-delay-v2-0-9be1bcaf35e0@chromium.org>
Subject: Re: [PATCH v2 0/4] arm64: dts: mt8183: Add
 i2c-scl-internal-delay-ns
Message-Id: <172984715034.53952.16839871350225825079.b4-ty@collabora.com>
Date: Fri, 25 Oct 2024 11:05:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 25 Oct 2024 16:03:47 +0800, Hsin-Te Yuan wrote:
> Add i2c-scl-internal-delay-ns for each device.
> 
> 

Applied to v6.12-next/dts64, thanks!

[1/4] arm64: dts: mt8183: fennel: add i2c2's i2c-scl-internal-delay-ns
      commit: c802db127dfb9602aaa9338e433c0553d34f1a9c
[2/4] arm64: dts: mt8183: burnet: add i2c2's i2c-scl-internal-delay-ns
      commit: 85af64983889c621e8868b744c8ca03bd5038c02
[3/4] arm64: dts: mt8183: cozmo: add i2c2's i2c-scl-internal-delay-ns
      commit: bd0eb3b1f7aee698b86513edf10a50e2d0c7cb14
[4/4] arm64: dts: mt8183: Damu: add i2c2's i2c-scl-internal-delay-ns
      commit: 6ff2d45f2121c698a57c959ae21885a048615908

Cheers,
Angelo



