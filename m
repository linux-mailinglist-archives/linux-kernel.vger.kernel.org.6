Return-Path: <linux-kernel+bounces-351614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B449913A3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 02:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC81C1F238AB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5F4C9F;
	Sat,  5 Oct 2024 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="OAA9saWj"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D57231C9A
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728089784; cv=none; b=Oc4KmfK9RWM3fhdzOZzUG0BJSEnRfzLvo0zPeM0QWk4z3mxCzWiQJLhbyoa8aTpj5CfmaRZKwZbgLJhepy+RgYZwwniCVcIyALU4mthCCp0fPGhGKun0+ksqS0wuxqAOfOExVIZ3e0MkbsKKtXQYNsd9gINlOqVb4ompRcWJgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728089784; c=relaxed/simple;
	bh=uWpihwhgNZ9C/j1YGNCIB8h3fdbrOo3+kpCjnAlTqmw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9D86Tza9lF7n8lRRm5RoAGwyh6lggTOLGojxwxy93hA90CF9rmK2hsZUQSF/Df94mcsHpASvGsY3cyxWxiesgTWnexlTHXVFjQmc9XTyRMl+NvGCpysNyvml9y5lYmLasa14vVjYRKinpzBgQmxx77UyY2nFIBwZa9G2ddoFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=OAA9saWj; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728089763; x=1728694563; i=spasswolf@web.de;
	bh=US4ELvZveioeKd+zRDh9paghb6EwdjvF4+GRpVTb5Ik=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OAA9saWjs4IKwAFINUkKn7HVmsFOVWbrrlclbei7+guqHIUzuUpXlQtYmLqoZfRf
	 9jBAl1k6OlDCXHty8hIw0UhfioH8I9J9TYRB4JIWGJrzBrpCTMgKw6m7k6VW8G4Y0
	 RTeCKY+nKBIyKxp/5Zqa/Arh65AmTxkdjMaMCF1twoHiP4EXEmSmycOMcDiAbW2kV
	 bXXgkUU/jA8f8KEj3qJ59pOXm48vnyxrcAPFKezUwBtHiVBIeH9jYK6kBUHmrbLR9
	 t5060Gq4u6aE5cSTsETMPlWCLxCFps55y5X6powfL1aJI/lOZbVA5N2aktPSo8TrH
	 pHjhuk+H9sM/IH944g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Ez3-1t0Rzi093l-0039Jg; Sat, 05
 Oct 2024 02:56:03 +0200
Message-ID: <088a3541b85b783ef68337bd4bb790d62f200dfa.camel@web.de>
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 	spassowlf@web.de
Date: Sat, 05 Oct 2024 02:56:01 +0200
In-Reply-To: <3b83746d-b73e-4b89-9b74-5aba5a827f45@lucifer.local>
References: <20241004093546.3232-1-spasswolf@web.de>
	 <3b83746d-b73e-4b89-9b74-5aba5a827f45@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:929eX6I7xC8zQKm+5s+TEpMT82t07Ecx/j0r5bMZS9EGFilHiaF
 HOte4WyhkPa35WiMmffNicT5j132ZUSAqssLM6C7HQd2rVwanSHRuTT5Tl1do007xo/sNgg
 cQ5W28HpdsIeD7eAaZgslDx/rBGq2G6MRKwhsqx/wNG3eOqtoG22Z0HIYgkBgWjLvpOiEma
 m6XOPaXXH++daxp3kXvhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IttrPLwLCR4=;DiJ9K+Kwjle3Etl4W/BTec6yfUY
 qSfN0JlEPy/V6wVQYbcc1CSqePFDxar0ShTlnhg+QdVymrYBd3SaSaafn5rpLdFBh7GJMt7Z0
 HZe86C2WDiF9Hyyqhf7+Z7iaLAjAfxSISntCBTGk7su6RjJdgcTVsC/G5ARVaNpFyAKTeDtJA
 RXxUv8ARduPpGhe4qXfYPjeCarqucnJh13h91suU44oBZL5JsQz1b+v0eaXhVvYcndOvf8Dcj
 tuiUHn3rhsB8mpaGBDnx3c2EFjzX2111VUGMrm47IMbJ97TtdGI8OC6uwFeCR/+WEvep6xDJE
 5mu5CWOkFtcMrv1H7xVysbC/4TNXZX6SU0i98IphYl52/ntiKgEXwBmtnqWpSoM+0Yn6GA5pa
 ZHBpRPhYAxQDpumoXn+E1F4w1u0E/hLNwmrXzzlxyg34BKqMBBgi75jhk9XZJKZWsf1T5Xmle
 /ap0jyCsmOIJ0EjRlNPpS586abThE+RunQbTyHHIesphSatXiIf8XFh8UXOL/WtHgaeJAf+wH
 mnUB4ZliXkQ70aZkx2b2dpL5fj0b9rzWvPKso/CgBAC5C5kjkJ5I6KpI/HyvhjKWhJPv5qZ3c
 Ii4M8wfwYjY74VrbcTdakQ2b5aL8IW6bUbGxBNq3b289gjzp5JdKiHUnxlhQS3wHUWN4Zvyb3
 2yUBok+QMmJkUtQeTO7SEpUfl4Js4FZJnbj/rFuyHcONyCGkrjKN18dW1PzvFS0+ZIoZiD39Q
 L+8zjhuX6iCG5ajIYPjCtXcs4Jw2zNDluG/836YorTtACBESC9QStNfY2X1ZB/EazahaM7kDz
 0muFD42lSRCORhgvlLDGLB7g==

