Return-Path: <linux-kernel+bounces-374231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AF49A6733
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E30E1F2177B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE681EB9E5;
	Mon, 21 Oct 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvrfPwfy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB581E8859
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511747; cv=none; b=uOIDIL6hswe2V6/cqEODuNlUrwWqPNfQxI9y2a7+KWdtFAsElD/W5wUt4gXTK6cei1IL3HdUffDCVrHoStnC93pp6U505TLzSef1kCFMw8FatXqSUBSb+jwOSfhDT5iEtnRdlSFH4APeeeF0XTWvn9hOus3qzlU+LJ238tzT1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511747; c=relaxed/simple;
	bh=X8WQ3z64pPNckXDxrJ4ml8wT6GrK7mqZvarVMujq0R4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tr+nEaRylEVgLktK9B08mstVOcZYyJTvozKrcg99G4PLKpwO+1fTEzYrw1dRO2DuhXyTNNG5aaZ6lEvF4jT81Uu7sMS0LIWER6qf5DT/5QVcG4toSJzcEtdrbuTwxyZ9r6uQwG4NezybLyPoLcuGjFXs2OzT+Ll4NXFiGJY7Gvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvrfPwfy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729511744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/WdBfswZMeJC269lngvZswt3QmM8KRMacxdnmmnXOwk=;
	b=SvrfPwfy/UyifFER45OUxJAWaIz8h7VHbfDOJzl8DvnX4Cxv/PlBGGj94AryqID3ezSZxy
	wccOqDJDpKmm1mNLbijLzu3h7POPNgBrPavKjrxwzqaFsIPTTC3eE1ipn+LUuCKmVdSPyv
	t35IcZd6F9wUGh+KYAuzofNcZOBW49M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-FxOyi2RSMaO4JaL_kXIPsw-1; Mon,
 21 Oct 2024 07:55:41 -0400
X-MC-Unique: FxOyi2RSMaO4JaL_kXIPsw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B913B19560A3;
	Mon, 21 Oct 2024 11:55:39 +0000 (UTC)
Received: from [10.45.226.64] (unknown [10.45.226.64])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD9CC19560A2;
	Mon, 21 Oct 2024 11:55:37 +0000 (UTC)
Date: Mon, 21 Oct 2024 13:55:34 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
cc: agk@redhat.com, snitzer@kernel.org, msakai@redhat.com, 
    dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] dm deadcoding
In-Reply-To: <20241003011554.266654-1-linux@treblig.org>
Message-ID: <f251e49c-d846-2c87-3914-2d4f8bf37e3e@redhat.com>
References: <20241003011554.266654-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi

I've accepted these patches.

Mikulas



On Thu, 3 Oct 2024, linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This is a collection of deadcoding in various parts
> of dm.  It's all strictly function deletion with no
> (expected) change of behaviour.
> 
> Build and booted on x86-64, but no dm tests done.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> 
> Dr. David Alan Gilbert (9):
>   dm cache: Remove unused btracker_nr_writebacks_queued
>   dm cache: Remove unused dm_cache_dump
>   dm cache: Remove unused dm_cache_size
>   dm cache: Remove unused functions in bio-prison-v1
>   dm: Remove unused dm_set_md_type
>   dm: Remove unused dm_table_bio_based
>   dm: zoned: Remove unused functions
>   dm vdo: Remove unused functions
>   dm vdo: Remove unused uds_compute_index_size
> 
>  drivers/md/dm-bio-prison-v1.c            | 35 -----------------
>  drivers/md/dm-bio-prison-v1.h            | 24 ------------
>  drivers/md/dm-cache-background-tracker.c |  6 ---
>  drivers/md/dm-cache-background-tracker.h |  1 -
>  drivers/md/dm-cache-metadata.c           | 33 ----------------
>  drivers/md/dm-cache-metadata.h           |  3 --
>  drivers/md/dm-table.c                    |  5 ---
>  drivers/md/dm-vdo/data-vio.c             | 29 --------------
>  drivers/md/dm-vdo/data-vio.h             |  5 ---
>  drivers/md/dm-vdo/indexer/index-layout.c | 26 ------------
>  drivers/md/dm-vdo/indexer/indexer.h      |  4 --
>  drivers/md/dm-zoned-metadata.c           | 50 ------------------------
>  drivers/md/dm-zoned.h                    |  2 -
>  drivers/md/dm.c                          |  6 ---
>  drivers/md/dm.h                          |  2 -
>  15 files changed, 231 deletions(-)
> 
> -- 
> 2.46.2
> 


