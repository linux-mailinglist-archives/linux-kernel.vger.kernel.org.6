Return-Path: <linux-kernel+bounces-388123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988CA9B5AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2AE1F24DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89340198A37;
	Wed, 30 Oct 2024 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gAs5ZwHT"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CE1547FB;
	Wed, 30 Oct 2024 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263960; cv=none; b=PebZ0sXVJw804YcUARqnnmN1M1jDSO31nsYhZ0oaXYUUqCkPP6rnVt/6CBB4DtkOC9qUcEnKXjm3T+iZjKiM4RTfjhay5xqd3wFegkqWazbGfZXpcAn3bmIPVUUfZEXQktgel851Z+avSFGnp8aed/zn7KD+TD0OpD7kiVPQR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263960; c=relaxed/simple;
	bh=tkuh/NgWAupZs6TgYHIZI9+ElQhSCbppWsyuLhhh888=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZXmpJ5MQo2le4zpa1YgDLWD/oq7Rq1WZ6SV74bjICZ8UJ4urkNVjubaDFl7BlXbfvTdzQdVRAFlgBHfGkvqTOOaJLIiAz7hvia0IAKHRViymKdy2tCBfKYAHJBKRztR2yFrHMcJ/crVQG0q6f8gmJdVtk7Je30hwwl0qN51f04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gAs5ZwHT; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49U4qUv3046209;
	Tue, 29 Oct 2024 23:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730263951;
	bh=EXEoGVVRa6LoOYXk0lcO2dzLAjAUxRyL2GF3k7zGkoQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gAs5ZwHToPW8AeNDMhTuGwmpNlf6Jp4bsklHQUA4qeo2tbNdKuPX4mM2T6o0AW408
	 YAYNBRm+/VJR/UvvuzZ7u/PbQQ0iqecwdUqZ/WduEhRNiSaZVzpw3QoJWx7WmsfiYz
	 sXlplvZVAWq8sMvWacgQ9Uuz7qQkfNH3rBcTUe64=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49U4qU7C014376
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 23:52:30 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 23:52:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 23:52:30 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4qQV0005184;
	Tue, 29 Oct 2024 23:52:26 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mranostay@ti.com>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>, Aniket Limaye <a-limaye@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <u-kumar1@ti.com>,
        Jared McArthur
	<j-mcarthur@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j7200: Fix register map for main domain pmx
Date: Wed, 30 Oct 2024 10:22:24 +0530
Message-ID: <173021674662.3859929.17306406309658098523.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240926102533.398139-1-a-limaye@ti.com>
References: <20240926102533.398139-1-a-limaye@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Aniket Limaye,

On Thu, 26 Sep 2024 15:55:33 +0530, Aniket Limaye wrote:
> Commit 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux
> range") split the main_pmx0 into two nodes: main_pmx0 and main_pmx1
> due to a non-addressable region, but incorrectly represented the
> ranges. As a result, the memory map for the pinctrl is incorrect. Fix
> this by introducing the correct ranges.
> 
> The ranges are taken from the J7200 TRM [1] (Table 5-695. CTRL_MMR0
> Registers).
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j7200: Fix register map for main domain pmx
      commit: b7af8b4acb3e08c710cd48f098ce8cd07cf43a1e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


