Return-Path: <linux-kernel+bounces-566931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0B5A67E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD04E1697DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF84212F8F;
	Tue, 18 Mar 2025 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6/fGOyI"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511577E1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332277; cv=none; b=sppee/9grCeOMq2gdm6X3ThqpceJXKBZM5rjvRWA4iTlXNTSQ42uAvL7XdrlqpW9ppVGC/linB+qgeXHY3TrD5azaJ3ZW8VJUlh+BHIf8jOIt7MP9kCyWjOWu3oQjzWBsrqDCqp4QzEzh2PJJiA18+nE3xzxnJhphX39ysljuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332277; c=relaxed/simple;
	bh=dKX7d6/PBEnCBg2zkWoFk8K9X6y8ZPUjTHQFD+gcWQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RW+nj3bud7gC+f/FvDxOQNt5moWXyktHoevIq4eZ4P+gO0n4Kmak5Pf+ZgvW3P+Wft+W6+5FGPDbnvyZURMtf08aHZQcF1JOfQ4ddWTaQ0jfOd0NYqSigZtnJ2diobvvy08juSXQIFlwO2Cg/heNjUsFZYVlb0jXRsw9wPTJZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6/fGOyI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2263428c8baso16235ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742332273; x=1742937073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELk1b1nqpO/LqnlYtTtvebO9oIOSeNJWbhKVNUR8CFg=;
        b=L6/fGOyIVQXAqPiDJnrpVsQ6wW8laGIwpijmU3e4XbZHiCxTwj8u2PqJ7hsWLuslT0
         DoWlGodg8/D7Ss6Hk6Ei+HIyWDlm07i1n011CmywMEsRVvno+PPNJWXSktMs845K+aEU
         /Aj2ac+lpF8WHnDWFeX98tVLXqMBJdScV7a8w5mu8c26IrbtReEpkzTCGmtNaFHNZfRK
         7LlZ7wQttj3tVVEjrWGNZaD8b63wYXSewDK3eNdCIvwItYc9h0ttQ0osgrxl7nhW4GGV
         bDdduTT+jQmn1C7Rtu8SJ90auykdgfG93zHp3OmNCIFpUzBte7yxrji5DnJApVcyaEYl
         eDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742332273; x=1742937073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELk1b1nqpO/LqnlYtTtvebO9oIOSeNJWbhKVNUR8CFg=;
        b=DkxpOhdFv0zpApPz1gCvqX2KE8UCAwe5ELJ7rHnWujTeRS54E3uCdA24Ck2hoa8+lA
         Se0lLlwMaMYo8KJ1lmwdB+2hvKJQ0L5SPM4YJZUVb+k0J8q0rKktPBmBIQConvaaI3RU
         9L4XdTVX5Aqy1ZxmfIb+o7FQoUUl8kUvTipZWuJ6quDCn/hOlxfPSKe5PI0AR7iu7EZW
         EfC5idURcEmPnbiEOPH23mBaXlpPM4HqmpMo0yeBGlOQX0cF9+g+cUg4CJh6NTdyGA7g
         0yGgig1H1mMKBh8miLDLwyCyp86J2fF7ZKihHoTN7e1ujT29dcYK3APFkvFnb/lkZrAb
         8M6A==
X-Forwarded-Encrypted: i=1; AJvYcCUQsLRXrVi1LKXD2TiQgsucp9ePeJ66ytdVJTg6AGIj7dJC0CkDrPDnKiqldBATtd9Ge2yn1B1Dz8uOCwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycaeIAbg8sQSs/A7S0q8Ad7T3pnq+p0ZwIZsKGtAMBfrSUPh56
	qkK2XTDNKbYLNl5K3X4qpF9rq47k8FkIHJ3mWoAmGk1YRrcPCzjLreDtdr1t40s/oshY3Bg9YrL
	8aR47kMnHnr/YKUS1vzfYiqpveFF+6TK8zdig
