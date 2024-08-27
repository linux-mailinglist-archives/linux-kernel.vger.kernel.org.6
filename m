Return-Path: <linux-kernel+bounces-303339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D2960AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59431C226B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A2D1C3F34;
	Tue, 27 Aug 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mn+F7tuG"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5001C2DC6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762878; cv=none; b=K/lCqZblcpZboHxxjSVIjJb3vdWTYUAzof+O5qRe5D7z9RHwUm4avvHbbrOMOFU/i5eDl/AuD6/N6VUtYwkjJtzac2gd7S1HWcfnwMW1pd+zKC1ETaReBIbNGXWrkAqE7KsO7VQpAKzfY8G+W0AJdKmpuIYyIGwNhZmAEWiWHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762878; c=relaxed/simple;
	bh=XY55OP/Qaf/+GGoLt+wyLwHxCnZpJqmqZD87P/VbmMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2u63kASo17MTctA3mz4Ke+ADiL7Qw7F6l8snPA7PTymqrvvedxIjqX6s1xtNzu2fSh2a9eLOb+yElLS9enjrDTAhzIEX0HZPEYn2KJbjIhhhJ73re6YE5jN6TVHoj9u0jg6J3fLndldtaiKe35rIUudD5quqpQaxBFDlsuTPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mn+F7tuG; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RClcV5021450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762861; bh=kATzU0mUDcZgfUdBUscSr/30Gq0bulmJCImH68vNTqU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=mn+F7tuG399axBj9ZMiuFpomzq8yusuKSq0Iw03YRexzYvPcPN8JINm5C1yO7VfQY
	 PULIj6vUCbimY5RqZ/WtAe2ET6Znb+WaL5Lb/8NL9Pj8No0GftxTnyFeZqZQ/eEtfS
	 tJFT939Wb94SD8np5d/VIdj3JMqtafsn7osXPjeYP44P/KTJKlUEWmoAx6useSczIE
	 MYA2HXMokT8Kn9Hj3/V1Hrs4X746cAXGHFOkv47U4U8k8moLj8Pn8OH4UW4toQ14aM
	 xh71juTJmguCRNT9y1rq0r1kweQ9x/F4xjeTeYbFf0ebymBvO2q5tPDLird1HOYKkg
	 5epgKK3shIQYw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B639215C02C6; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ext4: fix incorrect tid assumptions
Date: Tue, 27 Aug 2024 08:47:25 -0400
Message-ID: <172476284020.635532.250077897780132368.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724161119.13448-1-luis.henriques@linux.dev>
References: <20240724161119.13448-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 24 Jul 2024 17:11:14 +0100, Luis Henriques (SUSE) wrote:
> As discussed here [1], there are a few places in ext4 and jbd2 code where it
> is assumed that a tid of '0' is not valid.  Which isn't true.
> 
> This small patchset tries to fix (hopefully!) all these places.  Jan Kara
> had already identified the functions that needed to be fixed.  I believe
> that the only other issue is the handling of sbi->s_fc_ineligible_tid.
> 
> [...]

Applied, thanks!

[1/4] ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()
      commit: dd589b0f1445e1ea1085b98edca6e4d5dedb98d0
[2/4] ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
      commit: 972090651ee15e51abfb2160e986fa050cfc7a40
[3/4] ext4: fix incorrect tid assumption in jbd2_journal_shrink_checkpoint_list()
      commit: 7a6443e1dad70281f99f0bd394d7fd342481a632
[4/4] ext4: fix incorrect tid assumption in ext4_fc_mark_ineligible()
      commit: ebc4b2c1ac92fc0f8bf3f5a9c285a871d5084a6b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

