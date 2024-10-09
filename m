Return-Path: <linux-kernel+bounces-357403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2A99970E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BDF1C225C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B0D206E7E;
	Wed,  9 Oct 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHhqFDPV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248141E1044
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489208; cv=none; b=KVyhpDHAgBV9fgkg85qGs4oXNWK+kLNNbcgvDr3QUAdkffvJr2edbaJveBv/Swxmo/nH8iOn4lu0Elq5rd3Y/BxIAa/SqCXoSXX8QUZlUDHBNfaa1bv79CZwBrnnTW8stNpy+TnFhjxzp5XzowTQ8BByd20seBAN0ako3YQmxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489208; c=relaxed/simple;
	bh=f1LpFtobIOnpHETah6AN22lR7vlL7PV48c1P86HfDz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HEXV4/PxHDQVI4TSn0BTHUDaVHiaS1q4qFg1eiKDAuwvHHr/jBSfwN7xm8SE7XJrmP7izenH6HsXuzpmV1Re4l2oTADaOKKvgha00anKuukMqpY1uCQ6teRDSnmLlQ7PNFbmL7LyCPAJVU21zQ7hm9C//hkIw/iNg4Wmdg3s/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHhqFDPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88D9C4CEC3;
	Wed,  9 Oct 2024 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728489207;
	bh=f1LpFtobIOnpHETah6AN22lR7vlL7PV48c1P86HfDz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZHhqFDPVrQDICk6eihx/YBkMWHPbEgR+D6wPUj8geuPlaQWEpRldZnQ7GWzXJ5w8s
	 K6hfXyarRl8lN4cvB6sVpAUf0zWJ1/OWmtbwurI2GafU7io1BSLvq6nenZ5SKCeAaH
	 8hyL3ja8JIaXFdPTRvGFStSGt4hAiyX7A/9CD8peaEiDFiKxQFZtDYpfpYCCILdztL
	 PfguLnNRdgq4Eb+VYfj+wYKm2tI+XAM8/tCQcCeBbO3xLF4qH9XumZy2IVn70viQod
	 yNnvSfVLnYevpg0wEm7cQVlVWqXd7T++/ykZPI4NhWfch/UFv2w7yuhPIYugXBdulL
	 J6VT402UG5ksQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20241002121311.162691-1-ckeepax@opensource.cirrus.com>
References: <20241002121311.162691-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH] mfd: cs42l43: Fix issues in probe error paths
Message-Id: <172848920654.651408.16509705834016673995.b4-ty@kernel.org>
Date: Wed, 09 Oct 2024 16:53:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 02 Oct 2024 13:13:11 +0100, Charles Keepax wrote:
> The error path in cs42l43_boot_work() will lead to an unbalanced
> regulator put, when the driver is removed. Fix this by relying
> on remove to power down the device. Also the boot work needs to
> be synchronised with driver remove, to ensure the work is not
> still running after the driver has been removed. Add the required
> cancel_work_sync().
> 
> [...]

Applied, thanks!

[1/1] mfd: cs42l43: Fix issues in probe error paths
      commit: 416689a634c5bea3432facc8ae59187c71e7c47d

--
Lee Jones [李琼斯]


