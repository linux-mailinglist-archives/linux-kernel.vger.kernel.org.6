Return-Path: <linux-kernel+bounces-564901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B41A65C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34483B3C10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CF71C84A2;
	Mon, 17 Mar 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="S+zOsbPz"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286419048F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235893; cv=none; b=Yt3uLrpz37/dTPjMX4gwPwSQcQu8YOndsDYdiBTV5BimByBW4YWofpKMkrNu/c6htwznYfIO4X5C8oqaA2oWKPxTzF5ZF+sRDAkTCfJNkF3p2grzKFiH+SjHk8fvTrbb4GE5/pe7i0f+HKKJ6gsK+/byrSERcKgsFa0G4VsHG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235893; c=relaxed/simple;
	bh=+q0Pkl+0ut0ZVjPhp2WhARVxM+/p2oXgrwzMBgwbvRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndtvv72bALe7f8BeTxO/HKiX08Lsa1GvyyQ2omTp6hVxJDNxcQVR2z1YnkcISISxA/gacMGAtCGEL3+6AvqH6+mujL+6pIrO74Rm72tvMbpKy9SNBWNBgHlfuv2quII57pshg3TfB4XIJ/AYb31LrgFT+XcFhQEN6zHIacqOlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=S+zOsbPz; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6eafac1f047so20695956d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742235891; x=1742840691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qffRqeeaN/xyBcdXkC41yRxHN6rIHMJ0xVP8VR6XDiU=;
        b=S+zOsbPzXvOeTYmuwGfJEWugAi/zOutyfHoYSVlcRLykMEIrMn2os7QgNOrVM8DoHT
         IdhzBsHvbvr+KnWHNgHUsBzD5YlsAcwYtQq7FyYWRQuc8wLrIAlNSIB9JyDyQpn4ruOi
         1BIEKmJLXbruJ3GHovYpF0W+MkuHsuT5IfMqZfzboBrYQWIGPSPhXN8Xv1KA53OmCQcb
         W1qzVC3B7XAcbEe+nrHyo6gqDWIX2hOHcw0D/6Zm42N67OV+7Mv/v3iwm6QTm/1iyDHl
         pHRf0EHF1HN1WU5giXGlKYG3+getQ0m+sU4FsfP6JMdOgCMEfTdca16xOnM4WyZPfvbK
         +yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235891; x=1742840691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qffRqeeaN/xyBcdXkC41yRxHN6rIHMJ0xVP8VR6XDiU=;
        b=CdrUe75Y9d0Inxdy0roawUSMfgOGJ0Cs1FDMJw9y6fPkIRgmXCvY28hlJvufTrooX0
         +/vC6qIPszUpSP9qJrfPlb56lM5wcCZUBPnfFKH/y85rwkyK0wxrHa+djYyJcuRIl7Qp
         s7dpNJ1EhEYhUOIN2e13RvNoC009+63/tNV3P3Ue7+odHjs2Cws0zzMHKMIesfVICWTe
         +qojueXc/qbs8AjOCZdRyEUSlvv/bOzmKWew8vrIoNhVzopsNECJf6ElUeRn7kQB0twb
         7GXwJeW8vX3GWFckA/eZvuX7ra0gdQx9Ua2uT4vpGixAob7oW064PT6ii3jsCDuOqO10
         qdZw==
X-Gm-Message-State: AOJu0YwPOyciUfqR3VAL2MOHIK3h5ICGzbAMpr/SQof5+EuL2xg1cril
	uIKKwcTt5tTxrZ6rrbIYWDAvW6I+vNMErl2yTUi69x3OcQM5REESf8qb1CHxeOE=
X-Gm-Gg: ASbGncuwITNBDoyRJj+V7V3UI2jxRmJR8TPjycNfreXJmRNYo9nue3gXXW4yJwzwb1O
	yiV7pocfnyugQkRlj5DGbmp4e8MzqDFb7/+kZDErkjj4SCrAUhsZvvNLkW6yboteBlDH0oj94ZJ
	yPlJ4ss8GkRvvQONhDAvZtScPNgecUeVTuh8v+K86k76lR/4iydgraI5gRNm08DmAqiu//Zg1yL
	u9HejL6Dpi4P2UHJ2XWZ75FzzhlpU6SFIqktsCaD1ddL9x+E/iDn6ANw+smddWLNHGUZdKUVequ
	B+4yc4PYFuTw9TU0PhWsgyaFaUcC8BCdCNtu5fwMicyIC9L53atDyqcofN+Y7GMTRVNAjtU1zRN
	fPKJ+7qWGdHZrhVruIn6/0NxapnaXxt5i1+FC1A==
X-Google-Smtp-Source: AGHT+IECAQV2W4ZfXVx/cTTr/lq8wcLUfss4PApt70+7/vAmtkEDvbuW09xiFSiw2Zhgj5gShBbs2g==
X-Received: by 2002:a05:6214:2626:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6eaeaad4dd7mr242589906d6.34.1742235890789;
        Mon, 17 Mar 2025 11:24:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eaef289853sm39397646d6.25.2025.03.17.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:24:50 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:24:47 -0400
From: Gregory Price <gourry@gourry.net>
To: Bharata B Rao <bharata@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Jonathan.Cameron@huawei.com, Michael.Day@amd.com,
	akpm@linux-foundation.org, dave.hansen@intel.com, david@redhat.com,
	feng.tang@intel.com, hannes@cmpxchg.org, honggyu.kim@sk.com,
	hughd@google.com, jhubbard@nvidia.com, k.shutemov@gmail.com,
	kbusch@meta.com, kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com,
	leillc@google.com, liam.howlett@oracle.com,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, raghavendra.kt@amd.com,
	riel@surriel.com, rientjes@google.com, rppt@kernel.org,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, yuanchu@google.com
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
Message-ID: <Z9ho77H94jsLHDNu@gourry-fedora-PF4VCD3F>
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
 <20250313164430.bzkfyqmx6a5dj7d2@offworld>
 <b9965654-af90-42c9-8e4b-b29621d11ea7@amd.com>
 <Z9g6JIAPZof2eFbJ@gourry-fedora-PF4VCD3F>
 <038d0332-2146-4bda-adf6-03ef58dcc3b5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <038d0332-2146-4bda-adf6-03ef58dcc3b5@amd.com>

On Mon, Mar 17, 2025 at 09:52:29PM +0530, Bharata B Rao wrote:
> > 
> > > kpromoted_recorded_accesses 960620 /* Number of recorded accesses */
> > > kpromoted_recorded_hwhints 960620  /* Nr accesses via HW hints, IBS in this
> > > case */
> > > kpromoted_recorded_pgtscans 0
> > > kpromoted_record_toptier 638006 /* Nr toptier accesses */
> > > kpromoted_record_added 321234 /* Nr (CXL) accesses that are tracked */
> > > kpromoted_record_exists 1380
> > > kpromoted_mig_right_node 0
> > > kpromoted_mig_non_lru 226
> > > kpromoted_mig_lru_active 47 /* Number of accesses considered for promotion
> > > as determined by folio_test_active() check */
> 
> However disabling demotion has no impact on this number (and hence the
> folio_test_active() check)
>

I've been mulling over what's likely to occur when the Low but not Min
watermark is hit and reclaim is invoked but without demotion enabled.

I'm wonder if kswapd pushes things like r/o pagecache out, only to have
them faulted back into CXL later, while new allocations stick on the
main memory.

You might try MPOL_PREFERRED with CXL node as the target instead of bind
w/ the local node to at least make sure the system is actually
identifying hotness correctly.

~Gregory

