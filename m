Return-Path: <linux-kernel+bounces-276130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EEC948EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D75B256A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDB41C4622;
	Tue,  6 Aug 2024 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KT621vt6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154081C3F08;
	Tue,  6 Aug 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946400; cv=none; b=eUvhawMWXG99ZkypX1nlvtQiQiirABiOdpSnahH9Se4OXFkEiufDcEHYhNzs30Ie6qB4WLYV2pWaX4CK2kaFZ4E5zTu6ToF02w4GQUqOZ33VcLh/GGFWzZoEzv8R8PCjuk+/Z0GFXuK1DZh2xQby2qxukOCImfshaxV+feAAByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946400; c=relaxed/simple;
	bh=vDIYMNWUnBp2X+UXR1beZL/3sN5snPK3x8hJqnHf5Cc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAzh+SwNdafYEhYiEkf3JecQU19Igo83EFW+xDPoaxOFwVNc7VDtPGe6zLii/WLJ9YK2xBflrxh7a2ouAWffdJxz5UZ4f8KGint5jcv5Yk87ep8H3LhXRls7EVGmKLaxf1NnV4z1FqCJtjBPASDtHd68cpHLDUwp3BZSWAroIk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KT621vt6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476CCtUA124393;
	Tue, 6 Aug 2024 07:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722946375;
	bh=p0WXhYHU2Q5VD4zKoqLsbmGP4zVGVJ14t95iABMkEHI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KT621vt6KVXuvAjsx9gLIk8eL/nPwaBaNYviC+DG+B6JqRMHNju8gd07c3B4fPVwQ
	 IViv6X1BNAeGi7AMrYbABKNhzZw0fwrRriAgaj7Z6x0peZ75xdhnQae3t7MplkOZ6+
	 iZT6UCc2TYgMtm2QLrpqsziXwde9yjolw2MP9vqA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476CCtdA023460
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 07:12:55 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 07:12:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 07:12:55 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476CCsFE083782;
	Tue, 6 Aug 2024 07:12:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parth Pancholi <parth105105@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Parth Pancholi <parth.pancholi@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs
Date: Tue, 6 Aug 2024 07:12:53 -0500
Message-ID: <172294636781.366424.12556232446484144783.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730093754.1659782-1-parth105105@gmail.com>
References: <20240730093754.1659782-1-parth105105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Parth Pancholi,

On Tue, 30 Jul 2024 11:37:54 +0200, Parth Pancholi wrote:
> Correct the McASP nodes - mcasp3 and mcasp4 with the right
> DMAs thread IDs as per TISCI documentation [1] for J784s4.
> This fixes the related McASPs probe failure due to incorrect
> DMA IDs.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs
      commit: 402d336053a5d827c70ec11109e079811e86e0e8

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


