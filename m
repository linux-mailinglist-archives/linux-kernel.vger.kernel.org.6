Return-Path: <linux-kernel+bounces-317336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD27E96DCAA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B06B1C21EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8BD19E822;
	Thu,  5 Sep 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="W36AO+Ok"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF174148302
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548056; cv=none; b=TUPEx+aEXXXzbqZpIOxHw23I5lClfLNKuOIvom+KevlsBX5L11bKr+n1A37qhLRQaVvp6JuCl2bNq1ijOp7gPMEk/LNUW6TJ54vB2KZk8qygtLbppzKNpesZaEfgP93cj7zuZz6E/B3tkC714SXjXwygdyTpyAW61j+9FqVGlqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548056; c=relaxed/simple;
	bh=XHNWFsPO4rhOhjUD5kfeygL+CLo9i0mepp1M3cGnGrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oks3IwJ1X9gePW3+BPYQ4XNwW9LHFmXuF1ZiRlAQBkhQWlTkqYlZ3J5rZTtygP7jlT0R+CdnHc4mfAmA/KmHug7A5OQyE463WhmMZnCmIizwCPao1afCxD0NJNArTqQRFYw6H0pTJOdoV+oqI+TBvZ80Kb/5ts5tMCO4HnUDxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=W36AO+Ok; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485ErsAr004661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 10:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725548039; bh=XT9HRP1/P5NPb53sSdVf17ip7FShvNz7T2P4ENR7kg4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=W36AO+OkeEOYjBLCGHxy5leMVqtTaVb4yX2sXW7q77XUXr9A0G/UbPIh26J5WfdYr
	 QqTvAVc8ncKHnEQ9BylwuNkvzHkx8omJceHUolDxpRXRnbx73J9c4MCovAWtsmVFel
	 qdSO8mZ5aPNa+3G+GngPMLiXef30a+cmDjPU+mbTvPeI+Vrrz9sxYMlKmKVe0/smN/
	 C3Ij3Q7HgOSGaL9uoMwN0ckTzPZeG0QEpkloJgzwqecu4FcBhQnF2hM2K9Qn1kqz+O
	 t4iGXEnWHm6FSQFam47BptcdA1E6sNR7vD1e2lngOl54mIU0EFjVJnd7U+2xso65rz
	 SxOvsTNgHGZjQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DAA1115C02C6; Thu, 05 Sep 2024 10:53:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Artem Sadovnikov <ancowi69@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mikhail Ukhin <mish.uxin2012@yandex.ru>
Subject: Re: [PATCH v3] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Thu,  5 Sep 2024 10:53:40 -0400
Message-ID: <172554793835.1268668.9896908315159460691.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829152210.2754-1-ancowi69@gmail.com>
References: <20240829152210.2754-1-ancowi69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 29 Aug 2024 15:22:09 +0000, Artem Sadovnikov wrote:
> Fuzzing reports a possible deadlock in jbd2_log_wait_commit.
> 
> This issue is triggered when an EXT4_IOC_MIGRATE ioctl is set to require
> synchronous updates because the file descriptor is opened with O_SYNC.
> This can lead to the jbd2_journal_stop() function calling
> jbd2_might_wait_for_commit(), potentially causing a deadlock if the
> EXT4_IOC_MIGRATE call races with a write(2) system call.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
      commit: cc749e61c011c255d81b192a822db650c68b313f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

