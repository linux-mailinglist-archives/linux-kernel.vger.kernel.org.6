Return-Path: <linux-kernel+bounces-510395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22931A31C30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC187A1669
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CA91D5CC4;
	Wed, 12 Feb 2025 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTK4Ay43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7895F1CDA3F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328003; cv=none; b=nOljKy9IXPUL7eIy0IzW5G84I0mcDRF1dLPujDKvfOfUAcTFYQw4D/ARTXW9lr8TdmBrz0C22P8fWzri3bkGdIwygE4OPiWyMsQ2F5iD/xs6F2ARytFWzYQ+iokVSFeZNyzCpwfMI2rDeF+e5H5cEgphdzuxUqRcY/NPdFQzBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328003; c=relaxed/simple;
	bh=qCqjKDkgcJ9MTQY84WTCtp38UhKYa6ZgpJr4unZFVtU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qq0prhKOGCMGKDJ/xzGbTiXIuZ/DKMeu4G+kxCuFNDgc+5Y2XAAjWD8lekpqppsIggxeQn7oMJRNPy3Yo1kygR0zUpMkhtiTz5ktHyeTY3mJQMM66JBGAkLQxeumGG94lqbdjRIQcudWJ1xaJnTZjE8sJmOUlMd5BCaormFO6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTK4Ay43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFEAC4CEDD;
	Wed, 12 Feb 2025 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739328002;
	bh=qCqjKDkgcJ9MTQY84WTCtp38UhKYa6ZgpJr4unZFVtU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tTK4Ay43kUqtrBJl7vMg8mVzH7+9t+lhzK5y2Z9LIeOLOVNR+xSh0fNVcujXn+EP9
	 n2pCBhaOw4TXM2LDpgBb5+Ew63guS85rUlAW+BeZiwScbFrVgT9uOVgk7Bbie3TeSH
	 +u9QyXCMdvDadvlXzj/IOLydnveTxUk0EhQHMvfOwXrc76TOQtiExS57hxgcmOLDZp
	 Ym6h7+f+k7ssd6AQSyST28/TJtFf9MMcHf3zKkqu6WfoApfuzS+8hRTUWFBW6sszji
	 Sh6DjAJ9l3M01DzaEW3J3ZqnxCo9MyX7OoR6/57J7rwopmtFuPPWvfQp4fXQdqtXPN
	 CWrMG0ncsJVNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB854380AAFF;
	Wed, 12 Feb 2025 02:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: don't retry IO for corrupted data
 scenario
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173932803180.78500.9143356682528307382.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 02:40:31 +0000
References: <20250212015413.666375-1-chao@kernel.org>
In-Reply-To: <20250212015413.666375-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 12 Feb 2025 09:54:12 +0800 you wrote:
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: don't retry IO for corrupted data scenario
    (no matching commit)
  - [f2fs-dev,2/2] f2fs: add dump_stack() in f2fs_handle_critical_error()
    https://git.kernel.org/jaegeuk/f2fs/c/4f91f074702a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



