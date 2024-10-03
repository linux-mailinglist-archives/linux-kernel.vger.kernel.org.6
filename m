Return-Path: <linux-kernel+bounces-349576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D828598F892
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0223E1C20E05
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E521C57B2;
	Thu,  3 Oct 2024 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5FoKXtz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7411C4637
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989582; cv=none; b=JlVJcyKpqQX3j0ezno8Syia/AyScZKHbzG8YmoaHtel1siUVh4whzDrM0YwZu1rOv9sBzE99GHVdNSxYj/5Z/xl/GuskrrPsCSSldNUqzO+g+Sgni4juxq1qqW6FCvc1+nPW6EmitkKqCF16Il4rWWchb3zqLdqYevJSXpkNWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989582; c=relaxed/simple;
	bh=/JuHMdlJ9WNt13Gz/ok4Kpgofgp0Zv5QG87uWlBo6jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRfDItNkZM8h5TmcMP535H8mqCLst25Ptd4b495AXe8GHRtE2sBtZLG9vdvw4Brdt+MJoDMG1+8/13c04J1ZyIUp6W/ZeYqQZs43TxjJ38jTStANmt8R6iKH2vO0CGP1vjI5ESM2d7gPszAdeSwh3JOSaEp2e8VzMlY3JAWUQOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5FoKXtz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727989579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=co1Cdmbng7qJPNFfC9PHo94sETHhYGaYZfEnWlL7fpI=;
	b=B5FoKXtzo0PeTJi1BlOMY0vRaBrifzF1It2+yItJfQxAz+8/C85jiDab39PKHCFaD6Nwn/
	DeLHEjEMbb8Gug0BUjMYQNtSL2/m7ApbX4YBwkkH+hY5weY4koncbHeIqL87YBVX+0QBAv
	IRTRX3UaRHL2hruSx57l3nAEO85azXY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-IzvklZcMNDmcvllLsGsCvA-1; Thu, 03 Oct 2024 17:06:17 -0400
X-MC-Unique: IzvklZcMNDmcvllLsGsCvA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6d9e31e66eeso29968547b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 14:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989577; x=1728594377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=co1Cdmbng7qJPNFfC9PHo94sETHhYGaYZfEnWlL7fpI=;
        b=JHYpjSQ735A7gBlTFfRCUqL30a6kzU++VsheVs+4K3Z4csXM1zJspk0k1QJs+Svcdo
         amIPkCYHfIRYuQbXGuWh9ex2DtSgtVYKBc979otAd5KPZdSkHxxTw9ODVB9OXuq7ecVn
         U2mGlT4vyUWylK1zhgeIrmBC6rrt1gSR/81uTVVwDhh/R094/3cO5GAg3cZq2556KzXf
         K64QoWAjiQkRcaBkSb81iAH1q5RZR+nehmt9zE5rwXQ/gnpkaY5RuWVDJv7CW8zLkuDM
         9RPjbKlHNgcVuOIz1CpGed2j/fl7NCOjzfRh5bBSuVdXBzqUQRPcZ5T/Az0ffl2wQCGu
         cYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGqpkrSDUF4tdBlV5upFfvBbdZVDnJkgnWIqdj1RbOys81tgk0+3O6cmMCQAIOdXX4RmtseWx9/D7Z/Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYrGFo7UVaUTLWoD9Xfo8ZgG8G3OxO58QQVCj0KTis9GgsgF4
	jar/W+GsPdBTtDr5saIhEC1RXVsnKXpHvVXaofHc7FpfFDJ4hreuL6sAbWu/jIF8wZJCB8bBsyH
	mjMJxDXkXQCKLk/409pFiv13dsV7AWkfeWSK9E3ZFW7BPXtHP57mft8jHtEIW9Q==
X-Received: by 2002:a05:690c:e20:b0:6db:e368:3ff3 with SMTP id 00721157ae682-6e2c72aff7dmr8129547b3.40.1727989577218;
        Thu, 03 Oct 2024 14:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqfS03nDQEpimFlpdc50CpiYA8P/eDMh1b8URFN6pA2GvrN7WtkcL4A8gEhSla9VANYp5P8Q==
X-Received: by 2002:a05:690c:e20:b0:6db:e368:3ff3 with SMTP id 00721157ae682-6e2c72aff7dmr8129257b3.40.1727989576930;
        Thu, 03 Oct 2024 14:06:16 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3dc230sm79033785a.118.2024.10.03.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:06:15 -0700 (PDT)
Date: Thu, 3 Oct 2024 17:06:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: manas18244@iiitd.ac.in, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fixes: null pointer dereference in pfnmap_lockdep_assert
Message-ID: <Zv8HRA5mnhVevBN_@x1n>
References: <20241003-fix-null-deref-v1-1-0a45df9d016a@iiitd.ac.in>
 <Zv7_Fcg4cvzwi7LS@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zv7_Fcg4cvzwi7LS@casper.infradead.org>

Matthew,

On Thu, Oct 03, 2024 at 09:31:17PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 03, 2024 at 09:31:06PM +0530, Manas via B4 Relay wrote:
> > From: Manas <manas18244@iiitd.ac.in>
> > 
> > syzbot has pointed to a possible null pointer dereference in
> > pfnmap_lockdep_assert. vm_file member of vm_area_struct is being
> > dereferenced without any checks.
> > 
> > This fix returns if vm_file member in vm_area_struct is NULL.
> 
> This seems like the wrong fix.  It's mmap'ing a file, so vm_file should
> not be NULL.  Or have I forgotten something very important about how the
> MM works?

If I read the stack right, the crash was before mmap() of the new vma
happens, instead it's during unmap() of one existing vma which existed and
overlapped with the new vma's mapping range:

 follow_phys arch/x86/mm/pat/memtype.c:956 [inline]
 get_pat_info+0x182/0x3f0 arch/x86/mm/pat/memtype.c:988
 untrack_pfn+0x327/0x640 arch/x86/mm/pat/memtype.c:1101
 unmap_single_vma+0x1f6/0x2b0 mm/memory.c:1834
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1900
 unmap_region+0x214/0x380 mm/vma.c:354     <--------------- here
 mmap_region+0x22f9/0x2990 mm/mmap.c:1573
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

It looks like the vma that was overwritten by the new file vma mapping
could be a VM_PFNMAP vma (I'm guessing vvar or something similar..), that's
where untrack_pfn() got kicked off.  In this case, the vma being
overwritten and to be unmapped can have ->vm_file==NULL (while ->vm_ops
non-NULL; /me looking at __install_special_mapping()).

Thanks,

-- 
Peter Xu


