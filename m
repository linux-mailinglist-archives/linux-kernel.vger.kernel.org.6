Return-Path: <linux-kernel+bounces-244364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2692A32A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAD01C20C4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A4824A1;
	Mon,  8 Jul 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NNBueFj9"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDE82499
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442897; cv=none; b=WahkyZo+hHs3oXxPkLo7vmxx9YM2lKyZKx9brW5hQYzGDbFoTjuG4QPTfIan+vvm4dyOzPiwabiu/6hsI9Fwth3lOYknUZH5NqVBXxtR3wRpPcSZxHmaOB3zAlL8PUSrKXccuzperwrSShKxoRLegGRPMZrZ1POCGjhNPwcyogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442897; c=relaxed/simple;
	bh=e+JPE6RV4+WhCTkyb2r7IHgJpza1D8x2iyR3fUThmdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvuJYhSEnE8QdEGRBw5tgKQffV4oTqWVK4PVyvzyh1r9Wz6rV48ED6hpuGTBwc9v4AKliG9mElfdXXRAyHJG22FsDbV/4C0rnHbKlKWo86SIbsY9mcDOhinwXVbG2YtKa24dWmjNRv3GN8jRxGd2C1NTPcMa6XrYIBG/Rl9HjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NNBueFj9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab63so5694417a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720442894; x=1721047694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fK5HtVriGenm5ML1JpdFXOU3g+iCUeiv2gozAo0WN/s=;
        b=NNBueFj9ljTPVEF95jG9I4Cy3YdmtcyRfGBtBKiE5SZlkM+cRgk8HgBLgPnrgWa8Np
         LsSpkdK6OGW7UbJMlXwcaPJMGBuyFzz/xtCId09GoXMY3L636OGwUkpppwT25jfBr/0d
         0GqWy0mGZbcoitTbMeADG2K0kL8w9Dy9QQHM+I4Yik0nnXuaA1aD8aOTwofZzaPVH2Iz
         CgQ1zTVX9fq7Nfhezd4JnznJJxRN5JuYsPTl0soB52nBqTvIyL/eaGNZthdV7lSnreNq
         AGcyS9j+6Dc97dmjWaF22NrUC7+3JTt4Jt+vgwDwsGXpQo/f9uRC9sTyY7ZzXZkp4U6G
         wSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720442894; x=1721047694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fK5HtVriGenm5ML1JpdFXOU3g+iCUeiv2gozAo0WN/s=;
        b=Di/J417rKbRTl7oetn1SGyzN44MYjqNqMekbLgMUSuy2M/KWAcCOOygD41nQBM5m0/
         Hw3TWkokez4CJE01uviCN+RU8zZ37xMb/RjUENf0O2L490ORdJSBGk/rnX8YtOsCDTzm
         tJPMBk2Bz47/i07LHsKEwmhP8Ad1KAoKgoXrpldvWYJ5H9RQo5k2pACCZPAsP3sX6XO6
         tKMew8lGmZQ35tL20lCbZl3G9FN2iQzCyf86+Iye2Pdrv7Hext5L6Vchg5+nNy0kxCl4
         oGBARApwxELR/lxftgC38b8ifx87OQ0nwiCaiIKFlx6R89mbGfk1TS2DTl1xgvw2+dlb
         ASNg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2ZZr1anTAJbo8TVUT4uTZ2vD3AdaNb+K2kQ/OMp8jauepGclWczVlgOsaVR3niH/bK48NiaK7asPFFAN0WMp6nykhL2zrXGCN7Wa
X-Gm-Message-State: AOJu0Yw1kA1J8nhZDwa0WKilQjfqFAgY88/nNyo34bV6JCFduE1PS17F
	0fO54iYlcFaxU+F8ZaAY+0UI876fvIAWsESFvDFvyQl5qQzYNOEulIjEI2pZ1dI=
X-Google-Smtp-Source: AGHT+IGwaHfNVUOdVeIQh5PDgHlFtNS0KriPJG08xmwkOUQ8J2Y8vvp7jybJ1dinpCMovCYMRlZEhQ==
X-Received: by 2002:a17:907:969e:b0:a75:110d:fa53 with SMTP id a640c23a62f3a-a77ba70baf4mr939217266b.49.1720442893911;
        Mon, 08 Jul 2024 05:48:13 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77d808b81esm278822266b.151.2024.07.08.05.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:48:13 -0700 (PDT)
Date: Mon, 8 Jul 2024 14:48:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: xiujianfeng <xiujianfeng@huawei.com>, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH -next] mm/hugetlb_cgroup: introduce peak and rsvd.peak to
 v2
Message-ID: <ZovgDfGFJdc6lVN3@tiehlicka>
References: <20240702125728.2743143-1-xiujianfeng@huawei.com>
 <20240702185851.e85a742f3391857781368f6c@linux-foundation.org>
 <6843023e-3e80-0c1c-6aab-b386ffebd668@huawei.com>
 <20240703133804.1d8ddf90f738a7d546399b3b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703133804.1d8ddf90f738a7d546399b3b@linux-foundation.org>

On Wed 03-07-24 13:38:04, Andrew Morton wrote:
> On Wed, 3 Jul 2024 10:45:56 +0800 xiujianfeng <xiujianfeng@huawei.com> wrote:
> 
> > 
> > 
> > On 2024/7/3 9:58, Andrew Morton wrote:
> > > On Tue, 2 Jul 2024 12:57:28 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> > > 
> > >> Introduce peak and rsvd.peak to v2 to show the historical maximum
> > >> usage of resources, as in some scenarios it is necessary to configure
> > >> the value of max/rsvd.max based on the peak usage of resources.
> > > 
> > > "in some scenarios it is necessary" is not a strong statement.  It
> > > would be helpful to fully describe these scenarios so that others can
> > > better understand the value of this change.
> > > 
> > 
> > Hi Andrew,
> > 
> > Is the following description acceptable for you?
> > 
> > 
> > Since HugeTLB doesn't support page reclaim, enforcing the limit at
> > page fault time implies that, the application will get SIGBUS signal
> > if it tries to fault in HugeTLB pages beyond its limit. Therefore the
> > application needs to know exactly how many HugeTLB pages it uses before
> > hand, and the sysadmin needs to make sure that there are enough
> > available on the machine for all the users to avoid processes getting
> > SIGBUS.

yes, this is pretty much a definition of hugetlb.

> > When running some open-source software, it may not be possible to know
> > the exact amount of hugetlb it consumes, so cannot correctly configure
> > the max value. If there is a peak metric, we can run the open-source
> > software first and then configure the max based on the peak value.

I would push back on this. Hugetlb workloads pretty much require to know
the number of hugetlb pages ahead of time. Because you need to
preallocate them for the global hugetlb pool. What I am really missing
in the above justification is an explanation of how come you know how to
configure the global pool but you do not know that for a particular
cgroup. How exactly do you configure the global pool then?
-- 
Michal Hocko
SUSE Labs

