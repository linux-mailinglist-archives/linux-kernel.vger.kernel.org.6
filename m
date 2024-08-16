Return-Path: <linux-kernel+bounces-289933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C239954D77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79ED286BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9960D1BDA93;
	Fri, 16 Aug 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVh4w6IU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B301BDA8F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821389; cv=none; b=HYasiBTahpGv2BprmSEhq+kCzEhlo+rquFfRilMIAPZMdxmjPq/ruS7nrErRcL0YT7EKigHodp3ZCQA1u+I/a5c3PwEnhjBztt9dY+FD2WHq2G7GPytshen5y3sJXdkYxlAW0HUUYMGkrOCKCJ6l8LiZUVNDJ8KBXv+2lxRBhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821389; c=relaxed/simple;
	bh=M3aXYfvZtOSP1Cm45umkLlCrgyuN8YBKot+wHksTLeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3d9LlSLh2Bh1KVlXeax91AjgVMjpYiies5HNpV8JeTTm3a2HriLq9txGT218zd0cb5tmua2addQgUV75Wx0cpSB7OTsp/EJs7GttihCluSafEkg2TXxvzOv1wE1Y8+wbgY5b/oxhPI4bvSY19Yxdijkppt4eD+JFJZi+COxZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVh4w6IU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499C2C4AF11;
	Fri, 16 Aug 2024 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821388;
	bh=M3aXYfvZtOSP1Cm45umkLlCrgyuN8YBKot+wHksTLeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVh4w6IU4BSTS3EEym+oVd0Mq9Ouw3SmOallmWODUWdGVf9OugK7otEfi9BoLeKAz
	 J5PZ0UXn8RIKzwhJiOzTplTw64PmFk4gvwywbayvCdJHI6LOtYkWBRf+zu0DYADo3y
	 Wv+WRh172doczIcxyUdWBblmE3+v07vGSj62NNA6QDtVypTduqILY+dGQyfiCoLcrz
	 SgtrXpwq6g7+r6aC1XGenCfs44AUf9TEDQ16aQita6pLU3g8YPLZ1yoUN3u6iQ23q8
	 JOJ1yZ9+/cOktFvkJcoTH4g0sFhsGf3DUBX04Xyb9tnfC65Ful/vkdLm6VX8LmO4Wr
	 Y+/55HnIpEV5g==
From: Will Deacon <will@kernel.org>
To: sunilvl@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE
Date: Fri, 16 Aug 2024 16:15:57 +0100
Message-Id: <172380817082.2918676.9519520229609793025.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240729035958.1957185-1-haibo1.xu@intel.com>
References: <20240729035958.1957185-1-haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 29 Jul 2024 11:59:55 +0800, Haibo Xu wrote:
> Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> To ensure all the values were properly initialized, switch to initialize
> all of them to NUMA_NO_NODE.
> 
> 

Applied arm64 hunk to arm64 (for-next/acpi), thanks!

[1/1] ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE
      https://git.kernel.org/arm64/c/8bb0376fe082

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

