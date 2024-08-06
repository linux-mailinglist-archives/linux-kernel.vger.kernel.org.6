Return-Path: <linux-kernel+bounces-276343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6999E94924A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179FB282986
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998471BE240;
	Tue,  6 Aug 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="HGb+hdEx"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F61D619D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952566; cv=none; b=Hj/4sJThBZAMclW2XpzL2I6spgOpHrlmpoJJdnnJ0Z44iGW5zfyqtMicOnQdePVTo40BWfOMG1rw6sWEHb4TnIHEJdplslWtRqNstq6QWb1YgQSnhvXhaLkFEbDWPebwcwtN3vnqcDvrTxO/whSJ4xMgp5eyi8bCLmVoufF6tQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952566; c=relaxed/simple;
	bh=PPLpJo3OSXgPzZSxUyoR+XuxYN3LdUpmgFjPcifw8gM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mk8YEvAC6I5IS9S+ODoDEc35eDQoJXTsveP9lN+PgcFSHs6Vi5IrwY59vQVELfdDZndcCP2nxhUDqYt2i76RYO11NW6GL7DR/QFbMUPUntf1lUgG1VvXoNcyvJTIWFbGDkecjBfLnx1f7WP/XO8581AV5T4b++GAdXXmibIPbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=HGb+hdEx; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 02CA61D05A3;
	Tue,  6 Aug 2024 15:56:00 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722952561; bh=9UG+juul92oU4si1s4KFo6ubGOSTTwVp45lS5rICtAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HGb+hdExhvsChrxpaGJYFxFKomVOqzLgubxsj2OnyUYqN32IQaquxmVVvY95X6/7A
	 5hdlRyac03bYVLpQBPAEY02yEOeGYvl4ol2Scq605VkRAWenoq7XIgyb9gj86MHAIH
	 bD6RdkcjhJZusQy0QUN3Nn20G9tFWKFJrH7ICHTcSYCrhKU8k3SmzffksIkmYRqeYg
	 rGDlncYRDzc9esUjhGmT6JOqs+l3wFjWbxP2rt3PlsYfLgtmZZyCD7gkjALfUYCyeW
	 JjKQdVRhckA4NkUB5/4W37CCgQxV+QSLmjDuAOoSK+qwtfKKfCEWv3wKwYfX5rVqY2
	 2XM1DJu2uixkA==
