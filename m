Return-Path: <linux-kernel+bounces-305550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D8496304F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3C21F25567
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8151AB515;
	Wed, 28 Aug 2024 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tk0vNvdG"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397F1850B5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870542; cv=none; b=VZWs67mlUWjCYVS6NqKbZqVgcp7hJzKOFfsHW5QgSxvCZdYX4iBgyp5NxOwLQ7DMsTIy1DYHjSqjIEOl5iaIpWJyeN3SuLA105PxnEFBPNnw/ypQieogGi4f8HyIQff2/kKeV6+l4rUt6v+yiFNACe6KkJfMZdBeyku2LhqkMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870542; c=relaxed/simple;
	bh=+Hy4MhEZ0TQM2J5evU+xJLFpadBLRiwWrPVZtpUS6zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqx/ybRAltnk1Wj9tvp8yBHZB5vVOHMp5z31PsG6CrfLZB2255VClSDw8+ofe/HoM9ea0G4sXSQmI7eMnvMbaOBh8Pjl62K4LN4Tt40pRYpo4UC+dUblxRtcfQA+nQ9Bk2U4omkzYG2KoN4W6yOLnhmYef5ybat4xUzDyTTgfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Tk0vNvdG; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SIg0hw030450;
	Wed, 28 Aug 2024 13:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724870520;
	bh=dCzel+mA5KauDoR7Zr1zRFmfIbr/0hgHzvkCt7YmUPE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Tk0vNvdGOog0WYpj6Jupx03oU4n4kIR0CmxNhrzIAT9N0peaog3FGAsJiuFkxFLWL
	 ovWImXJXwJwDQZ2+YKJPZMeXeBt6aJjheGa7FEDppRyG8rhkkGx35ZrDe/NJxdpW7i
	 SLxu0C+Jy6EV5Imwa1rh1C89f7LoEO/417btTzFw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SIg0fP004887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 13:42:00 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 13:42:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 13:42:00 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SIg0Q9036359;
	Wed, 28 Aug 2024 13:42:00 -0500
From: Nishanth Menon <nm@ti.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Julia Lawall
	<julia.lawall@inria.fr>,
        Kousik Sanagavarapu <five231003@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Shuah Khan <skhan@linuxfoundation.org>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/4] Do device node auto cleanup in drivers/soc/ti/
Date: Wed, 28 Aug 2024 13:41:57 -0500
Message-ID: <172487049349.3438376.18165226507785538752.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240825085714.10736-1-five231003@gmail.com>
References: <20240825085714.10736-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Kousik Sanagavarapu,

On Sun, 25 Aug 2024 14:18:41 +0530, Kousik Sanagavarapu wrote:
> Do "struct device_node" auto cleanup in soc/ti/.  This patch series takes
> care of all the cases where this is possible.
> 
> Thanks Nishanth for the review on the previous round.
> 
> v3:
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/4] soc: ti: pruss: factor out memories setup
      commit: 952ceb03787dde88fc713c7453824e25bf12cb3a
[2/4] soc: ti: pruss: do device_node auto cleanup
      commit: df70c0b4828bb85f1370453288a0a63d7618decf
[3/4] soc: ti: knav_qmss_queue: do device_node auto cleanup
      commit: b0289dbf1c952c04ba48b05cc6345381999ef055
[4/4] soc: ti: pm33xx: do device_node auto cleanup
      commit: 68123510b7c1c610387dd306f92ff539c3c546b5

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


