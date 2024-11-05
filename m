Return-Path: <linux-kernel+bounces-396990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B1B9BD54C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EABA283DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C5C1CAA4;
	Tue,  5 Nov 2024 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jq6Gfpdd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8D1E7C2A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832408; cv=none; b=qReun/May/tqA6/3uj67EdB5btgC+lZnO97luy5ibpvJIE43Cw+d+cdy/VVMisj+1X/36COS3w7vFwy1/2y5Y//LtX1RqNjqrbwjYzZeNjxa0+8zQFtqP9CE+WYX1I7OWqIsGpqPaaE2jS/e0BWcSBpIos42gNKid3eIuEBFY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832408; c=relaxed/simple;
	bh=hMHU7KjhEah9yAgG3YUgZvGH42ddpnG4O6UlxjhbfN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUE21fllZnCHE7qZLARQ4rMO+1GZHQ8Ge3IM1ojUXLXEy6Tzvbo5XgI1zW1Q+VFT/t7Ov7G2Q0XKXEwAxAy/P93O0Jghky1iuINc6gEH7cIXL2FmKo0z1REIo9r4vY+Gbn5OoMVNwP/8TEvZGXu+YFumyzTXDDLezaU7h9DomrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jq6Gfpdd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730832405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYwp8KIugtxkap4ul3M8EPvAlgEl05pvj3U2wYQAfhc=;
	b=Jq6GfpddmgmnZ1BUSLOQQPXxt4sPccmyJT0f50FnlyhF9TTsfqTS08OeksQ3l0USI1Qrkw
	hn+UMyh9KvENGQfrPWt8tZrlF2pDqzQl9UOwitIWi5nr37neSuzY8DzKLmFKSVe9uFel2s
	e1kwqUMBrtXssorqkcCS1uAE3TMxwsg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-7hg87Pd-PGSEVL6fVN--0A-1; Tue, 05 Nov 2024 13:46:44 -0500
X-MC-Unique: 7hg87Pd-PGSEVL6fVN--0A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4608e7a1ad2so113326651cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 10:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832404; x=1731437204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYwp8KIugtxkap4ul3M8EPvAlgEl05pvj3U2wYQAfhc=;
        b=POaYS2X/fOSuYdETSpHOpZb2niv6j6O+mvcy5xDwNdkSZyl/4Wr+oyND5tcRM5/fZO
         MEuv70RsrMQ4oyxLG1TdfVz3foKNGHbucxnfBmZFoDTDXxWBESF3QYA4uZQHAgQuaVA6
         k1+q4sZL0sIRp+poYCf5mXFpbEi0e/BhAeK24301Eh8j7YiPQo2Ob4w7R87ZdjSPRjXP
         0LrPkeVD2pBUHHbb/Cy1NfpAWBIAiKG80C5C7dr9UNLGP2NLvKI1eL8Sviu+xW66ra/P
         2fnDG0woALjiPNkHjW2fMDifFO3DzBJmnXXi+3f4MazxhIAT0QL8g9JXBJM+4BIg+Q0r
         I5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXx76cLCT/kAinQrlYkJLs2PyhrF2uJFXI9OG/jPL0V7lFqGzVubZjhNzJ2DhqRE32aq2/QLi8nitxLbNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR8BAbQ111AIW0WP29bhQZzRRrM25qlHTvciGbGpjIgf2W0vOO
	MbnBRjkz8ZsRkrqYnaxMD2uE8/HyvOS7JLBdtNJ8IeXe8+YOmPvfoi+eHfVknDsp96Jnh4/mMlr
	P95mLEbA91qgOQCP1KFefJHvqA7INEnf+3gYL0mN4p07KG6Glf7LsFcfHn3XhBg==
X-Received: by 2002:a05:6214:16d1:b0:6d3:6577:ab0e with SMTP id 6a1803df08f44-6d36577ad52mr176220136d6.25.1730832403712;
        Tue, 05 Nov 2024 10:46:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJqKYJHWZJB7IdidyerdlnGnmwlSuAXCaI3vemSa5qwsTCH66dfDEtOB+NFfPtBagp0pe3Vg==
X-Received: by 2002:a05:6214:16d1:b0:6d3:6577:ab0e with SMTP id 6a1803df08f44-6d36577ad52mr176219756d6.25.1730832403337;
        Tue, 05 Nov 2024 10:46:43 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d354177d2fsm62931026d6.107.2024.11.05.10.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 10:46:42 -0800 (PST)
Date: Tue, 5 Nov 2024 13:46:39 -0500
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
Subject: Re: [RFC PATCH 2/3] mm: hugetlb: Refactor vma_has_reserves() to
 should_use_hstate_resv()
Message-ID: <ZypoDzm2XdfnG1if@x1n>
References: <cover.1728684491.git.ackerleytng@google.com>
 <3d1946d01f63104de913c0979b5a596e2add1672.1728684491.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d1946d01f63104de913c0979b5a596e2add1672.1728684491.git.ackerleytng@google.com>

On Fri, Oct 11, 2024 at 11:22:37PM +0000, Ackerley Tng wrote:
> With the addition of the chg parameter, vma_has_reserves() no longer
> just determines whether the vma has reserves.
> 
> The comment in the vma->vm_flags & VM_NORESERVE block indicates that
> this function actually computes whether or not the reserved count
> should be decremented.
> 
> This refactoring also takes into account the allocation's request
> parameter avoid_reserve, which helps to further simplify the calling
> function alloc_hugetlb_folio().
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

