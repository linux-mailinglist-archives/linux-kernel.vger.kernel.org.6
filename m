Return-Path: <linux-kernel+bounces-560244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C2A600B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C86D189EB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9331F1523;
	Thu, 13 Mar 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sa7H0qjO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC67F4FA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893141; cv=none; b=T6I/Of4CcM8rxyvnJgnk3hyH8lYGxK/iO/hqEeKorx4Z18c0UXzPFNE9GZSGlfAalwyBSBVbwSR51D6+KtbWaR54hP4shXbwUYPK2nNsM69zBqth7dwdG6hFv4XvVAh8LdOw1gQeP2O9+rDjb0k/KtQ2tFBVVObgx4PHvLZN/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893141; c=relaxed/simple;
	bh=jagCpUiEiGHEWFubbh7emapvGjhnMLj+b75pACy+vZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO6szsp7q359DINPrE63DctotcmehntSdl/i9Xx0yEPseQ69jp+/5rDd0S7DRIiNKiX71jrwkddYbyi6/W1CMTAWWrDnDo7+uqMZzLk7WPxzQu+aC+TKLnLEuDbM2Fz6vtCZT+UJd9jt4uyEyKc1cI3EXwSP9ZmeVI/PMt3rAyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sa7H0qjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741893137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eu8Zt5JHKLInYlZV//fPfzrbXAHVXgUz1d/jNhTgXBA=;
	b=Sa7H0qjOTXP+In0oYuh9aTl+/aGQoPsttMrDXBfMjMyIVcVAragm5qSsf1PGT45uaHj3Z0
	lW4lB+SyHGQCQ4pUKSw0/SVHxsIUftBZYLd8RnkFm4Y6e1Y657Qdk9q2Ety2wy07I1g+0L
	+vPvNAimCaFtBpxrCaAj908vxIMSkGQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-mIhCLnaPM0CM7RbIEC1Ubg-1; Thu, 13 Mar 2025 15:12:16 -0400
X-MC-Unique: mIhCLnaPM0CM7RbIEC1Ubg-1
X-Mimecast-MFC-AGG-ID: mIhCLnaPM0CM7RbIEC1Ubg_1741893136
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c086889ad3so250288485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741893136; x=1742497936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu8Zt5JHKLInYlZV//fPfzrbXAHVXgUz1d/jNhTgXBA=;
        b=HuqBybN78KcOIqYnuhX4hPQxEXA4U/Dt/kFjyp3UVrZYvDuWf8gHMGV+CNu+TI/r9B
         Jnf/MEzLVMTVtgEXgj7r+XzWpg7Jc9Rd+YiC+Mf1Yhsk3RBMJoVJ6kG/edSkHBr5g4Ot
         /rSa4gB6ZD8+VZ2hf9daGw2gi12OuNi0D1AtKl4rwTXwRjIJKC7BM/sEoh5tmMgY3sYb
         KA9cCHNaQGY1RyT9RTzsTnDQhl54rfAEWBvvOZK80YACSMdw0PjR5B88YQIUuemsA4Kf
         V1tqh/9wO8KC2+bLI4X/mCSwTbep1PvWD/4beP5W/i1CebXfJf8ocZiexCOeOJTB46bW
         YJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCVLOPtbho8NpBOchqKeRtlu74lobTXSAmeoWiQDwbGVb2d1AjdYTqJy8wXPC6AEdLbfpXVwaz958IGjDxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNyQrSAHfOekGcqVqT2I5QceqtW0xwgQ3Bdes04kLp+R+S2rH
	Re+XmzTAUtYK7jsuTnunGKEPheVKGgQdhCyM59crupjrZIgdqmQ0wqgyJWJiR3QsMMBYdsUgFzl
	6t5UAtldsagg9tPCAXTSebhhUSW+av7/iC8pb4MOuzOO9mqKrMYXFb+bsdT+ceQ==
X-Gm-Gg: ASbGncuW3giZmx4HXQ+AMnyNQzrnXSCefWYf6Kq4wtJ+H4u6uJkFCQlNa2UfvTXHsER
	kcAtGlFvuyIPzGKxdZG9b4LdYjqs/ZPq/cJRmx+3ZGEz3U0TcBZQOIM9xt3cn1LCpcwTQo9ryJz
	2L06etGvK8Aa/ppEJ0Q1hxaTa2T4V6b5vqtWzM+KaYHQ+drapIfPGEHoEXlJCBeaXWJrTdp4vDy
	tX9dMMoP4SzNgCjOhtniaA48lQN00CHXwP/E/GVKScAB4rfRuuYL1UExiapbQ5Lyah7+uLJnwsl
	oc6CqxE=
X-Received: by 2002:a05:620a:838f:b0:7c3:c13f:5744 with SMTP id af79cd13be357-7c573713527mr744170285a.3.1741893135758;
        Thu, 13 Mar 2025 12:12:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmL8wnHI3XvOc6TmOoi5mIyx1LyijkYTY/k9F1G3PKJ/9z/mlexd/aqNP663C+GN+ActHxCA==
