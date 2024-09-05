Return-Path: <linux-kernel+bounces-317965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC7296E62C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A373284D57
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F21B3B1F;
	Thu,  5 Sep 2024 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="twNTuNmP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C018EFF8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578725; cv=none; b=GR2+fikOJwCyDINQi75Zz03MHt3sHrdxqm8gxhfqaj94wgbVhcNeQJd7MQWOlhRJRemb2ypQ8sHG9C2gVGLjqsgVxBjx/MHwe40yMFciE0YvW5VRFWhnqe1/CKl1N5+kaa3B3Q6Ur+kWvj99wojVeaVTil2x6CU7MgKOpr1VfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578725; c=relaxed/simple;
	bh=QEsWFh+dBd/2Lkor6S3sEDvsLM6qeDAJ74qBwVeiOLE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=URjBJv5+DCGQt/w9zm7eoE+fAkMie1BBSAW4tpFmuazgXYypI0G6IaG9mNHowvidanL/md7gHQTK4QHOoe8prJG9sDMIqhSRfqtx35hllkm+wMNEeRBJmWlhHuJBzlfFnKf2eEln7ogbCMjS94ctnLqqcXqaV/tfc/BRwrUW7H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=twNTuNmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E94C4CEC3;
	Thu,  5 Sep 2024 23:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725578724;
	bh=QEsWFh+dBd/2Lkor6S3sEDvsLM6qeDAJ74qBwVeiOLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=twNTuNmPH1sBFyI0ob0L9ArKRS6yehjFEXHz1zKy0LkdNt4eHTq+kwVrQHr+BzUGD
	 Eo8dCT/kB6DIgjjlTSjMi1wIUbjlB7opsoX9yEmmGYknAQxr3ZGeUgGd5TD5H+odbu
	 GHdZ4v8B1BZ47coDPHj8QvHYnf68YcyIcrRg0xr0=
Date: Thu, 5 Sep 2024 16:25:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Muchun Song <muchun.song@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v1 3/3] mm/codetag: add pgalloc_tag_copy()
Message-Id: <20240905162524.72c5bbefa075adb466ea6057@linux-foundation.org>
In-Reply-To: <20240903213649.3566695-3-yuzhao@google.com>
References: <20240903213649.3566695-1-yuzhao@google.com>
	<20240903213649.3566695-3-yuzhao@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Sep 2024 15:36:49 -0600 Yu Zhao <yuzhao@google.com> wrote:

> Add pgalloc_tag_copy() to transfer the codetag from the old folio to
> the new one during migration. This makes original allocation sites
> persist cross migration rather than lump into compaction_alloc, e.g.,
>   # echo 1 >/proc/sys/vm/compact_memory
>   # grep compaction_alloc /proc/allocinfo
> 
> Before this patch:
>   132968448  32463  mm/compaction.c:1880 func:compaction_alloc
> 
> After this patch:
>           0      0  mm/compaction.c:1880 func:compaction_alloc
> 

I'm thinking that [2/3] should be backported?

And possibly this one, but for that we should identify a Fixes:, please.