I wonder if this patch could be merged with the 3rd, IIUC this can
fundamentally be seen as a movement of what patch 3 was removed.

Furthermore, I do feel like should_use_hstate_resv() could be redundant on
its own on many things.

Let me try to justify.  Firstly, after 3 patches applied, now it looks like
this (I removed all comments to make things shorter..):

static bool should_use_hstate_resv(struct vm_area_struct *vma, long chg,
				   bool avoid_reserve)
{
	if (avoid_reserve)
		return false;

	if (vma->vm_flags & VM_NORESERVE) {
		if (vma->vm_flags & VM_MAYSHARE && chg == 0)
			return true;
		else
			return false;
	}

	if (vma->vm_flags & VM_MAYSHARE) {
		if (chg)
			return false;
		else
			return true;
	}

	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
		if (chg)
			return false;
		else
			return true;
	}

	return false;
}

Then let's look at chg==0 processing all above: what does it say?  I
suppose it means "we don't need another global reservation".  It means if
chg==0 we always will use an existing reservation.  From math POV it also
is true, so it can already be moved out ahead, IIUC, like this:

static bool should_use_hstate_resv(struct vm_area_struct *vma, long chg,
				   bool avoid_reserve)
{
	if (avoid_reserve)
		return false;

        if (chg == 0)
                return true;

	if (vma->vm_flags & VM_NORESERVE)
                return false;

	if (vma->vm_flags & VM_MAYSHARE)
                return false;

	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER))
                return false;

	return false;             <--------------------- [1]
}

Move on.  If I read it right, above [1] is exactly for avoid_reserve==1
case, where it basically says "it's !NORESERVE, private, and it's not the
vma resv owner, either fork() or CoW".  If my reading is correct, it means
after your patch 2, [1] should never be reachable at all.. I would hope
adding a panic() right above would be ok.

And irrelevant of whether my understanding is correct.. math-wise above is
also already the same as:

static bool should_use_hstate_resv(struct vm_area_struct *vma, long chg,
				   bool avoid_reserve)
{
	if (avoid_reserve)
		return false;

        if (chg == 0)
                return true;

	return false;
}

Then it makes a lot more sense now, because afaict, gbl_chg is exactly what
should_use_hstate_resv() is looking for.. only except avoid_reserve==true.

Would above make sense to you?

In short, it's about whether a patch on top of your series would further
simply this whole thing, like below:

===8<===
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 60e72214d5bf..4b1c5c4ed7be 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1245,80 +1245,6 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
 	hugetlb_dup_vma_private(vma);
 }
 
-/*
- * Returns true if this allocation should use (debit) hstate reservations, based on
- *
- * @vma: VMA config
- * @chg: Whether the page requirement can be satisfied using subpool reservations
- * @avoid_reserve: Whether allocation was requested to avoid using reservations
- */
-static bool should_use_hstate_resv(struct vm_area_struct *vma, long chg,
-				   bool avoid_reserve)
-{
-	if (avoid_reserve)
-		return false;
-
-	if (vma->vm_flags & VM_NORESERVE) {
-		/*
-		 * This address is already reserved by other process(chg == 0),
-		 * so, we should decrement reserved count. Without decrementing,
-		 * reserve count remains after releasing inode, because this
-		 * allocated page will go into page cache and is regarded as
-		 * coming from reserved pool in releasing step.  Currently, we
-		 * don't have any other solution to deal with this situation
-		 * properly, so add work-around here.
-		 */
-		if (vma->vm_flags & VM_MAYSHARE && chg == 0)
-			return true;
-		else
-			return false;
-	}
-
-	/* Shared mappings always use reserves */
-	if (vma->vm_flags & VM_MAYSHARE) {
-		/*
-		 * We know VM_NORESERVE is not set.  Therefore, there SHOULD
-		 * be a region map for all pages.  The only situation where
-		 * there is no region map is if a hole was punched via
-		 * fallocate.  In this case, there really are no reserves to
-		 * use.  This situation is indicated if chg != 0.
-		 */
-		if (chg)
-			return false;
-		else
-			return true;
-	}
-
-	/*
-	 * Only the process that called mmap() has reserves for private
-	 * mappings. A child process with MAP_PRIVATE mappings created by their
-	 * parent have no page reserves.
-	 */
-	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
-		/*
-		 * Like the shared case above, a hole punch or truncate
-		 * could have been performed on the private mapping.
-		 * Examine the value of chg to determine if reserves
-		 * actually exist or were previously consumed.
-		 * Very Subtle - The value of chg comes from a previous
-		 * call to vma_needs_reserves().  The reserve map for
-		 * private mappings has different (opposite) semantics
-		 * than that of shared mappings.  vma_needs_reserves()
-		 * has already taken this difference in semantics into
-		 * account.  Therefore, the meaning of chg is the same
-		 * as in the shared case above.  Code could easily be
-		 * combined, but keeping it separate draws attention to
-		 * subtle differences.
-		 */
-		if (chg)
-			return false;
-		else
-			return true;
-	}
-
-	return false;
-}
-
 static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	int nid = folio_nid(folio);
@@ -3255,7 +3181,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 	}
 
-	use_hstate_resv = should_use_hstate_resv(vma, gbl_chg, avoid_reserve);
+	use_hstate_resv = avoid_reserve || !gbl_chg;
 
 	/*
 	 * charge_cgroup_reservation if this allocation is not consuming a
===8<===

Thanks,

-- 
Peter Xu


