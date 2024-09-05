Return-Path: <linux-kernel+bounces-317337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6A96DCAC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51989B253CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4019EEA7;
	Thu,  5 Sep 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DV57PgEw"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9D19E81D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548058; cv=none; b=Q1+bMIv5lzkl2YE3rYWUrcLVv+dYP+t+KGaeavNdK7CYPF34Dq1345g1+UufcokcDZj23RtkvR/cMnlyEwCn4J/O10NDH/CpV1v7TDhYCC9PCDPBUIJM6Rga2rJanETQixiuNXazpSTME813WqLJ0VFYSvECrJ52HeOMIEzXVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548058; c=relaxed/simple;
	bh=uofkn+W/RAMpSW0/e7yAhTNufcO4+0weyn7IllT16aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCVrN67bmmWos2vKKHRQsi5Qix1PiIW+XMA6Tf1Kn+fOiAwKg0/YIAS+aQLIlb4j2Ggm+C8dD6SwsZf4CL9tBxTqNsJwIj8R04eR1sS1GmWWxPhZmDNdGe8/7cDyShhc14SancD/LiB5J4nYCHdg2yltfZPKSNVjtoiLvXS6MEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DV57PgEw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485ErwiC004706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 10:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725548040; bh=+ZjrSw5LPIT+d2lxSZhJUnnHgoaZVc/cfxGde+6kys4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=DV57PgEwqVRlMpKxyAuW30CRuppKGq5eYnlmSdF8vdx8+f0+dTZRy/4h+CnZEFR9l
	 Cavg8f49SrogwAvA68IgLfkEhxIakT2kzGYOVYmDYMlzw5GNp0XsQqxllRFmlvllSm
	 MXL4dw4w6zJgZKB8U76LcnOGDYiSVSx+YcVgGWs7l0MciKzPXIew4ZZvkS+hKl6LX1
	 JXyS8Uea1/p3J7NWI5c28Czr7ypymjiXr2CvJ0xLiS7G6GVLtSFTd/O8IfSrVAZ80u
	 Cq4h7Ms70i2hDAm/UACjKUDv14WLigFLxV1+JokBxrmKtT5tOb4TqQVzm33Ofoz1Gc
	 60grhDt76ZEYw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E579515C19DB; Thu, 05 Sep 2024 10:53:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, harshadshirwadkar@gmail.com,
        darrick.wong@oracle.com, akpm@osdl.org, shaggy@austin.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Fixes and cleanups to ext4 ialloc
Date: Thu,  5 Sep 2024 10:53:45 -0400
Message-ID: <172554793831.1268668.270033706613826294.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820132234.2759926-1-shikemeng@huaweicloud.com>
References: <20240820132234.2759926-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 20 Aug 2024 21:22:27 +0800, Kemeng Shi wrote:
> v1->v2:
> -Append parentheses to function names in changelog.
> -Add "Fixes" tag to bugfix patch
> -Minor improve in patch "ext4: avoid potential buffer_head leak in
> __ext4_new_inode"
> 
> This series contains some random fixes and cleanups to ext4 ialloc. More
> details can be found in respective patches. Thanks!
> 
> [...]

Applied, thanks!

[1/7] ext4: avoid buffer_head leak in ext4_mark_inode_used()
      commit: 5e5b2a56c57def1b41efd49596621504d7bcc61c
[2/7] ext4: avoid potential buffer_head leak in __ext4_new_inode()
      commit: 227d31b9214d1b9513383cf6c7180628d4b3b61f
[3/7] ext4: avoid negative min_clusters in find_group_orlov()
      commit: bb0a12c3439b10d88412fd3102df5b9a6e3cd6dc
[4/7] ext4: remove dead check in __ext4_new_inode()
      commit: f7c69be505a5ec3df13b65cedb245343b2a5f751
[5/7] ext4: move checksum length calculation of inode bitmap into ext4_inode_bitmap_csum_[verify/set]() functions
      commit: 66eafbde7d74e36cd80e6b6246ea4bd599416e2c
[6/7] ext4: remove unneeded NULL check of buffer_head in ext4_mark_inode_used()
      commit: 7523a7ef099abe7b9a98c4c8f722fe40541c9723
[7/7] ext4: check buffer_verified in advance to avoid unneeded ext4_get_group_info()
      commit: 7d2b48881877ace14ea85a7e3a17ff8f80f3d8e6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

