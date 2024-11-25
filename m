Return-Path: <linux-kernel+bounces-421452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5075A9D8B84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75AF166762
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AFA160884;
	Mon, 25 Nov 2024 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCRQkU2N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301E1B4F15
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556691; cv=none; b=MrsqES9nhbfvxow5cZbeh4rthXUh2qnO+bAMBdhKQxu8aUouVOgCE2drNMbo73J+Qal7ZQlX5sT4MvbDV6rJ/rK4qGw7mu1npnDUdtu4qPax8+kMarN6D73uMk8wuIkSgK2x7v8DWCJs0QDBneMkilS99XEnjvR4xM4rvEAkGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556691; c=relaxed/simple;
	bh=s6DieJ3M/QSwKkbpxTMLxOi4pCNogAPC97GRf/Ui53Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWP5gy/91dUr3wz6i/xM5RDQYb2NoxrpSRora/J+dwIGhJ8wSeCe4BLNOt1RdiyNUjT134ryq+97vp3xhA9PLGFv7aznfZNNs9cxFji2n5tIDEka0rBJYYs+CfV4YvvR1YcNkK1QHpIYXN/99UreZuYjWJsXId0IZuwAP69ZwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCRQkU2N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732556688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNroIug4JJT33LY+P3Ic7ali3bMKIIvjS1+5Z6B9o8A=;
	b=HCRQkU2N3H5UGXkfnJCKy6HCZdMwBToWPDONzWUXXAyMDAMjgbYOfv1qdq7p9h6Gx5KCap
	fCd0PnRzXryAeFUikawsIAin6Rag5MxJhYFwi9REmKQHfCSLK8CtT3F41pVyTRUANWAvw6
	iDEiz4UM+96yKWRktu4FPLTWoj6JTAc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-1lEpn1dCNsS9RMK6J-83uA-1; Mon, 25 Nov 2024 12:44:46 -0500
X-MC-Unique: 1lEpn1dCNsS9RMK6J-83uA-1
X-Mimecast-MFC-AGG-ID: 1lEpn1dCNsS9RMK6J-83uA
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-71d4ed0d599so1064581a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732556686; x=1733161486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNroIug4JJT33LY+P3Ic7ali3bMKIIvjS1+5Z6B9o8A=;
        b=Q2D/WUqZMtAqEBGszg3Owuul2e/AMfTNJ+uIvdoUUI0Rz/caA7m1NPJgvrJwPzbvs9
         2wjCAFO4wf+DJqZcArDoiqf/fLugCT2rQXp5a/b4bxacryvIGJTRVrcdWZiuos+WVJ4n
         rNefy9B2BhJg4UTEHBr91Wq4dh5pwwD0w17TAfVjqVgIZu+be2AyxolnHLkCZ+j6diQH
         /qUYDw9At9PvTFEymmDsGmx5ys6A8lYEZ8cqPv50dzOgtMKNmePUOaSrLC7Ox0ihRsN4
         Fb8o7+lbL/kRGjwN0ThGItDoazeFgE0v7t7rf/y4hNEVAD6IDfxbgiT8h0LnasOKIjqg
         /V1Q==
X-Gm-Message-State: AOJu0YzHn11LueTFYnHy158jp+f0E0RYLzUz8VOuG/MzvIIgAqzfJ/FA
	Kji9pnsS/ZWBtxbNryXTEGFnEucqkuQAoCswKq7btrYE3SY7oNtiBQ/tgKEMLkV+pMLY4GVHPzW
	X6+5FyG+E4zikbZj0AhxmWpHRnE6I5ENPxABX/rs4OP6mp0iYfIk9QbOw596kyn9SNLremg==
X-Gm-Gg: ASbGncsVKMhXEoGyz515RvEUrVAmBQDpxAXbzbgruiTpateWwoqEOqCuXBXBCwl7YUY
	IaRX+j+Gdk+lqPdcTKFruTNjCrKB6ZMrA5pBwE5Y9dRvL3U6vHfdV2Jiu2R1LgqoPlUpibOWniY
	0JTG+7Q4TJi/6RPb5uo5Hgw1GNTsYKKtd2LFeQyENFOOPlsjIVazwNNjd9CsjjLiPAXMidBYL8V
	P3Yh/3KpnyTMUcSvIawjXi5AK2KXg0Q86Z8LW7cTc4rjbLVtcRTqDtHOJEcjvskbUfg0fcGyd1n
	iXX5j8yp+/8=
X-Received: by 2002:a05:6830:6202:b0:717:fdbb:146d with SMTP id 46e09a7af769-71c04b72221mr14182337a34.2.1732556685947;
        Mon, 25 Nov 2024 09:44:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0MAf6sWWKow7pt65Ce/fhZZ3tYRn7eJAqWgJJyrvftQg6HC3to/2Lqzq77+RS1r6Wvc1tCg==
X-Received: by 2002:a05:6830:6202:b0:717:fdbb:146d with SMTP id 46e09a7af769-71c04b72221mr14182310a34.2.1732556685701;
        Mon, 25 Nov 2024 09:44:45 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe1a022sm2184532173.1.2024.11.25.09.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 09:44:45 -0800 (PST)
Date: Mon, 25 Nov 2024 12:44:42 -0500
From: Peter Xu <peterx@redhat.com>
To: stsp <stsp2@yandex.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Message-ID: <Z0S3isgc-QlEF7oW@x1n>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
 <Z0Se4BuVfqwjeCWV@x1n>
 <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
 <Z0Ssq15MQd3rimBr@x1n>
 <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>
 <Z0SwOILi4R4g9JBa@x1n>
 <9b68a811-ffed-4595-83a6-0ef78a7de806@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b68a811-ffed-4595-83a6-0ef78a7de806@yandex.ru>

On Mon, Nov 25, 2024 at 08:32:54PM +0300, stsp wrote:
> 25.11.2024 20:13, Peter Xu пишет:
> > Old kernels will fail with -EINVAL, new will succeed.  It's already an ABI
> > violation, IMHO.
> > 
> > Not to mention I'm not sure what could happen if uffd feature flags can
> > change on the fly.  Your proposal means it can happen when anon missing
> > trap is enabled at least.  That's probably unwanted, and unnecessary
> > complexity to maintain to the kernel.
> OK, thanks for considering.
> 
> By the way, as we are at it, I have
> this usage question. I initially intended
> to use UFFD_FEATURE_WP_ASYNC, but
> it appears (and is documented so) to not
> deliver any notification.
> Why not?
> I am currently using UFFD_FEATURE_PAGEFAULT_FLAG_WP,
> but I only want to monitor the fact that
> the page was written to. With
> UFFD_FEATURE_WP_ASYNC it would be
> much faster, as the kernel resolves the
> fault for me. Yes, I've seen the mentioning
> of /proc/pages in docs (I don't even have
> /proc/pages - perhaps it was ment to be
> /proc/<pid>/pages?), but why such a
> complexity if all I need is the notification
> similar to what I get from
> UFFD_FEATURE_PAGEFAULT_FLAG_WP?

Apps who tracks snapshots needs the unmodified pages before being written.
Those cannot rely on kernel resolution because it needs more than "if the
page is written" - it also needs the page data before being written.

-- 
Peter Xu