X-Received: by 2002:a05:620a:838f:b0:7c3:c13f:5744 with SMTP id af79cd13be357-7c573713527mr744166785a.3.1741893135438;
        Thu, 13 Mar 2025 12:12:15 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89ad6sm130678585a.102.2025.03.13.12.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:12:14 -0700 (PDT)
Date: Thu, 13 Mar 2025 15:12:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: James Houghton <jthoughton@google.com>, akpm@linux-foundation.org,
	pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, david@redhat.com,
	ryan.roberts@arm.com, quic_eberman@quicinc.com, graf@amazon.de,
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
	nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Message-ID: <Z9MuC5NCFUpCZ9l8@x1.local>
References: <Z8YfOVYvbwlZST0J@x1.local>
 <CADrL8HXOQ=RuhjTEmMBJrWYkcBaGrqtXmhzPDAo1BE3EWaBk4g@mail.gmail.com>
 <Z8i0HXen8gzVdgnh@x1.local>
 <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>
 <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local>
 <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
 <Z9HhTjEWtM58Zfxf@x1.local>
 <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>

On Thu, Mar 13, 2025 at 03:25:16PM +0000, Nikita Kalyazin wrote:
> 
> 
> On 12/03/2025 19:32, Peter Xu wrote:
> > On Wed, Mar 12, 2025 at 05:07:25PM +0000, Nikita Kalyazin wrote:
> > > However if MISSING is not registered, the kernel will auto-populate with a
> > > clear page, ie there is no way to inject custom content from userspace.  To
> > > explain my use case a bit more, the population thread will be trying to copy
> > > all guest memory proactively, but there will inevitably be cases where a
> > > page is accessed through pgtables _before_ it gets populated.  It is not
> > > desirable for such access to result in a clear page provided by the kernel.
> > 
> > IMHO populating with a zero page in the page cache is fine. It needs to
> > make sure all accesses will go via the pgtable, as discussed below in my
> > previous email [1], then nobody will be able to see the zero page, not
> > until someone updates the content then follow up with a CONTINUE to install
> > the pgtable entry.
> > 
> > If there is any way that the page can be accessed without the pgtable
> > installation, minor faults won't work indeed.
> 
> I think I see what you mean now.  I agree, it isn't the end of the world if
> the kernel clears the page and then userspace overwrites it.
> 
> The way I see it is:
> 
> @@ -400,20 +401,26 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
>         if (WARN_ON_ONCE(folio_test_large(folio))) {
>                 ret = VM_FAULT_SIGBUS;
>                 goto out_folio;
>         }
> 
>         if (!folio_test_uptodate(folio)) {
>                 clear_highpage(folio_page(folio, 0));
>                 kvm_gmem_mark_prepared(folio);
>         }
> 
> +       if (userfaultfd_minor(vmf->vma)) {
> +               folio_unlock(folio);
> +               filemap_invalidate_unlock_shared(inode->i_mapping);
> +               return handle_userfault(vmf, VM_UFFD_MISSING);
> +       }

I suppose you meant s/MISSING/MINOR/.

> +
>         vmf->page = folio_file_page(folio, vmf->pgoff);
> 
>  out_folio:
>         if (ret != VM_FAULT_LOCKED) {
>                 folio_unlock(folio);
>                 folio_put(folio);
>         }
> 
> On the first fault (cache miss), the kernel will allocate/add/clear the page
> (as there is no MISSING trap now), and once the page is in the cache, a
> MINOR event will be sent for userspace to copy its content. Please let me
> know if this is an acceptable semantics.
> 
> Since userspace is getting notified after KVM calls
> kvm_gmem_mark_prepared(), which removes the page from the direct map [1],
> userspace can't use write() to populate the content because write() relies
> on direct map [2].  However userspace can do a plain memcpy that would use
> user pagetables instead.  This forces userspace to respond to stage-2 and
> VMA faults in guest_memfd differently, via write() and memcpy respectively.
> It doesn't seem like a significant problem though.

It looks ok in general, but could you remind me why you need to stick with
write() syscall?

IOW, if gmemfd will always need mmap() and it's fully accessible from
userspace in your use case, wouldn't mmap()+memcpy() always work already,
and always better than write()?

Thanks,

> 
> I believe, with this approach the original race condition is gone because
> UFFD messages are only sent on cache hit and it is up to userspace to
> serialise writes.  Please correct me if I'm wrong here.
> 
> [1] https://lore.kernel.org/kvm/20250221160728.1584559-1-roypat@amazon.co.uk/T/#mdf41fe2dc33332e9c500febd47e14ae91ad99724
> [2] https://lore.kernel.org/kvm/20241129123929.64790-1-kalyazin@amazon.com/T/#mf5d794aa31d753cbc73e193628f31e418051983d
> 
> > > 
> > > > as long as the content can only be accessed from the pgtable (either via
> > > > mmap() or GUP on top of it), then afaiu it could work similarly like
> > > > MISSING faults, because anything trying to access it will be trapped.
> > 
> > [1]
> > 
> > --
> > Peter Xu
> > 
> 
> 

-- 
Peter Xu


