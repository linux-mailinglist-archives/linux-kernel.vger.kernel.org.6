Return-Path: <linux-kernel+bounces-310388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EA967C1E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD0BB21251
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E51311AC;
	Sun,  1 Sep 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PNZKVnJ8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4B6F2F3;
	Sun,  1 Sep 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725222449; cv=none; b=Hx/pso/swIVHRn1FKFhQzvMw2TtbhVnyUuLQjO/QVEDSabFhMtGfoHG2QZ5XkX7d5wEkyeayaHZFYoCau6XMsigxT24tXSE5EE6rALkEJe+UMKW6O3RkEkxoDwp9/MAtiKujzBzlE/OCWY7kG4kdZUEu2IHOftk1Os9l3x0RQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725222449; c=relaxed/simple;
	bh=dWWUyZ4W6tv1nKNjX3JmE+vszYZo/H/vp5V145nYC3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQS5fQztSRp3tGDSbLkqtM9dIadgOgluAsjXqaMo6gd4s1yrBqDAS3/Wud6UH0RIQGjAZdHUlbFIp3gMsyt2w8HBMNPHMH2Gao21EFIbK0jhO9oaOzCuWgID+x36k1iwqdkZ5qF7Lda8H0j6RP7uN+gmWDVa9VrAwhTMCkKp/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PNZKVnJ8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481KRLrK014382;
	Sun, 1 Sep 2024 15:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725222441;
	bh=HbMuDKTJn/05b6WVXHNCooo178JomhOxUGwIjE5S+e4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PNZKVnJ8NgF/U4lIqDNP8z4lj+yetmeI0wFbOu5fkJzCPDrl60US+dIpZSLF1uw7X
	 KioL7qoFphIAIYtgdV5lCOD5kGqCIRLgSJuNk5u9usOyabBnhzCg6u0XUUlcJrFPHR
	 Pi5nZGQKpxxJZtOIjww2Vh6WoVEjNaSSLfy0/kws=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 481KRLAe018520
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Sep 2024 15:27:21 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 15:27:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 15:27:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481KRL6F130225;
	Sun, 1 Sep 2024 15:27:21 -0500
From: Nishanth Menon <nm@ti.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>
CC: Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Jared McArthur
	<j-mcarthur@ti.com>, Andrei Aldea <a-aldea@ti.com>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Deepak Khatri <lorforlinux@beagleboard.org>,
        Drew
 Fustini <drew@beagleboard.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: ti: Add BeagleY-AI
Date: Sun, 1 Sep 2024 15:27:20 -0500
Message-ID: <172522242296.999759.5764187083192053718.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829213929.48540-1-robertcnelson@gmail.com>
References: <20240829213929.48540-1-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Robert Nelson,

On Thu, 29 Aug 2024 16:39:28 -0500, Robert Nelson wrote:
> This board is based on ti,j722s family using the am67a variation.
> 
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] dt-bindings: arm: ti: Add BeagleY-AI
      commit: b8c773f556936577f8fd7be29c5e579422436784
[2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
      commit: c5e615963bbeda0bdb0a97a33bcba46d6eea8a96

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


