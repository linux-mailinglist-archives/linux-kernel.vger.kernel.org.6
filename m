Return-Path: <linux-kernel+bounces-174615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D568C119B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281CD1C21A57
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D93AC2B;
	Thu,  9 May 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HBjKbI0S"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD813C827
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266900; cv=none; b=J8WWmrH0/lQDcNb/cNtWQIzVJQx2iHO6OabHCVeCTvgwukgZQ6v5KPCZ2EdJ3i6NYmKeKQlG4ucpdUgQdss/JNcejcowIh2A1syPlD6HJs18XbesIbzu+egTH8pZK2UH+MPFiOrw/rLijg1ucUDHk4cvqg/P+8l8y0j90TYefhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266900; c=relaxed/simple;
	bh=t8PqgycytqGvfh/83Ssgd6VEVvyTRRdNTUDR7Eqmht4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNDd5BQ7VI1QHEo8pY6V1WvvSCPwoYNYEn6wgyWYjRfASFyBb3sDMwxQj0rqWRQmJ6YcmpvPUwEAFKvjwD6g7HJABtwS0IbD30AGQwwHfKYMA15JV/ZTTjyDRT10A/7zlnZb29w3y19GbEWRubG/Zmg0XBaAEf72nxOrbODu6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HBjKbI0S; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 449F1Gkb032046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 11:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715266878; bh=loFoOBkAkkVCrsaTBPUVuK7k63DRhAG1Rjk227V+1mE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=HBjKbI0SoD3GS4bGBQ/9XOf73uLgqBBoQOUkLZHSCEFUVTCy2/e9foKKk/VnPEUyU
	 kK/0XFp1A/QaRZoqqhOk6Aw1Ud/STRLAOFRXJIlz3+5uMV5Oa5AEGqAtimgLKHaObX
	 L+DQ5B2PbSVJvj7BncZii7tXsC4serUMQtT5SfZRv5OFK1J2S979xpYHVi1b5nTSko
	 V8SxDfHuBTKfiKkpIo+Rb1vpm/EZZkmqul00tqtI46ZMPn12Vg7IaRNI1tfk7Z2PUI
	 ttsz83nlYgszun6cfiWCvHVqqh9NgSKF0DvXfMw2GK+4sd5FArrkRJhjofcPdTQUgY
	 JdPILP5sdEqsQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id F1FFF15C026F; Thu, 09 May 2024 11:01:15 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH] e2fsck: fix acl block leak when process orphan list
Date: Thu,  9 May 2024 11:01:13 -0400
Message-ID: <171526685561.3688698.1769581129271074581.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418063946.2802835-1-yebin10@huawei.com>
References: <20240418063946.2802835-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Apr 2024 14:39:46 +0800, Ye Bin wrote:
> There's a issue:
> []$~/e2fsprogs/e2fsck/e2fsck -f scsi-disk2.img
> e2fsck 1.47.0 (5-Feb-2023)
> scsi-disk2.img: recovering journal
> Clearing orphaned inode 12 (uid=0, gid=0, mode=0140777, size=0)
> Pass 1: Checking inodes, blocks, and sizes
> Extended attribute block 4247 has reference count 3, should be 2.  Fix<y>? no
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> Free blocks count wrong (249189, counted=249188).
> Fix<y>? no
> Free inodes count wrong (65526, counted=65523).
> Fix<y>? no
> 
> [...]

Applied, thanks!

[1/1] e2fsck: fix acl block leak when process orphan list
      commit: 4c2fb1cc1848790735cb6bc78b5dfb8a30d326c2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

