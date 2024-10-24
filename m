Return-Path: <linux-kernel+bounces-379773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32759AE37D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F110281695
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9931C9EB7;
	Thu, 24 Oct 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PksvEK/0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083341C174A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768419; cv=none; b=nGm7/cAcNli5yV7KMTZ3OY7xL87CIUgUYhqE9pubZxOBDAhfrhBh6YyzMV1ne0BIqoCanAu/RsO/3+U/oq6qzqd+DTfB3U9LjtARFcjRB0xeDMkUvELirtFodqojpaPt0W5Kpjewszl3HvD8jpqBCMaaY4isS4WZ09M2pjlGx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768419; c=relaxed/simple;
	bh=wTStZVdsK7XzQi2Yh/SFMkS+5Tzo9LDkBF2xEN1og2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhPQnAZLYdkvbI9LSs0qgQRLAUsQUKfrq4g2z3lcG3cEGEFdoNhn79qXEzgwPM4Dgs1O5mmeIRt/bjBDiN4X8DX9/oGSS3FlNaqpk8RqTXYp3fTcxJIHNTmwk2BVXyH3ZpxvFmifdR3dWTTaHGgM1TBelc5UkVmOTtkSwvrLywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PksvEK/0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315855ec58so1215335e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729768414; x=1730373214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imSjjMdCGM+aw7g8sBxgyv1wz/fsW/mplJEegqFMe/Y=;
        b=PksvEK/0WQdlwZEe8/Tnte+XgaUPKd3OKCrb7isot/WfWElKOpFTv4W/13FLk5xEsE
         8irIK+euol4HMJBU8vO6sleVJSZftcqHc1pTGfxzVfIl6NBlAze9J8jyoo6JhfuXeQMu
         +wvHtRu+ouqPkxw73JNN3PTFqc80Ph6GNzuwxWyZT8Woo3a7keLTQfjstanwF0FLInFr
         ft6+dOt8IjrLz4GQj0ZvorGuBxLYf4a8aegDPf68byXlv+jop482LmEfaAy4MV3Z3v/l
         JFX7DVbKPA4ZaCTNMft2Msho1liN/DYDKsqtqFBIw43Z3LV+MeUkHJ8pZDW+pW0/2sYs
         3qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729768414; x=1730373214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imSjjMdCGM+aw7g8sBxgyv1wz/fsW/mplJEegqFMe/Y=;
        b=PVduHVpNOJkvkhAZr7gSwO0Z+CrTWG9Yc4odqTNfjz9qM7rz804449G/vqXpCKqpCV
         5eoXY6B7zIfUeLJPFZPH475YhK73JzUm68u0VRsesQTSOHLiOkJUM7tG2n6vM1mj4uYW
         zTNznAdcjYISUUihHQFimjCHxOTHqWQ9hyjdeCWxt58MTIpzZrjBoN7W4/YkgAdzcKGc
         I9eRPH0jC2EnmD7P1lWV7c4U2gUcnpUepM0Gm0qhkspPF+iRH3NHbssVKoF2x6coehmg
         X8jYgtLXwPeBmszDacXsiDLGlaf39zkmKcujYKUME5cXnwVQHi9e+U5E2yGdx3mQY7pz
         seFg==
X-Forwarded-Encrypted: i=1; AJvYcCXzsD+Eg82+Rr9YftifKb3d6v/yUqzIDm9K/IkOUn1dmkZrjCnvRy5hytb8XqLha2lh5sdiMaSoYmkmlYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYSFwVUSWdnWSA+g4Ppho9Rl4TkWBIqDyZr4G/LgoNaIUwMcEO
	/ZJ+1mHxIubopQBLMq9z0t4mJDumPtSrXp6EMneel0I0DbyBBG5rm0hRlBaZDiY=
X-Google-Smtp-Source: AGHT+IGIXilVoLz80S9lTX9xPagKYC9relfalPeQ6MVSzPoX86xnZqbX87TXtrWjzG6YzftDbrnT/w==
X-Received: by 2002:a05:600c:1d06:b0:42c:c59a:ac21 with SMTP id 5b1f17b1804b1-43184139fbamr19560845e9.2.1729768414142;
        Thu, 24 Oct 2024 04:13:34 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55d753sm14111295e9.11.2024.10.24.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:13:33 -0700 (PDT)
