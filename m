Return-Path: <linux-kernel+bounces-174536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED518C1052
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95718B22A4A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53E15278F;
	Thu,  9 May 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2BxL17A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAA1272A8
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261162; cv=none; b=luUqnJ0NPfaqZF/bydARbnwUFGzXtmLjX5UyYv5Jwk1Sn4TeJq5YPopmOcy8ilQUG56ACGy7Ywr0tmx1G96eBTyJpobwcrA7KmCjew2vzx4Q0vu1U2ZuzFcHTO5eIJ687O8RxtMl17CRSb+u06c8s/J0uN1RtgKtpU93hMHeFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261162; c=relaxed/simple;
	bh=IwlJXIVeldRELa0/z+zt6CIvG1bWfjAC1EoduHYSA2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdqTkM9HwyJ4Oj+3/mxWGSAouz9c/AUwT/iUt9wH3sSEmU0cxXawJx6TOdFiQeysLuwk0/0Ycpmo8McfYlKPYA86mgRpruJy2jWxzRWXLc0WzYDxKOW1xU5TAZEkm5Fwg3hVXr8wqtqXE16sk18IdchtRaDmYhXb1/BMNkjHC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2BxL17A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715261159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYFPPJZKOGFD0i1KKljU7Qa1N+D0FkSOCXLk5sIs25c=;
	b=Q2BxL17A1AhN8F7xHkjZ/tN4q8/9IkiM56YJxIF2V1wMwDzfRlZvjrAwT0VxzlF5FwLSgs
	U/qOR386WiXBqvFkC6F5x8qX6UgWiaHcrdyGd08Dsc34xATKZEvgi98dTYXYRZpNu1iDDf
	Z52ruNxSlSGFuVto203SetJwW62D4QQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-69ZMY2bdMyKltkRNZvWMTA-1; Thu, 09 May 2024 09:25:58 -0400
X-MC-Unique: 69ZMY2bdMyKltkRNZvWMTA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5b22d772714so215450eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 06:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715261157; x=1715865957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYFPPJZKOGFD0i1KKljU7Qa1N+D0FkSOCXLk5sIs25c=;
        b=gcAk/FWXBCRxSm/8ROtGrnfdZbbtt8acZDjtIXjc2EiXYwu697fE4AbKgtHwUl9bN6
         Iem8W+D0mNh0V0L/zJGWzC3rSTxE3vR6BcgoiUQ0ckRQWzYoyZnXreEmQxStPDdwdoeV
         uIdJG0VPkKmHanEg2C5aihZp7izo8mIvXlmYZ4retd9S7mq3A/ZirTinS7iZbTnFvwwz
         2F7oM4eO+VzjAAj+uZW59NWzrdH5ZUEAx3ceBZRjrgMvaGZXHye+mFghGlyWy2awU/MP
         AW0A0tqRI53h5C4cNzoXpy1XLQsdqreZiyjm8b12x2fNQLuQ9ImFNBqRlC9UD5VfuNak
         zgGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPp38IQZWyoM2ymxlcv2b7vSVtvJy+BBHctEmWYyTWOKHJHr+OE5DWglTInKm3ODYotSx9KKngrowjgnL8Y0SIJwGFV+HTU7Jc7Xy5
X-Gm-Message-State: AOJu0YxymlFXgUIlHVM+A5C9IbYys/UMOCyBssxrd+i42IMI6ircR72t
	C3b5QiY24ETgb5U42Bgx4SoR4WYOLFJ6LHm+FAUjR6IHE6Ra5r2rnHWLkkw0l10DnbfFXI+8v4b
	ieDD/IlHMe1EE/vkt4k2N9X3dsH5jZHgJHpmfaNYp7UQIjecfKGxW4rNAjXsvBA==
X-Received: by 2002:a05:6359:4c21:b0:192:7817:5c4b with SMTP id e5c5f4694b2df-192d1b33924mr573402355d.0.1715261157104;
        Thu, 09 May 2024 06:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF13ZO4QpA0wRGmKo1XMZHPduAQ3ows7Wg2xn1APAWAT/ID2YOC4hG5DXTPcgbEhwi/3LeK8A==
X-Received: by 2002:a05:6359:4c21:b0:192:7817:5c4b with SMTP id e5c5f4694b2df-192d1b33924mr573398755d.0.1715261156412;
        Thu, 09 May 2024 06:25:56 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1872f8sm6962456d6.55.2024.05.09.06.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:25:56 -0700 (PDT)
Date: Thu, 9 May 2024 09:25:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH 0/2] Minor fixups for hugetlb fault path
Message-ID: <ZjzO4xH97Lu2UgEu@x1n>
References: <20240509100148.22384-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240509100148.22384-1-osalvador@suse.de>

On Thu, May 09, 2024 at 12:01:46PM +0200, Oscar Salvador wrote:
> Hi,
> 
> this series contains a couple of fixups for hugetlb_fault and hugetlb_wp
> respectively, where a VM_FAULT_SET_HINDEX call was missing.
> 
> I did not bother with a Fixes tag because the missing piece here is that
> we will not report to userspace the right extension of the faulty area
> by adjusting struct kernel_siginfo.si_addr_lsb, but I do not consider that
> to be a big issue because I assume that userspace already knows the size
> of the mapping anyway.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


