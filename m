Return-Path: <linux-kernel+bounces-353258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC9992B49
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FEC284CA7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F541D2226;
	Mon,  7 Oct 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lhTXB80a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+83ssanX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lhTXB80a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+83ssanX"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737E1D1F70
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303312; cv=none; b=tfF6aixhGaOPnop4WJxVJftSLHRzslfHnIC3BcwFTzX8CtQqCXQSZQ5s/FifMxxZK/T9TPmUkxKmnX/t8NWKg8+QirfWxeWD/X1TJ2kcs2VwQ6rMO0kqaZcuX40ticJeHEySJ4CwZoh1NUFIcVoZBKwpE0pTEKxbilcjbw+A/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303312; c=relaxed/simple;
	bh=+/xJ8Z6HrYWjc7E8zIU87JxlrwnrD3aL5KY6Ii+yuqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2pNGWio1q4Xe5YmOHYo9/3u+lmE0GG7GjMnbdOET5NGlCwKXXIk26+ltDULhHwItHr2Us/OhycxgYHfQqKRBx9dp2t7ccEoBBjZ0v/DxrSP+eVYpOnBvYNF8uatKYw+A95g4kUwKJ1Eoelra0JoA258ihJkAfhnrhXbQxnCF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lhTXB80a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+83ssanX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lhTXB80a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+83ssanX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72C1321B71;
	Mon,  7 Oct 2024 12:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728303308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2ouv1GShtv7jkf/iHriBRHJG0IgJ+grVNYQ8hpVznw=;
	b=lhTXB80alR9VCihHgs2B6QQPX4Z5rqoCcxpMZ7rnSScjnN250O6p+4ddEAgEYw3+GWXfZe
	Fjr8jMLtizpkCH+iUJKudjia12/+QfbVr9MMG8WlmB+iS1smlROphNOdtNwtDxS9Tn9NpW
	hvJoWJD2nW598iqhUDWWhUTTOFTjCkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728303308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2ouv1GShtv7jkf/iHriBRHJG0IgJ+grVNYQ8hpVznw=;
	b=+83ssanXsYqqgSdiFHh+eFHz0Bviyv7SFUXvw6ZrHZkoMZT9qgobu1KjrB+iY7rQ48Z56e
	p3/KWZPg4KeMVfDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lhTXB80a;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+83ssanX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728303308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2ouv1GShtv7jkf/iHriBRHJG0IgJ+grVNYQ8hpVznw=;
	b=lhTXB80alR9VCihHgs2B6QQPX4Z5rqoCcxpMZ7rnSScjnN250O6p+4ddEAgEYw3+GWXfZe
	Fjr8jMLtizpkCH+iUJKudjia12/+QfbVr9MMG8WlmB+iS1smlROphNOdtNwtDxS9Tn9NpW
	hvJoWJD2nW598iqhUDWWhUTTOFTjCkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728303308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u2ouv1GShtv7jkf/iHriBRHJG0IgJ+grVNYQ8hpVznw=;
	b=+83ssanXsYqqgSdiFHh+eFHz0Bviyv7SFUXvw6ZrHZkoMZT9qgobu1KjrB+iY7rQ48Z56e
	p3/KWZPg4KeMVfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CEE513786;
	Mon,  7 Oct 2024 12:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 09eoFczQA2feTAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 07 Oct 2024 12:15:08 +0000
Message-ID: <1cd350d3-a450-4804-aabe-0e5b4accffa4@suse.cz>
Date: Mon, 7 Oct 2024 14:15:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 hotfix 6.12 2/2] maple_tree: add regression test for
 spanning store bug
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 Bert Karwatzki <spasswolf@web.de>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 maple-tree@lists.infradead.org
References: <cover.1728223996.git.lorenzo.stoakes@oracle.com>
 <12af588c6b3338bf6a73cd2d95943a83a44c3b42.1728223996.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <12af588c6b3338bf6a73cd2d95943a83a44c3b42.1728223996.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 72C1321B71
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kvack.org,vger.kernel.org,oracle.com,web.de,gmail.com,lists.infradead.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 



On 10/6/24 4:31 PM, Lorenzo Stoakes wrote:
> Add a regression test to assert that, when performing a spanning store
> which consumes the entirety of the rightmost right leaf node does not
> result in maple tree corruption when doing so.
> 
> This achieves this by building a test tree of 3 levels and establishing a
> store which ultimately results in a spanned store of this nature.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  tools/testing/radix-tree/maple.c | 84 ++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 1873ddbe16cc..5fde09999be4 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -36406,9 +36406,93 @@ void farmer_tests(void)
>  	check_nomem(&tree);
>  }
> 
> +static unsigned long get_last_index(struct ma_state *mas)
> +{
> +	struct maple_node *node = mas_mn(mas);
> +	enum maple_type mt = mte_node_type(mas->node);
> +	unsigned long *pivots = ma_pivots(node, mt);
> +	unsigned long last_index = mas_data_end(mas);
> +
> +	BUG_ON(last_index == 0);
> +
> +	return pivots[last_index - 1] + 1;
> +}
> +
> +/*
> + * Assert that we handle spanning stores that consume the entirety of the right
> + * leaf node correctly.
> + */
> +static void test_spanning_store_regression(void)
> +{
> +	unsigned long from = 0, to = 0;
> +	DEFINE_MTREE(tree);
> +	MA_STATE(mas, &tree, 0, 0);
> +
> +	/*
> +	 * Build a 3-level tree. We require a parent node below the root node
> +	 * and 2 leaf nodes under it, so we can span the entirety of the right
> +	 * hand node.
> +	 */
> +	build_full_tree(&tree, 0, 3);
> +
> +	/* Descend into position at depth 2. */
> +	mas_reset(&mas);
> +	mas_start(&mas);
> +	mas_descend(&mas);
> +	mas_descend(&mas);
> +
> +	/*
> +	 * We need to establish a tree like the below.
> +	 *
> +	 * Then we can try a store in [from, to] which results in a spanned
> +	 * store across nodes B and C, with the maple state at the time of the
> +	 * write being such that only the subtree at A and below is considered.
> +	 *
> +	 * Height
> +	 *  0                              Root Node
> +	 *                                  /      \
> +	 *                    pivot = to   /        \ pivot = ULONG_MAX
> +	 *                                /          \
> +	 *   1                       A [-----]       ...
> +	 *                              /   \
> +	 *                pivot = from /     \ pivot = to
> +	 *                            /       \
> +	 *   2 (LEAVES)          B [-----]  [-----] C
> +	 *                                       ^--- Last pivot to.
> +	 */
> +	while (true) {
> +		unsigned long tmp = get_last_index(&mas);
> +
> +		if (mas_next_sibling(&mas)) {
> +			from = tmp;
> +			to = mas.max;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +	BUG_ON(from == 0 && to == 0);
> +
> +	/* Perform the store. */
> +	mas_set_range(&mas, from, to);
> +	mas_store_gfp(&mas, xa_mk_value(0xdead), GFP_KERNEL);
> +
> +	/* If the regression occurs, the validation will fail. */
> +	mt_validate(&tree);
> +
> +	/* Cleanup. */
> +	__mt_destroy(&tree);
> +}
> +
> +static void regression_tests(void)
> +{
> +	test_spanning_store_regression();
> +}
> +
>  void maple_tree_tests(void)
>  {
>  #if !defined(BENCH)
> +	regression_tests();
>  	farmer_tests();
>  #endif
>  	maple_tree_seed();
> --
> 2.46.2

