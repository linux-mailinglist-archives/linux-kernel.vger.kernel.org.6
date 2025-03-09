Return-Path: <linux-kernel+bounces-552869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E5DA58037
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 02:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C2616D7B5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 01:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930EB19BBC;
	Sun,  9 Mar 2025 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkeaAeZP"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5CC2EF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741482604; cv=none; b=clU8ou0AIqU4yHygtWfIMxbglvJCiVM7y16qaO2NijVCYBqYnkLr2leVi314I6or260OpWLtpiS/VLk/Eo6dvw/v6EQP7l6HY4pF1HUyHgi3uV+mdNgiYO32+j2zAhvpz/CdLJP5spkRtofKrhgVKTQnFEGch2EuWAlGf6v/7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741482604; c=relaxed/simple;
	bh=EMETro1CBymXxo+PkEzv8CVP78iq4oJXIfSe7eI5Prs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYhYdsFOT/TBcXUVocSH0DyNdWI99Hj6WKkNIf1bhb0IErY1zciy4atnEKgWz8XG6XKCnK+pUzC8pArTdXAQh72PEZkw40NiqnHcLoAF7JJSRY7+OXIt0w2YL+8ytvlD/DiGK4hGrzYNzgjhj3vERHqtKFd/PaClLdSBkjvWIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkeaAeZP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2242aca53efso104325ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 17:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741482603; x=1742087403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4FPh8cAnZtQW5ZPsNxGskEY/OiXTs4MuYAjZb1WM+U=;
        b=ZkeaAeZPQ7WHdS2CK/13f0SEVvcCYLu7iFqUHpgPI9PUXmfMGxlkjOcbxwXzH2lFCR
         ovavEJ2ReX0jD9uYyfg/h38rnF0bL7psOnlHjBaK+Ifvws3KFBbq1MBhToPtu0xMtCOj
         CrWFlxncNE9PduzEtAg/Po7be/sguR0izvT5IlYtKBRA33AjsH2KBMWs19HaUKqf885Y
         WYSV5a6/ixvWL06uvYbyJprsommeTLNrtIxe5j5H/NLQqGVG7r0U9Ldu1IbIzBT4LqRe
         mRuyhdW4m180pcxrMO5wyUY+KA7rnffBmCaYBRx2/gWu2yhiXK5lfipt9RJT1k8t2OLv
         DW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741482603; x=1742087403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4FPh8cAnZtQW5ZPsNxGskEY/OiXTs4MuYAjZb1WM+U=;
        b=PAiHB8YTTg8A7HyJuJnKysx1W2oIa+u0cHTqFCRS1Ly0D/dgjgriGuGz0feUob6FR7
         UjqqYxgyVN21v+1cUOCcvJddeJtrIyC3pGDVbN/jJVMMSzhZOsOTBJSgBkrwGZTwHGST
         5UKKmjGrGDJJ6ubI7tK9VO1yDuH2Q7HbCN6KzmiODDTLXIFk92PFCPfJT/nJsQTvFCq0
         +NjKFqJYAV1xIVrdJWh4DRJR1odC9VP/lrmg5c4VxysqfYCVqsmyxe5DlOfgr2+hXv2U
         caylBjKIYpzKGPxFJcG6+0je6ExzlOs04R+r5YTL64vLKwN9nrBh6852EEm2hOThaLXr
         dUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+FSTYrg37U12N0xZCsSxYhY01ddlkLXpwdjqg9SmIJ3Q42phXACdhXLUC1cQzDS118Xmm5dYm4llUMYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCPg0p8wj5bv88KxXz9bPlvqvUIwc0BGDYhoeYh9RfRrvQpHf
	Hqs0f0e7zg+zE34baXpfWj4f0FrR+93XbHIGw7NFhk86G+tHFAJtNi0DYON9HpiUKi7O1MZh1p9
	Csw8Nk2OWLu3fSEKG4Lq8xP+0SoHNCjRrvD+F
X-Gm-Gg: ASbGncvrKoPgm6YbLgSIb+Z+0BpwEv6kaKVY/feCNBRbbbz36ZBVUNrlDLzqyDeNOyg
	Vh4wGeFAm9EnhkF0Pz4UNl0cAHMrrom2a6BwRp7itxTcD/HdHcank7TGtnE8UsE820z+caKVNHI
	kar0ojVnV1KfhLgjW4G9Cm8dXuLtVW4+RRGeKghdLCFxMjnu5nKTeqjJnWAA==
