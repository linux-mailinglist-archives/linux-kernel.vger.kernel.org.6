Return-Path: <linux-kernel+bounces-339806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDD3986AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1C11C213FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B6216FF25;
	Thu, 26 Sep 2024 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="harD6vKz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1B2C18C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727316213; cv=none; b=A812ligavT2BKolf1WNLE1o+mcuPnyL4MgUtaWlGrN1omZmo2aCUGh6BoI74szhI+z+s4HT8bEh2zfrRgzbmwulGw7qRDC3vNkDOdwFK+uIgbusNObeeSOrShrOeTJvRPFU/jPvtVZ2TKNk+VDmurTztdWNvgoDKZK8ZUSVCYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727316213; c=relaxed/simple;
	bh=Sl3F7flDuPPcQnO2qXWYfmucaK/BNWTk+/YHVoRe8HI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cbGjYMs+XY8p16tWf9mgG3wmlbjEgbOlMzqxfXfKeAxU/O0ClPvG0/RezL3re52HJ7BCrbiUxKobdT5wfsnbCVBFcOsVseFnChTSEY99NYaVGUTDodRBkAXaT0wkVEwp2mlyK2JGgGMeJqGJMQBEnCNUYPkExzOtkqqgUzhjHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=harD6vKz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727316212; x=1758852212;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Sl3F7flDuPPcQnO2qXWYfmucaK/BNWTk+/YHVoRe8HI=;
  b=harD6vKzhNotWWZtakHF4wYYhc1BA3GNNzKeurZJcCL+Y3YjsI1Iq6kW
   eUGe8Rs1ugNh9yFJK//KL6Veqn8Hw5XDM/sg3Lt9mN9a2+qSuHQ9QTnJy
   rWQKv2reRJ+lMIGtHY5BhOTcH1F0lzWRYEwKt5CyRzLFUNyv1MrLPwGvl
   DFN3xRbMjWczUTS8zCrazqSsUFaoDnrFPaIfDppx5FvEpedlTJNd2t0C4
   QRGGmaChgdxXPtaaAENVbCZGfrRgFFeMTfcVQI7bzwONSgBz/LQX/05xB
   Mvg9xEpx+hMllKMPbVDBXHhc482NKyBkVN07Ypf4Q2/kqCf4AvVHsv+Ll
   Q==;
X-CSE-ConnectionGUID: OvvsV0XVROSTamESl0GC9w==
X-CSE-MsgGUID: AQuyKmgyTq6QkTGLVIyd1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="25866994"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="25866994"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 19:03:30 -0700
X-CSE-ConnectionGUID: aGaQrNntTPy3jbEWuHGjBQ==
X-CSE-MsgGUID: VSRods/SToqX4Q1s4Wtrfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="72071831"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 19:03:26 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  akpm@linux-foundation.org,  hannes@cmpxchg.org,
  hughd@google.com,  shakeel.butt@linux.dev,  ryan.roberts@arm.com,
  chrisl@kernel.org,  david@redhat.com,  kasong@tencent.com,
  willy@infradead.org,  viro@zeniv.linux.org.uk,  baohua@kernel.org,
  chengming.zhou@linux.dev,  linux-mm@kvack.org,  kernel-team@meta.com,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
In-Reply-To: <CAKEwX=NB-vf4zTTJ2KaRFGJmcfeDQpLLuiX=Rh6X+49ib8S=wA@mail.gmail.com>
	(Nhat Pham's message of "Wed, 25 Sep 2024 07:37:12 -0700")
References: <20240923231142.4155415-1-nphamcs@gmail.com>
	<4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
	<CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
	<9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com>
	<CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
	<CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
	<CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
	<85a2fd61-93d3-4cd9-95a3-e9eaef87286b@linux.alibaba.com>
	<CAKEwX=NB-vf4zTTJ2KaRFGJmcfeDQpLLuiX=Rh6X+49ib8S=wA@mail.gmail.com>
Date: Thu, 26 Sep 2024 09:59:53 +0800
Message-ID: <87y13fqina.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nhat Pham <nphamcs@gmail.com> writes:

> On Tue, Sep 24, 2024 at 6:53=E2=80=AFPM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>> One benefit I can mention is that removing 'SWAP_MAP_SHMEM' can help to
>> batch free shmem swap entries in __swap_entries_free(), similar to the
>> commit bea67dcc5eea ("mm: attempt to batch free swap entries for
>> zap_pte_range()") did, which can improve the performance of shmem mTHP
>> munmap() function based on my testing.
>
> Yeah, the problem with having an extraneous state is you have to
> constantly check for it in code, and/or keep it in mind when you
> develop things. I've been constantly having to check for this state
> when I develop code around this area, and it gets old fast.
>
> If we can use it to optimize something, I can understand keeping it.
> But it just seems like dead code to me :)
>
> My preference is to do this as simply as possible - add another case
> (usage =3D=3D 1, nr > 1, and we need to add swap continuations) in the
> check in __swap_duplicate()'s first loop, and just WARN right there.
>
> That case CANNOT happen UNLESS we introduce a bug, or have a new use
> case. When we actually have a use case, we can always introduce
> handling/fallback logic for that case.
>
> Barry, Yosry, Baolin, Ying, how do you feel about this?

Sounds good to me to just WARN now.  We can always improve when it's
necessary.

--
Best Regards,
Huang, Ying

