Return-Path: <linux-kernel+bounces-409399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6F79C8C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D5A1F21448
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BF73C6BA;
	Thu, 14 Nov 2024 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cTwXbS9n"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BF13C9A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592464; cv=none; b=ik16WeK59Qq/mjj6qCeZJHOmo344a6kIs1RixPhVtvOZEV/RsPQ2G2hh5vbT8rlRpTPrMk8MB1sG7VLaZg4ezD+O20NJOwLM5CJYD2gxPA14edslrNe5CPlFKNo+yFu4sWI8jzo7Y0RN5q8xyXJoEmBgJwFJ2uK6LW2hxH8ofy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592464; c=relaxed/simple;
	bh=L6N5FhuwBE2F2S22yNwm0iDjQbpPT3PL+f4NyRVv5fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs6bVJUyR+/uDvBxdbkm28UXBgX5PT4oet4V2iwUMKjGrgVXr/rYK2Q1ZK+QZHwwcGfTbWOAXOLHGAntfu/n+RAMRIAEHZzuRsP5vZ6Esaw098InKEfTcpXvNVzElOO9rpPOac2zgNGWAC3fcCHHxBfeIHJtWFpw3NotEJXj8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cTwXbS9n; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-132.bstnma.fios.verizon.net [173.48.113.132])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AEDrhT3001790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731592425; bh=I/bpU/3JaMKBLIpAqDqZFt1If3TckqGQ1I+wHfOwwBM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=cTwXbS9ngF+v6fsGGt4eU+3dE0CzHBB+6EhbJ+cU7isel4f56eMj8+X849pIZkoqp
	 JlYxbNfvco03IiPglZ7KLFSomSm7FxehEIhwgv7fgT3sV0FoZdhHiNU/Pl+bN7/IHY
	 J4DMHXSV2lVoQiICoRcAI/ZgpfC1tWBHn066hU7JSjzdtEQUzJ2iM0kRqkXLp+E1VE
	 DB7jabA7faoM64RegsgvRpZfacCLeVXH/O8k0fnbhvCdzrNR5Y9CXFUdCpT38aH0nV
	 d4/vZCoSVsbmzMQ4pZj+v/W9ATIEpMfnwZxTGnDyjE6J+6ve7Cd894UA4KmIbIgLch
	 ZB9gRQD4/zDmg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 41DD415C12DB; Thu, 14 Nov 2024 08:53:43 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: jack@suse.com, Zhihao Cheng <chengzhihao@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, chengzhihao1@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] jbd2: Make b_frozen_data allocation always succeed
Date: Thu, 14 Nov 2024 08:53:33 -0500
Message-ID: <173159220755.521904.4965154876627000163.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241012085530.2147846-1-chengzhihao@huaweicloud.com>
References: <20241012085530.2147846-1-chengzhihao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 12 Oct 2024 16:55:30 +0800, Zhihao Cheng wrote:
> The b_frozen_data allocation should not be failed during journal
> committing process, otherwise jbd2 will abort.
> Since commit 490c1b444ce653d("jbd2: do not fail journal because of
> frozen_buffer allocation failure") already added '__GFP_NOFAIL' flag
> in do_get_write_access(), just add '__GFP_NOFAIL' flag for all allocations
> in jbd2_journal_write_metadata_buffer(), like 'new_bh' allocation does.
> Besides, remove all error handling branches for do_get_write_access().
> 
> [...]

Applied, thanks!

[1/1] jbd2: Make b_frozen_data allocation always succeed
      commit: abe1ac7ca84236513a3d8ede02cc47584437f24f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