Date: Tue, 6 Aug 2024 15:55:55 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 10/10] mm: rework vm_ops->close() handling on VMA merge
Message-ID: <20240806155555.1125554c@mordecai.tesarici.cz>
In-Reply-To: <0afd85543d46fd743c0c71b6f6520f9580174b4f.1722849860.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<0afd85543d46fd743c0c71b6f6520f9580174b4f.1722849860.git.lorenzo.stoakes@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 13:13:57 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> In commit 714965ca8252 ("mm/mmap: start distinguishing if vma can be
> removed in mergeability test") we relaxed the VMA merge rules for VMAs
> possessing a vm_ops->close() hook, permitting this operation in instances
> where we wouldn't delete the VMA as part of the merge operation.
> 
> This was later corrected in commit fc0c8f9089c2 ("mm, mmap: fix vma_merge()
> case 7 with vma_ops->close") to account for a subtle case that the previous
> commit had not taken into account.
> 
> In both instances, we first rely on is_mergeable_vma() to determine whether
> we might be dealing with a VMA that might be removed, taking advantage of
> the fact that a 'previous' VMA will never be deleted, only VMAs that follow
> it.
> 
> The second patch corrects the instance where a merge of the previous VMA
> into a subsequent one did not correctly check whether the subsequent VMA
> had a vm_ops->close() handler.
> 
> Both changes prevent merge cases that are actually permissible (for
> instance a merge of a VMA into a following VMA with a vm_ops->close(), but
> with no previous VMA, which would result in the next VMA being extended,
> not deleted).
> 
> In addition, both changes fail to consider the case where a VMA that would
> otherwise be merged with the previous and next VMA might have
> vm_ops->close(), on the assumption that for this to be the case, all three
> would have to have the same vma->vm_file to be mergeable and thus the same
> vm_ops.
> 
> And in addition both changes operate at 50,000 feet, trying to guess
> whether a VMA will be deleted.
> 
> As we have majorly refactored the VMA merge operation and de-duplicated
> code to the point where we know precisely where deletions will occur, this
> patch removes the aforementioned checks altogether and instead explicitly
> checks whether a VMA will be deleted.
> 
> In cases where a reduced merge is still possible (where we merge both
> previous and next VMA but the next VMA has a vm_ops->close hook, meaning we
> could just merge the previous and current VMA), we do so, otherwise the
> merge is not permitted.
> 
> We take advantage of our userland testing to assert that this functions
> correctly - replacing the previous limited vm_ops->close() tests with tests
> for every single case where we delete a VMA.
> 
> We also update all testing for both new and modified VMAs to set
> vma->vm_ops->close() in every single instance where this would not prevent
> the merge, to assert that we never do so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c                |  69 ++++++++-----
>  tools/testing/vma/vma.c | 213 ++++++++++++++++++++++++----------------
>  2 files changed, 173 insertions(+), 109 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index c55ae035f5d6..9c779fc65ba8 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -10,14 +10,6 @@
>  static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
>  {
>  	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> -	/*
> -	 * If the vma has a ->close operation then the driver probably needs to
> -	 * release per-vma resources, so we don't attempt to merge those if the
> -	 * caller indicates the current vma may be removed as part of the merge,
> -	 * which is the case if we are attempting to merge the next VMA into
> -	 * this one.
> -	 */
> -	bool may_remove_vma = merge_next;

See my comment on PATCH 02/10. You're removing the local variable here,
so maybe it need not be introduced in the first place?

>  	if (!mpol_equal(vmg->policy, vma_policy(vma)))
>  		return false;
> @@ -33,8 +25,6 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
>  		return false;
>  	if (vma->vm_file != vmg->file)
>  		return false;
> -	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
> -		return false;
>  	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
>  		return false;
>  	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
> @@ -606,6 +596,12 @@ static int commit_merge(struct vma_merge_struct *vmg,
>  	return 0;
>  }
> 
> +/* We can only remove VMAs when merging if they do not have a close hook. */
> +static bool can_merge_remove_vma(struct vm_area_struct *vma)
> +{
> +	return !vma->vm_ops || !vma->vm_ops->close;
> +}
> +
>  /*
>   * vma_merge_modified - Attempt to merge VMAs based on a VMA having its
>   * attributes modified.
> @@ -710,9 +706,30 @@ static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> 
>  	/* If we span the entire VMA, a merge implies it will be deleted. */
>  	merge_will_delete_vma = left_side && right_side;
> -	/* If we merge both VMAs, then next is also deleted. */
> +
> +	/*
> +	 * If we need to remove vma in its entirety but are unable to do so,
> +	 * we have no sensible recourse but to abort the merge.
> +	 */
> +	if (merge_will_delete_vma && !can_merge_remove_vma(vma))
> +		return NULL;
> +
> +	/*
> +	 * If we merge both VMAs, then next is also deleted. This implies
> +	 * merge_will_delete_vma also.
> +	 */
>  	merge_will_delete_next = merge_both;
> 
> +	/*
> +	 * If we cannot delete next, then we can reduce the operation to merging
> +	 * prev and vma (thereby deleting vma).
> +	 */
> +	if (merge_will_delete_next && !can_merge_remove_vma(next)) {
> +		merge_will_delete_next = false;
> +		merge_right = false;
> +		merge_both = false;
> +	}
> +
>  	/* No matter what happens, we will be adjusting vma. */
>  	vma_start_write(vma);
> 
> @@ -756,21 +773,12 @@ static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
>  		vmg->start = prev->vm_start;
>  		vmg->pgoff = prev->vm_pgoff;
> 
> -		if (merge_will_delete_vma) {
> -			/*
> -			 * can_vma_merge_after() assumed we would not be
> -			 * removing vma, so it skipped the check for
> -			 * vm_ops->close, but we are removing vma.
> -			 */
> -			if (vma->vm_ops && vma->vm_ops->close)
> -				err = -EINVAL;
> -		} else {
> +		if (!merge_will_delete_vma) {
>  			adjust = vma;
>  			adj_start = end - vma->vm_start;
>  		}
> 
> -		if (!err)
> -			err = dup_anon_vma(prev, vma, &anon_dup);
> +		err = dup_anon_vma(prev, vma, &anon_dup);
>  	} else { /* merge_right */
>  		/*
>  		 *     |<----->| OR
> @@ -886,6 +894,8 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
>  	unsigned long end = vmg->end;
>  	pgoff_t pgoff = vmg->pgoff;
>  	pgoff_t pglen = PHYS_PFN(end - start);
> +	bool merge_next = false;
> +	struct anon_vma *anon_vma = vmg->anon_vma;

Calling this "anon_vma" feels a bit too generic. IIUC you want to save
the original vmg->anon_vma in case the VMA turns out to be ummergeable
with the next VMA after vmg->anon_vma has already been modified.

What about calling it "orig_anon_vma"?

Petr T

> 
>  	VM_WARN_ON(vmg->vma);
> 
> @@ -916,8 +926,9 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
>  		vmg->end = next->vm_end;
>  		vmg->vma = next;
>  		vmg->pgoff = next->vm_pgoff - pglen;
> -
>  		vmg->anon_vma = next->anon_vma;
> +
> +		merge_next = true;
>  	}
> 
>  	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> @@ -925,6 +936,16 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
>  		vmg->start = prev->vm_start;
>  		vmg->vma = prev;
>  		vmg->pgoff = prev->vm_pgoff;
> +
> +		/*
> +		 * If this merge would result in removal of the next VMA but we
> +		 * are not permitted to do so, reduce the operation to merging
> +		 * prev and vma.
> +		 */
> +		if (merge_next && !can_merge_remove_vma(next)) {
> +			vmg->end = end;
> +			vmg->anon_vma = anon_vma;
> +		}
>  	} else if (prev) {
>  		vma_iter_next_range(vmg->vmi);
>  	}
> @@ -978,6 +999,8 @@ int vma_expand(struct vma_merge_struct *vmg)
>  		int ret;
> 
>  		remove_next = true;
> +		/* This should already have been checked by this point. */
> +		VM_WARN_ON(!can_merge_remove_vma(next));
>  		vma_start_write(next);
>  		ret = dup_anon_vma(vma, next, &anon_dup);
>  		if (ret)
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index e465dc22e2d0..0c0a6ffcfc98 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -327,6 +327,9 @@ static bool test_vma_merge_new_vma(void)
>  	struct anon_vma_chain dummy_anon_vma_chain_d = {
>  		.anon_vma = &dummy_anon_vma,
>  	};
> +	const struct vm_operations_struct vm_ops = {
> +		.close = dummy_close,
> +	};
>  	int count;
>  	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
>  	bool merged;
> @@ -370,6 +373,7 @@ static bool test_vma_merge_new_vma(void)
>  	 * 0123456789abc
>  	 * AA*B   DD  CC
>  	 */
> +	vma_a->vm_ops = &vm_ops; /* This should have no impact. */
>  	vma_b->anon_vma = &dummy_anon_vma;
>  	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, flags, &merged);
>  	ASSERT_EQ(vma, vma_a);
> @@ -406,6 +410,7 @@ static bool test_vma_merge_new_vma(void)
>  	 * AAAAA *DD  CC
>  	 */
>  	vma_d->anon_vma = &dummy_anon_vma;
> +	vma_d->vm_ops = &vm_ops; /* This should have no impact. */
>  	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, flags, &merged);
>  	ASSERT_EQ(vma, vma_d);
>  	/* Prepend. */
> @@ -423,6 +428,7 @@ static bool test_vma_merge_new_vma(void)
>  	 * 0123456789abc
>  	 * AAAAA*DDD  CC
>  	 */
> +	vma_d->vm_ops = NULL; /* This would otherwise degrade the merge. */
>  	vma = try_merge_new_vma(&mm, &vmg, 0x5000, 0x6000, 5, flags, &merged);
>  	ASSERT_EQ(vma, vma_a);
>  	/* Merge with A, delete D. */
> @@ -573,120 +579,145 @@ static bool test_vma_merge_with_close(void)
>  	struct vma_merge_struct vmg = {
>  		.vmi = &vmi,
>  	};
> -	struct vm_operations_struct vm_ops = {};
> -	struct vm_area_struct *vma_next =
> -		alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, flags);
> -	struct vm_area_struct *vma;
> +	const struct vm_operations_struct vm_ops = {
> +		.close = dummy_close,
> +	};
> +	struct vm_area_struct *vma_prev, *vma_next, *vma;
> 
>  	/*
> -	 * When we merge VMAs we sometimes have to delete others as part of the
> -	 * operation.
> -	 *
> -	 * Considering the two possible adjacent VMAs to which a VMA can be
> -	 * merged:
> -	 *
> -	 * [ prev ][ vma ][ next ]
> -	 *
> -	 * In no case will we need to delete prev. If the operation is
> -	 * mergeable, then prev will be extended with one or both of vma and
> -	 * next deleted.
> -	 *
> -	 * As a result, during initial mergeability checks, only
> -	 * can_vma_merge_before() (which implies the VMA being merged with is
> -	 * 'next' as shown above) bothers to check to see whether the next VMA
> -	 * has a vm_ops->close() callback that will need to be called when
> -	 * removed.
> -	 *
> -	 * If it does, then we cannot merge as the resources that the close()
> -	 * operation potentially clears down are tied only to the existing VMA
> -	 * range and we have no way of extending those to the nearly merged one.
> -	 *
> -	 * We must consider two scenarios:
> -	 *
> -	 * A.
> +	 * When merging VMAs we are not permitted to remove any VMA that has a
> +	 * vm_ops->close() hook.
>  	 *
> -	 * vm_ops->close:     -       -    !NULL
> -	 *                 [ prev ][ vma ][ next ]
> -	 *
> -	 * Where prev may or may not be present/mergeable.
> -	 *
> -	 * This is picked up by a specific check in can_vma_merge_before().
> -	 *
> -	 * B.
> -	 *
> -	 * vm_ops->close:     -     !NULL
> -	 *                 [ prev ][ vma ]
> -	 *
> -	 * Where prev and vma are present and mergeable.
> -	 *
> -	 * This is picked up by a specific check in vma_merge_modified().
> -	 *
> -	 * IMPORTANT NOTE: We make the assumption that the following case:
> +	 * This is because executing this hook may clear state that is pertinent
> +	 * to the VMA range as a whole.
> +	 */
> +
> +	/*
> +	 * The only case of a new VMA merge that results in a VMA being deleted
> +	 * is one where both the previous and next VMAs are merged - in this
> +	 * instance the next VMA is deleted, and the previous VMA is extended.
>  	 *
> -	 *    -     !NULL   NULL
> -	 * [ prev ][ vma ][ next ]
> +	 * If we are unable to do so, we reduce the operation to simply
> +	 * extending the prev VMA and not merging next.
>  	 *
> -	 * Cannot occur, because vma->vm_ops being the same implies the same
> -	 * vma->vm_file, and therefore this would mean that next->vm_ops->close
> -	 * would be set too, and thus scenario A would pick this up.
> +	 * 0123456789
> +	 * PPP**NNNN
> +	 *             ->
> +	 * 0123456789
> +	 * PPPPPPNNN
>  	 */
> 
> -	ASSERT_NE(vma_next, NULL);
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
> +	vma_next->vm_ops = &vm_ops;
> +
> +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> +	ASSERT_EQ(vma_merge_new_vma(&vmg), vma_prev);
> +	ASSERT_EQ(vma_prev->vm_start, 0);
> +	ASSERT_EQ(vma_prev->vm_end, 0x5000);
> +	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> +
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> 
>  	/*
> -	 * SCENARIO A
> +	 * When modifying an existing VMA there are further cases where we
> +	 * delete VMAs.
> +	 *
> +	 *    <>
> +	 * 0123456789
> +	 * PPPVV
>  	 *
> -	 * 0123
> -	 *  *N
> +	 * In this instance, if vma has a close hook, the merge simply cannot
> +	 * proceed.
>  	 */
> 
> -	/* Make the next VMA have a close() callback. */
> -	vm_ops.close = dummy_close;
> -	vma_next->vm_ops = (const struct vm_operations_struct *)&vm_ops;
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> +	vma->vm_ops = &vm_ops;
> 
> -	/* Our proposed VMA has characteristics that would otherwise be merged. */
> -	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
> +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> +	vmg.prev = vma_prev;
> +	vmg.vma = vma;
> 
> -	/* The next VMA having a close() operator should cause the merge to fail.*/
> -	ASSERT_EQ(vma_merge_new_vma(&vmg), NULL);
> +	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
> 
> -	/* Now create the VMA so we can merge via modified flags */
> -	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
> -	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, flags);
> -	vmg.vma = vma;
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> 
>  	/*
> -	 * The VMA being modified in a way that would otherwise merge should
> -	 * also fail.
> +	 * This case is mirrored if merging with next.
> +	 *
> +	 *    <>
> +	 * 0123456789
> +	 *    VVNNNN
> +	 *
> +	 * In this instance, if vma has a close hook, the merge simply cannot
> +	 * proceed.
>  	 */
> +
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
> +	vma->vm_ops = &vm_ops;
> +
> +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> +	vmg.vma = vma;
> +
>  	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
> 
> -	/* SCENARIO B
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> +
> +	/*
> +	 * Finally, we consider two variants of the case where we modify a VMA
> +	 * to merge with both the previous and next VMAs.
>  	 *
> -	 * 0123
> -	 * P*
> +	 * The first variant is where vma has a close hook. In this instance, no
> +	 * merge can proceed.
>  	 *
> -	 * In order for this scenario to trigger, the VMA currently being
> -	 * modified must also have a .close().
> +	 *    <>
> +	 * 0123456789
> +	 * PPPVVNNNN
>  	 */
> 
> -	/* Reset VMG state. */
> -	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
> +	vma->vm_ops = &vm_ops;
> +
> +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> +	vmg.prev = vma_prev;
> +	vmg.vma = vma;
> +
> +	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
> +
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
> +
>  	/*
> -	 * Make next unmergeable, and don't let the scenario A check pick this
> -	 * up, we want to reproduce scenario B only.
> +	 * The second variant is where next has a close hook. In this instance,
> +	 * we reduce the operation to a merge between prev and vma.
> +	 *
> +	 *    <>
> +	 * 0123456789
> +	 * PPPVVNNNN
> +	 *            ->
> +	 * 0123456789
> +	 * PPPPPNNNN
>  	 */
> -	vma_next->vm_ops = NULL;
> -	vma_next->__vm_flags &= ~VM_MAYWRITE;
> -	/* Allocate prev. */
> -	vmg.prev = alloc_and_link_vma(&mm, 0, 0x1000, 0, flags);
> -	/* Assign a vm_ops->close() function to VMA explicitly. */
> -	vma->vm_ops = (const struct vm_operations_struct *)&vm_ops;
> +
> +	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
> +	vma_next->vm_ops = &vm_ops;
> +
> +	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
> +	vmg.prev = vma_prev;
>  	vmg.vma = vma;
> -	/* Make sure merge does not occur. */
> -	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
> 
> -	cleanup_mm(&mm, &vmi);
> +	ASSERT_EQ(vma_merge_modified(&vmg), vma_prev);
> +	ASSERT_EQ(vma_prev->vm_start, 0);
> +	ASSERT_EQ(vma_prev->vm_end, 0x5000);
> +	ASSERT_EQ(vma_prev->vm_pgoff, 0);
> +
> +	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> +
>  	return true;
>  }
> 
> @@ -699,6 +730,9 @@ static bool test_vma_merge_modified(void)
>  	struct vma_merge_struct vmg = {
>  		.vmi = &vmi,
>  	};
> +	const struct vm_operations_struct vm_ops = {
> +		.close = dummy_close,
> +	};
> 
>  	/*
>  	 * Merge right case - partial span.
> @@ -711,7 +745,9 @@ static bool test_vma_merge_modified(void)
>  	 *   VNNNNNN
>  	 */
>  	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
> +	vma->vm_ops = &vm_ops; /* This should have no impact. */
>  	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
> +	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
>  	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
>  	vmg.vma = vma;
>  	vmg.prev = vma;
> @@ -743,6 +779,7 @@ static bool test_vma_merge_modified(void)
>  	 */
>  	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
>  	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
> +	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
>  	vmg_set_range(&vmg, 0x2000, 0x6000, 2, flags);
>  	vmg.vma = vma;
>  	vma->anon_vma = &dummy_anon_vma;
> @@ -768,7 +805,9 @@ static bool test_vma_merge_modified(void)
>  	 * PPPPPPV
>  	 */
>  	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
>  	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
> +	vma->vm_ops = &vm_ops; /* This should have no impact. */
>  	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
>  	vmg.prev = vma_prev;
>  	vmg.vma = vma;
> @@ -800,6 +839,7 @@ static bool test_vma_merge_modified(void)
>  	 * PPPPPPP
>  	 */
>  	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
>  	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
>  	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
>  	vmg.prev = vma_prev;
> @@ -827,6 +867,7 @@ static bool test_vma_merge_modified(void)
>  	 * PPPPPPPPPP
>  	 */
>  	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
> +	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
>  	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
>  	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
>  	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
> --
> 2.45.2
> 


