Return-Path: <linux-kernel+bounces-385466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A099B3785
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B43DB21379
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD561DF24B;
	Mon, 28 Oct 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSgEXM0/"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FCC1DED57
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135994; cv=none; b=V8YfHqq2dKGuAOeGwYcjutxZQOcR88/1fc+AR+OMNrwWHYq5+Ri5CUSeRNfngW3UEXGdTsoA4lGfPO916Ymm1vKaLgHFTZYBqYylpzBS5vvnOVgmxuHTxQ7LhYOsqyiuC6kuKqo2RQ4HytZXCoXX3fQk9t8LS/acqnAaLtzIs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135994; c=relaxed/simple;
	bh=G95DEzV0F1JIKxJidz8QzR0/fQJUIyDTNSavswOe7ac=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kWLoxiV0BtWUdOiQ6Cr/bvvvDBZxCBN9LYN84YVght6eeL/18ip+wIh3+wiPGZiZ5k39AOs5v0VySHF1I304tE0KIRZyVNyS6lwX8kTiRYgMSVu4OmlC6ghdMtYrKkYnHt+KbJBM2XTKwiIs2a764avco8Cc8bbbkQJ7rL+MXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tSgEXM0/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso3673234b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730135992; x=1730740792; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RY6zr2YzyvahJvl44LPriDmoX1vRe4PibvLEnYm5kVI=;
        b=tSgEXM0/3N0Cgiq2LXCodUrDEWTP5tczzSwC9iT9nzcKNUyLnraP/0g3A7CfsXkdf+
         BdeCg9VtpiKwNdqcORRgMiZpcezgmQyHl7YOkt9vR8Bj+POehMPzymD4LoXHSgczEJna
         nO2nl28jU5u6vxVXo6RNl5DN/Fz/rQMZEy905j9NlqIPdAmzbPxl+n/zz/TFarUD52RV
         zzKkLsyC9jO+2rehCPXO2b18K2tCTKeq62uPu+NxawYMCQeShV8B6zR2xualavr7GAC6
         8G+OxMciZTY8eh/RFwDpU7ESc9YUuGJ6WLROOks7y4GHIRuhFqSrAQOJ9l5iCNGaUtEB
         BrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135992; x=1730740792;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RY6zr2YzyvahJvl44LPriDmoX1vRe4PibvLEnYm5kVI=;
        b=lGm8m+VJer2P5NcmAV5gL42msxd0hSzrYB37s1V8Q3wCfoRMBbR3GUH9mC4GdZUpXl
         sCxe/D+2hWzkovRul3aRw+hFd2MknpskbqmV33SF0wc10o1to4lDUKjNdYJ2Uo+kNSqK
         OfxUA2AnVZOBT53CKxk2p6DNCa/+7kikHudN76CJYs3s/TTyq2FAwutt+zLaSARMYrd5
         KKtrvH5EAsGci9WtOS0Qr0WUSgQf5kn4zUHdiLZCRqjB8hTlDhe6EXvn7Z1wtzJRDuIx
         3y8yeej2kuWcjHKi78yUwgETxUkJ5NigLeM57EDTw3BYvAJRp85860wkovw0YjZMr8zU
         fXSg==
X-Forwarded-Encrypted: i=1; AJvYcCWU4qpxP7TtLbHtlMsGWvMrrMLa6jd1R5cb+EheADXLcxZBdEMf83Qt2bygagKx+6KbD0vL6ddQCnW61WY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/NXkkW0LYffykg+XBnGgdnw51CkloK2AcFz4C9Qcl2sMzYJw
	enviwTJkfIYMkJu9doR6P9hAVg6p1fi4zoPyBwlIwqynCQBIx8uR4GsM8coX1Q==
