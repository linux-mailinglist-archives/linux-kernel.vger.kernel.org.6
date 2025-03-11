Return-Path: <linux-kernel+bounces-556573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BA1A5CBD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896701896345
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CCF25E47C;
	Tue, 11 Mar 2025 17:15:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5263184F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713353; cv=none; b=m1a2zt6Zgz99iO3vg4NFH6zSkrcLKPLYHR2njYYLw9bCQJ7sWIPwkIWj8kfScJdp9ADnL5710qEd++0xHhJtUxzRvsJpWC9DfOPRrI1gGJhLRcqYp5nIwHvV45+2Ujr2wvL32U+gvv6RugewwsUY/E+oCvbxZRXDX3igEMUdjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713353; c=relaxed/simple;
	bh=Xla00Z3ALS7cRbu4taKyAoO71Nh1XUVFNF6do1tkZ1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dlr1C19U393oRL1ZE0ayiFHihxy4zQ9il8Rie2QcYFVr1D7g0FzkFMy4hfYK/eaGJ3V7g/7sNN67johAvVeXNFa48lQ7jII7tVAQZFuKct3Y7RMTKemNZrn8dONqmaswjKN2iq3jHLqtif88JlACEbT31cHQujNulDAP6gix1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05A2C4CEED;
	Tue, 11 Mar 2025 17:15:50 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will@kernel.org>,
	maz@kernel.org,
	steven.price@arm.com,
	aneesh.kumar@kernel.org,
	gshan@redhat.com,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 0/3] arm64: realm: Fix DMA address for devices
Date: Tue, 11 Mar 2025 17:15:48 +0000
Message-Id: <174171334191.3659388.13494602275110471880.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227144150.1667735-1-suzuki.poulose@arm.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 14:41:47 +0000, Suzuki K Poulose wrote:
> Linux can be run as a Confidential Guest in Arm CCA from Linux v6.13. The address
> space (GPA or IPA) of a Realm VM is split into two halves, with private bottom
> half and shared top half. In Linux we treat the "top" bit of the IPA space as
> an attribute, to indicate whether it is shared or not (MSB == 1 implies shared).
> Stage2 (GPA to PA) translations used by the CPU accesses, cover the full IPA space,
> and are managed by RMM. The "top" bit as attribute is only a software construct.
> 
> [...]

Applied to arm64 (for-next/cca-dma-address), thanks!

[1/3] dma: Fix encryption bit clearing for dma_to_phys
      https://git.kernel.org/arm64/c/c380931712d1
[2/3] dma: Introduce generic dma_addr_*crypted helpers
      https://git.kernel.org/arm64/c/b66e2ee7b6c8
[3/3] arm64: realm: Use aliased addresses for device DMA to shared buffers
      https://git.kernel.org/arm64/c/7d953a062416

-- 
Catalin


