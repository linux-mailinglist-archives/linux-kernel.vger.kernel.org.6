Return-Path: <linux-kernel+bounces-558554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C91A5E78D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186EA7A37E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3D1F0E31;
	Wed, 12 Mar 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="krkTAbkP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FE1F098A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818979; cv=none; b=DO84SYN5AxhSCk+we7z67NQi9xPo8ixvX/nS1tMvCH5d1g/NPswnBnVNioi4Qii+bPK1JyHZnkQcAv+CHCmBWO2imZoSOkfsuXH7lt1NUrcocZ1Vmt/GIUXvTDwpW0KOeZQ4WdSNX9XpjuIAZ4MrNFNLk2RAcMx6OevCeHAIW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818979; c=relaxed/simple;
	bh=esNciyZGGa4yuxE1In7Ugw3hY1fgk+4q/nGujvoPSHE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZTvNlAKLKFkgOnF2iRR6Wz78qcBKlf8youIZqMD0l2KtFcHQwVlTRgqAAF4cp/s50T359gZ6s0cpAhobx9r7UKdtS7GLQx4XE7OA/GkiKN7aBMKN/szGW7sk0/z+GSiNfpHhS0TpOFc/9YnWbQ/krgdUiB3y/1+q6sYs6aZEuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=krkTAbkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE158C4CEDD;
	Wed, 12 Mar 2025 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741818979;
	bh=esNciyZGGa4yuxE1In7Ugw3hY1fgk+4q/nGujvoPSHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=krkTAbkPIIdY70Yq3zuaB9FSIdrTel4qNE3xdlDNjVLFwwxTGZMGP+7hylJJYWEcC
	 WQy5X9zW0skQ1LsECxI/C6MsMaLBdvstxMaDWsxXRdGRpjDMtoF3d2p4dfCBbS8BZ/
	 8mMzQQVvi4FkiP0YFwH5XQoF4dJJd8GnJRIJNmLY=
Date: Wed, 12 Mar 2025 15:36:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: mhocko@suse.com, hannes@cmpxchg.org, muchun.song@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: skip the file folios in proactive reclaim
 if swappiness is MAX
Message-Id: <20250312153618.e24f399d2d9767ebef87519f@linux-foundation.org>
In-Reply-To: <20250312094337.2296278-1-hezhongkun.hzk@bytedance.com>
References: <20250312094337.2296278-1-hezhongkun.hzk@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 17:43:37 +0800 Zhongkun He <hezhongkun.hzk@bytedance.com> wrote:

> With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
> memory.reclaim")', we can submit an additional swappiness=<val> argument
> to memory.reclaim. It is very useful because we can dynamically adjust
> the reclamation ratio based on the anonymous folios and file folios of
> each cgroup. For example,when swappiness is set to 0, we only reclaim
> from file pages.
> 
> However,we have also encountered a new issue: when swappiness is set to
> the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> to the knob of cache_trim_mode, which depends solely on the ratio of
> inactive folios, regardless of whether there are a large number of cold
> folios in anonymous folio list.
> 
> So, we hope to add a new control logic where proactive memory reclaim only
> reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS.
> For example, something like this:
> 
> echo "2M swappiness=200" > /sys/fs/cgroup/memory.reclaim
> 
> will perform reclaim on the rootcg with a swappiness setting of 200 (max
> swappiness) regardless of the file folios. Users have a more comprehensive
> view of the application's memory distribution because there are many
> metrics available.
> 
> With this patch, the swappiness argument of memory.reclaim has a more
> precise semantics: 0 means reclaiming only from file pages, while 200
> means reclaiming just from anonymous pages.

Please update Documentation/admin-guide/cgroup-v2.rst for this.

