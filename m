Return-Path: <linux-kernel+bounces-413871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7F89D1FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FC7B224ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A9135A63;
	Tue, 19 Nov 2024 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjWAMEsv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562D150981
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996193; cv=none; b=tBj9sTDtQTSbKN911gvNPKJSPJUectziXiNkz16+DRGpJ/eLjQE3F495faUaqKdlHJV0N12+BKXc2b8imZNsMhbH8VyhFsvD2Ru7QJ4L8Ahw+BDEv7PFWsRNAMUXsDiMBK74qkwPffJ4as89U7tVudDlJ7fwLi84t8uphvOP9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996193; c=relaxed/simple;
	bh=Mlb24BR91olr/c0PnTtI9xuV2wUp7nrG4b18G/p3hGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/KooZYOe+5/8U5skFoAYmQxOqu1o60PBDOvKR6aEun1dZsehrAZ/va68HL4ozV+C4qwFPhDoaYyOW6hM6/d1I/O7P3SKsVRp6eusiSmA0xJjJVkm4cq043xDqzc/h6E0EpSLXvrQiRfLD6vLfRP72s7+S2Vkx5LKQ2cSNS00kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjWAMEsv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731996190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVNYyqpnD/KRHanFC8wz+cSrFTnAk34SdUd5nLIOvCk=;
	b=NjWAMEsvO855dvBw+/neaKoY4x/9O87BevKM2tnQR/Xf/pAZ/RzuhjKLO5nFL94zrV/ySw
	gOioxdEJsESFPiLdc+Qyg8MqxiSY1rAMDaIzcvtp6rWkAK+9SyQBamlPlu/fF59ezz6qRI
	2mALurgtj/kHRL9/8grZCTJguO4USSY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-fNsNxG7jNiuw1yxqSXzW5g-1; Tue, 19 Nov 2024 01:03:08 -0500
X-MC-Unique: fNsNxG7jNiuw1yxqSXzW5g-1
X-Mimecast-MFC-AGG-ID: fNsNxG7jNiuw1yxqSXzW5g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316300bb15so3927035e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731996187; x=1732600987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVNYyqpnD/KRHanFC8wz+cSrFTnAk34SdUd5nLIOvCk=;
        b=hY3xhKkrRLvE6iwIA+U5qdH+pCGXUx0/xcrwcgG9p+nLG0JARy1xXjlQwkF0bYbdPF
         RnNByNexxbyxlgnBCRXrMdBoP0MtHJWjiMHfL63v8ntJdDbGBLvQSbCyBIT+JDZnMj9m
         2Tkj+C9kduHrIcvXUdkQ0pfk+saU6jzT6vKvIAlTVN0fVyQwA7WxwAHKxAOT+LA9Z+7h
         gxV9A0HC3p83+QvUrPnhqSHGyDuk2aH5+GjEV9L7P36xbSJo5TNLBHT6ImIpT71lacHp
         rN+tkSa5tmVA9r4eNQAK3IsdjM4slybvAsl8xjPC/GB9WeHkVXDdTPG8kqc+SQToo5+3
         ow0A==
X-Forwarded-Encrypted: i=1; AJvYcCUboeerND0O6wKqF75gbpNjpiVDUF4fuTjqZ27c3YVtpwqU7IdypWoyxRzJxvYIJGeLGriQlycN1x/OGxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTTmyPqNtDR0NVEpIRXFAOgCkujA18ihHVuuIX8nnQHgYNlWo
	skpfTdo/+d/3+tIhDgm49vwXbbtUNv7pH9wJsa4+Y87bylusz+paSt9d+GIQz9IVPuUKdFuBuxV
	mb0byajmQzRlPWG7WeNBp3A8VXMMyUcaLHMS+LiuxNxn7eJYgLJPqxIaGDlAKbA==
X-Received: by 2002:a05:600c:b8f:b0:431:561b:b32a with SMTP id 5b1f17b1804b1-432df74cd6fmr127476875e9.19.1731996187381;
        Mon, 18 Nov 2024 22:03:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFohqQmUxnR8N9/g+dNimT9dXzE/ioMgWVayD6md4T0F7iMNpwZ/ZqX5QIL5sixzMqeMnItFw==
X-Received: by 2002:a05:600c:b8f:b0:431:561b:b32a with SMTP id 5b1f17b1804b1-432df74cd6fmr127476655e9.19.1731996186994;
        Mon, 18 Nov 2024 22:03:06 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.74.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80869sm179708965e9.22.2024.11.18.22.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 22:03:05 -0800 (PST)
Date: Tue, 19 Nov 2024 07:03:02 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
Message-ID: <ZzwqFkzGACnbiTJW@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114181915.142894-1-longman@redhat.com>
 <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
 <1515c439-32ef-4aee-9f69-c5af1fca79e3@redhat.com>
 <ZzsLTLEAPMljtaIK@jlelli-thinkpadt14gen4.remote.csb>
 <5a878687-9d08-472e-a387-02b2a150d2df@redhat.com>
 <c3354d87-a856-421b-a03e-cda2f1346095@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3354d87-a856-421b-a03e-cda2f1346095@redhat.com>

On 18/11/24 22:28, Waiman Long wrote:
> On 11/18/24 8:58 AM, Waiman Long wrote:
> > > > The failing test isn't an isolated partition. The actual test
> > > > failure is
> > > > 
> > > > Test TEST_MATRIX[62] failed result check!
> > > > C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 . . X5 . . 0
> > > > A1:0-4,A2:1-4,A3:2-4
> > > > A1:P0,A2:P-2,A3:P-1
> > > > 
> > > > In this particular case, cgroup A3 has the following setting
> > > > before the X5
> > > > operation.
> > > > 
> > > > A1/A2/A3/cpuset.cpus: 2-4
> > > > A1/A2/A3/cpuset.cpus.exclusive: 4
> > > > A1/A2/A3/cpuset.cpus.effective: 4
> > > > A1/A2/A3/cpuset.cpus.exclusive.effective: 4
> > > > A1/A2/A3/cpuset.cpus.partition: root
> > > Right, and is this problematic already?
> > We allow nested partition setup. So there can be a child partition
> > underneath a parent partition. So this is OK.
> > > 
> > > Then the test, I believe, does
> > > 
> > > # echo 5 >cgroup/A1/A2/cpuset.cpus.exclusive
> > > 
> > > and that goes through and makes the setup invalid - root domain reconf
> > > and the following
> > > 
> > > # cat cgroup/A1/cpuset.cpus.partition
> > > member
> > > # cat cgroup/A1/A2/cpuset.cpus.partition
> > > isolated invalid (Parent is not a partition root)
> > > # cat cgroup/A1/A2/A3/cpuset.cpus.partition
> > > root invalid (Parent is an invalid partition root)
> > > 
> > > Is this what shouldn't happen?
> > > 
> > A3 should become invalid because none of the CPUs in
> > cpuset.cpus.exclusive can be granted. However A2 should remain a valid
> > partition. I will look further into that. Thank for spotting this
> > inconsistency.
> 
> Sorry, I misread the test. The X5 entry above refers to "echo 5 >
> A1/A2/cpuset.cpus.exclusive" not to A3. This invalidates the A2 partition
> which further invalidates the child A3 partition. So the result is correct.

OK, makes sense to me. But so, the test doesn't actually fail? Sorry,
guess I'm confused. :)


