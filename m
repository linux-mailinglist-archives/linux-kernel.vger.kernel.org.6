Return-Path: <linux-kernel+bounces-403906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3669C3C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E4228252B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F4517C7BD;
	Mon, 11 Nov 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="il/YDmB/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D2175D34
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322597; cv=none; b=QX8TgSmih1gG2TghAw5x+p/3NbjzqkHoezTIQVhsRciYZCfGFlotambwYdw7MquYe4ZtSxzNXLrzIgdtaqjJpqnYiSc4f4T9xCgssITtacQY5+rdG7Uqu2t2auj1fKSnfyERcWLU1ayX+OSDlCNsUl1iXJSyxOITpO+WlLjY9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322597; c=relaxed/simple;
	bh=xyu2W+AkhEUFrLCZO/aFXuBzwn1sWoS3HvpP6+mglTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJz/gKdIhFBhawGsiCzu/ZhvfVOX3nC9FtEIRHQ7RLkthxbEEKrLvfMUjN5n52ioISHP5VROnADp8GWsE3oFKbtSf2mgy7+JAGQT2KmlYuu1ITej8PKFaSGYURHNAVD2PCUjVQeJYp1XFIlRl/PuiAb4L8J+ICBXg/2cFEHQGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=il/YDmB/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731322595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PzxqFjD6NsHew4NyK62jDoA1MQuiNh2M1h/kJUKkO+w=;
	b=il/YDmB/rKdLU0paZKBte+vzrX65cqqNejz8gwzFPrrV9c6Q2Tgyw1txfLUNp1oX5artx+
	IwnzgwT0rrif/7iBaTyiLEKzM+RX7tWIgsmF7uWlyn0D18b0doUEzlK11W+jIQQrbxHwFp
	hTk2/yjr6SDUtCOwzOAu2Sa5iI8ZS+g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-tX_-tBiMNumxF_u03GvLBw-1; Mon, 11 Nov 2024 05:56:33 -0500
X-MC-Unique: tX_-tBiMNumxF_u03GvLBw-1
X-Mimecast-MFC-AGG-ID: tX_-tBiMNumxF_u03GvLBw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-381d0582ad3so3654896f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322592; x=1731927392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzxqFjD6NsHew4NyK62jDoA1MQuiNh2M1h/kJUKkO+w=;
        b=ssUEQvaFA6h3yLG16VR415nqMxKqU7My2rKhI65rFeRWeAY5PCyVmUCmmDYeG3HDP1
         p1N/FzE3A6ubY/0/bHhCEy/hrP96gkKghO/TlpqQssYUUHoZHxKF/s63uV93nYpCamtA
         KeGNQkwh4BLCkU32prw5BBpCfXziKjouI0hBwOukKYWBlR1E3Xb8O8ia/PtAV7nYZbDb
         nr1GXc5PNUkc6OEBS/L+4iIfhQjoxWBFOY1gvFsJyGTh5PiTLuRCnzuccCL/qlQheww/
         +Ywc0jTWnQSAXWcVIlrzEATZBmFmiRhXVHpxYnln0vFglyWk+KCNUtiL8ozlaNL4rLrQ
         XUyA==
X-Forwarded-Encrypted: i=1; AJvYcCWzlobcqfl+Aaj0qah1/cn2Mvmk3UBNbr34L60XEjMEFDMJgAZtFKuYY6HdRZkvPDo2wcBSB3jANS4aCMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEfakIUbjypY6DoWMusWS6JqqYEJRyoIeohAOr+4XCwzCC62B
	8NMBpaWFeRIKVYGvCHPuAXJFRQ/HUVe8X6Y2khyZrBgLAozuY3Qb3f2m/7K4caAZCvp81yD+Cn2
	/4sybF+AaBp3Py7+hFtXn2XdoNK0ZvwwKNHMWnJNKvcZAGw26kvuwhlAxacOTVA==
X-Received: by 2002:a05:6000:782:b0:37d:612c:5e43 with SMTP id ffacd0b85a97d-381f1838df9mr13309458f8f.0.1731322591716;
        Mon, 11 Nov 2024 02:56:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4fjQnzFja0IJnI8AD28pvo7qsfh9Pd6dcZnWBKwZ9TR9z3dtExcl6hKH6mrCYf74gr9Y9+w==
X-Received: by 2002:a05:6000:782:b0:37d:612c:5e43 with SMTP id ffacd0b85a97d-381f1838df9mr13309436f8f.0.1731322591400;
        Mon, 11 Nov 2024 02:56:31 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-250.as13285.net. [89.240.117.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9f8984sm12792910f8f.71.2024.11.11.02.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:56:30 -0800 (PST)
Date: Mon, 11 Nov 2024 10:56:29 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cgroup/cpuset: Enforce at most one
 rebuild_sched_domains_locked() call per operation
Message-ID: <ZzHi3VIQAx4AJ3lP@jlelli-thinkpadt14gen4.remote.csb>
References: <20241110025023.664487-1-longman@redhat.com>
 <20241110025023.664487-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110025023.664487-3-longman@redhat.com>

Hi,

On 09/11/24 21:50, Waiman Long wrote:
> Since commit ff0ce721ec21 ("cgroup/cpuset: Eliminate unncessary
> sched domains rebuilds in hotplug"), there is only one
> rebuild_sched_domains_locked() call per hotplug operation. However,
> writing to the various cpuset control files may still casue more than
> one rebuild_sched_domains_locked() call to happen in some cases.
> 
> Juri had found that two rebuild_sched_domains_locked() calls in
> update_prstate(), one from update_cpumasks_hier() and another one from
> update_partition_sd_lb() could cause cpuset partition to be created
> with null total_bw for DL tasks. IOW, DL tasks may not be scheduled
> correctly in such a partition.
> 
> A sample command sequence that can reproduce null total_bw is as
> follows.
> 
>   # echo Y >/sys/kernel/debug/sched/verbose
>   # echo +cpuset >/sys/fs/cgroup/cgroup.subtree_control
>   # mkdir /sys/fs/cgroup/test
>   # echo 0-7 > /sys/fs/cgroup/test/cpuset.cpus
>   # echo 6-7 > /sys/fs/cgroup/test/cpuset.cpus.exclusive
>   # echo root >/sys/fs/cgroup/test/cpuset.cpus.partition
> 
> Fix this double rebuild_sched_domains_locked() calls problem
> by replacing existing calls with cpuset_force_rebuild() except
> the rebuild_sched_domains_cpuslocked() call at the end of
> cpuset_handle_hotplug(). Checking of the force_sd_rebuild flag is
> now done at the end of cpuset_write_resmask() and update_prstate()
> to determine if rebuild_sched_domains_locked() should be called or not.
> 
> The cpuset v1 code can still call rebuild_sched_domains_locked()
> directly as double rebuild_sched_domains_locked() calls is not possible.
> 
> Reported-by: Juri Lelli <juri.lelli@redhat.com>
> Closes: https://lore.kernel.org/lkml/ZyuUcJDPBln1BK1Y@jlelli-thinkpadt14gen4.remote.csb/
> Signed-off-by: Waiman Long <longman@redhat.com>

This indeed works for me and fixes things with the test above (on v2).

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri


