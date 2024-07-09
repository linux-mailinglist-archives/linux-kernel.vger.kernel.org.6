Return-Path: <linux-kernel+bounces-246612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC0592C44E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC840B2169F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DC182A61;
	Tue,  9 Jul 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X58P9/O8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFF17B02B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555509; cv=none; b=IyMNUXPFxj0YFCFkZfLTAdfdBttkb+wIqJBNOxffP8tE0Se8kODSrjhFCR4Vhzi2QutveEBTUppA69zSci2/O7CMpUbKvRv1n88cyTvbo9jGgK5uj42j/wWnmHmwrfz8vTxlmqfhWn9NtIHvbJ8w2Z4qaJUccptwgZ8xEgRYIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555509; c=relaxed/simple;
	bh=TdbFGda/jsBTS87FOe2ez9VQLOM2T6b8e2FlCrnOKEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F477vDfpaw0Cm8p/2X6aGjfaNDaJr9VXejoT+ZPu0naWXpGBShNIY6sDhfchx+vgyCWD7bcJjWbOIRtETCvIYfW9t3FG0ebOppqK+BDDU2m9vikV3FD4a/PaEEK38wQcWyrrf0rAafylaC09b4ULk7mnsfpdJ6DdzVetbIME7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X58P9/O8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720555506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acV3bdXIqAgQ8trrw2JLt1DVrqR2fOsC/08QRSeWEs4=;
	b=X58P9/O81hwd8xjm9OHkG9mhc53vubhV7oUcjxOQFXS5IH1v5S9gBkPNocCO8HORwaFav1
	DISKMQ3AndJNFBOCTsnwN701d3Om3GbI6Gyw0+s73giB0nOAwE7gyu30ILmKVa8xmiUx4R
	jjN1qR/pgwTmSgjW5s+adfO48gSCQp8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-Ioh_wX9vO3eiG6jxrDEGwA-1; Tue, 09 Jul 2024 16:05:05 -0400
X-MC-Unique: Ioh_wX9vO3eiG6jxrDEGwA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-447e6064232so3567581cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720555505; x=1721160305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acV3bdXIqAgQ8trrw2JLt1DVrqR2fOsC/08QRSeWEs4=;
        b=VsJoHeXe7kqMZW8k2GE5f/nNkGvrilrqDOBGswFQUioMnfLcVXn4ji4r55ufwPF5VH
         HHtbzb+Ey9s/t5rXcxT7VtUrym9PRhObmuIZmWLUqJHTh+PvSZX7Qw0CIOb+0DXN2Vxb
         9Btwhwcqxa6sjQtB2P/25qNHsSnPu+OEJ2TEQQqlyTy+Z2P3Kv9IjL7Gyf6iP+JepMoa
         5VjVoeiujurJkQWKe+2ms1Nn5qTIyaZc/tTcNww4BxDmQana7jfK1OOXzTgOoIxzTrBK
         FVH/1c21pvsvC+lmVD7stR4WkDjNYb9lZeOMWMU04YIBBhD2T/BXZ2JKomtw+x2LaIlh
         vTdA==
X-Forwarded-Encrypted: i=1; AJvYcCVPPTeF3s6Gn5VgIuyX1VUERexSA0h4C4HANtu1V/nyEweWK6IxlIKqjMv+wOjLUh0Hz0Etpzn3YC5xKCN5wSza9S2EM9jGRl+lU6ua
X-Gm-Message-State: AOJu0YznguD2LK7EodC8qjIep41hZEadqOHGdoI9dAscjaIB+wnxuv5D
	zNlh6d6sRpRe4DPUWf0P0LZaurHfLblRyKAmBbXaHAyzDjVoN+4VI8jFKUPjj84a7Aem1bn3Ifj
	upBaygzk6ohvS366DDuMRBpdODrzQkAzrGjMp5BGFF7MYgBnJRVXVX/jfXkIsHQ==
X-Received: by 2002:a05:620a:171f:b0:79f:4e6:180c with SMTP id af79cd13be357-79f199d7312mr455690885a.1.1720555504901;
        Tue, 09 Jul 2024 13:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGod5HLhjaEtr8mfDORMGJvPtwJ15+Y7CImilQWW2qICV4jpZZUSz7pT07l60mMJH24idc6CQ==
X-Received: by 2002:a05:620a:171f:b0:79f:4e6:180c with SMTP id af79cd13be357-79f199d7312mr455688385a.1.1720555504525;
        Tue, 09 Jul 2024 13:05:04 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff691bsm129139385a.21.2024.07.09.13.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 13:05:03 -0700 (PDT)
Date: Tue, 9 Jul 2024 16:05:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org, linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 3/3] mm: Add p{g/4}d_leaf() in
 asm-generic/pgtable-nop{4/u}d.h
Message-ID: <Zo2X7aOxBb7U5J2s@x1n>
References: <b601e1a88e3a5d4d93b130fa20184b555e2a2bea.1720074307.git.christophe.leroy@csgroup.eu>
 <c8cb83b709740f7ac835997b88c5ddda610f66ab.1720074307.git.christophe.leroy@csgroup.eu>
 <Zoa2Qnpzl97hmpHC@x1n>
 <56a0340a-2534-4d2e-92e4-cf27a6358b23@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56a0340a-2534-4d2e-92e4-cf27a6358b23@csgroup.eu>

On Tue, Jul 09, 2024 at 09:48:24PM +0200, Christophe Leroy wrote:
> 
> 
> Le 04/07/2024 à 16:48, Peter Xu a écrit :
> > On Thu, Jul 04, 2024 at 08:30:05AM +0200, Christophe Leroy wrote:
> > > Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
> > > issues") added pud_leaf() in include/asm-generic/pgtable-nopmd.h
> > > 
> > > Do the same for p4d_leaf() and pgd_leaf() to avoid getting them
> > > erroneously defined by architectures that do not implement the
> > > related page level.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > >   include/asm-generic/pgtable-nop4d.h | 1 +
> > >   include/asm-generic/pgtable-nopud.h | 1 +
> > >   include/linux/pgtable.h             | 6 +++---
> > >   3 files changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
> > > index 03b7dae47dd4..75c96bbc5a96 100644
> > > --- a/include/asm-generic/pgtable-nop4d.h
> > > +++ b/include/asm-generic/pgtable-nop4d.h
> > > @@ -21,6 +21,7 @@ typedef struct { pgd_t pgd; } p4d_t;
> > >   static inline int pgd_none(pgd_t pgd)		{ return 0; }
> > >   static inline int pgd_bad(pgd_t pgd)		{ return 0; }
> > >   static inline int pgd_present(pgd_t pgd)	{ return 1; }
> > > +static inline int pgd_leaf(pgd_t pgd)		{ return 0; }
> > >   static inline void pgd_clear(pgd_t *pgd)	{ }
> > >   #define p4d_ERROR(p4d)				(pgd_ERROR((p4d).pgd))
> > > diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
> > > index eb70c6d7ceff..14aeb8ef2d8a 100644
> > > --- a/include/asm-generic/pgtable-nopud.h
> > > +++ b/include/asm-generic/pgtable-nopud.h
> > > @@ -28,6 +28,7 @@ typedef struct { p4d_t p4d; } pud_t;
> > >   static inline int p4d_none(p4d_t p4d)		{ return 0; }
> > >   static inline int p4d_bad(p4d_t p4d)		{ return 0; }
> > >   static inline int p4d_present(p4d_t p4d)	{ return 1; }
> > > +static inline int p4d_leaf(p4d_t p4d)		{ return 0; }
> > >   static inline void p4d_clear(p4d_t *p4d)	{ }
> > >   #define pud_ERROR(pud)				(p4d_ERROR((pud).p4d))
> > > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > > index 2a6a3cccfc36..b27e66f542d6 100644
> > > --- a/include/linux/pgtable.h
> > > +++ b/include/linux/pgtable.h
> > > @@ -1882,13 +1882,13 @@ typedef unsigned int pgtbl_mod_mask;
> > >    * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
> > >    *   pXd_devmap(), or hugetlb mappings).
> > >    */
> > > -#ifndef pgd_leaf
> > > +#if !defined(__PAGETABLE_P4D_FOLDED) && !defined(pgd_leaf)
> > >   #define pgd_leaf(x)	false
> > >   #endif
> > > -#ifndef p4d_leaf
> > > +#if !defined(__PAGETABLE_PUD_FOLDED) && !defined(p4d_leaf)
> > >   #define p4d_leaf(x)	false
> > >   #endif
> > > -#ifndef pud_leaf
> > > +#if !defined(__PAGETABLE_PMD_FOLDED) && !defined(pud_leaf)
> > >   #define pud_leaf(x)	false
> > >   #endif
> > >   #ifndef pmd_leaf
> > 
> > Is it possible to do it the other way round, so that we can still rely on
> > "ifdef pxx_leaf" to decide whether to provide a fallback, and define them
> > properly when needed?
> 
> What do you mean by the "other way round" ? Did I do a mistake ? I can't see
> it.
> 
> The purpose here is:
> - If the architecture has the said level and implements pXd_leaf(), that's
> fine
> - If the architecture has the said level and doesn't implement pXd_leaf(),
> that's also fine, a fallback is provided.
> - If the architecture doesn't have the said level but implements pXd_leaf(),
> it will conflict with the definition in include/asm-generic/pgtable-nopXd.h
> and the build will fail.
> 
> The purpose is to make sure architectures don't implement pXd_leaf() at the
> wrong level, for instance:
> - an architecture without PMDs shall not implement anything else than
> pmd_leaf()
> - an architecture without P4Ds shall not implement pgd_leaf().

What I meant is it'll be nice to keep the pattern of using:

#ifndef XXX
#define XXX ...
#endif

Rather than:

#if defined(YYY) && !defined(XXX)
#define XXX ...
#endif

The reason is it is not as obvious as previous one, and we can still miss
some defines depending on whether YYY was there.

The current patch also didn't follow the rule where "if pxx_leaf is
defined, we should define the macro" rule.  Then we introduce yet another
rule for defining these.

In short, what I thought as "the other way round" is as simple as something
like:

===8<===
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 8ffd64e7a24c..cce31c1f9159 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -31,8 +31,8 @@ static inline int pud_none(pud_t pud)         { return 0; }
 static inline int pud_bad(pud_t pud)           { return 0; }
 static inline int pud_present(pud_t pud)       { return 1; }
 static inline int pud_user(pud_t pud)          { return 0; }
-static inline int pud_leaf(pud_t pud)          { return 0; }
 static inline void pud_clear(pud_t *pud)       { }
+#define pud_leaf(pud)                          false
 #define pmd_ERROR(pmd)                         (pud_ERROR((pmd).pud))
 
 #define pud_populate(mm, pmd, pte)             do { } while (0)
===8<===

When used as a macro we don't need to touch linux/pgtable.h.  Would that
look nicer?

Thanks,

-- 
Peter Xu


