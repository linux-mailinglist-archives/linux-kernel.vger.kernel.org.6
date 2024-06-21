Return-Path: <linux-kernel+bounces-224962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DDD912928
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445291C2259A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807E35CDE9;
	Fri, 21 Jun 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ofcvR19f"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCF374D1;
	Fri, 21 Jun 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982869; cv=none; b=N/4v2knzUfFzoY1i7ALx0/57GDwUu6qyIQyUewVvz0S8C0kCUa+06FYMNw7p28K/2FMPs+cO4YOB9tKDdkejpzHtc3fzUiKb0uPPTFaC4csQ99EOa+yEtR0lp4aE6sP0P3wgXwAiv2E2bHdEUjygQt749yet473OeQsKAaQqPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982869; c=relaxed/simple;
	bh=umC54IYckTgkQeoniX9VSI4d9IzVAPV0mFUWWUNAxcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QW3qkgC2UoqgI6z3ywsVhGufmEZcSXWKZbxZ0geN2pKUdEBx3jAEjSA2pScLLxjOUkXmzikWUKjwF0nkLEsBhvuEQEKH6mtS6XrebgdqNk8bhWpit4cH0GEq/rysUVEeIDj8s9URK0lL2IAg3ugr1gWctL8gWMYLiDRiLDPyGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ofcvR19f; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LFEIK5073022;
	Fri, 21 Jun 2024 10:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718982858;
	bh=nYRRWkXd19SnsQRtzTSJ/QxcrDstVG9Wz1Q3ayqJNkw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ofcvR19fvDYS00WW9sja4fbtLpbYHWX9rF4DW9/57FfSx5wscfE9/neRoL0hrNi2D
	 XUtNZYAyC0nuFtZ2nFya74MnzV25lydmoXXoI3NOwfeY0EtsLRnfoWAKHZ0AnFLBgL
	 fJqJQWvXB9o3P7tu/tCq8jUZJOd2fRIAkk3FbGsI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LFEI7J016262
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 10:14:18 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 10:14:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 10:14:18 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LFEFV7062734;
	Fri, 21 Jun 2024 10:14:15 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-sk: Add power supply temperature sensors
Date: Fri, 21 Jun 2024 20:44:12 +0530
Message-ID: <171898028149.2272421.15510099849827395952.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612183826.121856-1-afd@ti.com>
References: <20240612183826.121856-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew Davis,

On Wed, 12 Jun 2024 13:38:26 -0500, Andrew Davis wrote:
> The SK-AM64 board has two TMP100 temperature sensors, add these here.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-sk: Add power supply temperature sensors
      commit: b82feb3a56e25919d6729b98c8152d950045fc5b

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


