Return-Path: <linux-kernel+bounces-220748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C980990E696
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EA52837DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AB97EEF5;
	Wed, 19 Jun 2024 09:11:53 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC32139CD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788313; cv=none; b=fD311fzEaEpI+4rT33uKqIt0deiL6yFvNQuYoM21qntLOyMd53M8tVi837kfgDx155TrGLqh0cPuki1MaEMstmPA8Hc4Yrxtg7PGBjarDs3xH2Wm72YclKsB/ZJimxQq+DugxiZRnUBzMqo3lQ1RPFOGOjijRgDC/vUlnHuTpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788313; c=relaxed/simple;
	bh=oFJSFMXpU5EZ7rZPZK1JRT8WtoWNFthtrmsxWh2R4Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nr3EkGad4ww8pmmsIpa+ftvzTWB2hrqJFMnMnYD+YGNNMmocTPuAcPGE5il/kpFEM8EExs2rWaEWZ0w0+jAL6dpY3+GwR6CGf0MmmG+ZVV7+4yqIHqhQ4p0xHftxfVq1dLytJ3KJfp8b4SoF/ChHGpR+kRJ10Crzljf0ArjvERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4ee5662fde8so1562208e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788311; x=1719393111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fIyHxlJcCCgl75LYMwqyMjmqzj6OP0aPwZGcOjx+O4=;
        b=vhdS/HP9x2BF8JR8Ng27YqPWxpwHEZPWdee6eTt/b5JH5O16DbKi4NGGpqFP4z+4Ch
         0bhkuSIGA6Ss+FZKpGTkma4ZG/zHaBhg1gPJ39JpVwiQPWEtjX9XEiZnar2BLLeuSIDl
         UaNIYrTaaNyKswEwT2nWXJnEA98Tb+19hW1QEj2p2KVOd+EQcZ6AbllDxpk1n5Vq8MlQ
         7nzo0UplDPF56QOORfyGIyhHF7MGbB1iaBWb6LKlebUj7FzGi3FYRpEFhdKu+VMeUs23
         uvrMhtGiZpshQJhusNhaOdEsnBkIEFwwRfFJmk3wbmk0fj8/FF/r5vXmVeecMcA2Fwvg
         Eyjg==
X-Forwarded-Encrypted: i=1; AJvYcCVcprJxVZB1aoxIFHGExkxqduB1Zc9QHBzWzzEEJqZ0szZxpLYQs0qWx8ZH3jpIbWpd15g2nx0JobY0dByQ/7gyuIIBBdTAnerDbfMl
X-Gm-Message-State: AOJu0Yx8R5JvaOdi51SiZ2R2K7cQg4jdYtXVycgXDHLFsWIi070cKsiM
	DZY4Dn5LArD7gQKhLMBox9n8kiNb6RG5xLovgiQz8pHdms1tYXvLdd796RP3NLArVOQk8cPIni1
	H3yDJ9yq925RYKsn83jbYWwZ6NSI=
X-Google-Smtp-Source: AGHT+IFjnX+Hn3g+YYR3b1mFHL2xyW+Lwm+EvEdbA2lohRi2wird6psc1h8B1eaR1xSaWnFeTdkFtJ2P4fk43QoK2+U=
X-Received: by 2002:a05:6122:c88:b0:4ec:f6f2:f1cd with SMTP id
 71dfb90a1353d-4ef276e5110mr2246166e0c.9.1718788310620; Wed, 19 Jun 2024
 02:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
In-Reply-To: <20240618232648.4090299-1-ryan.roberts@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 19 Jun 2024 21:11:39 +1200
Message-ID: <CAGsJ_4wx2WD+Msjhqqy7CK1gNGAQ2LGjuM5x_bNdXUOeGsz3xw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/5] Alternative mTHP swap allocator improvements
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Shuai Yuan <yuanshuai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:27=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> Hi All,
>
> Chris has been doing great work at [1] to clean up my mess in the mTHP sw=
ap
> entry allocator. But Barry posted a test program and results at [2] showi=
ng that
> even with Chris's changes, there are still some fallbacks (around 5% - 25=
% in
> some cases). I was interested in why that might be and ended up putting t=
his PoC
> patch set together to try to get a better understanding. This series ends=
 up
> achieving 0% fallback, even with small folios ("-s") enabled. I haven't d=
one
> much testing beyond that (yet) but thought it was worth posting on the st=
rength
> of that result alone.
>
> At a high level this works in a similar way to Chris's series; it marks a
> cluster as being for a particular order and if a new cluster cannot be al=
located
> then it scans through the existing non-full clusters. But it does it by s=
canning
> through the clusters rather than assembling them into a list. Cluster fla=
gs are
> used to mark clusters that have been scanned and are known not to have en=
ough
> contiguous space, so the efficiency should be similar in practice.
>
> Because its not based around a linked list, there is less churn and I'm
> wondering if this is perhaps easier to review and potentially even get in=
to
> v6.10-rcX to fix up what's already there, rather than having to wait unti=
l v6.11
> for Chris's series? I know Chris has a larger roadmap of improvements, so=
 at
> best I see this as a tactical fix that will ultimately be superseeded by =
Chris's
> work.
>
> There are a few differences to note vs Chris's series:
>
> - order-0 fallback scanning is still allowed in any cluster; the argument=
 in the
>   past was that swap should always use all the swap space, so I've left t=
his
>   mechanism in. It is only a fallback though; first the the new per-order
>   scanner is invoked, even for order-0, so if there are free slots in clu=
sters
>   already assigned for order-0, then the allocation will go there.
>
> - CPUs can steal slots from other CPU's current clusters; those clusters =
remain
>   scannable while they are current for a CPU and are only made unscannabl=
e when
>   no more CPUs are scanning that particular cluster.
>
> - I'm preferring to allocate a free cluster ahead of per-order scanning, =
since,
>   as I understand it, the original intent of a per-cpu current cluster wa=
s to
>   get pages for an application adjacent in the swap to speed up IO.
>
> I'd be keen to hear if you think we could get something like this into v6=
.10 to
> fix the mess - I'm willing to work quickly to address comments and do mor=
e
> testing. If not, then this is probably just a distraction and we should
> concentrate on Chris's series.

Ryan, thank you very much for accomplishing this.

I am getting Shuai Yuan's (CC'd) help to collect the latency histogram of
add_to_swap() for both your approach and Chris's. I will update you with
the results ASAP.

I am also anticipating Chris's V3, as V1 seems quite stable, but V2 has
caused a couple of crashes.

>
> This applies on top of v6.10-rc4.
>
> [1] https://lore.kernel.org/linux-mm/20240614-swap-allocator-v2-0-2a513b4=
a7f2f@kernel.org/
> [2] https://lore.kernel.org/linux-mm/20240615084714.37499-1-21cnbao@gmail=
.com/
>
> Thanks,
> Ryan
>
> Ryan Roberts (5):
>   mm: swap: Simplify end-of-cluster calculation
>   mm: swap: Change SWAP_NEXT_INVALID to highest value
>   mm: swap: Track allocation order for clusters
>   mm: swap: Scan for free swap entries in allocated clusters
>   mm: swap: Optimize per-order cluster scanning
>
>  include/linux/swap.h |  18 +++--
>  mm/swapfile.c        | 164 ++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 157 insertions(+), 25 deletions(-)
>
> --
> 2.43.0
>

Thanks
Barry

