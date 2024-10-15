Return-Path: <linux-kernel+bounces-366007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4B99EF9D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E39281CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2EB14F117;
	Tue, 15 Oct 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="DCvNZV0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XG1jhIQY"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332F1FC7D6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002772; cv=none; b=Sv6wwPx5Z9M7xaIAnx2819lNI9y95uowyLJCEGTHZcSEGagsljL02caepHpKSYBLQIYpVZCmGtlPJ9pEnZN5qee14EXtoi2Iw4XiOfomvbwATM7xBnKKXq/esl8GSalcKT3/bnmGGiOdaIXP+BQOZPQaEtKV7PbH008NBBZ5sas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002772; c=relaxed/simple;
	bh=g4sTiUvjTsetjuJdEgbcRfe++R54P0kyuoDwU0SoaU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Phb1J4brrYy+8lm8uuV8xYgpG9ycNjbpNleeZ8PzkLgQSnl3ITiYz62Jp6tvqhk8ROFoZDOm/Cn8hSVqOsiau0pWP4IMdgNxca3OcbIhhODguTkTH7Lr5fIGizEVVWjw9XKiBUWkd4MCkwIaM1RILF/t/kvFJWNKv2KzwIt7UEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=DCvNZV0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XG1jhIQY; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D229A11400B8;
	Tue, 15 Oct 2024 10:32:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Oct 2024 10:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729002767; x=
	1729089167; bh=BdJQJ6JTmrxhR/CBpOrLwB6GgPYfRWDiNQYumQSX2aA=; b=D
	CvNZV0Lb12ysCHUNkQxJ+XdhztK/9hpUMKMDzjXAa/G2YhHYkaHRswIqNHet6Gy7
	qesw9ovlzTt7AZ7k/Z6QmxtXtTkJcfcovGiuJhhWd1afFmaQxHSbSbsgUSGp6DuR
	4/PyPvdLoyz5pIlV0O3UW+gEyhog9hg8NCsLFGZ/cFklT3s4BSzEzsxK74DNFCWJ
	pDOMQJkqhiLC0dc37X8nD0/7Uu97ZVK1z7jc5cy4NlWPvKGpe9ODGbxxurmtlkpf
	Wysj8EOKs+vG5oVwANz1C+1D+8WPhYJ72PdQffyOZTh4RGFzY+zDTvFYJ3Ex6/kq
	Wd5f/dcA0BiabKXDeQzBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729002767; x=1729089167; bh=BdJQJ6JTmrxhR/CBpOrLwB6GgPYf
	RWDiNQYumQSX2aA=; b=XG1jhIQYqo+XGvfnuP53v0ImXBuSeBAI4y3d8Xufdo7Q
	2FFi04mEy8WALmVB9OcrHRkMZb+zmrFcYDOI4DkzANU3Ffn17ub6lqySX1xiz4v1
	JvnfG9s0wYa3HHj63P3+1uw4JJP8Vkbvhrl9cnhJIqExv/IAx3F1mqmkuMFxgQFC
	r4Vlgu6b/GGL1b1vznalAw1zbiufBy4dQQnX8x3YQMLFvxvEYYB8AAp34mpM6pWh
	FUsE/yLmTlNp13AYkqfEWGglHte1O2LHjDicDdQjiHVpYB63htqwWr0JU5IZXarh
	aFCNbmOUuohMLanEOWYFQ8kFXGEPFQ6f+uQUU3pYVQ==
X-ME-Sender: <xms:D30OZ4MjUCtTCkDneT2Ian2aRg7PsKuEF7hiXsPhdwJ6zii_E0EM2Q>
    <xme:D30OZ-_swA9kcwiQqBfZXFdDspYox_8QnNiw1qdljKL9ej7gBCZ0iF-qdvQZnQPmE
    6hQW5oigzMskFMPP9k>
X-ME-Received: <xmr:D30OZ_Tzt68MG9JTwy0gdvjy5_8RT-9po7-vFJQ8VqT5onBCJDAp-fwas7PzbtOgOMgt7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeltedugedtgfehuddu
    hfetleeiuedvtdehieejjedufeejfeegteetuddtgefgudenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhope
    eipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphht
    thhopehshiiisghothdojeguledujehfieejtgdthedtieeitggvtgdvleehsehshiiikh
    grlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehjrghnnhhhsehgoh
    hoghhlvgdrtghomh
X-ME-Proxy: <xmx:D30OZwuDU9hGODdBt-0bIdp25s-RUEir3NxK3iv4EVxrXOyXAYCQzA>
    <xmx:D30OZwdysrf81ghW_V733dENtebBiF5SwP8NWO6fddyB_8egdgYMEA>
    <xmx:D30OZ01zxzpdsVwMT4xgS-2jwrCurJ40J-sqQkBgs4niEiEpSaoJOw>
    <xmx:D30OZ0_XHLzkmsPtzA69dHsNFgkrbrWC0kJ7TzfBjOUUsk-Zufy2Hw>
    <xmx:D30OZ4RvaYJjOF5AJg7SZ_liBaTcH1FUX7DXAQEyCy7Bh_YrOhqTa_Z9>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 10:32:44 -0400 (EDT)
Date: Tue, 15 Oct 2024 17:32:39 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1] mm/pagewalk: fix usage of pmd_leaf()/pud_leaf()
 without present check
Message-ID: <bu3aq2gxcfkjxocu3uzowvevlv6rgeihepc36cwuhh44xqydkc@3ghgml6xnlgx>
References: <20241015111236.1290921-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015111236.1290921-1-david@redhat.com>

On Tue, Oct 15, 2024 at 01:12:36PM +0200, David Hildenbrand wrote:
> pmd_leaf()/pud_leaf() only implies a pmd_present()/pud_present() check on
> some architectures.

Should we clarify what behaviour we actually want from arch code?


> We really should check for
> pmd_present()/pud_present() first.
> 
> This should explain the report we got on ppc64 (which has
> CONFIG_PGTABLE_HAS_HUGE_LEAVES set in the config) that triggered:
> 	VM_WARN_ON_ONCE(pmd_leaf(pmdp_get_lockless(pmdp)));
> 
> Likely we had a PMD migration entry for which pmd_leaf() did not
> trigger. We raced with restoring the PMD migration entry, and suddenly
> saw a pmd_leaf(). In this case, pte_offset_map_lock() saved us from more
> trouble, because it rechecks the PMD value, but we would not have processed
> the migration entry -- which is not too bad because the only user of
> FW_MIGRATION is KSM for unsharing, and KSM only applies to small folios.
> 
> Further, we shouldn't re-read the PMD/PUD value for our warning, the
> primary purpose of the VM_WARN_ON_ONCE() is to find spurious use of
> pmd_leaf()/pud_leaf() without CONFIG_PGTABLE_HAS_HUGE_LEAVES.
> 
> As a side note, we are currently not implementing FW_MIGRATION support
> for PUD migration entries, which likely should exist due to hugetlb. Add
> a TODO so this won't fall through the cracks if more FW_MIGRATION users
> get added.
> 
> Fixes: aa39ca6940f1 ("mm/pagewalk: introduce folio_walk_start() + folio_walk_end()")
> Reported-by: syzbot+7d917f67c05066cec295@syzkaller.appspotmail.com
> Closes: https://lkml.kernel.org/r/670d3248.050a0220.3e960.0064.GAE@google.com
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

