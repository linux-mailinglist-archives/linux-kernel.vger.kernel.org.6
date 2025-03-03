Return-Path: <linux-kernel+bounces-542721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB49A4CCDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57FC3A61B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5E238D38;
	Mon,  3 Mar 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUmgsx9j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3F237705
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034730; cv=none; b=qYwu0D6puZOmvDtROShkNYWBoA3NYBwsXa3ZKDTBzYDKOHITH5xEVRqxJHjAE+rjjowy7G3vA4gspn3EhPAmHkomtBuWWydP1JaixiKIw0IYD1MlKSmRNgiyUTviD/QQu5pvVz4bHkrAp8RTyKB++0clWfGSUKAWG4kq6DJM1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034730; c=relaxed/simple;
	bh=Ywyb+MQz1/EE6FEVNPJfsfJnKicxgUp5/DhitTQODek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcz2OI0u//w1ANmHhkEfpAIhajGyAZBcYoRCHErNVoBJPb4XCDbTwQartrr8NhJfo82r0c0yb77gCUzjzOBGZW5NXC0udLYy5XUOvQdIE3BoRy8eoBtpopPLBDZ7jDG9v/jE45AvGg7rB8Rltt5oh7OiE/zD5xyvnqUgwfXxSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUmgsx9j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741034727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOa8kLE6/JcsUiXWrc6BUEi3i8IaVFrG4gnUMbJudMc=;
	b=hUmgsx9jxTFGJzLU5B5QlrJnhlfDGzlWa1z8aB+sS66bAjF0faqyCx4qjsokFet4DYgqcn
	zpPyGSYjWJJhp/dk+gjQOcRZct8yIKNkWk/jSBDfze93qGfcQbD/cQuntLh9Svz9BzqJL4
	liDjaNkq7s88J/En09tbmUlnRA5NvhU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-7xQE8-TyOwe72U7j65kFeA-1; Mon, 03 Mar 2025 15:45:21 -0500
X-MC-Unique: 7xQE8-TyOwe72U7j65kFeA-1
X-Mimecast-MFC-AGG-ID: 7xQE8-TyOwe72U7j65kFeA_1741034721
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8c58184e9so30440766d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741034720; x=1741639520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOa8kLE6/JcsUiXWrc6BUEi3i8IaVFrG4gnUMbJudMc=;
        b=aOeiQqCfhhfwBdZQ+VVi8U/RIs/O67CsS3H9FNImNhdugywKcoMMuq0DbXSPRPde63
         dJ+uio7uYNkVeEcrKzcekr7z+peKQ+q9R2TEAE4eZ2lohcoI54ErdAP1qkqZzfvPYNrf
         CZBHvu4gOKLtSTh+rW/xTgNrxederQVYiQN5y7D3zt0ExXY2RElRgR28CryHxC3bI2r3
         X50+VpZ7qZB9gKObWUDKOG2M6U6KfHvooSxbp7mdiL2ToIBCKdi5lftcL2hEwXRO8w1A
         oTMoZO0E5a1oQj15NWfkX3TQFQrZhmZqHQr0KpUVNrpuh8Y5xrAwO+vaSMDkE9Gwi9PM
         CHKg==
X-Forwarded-Encrypted: i=1; AJvYcCXkxRLpVe8fwmtR1go3G7gaYpj31zHiWszVvt1iMbGKcDV41pUd4shj35lAtFDu/s1ggcPMJZb1erCfj+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Hfsy86n0gOZFljajs0OqoFCGExP1JXZKQ615bFJPvT899w1/
	tKk9MKCepoBgNwZxa7mP0pj30Y30jyYr74lUVET2gS4nFVl5ZOJKo+b3AB5+iWxKPgl2m54L/E0
	jOs+KbA5x9vrEVaHAE5Uo59Fxg79mrfIZlW+/+G1AI12j2Yseagzy71Xlmj811B/n1OmSpg==
X-Gm-Gg: ASbGnct/D2ocrB2j2w6iGKpmO0ufWQj9wZfreK7MCzvpbM1MjppC+Vn2Xhu5GUG1vga
	Ryvzby+lfLfi0OV39x1EVpi0FdyJEeDQnQGjhCAunm3wNceAagCFs2UkNF2NBTC1F5BT9MCZDvC
	vnJS7oxQ6hLV92B3+qGQ2376EH3tzn6/Ejb3BCi0FcjySHj102Ck/V2wcC7nRE+fgXpj9mrGyBX
	AsIdMPnfpOw5N7XUVM81+BnJH8jkruJBsuzxPwwJjHX81uiNKweZ7RSBy7x1juyK6CEZQ1sGkp6
	jRYiwx8=
