Return-Path: <linux-kernel+bounces-185387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CC18CB451
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9918828226C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB52E148301;
	Tue, 21 May 2024 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF4FZQx3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C06FDC
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320337; cv=none; b=MAjGqSSDFwDo/eniAStMj+ZKhHAIsjOW1IOA9her5IXVT8MwcCmtcVm510nZpA5Xj7xTYKgiz0pmFaRkGe1sTZ/1s6IbboZuZQwUzyAwFR8ITD16PbOZH8T/xw5W954g+j96oJNhsi2sus50k9csa3WjZfEx9CDPnaiqiSLhhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320337; c=relaxed/simple;
	bh=yM5jUBsUFVsKXfURl4V3IpmBHiXpMXsFD7O98BJGzzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnkBLBe5bxXFFpjc63XUnI2K7i+xWGmmeYV+AudJ0oMpeI70IYyObN+YudSsYKiKS171cBl8MYT0TaK2N72H9hCzwqjtYh4ZtCXo6kYhx5UbRm17KHxgWVzW/DH5GJqxJ6Qx61MiaTXBDIeiq2rpAcbeih50mtd33D6h0ElG5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EF4FZQx3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716320334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYYVmpxUTW1rvzvLb3yl7sd1KPPLyWa+9wqUfdTVkKQ=;
	b=EF4FZQx3V0ABD6oznOVo6eBId9FDQvm74fOOJ1ao3pWcf31uL/nNfAZvuNjdbf9d2tJCOn
	35ksuT4LrvNNfh8IwTJpsv8d85GhYP4qfR3qhaBuLWkaI+ApXdmafJ2adetFZ6a/lRhmUs
	7oPORJGjMu2oq+Cwp1SZCa+Kb9sxjAo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-QonVt4JhMWuf5H_IYsakow-1; Tue, 21 May 2024 15:38:50 -0400
X-MC-Unique: QonVt4JhMWuf5H_IYsakow-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5b278f641e7so4249185eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716320330; x=1716925130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYYVmpxUTW1rvzvLb3yl7sd1KPPLyWa+9wqUfdTVkKQ=;
        b=Lw5yDS4vWoOeEpepMiUAUyVKIKr7Fmr3JeBreCt5OZdjfrLqiGa5GWktquC0RX+fBW
         W9BWjRlX7N6AKUnf4rBH0C0iDaN7w6+CE6yylSSwhKnoAzH2fhyrg6kErqMy68zxXtXJ
         s/ogCcd/WtjL6v1GUXgoy78LYyxTMb9Xh6Mqa9yTtBnwX7bNkeDzKryw11sm8EMClKOv
         +Wil8vC9EwAE1Y09X/cwXFXBzrGSdniuTx20MGhtHRpr2qutgmiDmuiekGi6pRDmQzWb
         xw7RHDbmzUr8WXawiL/k+gutydEBWfYQIexFKUV1pqUuxxyzWpHO9gGgm+T0ZM67/EbM
         EHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ym3JyS7RlBGCqMUlQ8pH8d6AkdRzNjfiJ/iItZq4fwbW70JwmPA4Z/EmzK3TbnmN98N9mStR2tAIOcjZk7o9j4Cx7FDGkp6ATWgm
X-Gm-Message-State: AOJu0YxFJHiq8vsgDxPZbozJHua66jqqEhZUzYKJhMt199c5vBTx86JU
	ZXXs+tRRBUtx1orj2uAGuzv6P1RxTK6T4bnhI5/8Wimw96JP2ilhvjxxFkW+m1yFMqUTdWTQZGi
	a2BoGCtqK4uAJTasif6nI5SkrXzxEWNRSnsNM7KWyEcncbcKU6OPAs6NYvb25/Q==
X-Received: by 2002:a05:6870:ec92:b0:22e:d06b:5d8f with SMTP id 586e51a60fabf-24c68f1addemr73228fac.3.1716320329575;
        Tue, 21 May 2024 12:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuJRXiMDJJZEtnmzU9qzE6oDOn/TCBfN2Y35IEbikRKw/0W0UM2Vxc+OkccQ8gdSdHQwLz4A==
X-Received: by 2002:a05:6870:ec92:b0:22e:d06b:5d8f with SMTP id 586e51a60fabf-24c68f1addemr73193fac.3.1716320328487;
        Tue, 21 May 2024 12:38:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54d6e47sm161791381cf.28.2024.05.21.12.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:38:47 -0700 (PDT)
Date: Tue, 21 May 2024 15:38:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2024-36000: mm/hugetlb: fix missing hugetlb_lock for resv
 uncharge
Message-ID: <Zkz4RRgfwUHPbQ5z@x1n>
References: <2024052023-CVE-2024-36000-cfc4@gregkh>
 <Zkto8rbtAUBql-78@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zkto8rbtAUBql-78@tiehlicka>

