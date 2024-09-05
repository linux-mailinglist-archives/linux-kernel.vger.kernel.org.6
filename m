Return-Path: <linux-kernel+bounces-317345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B7296DCCB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6E01F244B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D719DF5B;
	Thu,  5 Sep 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Zjezu1hE"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24319DF4F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548176; cv=none; b=UAokaz+IzxsgqhnfHtdshrVcreri3y1mQms0+kTjjUkrjCNAxA9X8/2Ti3XHpy/1rgcFyN8bZ4gqXZEhFNPTVG0dvNimWgJEqyuARgzg0xjQVW9Pdb/qz7/CNiJhswPbdCG/7bcUtRhYG0p2rg27mWq/c/S7p/crkommGv1yxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548176; c=relaxed/simple;
	bh=Ya3cBxkk6orVw2MWHjOg8FFcFpxOwiWe/W/gs0aki1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tW91jFQW2saIrjxTDfbAF0rDraNn2cw6kqVMzQivEn24Rg2PQveQ6vWxKh4KyU46NNUi/RpxHIuMmktnHZNrPUBcQ4YxXQczIqUFrXYmyPgO1B90sudz3opmJSHPJfqIr7dt2z7DRdIZ22VTBHeZhKlKbZ0Bd7SIIA1bqq9HAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Zjezu1hE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485ErsM9004662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 10:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725548038; bh=HSvQunN0IACnXxtuRnogevWBC95tWsgiQrZ2YAw1pak=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Zjezu1hEroRBvnodNhcSTPjNt8G6bcMM0vXYA2YqhNtw/KqxzGe07el6Jgi00Mrir
	 1OPUZESv5E19pHEk2WGOK2l2wLowGleByLmcRk/Y/IZ5F9bn2Kct//rcCZhvOzYGo5
	 ugHmxcrmedoPH/8Vq+383++miTYD7u64TGjnIX6vjtQt7+aIeYSArry87X/c7etAms
	 idtPfLeHLhIRhLIIuWgDyH5SRkum++I0+a3Q7wRkz41Dzk96eHeDdUw3giY5VkNYCM
	 YSjcIEQZnFU7j899vmukcSRm7iSJTv4FzdrISLiSFrRlqiBphW25/wxj3UEah788Jd
	 mMOVXvM0IhXkA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E364515C19A9; Thu, 05 Sep 2024 10:53:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Kemeng Shi <shikemeng@huaweicloud.com>,
        syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] ext4: Check stripe size compatibility on remount as well
Date: Thu,  5 Sep 2024 10:53:44 -0400
Message-ID: <172554793836.1268668.15514751262481415081.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <3a493bb503c3598e25dcfbed2936bb2dff3fece7.1725002410.git.ojaswin@linux.ibm.com>
References: <3a493bb503c3598e25dcfbed2936bb2dff3fece7.1725002410.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 30 Aug 2024 12:50:57 +0530, Ojaswin Mujoo wrote:
> We disable stripe size in __ext4_fill_super if it is not a multiple of
> the cluster ratio however this check is missed when trying to remount.
> This can leave us with cases where stripe < cluster_ratio after
> remount:set making EXT4_B2C(sbi->s_stripe) become 0 that can cause some
> unforeseen bugs like divide by 0.
> 
> Fix that by adding the check in remount path as well.
> 
> [...]

Applied, thanks!

[1/2] ext4: Check stripe size compatibility on remount as well
      commit: ee85e0938aa8f9846d21e4d302c3cf6a2a75110d
[2/2] ext4: Convert EXT4_B2C(sbi->s_stripe) users to EXT4_NUM_B2C
      commit: ff2beee206d23f49d022650122f81285849033e4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

