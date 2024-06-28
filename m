Return-Path: <linux-kernel+bounces-234285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C513491C4A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC9E1F22DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236061CE0AA;
	Fri, 28 Jun 2024 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gp6vUw2J"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18361CD5A9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595099; cv=none; b=eUDqv3G/tg16oBwscIhh6HSIvPnh4fxoFBc7A/aNDWIWF7nNA5DzmOpbLPOBZYD30aFivinj56cGOHxCrbNxGCZKERv+qOvN8oqokwA6xuhM5kEuWJm8hYxKJg9tjNNJpaJObZGdBW0IIwP9G9kzN48pNv/rMMY217OtL++suvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595099; c=relaxed/simple;
	bh=9U9k9NSLSB1eaU9tAU7rHEi84QCAIMfQDGygGimoTTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwfbBgB1W3B/5c7Tw0n2GgfYiI58/BkO/2VPGftP8zCDREmjajgT4zSYX8iMa/9I2V/d7Z0iVhqDGiqT5CmT7tUKpDjaHnK1gF/pHpTwj8ianUf7GDZaJcFLoq+1EYlfX2FcmH8Jffpx0puCjqbb1gXf0Kb8Xuc6G55kRqMRUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gp6vUw2J; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-63.bstnma.fios.verizon.net [173.48.120.63])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45SHHtdM024132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 13:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719595076; bh=Fk2dZVoYeN9for80TCHwR5kaMnR/2N5A+vQVBu9xFoQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=gp6vUw2Jyd32+ukMpFeLhaVktJEa/1LANd4FcDn8XUH2j9Nd24oxrx9VjWIH4k9WS
	 IZLFWTIGsJT5shBCo97hqiOXeZLBaL85fjzffoVqWxZq48K37wpGhc8T3h29BKRBLy
	 pps2EGKmFCLxOdWSzcqodhcqXk67wSAh1J+ES0OMcidh+5eXcBmP3qO+UQFbPeDgFc
	 nv0SJWMGM+bHm28bbL287H0DOLkLt1zm1VKivEmFbymuHkCExjDUKh/JisxVuDvpJx
	 XbuSlRNae9WDPUdq1qm+ognNq9kCWWiw2V2AOXxnCME4KSDTFcsy50Dqi0aqSLEWTe
	 tbLMIKn2MzKHw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D6E2515C02D8; Fri, 28 Jun 2024 13:17:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: jack@suse.com, yi.zhang@huaweicloud.com,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] A fix and some cleanups to jbd2
Date: Fri, 28 Jun 2024 13:17:48 -0400
Message-ID: <171959506218.737463.5581686485417028321.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
References: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 May 2024 19:24:29 +0800, Kemeng Shi wrote:
> v1->v2:
> -Collect RVB from Yi and Jan
> -remove rename "flags" to "escape" in patch 2/9
> -goto new copy_done tag in patch 4/9
> -add more comment in patch 5/9
> 
> Patch 1 fixes memleak in jbd2_journal_write_metadata_buffer.
> Patch 2-6 contain some cleanups to jbd2_journal_write_metadata_buffer().
> Patch 7-9 contain some cleanups to kjournald2()
> All tests in "kvm-xfstest smoke" survive. Please let me konw if more tests
> should be ran. Thanks.
> 
> [...]

Applied, thanks!

[1/9] jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
      commit: cc102aa24638b90e04364d64e4f58a1fa91a1976
[2/9] jbd2: remove unused return info from jbd2_journal_write_metadata_buffer
      commit: abe48a52250a91f0d1f9b5052a246c63cb845827
[3/9] jbd2: remove unnedded "need_copy_out" in jbd2_journal_write_metadata_buffer
      commit: 5dd3e8c0758a7c7a8c8f3002b2632a3c9d31c808
[4/9] jbd2: jump to new copy_done tag when b_frozen_data is created concurrently
      commit: 4c15129aaad54af2df4665ddde9245788ee9fa9c
[5/9] jbd2: remove unneeded kmap to do escape in jbd2_journal_write_metadata_buffer
      commit: daabedd664021afa9e7e3225489888a4fee99bad
[6/9] jbd2: use bh_in instead of jh2bh(jh_in) to simplify code
      commit: 4eb9bd13eba3c168e91460972a76ddd53ac3b2b0
[7/9] jbd2: remove dead equality check of j_commit_[sequence/request] in kjournald2
      commit: d5c545735aa0d6443460ac407d35f8fa235d5102
[8/9] jbd2: remove dead check of JBD2_UNMOUNT in kjournald2
      commit: 136d3e0703e807b14ed6f9b8a5a544b6ba08d940
[9/9] jbd2: remove unnecessary "should_sleep" in kjournald2
      commit: b07855348b305c234d9fabb7ab9b50fa9b3a7759

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