Am Freitag, dem 04.10.2024 um 23:41 +0100 schrieb Lorenzo Stoakes:
> On Fri, Oct 04, 2024 at 11:35:44AM +0200, Bert Karwatzki wrote:
> > Here's the log procduced by this kernel:
> >
> > c9e7f76815d3 (HEAD -> maple_tree_debug_4) hack: set of info stuff v5
> > 7e3bb072761a mm: correct error handling in mmap_region()
> > 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) =
Add linux-next specific files for 20241001
> >
> > Again it took two attempts to trigger the bug.
> >
> > Bert Karwatzki
> >
>
> Sending an updated, cleaned up version of the patch with a lot of
> explanation. This is functionally identical to the v3 fix I already sent=
 so
> you can try that or this to confirm it resolves your issue.
>
> If you are able to do so, I can submit this to upstream for a hotfix. If
> not, well then back to the drawing board and I'd be very shocked :)
>
> I have been able to reproduce the issue locally in our userland testing
> suite entirely consistently, and this patch resolves the issue and also
> continues to pass all maple tree unit tests.
>
> Again thank you so much for all your help - I hope you are able to find =
a
> spare moment to quickly give this one a try and confirm whether it does
> indeed address the problem you've reported.
>
> Thanks, Lorenzo
>
> ----8<----
> From 126d65bd9839cd3ec941007872b357e27fd56066 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Fri, 4 Oct 2024 15:18:58 +0100
> Subject: [PATCH] maple_tree: correct tree corruption on spanning store
>
> Writing a data range into a maple tree may involve overwriting a number =
of
> existing entries that span across more than one node. Doing so invokes a
> 'spanning' store.
>
> Performing a spanning store across two leaf nodes in a maple tree in whi=
ch
> entries are overwritten is achieved by first initialising a 'big' node,
> which will store the coalesced entries between the two nodes comprising
> entries prior to the newly stored entry, the newly stored entry, and
> subsequent entries.
>
> This 'big node' is then merged back into the tree and the tree is
> rebalanced, replacing the entries across the spanned nodes with those
> contained in the big node.
>
> The operation is performed in mas_wr_spanning_store() which starts by
> establishing two maple tree state objects ('mas' objects) on the left of
> the range and on the right (l_mas and r_mas respectively).
>
> l_mas traverses to the beginning of the range to be stored in order to c=
opy
> the data BEFORE the requested store into the big node.
>
> We then insert our new entry immediately afterwards (both the left copy =
and
> the storing of the new entry are combined and performed by
> mas_store_b_node()).
>
> r_mas traverses to the populated slot immediately after, in order to cop=
y
> the data AFTER the requested store into the big node.
>
> This copy of the right-hand node is performed by mas_mab_cp() as long as
> r_mas indicates that there's data to copy, i.e. r_mas.offset <=3D r_mas.=
end.
>
> We traverse r_mas to this position in mas_wr_node_walk() using a simple
> loop:
>
> 	while (offset < count && mas->index > wr_mas->pivots[offset])
> 		offset++;
>
> Note here that count is determined to be the (inclusive) index of the la=
st
> node containing data in the node as determined by ma_data_end().
>
> This means that even in searching for mas->index, which will have been s=
et
> to one plus the end of the target range in order to traverse to the next
> slot in mas_wr_spanning_store(), we will terminate the iteration at the =
end
> of the node range even if this condition is not met due to the offset <
> count condition.
>
> The fact this right hand node contains the end of the range being stored=
 is
> why we are traversing it, and this loop is why we appear to discover a
> viable range within the right node to copy to the big one.
>
> However, if the node that r_mas traverses contains a pivot EQUAL to the =
end
> of the range being stored, and this is the LAST pivot contained within t=
he
> node, something unexpected happens:
>
> 1. The l_mas traversal copy and insertion of the new entry in the big no=
de
>    is performed via mas_store_b_node() correctly.
>
> 2. The traversal performed by mas_wr_node_walk() means our r_mas.offset =
is
>    set to the offset of the entry equal to the end of the range we store=
.
>
> 3. We therefore copy this DUPLICATE of the final pivot into the big node=
,
>    and insert this DUPLICATE entry, alongside its invalid slot entry
>    immediately after the newly inserted entry.
>
> 4. The big node containing this duplicated is inserted into the tree whi=
ch
>    is rebalanced, and therefore the maple tree becomes corrupted.
>
> Note that if the right hand node had one or more entries with pivots of
> greater value than the end of the stored range, this would not happen. I=
f
> it contained entries with pivots of lesser value it would not be the rig=
ht
> node in this spanning store.
>
> This appears to have been at risk of happening throughout the maple tree=
's
> history, however it seemed significantly less likely to occur until
> recently.
>
> The balancing of the tree seems to have made it unlikely that you would
> happen to perform a store that both spans two nodes AND would overwrite
> precisely the entry with the largest pivot in the right-hand node which
> contains no further larger pivots.
>
> The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma t=
ree
> in mmap_region()") seems to have made the probability of this event much
> more likely.
>
> Previous to this change, MAP_FIXED mappings which were overwritten would
> first be cleared before any subsequent store or importantly - merge of
> surrounding entries - would be performed.
>
> After this change, this is no longer the case, and this means that, in t=
he
> worst case, a number of entries might be overwritten in combination with=
 a
