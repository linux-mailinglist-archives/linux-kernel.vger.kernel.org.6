Return-Path: <linux-kernel+bounces-539575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FF7A4A5F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E667A4DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5BA1DE2B9;
	Fri, 28 Feb 2025 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnOFdZWn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4561BC9EE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781974; cv=none; b=mpoe2yrsKEafJvi5Pxfsh0cBwDVBNPTjd/iSKLYK3WDXvwVNz4Wgz+elhREr7nP64H1nzIwKCPCfvSlRH3ZwV7purKNsaSFqnZ0ebcDDI+7wCRrgAAlIeBaSvIQ+hWRH2wYykI44T/jzeqhbE6KiYDixyeoPNw8Zvncc/mslsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781974; c=relaxed/simple;
	bh=O0GebC/SdgLZdHlPcLO5yKRPnT4hiBRcnUmcYB/ugMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKC9bMtWZ0IEGh3DuD9tq20vseszbrMXYEMO/9TrM14V/7V3yt9t8w7VkbGBF30utrOJuUs5PNgHDMNZPRKIUmWUCppjAtU+aqGng+0bJWR4onJL0W1e7BozUxKC85+emPlZDY0nnPab+yqc/0Jx/3tye7u1pzosq2tLLS2w5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnOFdZWn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740781971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sB1843xTI8E6I6Uv3+jpu/4UMdPYkCK+nlLxyIrwqY4=;
	b=TnOFdZWnQc5OiKfMWponE9EtwUYEETtMSCiITvzt0nFbnEFh0fIz6ZTqKss5TB5pv2K0D8
	/AOwEB12bkLEUmi9bPP1EiKpOM5NG3eVNYA/NL/OdrBGyvNO6nU+O5r/9P6ei+gtrOG2cF
	RJmNWKZSMp4exUz7p3V0iH8YEYvhIVA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-8cc3FcW7OkiTPFtfP9yy2w-1; Fri, 28 Feb 2025 17:32:46 -0500
X-MC-Unique: 8cc3FcW7OkiTPFtfP9yy2w-1
X-Mimecast-MFC-AGG-ID: 8cc3FcW7OkiTPFtfP9yy2w_1740781966
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-472012f2edfso52792971cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781966; x=1741386766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB1843xTI8E6I6Uv3+jpu/4UMdPYkCK+nlLxyIrwqY4=;
        b=fTlYUHqZ+/SvClwZ91omAR1sa2kl+E+uc7cZqo3LCd1t8EvygZUXPgPNp+6xzUjlRn
         /ijQMBEwPd3L5OQia5KjhWggmPd93n7u4laPOhAuS74FR8uP6eRQ43XRCV/bPzQBQ2ma
         rJujJDSGZd0WcSVtgHBm1cYV45Bzt5x+3h59aizplzkaPYJuLCE+PfdfIb5SbKu8+2LY
         JFTJv59fTDUWoWFL5N7wiGVTN2D445iRFLBA+wS+b/rEoegKhjl89F6WwoBD3dHzBonq
         NeEK/6o89cJAL8KFFLj7UQnYwA5jWLq9P9Ab96w55tByH5FMzhg/3F+GMeMzt1agTuNH
         oOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHaLmFtjSLlUsqxuOQxfuWhPYnnjCWTiTktlpRUi0Dw1FvsgcS+infjpV8W3GZpD82ATjLMDsuBoJ1IpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQNB663Q2KNyPTurTkbvjBgEsd+l8DDNWWSWhq+f6GPlmPc8f
	a+hwabGqRYCt2k0mRlO4H7t0VRQl+/cNWBIiAeOI1u/Fn6Suk1u/RmAk5cX6IHfckrbolmVphHV
	ere7Cw/r4rb/mo4avRSRzy6sCR5+POpJ1dMp6Q2b1YY5DAabX+z2VYT0pt+77eQ==
X-Gm-Gg: ASbGncvoCS/O6T9YnMiXsKHAuGjG3A/sy7TxqUIbGZI1LbNB6zJCQ627TBvMWn5ocx9
	nHteSqy00nNrggBqFrRKFND72ejvCiDP6IdDwHn5mKlfJmhJwh8W0sXQHVmDFKd3nCr58bHreRc
	bQUbooRxSd/OQ13u4MMz+PnQphETrLm/SfbvsDNvhZQ22xiR1s81bdPJh+d22Q/vdabv0v7yq0k
	yEmfltLkZx7a/zPXVcfzmmz16xvMNaEcLlwER5CnilIgLRncyjeDwOVEmu0l6w51iKwkydKwPxS
	a5/84NQ=
X-Received: by 2002:ac8:7c4d:0:b0:473:882f:bcb1 with SMTP id d75a77b69052e-474bc11553dmr76548621cf.46.1740781966127;
        Fri, 28 Feb 2025 14:32:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlD/UdqqRjI56c+mRc1D/klxdusZ2AeL/TuShZH0ZdmlehnjstEE71nYfhGcROB+VVXH5jKQ==
X-Received: by 2002:ac8:7c4d:0:b0:473:882f:bcb1 with SMTP id d75a77b69052e-474bc11553dmr76548281cf.46.1740781965782;
        Fri, 28 Feb 2025 14:32:45 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721c0a64sm30437561cf.42.2025.02.28.14.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 14:32:44 -0800 (PST)
Date: Fri, 28 Feb 2025 17:32:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Olivier Dion <odion@efficios.com>, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
Message-ID: <Z8I5iU6y_nVmCZk6@x1.local>
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
 <Z8HlL4FopVjeveaJ@x1.local>
 <60f148db-7586-4154-a909-d433bad39794@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60f148db-7586-4154-a909-d433bad39794@efficios.com>

On Fri, Feb 28, 2025 at 12:53:02PM -0500, Mathieu Desnoyers wrote:
> On 2025-02-28 11:32, Peter Xu wrote:
> > On Fri, Feb 28, 2025 at 09:59:00AM -0500, Mathieu Desnoyers wrote:
> > > For the VM use-case, I wonder if we could just add a userfaultfd
> > > "COW" event that would notify userspace when a COW happens ?
> > 
> > I don't know what's the best for KSM and how well this will work, but we
> > have such event for years..  See UFFDIO_REGISTER_MODE_WP:
> > 
> > https://man7.org/linux/man-pages/man2/userfaultfd.2.html
> 
> userfaultfd UFFDIO_REGISTER only seems to work if I pass an address
> resulting from a mmap mapping, but returns EINVAL if I pass a
> page-aligned address which sits within a private file mapping
> (e.g. executable data).

Yes, so far sync traps only supports RAM-based file systems, or anonymous.
Generic private file mappings (that stores executables and libraries) are
not yet supported.

> 
> Also, I notice that do_wp_page() only calls handle_userfault
> VM_UFFD_WP when vm_fault flags does not have FAULT_FLAG_UNSHARE
> set.

AFAICT that's expected, unshare should only be set on reads, never writes.
So uffd-wp shouldn't trap any of those.

> 
> AFAIU, as it stands now userfaultfd would not help tracking COW faults
> caused by stores to private file mappings. Am I missing something ?

I think you're right.  So we have UFFD_FEATURE_WP_ASYNC that should work on
most mappings.  That one is async, though, so more like soft-dirty.  It
might be doable to try making it sync too without a lot of changes based on
how async tracking works.

Thanks,

-- 
Peter Xu


