Return-Path: <linux-kernel+bounces-547930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 961EBA53DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4E918914D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D210C20AF64;
	Wed,  5 Mar 2025 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6HeptYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9720A5DC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215744; cv=none; b=pRpc3iAYdFM0RToliQMvE/Q8PU+jZws31iI9l5lDK/NrC6oYwOnXWEBZ/rAi7RsdVtkye1ngWWTmqLq/zNreFoZQ4MjND2+SPtlBDNdOBvriZMNqhh7X6wN6xOTfbXbp99NxvWm3uz9GPDAw4DyGN3/SiBQi89ril+VS/PbiOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215744; c=relaxed/simple;
	bh=RT34XeNjBWgzD0ZN8J6EvR3tl5kGle9qJ4bsjQ3pd50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daYQfZM3QWrc4LbJaiHKnVuRC1fQX0kyE1r2wwRAzmTxSkc/oLx+w8vKclORn3S+dOd33IppvRCCUNL027B+fbS7O5KAQ/dXUUGtDTCQKXGBmNt53UEuzl4eyg1Wz9J6vUTAKJfNJQ0FOYedhNalW+Cy9cA/UYixlEKX/b6sUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6HeptYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618B0C4CED1;
	Wed,  5 Mar 2025 23:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215743;
	bh=RT34XeNjBWgzD0ZN8J6EvR3tl5kGle9qJ4bsjQ3pd50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6HeptYfM5LX312DQ+XiDr5qTJirK8w57ErL1+7DiDSwXjh3TAmLmjiCNdY4KFGqI
	 zTsVfn+MC5I3CBVRT5ciopZFt6DFsw6fEpAiFkhQTpQNWtSqf14tMZgRBEHvzPs7qz
	 S8Dpqlj+WU9n3jAQOpw5vBEsbKHo/z+Q2li/KKDG3VHWy67I8QiUVlIgM1+UvB92Xa
	 fqNk7anhzsLVRatfX6X1ERumDS+/Ih8gG5zvIvCRf98oj1qRXEJIixz6ygKIdSqOYS
	 Gi1nsbh3jHmkq4ftxg/wQ6h4WYjfk4X2HlfqIPi9xjqL7EvmASYwhjqw2JMeut0IHd
	 m4V69v7GO8Z5Q==
From: SeongJae Park <sj@kernel.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for MADV_DONTNEED and MADV_FREE
Date: Wed,  5 Mar 2025 15:02:21 -0800
Message-Id: <20250305230221.60260-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <7BC81F7C-191F-451D-8FE5-5BB268F6B0A1@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 5 Mar 2025 22:36:45 +0200 Nadav Amit <nadav.amit@gmail.com> wrote:

> 
> > On 5 Mar 2025, at 20:15, SeongJae Park <sj@kernel.org> wrote:
> > 
> > For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> > can happen for each vma of the given address ranges.  Because such tlb
> > flushes are for address ranges of same process, doing those in a batch
> > is more efficient while still being safe.  Modify madvise() and
> > process_madvise() entry level code path to do such batched tlb flushes,
> > while the internal unmap logics do only gathering of the tlb entries to
> > flush.
> 
> I made some related (similar?) patches in the past. You can see if you
> find something useful in the discussion there. I think your version avoids
> some of the “mistakes” I made.

Thank you for sharing this!  I sure I can learn and use many things from this
work and previous discussions.

> 
> [1] https://lore.kernel.org/all/20210926161259.238054-1-namit@vmware.com/T/#m23ccd29bad04a963c4d8c64ec3581f7c301c7806


Thanks,
SJ

