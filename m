Return-Path: <linux-kernel+bounces-549830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D6BA557B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B3E175E64
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1161FCFCA;
	Thu,  6 Mar 2025 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzJssaA4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E822619
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294024; cv=none; b=NQ1sgckACxFvaWTNFE/30mW+r3YYAbJI9SlM+MBEtTiciL0tDV3L1tGAOBP7Wjnzddokwlf0i4FbfC9K9Yv7kfqPQVVmBSmZsfyRh5AIqOSJFioqKD5p44oz6JTfobCN+Ccmh7MF21gm2D1tSSQ+i9SjEGpF1cj/j0zs0P40oaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294024; c=relaxed/simple;
	bh=GzcVtYLuIwXLiUH6fZgTvs8oVMg1+gDbgR6VTBxNxQE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QKTrWfnwiy1QVwEYMlIvw/89OxE55S7liTSLBAaj12CY4M8kNkjOFsTCdeuWCxYcWFT+Zrp/ZVDb6U62SMdPT4uOCiQn5NTCopIHi75Ms2Sf2d4I/SXr+qKwMg/b9zNu4uByNalFkhakXDmzVh7h01maOgAi6XGqJadrf9zYmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzJssaA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A85BC4CEE0;
	Thu,  6 Mar 2025 20:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741294024;
	bh=GzcVtYLuIwXLiUH6fZgTvs8oVMg1+gDbgR6VTBxNxQE=;
	h=From:To:Subject:Date:From;
	b=HzJssaA4Nzx3z2R/4738UEe1wTJb+w0CxYL6RJQze8NYIc4rMfz9dmIuwzR+Y4xUc
	 aRPkiNZILcVGc7c+FPUmyGoDEcl51dSuWhqCrfT07WuNOKA7AQZEgVQiR1u5xY3fGM
	 36euFrnzEhVAqDKRuX0aTdOp6AQzXt2Y2OxPDsfuht+3hJDCe5raWfbRysaeE9GMcs
	 J2UbYteLshONIHUjVhU/jRR+NmJU3kkIV9WNfECdHkceNjWOxUts/c3hlGEgwT0Vqd
	 cNN+xZJZzLNVmxPJcHNYUs3Smqz+o0XoyTEmnP8ZUvITxL+L9CVl3xR45TEdAPujzU
	 JJY/GYgyQxLKQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Keith Busch <kbusch@kernel.org>,Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,linux-kernel@vger.kernel.org
Subject: [bug report] nvme: fio workload hangs on 16m random read
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 06 Mar 2025 21:46:37 +0100
Message-ID: <87a59x6g5u.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi All,

My CI system has found an issue for the following fio workload:

root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme-core.ko
root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme.ko poll_queues=1

"fio" "--group_reporting" "--name=default" "--filename=/dev/nvme0n1"
"--readwrite=randread" "--blocksize=16777216" "--direct=1" "--numjobs=1"
"--ioengine=io_uring" "--iodepth=1" "--hipri=1" "--time_based=1"
"--runtime=3000"

fio will hang, some times immediately, some times after a few minutes.

I observed this on v6.14-rc1 and v6.14-rc5. It is not present in v6.13.

Can any of you reproduce this? I was able to reproduce this on real
hardware and in qemu.


Best regards,
Andreas Hindborg



