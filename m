Return-Path: <linux-kernel+bounces-521995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644ADA3C4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC433BB11D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473BB1F9410;
	Wed, 19 Feb 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="REMELqOK"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8EA1E8331
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981665; cv=none; b=Rf808MzVnyp/JnB06Ri1aT0w6BnCRIYHGpgedn4LHRETo4ZIfhXoiz5MqGaOiVW6qMq3gAcWAg1mqVDwhUi/urGqaMebr1NmQQWOWKRB0m9uBZr7nRoQbiUl6BT3+aI6wjeyNCovD+eJIZqrImLP5RFAt1BjtDgK0x+SK56D3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981665; c=relaxed/simple;
	bh=8zjFlNQlwV4+8TDhv5mKhNumLbCb5Hzx9gnY2KmtnRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5V5n4qHwRh+hHRrAfoLKBehRWwHZT+vCZO9h6Z5vm7mNTUtwlnImAroVIlrESd4N9OSlUsOkSCf2c0NNRANtenj2U7HiZE8pUyBtXxzFnjwFvKE94rIXBgZODEywFdSIZecD2mfoWTLWrXRuLrXqqs8yeli+FJR0ZFAUfKAOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=REMELqOK; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471f4909650so27801691cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739981662; x=1740586462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAEwvi0GBeXV5su+o42Sjw6+fX6vESKuWe1ByEzBoCM=;
        b=REMELqOKxjnd9SD7lEXN4lkKAjpSAWSJ+akcb9cLJaONLhA2vzhxRVfawzsSB2UmGg
         gsIF+FO6dw6okfS456/ARQfmmwPiGj19W9Lqya/AqKskHq9dAuQOTdfATPBBWJmqKpbF
         xwmdF/99zSy7xOqRpoiG5yGmx9mXLXaye6gSOvMd+xOQq0Ss073KGRDPq18bARToeS05
         8wyP7C7CkYi2a7BeMGAWWJmHAmKmwAnfB89fgGi7+MiWagSnTduxSwTgOojzoR+yOD6L
         CkI8ko+sJK5rNpOT8988NNpq2HdlmdwXGGUbN2ddPg+5W746l1Bsuoxus962RGTSj87i
         B5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981662; x=1740586462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAEwvi0GBeXV5su+o42Sjw6+fX6vESKuWe1ByEzBoCM=;
        b=ofdWlxAdhnasQFSPKcqSZoKHIgyxnMDOdOOOwJKfNfFPO168/KbFujYbMVqpXCl1r/
         FGOR+tL3UusjG/D5Buj89pIBzpCy6xxnM5PA8jf8jNfkvLsA6HmJWVtYhD79SjM0tx6h
         e7+WzX+vyoLtpWBynRhqlEb54JwKCZG/7YPkYZY4S5klkOHfeiUDi+nUYRZJ0Ulqz2Xc
         W85dDxwO1Sd6rBJ+j5VLiXhcgH9UmLLylq6GP+QO2pQujdDj85iFdAO20x1FMfaggxd+
         NDFl+d22A2S/AQjKJbo25XLs/B/lZT59KI/41NW0kxWyCe/wgh0i1gt7vYXuR/Ek2F2r
         zTtw==
X-Forwarded-Encrypted: i=1; AJvYcCUp5Z7zXljqFpcOCeCIn5ZmdMxDMnwSdyherQy1IkOtJQ9bVvgw9T2B8GLKfQKBSLzfKshHPX+gy7RCkn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy18tLcKhYAIY6xtKAHYiq6fpFThHm/h2kyu4qyyrR0he1dmU6J
	5aSGaQzOkAjhmkDLVo4pNF6LtaCeCqKrlCH+8NX06LPFPPYWkS4FzU9GTnxGxpQ=
X-Gm-Gg: ASbGncueTumAkFRBC+IJFSrWaQ4RjjUbAT4XyTftNVs1DF39i4TW8YV36tVypK1y2qp
	8ZLz+oZcr1P8si7xbDfbyYsZUByTgQ2t75yWnNPkFpIO1jfOX0B+CLulxH/wGdHx2UfrQfZl1ko
	ZxhCWqF2JK4OEd7g2r+L/KdL5i8l7Be62o1QtaMaM3FgvRBzMeHCjy1K0Fa+ETslktNTSDq0MOZ
	YEEntFh+FdZ6J5zuJ65FtECuuPvndkRrn5SN4jz5ISH4t2vjGYrsc2vtukuQkYmnjonwZrRSvBQ
	PtI2JelfoIBWXPkzE1CEhaYGpm4ibxSUaa9pYGTUdcZWrNDR0nICFWWBAkpDtBQ03eAwsY1W2g=
	=
X-Google-Smtp-Source: AGHT+IE6/v4wshXDrZEpD/MYfeRM134ORVrgYeRnyAz4JVMUV+BS4h0wbgOKih0/uNtmsb8QaJlVKw==
X-Received: by 2002:a05:622a:260e:b0:471:fc9e:8de2 with SMTP id d75a77b69052e-471fc9e9085mr118660761cf.8.1739981660311;
        Wed, 19 Feb 2025 08:14:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720624239csm14384451cf.11.2025.02.19.08.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:14:19 -0800 (PST)
Date: Wed, 19 Feb 2025 11:14:17 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7YDWbhOyhNGa7jL@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <Z7UvchoiRUg_cnhh@gourry-fedora-PF4VCD3F>
 <e332391c-30fb-49c3-9c05-574b0c486a81@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e332391c-30fb-49c3-9c05-574b0c486a81@redhat.com>

On Wed, Feb 19, 2025 at 09:53:07AM +0100, David Hildenbrand wrote:
... snip ...
> 
> Would the following make it better or worse?
> 

> The question is whether you want that memory to be hidden from MemTotal
> (carveout?) or treated just like allocated memory (allocation?).
> 
> If you treat the memmap as "just a memory allocation after early boot"
> and "memap_on_memory" telling you to allocate that memory from the
> hotplugged memory instead of the buddy, then "carveout"
> might be more of an internal implementation detail to achieve that memory
> allocation.
> 

Probably this is fine either way, but I'll poke at the patch you
provided and let you know.

> Right, it only currently works with ZONE_NORMAL, because 1 GiB pages are
> considered unmovable in practice (try reliably finding a 1 GiB area to
> migrate the memory to during memory unplug ... when these hugetlb things are
> unswappable etc.).
> 
> I documented it under https://www.kernel.org/doc/html/latest/admin-guide/mm/memory-hotplug.html
> 
> "Gigantic pages are unmovable, resulting in user space consuming a lot of unmovable memory."
>

Ah, I'm so used to seeing "1GiB Huge Pages" I missed that parts of the
kernel refer to them as "gigantic".  Completely missed this line in the
docs.  So a subtle choice being made by onlining memory into zone
movable is the exclusion of this memory region from being used for
gigantic pages (for now, assuming it never changes).

This is good to know.

> > I appreciate the clarifications here, sorry for the incorrect info and
> > the increasing confusing.
> 
> No worries. If you have ideas on what to improve in the memory hotplug
> docs, please let me know!
> 

I think that clears up most of my misconceptions.

The end-goal of this series is essentially 2-4 "basic choices" for
onlining CXL memory - the implicit decisions being made - while
identifying some ambiguity.  

For example: driver-setup into ZONE_MOVABLE w/o memmap_on_memory means
  1) ZONE_NORMAL page-struct use
  2) no gigantic page support
  3) limited kernel allocation support
  4) changeable configuration without reboot (in theory)
  5) Additioanl ras capabilities.

Thanks again for you patience and help as I work through this.
~Gregory

