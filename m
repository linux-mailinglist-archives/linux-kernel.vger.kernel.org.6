Return-Path: <linux-kernel+bounces-439086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC60D9EAAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A17188A9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DDC230D0E;
	Tue, 10 Dec 2024 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LIjKKpWb"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936522F3AE;
	Tue, 10 Dec 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819305; cv=none; b=b8hWcrIL9Y7Mbw38eJSOHDBZN63ZP45j24mMHSzldWIRCw8lKNYKht1HZqeodsvFfowOOaK5CyWyWgb7T9ICH2BNtH39h8w7+RmBEGgEDp+PyLY70hWgTCB1K/+XESmR6rpa7X6w7886mGXLlFFvDCq7wd+n+UN67A5bMTePGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819305; c=relaxed/simple;
	bh=wpi0mz8gNIjqHdmS+cqPCqSRyC2hv/m/XJlr//FMAxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K9PGrIwqVM5aUCCSxGusr2jaVoIt+ucBLY0QfASyX94WC468FsFEr42CJ9E84aur2LCapzS7hGF0fDkktsspSGjD1PL/Xeo0Tz/P7jO/NloP+cWJhVU4/OYehqkUye6nJblgiP36FU/sHiOlgLdH/tUEACeIA2sg88r1vudr6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LIjKKpWb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733819302;
	bh=wpi0mz8gNIjqHdmS+cqPCqSRyC2hv/m/XJlr//FMAxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LIjKKpWbbg+dvr3JuDxKmcaX+neuApyiRyU/uffcxMKwJWa8/thz8OE/q1sFrK9FJ
	 7jvHXVuZbfD+1ENQfSP9C/jkxQmFRXha+2vEi5ZjDTos9yjxc1D4ISd6VtvRLOtaKs
	 wSWbVtzy6CjNlwqtGUmSHIEcYBrtOfzT+2+X3277sBPkx34DV41+O7mvv8GhtFa/uQ
	 CvI4dyKmb1NczIVVMFPcMBgfZxiJX3nwnpTZk/ZgsRrg9ApxBNuxvoVdaIN5Y+bIys
	 RwFH3qo1HiU78UMi4IWIj1HXkkNhIebe2x6NrDYyuyTfj2W5sKlcRIi8f2znUa1bTn
	 oGyyb1UdfPrtg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CA79B17E14EF;
	Tue, 10 Dec 2024 09:28:21 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241113-damu-v4-1-6911b69610dd@chromium.org>
References: <20241113-damu-v4-1-6911b69610dd@chromium.org>
Subject: Re: [PATCH RESEND v4] arm64: dts: mt8183: set DMIC one-wire mode
 on Damu
Message-Id: <173381930175.18469.11487989790886879423.b4-ty@collabora.com>
Date: Tue, 10 Dec 2024 09:28:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 13 Nov 2024 16:16:53 +0800, Hsin-Te Yuan wrote:
> Sets DMIC one-wire mode on Damu.
> 
> 

Applied to v6.13-next/dts64, thanks!

[1/1] arm64: dts: mt8183: set DMIC one-wire mode on Damu
      commit: 6c379e8b984815fc8f876e4bc78c4d563f13ddae

Cheers,
Angelo



