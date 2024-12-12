Return-Path: <linux-kernel+bounces-442910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9143C9EE3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1072167B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98B12101AF;
	Thu, 12 Dec 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hkNhPD/c"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7831F949
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998366; cv=none; b=ZwEpH4RddoKG5LXQs0UPlMdIUQbhtwT2/pZotwQ25of8ARWsEiBFSwflAW1KyrvbBvK5KipjWZl3nbSUIc/GIktqf9EphnADS8StocJAXHNFwVJH1XHWVh7rhA+O0xJkco6iMv/ZCJY+N1+u60IG1sY2gMbiPCdavyIHhZQf9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998366; c=relaxed/simple;
	bh=6FMKZSv0DdjoMHaLeHBYlpCT1/M4a/wNX0bG0ju8St4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEk+JbtyfU5k29KOu0Re1w9HDU+LMJ/dQWCnpvRt9V+naG+WZT6ykn1OU7ilrE5YRBIJPmuzKAC7OKO/LHsWWVFZm0bQF4+rR2zemTWl5Woy9j/aihqSAS90nj4S9lShIgDo/EQ+GdUP++IVm3wWtEYtfDJDkr348ZdkmTxfXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hkNhPD/c; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43618283dedso3769805e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1733998362; x=1734603162; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6L/m3gKnrPsaMxDrU89bXCWhOH8qgzGCoqHbE1Yj18=;
        b=hkNhPD/cLT0vyTAbLHekCdBkv3wQrDpKlLBO+FGm4vaW0gzyAJVo8u/sRvK6f/8gvb
         DZX2pnz0gUiiamTbhRWa6S0jQS7Uy/UI0vVbL0+mBxWEmnyFB6pbOtGWgXl8mqSn2LQE
         7q+r8J5Ld4URV7NPV9FZNnLRE3MvbSDZRvnYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998362; x=1734603162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6L/m3gKnrPsaMxDrU89bXCWhOH8qgzGCoqHbE1Yj18=;
        b=ay49YEGbRxUiqKnVr+HnRrTBnJ2ZT7DAVTnyw8V8zvr73FOAbFMOcZIQQHDNqQOmV4
         40fwZY3Ke8ZJ04yYPEcfklvGd2Gh/D27jgZxk5PIMgcPkSuuOToWNAn9N/UIdI1jN8Od
         wj5aMMLt6ZHPhB9s9vaMaFXDQoP0wuDgN7+sXndQhIw+FK/FJs1F9ONm87KYWnKl238c
         CRFzD0qNyAxaEDdv59g0AffDdqvuzLO9kikeyg0HzBXr86EZzs6PVYLimsilt3iU9hst
         VJ/u9PcF6RpP27PhWgAQxUS18IzDhyzS7Hm8MutU2IpK12AwmRvC5pw/ZbGrzibZ7LEl
         WRIA==
X-Forwarded-Encrypted: i=1; AJvYcCXkUAAAZBJr0KrmR/pwwvVqSj/I1zIsftLZ1B5flEewCCl3aZ+IPJMHDfxecNay7ZD7fwO+GaYlolApqEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAr+7TpsEzQ3AO4NnqbiaPD0p87wZKlemdjD8ZdhfjOwgVo3gU
	aYZMUQe3FPwseNkTVbzUMwRvzmVWfCPtWpZcaC6muV6Umg/Y+bfYj5ITiS03tGg=
X-Gm-Gg: ASbGncuWlhrPT5q+FilMT4scUYrJVYBTUSzneUJoDmEVWOlgP81vt6LvzjMGR6X1tjD
	3MscbAFZ3naIOaaI99uk4xyhg8R7Ipyx8bYGaVIsGmKUAKDDn6qqTpXTOG26ZvD5G6M141Nn1cH
	sUvckDq1dd4Rr6lIVgg3Cw4QL/6zKXoHPOPdEJRtD/3J0NYj2yy1YXei+Z9clvAXCn4ls+kRpt6
	zXP8A/YpmlUpubUB2xy+Usu5QzAdAUYekHxUpe0zSeEJoOFqsEXrTpxCqN0gkbAAqPb
X-Google-Smtp-Source: AGHT+IEvyP9FitM66cSZMMwydxM3tJNlBph+iYVkomM+fbp/4XM+0mwafLdeLXGjgJiZl+wAHekCvA==
X-Received: by 2002:a05:600c:3b0e:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-4362282e38dmr25784385e9.14.1733998362260;
        Thu, 12 Dec 2024 02:12:42 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559f9b5sm12200215e9.26.2024.12.12.02.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:12:41 -0800 (PST)
Date: Thu, 12 Dec 2024 11:12:39 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Mika Kuoppala <mika.kuoppala@linux.intel.com>,
	intel-xe@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Maciej Patelczyk <maciej.patelczyk@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: Re: [PATCH 14/26] drm/xe/eudebug: implement userptr_vma access
