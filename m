Return-Path: <linux-kernel+bounces-212894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6729067E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D082858A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F07377118;
	Thu, 13 Jun 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rH6qOsQV"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D12137936;
	Thu, 13 Jun 2024 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269077; cv=none; b=PGpVxt0XbuorRhiLrURHeCTQReC9jK4ZxkMzii9LYxZMLlZrzw7cHGs/fYkX7TaFgt7bDgzd9gbGEZJHhucJxOk1LPxw+G53bmgAm+G1EWD38l31ZXarBXjM/cZV8tDdzPuuX4JqdiAvOiclzCR5ALlJayHpYyQlKeDWAXo0vsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269077; c=relaxed/simple;
	bh=8hk5bZhuEgYYt/XNoX//+yWm+oshHenGhcqzKTQZ93U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d2qWPbGdfQF5BieYf6QjApdTIX0g9auS6l7uJndY7KTg+5lbTh1tT9erl2VXOz2pAa/sx59xdhPKJNT/z0lMSTAb1CaqPgmrIPBLgi1gRzidZ7P7fOZgEzF3pqURRozsVqGwJ/nBodNG7Y4+TDyYrkU8EueZMjrDZXDL05W6thg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rH6qOsQV; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8vjFv111550;
	Thu, 13 Jun 2024 03:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718269065;
	bh=FCWXZUmqj2m4yTwYjoWQ5TZenCbpTC23rGxR4ivijcM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rH6qOsQVc0URBkDnH+51aGP64R4J4KRFJoQuMQ1+EY3fUoZFH6AoVL746VQaze0ko
	 VGV9E0pH8NhNwRnfwGPcQIvQGyMdQoAWX455oJoW6yDnt4t/m9410af+VtM3vOACg+
	 fm8k6IPpYCktmQf4NMOFp9717jULhLvKYOfZrNBo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8vjaO096529
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:57:45 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:57:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:57:45 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8vfNf109182;
	Thu, 13 Jun 2024 03:57:42 -0500
Message-ID: <65fcbdce-0163-411a-997d-6718b6975bd9@ti.com>
Date: Thu, 13 Jun 2024 14:27:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset)[PATCH v2 2/2] arm64: dts: ti: phycore-am64: Add PMIC
To: Nathan Morrisson <nmorrisson@phytec.com>, <lee@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <nm@ti.com>, <kristo@kernel.org>, <j-keerthy@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
References: <20240429195830.4027250-1-nmorrisson@phytec.com>
 <20240429195830.4027250-2-nmorrisson@phytec.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240429195830.4027250-2-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nathan,

On 30/04/24 01:28, Nathan Morrisson wrote:
> Add a PMIC node to the phycore-am64 device tree.
> 
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> ---
> v2: No change
> 
>  .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[2/2] arm64: dts: ti: phycore-am64: Add PMIC
      commit: f3841b6a22f1a7635dc73b94b98596b94d153ed1

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

