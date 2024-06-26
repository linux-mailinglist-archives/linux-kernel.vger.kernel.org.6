Return-Path: <linux-kernel+bounces-230889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18791835F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F651C21556
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585CF185083;
	Wed, 26 Jun 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4U3NGVv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2862D172BC6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410010; cv=none; b=TQhqU4PtuCh/vdhpBcEQzK4vethAJj1fmO1JWsl3u0hONDVojL9HZc7rmJeCsnRFZdxRCVm7w2qjhJwtjQFM6fEyVSrhwp6pegY1cCXtxMaZHVkruoJ14wRoLuq3ZJR1D+JnwvYXEUDO/wKpQuLvB8vkYVySg0eWu+yzwM1D1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410010; c=relaxed/simple;
	bh=A2o+l3NuRNw2a+iRKsLea/VZp78l6U646vGfevTxLB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ8BaA0DNojBAldViAv2xm3LltL5kXPuC8bMLgIenkTUVHzZr8K/8RVHcyr4tvyv0i6kcAqmHWRQSXiU6WD9wAr0Aped9y4N0I+fOXDmOHZn+qY/JdLI7zA9VVN49o+hhiTKsB0xc4U9By4kr+zv4y1gs8MweT/+dKmAMysbcGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4U3NGVv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719410007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L/CySx21VlY9lkKLs/UvRv4ham7l6zFWPjNK0vJEd8=;
	b=G4U3NGVvhW6/ThD4blwT6mVmWPNzZSryL4PDJe1GnTiIMMBiCBjjO3rY/pfZ7scipKhdsI
	b9+FXX+nc8B+w/kEZWQg68GYiEEN13mit36JFuPUxrg+KfvgJEEvijzx2zkb16zshOnVnK
	GDp9iNqThQ/fRg7W42ZqZ7jr+5+2JG0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-bbrXu_0TO12yYjb2ucaY1w-1; Wed, 26 Jun 2024 09:53:25 -0400
X-MC-Unique: bbrXu_0TO12yYjb2ucaY1w-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43e2c5354f9so14968621cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719410005; x=1720014805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6L/CySx21VlY9lkKLs/UvRv4ham7l6zFWPjNK0vJEd8=;
        b=s9rzxVFRPpHqoa9tEMAR2HWnrqTDdgaOtbYmX9KG62BOzpFh9WNJAk/2BJHWwxhGYG
         RZJlKFh/r3BvaYAtrsW7P2OQ5q5HEx2XeirTd6lu+YMudlAxPDJ0TCDNEhhTyJ+2tr3N
         zKGM7kScve2kyjw2Y+43SDqr8rTUTS2z2fb0VTBaWJA5RLAA7y6OphGhwiLoVg7EtS6U
         xOFo1BC0XEKCV0iZo0IJZGw4dO7VzBvw6J2ApToL8sC3Qe3LLjTFMfxjb3S4CNGtwH7t
         GkyPX1UwHWURNXuONGZc87t6jbxGe1VQJYNu/sEgnq5+2P6ftsHtHKdg8ja5i8HfeZju
         WN9g==
X-Forwarded-Encrypted: i=1; AJvYcCU/Q6ujc9z/U5x31bBWAKT0BdGLem6gweqZg7iBXPzBJVYdiMafhXRwSWOBWbOjf87J/DBGw1oMRgnLIaU7+niv9/nPCyUZ4/D1lxI+
X-Gm-Message-State: AOJu0Ywd2hsXJg1zw8D+QJoSbROZXiX3Whi0Fja00AC94CSHofW8nu0z
	9V+8fItjwOZs0Tw82yF4NAw9Ead5qIBG52SNENhrn9LsVH7ehrAPsO+/B0OwsaC48xKFPeu0qOS
	jgjRQwey/BC/5uEYeTaRCVjKhQ5LzvggVKcj7tLnl+uF9zev3jLFSfKILF+sP+Q==
X-Received: by 2002:a05:620a:29c5:b0:79d:53d0:95af with SMTP id af79cd13be357-79d53d098f6mr146858685a.2.1719410004597;
        Wed, 26 Jun 2024 06:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfg5gp8Vxw/erpGLqvLxIwWQrtznQgrqGbKZUsqsdxrw8Gui1u4uAwFXpio7u+OhtBKCeLlg==
X-Received: by 2002:a05:620a:29c5:b0:79d:53d0:95af with SMTP id af79cd13be357-79d53d098f6mr146856185a.2.1719410003910;
        Wed, 26 Jun 2024 06:53:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79c082c7433sm137223985a.53.2024.06.26.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:53:23 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:53:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <ZnwdUJmo7-7tjcB3@x1n>
References: <20240626130513.120193-1-audra@redhat.com>
 <20240626130513.120193-3-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626130513.120193-3-audra@redhat.com>

On Wed, Jun 26, 2024 at 09:05:13AM -0400, Audra Mitchell wrote:
> If CONFIG_PTE_MARKER_UFFD_WP is disabled, then we turn off three features
> in userfaultfd_api (UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
> UFFD_FEATURE_WP_UNPOPULATED, and UFFD_FEATURE_WP_ASYNC). Currently this
> test always will call uffdio_regsiter with the flag
> UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault
> that if the feature UFFD_FEATURE_WP_HUGETLBFS_SHMEM is disabled, only
> allow the VM_UFFD_WP on anonymous vmas, meaning our call to
> uffdio_regsiter will fail. We still want to be able to run the test even
> if we have CONFIG_PTE_MARKER_UFFD_WP disabled, so check to see if the
> feature UFFD_FEATURE_WP_HUGETLBFS_SHMEM has been turned off in the test
> and if so, disable us from calling uffdio_regsiter with the flag
> UFFDIO_REGISTER_MODE_WP.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  tools/testing/selftests/mm/uffd-stress.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index b9b6d858eab8..3266ae885f75 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
>  	test_uffdio_wp = test_uffdio_wp &&
>  		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
>  
> +	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
> +		test_uffdio_wp = false;
> +
>  	close(uffd);
>  	uffd = -1;
>  }
> -- 
> 2.44.0
> 

-- 
Peter Xu


