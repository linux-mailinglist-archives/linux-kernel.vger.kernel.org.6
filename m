Return-Path: <linux-kernel+bounces-396844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C8B9BD317
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E251C223E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C76F1DD885;
	Tue,  5 Nov 2024 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ekmp73Lt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39081DD0F9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826664; cv=none; b=d2kni2fHjZcEaMFdllIWSiyMhv4knhEGRki7fbcYfeaHbbAX4+0Z1uXE41jgtPYV+SfBltIKt1Awuy20naa5xZEJipzz3+4rSnaNObLuqOKXUOCdRtT9OyCEze+vp88RkyUORGz8aqho7nuw6Kfm+yda4ESKiLku8UiqllpdPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826664; c=relaxed/simple;
	bh=bq9xf0MdcuV97dUfsQhg494mQSv6D4lul3rFzDOgN6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1Ngn+47+R+kLN8nWmpp/Sn2oQ3Ym5000wwJ+JFneau/xpolzjBVa5Ur8/A/p7J7buBKSva467jHMPReP9GdhBiveW6NmWIYW1HzFnoBkba2x1L9pqozfMxXsnyl7rrLF6YsOvp1nLg6bTRay0mwXVdxJQTWgh9B2X+5rTTQzRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ekmp73Lt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730826661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X5ary5m+6+giBNSTWfRnA3AU+/fgGvJB2JlxwdSAVFI=;
	b=Ekmp73LtF0+7ZQNGlrj4nibVYq5XRc43X7WpoLjr7IcQUB/O1BX79VBsZ88fkW4/aVNiC3
	s4WNv8pSlYU/v2H5D8HZWbuUN5Hs2gnjQrvNgckwcl9FYhWMGbkUBw8XKAyXrQlarMuAJw
	weKwGtK0+V5/hNz/MVYLEP+QnqIRPPU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-9qFDlCftP-u8Vd-Vj-7Abw-1; Tue, 05 Nov 2024 12:10:59 -0500
X-MC-Unique: 9qFDlCftP-u8Vd-Vj-7Abw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6e32b43e053so81711717b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730826658; x=1731431458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5ary5m+6+giBNSTWfRnA3AU+/fgGvJB2JlxwdSAVFI=;
        b=dMr2e8OaNn0O1H9xPCeIC7qm1+rEfkUkxNYQBKNVDEtfh4xCnjxYalGGp/ppYjN5b3
         6Hl/YuUeized06IyIyfy9cWsH3opiQWqjuEyOlaOqgyqTKD9Z6290fLiY05L+pd5o4Y9
         IuOr2FYtegnS3G57Cl0gDLeFXKmpk1SrwfIeqiVHo5tcNUaajEuxqREA0y4tjC2j0fWb
         Nsm3k41R7V+M/S21Hg9VJmwULQk9jSBoLB88JvNROvyVtwEl6VFaNB5+XGML+ZrL+DBc
         KNhUMMpwbAxr7FcstZxraCwf1acUeUnLQHN1f/D3fhZKozpPviSMuiohvZJP7c/YZAzQ
         PguA==
X-Forwarded-Encrypted: i=1; AJvYcCXWyf93QjtY8i7p1bvQs3LnRIhGs16m5ShWtrz5eDxS+BuNxG0i0Hw9li1Oc0L65M9NSVJc+wu7bVoQVWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PTFf7/JVq/WsP1aI0o6gqM3acjv8lolQAEKkDvvrkQfRIg/G
	NOh1OvPot258bIAdEs9vZQ1jG/ehlmP7Qxsot14YLY2q7ig4kM4DnSL5ybjYivQKM3Xp5XuJZuT
	5h/CHP7jSgtZkClN+qVTErqB9A/WblNRnVLMz+yygA2GwPVVQvF6v6V8xxtCeEQ==
X-Received: by 2002:a05:690c:620f:b0:6e3:3227:ec64 with SMTP id 00721157ae682-6ea64bb1d36mr170331507b3.35.1730826658568;
        Tue, 05 Nov 2024 09:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX/FE7P3qC2CXMvuRrB7RjlcJ530vsCvz4/hDhCD92PXpxG3f295spbsi7aUlSyRqHCzUTZg==
X-Received: by 2002:a05:690c:620f:b0:6e3:3227:ec64 with SMTP id 00721157ae682-6ea64bb1d36mr170331117b3.35.1730826658111;
        Tue, 05 Nov 2024 09:10:58 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d354177e29sm61863956d6.108.2024.11.05.09.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:10:57 -0800 (PST)
Date: Tue, 5 Nov 2024 12:10:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, david@redhat.com,
	isaku.yamahata@intel.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, tabba@google.com, quic_eberman@quicinc.com,
	roypat@amazon.co.uk, jgg@nvidia.com, jhubbard@nvidia.com,
	seanjc@google.com, pbonzini@redhat.com, erdemaktas@google.com,
	vannapurve@google.com, pgonda@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/3] mm: hugetlb: Simplify logic in
 dequeue_hugetlb_folio_vma()
Message-ID: <ZypRnqssXG3sHCqU@x1n>
References: <cover.1728684491.git.ackerleytng@google.com>
 <b2b7be300469aa59933f08257c794675895d49f8.1728684491.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2b7be300469aa59933f08257c794675895d49f8.1728684491.git.ackerleytng@google.com>

