Return-Path: <linux-kernel+bounces-400599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111659C0FBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F56284A5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19493218D89;
	Thu,  7 Nov 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPh55dgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7150320EA3D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011440; cv=none; b=NBN5SxyTbVnwCeghTqm1B3Addcq92PyNY37s3bUmH0tI65YyIFQPlLD+6lBIzmOQ5BdJCnFA33rwRUBx6m9f+1WEP+gm5YhBuyccff0Ce1KEPvuz7sOshifvufcs2e9/EiwCL8KF0dIMYV+rMXbGp4sT+D8Q/VxUIMt8K2BDHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011440; c=relaxed/simple;
	bh=heoiBxP1nTthFD5q0UEdFf6g1XaL9Ti1foNVJFXQd30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e1nGvNykKcJd3MQrcgE1azPpUz8/P5B7XmjOyyc8Nu0/F65KlJqu4MP6n84OMa9Z2t6JXgSxkerr9fV/DJrc6K3DkMydRRfBJNTjtKH0VFxit7QRZ0DoGUbcco9UaHNMaJklBlxFTGGDQji690O1zxU7YB6ZnEhCSUi0Q9hsnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPh55dgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08466C4CECC;
	Thu,  7 Nov 2024 20:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011440;
	bh=heoiBxP1nTthFD5q0UEdFf6g1XaL9Ti1foNVJFXQd30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FPh55dgxYDTP3x6Wn584mBnHL7G3psJEcftGuNLECYo6DTC5DyewpEVvUvYEzd7HY
	 1CbKtgg/fdcUQP0GiGFjKwgaLcc3yZFUZ5gHBpr2XMf4ssAWN9GVp2aXc7vlKJG1Dr
	 zz3yZ6/nmNeZjV0T+aLU9QYnaW8h7VB2IdZ8dULTpvaoC5d4zGI9QBNA/zRQB5YL9a
	 JRr9HvN4L1lFArBls5g3skjnhIPbCaqbBoBg+pZeG126z8fcwNL9CKZAWXxMjT8rDK
	 bqIRCX6TAEePkXRsHOJch6Syn1rS2mZ462Zdm3EcHYgaupLADS1NhxNTwXCe686WNH
	 6Wqvg75ZVixvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71A543809A80;
	Thu,  7 Nov 2024 20:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to convert log type to segment data
 type correctly
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101144899.2084993.8424317066290373281.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:48 +0000
References: <20241030081701.1853020-1-chao@kernel.org>
In-Reply-To: <20241030081701.1853020-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 30 Oct 2024 16:17:01 +0800 you wrote:
> This patch introduces a new helper log_type_to_seg_type() to convert
> log type to segment data type, and uses it to clean up opened codes
> in build_curseg(), and also it fixes to convert log type before use
> in do_write_page().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to convert log type to segment data type correctly
    https://git.kernel.org/jaegeuk/f2fs/c/51d3d952c508

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



