Return-Path: <linux-kernel+bounces-533572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BDA45C35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2001892830
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3C226A08F;
	Wed, 26 Feb 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5cYX4Bx"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F525D54B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567259; cv=none; b=FGjCJefnBM6zLbVAmaPp/wx5aYeB+tLgn8dXTS+fR+SZDQRPaPVwoACGh4QLUJmm9zp64q+3B7fWWAoT/YyvhoiMM6BzdbPOs1rKR7yD88h9//fYzhi9H5p1hp+SPuZmsjJ7dkKJv5lyZlELvYZpu7hObN1B7ki7OD1bJE98NBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567259; c=relaxed/simple;
	bh=x5xg3LwibJXQQaaKDM6VQ+lAP9lfPVdOz0gIsQg4kuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9bxXsi3hpJOvdg9WixGBek6KExfthUQjn3k5tpVQgR43dxPgvHLctWCnnFKRFtAg6kJE70RFIhCxza6TbUER+YRgbHCRUkr+DcnipPACRLzSKkN+8IGEkBEkHV42LT/Rq34CJDywoIw5mjnvwY/7nAoPgYAXQeT6sBUlN6rsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5cYX4Bx; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471f1dd5b80so160871cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740567255; x=1741172055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8k9ussjgNfo7XH+19sy9pLzES4opNKoTTPxfbK8Va7w=;
        b=f5cYX4Bxd88dY7t4MQPx2AdKVuvpWEE3sUTMD5Jt266TY61hY3xGRVW70Vqrl+JlXp
         GmjZ3uYavX61DLSFyCGFiReZZwlz2zxpIA3s/AliLyENIkDafEH4e/brrCLRaHhpveDu
         r5hKll0tbE4C1DFitzluA7Sf71R0mZYEyi0seewgN/ApoVPSlQXNM9IWm5I2OKQ4mfGO
         hkMkNcj0csnZ0Es/kIviCoiQfFFEG4BOwxsQCMkqLGZI3A6fw0yAKqsOiSH60JzKtqLO
         akpTZ8THMO24/QPtnkXpjUNkwLwJ7G/BucQUfBhiaXxbfTD+DlwDJGB05gd9+BXfLsxr
         A1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740567255; x=1741172055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k9ussjgNfo7XH+19sy9pLzES4opNKoTTPxfbK8Va7w=;
        b=sQ+3DdwuUE1w7hMF7ujSBsYRHD1Ktx8A+EsCauj+YYtt5swXlZ/86FJNzruilcyKEb
         yJGi0g2F0ZIySgOkaPklQJrvXS13m7HWN7qsEC4MINZ7ks8yoLqzrlS2QrQRmyWuFzEs
         f2sRbhBd8BXjg6K8FERzkONcnaVS0ArwwOJYb+diCbGaYbXduczKGqWkvY5OdMxerZNs
         klvdu2QBxt5jWatI9NXQR13PHR8FHV5iXFe1wxzRGX9GOjwiEBcMOxaSSkJWNbiLw1v1
         TAfn3WZPA4Wf9xCZ9BOt2yplPWM6pbK2tCoG6wMcnMCuaqwCdpaZBVAbx8pVBI0HwZAi
         IDFw==
X-Forwarded-Encrypted: i=1; AJvYcCV5crEBBWYrLMloI+vU5wBjK17Xg84ouhD9oqsC5ujy9IUy41DV2E2dXwdj/0sJxfr3o5TcF/Ydjyiy8YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZwRMYViDDiW78/y0rJFDRCEwR+3FZGiFgi39hST8nnSuAvHx
	Zn8q1nj2EjeKyZOmwitHdGiDQghSjixgO668wRjYevIy4mooYD59T2nbLIRUCqjxvNQ8ANoTltE
	Mow86/U/qd72YNYrxhYIPMZpZxIyBdm7SBRyw
X-Gm-Gg: ASbGncswQhUO7200LZbsazl0vRH3cQ+PjNOy4YCFNsu9xaCdEtnEIMvPd5tmMKSjpOu
	wrcGh2hLgTHsWnKFAgh4tOOFIxHC6YQgcb/32OWVNK+T4D13c2OvtxUxclbY4l/TivO9A92/fhd
	8MHMBrXUqJN4CFhilqcXMYvsYprfEBXZm+uaY=
X-Google-Smtp-Source: AGHT+IEtUNEH5PpKZRBVaacFBgRUGjAhw23RRBB5/3TVjGiyJAVndyaT1T40ETOgSGf0gVSz9gyrvjommoMUte+jJtQ=
X-Received: by 2002:ac8:5a10:0:b0:471:fefc:f002 with SMTP id
 d75a77b69052e-47376e81cf3mr8973501cf.9.1740566831709; Wed, 26 Feb 2025
 02:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com> <20250224-page-alloc-kunit-v1-4-d337bb440889@google.com>
In-Reply-To: <20250224-page-alloc-kunit-v1-4-d337bb440889@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 26 Feb 2025 11:47:00 +0100
X-Gm-Features: AQ5f1JrJDmTOqjWilOWeguYEmp9d0N0gM7ZtyDHGC2VpER2YE2U_sG3dR8rzJXg
Message-ID: <CA+i-1C2C4GSd3Jhw56WfccKizoeLj4ychCz2BpOU6AwESjzSyg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] mm/page_alloc_test: Add smoke-test for page allocation
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 15:47, Brendan Jackman <jackmanb@google.com> wrote:
> +static inline struct page *alloc_pages_force_nid(struct kunit *test,
> +                                                gfp_t gfp, int order, int nid)
> +{
> +       NODEMASK_ALLOC(nodemask_t, nodemask, GFP_KERNEL);
> +       struct page *page;
> +
> +       KUNIT_ASSERT_NOT_NULL(test, nodemask);
> +       kunit_add_action(test, action_nodemask_free, &nodemask);
> +       nodes_clear(*nodemask);
> +       node_set(nid, *nodemask);
> +
> +       page = __alloc_pages_noprof(GFP_KERNEL, 0, nid, nodemask);

Oops, it's ignoring the gfp argument here.

> +       { .gfp_flags = GFP_DMA32,       .want_zone = ZONE_NORMAL },

And with that fixed, it becomes clear DMA32 allocations can't be
expected to succeed in this zone setup.

(Anyway, it's a bit of a silly test regardless, just something to
illustrate the KUnit idea).