X-Google-Smtp-Source: AGHT+IEnP7I9ySstlcZGJ1tZDqOTjeuAM8G3XCA455EMBwktt5hFsyHctd8BrSjV+FAC7IE5LbliZg==
X-Received: by 2002:a05:6a00:2389:b0:71e:79a9:ec47 with SMTP id d2e1a72fcca58-72062f82516mr13531018b3a.6.1730135991320;
        Mon, 28 Oct 2024 10:19:51 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057935747sm6000792b3a.78.2024.10.28.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:19:50 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:19:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>, 
    Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH hotfix v2 2/2] mm/thp: fix deferred split unqueue naming
 and locking
In-Reply-To: <154430c4-7b17-443f-8628-ef3bb7738ae9@redhat.com>
Message-ID: <c47c355f-fc2a-d8f4-4c8d-4a7a1468f0b2@google.com>
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com> <8dc111ae-f6db-2da7-b25c-7a20b1effe3b@google.com> <154430c4-7b17-443f-8628-ef3bb7738ae9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Oct 2024, David Hildenbrand wrote:

> Hi Hugh,
> 
> mostly looks good to me, one comment:

Thanks...

> 
> > +++ b/mm/memcontrol-v1.c
> > @@ -848,6 +848,8 @@ static int mem_cgroup_move_account(struct folio *folio,
> >    css_get(&to->css);
> >    css_put(&from->css);
> >   +	/* Warning should never happen, so don't worry about refcount non-0 */
> > +	WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
> >    folio->memcg_data = (unsigned long)to;
> >   
> >   	__folio_memcg_unlock(from);
> > @@ -1217,7 +1219,9 @@ static int mem_cgroup_move_charge_pte_range(pmd_t
> > *pmd,
> >    enum mc_target_type target_type;
> >    union mc_target target;
> >    struct folio *folio;
> > +	bool tried_split_before = false;
> >   +retry_pmd:
> >    ptl = pmd_trans_huge_lock(pmd, vma);
> >    if (ptl) {
> >   		if (mc.precharge < HPAGE_PMD_NR) {
> > @@ -1227,6 +1231,27 @@ static int mem_cgroup_move_charge_pte_range(pmd_t
> > *pmd,
> >     target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
> >     if (target_type == MC_TARGET_PAGE) {
> >   			folio = target.folio;
> > +			/*
> > +			 * Deferred split queue locking depends on memcg,
> > +			 * and unqueue is unsafe unless folio refcount is 0:
> > +			 * split or skip if on the queue? first try to split.
> > +			 */
> > +			if (!list_empty(&folio->_deferred_list)) {
> > +				spin_unlock(ptl);
> > +				if (!tried_split_before)
> > +					split_folio(folio);
> > +				folio_unlock(folio);
> > +				folio_put(folio);
> > +				if (tried_split_before)
> > +					return 0;
> > +				tried_split_before = true;
> > +				goto retry_pmd;
> > +			}
> > +			/*
> > +			 * So long as that pmd lock is held, the folio cannot
> > +			 * be racily added to the _deferred_list, because
> > +			 * __folio_remove_rmap() will find !partially_mapped.
> > +			 */
> 
> Fortunately that code is getting ripped out.

Yes, and even more fortunately, we're in time to fix its final incarnation!

> 
> https://lkml.kernel.org/r/20241025012304.2473312-3-shakeel.butt@linux.dev
> 
> So I wonder ... as a quick fix should we simply handle it like the code
> further down where we refuse PTE-mapped large folios completely?

(I went through the same anxiety attack as you did, wondering what
happens to the large-but-not-PMD-large folios: then noticed it's safe
as you did.  The v1 commit message had a paragraph pondering whether
the deprecated code will need a patch to extend it for the new feature:
but once Shakeel posted the ripout, I ripped out that paragraph -
no longer any need for an answer.)

> 
> "ignore such a partial THP and keep it in original memcg"
> 
> ...
> 
> and simply skip this folio similarly? I mean, it's a corner case either way.

I certainly considered that option: it's known to give up like that
for many reasons.  But my thinking (in the commit message) was "Not ideal,
but moving charge has been requested, and khugepaged should repair the THP
later" - if someone is still using move_charge_at_immigrate, I thought
this change would generate fewer surprises - that huge charge likely
to be moved as it used to be.

Hugh

