Return-Path: <linux-kernel+bounces-387248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B7E9B4E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164C128769E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB581198E89;
	Tue, 29 Oct 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bY8fNujM"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5C198A36;
	Tue, 29 Oct 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216920; cv=none; b=YuXycBLJS6wzeoe+NtlzZuYxjAf5Vd7VxoaqElerb+pSDKCJzDrLL5YnATSzcFOz5g2IjATzLfnGdoePss0wVLw6FQMbUnhtbU/axE73M9RFF813sJSJc1vxXUY8YWCO9D5iHmAZIwG6lwatVYwyg3BQqXp31HcSNh3aqntJR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216920; c=relaxed/simple;
	bh=Vdvsr1lhBN/toODAQt4PxeC5u8yuFr3CMELIv6g9jjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEZtAgSH4CoScjWpS2o13Z4P0O+JYOEuXwopqit+NjxgiwQV4G1sMoEUWkubkZBFFuRIpVLhb3eyn6PHA8jDD5y9EWKGdYISKwLFURQWsbtSh0PDVIwqlSrcIm0bpFsB5+HLxhHnK5JOjDiecuo1+Wfee2dctSlfDdwsqEMciow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bY8fNujM; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TFmOxF107291;
	Tue, 29 Oct 2024 10:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730216904;
	bh=eTnFEy1MAUFsyqRGyai5JvkXC+wAhVQ3q3U2Jfipum0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bY8fNujMdePon04Tk0nymLeMsUyLheOcxYbeFh30kaM91oTiQGeafV4WlEieVDumS
	 DazlZnsJxJUMClhpk1htmbboPid6zupPotQBt5fwDaMiAMkPC1m+yuKVZPsdrilYUA
	 pnYU4BsHPMEIoJRP+b5pdWMzHT4iOwJbmgJdgSh4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49TFmOAM018851
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 10:48:24 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 10:48:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 10:48:23 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TFmKUC084172;
	Tue, 29 Oct 2024 10:48:21 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am625-verdin: add TPM device
Date: Tue, 29 Oct 2024 21:18:18 +0530
Message-ID: <173021674663.3859929.17448432308206382052.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018170436.80010-1-francesco@dolcini.it>
References: <20241018170436.80010-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Francesco Dolcini,

On Fri, 18 Oct 2024 19:04:36 +0200, Francesco Dolcini wrote:
> Add on-SOM TPM device to the device tree file.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am625-verdin: add TPM device
      commit: 4a050c4ee190b3184f9d734ec4e277e5279132f5

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


