Return-Path: <linux-kernel+bounces-360527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61B0999C20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46EB281AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511D51F706F;
	Fri, 11 Oct 2024 05:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6CoOpFV"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AA2F26
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625085; cv=none; b=leDwSfSe9NhmswBvUdImaFzBHPCKTFv1YmsKmuhBatMlovQybkjY4MHOxZhR0hpceICVlyusbcehLn5wg17RP/fFoWIDbebtts0EU+7rp49KKDDeyQw8McTMQp/cirUIDYPtplmJL6XkIThmeZlRg7Ngx6uULDbPdb3WpfiW/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625085; c=relaxed/simple;
	bh=jC9WrMbvVeN49TjGV86t0KueBQ9oV3kZ7SayGILohyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQS23aNerBsHmgmzAjMziHV1ojjI7WdvHxTV63UzhNZFlqeCNS6jy+ShYXRKSKH2OtMOwCHOf14q2q5ajQxGUMMSYCe6cRL+ySf2ib03oNwZIzvvF/gj7QfkAIYOtC7CXg43mGAUzW7N1daUkAekn+EX/a1oTaB334y0sp52Nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6CoOpFV; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7ae3e3db294so82056885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728625082; x=1729229882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwlVoZjFNRYGaq2/r/PMr145DdKMAVPt1Mu6ZSsQqB0=;
        b=h6CoOpFVizye9m2dsdetpYEnaHIqBfUhJFe8Q82h3/Ae0hid3GUFPskI5SKo+eUD/v
         TbB9IO/lIktNzCBAyphlaIeFG2zb9oWYr7X3mdynyYCW+NxUVcUasiYSGBv4NEnQtPjd
         2CBBthlZeFY8xv7ytJfoAzYw+I64xuuIwtcEtQ5y7XpjRhFFmmJ/y1Kl7vKqjnvVbm+v
         yu5RKIKahB2H4ASZ9JMCpwaiL6yrnta9+gc8/1V+s+lWfgPuGlbliYtXHB3knxKY4DTg
         S7E/mCtzYvO9I1+E8A+S76kP2+Xw1jWLoDlwX+L92QkO4FiDyK1XMl5nFoJcxt9s2oYl
         1wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728625082; x=1729229882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwlVoZjFNRYGaq2/r/PMr145DdKMAVPt1Mu6ZSsQqB0=;
        b=HJX1kw9XZqJ0udMD1CI6LXz2R+bxDwXmhRwKneh2is9cfwc0ERo8tFsDj/m+odq3zJ
         KnWL/vLmx5BDSKpkTCT97p6EqW3N9dZk+/JefWT0OLWAexOmRkzrSjo7044u8X1UAnp1
         coCwD3fk5S0VTMoZ1CoEFDHJciOuOD/J7PrwkCwvcXhfHNJSjWY8I659NhxtHkpXxx/F
         QYNVflGS5zRewHsG714o9KPG4iy0zXm5N4SckIQFJyn7mJIYNwaH8xZvAsjUq3hBum2r
         tZ0Jn0avWEws5Aivizm1jKXvP9wFqEmj/MQeXYe/DkM96Ku2QTuEAh4C9Hd52E/j/X34
         coDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ3HsHrznkGYx2xdp3xqV4dg/AYWnH+NBZLzGfuEdsKwweOSlGzHxLbFnEyQbb5hTYNlP0z0qClg5l4eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEbR0ZzB81bjF9/6QrBKlE0JphJbeif+9GRhwL4DLFcNZfgtv
	wYRCSdf0264UjTLNOLSOzq+tGUVyEhHTW1HYFN9ZHpk47SmRMPAUjuWX9rnfxwAW4NOQZ297ccF
	IKwp6M6JMte55yEK69FeauU0gnKY=
X-Google-Smtp-Source: AGHT+IEQfyemdrvKQKrZ7MjKWE0nTXcXuLcBF9JFya6fxbzlek9cQNBnNIMUqQGG+YXT+vOGAagftGcVUxGYjXMBWCA=
X-Received: by 2002:a0c:f408:0:b0:6cb:cc5e:1bcf with SMTP id
 6a1803df08f44-6cbeffe59b8mr19631136d6.21.1728625082463; Thu, 10 Oct 2024
 22:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728314402.git.lorenzo.stoakes@oracle.com> <48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 11 Oct 2024 10:37:51 +0500
