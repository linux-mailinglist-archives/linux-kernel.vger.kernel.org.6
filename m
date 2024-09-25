Return-Path: <linux-kernel+bounces-338158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6041E98541D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911901C202F2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774C5158557;
	Wed, 25 Sep 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmWZm82l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD215852E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249016; cv=none; b=oa/Fc1g6wt51kJJx0T8Kcv3h+KEpz6c3yrsu2npUmHEZDC4rE51YVLICZ7IW01KNMLOMEbCV3FZQ1zTgCAIy3V+fHildH9yHQFdh8yU2p6dORvdj4V7FwN0HGZ7R/rMT9N2Bh1Ygmmy7JkksxIiy/3efHHLKM5MGxNgiUFM/U9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249016; c=relaxed/simple;
	bh=Fbab7FZMNC0c+b4Oy70/Uh2GSx8i/kzZr1RGlGnO0PM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zrq3qdl5EizmCtiwFQAhS8E+E2xeOGjns2/bFRf/9If9civEkvlyUIZPEkyd1effOZNM7zmKkVaehb9J6TVdr25cOdkIPMEflYKXb/F3qz8NMFT/Ecyp4t0Uehd/ZAXTYUOAlyKTZxZxXFyqzGcE3A19nuIEkvNKq/hvZecNzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmWZm82l; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727249015; x=1758785015;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Fbab7FZMNC0c+b4Oy70/Uh2GSx8i/kzZr1RGlGnO0PM=;
  b=EmWZm82lP+D5pKbTUn09q/zgZO8+E2zj+QQ2ImjAL1UGHDyJ+knpaNGU
   POSc0TL7F8e248s0ROYHxbvfNXjh7xa43gWwLRF13socBD/ekOoE2h2jJ
   Cm+xFAxcei4HWfpFt96AJnNIN4fk1XNJTB8rjOvsSrUe0rO6CyCOzVqc8
   dUIpk9F4lhuHa7e9XSvTIkX9ELHp+VhasSuxqETTNkyv5zXKhT7g9Kebc
   7QsKVgGcLoDEeItTu76pyevZHPwT+iWHpbFC2lg7XqrT1vR6TAYHy9rPQ
   5OOdyvDxOU0mLDAADcBLHcmYL/JrSyKTYx0AyWCuNuEhqFkDM/A8jJVTG
   Q==;
X-CSE-ConnectionGUID: UY6Cq7iNRButAsQmj5fXnQ==
X-CSE-MsgGUID: y0Xr0hCZTeCBtpqDNrybzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36862829"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="36862829"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 00:23:34 -0700
X-CSE-ConnectionGUID: kOut79YfQOqKx+6r2a1pZg==
X-CSE-MsgGUID: NzQ6/hS0SLa/6VDp5Jy5TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71986383"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 00:23:30 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  akpm@linux-foundation.org,
  hannes@cmpxchg.org,  hughd@google.com,  shakeel.butt@linux.dev,
  ryan.roberts@arm.com,  chrisl@kernel.org,  david@redhat.com,
  kasong@tencent.com,  willy@infradead.org,  viro@zeniv.linux.org.uk,
  baohua@kernel.org,  chengming.zhou@linux.dev,  linux-mm@kvack.org,
  kernel-team@meta.com,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
In-Reply-To: <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
	(Nhat Pham's message of "Tue, 24 Sep 2024 08:48:09 -0700")
References: <20240923231142.4155415-1-nphamcs@gmail.com>
	<4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
	<CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
	<9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com>
	<CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
	<CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
	<CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
Date: Wed, 25 Sep 2024 15:19:57 +0800
Message-ID: <87o74cryhu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Nhat Pham <nphamcs@gmail.com> writes:

[snip]

>
> My understanding now is that there are two for loops. One for loop
> that checks the entry's states, and one for loop that does the actual
> incrementing work (or state modification).
>
> We can check in the first for loop, if it is safe to proceed:
>
> if (!count && !has_cache) {
>     err = -ENOENT;
> } else if (usage == SWAP_HAS_CACHE) {
> if (has_cache)
>     err = -EEXIST;
> } else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
>     err = -EINVAL;
> } else if (usage == 1 && nr > 1 && (count & ~COUNT_CONTINUED) >=
> SWAP_MAP_MAX)) {
>     /* the batched variants currently do not support rollback */
>     err = -ENOMEM;
> }
>
> At this point, IIUC, we have not done any incrementing, so no rollback
> needed? :)

I think that it's better to add a VM_WARN_ONCE() here.  If someone
enabled 'nr > 1' for __swap_duplicate(), the issue will be more
explicit.

[snip]

--
Best Regards,
Huang, Ying

