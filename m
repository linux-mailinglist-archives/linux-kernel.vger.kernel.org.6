Return-Path: <linux-kernel+bounces-534914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCFAA46CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF75416E1FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F8022A81C;
	Wed, 26 Feb 2025 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eB8+emjF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99F20F060
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602631; cv=none; b=ECYnpuuKGTfWEW5ojK6R8IUZgFCHHT4ncp8X9kAx9x7pUOnsc9k5ZMmxlteBFfyPI3128FQVBa83buWpsL7CPOeHMzvZmDWGTiCwl6oRrqYLRx1nqsdV6reCh76QrQ79dN03IEkv+6i3rjaDHFvAspV0/MLVwTH+Rh0syE/dAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602631; c=relaxed/simple;
	bh=+ruaCMehGYFua+tFCSHEmxudmg2YDhg0fq3RTLX1bos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQct7+95scJQ88PeBtBBh18RFHhWpalczxLwWr7HGM2y2dkQBN/I0Nn6mF2lj0yxer/6gnc6hHeo6vIoEdgrODufXMUUiy1j5OIOBtCRO93ofC/YaRr9dSdsuiXcJBIP2TVr1jESDX0SzSI2qAnawoA4P8xBbqjLuPzWN3l8jPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eB8+emjF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740602628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0dzl5SDcbfWTKxhGQl5HtUv9pp6OHwLmqZpG5FxCO8=;
	b=eB8+emjF5ZvR8PgN4jYLpnyBNZXMZoVLJOarIRZCtoTKktFeGgFkd+fFYcA1doVRXZKhHy
	TuLjwBWx8SEoFc8Dj5ph/35Mh9hRjJL1FXqfufnIHORqjksFGjn2Bi1g9Rp6woogq5AkW5
	vjWyJhndRUdylf9OKOxHXtGsQmNqoWA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-o1PLBVz6Md-4vNeJ-PP2HA-1; Wed, 26 Feb 2025 15:43:47 -0500
X-MC-Unique: o1PLBVz6Md-4vNeJ-PP2HA-1
X-Mimecast-MFC-AGG-ID: o1PLBVz6Md-4vNeJ-PP2HA_1740602626
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e682a1c92aso2920766d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740602626; x=1741207426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0dzl5SDcbfWTKxhGQl5HtUv9pp6OHwLmqZpG5FxCO8=;
        b=n22b7v2/Rn9EJal28R3LhQ7HJBVH9UzV0eMFV5mHq6i82o2oT9sGPBU6g8owZnKJbB
         4d+XLR3SnBCXFPvlSeqI6kZRlyT4FCST+/K0QiS6y1UIhXCMnQmjxD0AOlYqbfzEOGMo
         G6BS+w+bERaEARRj/qiry2itwXWPD6iWnlzBWKLjghMT73zI3tDgMmwXRn2zlcBE663C
         lggowDM5JKIDYastyDE7xlYPkt0zAybZnd3eq7bIEerklP0bCArgHJDhrfXAMu7pmLYh
         QO70JilwKwkTyICmvtZDzuBzEnxKnXFF+Yj0PIzllDfL3lYPLnn/KoLNLkCgWnkgqvJO
         UBcg==
X-Forwarded-Encrypted: i=1; AJvYcCVGIRl6fuuBIFSc/eyi+uWZQpLhfg/kZEKi5hmgJbA2N+vOUzARWRes91HDnTyjH2ueAjj1w1rrGsFXwoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gKcNh+DuC+SIMcZStZkPMRO9q5cczB9ZK53PoB819R7MMmQd
	/9LocwvadjflAnMDwL1cmgdO1pwD3FghgPYoEN3OauYaO81kquGwWd6qfRMTT8L3Bga7lvUjk9U
	3s1PJP9Bs0BE07/pZETunfvBTINcxn0G8D3YPiBie5oqyiudMRBo/4oLZcm9s5Q==
X-Gm-Gg: ASbGncufeuRmr/ZklXElGlBb2Cc16ianstB+vcdhgJ+jU+rtfPa8jLpLVW7u2GHvJPP
	nXIUW4eaxmMXu/MBHa9LFpp+yldhZEt0JpGLiIdlswvaPQl6VjMJd6j8ALzWIKd+eLpTNE8y3pI
	HYyBDlmHw0X4VYkc/FnC2fZ6PCg2mIMEsoCh5l6JM5KF1Ufl96QKOo1y3Q3/9HnsdfvynqmDDnS
	vLXDLPKjTACt9inZElDagdRS/QFdcfTKV54bV4jLVjEkjGkVLfWcMAFxGbE6YYzuXObRg==
X-Received: by 2002:a05:6214:492:b0:6e6:630c:71e8 with SMTP id 6a1803df08f44-6e886870f50mr77100636d6.7.1740602626568;
        Wed, 26 Feb 2025 12:43:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKXwQVAgk3jgl/49xngaYBX6oKJbXhVjpUcSNtUjB7QKk0vvqdGgR/UdpT1mhsnTG/+3HOWQ==
X-Received: by 2002:a05:6214:492:b0:6e6:630c:71e8 with SMTP id 6a1803df08f44-6e886870f50mr77100256d6.7.1740602626235;
        Wed, 26 Feb 2025 12:43:46 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976608e7sm514216d6.51.2025.02.26.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:43:44 -0800 (PST)
Date: Wed, 26 Feb 2025 15:43:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, lokeshgidra@google.com, aarcange@redhat.com,
	21cnbao@gmail.com, v-songbaohua@oppo.com, david@redhat.com,
	willy@infradead.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, hughd@google.com, jannh@google.com,
	kaleshsingh@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] userfaultfd: fix PTE unmapping stack-allocated PTE
 copies
Message-ID: <Z798_nEvv6YVZntx@x1.local>
References: <20250226185510.2732648-1-surenb@google.com>
 <20250226185510.2732648-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226185510.2732648-3-surenb@google.com>

On Wed, Feb 26, 2025 at 10:55:09AM -0800, Suren Baghdasaryan wrote:
> Current implementation of move_pages_pte() copies source and destination
> PTEs in order to detect concurrent changes to PTEs involved in the move.
> However these copies are also used to unmap the PTEs, which will fail if
> CONFIG_HIGHPTE is enabled because the copies are allocated on the stack.
> Fix this by using the actual PTEs which were kmap()ed.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


