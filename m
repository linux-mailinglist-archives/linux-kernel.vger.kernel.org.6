Return-Path: <linux-kernel+bounces-412650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B49D0BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DED1284D72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E175A190499;
	Mon, 18 Nov 2024 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYU9brEX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4421714A1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922777; cv=none; b=entcTmQI4BXf+SWGq9TW19ilwMcKJ7ydFovIw96vsSfOLqg7XFSmDFMRNgA5yj5aXhaZXRtvnK/7RITvpMXWPPcc+aYOclplpjC0AnmiqLKjK4GliFbLY0bTzLtF71r7Y0iLuTTBmbLU5RgA2pADaTkYObTIu0pzvphccbv95fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922777; c=relaxed/simple;
	bh=ASfy3ZmkJlDJivURpQuQX8Ww/zzWEUu+7CDd1iXeFdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmpCL6bQCFFgu8opVi2DlYtR+Nn1dfAiryqEOM7KiDSuO8Z8d4mCmEqk24LR6Ig6gSGy81vUJYqiHS1FdTGw2Uw6loTrBtbAuwfGLarCk7hZWMYS280V46iOffuWyzK+cPjxbNCpceJZulMnAyf1bykGhO9K7lKOz67sBSTpJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYU9brEX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731922775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCTWIW9+3Ez/dT5JWYg8kZzlPGcdYEYTLifRWAR2waM=;
	b=hYU9brEXFZs1ZdxOctdkXibu3yjTgG2dAh7FjonoooGNlIyJxdtlZgwdRKs9k7cFF3jDNJ
	+FBh1p2Pd68vEBHV4Gnnhli9QVmS5cJl0JDAwHy6pOwmFNfndmq1QGq/ktE03v0ZQvpp9g
	kcpOsfEBMnFFxkJWxohHoWw4717Og8A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-ZTeTGCDzNY6yjwlaUiL5Ww-1; Mon, 18 Nov 2024 04:39:32 -0500
X-MC-Unique: ZTeTGCDzNY6yjwlaUiL5Ww-1
X-Mimecast-MFC-AGG-ID: ZTeTGCDzNY6yjwlaUiL5Ww
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315eaa3189so18217985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922771; x=1732527571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCTWIW9+3Ez/dT5JWYg8kZzlPGcdYEYTLifRWAR2waM=;
        b=NXIA2zUnbE9Qermw/cys0sIopo2hWUbpitxugGB3NjIKfoT/p4pxCCmEcssJ4Xu/MW
         +6DmNXOdUZ0laUKS7MpL6JApKXm/hQeHzuxMS4wejS2iVrsJyoQxoWa6mKd5hCv94H70
         XZr85X834HaPwcIPE3BTXbTg603uPaI0iiB6MshF0Wfwb2eEQxImBLDHv0kcZqg15AOA
         2jQtbW28Zq8SHe1K0m4B156iCfAjTKIGBrk+5535ael35pk/7aaJT7Y4x0oLS8giEDDj
         vXtslTB6iF1LQANlkbReje7fmlqTYzvwa9ZkbKmWl9pP9kfTUpyC8xblvW24FZSXuU9+
         O+jw==
X-Forwarded-Encrypted: i=1; AJvYcCW/yYlIx363Z5/fcjp492qVa0wZdn+xM2GKpeyHwoxDlgHXq9HQIp4fYn7qbGhFS3rpDx4gXEjKYnlXKhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSmlbfa9Cak70CJEQ3jompeQghQfM8zx7D5sgkcTFle7is/A4
	p8eArujJ4gwtDEHnB6kC9QXFZGoUnM8j/rCJdPxrwOXycYB0a/Rkysnn1N2ME1DrjbBT5qFhEoa
	yhi0XL/+rVtjjnIa673u5E5PSpE9UDXyfzT4EfggnR2vCtLTrGg8ow4f/Ve3+EOa9FzfXfkmY
X-Received: by 2002:a05:600c:34d0:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-432df7229f6mr121513865e9.6.1731922769576;
        Mon, 18 Nov 2024 01:39:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc6yVpDr/TaAuyJ9tO0NDlNPWZ/GE7BRdiwq0stPKiYiB6rMVLY2MnHX6hc4DRwRnWcOGDEA==
X-Received: by 2002:a05:600c:34d0:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-432df7229f6mr121512985e9.6.1731922767768;
        Mon, 18 Nov 2024 01:39:27 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.74.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab807d4sm148437785e9.21.2024.11.18.01.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:39:26 -0800 (PST)
Date: Mon, 18 Nov 2024 10:39:24 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
Message-ID: <ZzsLTLEAPMljtaIK@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114181915.142894-1-longman@redhat.com>
 <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
 <1515c439-32ef-4aee-9f69-c5af1fca79e3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515c439-32ef-4aee-9f69-c5af1fca79e3@redhat.com>

On 15/11/24 12:55, Waiman Long wrote:
> On 11/15/24 5:54 AM, Juri Lelli wrote:
> > Hi Waiman,
> > 
> > On 14/11/24 13:19, Waiman Long wrote:
> > > With some recent proposed changes [1] in the deadline server code,
> > > it has caused a test failure in test_cpuset_prs.sh when a change
> > > is being made to an isolated partition. This is due to failing
> > > the cpuset_cpumask_can_shrink() check for SCHED_DEADLINE tasks at
> > > validate_change().
> > What sort of change is being made to that isolated partition? Which test
> > is failing from the test_cpuset_prs.sh collection? Asking because I now
> > see "All tests PASSED" running that locally (with all my 3 patches on
> > top of cgroup/for-6.13 w/o this last patch from you).
> 
> The failing test isn't an isolated partition. The actual test failure is
> 
> Test TEST_MATRIX[62] failed result check!
> C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 . . X5 . . 0 A1:0-4,A2:1-4,A3:2-4
> A1:P0,A2:P-2,A3:P-1
> 
> In this particular case, cgroup A3 has the following setting before the X5
> operation.
> 
> A1/A2/A3/cpuset.cpus: 2-4
> A1/A2/A3/cpuset.cpus.exclusive: 4
> A1/A2/A3/cpuset.cpus.effective: 4
> A1/A2/A3/cpuset.cpus.exclusive.effective: 4
> A1/A2/A3/cpuset.cpus.partition: root

Right, and is this problematic already?

Then the test, I believe, does

# echo 5 >cgroup/A1/A2/cpuset.cpus.exclusive

and that goes through and makes the setup invalid - root domain reconf
and the following

# cat cgroup/A1/cpuset.cpus.partition
member
# cat cgroup/A1/A2/cpuset.cpus.partition
isolated invalid (Parent is not a partition root)
# cat cgroup/A1/A2/A3/cpuset.cpus.partition
root invalid (Parent is an invalid partition root)

Is this what shouldn't happen?


