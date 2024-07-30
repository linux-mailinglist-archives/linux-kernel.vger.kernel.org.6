Return-Path: <linux-kernel+bounces-267655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB78941401
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261B51F24C81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6E1A2575;
	Tue, 30 Jul 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozLpGhYZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F41A073C;
	Tue, 30 Jul 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348667; cv=none; b=DS7aewoyCXb0Q4njUwfeKQ86elj72bZK0zMufz0n/zIEpCCit02mpk5QN0qnkvt+XAfmRMlOPdLdDBhiwpTZcz80ymy4kTjMEdsqsoIoVpZi/D1G3NccnYwn2sho7YBg/i3su/wlRnTrhwN2jFmcEhGZDZL6NAZAsslMTCLXsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348667; c=relaxed/simple;
	bh=NXSW+Ww4qnog5Wakb9vB7eNj7FiGI0hJ4qlSFMOdIis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPT7yiIMZ/SxHJV+6N+rmJpe5YOCkVhx4q3MXmif++qNmPzDny3KWZjTBYKdv0mzxeOWQicjSdSNeSFHdfYxdn4JoGnSR2wIUBCmVAIkgRDGVY8J+s+KyvqD4xwxhDvy/93cCI5Tsb2I26+amUGaPsP1CPukbzSU9pLaEKm++us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozLpGhYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7FAC32782;
	Tue, 30 Jul 2024 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722348666;
	bh=NXSW+Ww4qnog5Wakb9vB7eNj7FiGI0hJ4qlSFMOdIis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozLpGhYZBO6f+OrxkhcxLN8vWcBKBQFGwrRpMExe+1K9qNn2Yh+nQaGW3ECUqOVXV
	 cO1IMg5JkySVBUfURubNl9MIiTpq/YFSAwKijWsOB4yYP4cK9Sq/ePdkOySk4Hd/jG
	 7cBtRHxIZSKc568DR9Hk7y/rIjkAPg33TEhPmfhbKIn0tUizsH4p3mlyNquLGv3Ess
	 71t9viPqmMiu41zocV9T5RFYuZrrt4FM1f6nn5IFjkv+rWk06wejahoKFH16v7wPf1
	 +0pK2eaDzzYINz7v7oQJFA8/L8nXeICFkfuRNvW2IFjwUpRlQBMxRbXIfnsPXM6ZoC
	 F2ykVF+8UaGyw==
From: Christian Brauner <brauner@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/aio: Fix __percpu annotation of *cpu pointer in struct kioctx
Date: Tue, 30 Jul 2024 16:10:53 +0200
Message-ID: <20240730-halbmarathon-galionsfigur-8cd5615a4f7d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730121915.4514-1-ubizjak@gmail.com>
References: <20240730121915.4514-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=brauner@kernel.org; h=from:subject:message-id; bh=NXSW+Ww4qnog5Wakb9vB7eNj7FiGI0hJ4qlSFMOdIis=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSt+FKioz99g7KTs9tKH5FtJcck17dnsgr8fZ/t48GTs XzrJNvSjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkEtDIy7Oiw+MmSGa39uv/b MxdF0fAfz37ar172ctqr7LBJLk4q2xj+Gb1oPfxqjrxTWFOKqjpHm/OTjbf4//8+5tz5RvD1l3U HGAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 30 Jul 2024 14:18:34 +0200, Uros Bizjak wrote:
> __percpu annotation of *cpu pointer in struct kioctx is put at
> the wrong place, resulting in several sparse warnings:
> 
> aio.c:623:24: warning: incorrect type in argument 1 (different address spaces)
> aio.c:623:24:    expected void [noderef] __percpu *__pdata
> aio.c:623:24:    got struct kioctx_cpu *cpu
> aio.c:788:18: warning: incorrect type in assignment (different address spaces)
> aio.c:788:18:    expected struct kioctx_cpu *cpu
> aio.c:788:18:    got struct kioctx_cpu [noderef] __percpu *
> aio.c:835:24: warning: incorrect type in argument 1 (different address spaces)
> aio.c:835:24:    expected void [noderef] __percpu *__pdata
> aio.c:835:24:    got struct kioctx_cpu *cpu
> aio.c:940:16: warning: incorrect type in initializer (different address spaces)
> aio.c:940:16:    expected void const [noderef] __percpu *__vpp_verify
> aio.c:940:16:    got struct kioctx_cpu *
> aio.c:958:16: warning: incorrect type in initializer (different address spaces)
> aio.c:958:16:    expected void const [noderef] __percpu *__vpp_verify
> aio.c:958:16:    got struct kioctx_cpu *
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/aio: Fix __percpu annotation of *cpu pointer in struct kioctx
      https://git.kernel.org/vfs/vfs/c/b484eca083f7