Message-ID: <Z1q3F81k2TkUzKW7@phenom.ffwll.local>
Mail-Followup-To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Mika Kuoppala <mika.kuoppala@linux.intel.com>,
	intel-xe@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Maciej Patelczyk <maciej.patelczyk@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
References: <20241209133318.1806472-1-mika.kuoppala@linux.intel.com>
 <20241209133318.1806472-15-mika.kuoppala@linux.intel.com>
 <ec42fe8b-9be0-41cc-96f4-f1869c6bb7e6@amd.com>
 <Z1cNQTvGdAUPp4Y-@phenom.ffwll.local>
 <3c1cc9403eb50bc8c532d180f766eb7a429e8913.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c1cc9403eb50bc8c532d180f766eb7a429e8913.camel@linux.intel.com>
X-Operating-System: Linux phenom 6.11.6-amd64 

On Thu, Dec 12, 2024 at 09:49:24AM +0100, Thomas Hellström wrote:
> On Mon, 2024-12-09 at 16:31 +0100, Simona Vetter wrote:
> > On Mon, Dec 09, 2024 at 03:03:04PM +0100, Christian König wrote:
> > > Am 09.12.24 um 14:33 schrieb Mika Kuoppala:
> > > > From: Andrzej Hajda <andrzej.hajda@intel.com>
> > > > 
> > > > Debugger needs to read/write program's vmas including
> > > > userptr_vma.
> > > > Since hmm_range_fault is used to pin userptr vmas, it is possible
> > > > to map those vmas from debugger context.
> > > 
> > > Oh, this implementation is extremely questionable as well. Adding
> > > the LKML
> > > and the MM list as well.
> > > 
> > > First of all hmm_range_fault() does *not* pin anything!
> > > 
> > > In other words you don't have a page reference when the function
> > > returns,
> > > but rather just a sequence number you can check for modifications.
> > 
> > I think it's all there, holds the invalidation lock during the
> > critical
> > access/section, drops it when reacquiring pages, retries until it
> > works.
> > 
> > I think the issue is more that everyone hand-rolls userptr. Probably
> > time
> > we standardize that and put it into gpuvm as an optional part, with
> > consistent locking, naming (like not calling it _pin_pages when it's
> > unpinnged userptr), kerneldoc and all the nice things so that we
> > stop consistently getting confused by other driver's userptr code.
> > 
> > I think that was on the plan originally as an eventual step, I guess
> > time
> > to pump that up. Matt/Thomas, thoughts?
> 
> It looks like we have this planned and ongoing but there are some
> complications and thoughts.
> 
> 1) A drm_gpuvm implementation would be based on vma userptrs, and would
> be pretty straightforward based on xe's current implementation and, as
> you say, renaming.
> 
> 2) Current Intel work to land this on the drm level is based on
> drm_gpusvm (minus migration to VRAM). I'm not fully sure yet how this
> will integrate with drm_gpuvm.
> 
> 3) Christian mentioned a plan to have a common userptr implementation
> based off drm_exec. I figure that would be bo-based like the amdgpu
> implemeentation still is. Possibly i915 would be interested in this but
> I think any VM_BIND based driver would want to use drm_gpuvm /
> drm_gpusvm implementation, which is also typically O(1), since userptrs
> are considered vm-local.
> 
> Ideas / suggestions welcome

So just discussed this a bit with Joonas, and if we use access_remote_vm
for the userptr access instead of hand-rolling then we really only need
bare-bones data structure changes in gpuvm, and nothing more. So

- add the mm pointer to struct drm_gpuvm
- add a flag indicating that it's a userptr + userspace address to struct
  drm_gpuva
- since we already have userptr in drivers I guess there should be any
  need to adjust the actual drm_gpuvm code to cope with these

Then with this you can write the access helper using access_remote_vm
since that does the entire remote mm walking internally, and so there's
no need to also have all the mmu notifier and locking lifted to gpuvm. But
it does already give us some great places to put relevant kerneldocs (not
just for debugging architecture, but userptr stuff in general), which is
already a solid step forward.

Plus I think it'd would also be a solid first step that we need no matter
what for figuring out the questions/options you have above.

Thoughts?
-Sima