X-Gm-Gg: ASbGncuKAWKIE5JzE902eYaCUPhvvrMtzjMmzzhqrKflBs3QL3RihRQ5WeWo8MxQ4Bx
	HiawIqEwqMHEEvPOSbDL+BaJgKE+gGZKY46czrO76eI9yMroEIvGtlrKW0ZR0wktbhpqjQUr+dX
	LR40kJtskMnR3Qp06pbP4hls68oL37Kn8ekSTwYCuC7GYlhy7RuyTV4V9e
X-Google-Smtp-Source: AGHT+IFGG8DLzonr6FKBbKB+H+1z7WyNrHJ731tM0Sb0OV7WezD5Dx0a7Oj/fMw+cPQIPNCBUA8F/Hx36MDDTZiafwo=
X-Received: by 2002:a17:902:e952:b0:21f:4986:c7d5 with SMTP id
 d9443c01a7336-22646fde80dmr790755ad.8.1742332273177; Tue, 18 Mar 2025
 14:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313181629.17764-1-adrian.hunter@intel.com>
 <ful5rg4jmtxtpyf4apdgrcp3ohttqvwfdwbcrszf6h3jnlhlr5@pfkl6uvadwhu> <2ac8bb8e-c05b-4dc3-a2c1-43e8b936e8f3@intel.com>
In-Reply-To: <2ac8bb8e-c05b-4dc3-a2c1-43e8b936e8f3@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 18 Mar 2025 14:11:01 -0700
X-Gm-Features: AQ5f1JpAV6m7FctwYSrZje59SxYw7q6gGxEIA-wiHl6zPKMoWzRxG1yoWxqsye4
Message-ID: <CAGtprH_9nQ02Phd0RLcq7YDVOE7VKuVkvNnFktfpAsVuBUc+Ow@mail.gmail.com>
Subject: Re: [PATCH RFC] KVM: TDX: Defer guest memory removal to decrease
 shutdown time
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, pbonzini@redhat.com, seanjc@google.com, 
	kvm@vger.kernel.org, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@linux.intel.com, 
	isaku.yamahata@intel.com, linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 8:42=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 17/03/25 10:13, Kirill A. Shutemov wrote:
> > On Thu, Mar 13, 2025 at 08:16:29PM +0200, Adrian Hunter wrote:
> >> @@ -3221,6 +3241,19 @@ int tdx_gmem_private_max_mapping_level(struct k=
vm *kvm, kvm_pfn_t pfn)
> >>      return PG_LEVEL_4K;
> >>  }
> >>
> >> +int tdx_gmem_defer_removal(struct kvm *kvm, struct inode *inode)
> >> +{
> >> +    struct kvm_tdx *kvm_tdx =3D to_kvm_tdx(kvm);
> >> +
> >> +    if (kvm_tdx->nr_gmem_inodes >=3D TDX_MAX_GMEM_INODES)
> >> +            return 0;
> >
> > We have graceful way to handle this, but should we pr_warn_once() or
> > something if we ever hit this limit?
> >
> > Hm. It is also a bit odd that we need to wait until removal to add a li=
nk
> > to guest_memfd inode from struct kvm/kvm_tdx. Can we do it right away i=
n
> > __kvm_gmem_create()?
>
> Sure.
>
> The thing is, the inode is currently private within virt/kvm/guest_memfd.=
c
> so there needs to be a way to make it accessible to arch code.  Either a
> callback passes it, or it is put on struct kvm in some way.
>
> >
> > Do I read correctly that inode->i_mapping->i_private_list only ever has
> > single entry of the gmem? Seems wasteful.
>
> Yes, it is presently used for only 1 gmem.

Intrahost migration support[1] will make use of this list to track
additional linked files. We are planning to float a next revision
soon.

[1] https://lore.kernel.org/lkml/ZN%2F81KNAWofRCaQK@google.com/t/

>
> >
> > Maybe move it to i_private (I don't see flags being used anywhere) and
> > re-use the list_head to link all inodes of the struct kvm?
> >
> > No need in the gmem_inodes array.
>
> There is also inode->i_mapping->i_private_data which is unused.
>

