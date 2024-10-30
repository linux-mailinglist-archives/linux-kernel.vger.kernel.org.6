Return-Path: <linux-kernel+bounces-388911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1219B65FA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287961F24D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10C1F8F09;
	Wed, 30 Oct 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8ny6gkb"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5251F131C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298702; cv=none; b=qN1gFVftqoTtDr7CTLDcRuF9i8TkKBprdbNCkPnYCU8m6SaPAkN6QGZqw3w4QZRPycNdAWO1vqOAkcyl21fx8SJ4w1QGgWIhIx9IIfwpdq62sRuAoKIU9Nhh5UGWWpqvmjIvzwwq76EiRcRQncEvg+K2FtS0MkFarYIIxEKYwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298702; c=relaxed/simple;
	bh=+ZAOI2L/59k17v7WpGBspS9eCfLH+WyqrgQ4JxTMXiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OeioFUACIClcjCzhAJ9iy21003vIaMYPCtE14ZxLLk7I9Dwve/P/Th6qaBmXx5Jcs3Upry2tlh/Z3BaCTcL9swia/+iw41rBsEBwhcIog6ka/7P2aAApEheTnW1IxZfmulPLIZoW8eFOmOQ5VLQhHD+HAjoY4qGQBBTch3YgfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y8ny6gkb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e49ae1172so6429782b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730298700; x=1730903500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0C/7DnA/y8wAesZ1qIY7l4f44jX4OYQkU92X7kuhu9Q=;
        b=y8ny6gkbHqvWc6lTVOwsGFOCHBcK7OmYm/psQUt+xTj/yW4sitVIITqe3cwV0G6U0T
         pLWRbPrjPjWQ8BoC1XMgefJb0mf5K2q6w06JBEXlH3+aQzWlg1WS9e8S122O4E7Wt/yF
         4mLKrwE4RlCPiY3zRa5weA3tlLMBQu/lUCmB+YGoBkFnj1psBXw0FZ65n12iCFUtj1vS
         m/onJ/dWcuQG00fxV1J9PV97ocVd98flqdEsvf8Dm6M0hDSui1ZBWqslufnW7DulwXOY
         t3nMa0tvE0HG4oQPxZAJN4RgoYWBoxFcAzoZmV438phjo0dypm5uE9DsIm9xK6YJbra6
         2Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298700; x=1730903500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0C/7DnA/y8wAesZ1qIY7l4f44jX4OYQkU92X7kuhu9Q=;
        b=Q57NgxqoGdoYhD5acCrgNh2o3XezDIStD7agfsKlu28tqmNn37mZL6Yzl9hx6YdZWJ
         +O+CJAx0Drf3qamR8U11fucQB3pxnbokt/VziXPeEazlZ4KllbZBf6Vxgb4zxDGEmdBy
         jUiAx3s6VMea6WmRYgj+EBEOD5BRDATSva+MxZiHsbkMc9aPW1Bz8DydQJgi4i65R6vc
         CbrEqAhvR8fqmr3f/G75/Ru0XnNOx8TVidz8vYJipyI2T+oyMny2bA1RUxEDEJRLJr0o
         jXh6L1UzE+sFSGIusFst6Hny+PsHKBMdR4B8ojQSKZwR5P/uzUQnw28yE+h2bd1gG6zW
         WotQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+8WrompfaDUPFCoCQlwChHKIzKgwd5CyxS55d6TFkCjPKYdLt7e5ebgVnTOFGpa3aKOlBAOJhGeHRR44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgfNYrjnyr9VSYyw/WJODqqIgsQVfJsvVaYxCFO00EBwq2q1K
	CaPBsCEX3u1PhwE86qVQ1UUVFc8PtuUkAu5j4pb3H6a1eta2u+4UmVdScnL7tThKX94l0igpiQE
	hyg==
X-Google-Smtp-Source: AGHT+IF8rMp2gxMuCaV/iHlOaeyvVg3V14dw5/CmY/hotCMcZb9W2xqvA/5krrLvEDL/BlsrKLqEQCxvGLg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a62:e708:0:b0:71e:5580:f456 with SMTP id
 d2e1a72fcca58-7206306de0fmr28754b3a.3.1730298700012; Wed, 30 Oct 2024
 07:31:40 -0700 (PDT)
Date: Wed, 30 Oct 2024 07:31:38 -0700
In-Reply-To: <b2b7be300469aa59933f08257c794675895d49f8.1728684491.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728684491.git.ackerleytng@google.com> <b2b7be300469aa59933f08257c794675895d49f8.1728684491.git.ackerleytng@google.com>
Message-ID: <ZyJDSqlB_U_z7V74@google.com>
Subject: Re: [RFC PATCH 1/3] mm: hugetlb: Simplify logic in dequeue_hugetlb_folio_vma()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: muchun.song@linux.dev, peterx@redhat.com, akpm@linux-foundation.org, 
	rientjes@google.com, fvdl@google.com, jthoughton@google.com, david@redhat.com, 
	isaku.yamahata@intel.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, tabba@google.com, quic_eberman@quicinc.com, 
	roypat@amazon.co.uk, jgg@nvidia.com, jhubbard@nvidia.com, pbonzini@redhat.com, 
	erdemaktas@google.com, vannapurve@google.com, pgonda@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 11, 2024, Ackerley Tng wrote:
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

The period here, and the comma later, are weird.

> Applying de Morgan's theorem on
> 
> avoid_reserve || !vma_has_reserves(vma, chg)
> 
> yields
> 
> !avoid_reserve && vma_has_reserves(vma, chg),
> 
> hence the simplification is correct.

Whitespace exists for a reason :-)

---

As proof, the original two if conditions

  !vma_has_reserves(vma, chg) && !available_huge_pages(h)

and

  avoid_reserve && !available_huge_pages(h)

can be combined into

  (avoid_reserve || !vma_has_reserves(vma, chg)) && !available_huge_pages(h)

Applying de Morgan's theorem on

  avoid_reserve || !vma_has_reserves(vma, chg)

yields

  !avoid_reserve && vma_has_reserves(vma, chg)

hence the simplification is correct.

---

