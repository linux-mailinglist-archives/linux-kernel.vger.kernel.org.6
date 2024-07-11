Return-Path: <linux-kernel+bounces-249993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B2692F2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41809B21C12
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D37D15B133;
	Thu, 11 Jul 2024 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hsMpeaue"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19814D2AC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741555; cv=none; b=tacDqjL4C+h1R7sGiiLA8jqmfgGvm77hg6GQB9kda7uH1pgBo1wlYcdawfpjnmzX2aYmjk3u4uxm47jFQJTnb/Y5ZgvNPNXQsjjkidg0AyPhE2JrklSswcbe0wMTSQfHDAT4YCGoItB9YdwrZr1EnP8OXrHonNKkPNd6DEqClpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741555; c=relaxed/simple;
	bh=ixwHm9s164H7lhleYumN5xZomvZGH6ly6DxBenbRgNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8FjTiB+LizB5FtWiqM2aE6RoqZzr9xv4hdBKc0RMR01jIcMSU6IvsgATnUecxhissetvg7nLPQFl9nJB84IMJUhYkT6FQHy4AdxFt9VO/1sXE6TLyd3bZQeJsgfnQjQ+HLVUrTYhrj2oqT9Q/7dQqiWciMNMXy2/jliumCrAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hsMpeaue; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44d1eb90522so6678851cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720741553; x=1721346353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CClLV1tB51ZaX86iB9FDhvujW8hrz0rku38BFiYHCho=;
        b=hsMpeaue6Ucf0sz9k2t2NuKhmx0FMbdAWlBz2a/rp6UFoLHI/oTo/avNZN6I6hNohU
         6n8mI+VWhO5uWpx+EKYlq6dR2w0ZP84rddsIBoXAwOMJfjS1RVYS7iMTz02OKq046RZO
         eHLBu1HaVEmRAE7RyJt87FMu9KxFfuOl7O+4F+/ySFOeETuzHJig5f8RLFCpmvxB2vp+
         5c0RKbr0kQYmdVEd9ImRaG4CPxdfQAJMezLis4IIYlMKQxy4yDScViQGDgho9z/B2JIj
         ZF61LQ+gFO5PmXgZm+ICetLz2r6THbhrAAKaGrPN5MW3gZ23g1a50mVxAr0pvqHMjq/1
         LxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741553; x=1721346353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CClLV1tB51ZaX86iB9FDhvujW8hrz0rku38BFiYHCho=;
        b=aAv08ilO+crpbC2RlikW/qC/4d3755UErxJKqorbpif4sG0W7/RmqrVvqDOsKcyd9n
         RqJe80R/1oXiY6JF5dRKe8yfrQSBf4tgAGA7/NQvuB5ugpONs3g1fWYhriEFmvxdvZKQ
         1W9DR6811FyAeJdRRB5e52hM6Kxbd/d77MjijLYN6EPWteumUgGGnBeW+/6B9g9e6Gqj
         GnO0ItonEcjTkXuGerMQyC2ge0VE4NSjh+bw6LHyFk4OoI/Cqk/iHVKGSUBeYh9Xl4IU
         /8knBewFayC8Ygg6uy8N50KoyHfzCseHRC+Z/7q3F625N1C0CpjBMr0D121bikfVjXJY
         cHTg==
X-Forwarded-Encrypted: i=1; AJvYcCXFDY56jOYXLlisqSdOEmxsy7AIHY60hKLo9I9P5SEqEaRM+ILe8fh/TkZ9oZdmrthShxfLDKhopSR5W2q60Qmvvwf0BxOQgE/JTq/6
X-Gm-Message-State: AOJu0YxjfSpVWxS+rUY/4tTYKzOo98ThFCf3Lad8ZtYMdTMTO3r/CJwg
	ea6pmLtFvhIQxYnwQedfdtpwO8DyAwPzp3Xmm56VVxEIkKk3deJCYZi6sd3ZKe8=
X-Google-Smtp-Source: AGHT+IGCxyT9qIVCEjXNFSJHXsvAlc0MYxLm+Aq0I+IiARoMTxGfb8kiptQiG1V3+Q00EN8jXeloBw==
X-Received: by 2002:ac8:5848:0:b0:447:e364:ab41 with SMTP id d75a77b69052e-447faa495d3mr115034431cf.59.1720741553352;
        Thu, 11 Jul 2024 16:45:53 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b2690csm35263031cf.1.2024.07.11.16.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:45:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS3Tz-00FUa5-38;
	Thu, 11 Jul 2024 20:45:51 -0300
Date: Thu, 11 Jul 2024 20:45:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommufd: Avoid PRI Response Failure
Message-ID: <20240711234551.GV14050@ziepe.ca>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710083341.44617-1-baolu.lu@linux.intel.com>

On Wed, Jul 10, 2024 at 04:33:38PM +0800, Lu Baolu wrote:
> This series is a follow-up for the discussion that happened here.
> 
> https://lore.kernel.org/linux-iommu/20240709173643.GI14050@ziepe.ca/
> 
> It prevents user space from responding to a group of page faults with a
> response code other than IOMMUFD_PAGE_RESP_SUCCESS and
> IOMMUFD_PAGE_RESP_INVALID, which will be treated by the device as
> Response Failure according to the PCI spec.
> 
> Please help review and comment.
> 
> Lu Baolu (3):
>   iommufd: Remove IOMMUFD_PAGE_RESP_FAILURE
>   iommufd: Add check on user response code
>   iommu: Convert response code from failure to invalid

Applied to iommufd for-next

Thanks,
Jason

