Return-Path: <linux-kernel+bounces-248532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AF192DE80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E64283E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BA612DD91;
	Thu, 11 Jul 2024 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cH3ln0+U"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C57E0FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665364; cv=none; b=rv19CXyjWWciKfXKkA0RataUKizuf2owKft9Z2n6E/jDxZ+waSFfkEE7W1CBqHIp7mFcrD59NlGCV+5XiawrX3NT1TCcUufdd+5Gj5Ldi9lnQs+l1Nkn0DXlgSOBJSc5Uc/YQEYrl2achPqRGMcBsdF+X2x1OytdpV40y5RMwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665364; c=relaxed/simple;
	bh=epLTkZNOB6OpkoXyb/vPfcZKaaf97RXsYzo/nRMIFwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GA+Sq8MqqTBsLWsBtZP/SYm9eqdxlZss+g2kaYCXF8Q9go6FCEL84f0zqM+mIBhNCUNvwSsnP0/WryOIyVm4AoITm9s5CFCq4MYTNCVqVPOzxTSFAFjVJvLZUhhIcak9an46RQHTJ+gXghn/8VL4XKFSboFG52zFASE/jPuUdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cH3ln0+U; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-79.bstnma.fios.verizon.net [173.48.116.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46B2Zh48025438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 22:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720665345; bh=1w3gnNNj+MgpqZ4HN8mLNqi65vmXapOmEMa7QOsH+Fg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=cH3ln0+Uh/P3M1oL8TTJpn7qIjwfJ4ACuLuE/ikTn5bbaMAuU0EQQNVhuNRM+iarT
	 ZYwb9qo+fWgxRuZzKfE/C7b3ezHoyxMgwEe98PzeKYoKnUxnut/gl+Th5U2mGkY/3p
	 9Jvi7BOB3lmj1JuyBA/SkcLQI1ahLNEiNTnX/kw4k3LF8B/oz6QYGt1hd8oDvRjGe6
	 efOLIo2vvKc26QCUw71M6yWixErKGNiR5nutTNtvNLZI/cdPN8rlqAYhW838bai0qo
	 CQQ4v9yUJ2LvclsMDfrRu1xp3LPoNikYjFoTI1oc0lmWtcFCSGuz98ZekCVzswDCXS
	 FvLHPKVhjeDiQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D1E1715C18ED; Wed, 10 Jul 2024 22:35:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ext4: fix fast commit inode enqueueing during a full journal commit
Date: Wed, 10 Jul 2024 22:35:33 -0400
Message-ID: <172066485813.400039.14328785579752390326.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240529092030.9557-1-luis.henriques@linux.dev>
References: <20240529092030.9557-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 May 2024 10:20:28 +0100, Luis Henriques (SUSE) wrote:
> Here's v3 of this fix to the fast commit enqueuing bug triggered by fstest
> generic/047.  This version simplifies the previous patch version by re-using
> the i_sync_tid field in struct ext4_inode_info instead of adding a new one.
> 
> The extra patch includes a few extra fixes to the tid_t type handling.  Jan
> brought to my attention the fact that this sequence number may wrap, and I
> quickly found a few places in the code where the tid_geq() and tid_gt()
> helpers had to be used.
> 
> [...]

The second patch in this series was applied:

[2/2] ext4: fix possible tid_t sequence overflows
      commit: 63469662cc45d41705f14b4648481d5d29cf5999

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

