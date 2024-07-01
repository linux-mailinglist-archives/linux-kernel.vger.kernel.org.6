Return-Path: <linux-kernel+bounces-236883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1109091E838
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A20283C19
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524EC16F26C;
	Mon,  1 Jul 2024 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLr+TKX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278516F293;
	Mon,  1 Jul 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860719; cv=none; b=ZJ7o1smYB/uHZImMlovZsHXzmzKXJ0/ROFQEH1AjWAOahRzFvzQUx1Uhvbh9towzB7Ny7IpB1ARjfviG0ZDgHD3hZXWL4g1xtmw8BM7HXpVZ2ONF4VQ4Q26RKlQZhARWXSau3Y525Z9zll8x4m1SmFWx0IKOSfHYbvAwFbpx2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860719; c=relaxed/simple;
	bh=naE5jRrwQozMx1LfncydeIdqJAI3pVBg0a8pa+E5Cmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTIQjByX2sBkQq98nFhH4rV4WtERJQ8VCxWmM0Y0LTf/calrMq0Lwp7kbaB6nYmdxuq1hKaD5WGsCNF9nchDiGupJXlnnnA+8r3ocQNmD9Eif/vb+5UI+NhQbRNcPi/8eJEzGsJiJ7FysXBr0uAsl3zEc8AFWC3/sPoUv579GHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLr+TKX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C798C4AF0A;
	Mon,  1 Jul 2024 19:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719860719;
	bh=naE5jRrwQozMx1LfncydeIdqJAI3pVBg0a8pa+E5Cmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLr+TKX/1TaBS8L+M+VJkO8JaWcJCi2qyVyaxj0qkfF29zNzZFuEWhR3IIOAv6ySp
	 79IOZqN1JDZ8T22t1yKTwXWCvVLVpwIrdRevmdUgQOQnuhrFRif/OHJ+hzP9ceXh/Q
	 L0ZjlWlBuUpgTNongXL0LJm8vk2dJn1nslWI2TIW23AcgsylpGbtcYCxOrso0utVlq
	 ightxSGV+ZvXdRAAiECp1hWgFLQK0UQrzQVtmTNRj4CVPosaJlsCXR5d77OGxF5MQT
	 yQiinpmrv7rV32Oycm/6foquAWvCxOsfppGZbi81xpERTFKeAs2L/iMeBIxIj6KmpW
	 rmNg2QnFNCH+A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Docs/mm/allocation-profiling: mark 'Theory of operation' as chapter
Date: Mon,  1 Jul 2024 12:05:09 -0700
Message-Id: <20240701190512.49379-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701190512.49379-1-sj@kernel.org>
References: <20240701190512.49379-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'Theory of operation' part of allocation-profiling document is
apparently a chapter.  However, it is mistakenly marked as a document
title.  As a result, rendered mm document index page shows two items for
the document.  Fix it to be marked as a chapter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/allocation-profiling.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
index d3b733b41ae6..ffd6655b7be2 100644
--- a/Documentation/mm/allocation-profiling.rst
+++ b/Documentation/mm/allocation-profiling.rst
@@ -46,7 +46,6 @@ Example output::
          55M     4887 mm/slub.c:2259 func:alloc_slab_page
         122M    31168 mm/page_ext.c:270 func:alloc_page_ext
 
-===================
 Theory of operation
 ===================
 
-- 
2.39.2


