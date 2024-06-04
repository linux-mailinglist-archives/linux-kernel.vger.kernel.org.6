Return-Path: <linux-kernel+bounces-200004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545ED8FA91D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091041F26882
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6454413D2AA;
	Tue,  4 Jun 2024 04:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpVI0MWG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523E8C1D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474892; cv=none; b=CB54V1Peu3C1ioIaF1HIsng/tYUrWplwhuH+TKSnvjqBaUNtjWXAyZw8WYnSzfcLmegNf4OKGq8D/GeqEADuZ8DymjP5Mi89zte4kNUd1XB5uhcPdiG/BBZl8qINZBfTjP3c1JfuOmu+HJozTbPLlBIszfoIYJFVWuF5WmPz/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474892; c=relaxed/simple;
	bh=WB96U8psVIt6mbqurUhHZdffu9nyfOCHtJ4CLQlAbng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbQGH1Bh0NzPKstiyW+QKtstDY4m9lA+st03G8HsqCy5xPGEGZJdXxdEaHorysOioF7foFyMUiEd1oI6cM/Ea2S/qj0IsDNih86zi7F2h529+OKbF3/dw34ji0omoBDFN4+wRn2lALmP7+14idDPxNCS57Hf/y6mLBD3BZF60wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpVI0MWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65FDC2BBFC;
	Tue,  4 Jun 2024 04:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474892;
	bh=WB96U8psVIt6mbqurUhHZdffu9nyfOCHtJ4CLQlAbng=;
	h=From:To:Cc:Subject:Date:From;
	b=UpVI0MWGFrpsXplgU/n2fwK4ELaQ+xo8GHRLZJJzpQiGlCsZ3Am8B/S5R1OhvYTqE
	 qS0bo2QQMWm+bFkuKkvJV3WZRhYPQ5fjr34Q/7UWqc3Y0Ud2ZdCTXa4ezziGs5JyLg
	 ZwwwDAlJC/0fsMkdWh+fDA3xeX+grM2aPQO02UKjzYO0c5j0Hp0lmsymA/lT2t2T8L
	 w4H8ygWBW4dWEMlAkb2QX3RmhavUlH5yvA2Wvju42JJ4aVxk3diICbR6+XO/gQA0Zv
	 0Rrew7nzYrgVeO39VBYc1Aal+LAlTKMNG/gwsYYF2dyrcpXS92ssxJ+mzUKktRWUex
	 kSDDbQHAR0Ang==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	izik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	chrisw@sous-sol.org,
	hughd@google.com,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 00/10] use folio in ksm
Date: Tue,  4 Jun 2024 12:24:42 +0800
Message-ID: <20240604042454.2012091-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

This is the 2nd part to use folio in ksm, it saves 82kbytes in ksm.o and
passed all ksm testcases in kselftest.

KSM still split same folios to single page if they are good to be KSM,
but will skip the rest subpage checking if a folio couldn't suit for
ksm.

Alex Shi (tencent) (10):
  mm/ksm: reduce the flush action for ksm merging page
  mm/ksm: skip subpages of compound pages
  mm/ksm: use folio in try_to_merge_one_page
  mm/ksm: add identical_folio func
  mm/ksm: use folio in stable_tree_search
  mm/ksm: remove page_stable_node
  mm/ksm: use folio in unstable_tree_search_insert
  mm/ksm: use folio in try_to_merge_xx serie funcs
  mm/ksm: calc_checksum for folio
  m/ksm: use folio in ksm scan path

 include/linux/mm.h |  17 ++++
 mm/ksm.c           | 230 +++++++++++++++++++++++----------------------
 2 files changed, 135 insertions(+), 112 deletions(-)

-- 
2.43.0