On Mon, May 20, 2024 at 05:14:58PM +0200, Michal Hocko wrote:
> Peter,

Hi, Michal,

> does b76b46902c2d ("mm/hugetlb: fix missing hugetlb_lock for resv
> uncharge") really have any security implications? I fail to see any but
> UFFD is not really my area so I might be missing something very easily.

AFAIU that issue wasn't userfault specific, but a generic issue for hugetlb
- I believe that can also trigger in other paths whoever try to call
alloc_hugetlb_folio(), and UFFDIO_COPY is one user of it.

I looked at that and provided a fix only because the report originated from
the uffd report, so Andrew normally pointing those to me, and since I
looked anyway I tried to fix that.

Here in general what I can see is that the lock is needed since this
commit:

    commit 94ae8ba7176666d1e7d8bbb9f93670a27540b6a8
    Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    Date:   Tue Jul 31 16:42:35 2012 -0700

    hugetlb/cgroup: assign the page hugetlb cgroup when we move the page to active list.

That commit mentioned that we rely on the lock to make sure all hugetlb
folios on the active list will have a valid memcg.  However I'm not sure
whether it's still required now (after all that's 2012..), e.g., I'm
looking at hugetlb_cgroup_css_offline(), and hugetlb_cgroup_move_parent()
looks all safe to even take empty memcg folios with the latest code at
least:

	/*
	 * We can have pages in active list without any cgroup
	 * ie, hugepage with less than 3 pages. We can safely
	 * ignore those pages.
	 */
	if (!page_hcg || page_hcg != h_cg)
		goto out;

In short, I don't know any further security implications on this problem
besides LOCKDEP enabled.  But I don't think I fully understand the hugetlb
reservation code, so please just take that with a grain of salt.  E.g.,
right now we do the hugetlb_cgroup_uncharge_folio_rsvd(), then could it
happen that this folio will still be used finally and got injected into the
pgtables (after all, alloc_hugetlb_folio() will still return this folio to
the caller with a success), and would that be a problem if this folio has
its _hugetlb_cgroup_rsvd==NULL?  That looks like another question besides
this specific problem, though..

Thanks,

> 
> On Mon 20-05-24 11:48:36, Greg KH wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > mm/hugetlb: fix missing hugetlb_lock for resv uncharge
> > 
> > There is a recent report on UFFDIO_COPY over hugetlb:
> > 
> > https://lore.kernel.org/all/000000000000ee06de0616177560@google.com/
> > 
> > 350:	lockdep_assert_held(&hugetlb_lock);
> > 
> > Should be an issue in hugetlb but triggered in an userfault context, where
> > it goes into the unlikely path where two threads modifying the resv map
> > together.  Mike has a fix in that path for resv uncharge but it looks like
> > the locking criteria was overlooked: hugetlb_cgroup_uncharge_folio_rsvd()
> > will update the cgroup pointer, so it requires to be called with the lock
> > held.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-36000 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Issue introduced in 5.10 with commit 79aa925bf239 and fixed in 6.1.91 with commit 4c806333efea
> > 	Issue introduced in 5.10 with commit 79aa925bf239 and fixed in 6.6.30 with commit f6c5d21db16a
> > 	Issue introduced in 5.10 with commit 79aa925bf239 and fixed in 6.8.9 with commit 538faabf31e9
> > 	Issue introduced in 5.10 with commit 79aa925bf239 and fixed in 6.9 with commit b76b46902c2d
> > 	Issue introduced in 5.9.7 with commit f87004c0b2bd
> > 
> > Please see https://www.kernel.org for a full list of currently supported
> > kernel versions by the kernel community.
> > 
> > Unaffected versions might change over time as fixes are backported to
> > older supported kernel versions.  The official CVE entry at
> > 	https://cve.org/CVERecord/?id=CVE-2024-36000
> > will be updated if fixes are backported, please check that for the most
> > up to date information about this issue.
> > 
> > 
> > Affected files
> > ==============
> > 
> > The file(s) affected by this issue are:
> > 	mm/hugetlb.c
> > 
> > 
> > Mitigation
> > ==========
> > 
> > The Linux kernel CVE team recommends that you update to the latest
> > stable kernel version for this, and many other bugfixes.  Individual
> > changes are never tested alone, but rather are part of a larger kernel
> > release.  Cherry-picking individual commits is not recommended or
> > supported by the Linux kernel community at all.  If however, updating to
> > the latest release is impossible, the individual changes to resolve this
> > issue can be found at these commits:
> > 	https://git.kernel.org/stable/c/4c806333efea1000a2a9620926f560ad2e1ca7cc
> > 	https://git.kernel.org/stable/c/f6c5d21db16a0910152ec8aa9d5a7aed72694505
> > 	https://git.kernel.org/stable/c/538faabf31e9c53d8c870d114846fda958a0de10
> > 	https://git.kernel.org/stable/c/b76b46902c2d0395488c8412e1116c2486cdfcb2
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Peter Xu


