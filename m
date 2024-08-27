Return-Path: <linux-kernel+bounces-303340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3236960AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5341C22C43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D871C4620;
	Tue, 27 Aug 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Zl7YOZGO"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4571C32E3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762879; cv=none; b=tXCzAetHnImYqirsYL1L8SZJRzxm0sIZyOGcX8gJCQjHDflbCScpadpkYTsamddw22povyP30huG/5kFSXfQ2dc5lKl7MtDV/OnDXPx81m1AufsmzR1/9kWe4PLydoWzbuHS6giMC7Jlk+iF0FXz9hUWbm9PxMNCNpSkDdYcjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762879; c=relaxed/simple;
	bh=BkR66Rxn7CKsiWyF0wNqTkgsLKmrndjLEiy0BCV1+jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtpC2hX+KCbk4loVIJ/h7nINulE8W0bH2Ag2wYsCoHiKSt0vreUchws3aryfFT7vVMLwvnFfiIObzs0CTDIWmL6q0DS/606F+37s/tW3EUFuaNBLDG2zxZWC8z0jtyMaQf3JC6KzxnXTxIIl96mzNIwBA6d+KZEXEoShus5E8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Zl7YOZGO; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47RCleQ2021490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 08:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724762862; bh=Tdbr3erC3C87Tpj+QDL7eRkJIWDz+3mi2LufyrVfNDA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Zl7YOZGO/IslKoA8cjDhypYMDnbWqO/+nFzTMtkT0xg61I7dc1VqxDWqs63JGIOYu
	 p+ODCAioieveZ8MK6B5ToqZcgHIIvTuY05PKm3RZ5bmmZlz77KudXgdp6uhuNGAxvF
	 ey118KiSoasck8U+XKAl1Y8YI3KXjIBYF2rXgLzuWUF7B2WHIVvmH10zyBBasSg38e
	 iVU/ngR8zhIdyFPXFJsFt2X5pFsQFvbQPzV7r8bGFbjvr1junU9GHgWVqFUfSNvqJx
	 i1yZCu7gS+tyKsLsspnC6NsxkSjWIIvdI/DF9YDIm8CBje/1qyECIdlsD711Cwd+mx
	 IoK62EISz4fDQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B812F15C1909; Tue, 27 Aug 2024 08:47:38 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ext4: fix fast commit inode enqueueing during a full journal commit
Date: Tue, 27 Aug 2024 08:47:26 -0400
Message-ID: <172476284018.635532.11127658295639985238.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717172220.14201-1-luis.henriques@linux.dev>
References: <20240717172220.14201-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 17 Jul 2024 18:22:20 +0100, Luis Henriques (SUSE) wrote:
> When a full journal commit is on-going, any fast commit has to be enqueued
> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
> is done only once, i.e. if an inode is already queued in a previous fast
> commit entry it won't be enqueued again.  However, if a full commit starts
> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
> be done into FC_Q_STAGING.  And this is not being done in function
> ext4_fc_track_template().
> 
> [...]

Applied, thanks!

[1/1] ext4: fix fast commit inode enqueueing during a full journal commit
      commit: 6db3c1575a750fd417a70e0178bdf6efa0dd5037

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