Message-ID: <CABXGCsP_W6V3vKwGvpue47AcbYYsFtwC=AHPx6LwOZmkvLRtrw@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.12 v3 1/2] maple_tree: correct tree corruption on
 spanning store
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Bert Karwatzki <spasswolf@web.de>, maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:28=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> There has been a subtle bug present in the maple tree implementation from
> its inception.
>
> This arises from how stores are performed - when a store occurs, it will
> overwrite overlapping ranges and adjust the tree as necessary to
> accommodate this.
>
> A range may always ultimately span two leaf nodes. In this instance we wa=
lk
> the two leaf nodes, determine which elements are not overwritten to the
> left and to the right of the start and end of the ranges respectively and
> then rebalance the tree to contain these entries and the newly inserted
> one.
>
> This kind of store is dubbed a 'spanning store' and is implemented by
> mas_wr_spanning_store().
>
> In order to reach this stage, mas_store_gfp() invokes mas_wr_preallocate(=
),
> mas_wr_store_type() and mas_wr_walk() in turn to walk the tree and update
> the object (mas) to traverse to the location where the write should be
> performed, determining its store type.
>
> When a spanning store is required, this function returns false stopping a=
t
> the parent node which contains the target range, and mas_wr_store_type()
> marks the mas->store_type as wr_spanning_store to denote this fact.
>
> When we go to perform the store in mas_wr_spanning_store(), we first
> determine the elements AFTER the END of the range we wish to store (that
> is, to the right of the entry to be inserted) - we do this by walking to
> the NEXT pivot in the tree (i.e. r_mas.last + 1), starting at the node we
> have just determined contains the range over which we intend to write.
>
> We then turn our attention to the entries to the left of the entry we are
> inserting, whose state is represented by l_mas, and copy these into a 'bi=
g
> node', which is a special node which contains enough slots to contain two
> leaf node's worth of data.
>
> We then copy the entry we wish to store immediately after this - the copy
> and the insertion of the new entry is performed by mas_store_b_node().
>
> After this we copy the elements to the right of the end of the range whic=
h
> we are inserting, if we have not exceeded the length of the node
> (i.e. r_mas.offset <=3D r_mas.end).
>
> Herein lies the bug - under very specific circumstances, this logic can
> break and corrupt the maple tree.
>
> Consider the following tree:
>
> Height
>   0                             Root Node
>                                  /      \
>                  pivot =3D 0xffff /        \ pivot =3D ULONG_MAX
>                                /          \
>   1                       A [-----]       ...
>                              /   \
>              pivot =3D 0x4fff /     \ pivot =3D 0xffff
>                            /       \
>   2 (LEAVES)          B [-----]  [-----] C
>                                       ^--- Last pivot 0xffff.
>
> Now imagine we wish to store an entry in the range [0x4000, 0xffff] (note
> that all ranges expressed in maple tree code are inclusive):
>
> 1. mas_store_gfp() descends the tree, finds node A at <=3D0xffff, then
>    determines that this is a spanning store across nodes B and C. The mas
>    state is set such that the current node from which we traverse further
>    is node A.
>
> 2. In mas_wr_spanning_store() we try to find elements to the right of piv=
ot
>    0xffff by searching for an index of 0x10000:
>
>     - mas_wr_walk_index() invokes mas_wr_walk_descend() and
>       mas_wr_node_walk() in turn.
>
>         - mas_wr_node_walk() loops over entries in node A until EITHER it
>           finds an entry whose pivot equals or exceeds 0x10000 OR it
>           reaches the final entry.
>
>         - Since no entry has a pivot equal to or exceeding 0x10000, pivot
>           0xffff is selected, leading to node C.
>
>     - mas_wr_walk_traverse() resets the mas state to traverse node C. We
>       loop around and invoke mas_wr_walk_descend() and mas_wr_node_walk()
>       in turn once again.
>
>          - Again, we reach the last entry in node C, which has a pivot of
>            0xffff.
>
> 3. We then copy the elements to the left of 0x4000 in node B to the big
>    node via mas_store_b_node(), and insert the new [0x4000, 0xffff] entry
>    too.
>
> 4. We determine whether we have any entries to copy from the right of the
>    end of the range via - and with r_mas set up at the entry at pivot
>    0xffff, r_mas.offset <=3D r_mas.end, and then we DUPLICATE the entry a=
t
>    pivot 0xffff.
>
> 5. BUG! The maple tree is corrupted with a duplicate entry.
>
> This requires a very specific set of circumstances - we must be spanning
> the last element in a leaf node, which is the last element in the parent
> node.
>
> spanning store across two leaf nodes with a range that ends at that share=
d
> pivot.
>
> A potential solution to this problem would simply be to reset the walk ea=
ch
> time we traverse r_mas, however given the rarity of this situation it see=
ms
> that would be rather inefficient.
>
> Instead, this patch detects if the right hand node is populated, i.e. has
> anything we need to copy.
>
> We do so by only copying elements from the right of the entry being inser=
ted
> when the maximum value present exceeds the last, rather than basing this =
on
> offset position.
>
> The patch also updates some comments and eliminates the unused bool retur=
n
> value in mas_wr_walk_index().
>
> The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tr=
ee
> in mmap_region()") seems to have made the probability of this event much
> more likely, which is the point at which reports started to be submitted
> concerning this bug.
>
> The motivation for this change arose from Bert Karwatzki's report of
> encountering mm instability after the release of kernel v6.12-rc1 which,
> after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
> options, was identified as maple tree corruption.
>
> After Bert very generously provided his time and ability to reproduce thi=
s
> event consistently, I was able to finally identify that the issue discuss=
ed
> in this commit message was occurring for him.
>
> Reported-and-tested-by: Bert Karwatzki <spasswolf@web.de>
> Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.d=
e/
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7=
iF+XFRu1h7-+Dg@mail.gmail.com/
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  lib/maple_tree.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 20990ecba2dd..2fe59c534328 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2196,6 +2196,8 @@ static inline void mas_node_or_none(struct ma_state=
 *mas,
>
>  /*
>   * mas_wr_node_walk() - Find the correct offset for the index in the @ma=
s.
> + *                      If @mas->index cannot be found within the contai=
ning
> + *                      node, we traverse to the last entry in the node.
>   * @wr_mas: The maple write state
>   *
>   * Uses mas_slot_locked() and does not need to worry about dead nodes.
> @@ -3532,7 +3534,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>         return true;
>  }
>
> -static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
> +static void mas_wr_walk_index(struct ma_wr_state *wr_mas)
>  {
>         struct ma_state *mas =3D wr_mas->mas;
>
> @@ -3541,11 +3543,9 @@ static bool mas_wr_walk_index(struct ma_wr_state *=
wr_mas)
>                 wr_mas->content =3D mas_slot_locked(mas, wr_mas->slots,
>                                                   mas->offset);
>                 if (ma_is_leaf(wr_mas->type))
> -                       return true;
> +                       return;
>                 mas_wr_walk_traverse(wr_mas);
> -
>         }
> -       return true;
>  }
>  /*
>   * mas_extend_spanning_null() - Extend a store of a %NULL to include sur=
rounding %NULLs.
> @@ -3765,8 +3765,8 @@ static noinline void mas_wr_spanning_store(struct m=
a_wr_state *wr_mas)
>         memset(&b_node, 0, sizeof(struct maple_big_node));
>         /* Copy l_mas and store the value in b_node. */
>         mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
> -       /* Copy r_mas into b_node. */
> -       if (r_mas.offset <=3D r_mas.end)
> +       /* Copy r_mas into b_node if there is anything to copy. */
> +       if (r_mas.max > r_mas.last)
>                 mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
>                            &b_node, b_node.b_end + 1);
>         else
> --
> 2.46.2

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.

