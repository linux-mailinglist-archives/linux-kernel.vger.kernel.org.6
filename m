Return-Path: <linux-kernel+bounces-516271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC3AA36EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F3F17120E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE91D8A12;
	Sat, 15 Feb 2025 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eum/fFjl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182AF151991
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739632062; cv=none; b=eAxkyxm2nPJiAwjoIY72Ue7zQFI3ySuzWwR0WIJUipBLg1y4VCVWz78FEd/tKdOQIhPm6/F76iOZYTeR9GeYwq+alLmwCi67qQIzoYDXz8elfKscg0GvCbDY6os02OZcgXuRmzbfG3CMOT0SsK/MJV8aLvNHk0Yl1hL2wjt0g/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739632062; c=relaxed/simple;
	bh=XejohOSsOA6aP8L5R5o9ggG8b/Bwp7euByjy8KzI4qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFtN6gRI+Phm0sciRMfkGxmShutCkXLEg0ItYSX/r8cyYaACH5D0Rl0tneB4aYUrZoeF9MSyzWcpMEnrU9s5OtfKL+zz+fWRAANYXLRibJmkVJEyyhDxvvCIXRZuV154DsVpbpEkvSwm4XyXbPrxa6oI5yKSnNXzYDG1OfLrvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eum/fFjl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739632059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NALRKG4oKiAlHdUHvnXOLgXb+cbO4H71jnmJfo2HgGc=;
	b=eum/fFjlXeIXeSqZXfovx+ptzpVAiXWTwW9cxaV4y7J+3MKCJ7D652s1qlQeAomjbQyRi3
	G60QejKX/BTaeorRCEdrrSfEqOx6UPP60b5DSvLe6XMkqcSuNcIHpQlfXdF8Lssmo+JNLg
	w1PsnGfJCy9r7CPILbJfia6zqS1S01w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-tWixr9rkMGKrdm7E_KRGfw-1; Sat,
 15 Feb 2025 10:07:35 -0500
X-MC-Unique: tWixr9rkMGKrdm7E_KRGfw-1
X-Mimecast-MFC-AGG-ID: tWixr9rkMGKrdm7E_KRGfw_1739632053
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E97A11800570;
	Sat, 15 Feb 2025 15:07:32 +0000 (UTC)
Received: from localhost (unknown [10.72.112.76])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13C6F1800359;
	Sat, 15 Feb 2025 15:07:30 +0000 (UTC)
Date: Sat, 15 Feb 2025 23:07:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] mm, swap: remove swap slot cache
Message-ID: <Z7CtrKQFNRgak1Am@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <Z7BsL2v6+oweqWE4@MiWiFi-R3L-srv>
 <CAMgjq7DUdcbRdYLtFF7_VaBkzY4=VQXsRtDg_xhqTyBLmtMG9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7DUdcbRdYLtFF7_VaBkzY4=VQXsRtDg_xhqTyBLmtMG9w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/15/25 at 09:34pm, Kairui Song wrote:
> On Sat, Feb 15, 2025 at 6:28 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > Hi Kairui,
> >
> > On 02/15/25 at 01:57am, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Slot cache was initially introduced by commit 67afa38e012e ("mm/swap:
> > > add cache for swap slots allocation") to reduce the lock contention
> > > of si->lock.
> >
> > Thanks for adding me in CC. While I got failure to apply this series
> > to the latest mainline kernel, could you tell what is the base commit
> > of this pathcset?
> >
> > Thanks
> > Baoquan
> >
> 
> Hi Baoquan,
> 
> It's based on Andrews's mm-unstable here:
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
> 
> I've just re-checked, there should be no conflict. Sorry I didn't
> include this info in the cover letter, mm development is rapid so
> usually I send patch based on mm-unstable.

Thanks, applied to akpm-mm/mm-unstable branch cleanly.


