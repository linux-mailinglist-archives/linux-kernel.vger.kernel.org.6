Return-Path: <linux-kernel+bounces-541980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D5BA4C41F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B3A1896DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5D92135CB;
	Mon,  3 Mar 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L77gbFr/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6B84D13
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014133; cv=none; b=oKHiTxYvdpLwtrHVxMcty8MsawJrXfqw7X5A/KJ+F+Td+GTUJta8QuBrjf47JVHr7ZVOpY40cKDlc8VVx1wsR5mGg70ppru73m7VPnXgwhieUXcoqSCLav+oZ7mAX98RxGnQa5kXd+kGGxlibCbdzJbDSz4VHgwJ3QAEYIorVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014133; c=relaxed/simple;
	bh=FjP0E9sJ77PkBmH14fBWEU0Fc/TZES8qdigixTsakVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnzqyhJHnSlEUPSGyan1SCXbAwXeIYZaSkE1CGO1nLABIollzfUTkgobv1YGDQBKStvrwM7vP7rSfqdn07kA9NJSPgOGdfVHSWaKHP1QCuwbK9kcG68Cnt6OVcmW4zu3U9lv+E4g3Kgx42Mmds5nG7xgDASvGSCPhiMWkuP/tT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L77gbFr/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741014130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UzN9xGd4AYaVpFy7b8MSynryi29Xk8mITodEyd8B2C8=;
	b=L77gbFr/Je1r98QDoXCxb2jjHj5KU0sz1tt5xcV83R29q3LusYoCODwaEP6ad025PyUJXe
	Eo+AXVXolUhmNG3NyafNZ4bcvO4c9n89rs6/xezcLNHxIkBCGh1PxKQL/RGQ6JKdPBD1lb
	Pm0PoItZJejFviRtJM/rJs0zHlx3AcY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-w8w8sgSoPLyVnDBU5oEVNA-1; Mon, 03 Mar 2025 10:02:04 -0500
X-MC-Unique: w8w8sgSoPLyVnDBU5oEVNA-1
X-Mimecast-MFC-AGG-ID: w8w8sgSoPLyVnDBU5oEVNA_1741014123
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f2c7008c05so63552277b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014122; x=1741618922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzN9xGd4AYaVpFy7b8MSynryi29Xk8mITodEyd8B2C8=;
        b=YZ1prvF7uGDki/t4EMXKrD2cEaUEU7mhpfK1ZlWOj1aBGyGk8bxU+J+6g2rM4PYucE
         F8vndYGyiuqxYro+uEsBtWVJcKbeRkHwZJQ8ERCrwEcaqDChGRNk+JfzZX+b4iZMHufR
         SdcBt9GaeoG2vHLJCdtghnXCAbXPzz+iFgz7v5zAWqog8oOIiig6to6kZ1iHEhUqoggw
         OkchpAP0milhsq16qPtBYZVINsfnJdgZXYRI08U1vMFgqOcXHFsk0TlmDmwCV0Nsme9M
         4wb1i3v8ZMbHbp8/LBj2of5pfgH5PSo3WXgdaxTlytZuCaWrL0FzvQgE2YiOwPVGY+hK
         YNnw==
X-Forwarded-Encrypted: i=1; AJvYcCXnx/xNssP2H2N+JvZIH0oNirXQPzhKvjc+9Fx8jeJVZu40jqm5/zwaUUAK4lexT5ZlRPkMT/exxWMqw0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQlv1qlinGKZmvDSITGv4rpPrLZqyNDluR1vUMuh7fGqTzKF1
	PBvXjwgHgexH1y/zaSgoBt1duo4ooBsgq2dpt33jpfKDUEQ76u4GB83SpmiPmlt6SyNmHA5G9i3
	inOrn1WS8MYYVMDBJhCVHPZDNHNlCu+7NKZFrYO7EW30ijI6vQVuPFfM1l1zgaKa9osdZvg==
X-Gm-Gg: ASbGncsZ+aWX/c1Ul3ESHt+X2UkHSyUQJwlgysgv8DN4toO8U++KZmVREkUFritsKTz
	nl+HuieTtJ7qlLqvi50fuNJMN+BLkKVr/lphaMc4F5ShAm0LfWnJEZeralga6iaYP0vO9hzXPe+
	x+XnnbM7lDsUaywF57/dP+exr/Jl1pFuP8Nphvf3uPDGDpxG22qX2lfgXrid51bSJQabsVfYORI
	slKclltflQGNXSAuf1tp8n4CsM0s9bqtp9mTMf8dSWcuyg0VamB6mTlZA6ET5/wDcDBDteDlx3A
	DK9vZng=
X-Received: by 2002:a05:690c:4b12:b0:6fb:9450:b0c3 with SMTP id 00721157ae682-6fd4a02b0d8mr187857767b3.19.1741014122560;
        Mon, 03 Mar 2025 07:02:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG72IdQyN3LimMKL+mYIMq1dC012c40MIGCYQUmKF1f81r0mrUu3mk3SZh8e7XZzrnk5M4kfw==
X-Received: by 2002:a05:690c:4b12:b0:6fb:9450:b0c3 with SMTP id 00721157ae682-6fd4a02b0d8mr187857347b3.19.1741014122237;
        Mon, 03 Mar 2025 07:02:02 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3cb9f7besm20325617b3.107.2025.03.03.07.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:02:01 -0800 (PST)
Date: Mon, 3 Mar 2025 10:01:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Olivier Dion <odion@efficios.com>, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
Message-ID: <Z8XEZsZ2LZfqwfhu@x1.local>
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <cc1dec8c-8323-4c67-913f-5d8fb55ce715@efficios.com>
 <Z8HlL4FopVjeveaJ@x1.local>
 <60f148db-7586-4154-a909-d433bad39794@efficios.com>
 <Z8I5iU6y_nVmCZk6@x1.local>
 <e14516c2-bd7c-4bf1-b2af-314d23d8f59a@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e14516c2-bd7c-4bf1-b2af-314d23d8f59a@efficios.com>

On Sat, Mar 01, 2025 at 10:44:22AM -0500, Mathieu Desnoyers wrote:
> > > Also, I notice that do_wp_page() only calls handle_userfault
> > > VM_UFFD_WP when vm_fault flags does not have FAULT_FLAG_UNSHARE
> > > set.
> > 
> > AFAICT that's expected, unshare should only be set on reads, never writes.
> > So uffd-wp shouldn't trap any of those.
> 
> I'm confused by your comment. I thought unshare only applies to
> *write* faults. What am I missing ?

The major path so far to set unshare is here in GUP (ignoring two corner
cases used in either s390 and ksm):

	if (unshare) {
		fault_flags |= FAULT_FLAG_UNSHARE;
		/* FAULT_FLAG_WRITE and FAULT_FLAG_UNSHARE are incompatible */
		VM_BUG_ON(fault_flags & FAULT_FLAG_WRITE);
	}

See the VM_BUG_ON() - if it's write it'll crash already.

"unshare", in its earliest form of patch, used to be called COR
(Copy-On-Read), which might be more straightforward in this case.. so it's
the counterpart of COW but for read cases where a copy is required. The
patchset that introduced it has more information (e.g. a7f2266041).

Thanks,

-- 
Peter Xu


