Return-Path: <linux-kernel+bounces-562099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 444D4A61C13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704204605E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCE7209F58;
	Fri, 14 Mar 2025 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvopIwaf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498C2054EB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982668; cv=none; b=k8S3G/FRtY1kmU+0X2J8XdUNrBbL1sORZSqxMl6od9tq548dCg9A/zRGwqg0qsgCLILShrBzcVz7U1cKj+mezqoUfza8Sr6bGpV/7uBntGxEI6+Am/ioDKuy6B6ynKAvowwJie2Z2CmlmHg25hsLPxzjKCqKJKqFhx2Da3QQ4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982668; c=relaxed/simple;
	bh=+H598cocfIacpoV/aS/IeuVnKEx5ukzRWbUj/A1EjyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR1DEtX8ukxhp5NU0bvuYz+8fAeaaOjyfM6UeqsA+3+LE+PIOq+4CXUfuxg4GaVBnkDrtmaqtE1zD0zKGrDcgNGQNmnOeyHj8mruRqinQG52pSSMnmKROwsIqYBy0qPK++kLZbGmUfepgv3X5pL+Ehvz+Uf+kMHIVKgEVGx8Yss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvopIwaf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741982665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqRyL6MA+QupMYvedIjsb0gClHlzTIPhGP8UWlhlKow=;
	b=fvopIwafNGPqrnhaXHXVl0x3YmPEuFEGdMQzM/q3OIOIQ2CYYtVPpZUAa4QSNIEdouNYfv
	ZNTif/1wILE+/TYa/TU0brLU3lhLgevWj5D2f4tpTi/KlZS9pVLITaHeymE6lTuEFYBfsm
	WbL101GbSkwkPTcDPYPKGEYdRfkcEuU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-SoATf9OQMlSreUXU3sXZBA-1; Fri, 14 Mar 2025 16:04:24 -0400
X-MC-Unique: SoATf9OQMlSreUXU3sXZBA-1
X-Mimecast-MFC-AGG-ID: SoATf9OQMlSreUXU3sXZBA_1741982664
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e916df0d5dso46731556d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741982664; x=1742587464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqRyL6MA+QupMYvedIjsb0gClHlzTIPhGP8UWlhlKow=;
        b=vBHaWE0s1C00HPV3wHnUqlLP/O1l4Nub9lMUh+buJQnRoe69WP3SqQxg7rbaF1jSuv
         fJ2bd96lNh6yQKg6Z3vpZRPbZBdoKpcfxpZCheNjkabYCEloaCJi95l242EvCKvx1gK0
         RtmGlOZ9HW05bh9x1ft8aBeN3gMudqi20rtGGc494xqHKSkeN5kgZ9OSYBhU9YSoU3qz
         HUFRBmMRDW0xxsN6GYSjD6SXJJxZSDNxoDvxoqikQsUtFTaA1pOKKbAvpKBQS+V6PRGv
         VWUm+DGDcMTs83eci2qJlZBNYNeJBDKIq6dQKjrIY0BLJ3UIhYY7zjvFxcr406VHSjzL
         uyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxNidqSWJYebKtvvTRgw2ATEu4E8uavLhR/4K1CD/wqfviqrS8y6FFu7YsE8y6JFzxChprV0FAK/7EjvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1g5TxCAuKB8ZlCNL15Uq+hSqFxWKe/7q3MAGemZAZuEzpNijb
	acPUKNMUC2cucIbcpCv1jQF9Y95k9yxP++/xiQTGiuhXOVxKPB94eNpo8dD1DEml6SZWi/oO+b6
	4X7CIRaL7IXmxF/oiILJdPVTdh+kfmGsvQlrJ6sSRarxsEe++SdntJss5vD88Eg==
