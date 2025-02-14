Return-Path: <linux-kernel+bounces-515797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E85DA36932
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056361709CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614931FCF6B;
	Fri, 14 Feb 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FbfD5i3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E01922DE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576841; cv=none; b=QiIgM4EpVF79cMuFm4EkbEcOKiMQxXw4rNrtc0n5yv1HinpFvp8W5jGP5FL+fGJtJI+01CIGRxDW7ASDECQm0faCNJLWLsbrP/Wl1FUcrk3gpFrORlK9H2UYoWHnMHk3EMqnlCsCyU2n9VJxG35/2panPsr69KJ6dDHjdYtICyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576841; c=relaxed/simple;
	bh=UaT4pT/qCsHoeJRBMNkHe+2UwOkbHkv+62ubBAL9wn8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n97b+o0vtHoB/YuWm4R2r28mD/ZJjWpXApEKrt9S1tqiIs9fRl+kKA+FCVOHvYkhLzdwBJ5zTCd8hLUIjDSITwYmETxZaB9p1gYmm/UdJKBS7Mj3/aFU4imF8htPBLQcDQO044PHAPn3yjWsVYHUjH79ijBuGhQ6NBHyhrNKrgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FbfD5i3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21389C4CED1;
	Fri, 14 Feb 2025 23:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739576841;
	bh=UaT4pT/qCsHoeJRBMNkHe+2UwOkbHkv+62ubBAL9wn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FbfD5i3/hVxZvhRBj9Xwgju60aRyu8cYTKKxyet3yFHWi0hqDcNdqpdW3zpxCMVrs
	 PYjf/m80SHm8qi1KBfIizD9udceLsmL0Bz6AuB24uT6QZ57jEWGot9IoPrVZ26fbO1
	 OnAdpsgluBvpvc13iIvT43rlFp2/N6iRNgqe8PcU=
Date: Fri, 14 Feb 2025 15:47:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, Alexander Graf
 <graf@amazon.com>, Baoquan he <bhe@redhat.com>, Hari Bathini
 <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Fix kexec_locate_mem_hole() for missing
 CONFIG_KEXEC_HANDOVER
Message-Id: <20250214154720.42c1fab53ad7c3d3f8c968aa@linux-foundation.org>
In-Reply-To: <20250214125402.90709-1-sourabhjain@linux.ibm.com>
References: <20250214125402.90709-1-sourabhjain@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 18:24:02 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> While adding KHO support, commit 7d128945e003 ("kexec: add KHO support
> to kexec file loads") returns early from kexec_locate_mem_hole() if
> CONFIG_KEXEC_HANDOVER is not defined.
> 
> Due to this, kexec_locate_mem_hole() does not locate a hole for the
> kexec segment, and kbuf.mem holds 0x0. This leads to a kexec_file_load
> syscall failure in sanity_check_segment_list(). This impacts both
> kexec and kdump kernels.

Thanks.

Mike, I'll remove the v4 series from mm-unstable to gie you a clean
shot at v5.  Please incorporate Sourabh's fix?