X-Received: by 2002:a05:6214:1d28:b0:6e4:8774:3743 with SMTP id 6a1803df08f44-6e8a0d9f2a0mr219107966d6.41.1741034720287;
        Mon, 03 Mar 2025 12:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS7c+Jcth0ymjCrBovitR0r7qO6DrrfMff/miVtt7KtbKo7B0dh6BtjcpnebNZHWabydFfTg==
X-Received: by 2002:a05:6214:1d28:b0:6e4:8774:3743 with SMTP id 6a1803df08f44-6e8a0d9f2a0mr219107646d6.41.1741034719930;
        Mon, 03 Mar 2025 12:45:19 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634d8dsm57205356d6.10.2025.03.03.12.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:45:18 -0800 (PST)
Date: Mon, 3 Mar 2025 15:45:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Olivier Dion <odion@efficios.com>, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
Message-ID: <Z8YU2_FwTzO-gU81@x1.local>
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
 <Z8HlL4FopVjeveaJ@x1.local>
 <60f148db-7586-4154-a909-d433bad39794@efficios.com>
 <Z8I5iU6y_nVmCZk6@x1.local>
 <72810548-b917-49b7-b7ef-043c6b395d31@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72810548-b917-49b7-b7ef-043c6b395d31@efficios.com>

On Mon, Mar 03, 2025 at 03:01:38PM -0500, Mathieu Desnoyers wrote:
> On 2025-02-28 17:32, Peter Xu wrote:
> > On Fri, Feb 28, 2025 at 12:53:02PM -0500, Mathieu Desnoyers wrote:
> > > On 2025-02-28 11:32, Peter Xu wrote:
> > > > On Fri, Feb 28, 2025 at 09:59:00AM -0500, Mathieu Desnoyers wrote:
> > > > > For the VM use-case, I wonder if we could just add a userfaultfd
> > > > > "COW" event that would notify userspace when a COW happens ?
> > > > 
> > > > I don't know what's the best for KSM and how well this will work, but we
> > > > have such event for years..  See UFFDIO_REGISTER_MODE_WP:
> > > > 
> > > > https://man7.org/linux/man-pages/man2/userfaultfd.2.html
> > > 
> > > userfaultfd UFFDIO_REGISTER only seems to work if I pass an address
> > > resulting from a mmap mapping, but returns EINVAL if I pass a
> > > page-aligned address which sits within a private file mapping
> > > (e.g. executable data).
> > 
> > Yes, so far sync traps only supports RAM-based file systems, or anonymous.
> > Generic private file mappings (that stores executables and libraries) are
> > not yet supported.
> > 
> > > 
> > > Also, I notice that do_wp_page() only calls handle_userfault
> > > VM_UFFD_WP when vm_fault flags does not have FAULT_FLAG_UNSHARE
> > > set.
> > 
> > AFAICT that's expected, unshare should only be set on reads, never writes.
> > So uffd-wp shouldn't trap any of those.
> > 
> > > 
> > > AFAIU, as it stands now userfaultfd would not help tracking COW faults
> > > caused by stores to private file mappings. Am I missing something ?
> > 
> > I think you're right.  So we have UFFD_FEATURE_WP_ASYNC that should work on
> > most mappings.  That one is async, though, so more like soft-dirty.  It
> > might be doable to try making it sync too without a lot of changes based on
> > how async tracking works.
> 
> I'm looking more closely at admin-guide/mm/pagemap.rst and it appears to
> be a good fit. Here is what I have in mind to replace the ksmd scanning
> thread for the VM use-case by a purely user-space driven scanning:
> 
> Within qemu or similar user-space process:
> 
> 1) Track guest memory with the userfaultfd UFFD_FEATURE_WP_ASYNC feature and
>    UFFDIO_REGISTER_MODE_WP mode.
> 
> 2) Protect user-space memory with the PAGEMAP_SCAN ioctl PM_SCAN_WP_MATCHING flag
>    to detect memory which stays invariant for a long time.
> 
> 3) Use the PAGEMAP_SCAN ioctl with PAGE_IS_WRITTEN to detect which pages are written to.
>    Keep track of memory which is frequently modified, so it can be left alone and
>    not write-protected nor merged anymore.
> 
> 4) Whenever pages stay invariant for a given lapse of time, merge them with the new
>    madvise(2) KSM_MERGE behavior.
> 
> Let me know if that makes sense.

I can't speak of how KSM should go from there, but from userfault tracking
POV, that makes sense to me.

Thanks,

-- 
Peter Xu


