Return-Path: <linux-kernel+bounces-242442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E640B928811
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F77E284AFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E7149E05;
	Fri,  5 Jul 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ggh9iOKu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0779F146A96
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179532; cv=none; b=sN/v5lt8B5JazS8VGTJS9n8vIJjE2skZx//AnY7VzU6Le81Rl+BBkZLyxz8qZPuuFAOzqlqVj0ZY0cJ3H4JmuhC4vn+aESVl5ilHNTWWzx48Ifp7tx2mBn+HjeqhKuo5Fkdwxj0PO7prj5i5IbE+5ycRzF4wd4TdbFgLHFX2ymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179532; c=relaxed/simple;
	bh=mn7addAJQs0gp7HX0JcwJyD9fAvmm2Ny5QC5TMeAF64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxVPJ9KwflPlsFw0fXEIRA8MlkbjUDynalzJLczRFlxs3v2w71NIrZDCfFFd7Pz2MZvyUVEWkIsJTapVziFDsPvr4ZehFN5IergA56fE/GNqa2F76GzNflV1Nmw0GULBKxj+vCUXwja/FoWc/f2r2go1O6s2I6lMFYlNRFBm7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ggh9iOKu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720179529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tn9UyKzgPQLuVlt0B5M6jL1excF5o/c38K9E/eMCPoM=;
	b=Ggh9iOKuen9nKyZVkhiyIu3QG2Js220H+Q6HsDmrqm72nRFsSqx3KeKoV6AfY+DFyqyPT3
	+JFxBdj973IB+/IcFnkzXsPtRerfwp887EuhH/SCwQ+uj1EOZ+pPa0EyJOOCaMJHRpyd0b
	i+y2ZUku1XdOqyEHoweng99TeAsANtQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-CNsUoh1ROCOYSlST3CUEvw-1; Fri, 05 Jul 2024 07:38:48 -0400
X-MC-Unique: CNsUoh1ROCOYSlST3CUEvw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57c6e28b151so1639373a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179527; x=1720784327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn9UyKzgPQLuVlt0B5M6jL1excF5o/c38K9E/eMCPoM=;
        b=IRIfvqRQwaPUPy8UqGO+AWqrQmwp4IwWCotb1VDtJwqRfr1+G+6Eun/XFo7LP00j/Q
         2JS0yaAgGWt1PkFA4l921G82H9MkJY/fpFtmG46zVZt/frpFZs3P9CIINoRKHU9HZWAW
         tB4HgAvP1X01yw+brjrsszKiX3ul+imYq6xKvT43T4OcfGznzxmC/dS+1FJC3trvskiT
         7yDEwUYllBspOIuDflunoDf0mFDmeEXs8CMWk60rWwgSANmTRgrRbVAk9xm30uokD16U
         kNKOCINA94dCbjI1ZRbU5iMPMJojRshLBiv0NnDMZG2G9pL13LSrxPiYBu6H6rwXeo+Z
         dI0w==
X-Gm-Message-State: AOJu0YzzTM9M7XNKuzgJ6MqXmI6fzLLDNKl+LOBYRkq54s09TFM9WxZF
	CNTxKw21TH0CkeZQlQY2xIXnufCmjvIzqLpq3i9SY0WhbjcUrNe3aF5X/yOfKbCi0kYC69qWy8y
	TfCMJ4vD3pAuzvungKvb5F38pfCK76rt09DwRiQHQkN3Kj4iHtXfCCKTvoOZ/ig==
X-Received: by 2002:a05:6402:1ed6:b0:57c:a478:2ff4 with SMTP id 4fb4d7f45d1cf-58e596546b9mr3537762a12.11.1720179527336;
        Fri, 05 Jul 2024 04:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV8b4iDkdw+rIkOOJf4RYIsgkz/yWSYO87bDc17gRChUM+7lTgpawXB4YefY2tP+QQOw2PaQ==
X-Received: by 2002:a05:6402:1ed6:b0:57c:a478:2ff4 with SMTP id 4fb4d7f45d1cf-58e596546b9mr3537740a12.11.1720179526629;
        Fri, 05 Jul 2024 04:38:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58dd6f1fb85sm2505902a12.77.2024.07.05.04.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:38:46 -0700 (PDT)
Date: Fri, 5 Jul 2024 07:38:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] virtio-balloon: make it spec compliant
Message-ID: <20240705073122-mutt-send-email-mst@kernel.org>
References: <cover.1720173841.git.mst@redhat.com>
 <dc0a5a70-d691-4d54-ae00-0beb74f4c399@redhat.com>
 <20240705061647-mutt-send-email-mst@kernel.org>
 <77ba077a-a7a0-49b0-b14a-954cb24901e6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ba077a-a7a0-49b0-b14a-954cb24901e6@redhat.com>

On Fri, Jul 05, 2024 at 01:00:50PM +0200, David Hildenbrand wrote:
> On 05.07.24 12:19, Michael S. Tsirkin wrote:
> > On Fri, Jul 05, 2024 at 12:15:30PM +0200, David Hildenbrand wrote:
> > > On 05.07.24 12:08, Michael S. Tsirkin wrote:
> > > > Currently, if VIRTIO_BALLOON_F_FREE_PAGE_HINT is off but
> > > > VIRTIO_BALLOON_F_REPORTING is on, then the reporting vq
> > > > gets number 3 while spec says it's number 4.
> > > > It happens to work because the qemu virtio pci driver
> > > > is *also* out of spec.
> > > 
> > > I have to ask the obvious: maybe the spec is wrong and we have to refine
> > > that?
> > 
> > Well having vq function shift depending on features is certainly
> > messy ...
> 
> Right, but that's how all of this started from the beginning.
> 
> > How do we know no one implemented the spec as written though?
> 
> I understand that concern, IIUC it would imply that:
> 
> a) In case of a hypervisor, we never ran with a Linux guest
> b) In case of a guest, we never ran under QEMU

Or maybe VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.



> It's certainly possible, although I would assume that most other
> implementation candidates (e.g., cloud-hypervisor) would have complained by
> now about Linux issues.

They either set VIRTIO_BALLOON_F_FREE_PAGE_HINT or followed linux bug to
work around.





> What's your experience: if someone would actually implement it according to
> the spec, would they watch out on the virtio mailing lists for changes (or
> even be able to vote) and would be able to comment that adjusting the spec
> to the real first implementation is wrong?

Unfortunately my experience is that it's not that likely :(


Whatever we do, we need to take existing setups into account.

How would we do it in the spec without breaking working setups?  I guess
we could say that both behaviours are legal.  That would still mean we
need the qemu and linux patches, right?

-- 
MST


