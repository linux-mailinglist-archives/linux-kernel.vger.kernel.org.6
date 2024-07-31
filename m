Return-Path: <linux-kernel+bounces-269419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC7C9432A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D464B27BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FAC17BD6;
	Wed, 31 Jul 2024 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8RkqHBs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D317552
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438287; cv=none; b=hX3q3nlYiGOcm2CP4j9H2eHrlJhxLMAHCRn6SmktOTd2CSL0kBjQvOHUU6KpYoJXoCMjeTDRBhXRFGFl/0RAxwwj2EEfWTRUXmp6bhZVL3n7fYe8BL+Ke8DtI8F3kXkk5okGRA8TmeK3PbQT1D/8Je3HYi4n9S3pW2IdYwdZs+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438287; c=relaxed/simple;
	bh=0xlivJ5NDPWrLl/YBt8mgBivQ2EKz8rE8uNuVmAVF5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdBnxDIjLwaaJ5SqfuB9hGQVJevUvuM++vcpd/hoyqHawDyfqiH7jR/Fn7PgeCTzjx3i4CgDMRI3sHPnTmCtWsnGmozM3oYUjXwkoVrxsTn9GD3uJ3Cf7lWaV7a5W9P/XsT46jwE1MRvK3ow+J+4tE/4JGgr9e5vUBN/uEVsr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8RkqHBs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722438284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vOJO9sg3TlSfmYNdHGnaBZGap5yNJluWPijE8vwrVqQ=;
	b=a8RkqHBs6HP/8KJI9Kj59jI+AtLu9pz8ueBTITl4JgSActinAO+I2cx/yWWVw/GssLBsN1
	CShoOPOqTfl4qXcGmSdGpjBk6R83sH3A+dtCQ+VsfrbsL3t9/TpLh5VbFkiYDqF+YjPdc1
	UJXse0t4X3YNDliDxcmk1EX1RmZcYJ4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-eK84Fi-HP2qMZFwedCHlQQ-1; Wed, 31 Jul 2024 11:04:40 -0400
X-MC-Unique: eK84Fi-HP2qMZFwedCHlQQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b7a47a271cso12918366d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438279; x=1723043079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOJO9sg3TlSfmYNdHGnaBZGap5yNJluWPijE8vwrVqQ=;
        b=qIXnqs075MnFCKE/ovJyDPikRKLwucrEMacC6sTWdrgnTcc5TQZYm4+KEQHJRcmM07
         Vx/UTDiwsaNQSSJvaoT63pPCVpz3gHXTa0IowROF34W7AB19ivUT9OsCOzA14UWrow0V
         TE93un0xNjClLua8eQckEuwsJpLGRphUqDOEy5NX1mthrf5nYE98SIBqcOXP3h5fpfXX
         7x+z0bH5z8Hddjy//TwAOUUhi2nToWCg4nfZW3TKOI2xjO4VG+Uu1n9NxKDpoicTlrpH
         zlNabsX3yT2Mtn1vn4JryS192UFUQtRTfsRcKc6oBfZm40YT9Bu+gOIO0N8aMM4bSCSY
         cn1Q==
X-Gm-Message-State: AOJu0Ywci4zirchtRcD7eBBCDR0kyRh2lbqyDgSSEQs5NcFI+nV11NM5
	9ERwRZL32jEt5cSRhACMDvlIDVOiaCmyQeeHu+MIYsvzQQkmNXI9MNm6ZvNQA/hEMehDtcLVq0Z
	+Yod5xZ1eGUg/WnGahBFA4SiYRnAVV6r5z9iksnRS8oskYnVj/n9YD1fXyGK/eA==
X-Received: by 2002:a05:6214:4109:b0:6b5:dd7d:919b with SMTP id 6a1803df08f44-6bb3e318443mr154258456d6.4.1722438279527;
        Wed, 31 Jul 2024 08:04:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgiHGBMWk5x1HYwpQHAjg8hvv0cWuE13O2hya7MRyHGFB9sikLbOJVfIKdC3NoLC8ye9DpiA==
X-Received: by 2002:a05:6214:4109:b0:6b5:dd7d:919b with SMTP id 6a1803df08f44-6bb3e318443mr154258076d6.4.1722438278827;
        Wed, 31 Jul 2024 08:04:38 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fab9974sm74268696d6.108.2024.07.31.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:04:38 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:04:35 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1] mm/hugetlb: remove hugetlb_follow_page_mask() leftover
Message-ID: <ZqpSg2c3r98rBvUH@x1n>
References: <20240731142000.625044-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731142000.625044-1-david@redhat.com>

On Wed, Jul 31, 2024 at 04:20:00PM +0200, David Hildenbrand wrote:
> We removed hugetlb_follow_page_mask() in commit 9cb28da54643 ("mm/gup:
> handle hugetlb in the generic follow_page_mask code") but forgot to
> cleanup some leftovers.
> 
> While at it, simplify the hugetlb comment, it's overly detailed and
> rather confusing. Stating that we may end up in there during coredumping
> is sufficient to explain the PF_DUMPCORE usage.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


