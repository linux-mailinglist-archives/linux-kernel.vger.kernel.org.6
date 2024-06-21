Return-Path: <linux-kernel+bounces-225356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D4912F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EB61C21D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388C481AC1;
	Fri, 21 Jun 2024 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzYVLeK7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5C17BB1F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005272; cv=none; b=dDsPe5PTHkBN1L2pttsNNYh1JJW7FmNviACcwnkr0oLvUoo4gaYU+QG/7Q2cWGb+vpqBLF0FAiQsRNlWVgW2TZZK0pZbNBI5Ee2rzOHmiIr18HhQuo+G2fxumennGfxUM7R6aTY20/FyS+91OXsmDIHdOBbEkFCUNOfIAPXPJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005272; c=relaxed/simple;
	bh=J7wlojSeCtPdDmzv9T+G0ny3JFaUBw4hVOlldS5Z0pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo6D4nQEp3BHpEmfDyghwuANQTEW6QQb9VDnDh/zz2k+805MljUycJNOcFsH2qyM5dgAOBGOppnQQr6PlIyGh+e9aKxwM7CT6O4Ui2M1YFFeGKEv64jwl/2SHUDCpSMN6X1UejE5ywjITbzmb8eU1quisOhpYLApvhglB5MxG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzYVLeK7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719005269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQ0xDPDL6YPvh4aLolM37qH0KjXqVwO7jVCuyxbPwL0=;
	b=MzYVLeK7LN5/vl8Ud+/RSGJH2pZYMxnpv97PbyTpvO5rRr27DXuRhAtKtDHkafVzhSBcRR
	LCaCDiexgY/d1RwjbpJlGyAAkHciNjOAkCnN9Ix6sYCuvI8enI1T1XGXKPNJcHnuETBie2
	Gt8/k+FmIV/1O5FbWujwzBJuAcvYUCM=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-I_LzVKt7NouDCb9w2YMbOA-1; Fri, 21 Jun 2024 17:27:47 -0400
X-MC-Unique: I_LzVKt7NouDCb9w2YMbOA-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4ecf41bb90fso29228e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005267; x=1719610067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ0xDPDL6YPvh4aLolM37qH0KjXqVwO7jVCuyxbPwL0=;
        b=CLLZmWZ+scaghjvovZlT4xHe7r9PiElMLlBMVkDvBREaJCmeocv7G+hAbCdKe5K0PP
         hqYh9yO+dBpI+z4HU8wVa2YZoFEUjbofYowyZ5QzITGmbHF0EXGe2ypQ09JNAqK55zGh
         J3k8z46xv4CqZ1B+yxlafWUq0dD3PSdWd6wDCeH9FApb5u14az358HBDxmLBwqkiMFNf
         AVdebJgZxd7gQZYFzC8S7QvH7wcVn3ezx7dtxVft+i83KpqfXA4NVHGEXkkc5le22iL7
         m3FYeAlPY1mdXTqXmEB6d/OH3AIFu9z90m02NLey1BTiQQKpi96fl/1HW3rxZBi8Iak/
         LtHw==
X-Forwarded-Encrypted: i=1; AJvYcCVB7NBDDzyBm+CnNelyswAZ0Ya8KmBsA8vd/LR9Xrald3TWCF85A1ZRXfXI5Zwb9vAidI4sOJgQXdvMz/rzKJ7gLf3ATc+h2VkmoXpD
X-Gm-Message-State: AOJu0YwHdE9fPXOt1gx3I9tA9Z71FI4R3EL8qfYBQPVuDtomCnXmko2/
	iw9mLP6IVe8BEIGQ4cAgiqtfjHsHHcfksZPt2qm7FjoN5hoMLHDly2Cto++RksCCNDCsQ+iyWIz
	pBT/s5Aoy2bugyEkpIueHTzpNKKt6Ud4gfYj67F9wT2lowu1FCWqvcX2okR8Syw==
X-Received: by 2002:a05:6102:38c8:b0:48c:40d5:42e3 with SMTP id ada2fe7eead31-48f1309dfb6mr10014213137.2.1719005266906;
        Fri, 21 Jun 2024 14:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzupZ6agYxyv1aCWC7ddqvrHfUJj/wIVHn0qwNGlrsJjIRvL0WGKAYxaQoaDL6E1YUniP5lA==
X-Received: by 2002:a05:6102:38c8:b0:48c:40d5:42e3 with SMTP id ada2fe7eead31-48f1309dfb6mr10014198137.2.1719005266409;
        Fri, 21 Jun 2024 14:27:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce89be42sm117046185a.10.2024.06.21.14.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:27:45 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:27:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <ZnXwT_vkyVbIJefN@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
 <20240621181224.3881179-3-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621181224.3881179-3-audra@redhat.com>

On Fri, Jun 21, 2024 at 02:12:24PM -0400, Audra Mitchell wrote:
> If CONFIG_PTE_MARKER_UFFD_WP is disabled, then testing with test_uffdio_up

Here you're talking about pte markers, then..

> enables calling uffdio_regsiter with the flag UFFDIO_REGISTER_MODE_WP. The
> kernel ensures in vma_can_userfault() that if CONFIG_PTE_MARKER_UFFD_WP
> is disabled, only allow the VM_UFFD_WP on anonymous vmas.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>
> ---
>  tools/testing/selftests/mm/uffd-stress.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index b9b6d858eab8..2601c9dfadd6 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
>  	test_uffdio_wp = test_uffdio_wp &&
>  		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
>  
> +	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_UNPOPULATED))
> +		test_uffdio_wp = false;

... here you're checking against wp_unpopulated.  I'm slightly confused.

Are you running this test over shmem/hugetlb when the WP feature isn't
supported?

I'm wondering whether you're looking for UFFD_FEATURE_WP_HUGETLBFS_SHMEM
instead.

Thanks,

> +
>  	close(uffd);
>  	uffd = -1;
>  }
> -- 
> 2.44.0
> 

-- 
Peter Xu