> merge (and subsequent overwriting expansion) between both the prior entr=
y
> AND a subsequent entry.
>
> The motivation for this change arose from Bert Karwatzki's report of
> encountering mm instability after the release of kernel v6.12-rc1 which,
> after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
> options, was identified as maple tree corruption.
>
> After Bert very generously provided his time and ability to reproduce th=
is
> event consistently, I was able to finally identify that the issue discus=
sed
> in this commit message was occurring for him.
>
> The solution implemented in this patch is:
>
> 1. Adjust mas_wr_walk_index() to return a boolean value indicating wheth=
er
>    the containing node is actually populated with entries possessing piv=
ots
>    equal to or greater than mas->index.
>
> 2. When traversing the right node in mas_wr_spanning_store(), use this
>    value to determine whether to try to copy from the right node - if it=
 is
>    not populated, then do not do so.
>
> This passes all maple tree unit tests and resolves the reported bug.
> ---
>  lib/maple_tree.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 37abf0fe380b..e6f0da908ba7 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2194,6 +2194,8 @@ static inline void mas_node_or_none(struct ma_stat=
e *mas,
>
>  /*
>   * mas_wr_node_walk() - Find the correct offset for the index in the @m=
as.
> + *                      If @mas->index cannot be found within the conta=
ining
> + *                      node, we traverse to the last entry in the node=
.
>   * @wr_mas: The maple write state
>   *
>   * Uses mas_slot_locked() and does not need to worry about dead nodes.
> @@ -3527,6 +3529,12 @@ static bool mas_wr_walk(struct ma_wr_state *wr_ma=
s)
>  	return true;
>  }
>
> +/*
> + * Traverse the maple tree until the offset of mas->index is reached.
> + *
> + * Return: Is this node actually populated with entries possessing pivo=
ts equal
> + *         to or greater than mas->index?
> + */
>  static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas =3D wr_mas->mas;
> @@ -3535,8 +3543,11 @@ static bool mas_wr_walk_index(struct ma_wr_state =
*wr_mas)
>  		mas_wr_walk_descend(wr_mas);
>  		wr_mas->content =3D mas_slot_locked(mas, wr_mas->slots,
>  						  mas->offset);
> -		if (ma_is_leaf(wr_mas->type))
> -			return true;
> +		if (ma_is_leaf(wr_mas->type)) {
> +			unsigned long pivot =3D wr_mas->pivots[mas->offset];
> +
> +			return pivot =3D=3D 0 || mas->index <=3D pivot;
> +		}
>  		mas_wr_walk_traverse(wr_mas);
>
>  	}
> @@ -3696,6 +3707,7 @@ static noinline void mas_wr_spanning_store(struct =
ma_wr_state *wr_mas)
>  	struct maple_big_node b_node;
>  	struct ma_state *mas;
>  	unsigned char height;
> +	bool r_populated;
>
>  	/* Left and Right side of spanning store */
>  	MA_STATE(l_mas, NULL, 0, 0);
> @@ -3737,7 +3749,7 @@ static noinline void mas_wr_spanning_store(struct =
ma_wr_state *wr_mas)
>  		r_mas.last++;
>
>  	r_mas.index =3D r_mas.last;
> -	mas_wr_walk_index(&r_wr_mas);
> +	r_populated =3D mas_wr_walk_index(&r_wr_mas);
>  	r_mas.last =3D r_mas.index =3D mas->last;
>
>  	/* Set up left side. */
> @@ -3761,7 +3773,7 @@ static noinline void mas_wr_spanning_store(struct =
ma_wr_state *wr_mas)
>  	/* Copy l_mas and store the value in b_node. */
>  	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
>  	/* Copy r_mas into b_node. */
> -	if (r_mas.offset <=3D r_mas.end)
> +	if (r_populated && r_mas.offset <=3D r_mas.end)
>  		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
>  			   &b_node, b_node.b_end + 1);
>  	else
> --
> 2.46.2

I just tested this and it passed ten tests (i.e. upgrading the proton vers=
ion i
steam) in a row.

Bert Karwatzki

