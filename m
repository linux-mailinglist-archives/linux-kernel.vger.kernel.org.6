Return-Path: <linux-kernel+bounces-289399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ABD9545D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484AB1F29711
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BF213FD84;
	Fri, 16 Aug 2024 09:29:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E313E05C;
	Fri, 16 Aug 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800553; cv=none; b=GSsRZM7usPveI4BsNNUbxgeWQ37iI8IJnGjl6O9Tf7BugSuzBb/8S2sQ0tCauflbGXvLBmhtlfXScmomda685k3Xc7ujHIgXkQQQHD9eKVyfDpgAFnbMXP146085P/2+CrLoXB4uDe8XNqscPoWdesjP3q277n+ebRrFSIiM7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800553; c=relaxed/simple;
	bh=SltS1dKKb/LcApjDUP+DakymbXkrn0zHOj37EbtWeBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cB3DsHtGT+L6BFcGeB7VKN6+rnV6BQap9rhVNnXJrIa0F84X3oAlIq6HaOTARg9DstLCBO6+zeu05aMi79QLHwL1NkFGnZ1AwVbjOMs3/suzQzZQ3hKq1e/KGlQZFkFCAvzcjfO+fS44CJx2uofuFpTJG+kVJiy5fZ85VB81wCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61898143D;
	Fri, 16 Aug 2024 02:29:36 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7FF6E3F58B;
	Fri, 16 Aug 2024 02:29:08 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	ptosi@google.com,
	dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH v4 0/9] Make SCMI transport as standalone drivers
Date: Fri, 16 Aug 2024 10:29:04 +0100
Message-ID: <172380049401.784912.12689493595058820686.b4-ty@arm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812173340.3912830-1-cristian.marussi@arm.com>
References: <20240812173340.3912830-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 12 Aug 2024 18:33:31 +0100, Cristian Marussi wrote:
> Till now the SCMI transport layer was being built embedded into in the core
> SCMI stack.
> 
> Some of these transports, despite being currently part of the main SCMI
> module, are indeed also registered with different subsystems like optee or
> virtio, and actively probed also by those: this led to a few awkward and
> convoluted tricks to properly handle such interactions at boot time in the
> SCMI stack.
> 
> [...]

Applied to sudeep.holla/linux (for-linux-next), thanks!

[1/9] firmware: arm_scmi: Fix double free in OPTEE transport
      https://git.kernel.org/sudeep.holla/c/e98dba934b2f
[2/9] firmware: arm_scmi: Introduce setup_shmem_iomap
      https://git.kernel.org/sudeep.holla/c/1ebc28e9357c
[3/9] firmware: arm_scmi: Introduce packet handling helpers
      https://git.kernel.org/sudeep.holla/c/b6b7c77c988a
[4/9] firmware: arm_scmi: Add support for standalone transport drivers
      https://git.kernel.org/sudeep.holla/c/8b76a8c95930
[5/9] firmware: arm_scmi: Make MBOX transport a standalone driver
      https://git.kernel.org/sudeep.holla/c/b53515fa177c
[6/9] firmware: arm_scmi: Make SMC transport a standalone driver
      https://git.kernel.org/sudeep.holla/c/a41759500b71
[7/9] firmware: arm_scmi: Make OPTEE transport a standalone driver
      https://git.kernel.org/sudeep.holla/c/db9cc5e67778
[8/9] firmware: arm_scmi: Make VirtIO transport a standalone driver
      https://git.kernel.org/sudeep.holla/c/20bda12a0ea0
[9/9] firmware: arm_scmi: Remove legacy transport-layer code
      https://git.kernel.org/sudeep.holla/c/fc789363c9f0

--
Regards,
Sudeep