X-Google-Smtp-Source: AGHT+IFSArhJYsv3zVVqv8OWZu8TOBKIMea4fF5APrE5l+oYIst19Piwk29+HWLQWw6zl3b0tZUthbrcWcdq34ooI38=
X-Received: by 2002:a17:903:32c7:b0:21f:56e5:daee with SMTP id
 d9443c01a7336-22540e5a9aemr1979785ad.6.1741482602144; Sat, 08 Mar 2025
 17:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226082549.6034-1-shivankg@amd.com>
In-Reply-To: <20250226082549.6034-1-shivankg@amd.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sat, 8 Mar 2025 17:09:46 -0800
X-Gm-Features: AQ5f1JpKR8YeZcYjkYLi6Yj3T7-X4RTGFozEjKkiiy8Q2qes9s3EoImSl39wsJs
Message-ID: <CAGtprH8akKUF=8+RkX_QMjp35C0bU1zxGi4v1Zm5AWCw=8V8AQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Add NUMA mempolicy support for KVM guest-memfd
To: Shivank Garg <shivankg@amd.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, pbonzini@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	chao.gao@intel.com, seanjc@google.com, ackerleytng@google.com, 
	david@redhat.com, vbabka@suse.cz, bharata@amd.com, nikunj@amd.com, 
	michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, tabba@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:28=E2=80=AFAM Shivank Garg <shivankg@amd.com> wr=
ote:
>
> In this patch-series:
> Based on the discussion in the bi-weekly guest_memfd upstream call on
> 2025-02-20[4], I have dropped the RFC tag, documented the memory allocati=
on
> behavior after policy changes and added selftests.
>
>
> KVM's guest-memfd memory backend currently lacks support for NUMA policy
> enforcement, causing guest memory allocations to be distributed arbitrari=
ly
> across host NUMA nodes regardless of the policy specified by the VMM. Thi=
s
> occurs because conventional userspace NUMA control mechanisms like mbind(=
)
> are ineffective with guest-memfd, as the memory isn't directly mapped to
> userspace when allocations occur.
>
> This patch-series adds NUMA binding capabilities to guest_memfd backend
> KVM guests. It has evolved through several approaches based on community
> feedback:
>
> - v1,v2: Extended the KVM_CREATE_GUEST_MEMFD IOCTL to pass mempolicy.
> - v3: Introduced fbind() syscall for VMM memory-placement configuration.
> - v4-v6: Current approach using shared_policy support and vm_ops (based o=
n
>       suggestions from David[1] and guest_memfd biweekly upstream call[2]=
).
>
> For SEV-SNP guests, which use the guest-memfd memory backend, NUMA-aware
> memory placement is essential for optimal performance, particularly for
> memory-intensive workloads.
>
> This series implements proper NUMA policy support for guest-memfd by:
>
> 1. Adding mempolicy-aware allocation APIs to the filemap layer.

I have been thinking more about this after the last guest_memfd
upstream call on March 6th.

To allow 1G page support with guest_memfd [1] without encountering
significant memory overheads, its important to support in-place memory
conversion with private hugepages getting split/merged upon
conversion. Private pages can be seamlessly split/merged only if the
refcounts of complete subpages are frozen, most effective way to
achieve and enforce this is to just not have struct pages for private
memory. All the guest_memfd private range users (including IOMMU [2]
in future) can request pfns for offsets and get notified about
invalidation when pfns go away.

Not having struct pages for private memory also provide additional benefits=
:
* Significantly lesser memory overhead for handling splitting/merge operati=
ons
    - With struct pages around, every split of 1G page needs struct
page allocation for 512 * 512 4K pages in worst case.
* Enable roadmap for PFN range allocators in the backend and usecases
like KHO [3] that target use of memory without struct page.

IIRC, filemap was initially used as a matter of convenience for
initial guest memfd implementation.

As pointed by David in the call, to get rid of struct page for private
memory ranges, filemap/pagecache needs to be replaced by a lightweight
mechanism that tracks offsets -> pfns mapping for private memory
ranges while still keeping filemap/pagecache for shared memory ranges
(it's still needed to allow GUP usecases). I am starting to think that
the filemap replacement for private memory ranges should be done
sooner rather than later, otherwise it will become more and more
difficult with features landing in guest_memfd relying on presence of
filemap.

This discussion matters more for hugepages and PFN range allocations.
I would like to ensure that we have consensus on this direction.

[1] https://lpc.events/event/18/contributions/1764/
[2] https://lore.kernel.org/kvm/CAGtprH8C4MQwVTFPBMbFWyW4BrK8-mDqjJn-UUFbFh=
w4w23f3A@mail.gmail.com/
[3] https://lore.kernel.org/linux-mm/20240805093245.889357-1-jgowans@amazon=
.com/