> 
> > -Sima
> > 
> > > 
> > > > v2: pin pages vs notifier, move to vm.c (Matthew)
> > > > v3: - iterate over system pages instead of DMA, fixes iommu
> > > > enabled
> > > >      - s/xe_uvma_access/xe_vm_uvma_access/ (Matt)
> > > > 
> > > > Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> > > > Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
> > > > Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> > > > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com> #v1
> > > > ---
> > > >   drivers/gpu/drm/xe/xe_eudebug.c |  3 ++-
> > > >   drivers/gpu/drm/xe/xe_vm.c      | 47
> > > > +++++++++++++++++++++++++++++++++
> > > >   drivers/gpu/drm/xe/xe_vm.h      |  3 +++
> > > >   3 files changed, 52 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_eudebug.c
> > > > b/drivers/gpu/drm/xe/xe_eudebug.c
> > > > index 9d87df75348b..e5949e4dcad8 100644
> > > > --- a/drivers/gpu/drm/xe/xe_eudebug.c
> > > > +++ b/drivers/gpu/drm/xe/xe_eudebug.c
> > > > @@ -3076,7 +3076,8 @@ static int xe_eudebug_vma_access(struct
> > > > xe_vma *vma, u64 offset_in_vma,
> > > >   		return ret;
> > > >   	}
> > > > -	return -EINVAL;
> > > > +	return xe_vm_userptr_access(to_userptr_vma(vma),
> > > > offset_in_vma,
> > > > +				    buf, bytes, write);
> > > >   }
> > > >   static int xe_eudebug_vm_access(struct xe_vm *vm, u64 offset,
> > > > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > > > b/drivers/gpu/drm/xe/xe_vm.c
> > > > index 0f17bc8b627b..224ff9e16941 100644
> > > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > > @@ -3414,3 +3414,50 @@ void xe_vm_snapshot_free(struct
> > > > xe_vm_snapshot *snap)
> > > >   	}
> > > >   	kvfree(snap);
> > > >   }
> > > > +
> > > > +int xe_vm_userptr_access(struct xe_userptr_vma *uvma, u64
> > > > offset,
> > > > +			 void *buf, u64 len, bool write)
> > > > +{
> > > > +	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
> > > > +	struct xe_userptr *up = &uvma->userptr;
> > > > +	struct xe_res_cursor cur = {};
> > > > +	int cur_len, ret = 0;
> > > > +
> > > > +	while (true) {
> > > > +		down_read(&vm->userptr.notifier_lock);
> > > > +		if (!xe_vma_userptr_check_repin(uvma))
> > > > +			break;
> > > > +
> > > > +		spin_lock(&vm->userptr.invalidated_lock);
> > > > +		list_del_init(&uvma->userptr.invalidate_link);
> > > > +		spin_unlock(&vm->userptr.invalidated_lock);
> > > > +
> > > > +		up_read(&vm->userptr.notifier_lock);
> > > > +		ret = xe_vma_userptr_pin_pages(uvma);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +
> > > > +	if (!up->sg) {
> > > > +		ret = -EINVAL;
> > > > +		goto out_unlock_notifier;
> > > > +	}
> > > > +
> > > > +	for (xe_res_first_sg_system(up->sg, offset, len, &cur);
> > > > cur.remaining;
> > > > +	     xe_res_next(&cur, cur_len)) {
> > > > +		void *ptr = kmap_local_page(sg_page(cur.sgl)) +
> > > > cur.start;
> > > 
> > > The interface basically creates a side channel to access userptrs
> > > in the way
> > > an userspace application would do without actually going through
> > > userspace.
> > > 
> > > That is generally not something a device driver should ever do as
> > > far as I
> > > can see.
> > > 
> > > > +
> > > > +		cur_len = min(cur.size, cur.remaining);
> > > > +		if (write)
> > > > +			memcpy(ptr, buf, cur_len);
> > > > +		else
> > > > +			memcpy(buf, ptr, cur_len);
> > > > +		kunmap_local(ptr);
> > > > +		buf += cur_len;
> > > > +	}
> > > > +	ret = len;
> > > > +
> > > > +out_unlock_notifier:
> > > > +	up_read(&vm->userptr.notifier_lock);
> > > 
> > > I just strongly hope that this will prevent the mapping from
> > > changing.
> > > 
> > > Regards,
> > > Christian.
> > > 
> > > > +	return ret;
> > > > +}
> > > > diff --git a/drivers/gpu/drm/xe/xe_vm.h
> > > > b/drivers/gpu/drm/xe/xe_vm.h
> > > > index 23adb7442881..372ad40ad67f 100644
> > > > --- a/drivers/gpu/drm/xe/xe_vm.h
> > > > +++ b/drivers/gpu/drm/xe/xe_vm.h
> > > > @@ -280,3 +280,6 @@ struct xe_vm_snapshot
> > > > *xe_vm_snapshot_capture(struct xe_vm *vm);
> > > >   void xe_vm_snapshot_capture_delayed(struct xe_vm_snapshot
> > > > *snap);
> > > >   void xe_vm_snapshot_print(struct xe_vm_snapshot *snap, struct
> > > > drm_printer *p);
> > > >   void xe_vm_snapshot_free(struct xe_vm_snapshot *snap);
> > > > +
> > > > +int xe_vm_userptr_access(struct xe_userptr_vma *uvma, u64
> > > > offset,
> > > > +			 void *buf, u64 len, bool write);
> > > 
> > 
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