Date: Thu, 24 Oct 2024 13:13:31 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Rik van Riel
 <riel@surriel.com>, Matthias <matthias@bodenbinder.de>, Andrew Morton
 <akpm@linux-foundation.org>, Linux kernel regressions list
 <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Yang Shi <yang@os.amperecomputing.com>
Subject: Re: darktable performance regression on AMD systems caused by "mm:
 align larger anonymous mappings on THP boundaries"
Message-ID: <20241024131331.6ee16603@mordecai.tesarici.cz>
In-Reply-To: <a7585f3e-d6c7-4982-8214-63a7ec6258ad@suse.cz>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
	<f81ef5bd-e930-4982-a5a8-cd4aca272912@suse.cz>
	<ce35b58e-f18c-4701-8494-fa8d1f6e5148@suse.cz>
	<20241024124953.5d77c0b3@mordecai.tesarici.cz>
	<a7585f3e-d6c7-4982-8214-63a7ec6258ad@suse.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 12:56:27 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 10/24/24 12:49, Petr Tesarik wrote:
> > On Thu, 24 Oct 2024 12:23:48 +0200
> > Vlastimil Babka <vbabka@suse.cz> wrote:
> >   
> >> On 10/24/24 11:58, Vlastimil Babka wrote:  
> >> > On 10/24/24 09:45, Thorsten Leemhuis wrote:    
> >> >> Hi, Thorsten here, the Linux kernel's regression tracker.
> >> >> 
> >> >> Rik, I noticed a report about a regression in bugzilla.kernel.org that
> >> >> appears to be caused by the following change of yours:
> >> >> 
> >> >> efa7df3e3bb5da ("mm: align larger anonymous mappings on THP boundaries")
> >> >> [v6.7]
> >> >> 
> >> >> It might be one of those "some things got faster, a few things became
> >> >> slower" situations. Not sure. Felt odd that the reporter was able to
> >> >> reproduce it on two AMD systems, but not on a Intel system. Maybe there
> >> >> is a bug somewhere else that was exposed by this.    
> >> > 
> >> > It seems very similar to what we've seen with spec benchmarks such as cactus
> >> > and bisected to the same commit:
> >> > 
> >> > https://bugzilla.suse.com/show_bug.cgi?id=1229012
> >> > 
> >> > The exact regression varies per system. Intel regresses too but relatively
> >> > less. The theory is that there are many large-ish allocations that don't
> >> > have individual sizes aligned to 2MB and would have been merged, commit
> >> > efa7df3e3bb5da causes them to become separate areas where each aligns its
> >> > start at 2MB boundary and there are gaps between. This (gaps and vma
> >> > fragmentation) itself is not great, but most of the problem seemed to be
> >> > from the start alignment, which togethter with the access pattern causes
> >> > more TLB or cache missess due to limited associtativity.
> >> > 
> >> > So maybe darktable has a similar problem. A simple candidate fix could
> >> > change commit efa7df3e3bb5da so that the mapping size has to be a multiple
> >> > of THP size (2MB) in order to become aligned, right now it's enough if it's
> >> > THP sized or larger.    
> >> 
> >> Maybe this could be enough to fix the issue? (on 6.12-rc4)  
> > 
> > 
> > Yes, this should work. I was unsure if thp_get_unmapped_area_vmflags()
> > differs in other ways from mm_get_unmapped_area_vmflags(), which might
> > still be relevant. I mean, does mm_get_unmapped_area_vmflags() also
> > prefer to allocate THPs if the virtual memory block is large enough?  
> 
> Well any sufficiently large area spanning a PMD aligned/sized block (either
> a result of a single allocation or merging of several allocations) can
> become populated by THPs (at least in those aligned blocks), and the
> preference depends on system-wide THP settings and madvise(MADV_HUGEPAGE) or
> prctl.
> 
> But mm_get_unmapped_area_vmflags() will AFAIK not try to align the area to
> PMD size like the thp_ version would, even if the request is large enough.

Then it sounds like exactly what we want. But I prefer to move the
check down to __thp_get_unmapped_area() like this:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2fb328880b50..8d80f3af5525 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1082,6 +1082,9 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
 		return 0;
 
+	if (!IS_ALIGNED(len, size))
+		return 0;
+
 	if (off_end <= off_align || (off_end - off_align) < size)
 		return 0;
 

