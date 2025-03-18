Return-Path: <linux-kernel+bounces-565404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72187A66799
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D83A7A3962
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834A1B87C0;
	Tue, 18 Mar 2025 03:42:12 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC11C3BE6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269331; cv=none; b=HUP06QQB+7qyD6V4aK5qfRXu9tg61ABz2SvDP6RlpKdyBr2JPmQ6Z9cyjj3Kb+GxbLbD6J8y9gwnFAKSobjOEAjcd0//GbShNLl89DoOWhNu5RwV6ZuB3dS/QXZlhDiFbHp4S9GfFivZr2x6w4nX+bhMgzhnueAG/ksFVk1JVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269331; c=relaxed/simple;
	bh=U8G6WZVRaxamwFTXA6Gw4yw7e43KAxhNqRrgS/BWFD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dw2Upyz58F0CE6xquPr6yQAXJmuR8NhlzT3Jco/EPARijeDGsBDJxBBhQRl/PVcVETogw+mxt1AHgTS/uZ7qbkGtpIigCPOKwnoGGM4zAsjsUErmwwvJNivqk6JQbkHS7pyGhe4bI18Sgk5xTgYf34o06EKVl4Y0Bs0BdEfzr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fmVt012151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E9D852E0117; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, yi.zhang@huaweicloud.com,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, akpm@osdl.org, shaggy@austin.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix and cleanups to ext4 namei.c
Date: Mon, 17 Mar 2025 23:41:25 -0400
Message-ID: <174226639133.1025346.8871872064546436882.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250123162050.2114499-1-shikemeng@huaweicloud.com>
References: <20250123162050.2114499-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 24 Jan 2025 00:20:47 +0800, Kemeng Shi wrote:
> v1->v2:
> -Collect RVB from Ojaswin and Yi
> -Drop some unneeded patches
> -Improve changelog in patch 1/3
> 
> This series contains a fix and some random cleanups to namei.c. More
> detail can be found in respective patches. Thanks.
> 
> [...]

Applied, thanks!

[1/3] ext4: add missing brelse() for bh2 in ext4_dx_add_entry()
      commit: eb640af64db6d4702a85ab001b9cc7f4c5dd6abb
[2/3] ext4: remove unneeded forward declaration in namei.c
      commit: e8eac9fc4832976af800628ba8cbd351edc7f841
[3/3] ext4: remove unused input "inode" in ext4_find_dest_de
      commit: 477aa77ccea451ce102ee77d1046304b95575d58

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