On Fri, Oct 11, 2024 at 11:22:36PM +0000, Ackerley Tng wrote:
> Replace arguments avoid_reserve and chg in dequeue_hugetlb_folio_vma()
> so dequeue_hugetlb_folio_vma() is more understandable.
> 
> The new argument, use_hstate_resv, indicates whether the folio to be
> dequeued should be taken from reservations in hstate.
> 
> If use_hstate_resv is true, the folio to be dequeued should be taken
> from reservations in hstate and hence h->resv_huge_pages is
> decremented, and the folio is marked so that the reservation is
> restored.
> 
> If use_hstate_resv is false, then a folio needs to be taken from the
> pool and hence there must exist available_huge_pages(h), failing
> which, goto err.
> 
> The bool use_hstate_resv can be reused within
> dequeue_hugetlb_folio_vma()'s caller, alloc_hugetlb_folio().
> 
> No functional changes are intended.
> 
> As proof, the original two if conditions
> 
> !vma_has_reserves(vma, chg) && !available_huge_pages(h)
> 
> and
> 
> avoid_reserve && !available_huge_pages(h)
> 
> can be combined into
> 
> (avoid_reserve || !vma_has_reserves(vma, chg))
> && !available_huge_pages(h).
> 
> Applying de Morgan's theorem on
> 
> avoid_reserve || !vma_has_reserves(vma, chg)
> 
> yields
> 
> !avoid_reserve && vma_has_reserves(vma, chg),
> 
> hence the simplification is correct.

Some spacing is definitely good.. as Sean pointed out.

> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  mm/hugetlb.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 190fa05635f4..73165c670739 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1281,8 +1281,9 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>  	}
> 
>  	/*
> -	 * Only the process that called mmap() has reserves for
> -	 * private mappings.
> +	 * Only the process that called mmap() has reserves for private
> +	 * mappings. A child process with MAP_PRIVATE mappings created by their
> +	 * parent have no page reserves.
>  	 */
>  	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
>  		/*
> @@ -1394,8 +1395,7 @@ static unsigned long available_huge_pages(struct hstate *h)
> 
>  static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
>  				struct vm_area_struct *vma,
> -				unsigned long address, int avoid_reserve,
> -				long chg)
> +				unsigned long address, bool use_hstate_resv)

Here "avoid_reserve" + "chg" is indeed confusing, especially with the prior
"if (avoid_reserve) gbl_chg = 1;".  The new flag can make it slightly
easier to understand indeed for dequeue_hugetlb_folio_vma() alone.

I still feel like there can be something more to be cleaned up here even
after your patch 2-3, but I suppose this could be seen as a small-step
forward, considering one patch change will be harder to review.  Feel free
to take:

Acked-by: Peter Xu <peterx@redhat.com>

>  {
>  	struct folio *folio = NULL;
>  	struct mempolicy *mpol;
> @@ -1403,16 +1403,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
>  	nodemask_t *nodemask;
>  	int nid;
> 
> -	/*
> -	 * A child process with MAP_PRIVATE mappings created by their parent
> -	 * have no page reserves. This check ensures that reservations are
> -	 * not "stolen". The child may still get SIGKILLed
> -	 */
> -	if (!vma_has_reserves(vma, chg) && !available_huge_pages(h))
> -		goto err;
> -
> -	/* If reserves cannot be used, ensure enough pages are in the pool */
> -	if (avoid_reserve && !available_huge_pages(h))
> +	if (!use_hstate_resv && !available_huge_pages(h))
>  		goto err;
> 
>  	gfp_mask = htlb_alloc_mask(h);
> @@ -1430,7 +1421,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
>  		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
>  							nid, nodemask);
> 
> -	if (folio && !avoid_reserve && vma_has_reserves(vma, chg)) {
> +	if (folio && use_hstate_resv) {
>  		folio_set_hugetlb_restore_reserve(folio);
>  		h->resv_huge_pages--;
>  	}
> @@ -2973,6 +2964,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	struct mem_cgroup *memcg;
>  	bool deferred_reserve;
>  	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
> +	bool use_hstate_resv;
> 
>  	memcg = get_mem_cgroup_from_current();
>  	memcg_charge_ret = mem_cgroup_hugetlb_try_charge(memcg, gfp, nr_pages);
> @@ -3033,20 +3025,17 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	if (ret)
>  		goto out_uncharge_cgroup_reservation;
> 
> +	use_hstate_resv = !avoid_reserve && vma_has_reserves(vma, gbl_chg);
> +
>  	spin_lock_irq(&hugetlb_lock);
> -	/*
> -	 * glb_chg is passed to indicate whether or not a page must be taken
> -	 * from the global free pool (global change).  gbl_chg == 0 indicates
> -	 * a reservation exists for the allocation.
> -	 */
> -	folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
> +	folio = dequeue_hugetlb_folio_vma(h, vma, addr, use_hstate_resv);
>  	if (!folio) {
>  		spin_unlock_irq(&hugetlb_lock);
>  		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
>  		if (!folio)
>  			goto out_uncharge_cgroup;
>  		spin_lock_irq(&hugetlb_lock);
> -		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
> +		if (use_hstate_resv) {
>  			folio_set_hugetlb_restore_reserve(folio);
>  			h->resv_huge_pages--;
>  		}
> --
> 2.47.0.rc1.288.g06298d1525-goog
> 

-- 
Peter Xu


