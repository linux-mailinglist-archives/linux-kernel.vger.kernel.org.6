Return-Path: <linux-kernel+bounces-318721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A696F210
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90581C2400C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CAF1CB12A;
	Fri,  6 Sep 2024 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwHWAXW9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D91C9ED5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620381; cv=none; b=fHTmOtpkqDWzgFUcM8oNwYMKgNj/rwGwwflyax3cGHiZfnNhZKwnEIYTSK+bveIHGx8xGpF37+yrY016xByR9h1rUuc6CubWqHWelKBL7YkEl8SJIcUh0d9iePBjDYiqrpfk7sgFKDBM/2yM9FcF5mmj9aM6AYCzWNV9IgOexnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620381; c=relaxed/simple;
	bh=EtzK19wel6k8Ao3cms7f+E+8BJxjGUM+HfEDLVZrszI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sr4Bcy23HRf/E/WGgg6HpDWYCxUBSefHIK/KY3FsOdYl68cQtnHKqYm3sHhYV9gbLkPHIj03bzGOyzJ0Yp37EZVPziLKCgrfyB6it4aFb2zqXtSADykCmwbWqJH2XG4UNMioVykFFyYbZa0Xdwt30ZRLthms4iVjG8TjP8ibARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwHWAXW9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725620378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lii+zCyvH1nupBnz/bs5CIqcmUeaf64t1+wdh+5exj0=;
	b=hwHWAXW9YOJeA8gneF/I74vPxa3t5zqm6OqIat45p8sygxPSKm6QpzQ2eOekzShTKe5uQm
	KmJ4HH6XndNPzmaH7RQf3FGyZZnDIf42s+Ini/CVYCWlIcXwu69by7J6zFdlso59Ru3eUV
	3ZnW/ldHkewr10OYk0mRDJRynQRr8oE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-HweLr_pDN5ybzRciXidryw-1; Fri,
 06 Sep 2024 06:59:35 -0400
X-MC-Unique: HweLr_pDN5ybzRciXidryw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 028191955BC1;
	Fri,  6 Sep 2024 10:59:34 +0000 (UTC)
Received: from [10.45.224.222] (unknown [10.45.224.222])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0B911956086;
	Fri,  6 Sep 2024 10:59:30 +0000 (UTC)
Date: Fri, 6 Sep 2024 12:59:25 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
cc: dm-devel@lists.linux.dev, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, Tejun Heo <tj@kernel.org>, 
    Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] dm verity: don't use WQ_MEM_RECLAIM
In-Reply-To: <20240905223555.GA1512@sol.localdomain>
Message-ID: <c0002bca-efa0-b0b3-9c02-268c727c989c@redhat.com>
References: <20240904040444.56070-1-ebiggers@kernel.org> <086a76c4-98da-d9d1-9f2f-6249c3d55fe9@redhat.com> <20240905223555.GA1512@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On Thu, 5 Sep 2024, Eric Biggers wrote:

> On Thu, Sep 05, 2024 at 08:21:46PM +0200, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 3 Sep 2024, Eric Biggers wrote:
> > 
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Since dm-verity doesn't support writes, the kernel's memory reclaim code
> > > will never wait on dm-verity work.  That makes the use of WQ_MEM_RECLAIM
> > > in dm-verity unnecessary.  WQ_MEM_RECLAIM has been present from the
> > > beginning of dm-verity, but I could not find a justification for it;
> > > I suspect it was just copied from dm-crypt which does support writes.
> > > 
> > > Therefore, remove WQ_MEM_RECLAIM from dm-verity.  This eliminates the
> > > creation of an unnecessary rescuer thread per dm-verity device.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > Hmm. I can think about a case where you have read-only dm-verity device, 
> > on the top of that you have dm-snapshot device and on the top of that you 
> > have a writable filesystem.
> > 
> > When the filesystem needs to write data, it submits some write bios. When 
> > dm-snapshot receives these write bios, it will read from the dm-verity 
> > device and write to the snapshot's exception store device. So, dm-verity 
> > needs WQ_MEM_RECLAIM in this case.
> > 
> > Mikulas
> > 
> 
> Yes, unfortunately that sounds correct.
> 
> This means that any workqueue involved in fulfilling block device I/O,
> regardless of whether that I/O is read or write, has to use WQ_MEM_RECLAIM.
> 
> I wonder if there's any way to safely share the rescuer threads.
> 
> - Eric

When I thought about it, I think that removing WQ_MEM_RECLAIM would be 
incorrect even without snapshot and it could deadlock even with a 
read-only filesystem directly on the top of dm-verity.

There is a limited number of workqueue kernel threads in the system. If 
all the workqueue kernel threads are busy trying to read some data from a 
filesystem that is on the top of dm-verity, then the system deadlocks. 
Dm-verity would wait until one of the work items exits - and the work 
items would wait for dm-verity to return the data.

The probability that this happens is low, but theoretically it is wrong.

Mikulas


