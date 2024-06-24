Return-Path: <linux-kernel+bounces-227380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2358915034
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1981F23678
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30219AD80;
	Mon, 24 Jun 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0MuKjJB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324619AD45
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240130; cv=none; b=D8UD5yxLVYdeqXwdr8G/WroxQALUHIpOV64JVR8jdv5Hyc2mXpBePLUdJril0Y7deNKfpTq6ZB2flEdPtgzYDqIBFWknjRkxawltLViJZIRLtHU3vsy1ZzjMNQoLqhzM+W54A7lWQN+WYIJjyaxvpFimnNz/THN91rhRw6yZA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240130; c=relaxed/simple;
	bh=/fNP9lHtI2TK5RrwMbpkvfnkfdvJsuINBBNwCdflfCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2jJxiJ2ArkWTRBkjmh7PChA/B0lz6vDbgTZkK/9N3o1ZF7IHeWYrlmTEkxCdBUn/QJMYH0jx6kNErQy4cFsl0puk7GzXISOYRDLqBDgbU8e8BKAxjOsizfQcDg95AePZhD6CuqvK8ynUHfEyk8irMPIDvn2A1+CNiGJmMb2GXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0MuKjJB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719240126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YSFwvfLTs34coaqSsJLjio1esrhhUEBzaPezL3zICw=;
	b=G0MuKjJBn7tWo5mE1ECkgoOR70T7wD1hYHAdXQllXFNJ0kfpe/8XaYpg3O5FYAJ6QD84je
	rie5jjJsvW+upC0Kk81pRTAgu5YgGmsIRbTkSojFVIeX8X9HrORUQDalvkPz/a97fwYObM
	yRwTogLJqf1HalSIQeUpzW/lherd9qM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302--HTnCnsTM36tIPxse5xnSA-1; Mon, 24 Jun 2024 10:42:04 -0400
X-MC-Unique: -HTnCnsTM36tIPxse5xnSA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b52c538d04so7192106d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240124; x=1719844924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YSFwvfLTs34coaqSsJLjio1esrhhUEBzaPezL3zICw=;
        b=QvATsNhT14rvwSCJ/gtiZHPXWBY46dN9e6Y8ynETeXX7k5pVebQLUJvE8RFlMOUnof
         5NWhN/Md5F2KlhUoiKp/sTg8RdIEO9dcVIgXxF4qS9BJOD1p/S+WbwQtPJjnxvgWwjCw
         T6dcNYG0PZB97ghcJJAScU/QztG3efbqN+3ABGbxL+080oZ+QkOnnEKKHO9gNtNzq0Vf
         gEcaYp1CsuvsfD0pk2QyV6mQjqtF2DbG34fJ1LC7R0aFGS5wx4AxPSoYFwX2rsWDdDsI
         1AejWyBOX6+AnfUXBdq75bXyeAEZGDVM2j5ewJQfeOM9f+4B2ZyJALlysw/PJWmILaZR
         +OPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX//2OnJGUGA/OjRQ/+LkxzlQ4hTWmxcXvfTdtbTG1YrzmqGKua7oe2V6ZguGE9LWdfYlVUcRcAExeEsQ2erDgql1Wtqs/d0TkjcQLQ
X-Gm-Message-State: AOJu0YxpnMpMlLu+78nrsnBuUfCRbq0WxzMFbciHAn76SFsKTkkybLTq
	+6Tz9HGr9++xPESXtoDEqU/Z5IVrFvnvrx8WrNfCYpwyYPBmSX8YasVw5rrYizHvFidKPs1NeIf
	fdL3M3lUK0lCn6sM5lLMuKnK7lwtWF3AAztyM1FdL8Ralc5zAzpPy8iEGe7G7dA==
X-Received: by 2002:ac8:5753:0:b0:441:1de:8ab0 with SMTP id d75a77b69052e-444cf75fffbmr68513961cf.2.1719240124109;
        Mon, 24 Jun 2024 07:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGggCmyM4O7AbDKTFNzE+M2A0XkOn8q4QKOyaCtAAJssRP1VcmWE+zk9J/aPMuu0F6mZDXJWw==
