Return-Path: <linux-kernel+bounces-432956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473F09E5250
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275D9166FA3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDAE190059;
	Thu,  5 Dec 2024 10:31:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5C1946B3;
	Thu,  5 Dec 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394673; cv=none; b=Jk1OPxpoB2CPPc+a7t0jiZELdpurVkSVds4PG+UyumoV3U/0PUeXWb8GnNQg3lMVLqm07A4b6XCDieI+kHC0UNIDaVodFBqmBStcaPYyP4hVGjiTemtLLEb4SIlPdkH7u4Ji+X4KQHpzAi0qhRra3dYdmfpHe7Ruv6HKjVB8ZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394673; c=relaxed/simple;
	bh=ZCNAdJmWfjtie6QlXDqRoAWyQo4SKkaScCyvbtpcbhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8ERkZ8svukGVUjWT5S2vmmbbGUfQvuYnteC7XWrehAGNzKBE4K54vI22rKpi9lrB2YC0b95NL0Q9Dtxre2blxVLwx7XY5zj4+rzLi4Dcg2FKKAjKOzptQFd8CyfYEh3+2K8h6UzM7WgssWBxRIRymsKPQSKrjuJNg3VUPOtH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88EF2FEC;
	Thu,  5 Dec 2024 02:31:35 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F9533F5A1;
	Thu,  5 Dec 2024 02:31:05 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: fvp: Update bus-range property
Date: Thu,  5 Dec 2024 10:31:03 +0000
Message-Id: <173339457335.691023.1334271427632194234.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128152543.1821878-1-aneesh.kumar@kernel.org>
References: <20241128152543.1821878-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Nov 2024 20:55:43 +0530, Aneesh Kumar K.V (Arm) wrote:
> These days, the Fixed Virtual Platforms(FVP) Base RevC model supports
> more PCI devices. Update the max bus number so that Linux can enumerate
> them correctly. Without this, the kernel throws the below error while
> booting with the default hierarchy
>
> pci_bus 0000:01: busn_res: [bus 01] end is updated to 01
> pci_bus 0000:02: busn_res: can not insert [bus 02-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
> pci_bus 0000:02: busn_res: [bus 02-01] end is updated to 02
> pci_bus 0000:02: busn_res: can not insert [bus 02] under [bus 00-01] (conflicts with (null) [bus 00-01])
> pci_bus 0000:03: busn_res: can not insert [bus 03-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
> pci_bus 0000:03: busn_res: [bus 03-01] end is updated to 03
> pci_bus 0000:03: busn_res: can not insert [bus 03] under [bus 00-01] (conflicts with (null) [bus 00-01])
> pci_bus 0000:04: busn_res: can not insert [bus 04-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
> pci_bus 0000:04: busn_res: [bus 04-01] end is updated to 04
> pci_bus 0000:04: busn_res: can not insert [bus 04] under [bus 00-01] (conflicts with (null) [bus 00-01])
> pci 0000:00:01.0: BAR 14: assigned [mem 0x50000000-0x500fffff]
>
> [...]

Applied to sudeep.holla/linux (for-next/juno/fixes), thanks!

[1/1] arm64: dts: fvp: Update bus-range property
      https://git.kernel.org/sudeep.holla/c/4f776d81bf92
--
Regards,
Sudeep


