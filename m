Return-Path: <linux-kernel+bounces-238879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A339892529A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B41F270DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F73CF58;
	Wed,  3 Jul 2024 04:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VsqgfUeh"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74938FA3;
	Wed,  3 Jul 2024 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981679; cv=none; b=ElvUssBLS0pTPpJDuHw8yl5Hzu3XWxIfB8pjR2NaYnUeLujrQ0ewJB3JvIGiaOuR1EXzsp2wx7eHAyqbm/PrBbPUzKZcdxgl3vHjSjvMh+xXZyB9eIx6TSBVn/N5NI+nhZVJK4w8UIRcMiMMxYDdF5AGrVIoxGmuYJaauvOIfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981679; c=relaxed/simple;
	bh=oki8liKn5k0U22KlItiWsAt4L8gNr6FiUWluvbFXBQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMRIieciC+u6pbdyBp+UweqVX+f6n0CkIx/Es9nx5JeK0pZFeJqOBWN4XLvss4h7WWaQMaHiM+T3PQOlGA+GeTxB/ugdmJC7JBipFXAo8SLcXmIQJY5h2eNkMnGRAoyN3gY1ASD3mpV168RNw7I9i6U6AVnwOrL7B/JElMMxJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VsqgfUeh; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4634fCH8090508;
	Tue, 2 Jul 2024 23:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719981672;
	bh=M1L/X3uXJ7DcW2oB14EvasFdDWQd6cfIR9J/Id0i6YA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VsqgfUehVOFvVGQnvXcRMTOVH61hweVIlKhNWZ0gEQ2RZFzXpZz5FTGvu7en7HNto
	 LTApj8XEpQqQ9+1RFXdqNdW+eBUIekH3VoWtWxvlREsIHXwB7jOurkAFOJEUhwIaY7
	 k4neZBeCsKjxxMvd+ZvRoUBMaHrn53DtgiOxuPXY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4634fCk0029849
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 23:41:12 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 23:41:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 23:41:12 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4634f8Jb016725;
	Tue, 2 Jul 2024 23:41:08 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <srk@ti.com>, <praneeth@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nitin Yadav <n-yadav@ti.com>
Subject: Re: [PATCH 0/2] arm: dts: ti: k3-am62-lp-sk: Add NAND controller and overlay
Date: Wed, 3 Jul 2024 10:11:04 +0530
Message-ID: <171984950182.3152309.13685651099901318581.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622-am62lp-sk-nand-v1-0-caee496eaf42@kernel.org>
References: <20240622-am62lp-sk-nand-v1-0-caee496eaf42@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger Quadros,

On Sat, 22 Jun 2024 14:59:55 +0300, Roger Quadros wrote:
> This series adds GPMC and ELM controller nodes to AM62 SoC.
> It also adds NAND overlay file for AM62-LP-SK EVM.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm: dts: ti: k3-am62: Add GPMC and ELM nodes
      commit: a0286c7bf091ac6bf542a00a305b3ae510242127
[2/2] arm64: dts: ti: am62-lp-sk: Add overlay for NAND expansion card
      commit: e569152274fec9ffdd3cf40d865d2b21ce46f75b

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


