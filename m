Return-Path: <linux-kernel+bounces-303342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41499960AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED61F2843DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9981C4EDC;
	Tue, 27 Aug 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LfwYZSNX"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC71C460F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762881; cv=none; b=WUEF6nG65kwyDGRAPq9jBz5I2kfv5p1F8kWCfrJS25uLmrw19t4bSUqERz+kHuOGwyfs16fBvJZhpDjQ18SWeGLyiRcLUB6NDT3iHfASZlr1BezC6sD2oIYVH48cX8HHUNrigT4B+TQPJ4AtOzWKkxVvuMn1M4F8lWduByAI3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762881; c=relaxed/simple;
	bh=YMuWxOkb2NOwATeHQR4oFyPhSEVEzdOVjeqSC+oigo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyFgoEJG3LU4Se2nadGiyJ+DpCxNBfCSuRXw/CBOTEJG3aO4HgIglTcvkIl4Wv/r/96Rwx54EFZ5e3kAxbk4dF6TDrfQJHk27xWBvIXiSa6+FiDzYYvxZuEX8CSgohgK/cvaA0l682XLjzt1boUGquYPV5EAQE8vQ+G+vkyb+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LfwYZSNX; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClcpp021449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762861; bh=fen4ZU3aF/b0E8Xns2rJygiJI1vRstGMd3LUIA8G0UA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=LfwYZSNXCkd2ge0FzPE8jhiqxWRgxT69tF8iF44NWZdoIOxhEkoR5DMyg1/QunFEg
	 AW8glhTpTATZIkYtY1gW4upD55gLvK6jYpV41ra/SyibRDL0OcYxmHr0V2arTNiB5S
	 IJ1Atr2hUj6xZaJ+xdn2nSympCB/rG5wtH4BYrhghKrpsDhA43DknG6s2EwQUXWSJV
	 IKETwC8TLuljkqzCykGFCVp0jSdUtx3n8zb2Sk9zL6970ccV/TMDo/NTnhBeveTKcG
	 aPDahsr7HyFxjvq81+FjKuhHULV2zX8/MLPf1CfUz8ix1sOMt8iqs9GU0u7jk9iIR6
	 VfspdrToASOVg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B452E15C02C4; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix access to uninitialised lock in fc replay path
Date: Tue, 27 Aug 2024 08:47:24 -0400
Message-ID: <172476284018.635532.5641950219649503079.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718094356.7863-1-luis.henriques@linux.dev>
References: <20240718094356.7863-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Jul 2024 10:43:56 +0100, Luis Henriques (SUSE) wrote:
> The following kernel trace can be triggered with fstest generic/629 when
> executed against a filesystem with fast-commit feature enabled:
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 0 PID: 866 Comm: mount Not tainted 6.10.0+ #11
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0x90
>  register_lock_class+0x759/0x7d0
>  __lock_acquire+0x85/0x2630
>  ? __find_get_block+0xb4/0x380
>  lock_acquire+0xd1/0x2d0
>  ? __ext4_journal_get_write_access+0xd5/0x160
>  _raw_spin_lock+0x33/0x40
>  ? __ext4_journal_get_write_access+0xd5/0x160
>  __ext4_journal_get_write_access+0xd5/0x160
>  ext4_reserve_inode_write+0x61/0xb0
>  __ext4_mark_inode_dirty+0x79/0x270
>  ? ext4_ext_replay_set_iblocks+0x2f8/0x450
>  ext4_ext_replay_set_iblocks+0x330/0x450
>  ext4_fc_replay+0x14c8/0x1540
>  ? jread+0x88/0x2e0
>  ? rcu_is_watching+0x11/0x40
>  do_one_pass+0x447/0xd00
>  jbd2_journal_recover+0x139/0x1b0
>  jbd2_journal_load+0x96/0x390
>  ext4_load_and_init_journal+0x253/0xd40
>  ext4_fill_super+0x2cc6/0x3180
> ...
> 
> [...]

Applied, thanks!

[1/1] ext4: fix access to uninitialised lock in fc replay path
      commit: 23dfdb56581ad92a9967bcd720c8c23356af74c1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