X-Received: by 2002:ac8:5753:0:b0:441:1de:8ab0 with SMTP id d75a77b69052e-444cf75fffbmr68513631cf.2.1719240123513;
        Mon, 24 Jun 2024 07:42:03 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b3689csm42757861cf.20.2024.06.24.07.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:42:03 -0700 (PDT)
Date: Mon, 24 Jun 2024 10:42:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <ZnmFuAR7yNG_6zp6@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
 <20240621181224.3881179-3-audra@redhat.com>
 <ZnXwT_vkyVbIJefN@x1n>
 <Znl6dfM_qbH3hIvH@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Znl6dfM_qbH3hIvH@fedora>

On Mon, Jun 24, 2024 at 09:53:57AM -0400, Audra Mitchell wrote:
> On Fri, Jun 21, 2024 at 05:27:43PM -0400, Peter Xu wrote:
> > On Fri, Jun 21, 2024 at 02:12:24PM -0400, Audra Mitchell wrote:
> > > If CONFIG_PTE_MARKER_UFFD_WP is disabled, then testing with test_uffdio_up
> > 
> > Here you're talking about pte markers, then..
> > 
> > > enables calling uffdio_regsiter with the flag UFFDIO_REGISTER_MODE_WP. The
> > > kernel ensures in vma_can_userfault() that if CONFIG_PTE_MARKER_UFFD_WP
> > > is disabled, only allow the VM_UFFD_WP on anonymous vmas.
> > > 
> > > Signed-off-by: Audra Mitchell <audra@redhat.com>
> > > ---
> > >  tools/testing/selftests/mm/uffd-stress.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> > > index b9b6d858eab8..2601c9dfadd6 100644
> > > --- a/tools/testing/selftests/mm/uffd-stress.c
> > > +++ b/tools/testing/selftests/mm/uffd-stress.c
> > > @@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
> > >  	test_uffdio_wp = test_uffdio_wp &&
> > >  		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
> > >  
> > > +	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_UNPOPULATED))
> > > +		test_uffdio_wp = false;
> > 
> > ... here you're checking against wp_unpopulated.  I'm slightly confused.
> > 
> > Are you running this test over shmem/hugetlb when the WP feature isn't
> > supported?
> >
> > I'm wondering whether you're looking for UFFD_FEATURE_WP_HUGETLBFS_SHMEM
> > instead.
> 
> I can confirm, its all really confusing... So in userfaultfd_api, we disable
> three features if CONFIG_PTE_MARKER_UFFD_WP is not enabled- including 
> UFFD_FEATURE_WP_UNPOPULATED:
> 
> #ifndef CONFIG_PTE_MARKER_UFFD_WP
>         uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
>         uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
>         uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
> #endif
> 
> If you run the userfaultfd selftests with the run_vmtests script we get
> several failures stemming from trying to call uffdio_regsiter with the flag 
> UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault() 
> that if CONFIG_PTE_MARKER_UFFD_WP is disabled, only allow the VM_UFFD_WP -
> which is set when you pass the UFFDIO_REGISTER_MODE_WP flag - on 
> anonymous vmas.
> 
> In parse_test_type_arg() I added the features check against 
> UFFD_FEATURE_WP_UNPOPULATED as it seemed the most well know feature/flag. I'm 
> more than happy to take any suggestions and adapt them if you have any! 

There're documents for these features in the headers:

	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
	 * write-protection mode is supported on both shmem and hugetlbfs.
	 *
	 * UFFD_FEATURE_WP_UNPOPULATED indicates that userfaultfd
	 * write-protection mode will always apply to unpopulated pages
	 * (i.e. empty ptes).  This will be the default behavior for shmem
	 * & hugetlbfs, so this flag only affects anonymous memory behavior
	 * when userfault write-protection mode is registered.

While in this context ("test_type != TEST_ANON") IIUC the accurate feature
to check is UFFD_FEATURE_WP_HUGETLBFS_SHMEM.

In most kernels they should behave the same indeed, but note that since
UNPOPULATED was introduced later than shmem/hugetlb support, it means on
some kernel the result of checking these two features will be different.

Thanks,

-- 
Peter Xu


