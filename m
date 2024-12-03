Return-Path: <linux-kernel+bounces-429587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8919E25F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C00B339DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDE01F1304;
	Tue,  3 Dec 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quaHnSfv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B82AD02;
	Tue,  3 Dec 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233952; cv=none; b=VpTyKF4RVO0+cxvnAzX9e/NpYZ/AsSJWmPiWR4/IRp3M2Ht3/j3cw89hngQ5hJpae7s///DOxm3B33O3ySV3g1YadFn/6dkBPojzasp4G8W/8do04Pm+cUBdBIXzpSfjHcga/rYWAhALg01uXE7GqVMlPzdmxwnzII0CWbzf9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233952; c=relaxed/simple;
	bh=Py1FScrYE/Nxhj1tpTRCDTff5a2FxDu9XoSkMy68tsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFnVjZO/YKq2OPzmjqx/J55zQItnYRV2/n0aRK7XgAr/+xUPSu3JSnYU5W/zcVV1qHWU1DooL6DL3CLbMVQzz5eQS6A+56NPpq5+0KVesd3qMNaV64jCOfBefeYSbxsuX9ZYeGMlhc9kFUnW8o8UKrMzcUtFR+i6PC15Zj6m4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quaHnSfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B272C4CECF;
	Tue,  3 Dec 2024 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733233951;
	bh=Py1FScrYE/Nxhj1tpTRCDTff5a2FxDu9XoSkMy68tsY=;
	h=From:To:Cc:Subject:Date:From;
	b=quaHnSfvEKERvXPd9rRlhSG3Q3mrsgBDJKp16hQ/5ry14np9VmKgUExqgzqacxRrc
	 8sXsn3Xx1ha7x/aLJ/JxZ0rRLgUGJ8lTwO6JidM7jvjI+qpH4pA4vGrI1+SyykICok
	 /Wpr7PeLyR/BoiJOS0+PiUnZyN2PyT4myThCefw6z1K0O9yGva7G97rsa+ZjAZU/bm
	 dVGy5MnLBY9b3xVkdO1P10H8nWoJGlQl50D6rtRE7HDJEcW9EUBKQ9N/0ANWGGkwE0
	 MeuNsXAjj8KrP8RChN3Jx6mKNibNVo/gbt2kQwQft6zSjbwKYxriRDYvc8EmYA/h9y
	 1k3xKq+WpfDsg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next 0/3] Add Flow Control for Solicited MADs
Date: Tue,  3 Dec 2024 15:52:20 +0200
Message-ID: <cover.1733233636.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

From Or:

This patch series introduces flow control for solicited MADs in
the MAD layer, addressing the need avoid loss caused by insufficient
resources at the receiver.

Both the client and the server act as receivers - the latter receives
requests, while the former receives responses. To facilitate this flow
control, the series also refactors the MAD code, improving readability
and enabling more straightforward implementation.

Patch #1: Replace MAD's refcount with 'state' for readability
Patch #2: Remove unnecessary done list by utilizing MAD states
Patch #3: Add flow control for solicited MADs

The primary goal of this series is to add a flow control mechanism
to the MAD layer, reducing the number of timeouts.

The accompanying refactoring simplifies state management, making
the code more maintainable and supporting the new flow control
logic effectively.

Thanks

Or Har-Toov (3):
  IB/mad: Replace MAD's refcount with a state machine
  IB/mad: Remove unnecessary done list by utilizing MAD states
  IB/mad: Add flow control for solicited MADs

 drivers/infiniband/core/mad.c      | 212 +++++++++++++++++++++++++----
 drivers/infiniband/core/mad_priv.h |  19 ++-
 drivers/infiniband/core/mad_rmpp.c |   7 +-
 3 files changed, 202 insertions(+), 36 deletions(-)

-- 
2.47.0


