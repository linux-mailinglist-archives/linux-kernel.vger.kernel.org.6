Return-Path: <linux-kernel+bounces-268062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED0941FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572201C2351F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B91AA3D5;
	Tue, 30 Jul 2024 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6i1Nly1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6441AA3FF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365092; cv=none; b=Fm1KMnhoBkRvVGN3iN0w8J2tOwvvoeQO90+OhFmHwF8OzLPORGB8e28El0u+//7VPMuR1lk01jL+Hv3UJ9oyjL6GhW4tydNE87/2tG4z23xoNYZqVhj16OtrgyJz86yONjyb84huZiqpsaZmEgHsOTNGGtWXjhOL3qw3AGQlfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365092; c=relaxed/simple;
	bh=Y+/gz5qUpoR25K+n24Wpy2AG2PBd/RlwCNDMhPpD2Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTKL/L+TvY3sAV/FX+6Bqjl217NdAjtp/s5v0bLOEbr9kSNk5Snz8lhNyXJd3fdxO8nlExP0i0MMmQ8WlUVNOhh6Slidc8gTU+ystAUmr3jdv8ZW5kyUqnOgHcZiYNTYCPPYmfxqmH6Gj9+zHGVICVxiWfw2vBilmx5j9gJ/6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6i1Nly1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722365089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=we6cMjtS27X2yzrxa43xXf+7pMvZNESLxYR2e6Nhvxo=;
	b=D6i1Nly1jLQPt8pqJz3DXrRB1ofPP4mQf3JmmrhMJM/CrUWHR9cY1Y3EEAIeWfHYYNbJtW
	BPNl7bVO5QvEeT/BVDUkyy5MNezOL1mUSo35ZSWujghcTX3CnarEh6TEigb4y+6N1fAMP2
	4lVPE0wRWD+AbSqCO6RhV1AETB5x1P8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-m13H86mmO_-_vtdU97dVJw-1; Tue, 30 Jul 2024 14:44:47 -0400
X-MC-Unique: m13H86mmO_-_vtdU97dVJw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44fe325cd56so6128091cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722365087; x=1722969887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=we6cMjtS27X2yzrxa43xXf+7pMvZNESLxYR2e6Nhvxo=;
        b=EtQvDNmlXABH3lksqTlg7OBZgk2dvYHFDT+QoUHe/JPY6rEcjlGhDTuOx8sPHBSAnp
         kFnyGjrKuT+b96pO463Ly+V6XztaNYWxDR23ct3WGHqTjG6XXSspGfyYxm1HfNyURLcF
         sRiuN49tWmPNHaQcHNMlUTeAwGmtfJDCx20UAn9IGRE7NmkC4FogAuRGCRfBXmJExPkd
         Q8xdOkrAMTC0QwTEA+VHs/2cW9zX8KoIfj7GRsOFb/oqmuBzgjTyIc1ZX7gGs9IUv8U6
         hPng//axZN54o6ed78cJoTV+uDzEYhEZD/JGnGdGcm8CfWTtDGV1VveArKivzDAN8Ckw
         0Kyg==
X-Gm-Message-State: AOJu0YxZDzNhc9UM2I8I7osWV1dXNblglBektYvPvYc3vRBl9vhSb5Nr
	fO8lyjnzm237f6hBXmn0K8bfCPntoOq/z+a3UtKoe9zgdQ4sfvRgpFx3APnEF9IcuorBLNgBCKO
	31zXfJ+oVGVK4PzZCw9Z8+05tPwG0ovCnQJko8wwkd5XXq/nwX0cl/ud4E+wXbQ==
X-Received: by 2002:a05:620a:2910:b0:7a1:e3e5:c6f with SMTP id af79cd13be357-7a1e3e513fcmr947293885a.9.1722365086958;
        Tue, 30 Jul 2024 11:44:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHolbPklLWmv/+R+6JBgiAi3Lho9VqEd+2NZnVAe5Gt7Uz8YEdpcpKWmhat3pinDVriarC6Yw==
X-Received: by 2002:a05:620a:2910:b0:7a1:e3e5:c6f with SMTP id af79cd13be357-7a1e3e513fcmr947292385a.9.1722365086408;
        Tue, 30 Jul 2024 11:44:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b2341sm668734685a.39.2024.07.30.11.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:44:45 -0700 (PDT)
Date: Tue, 30 Jul 2024 14:44:43 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
Message-ID: <Zqk0mzD68lImF3y4@x1n>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com>
 <ZqPCjd35OdNRrcfl@x1n>
 <bf2069ed-f2b8-49d4-baf0-dbd2189362f9@redhat.com>
 <ZqQVDwv4RM-wIW7S@x1n>
 <9e671388-a5c6-4de1-8c85-b7af8aee7f44@redhat.com>
 <ZqfCmFUFyPU3WGES@x1n>
 <ZqfF2hhe60TE8xhQ@x1n>
 <da433043-d17c-43e0-ab6f-c4897061b4a1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da433043-d17c-43e0-ab6f-c4897061b4a1@redhat.com>

On Mon, Jul 29, 2024 at 07:46:26PM +0200, David Hildenbrand wrote:
> I see what you mean but this is a very similar pattern as used in
> collapse_pte_mapped_thp(), no? There we have
> 
> start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
> ...
> if (!pml)
> 	spin_lock(ptl);
> ...
> pte_unmap(start_pte);
> if (!pml)
> 	spin_unlock(ptl);
> 
> 
> Again, I don't have a strong opinion on this, but doing it more similar to
> collapse_pte_mapped_thp() to obtain locks makes it clearer to me. But if I
> am missing something obvious please shout and I'll change it.

Right.. I don't think that path can change the pte pgtable either, and
there is even the line Hugh left showing it's impossible:

	if (!start_pte)		/* mmap_lock + page lock should prevent this */
		goto abort;

I was thinking maybe the page lock is the critical one, irrelevant of mmap
lock.

No strong opinion either.  Not sure whether Hugh has some thoughts.  But
maybe if we stick with pte_offset_map_nolock() and if there'll be a repost
anyway, we could add a similar comment like this one showing that the pte
pgtable should be actually as stable as the ptlock.

Thanks,

-- 
Peter Xu


