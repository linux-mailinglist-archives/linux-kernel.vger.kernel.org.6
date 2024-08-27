Return-Path: <linux-kernel+bounces-303341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F6C960AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5881F23818
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE001C32E1;
	Tue, 27 Aug 2024 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YKsgfo8j"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4021C32E2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762879; cv=none; b=gDVraZbn3HAqVU37tggARxRPPakCio5gMPEYgiBXp7XoVK/8eJpuO30yfEZhdqhQs1vZb07dbxeOcg7vmJlYbs7SMZMVJkDSJ6sP7dZH1ZaOOxbq4kmawU3GT5YTbL2E4/Fv+wI4DIZ/Cd/b2cyJYE3k7yABusw9dCsu5PcCDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762879; c=relaxed/simple;
	bh=7I1mBqcXNKZEj9BJzUMFaqy9CkPZX/BhvH6llfgAerw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbJpR99TmT8jS58KqugoepxsVf6mcjfnPulijGDLGr4ldwGHLBR5wM9wctQ9ddj+KDofSLXJcqVLikmjc+BisGvOJMUCc3wCqvFmSzochTrOeEKQ37vNXGuXu01Z5H7/LfPLjBqxc6PUtIYT42qXLmXC3gykN5myIVvA/MItqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YKsgfo8j; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClf1p021522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762863; bh=LkuTiRnN0lgRW1b0F5EDli1YrkjxjlhcpjmBj7UtKMg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=YKsgfo8jFDZl4x9wjjcJvv/bHipg49C9GAd7Gq8775U8uuo7I1PKRTIiuapfb4Hks
	 4g6+gtS5yNub6w6XOej7huRUfO0jbEL97rZHUQzEewQE6Y96eimtCn3watpiTYX6eb
	 3BqxOOtfCmDBj1Qp4BWSlbw2gW+z87EfnIF2LFAdPww/zOOTyBgrwrxgLdeEgvINav
	 rqiSJtypaKkpkxxLiX8bqYunV//bRudRA4RpApwaCNvbvPk9VyQMmDgr61lOW3w5QY
	 sEyOStoC0u2s+mWaJtTh5oQavOnqUDSQppNBxvIP3BuX61FK60DXoOXthAjH3cD70M
	 IQ6IgxxUydZcA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BF69915C19DB; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: jack@suse.com, Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] Fix and cleanups to jbd2
Date: Tue, 27 Aug 2024 08:47:30 -0400
Message-ID: <172476284022.635532.14736376110407753656.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
References: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 01 Aug 2024 09:38:07 +0800, Kemeng Shi wrote:
> v3->v4:
> -Collect more RVB from Yi and Jan.
> -Use correct subsystem name "jbd2" instead of "ext4" in patch title.
> 
> v2->v3:
> -Improve patch "jbd2: remove unneeded check of ret in jbd2_fc_get_buf"
> -Collect RVB from Yi.
> 
> [...]

Applied, thanks!

[1/8] jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit
      commit: f0e3c14802515f60a47e6ef347ea59c2733402aa
[2/8] jbd2: remove dead check in journal_alloc_journal_head
      commit: f2917bda8a5c97be41c34e7761863a724097cf91
[3/8] jbd2: remove unused return value of jbd2_fc_release_bufs
      commit: fa10db138d205362026daecc8ea65d4e339ade00
[4/8] jbd2: remove unneeded kmap for jh_in->b_frozen_data in jbd2_journal_write_metadata_buffer
      commit: debbfd991f0116a8e88b77f08d231c57a1207dec
[5/8] jbd2: remove unneeded done_copy_out variable in jbd2_journal_write_metadata_buffer
      commit: 7c48e7d5a195fc918f9ab281390a5ba4b3e18022
[6/8] jbd2: move escape handle to futher improve jbd2_journal_write_metadata_buffer
      commit: f47aa3ebe3f4ff5ca4b9abfdbb71d7b775bb0c44
[7/8] jbd2: correct comment jbd2_mark_journal_empty
      commit: 1862304b062acb15e05b4e51270dc92de4b7635b
[8/8] jbd2: remove unneeded check of ret in jbd2_fc_get_buf
      commit: 6140ceb9b224fd178f405a7805d3fd82d2d02c39

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