X-Gm-Gg: ASbGnctMLUBPBdFxyQc6epSHpCMRROyqCUanlIZs4lWfD9yMjn2dHksadAfm5zEok5g
	zhTibtWV2ezSPyvwEs+DcU5IadKUgVsgxyQCRVll498+QZW1ubtuQuZuHSYRGeHFy4qO1RLAMZf
	iMFs5NvRy9Bui+zX8P8P0453rO5JOtr/hI/H8fsfNbZzt5oTyVJ1veuu8dU/XUjOUOwlryQtx/Q
	wVhjBfumV6irjbR6LsEnLnc9vEJH+WG+cw4O88QqeEofW4kDbJ5p1/HF31jYtALtazzSSBXSA2C
	dW/GI8g=
X-Received: by 2002:ad4:5cca:0:b0:6e8:f65a:67bd with SMTP id 6a1803df08f44-6eaeaa1c6e7mr54402516d6.11.1741982663659;
        Fri, 14 Mar 2025 13:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdrnxZkVhHJCu+0L4gTXfr+cGtUYoXrRv2lUDPgB5Dtd3VDIpsWxWp29AXtnPsgwf8cd2wQQ==
X-Received: by 2002:ad4:5cca:0:b0:6e8:f65a:67bd with SMTP id 6a1803df08f44-6eaeaa1c6e7mr54402066d6.11.1741982663335;
        Fri, 14 Mar 2025 13:04:23 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209335sm27689416d6.22.2025.03.14.13.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:04:21 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:04:17 -0400
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
Message-ID: <Z9SLwcWCMfmtwDZA@x1.local>
References: <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local>
 <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
 <Z9HhTjEWtM58Zfxf@x1.local>
 <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>
 <Z9MuC5NCFUpCZ9l8@x1.local>
 <507e6ad7-2e28-4199-948a-4001e0d6f421@amazon.com>
 <Z9NeTQsn4xwTtU06@x1.local>
 <24528be7-8f7a-4928-8bca-5869cf14eace@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24528be7-8f7a-4928-8bca-5869cf14eace@amazon.com>

On Fri, Mar 14, 2025 at 05:12:35PM +0000, Nikita Kalyazin wrote:
> Anyway, it looks like the solution we discussed allows to choose between
> memcpy-only and memcpy/write-combined userspace implementations.  I'm going
> to work on the next version of the series that would include MINOR trap and
> avoiding KVM dependency in mm via calling vm_ops->fault() in
> UFFDIO_CONTINUE.

I'll attach some more context, not directly relevant to this series, but
just FYI.

One thing I am not yet sure is whether ultimately we still need to register
userfaultfd with another fd using offset ranges.  The problem is whether
there will be userfaultfd trapping demand on the pure private CoCo use case
later.  The only thing I'm not sure is if all guest-memfd use cases allow
mmap().  If true, then maybe we can stick with the current UFFDIO_REGISTER
on VA ranges.

In all cases, I think you can proceed with whatever you plan to do to add
initial guest-memfd userfaultfd supports, as long as acceptable from KVM
list.

The other thing is, what you're looking for indeed looks very close to what
we may need.  We want to have purely shared guest-memfd working just like
vanilla memfd_create(), not only for 4K but for huge pages.  We also want
GUP working, so it can replace the old hugetlbfs use case.

I had a feeling that all the directions of guest-memfd recently happening
on the list will ultimately need huge pages.  It would be the same for you
maybe, but only that your use case does not allow any permanant mapping
that is visible to the kernel. Probably that's why GUP is forbidden but
kmap isn't in your write()s; please bare with me if I made things wrong, I
don't understand your use case well.

Just in case helpful, I have some PoC branches ready allowing 1G pages to
be mapped to userspace.

https://github.com/xzpeter/linux/commits/peter-gmem-v0.2/

The work is based on Ackerley's 1G series, which contains most of the folio
management part (but I fixed quite a few bugs in my tree; I believe
Ackerley should have them fixed in his to-be-posted too).  I also have a
QEMU branch ready that can boot with it (I didn't yet test more things).

https://github.com/xzpeter/qemu/commits/peter-gmem-v0.2/

For example, besides guest-memfd alone, we definitely also need guest-memfd
being trappable by userfaultfd, as what you are trying to do here, one way
or another.

Thanks,

-- 
Peter Xu


