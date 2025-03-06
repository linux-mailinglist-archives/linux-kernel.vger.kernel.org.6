Return-Path: <linux-kernel+bounces-549708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B9A55647
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9CD175080
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A65A26D5C3;
	Thu,  6 Mar 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o98WtyeM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3DA25A652
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288309; cv=none; b=ngiketoUN7BQ2TBjI4C3J38iGN81ctfKpMPCBnviKScSxgsWjkmWM7/5lMF0zos4Q4tGYFw3ljHRIeJqy+/mKvUIC/C9zUOMp17je9MyZzXmpEmDUZ2fQSwyMiSVDfCNMI9ai70PdigByL/GewfIBLGt6tNTLwz8lAYvMSqdMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288309; c=relaxed/simple;
	bh=kgh4N9HlQC6vss0XDSqgF+GANv+K6u/7NfhVoAsKOMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeB5oQnaooWqf2YCFqia21DxnoPe6CrFVru0tKJFllAUQX2XQFsnbM4hqyx1uOBfo5w1JW2LQL1AO8dxRawHTygYdAMcgl1LzyPrG4yV1mb8MDYks2uzxC0mOhzclqUyk/pO9lOi8qze9/Aq2BQTQdEBST5uUKBvswWEuHF9KAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o98WtyeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DEAC4CEE0;
	Thu,  6 Mar 2025 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288309;
	bh=kgh4N9HlQC6vss0XDSqgF+GANv+K6u/7NfhVoAsKOMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o98WtyeM8QrVCidJbd1zVPexrNtnhbR2GfswRQkDsr1qI6RuB9bkesh++UrAyHOy5
	 GMMBbARpkS0DX+fqtz1/xd+kZ52TD3AtFYSsyrRoFPY/tet424+xOLteG4xbJvwNSW
	 WtkXa1z748WL4Q1SCL8nbqujj8FYZ2C79c3F8ycREoYvZgG2X2zcHxQcIAOBTqCdnY
	 0EX6ibI2JKjGQK1PSJjHhUEia0PZ8APn/HLlQ1gRgdIQXiSfMsTiWoQDAe3Kf9a6M8
	 a0fnDB9fAd9FeggDnJZLU8VxJtxhqFqRodFR3/l/5UtrI9OAB147qelNVRxeO4Qqf4
	 wCsasW+kRG8iA==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 12/16] mm/madvise: batch tlb flushes for process_madvise(MADV_DONTNEED[_LOCKED])
Date: Thu,  6 Mar 2025 11:11:46 -0800
Message-ID: <20250306191147.843453-1-sj@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <qloyhszjm4v44lfocb5wjnmmylz4n7co2v6iqbxz335i3ybsru@arcmuuiwahkh>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 6 Mar 2025 10:36:43 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, Mar 05, 2025 at 10:16:07AM -0800, SeongJae Park wrote:
> > MADV_DONTNEED[_LOCKED] internal logic can be invoked with batched tlb
> > flushes.  Update vector_madvise(), which is called for
> > process_madvise(), to use that in the way, by passing an mmu_gather
> > object that it initializes before starting the internal works, and
> > flushing the gathered tlb entries at once after all the internal works
> > are done.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> Please squash 12, 13 and 14 patches.

Surely I will do so in the next spin, for all your squash requests, inlcuding
that for 15th and 16th patches.


Thanks,
SJ

