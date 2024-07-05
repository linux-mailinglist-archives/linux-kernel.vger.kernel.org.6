Return-Path: <linux-kernel+bounces-242325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A1C9286B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CFD1C228C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29751148FFB;
	Fri,  5 Jul 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1UzUM9A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B55148FF7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174804; cv=none; b=GY0Nos2LzFy474XDKRXlg4cG2aj2cBtonOfMH+8qyRsi1huXaNCghz/PlaKSY/1oFiFZamTxqngm09CFXk42Ac+oMBP0GI2C1BmTLCMJi0yk6+DrNu1BVOD3JX8E2+BsegnU051ZUVOvMYSFDtWJROSCCZq9G8blA/bsjlwX0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174804; c=relaxed/simple;
	bh=b45DFkE5+vd/DemeRUN5mfWtE9cqLn0I9pyhQTYW0lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjnoHxwqdK+O1ShVNskGOGAbSoY6a8zQy3hPSgDvqSXM0tI4PGhzteeqPzzb044Ki2yenVCnmIGoRNB96n8nb4nQPfub05aFbZx0QqTEgLXDZ46iaW0iO2toOVY1vrLl6j9NLBlBJSbJy9ILqQibr86BSYl/dABuKFV5R4GnWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1UzUM9A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720174801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cUUyfZ878Q+zwZKs9EfIJW1aswoVqjfZuS0dHgKy6no=;
	b=H1UzUM9A0ZwDgNhlirxgGo871tOfP66ukF1tADSdszV1ktKEIpgRWyZaWMwNS8siK/Gtfe
	NRNP+Tk7/o1wImhoW5Bu/b5Q/F3GltDzHPR8x8vx1ti+VB9fV1c7Rf8DRWB/0qA6Y8wGuc
	Cjpg0j8HX7N73S1LkDWwCQIziwrL6tY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Ei6dsL-dPHqYrg_feQqJew-1; Fri, 05 Jul 2024 06:20:00 -0400
X-MC-Unique: Ei6dsL-dPHqYrg_feQqJew-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee8eaccb7aso15644811fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174799; x=1720779599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUUyfZ878Q+zwZKs9EfIJW1aswoVqjfZuS0dHgKy6no=;
        b=wbRk6xraMTxke3KH7Xu/TE+h2oh0vgUa0lb+r8ozAJeVZJDA11ZAlNqqa0ev+UlqUx
         ms/Q5eDRWy36nGavzWZh9nlMqJ/QTG1KXvzoOI+hac6RpR/CzWnLq4T/W493/wvrGLq9
         mk45zP5kp9PIpkNoX4DQ+ojL1iuG/QNcWWUSFA7lcG83Caro5yRJQ3f6Emk8Nx1WrplU
         hewU0k96xCOfwX2hAp6kgsVhxuRhgTkf46E2/hQ0lztngoWy5AJN7DLF1wC/d8xXsGB0
         e95dTuH9d3gLf4wdmDMDtyaCRRT1cL/fcDx0wGoInHnDblqxxsVmhgKSMSXWQQ6bIKp7
         7onA==
X-Gm-Message-State: AOJu0Yz+XvNVjL4fTtUXGqSKTQ0JnE/X3sQX0Y4fZ5zlKcJ/Wi0fOSHn
	AwMhJ7If6ZJpp8S3+fA/aoB/SCGqbHThCIsW3Albv8ULbL+g9Kzb12Dxh/69Ic36yQLNCIQsRKc
	1dZ9lLO3WzoxJ1nkVU5YfUiz9/dV8mdsENtTWs2lDXyCslxKdZ4sRRbVGK/pBPA==
X-Received: by 2002:ac2:5bc7:0:b0:52c:86de:cb61 with SMTP id 2adb3069b0e04-52ea061aef7mr3231149e87.10.1720174798974;
        Fri, 05 Jul 2024 03:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2bcAOPVaee27OeqMAnVWnDrzOGhrEimtweyv/X8xvSG7bS11fzhz03JD7Xz6uuBaWWr8tqg==
X-Received: by 2002:ac2:5bc7:0:b0:52c:86de:cb61 with SMTP id 2adb3069b0e04-52ea061aef7mr3231123e87.10.1720174798329;
        Fri, 05 Jul 2024 03:19:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a5a31a1asm1847953f8f.7.2024.07.05.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:19:57 -0700 (PDT)
Date: Fri, 5 Jul 2024 06:19:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] virtio-balloon: make it spec compliant
Message-ID: <20240705061647-mutt-send-email-mst@kernel.org>
References: <cover.1720173841.git.mst@redhat.com>
 <dc0a5a70-d691-4d54-ae00-0beb74f4c399@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0a5a70-d691-4d54-ae00-0beb74f4c399@redhat.com>

On Fri, Jul 05, 2024 at 12:15:30PM +0200, David Hildenbrand wrote:
> On 05.07.24 12:08, Michael S. Tsirkin wrote:
> > Currently, if VIRTIO_BALLOON_F_FREE_PAGE_HINT is off but
> > VIRTIO_BALLOON_F_REPORTING is on, then the reporting vq
> > gets number 3 while spec says it's number 4.
> > It happens to work because the qemu virtio pci driver
> > is *also* out of spec.
> 
> I have to ask the obvious: maybe the spec is wrong and we have to refine
> that?

Well having vq function shift depending on features is certainly
messy ...
How do we know no one implemented the spec as written though?

-- 
MST


