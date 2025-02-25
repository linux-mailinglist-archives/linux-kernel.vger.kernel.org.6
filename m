Return-Path: <linux-kernel+bounces-530735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB86A437A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF151188B5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A1825EFA2;
	Tue, 25 Feb 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7Xih5up"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3781727
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472227; cv=none; b=Sggn4wjthJIht73x6feH0pMHtcOIyQ3/0eZ1zPlbABlICpVDoMtvAVnJH2TNqlAeUWkjNvcg9jtxR9WwXFvnYGI6ppDftxrTbhcXSu7naI7CySnQmF2RDRDdn2j9lu1Hm8oh128KYIF4Fanws5Tysk3j/AGSE43OTHHJJSqLbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472227; c=relaxed/simple;
	bh=oZsoK1cw3ClR6Nvp43TWcRmZZIKhQh28C4n1vCWF5FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/pWlrUh7NP54AgdRNqjBVCSUa6wGADeb8Gg+F1R3Xm4ZFApLLAwNbi7HYWdyyxRrxOMVxtLAjLM15ppUrnu7RtveNgNuQSny1PbWQaDJTuimm5tZfnCoHxEkg/cNuolzVc+hu7T//ag6Nk2yHAANqgn8RFP1kQDpuwEkU3fnJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7Xih5up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA6FC4CEE2;
	Tue, 25 Feb 2025 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740472227;
	bh=oZsoK1cw3ClR6Nvp43TWcRmZZIKhQh28C4n1vCWF5FQ=;
	h=From:To:Cc:Subject:Date:From;
	b=A7Xih5upTi0RucZKSZsjhlhz9rIPqa/Ksxxu4SG2hoCyDAmzzfT8bkidF6R7K3VL9
	 MIMb+0nYi/yL84ZRGq+miuincj+Sg/slYoEqTxsrjFye/hLYlqHM9wOKGkWhnsnqpr
	 q1qtVk0HDFbaBxmnqgLwRPJOYQLl1TXkdFJSnTCqL/fnU0VA5hLSq9YCueSV+7LFJq
	 AH+sPfRdsEN6jc+05/mZVhf95l3jc+nBTaxFQOpG1j98wwwPvR66tJXX40hmZ0edSZ
	 ara+y/OnhrdZmSjl7+W+/aFg2phpjUpJbfqSARDtLoRoZgUKTnnfoS5iokDy+n0Ilq
	 9yMJ4xcU9cKFA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Frank van der Linden <fvdl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable 0/2] mm_init: rename *init_reserved_page* functions 
Date: Tue, 25 Feb 2025 10:30:15 +0200
Message-ID: <20250225083017.567649-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Following Wei's comments on my patch that renamed init_reserved_page() to
init_deferred_page(), I think it makes sense to pull that patch out of KHO
series and merge it now.

To take into account the refactoring of that function in mm-unstable there
is also a patch that renames __init_reserved_page_zone() to
__init_page_from_nid().

[1] https://lore.kernel.org/linux-mm/Z71z9fO6tE5Px8rT@kernel.org/

Mike Rapoport (Microsoft) (2):
  mm/mm_init: rename __init_reserved_page_zone to __init_page_from_nid
  mm/mm_init: rename init_reserved_page to init_deferred_page

 mm/hugetlb.c  |  2 +-
 mm/internal.h |  2 +-
 mm/mm_init.c  | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.47.2


