Return-Path: <linux-kernel+bounces-439468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6405C9EAFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66DD16AC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB9D1E515;
	Tue, 10 Dec 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DSOTLoWb"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077523DE95
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829448; cv=none; b=mDT4EzNVQI3Q2a7PaCQUoFzXUQ0uGLNBCJEJUUiXq46DS/c8jGjaETd5bqAC+8ob4GKrX/tlmuIYWvxF8D6cMwdLckOgCpXkkXNgNaHV+G0MOtoPy1qy5PcWQjXlKR2FB53DBRv08769ebhpLVIDY3Yp8/u/nxNwfxTqvECqFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829448; c=relaxed/simple;
	bh=3IaavqenstEFlp7aEeDiBvK7w+yVdZgac92bDfgacsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp31f9SdRisyW3oAQZ07sslvYcws7prFuCnyuv5XnkiAUHHnbIG49L7gh9b82O0CMCnGwLG+PCX1FOO58RpFmWQiIhfp0ycv9aIAnrXhMbxCSheuPNm0vVJwe9zsmnHQhkOY/fWZ8hVC3cWEOEOXaf0poFccunVBsciTN+rmwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=DSOTLoWb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434e406a547so21609755e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1733829445; x=1734434245; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDojbZ2VONgpjznrfPM339c4Ui/XuZ8qmsW07fn2uQY=;
        b=DSOTLoWbZ+uiPphn5ZXRlSE5EC2ByARAmFdlmujSQCvKJPqGlmlOkUsOji21/shjHq
         gJsQzJMfYmiqerTFZtHT2NExVajfjn48Y1LOqDWa055kLkdQ4/ixRH+sXN9i5vpXyAoK
         nP+UfsuBRuO8/PDtYXerr5WQtX8puQX6aRTls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829445; x=1734434245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDojbZ2VONgpjznrfPM339c4Ui/XuZ8qmsW07fn2uQY=;
        b=m3zXc+PNEtzgGopCc5i0ZIn5aSOx1R6GbZCYFngc+LjMYbTaLvqAscws6T2i2uxrrN
         n5tYOsDHqz5niI0EHXoc3sP7pZnFlD/WzU0zTDQy9l4gbOl77rAf1yTgPTDGYCU9JbEB
         pDcGOGSMaN40bvnDNHI8uvl8FCO37RmdA7g+puea6IavKYog+rGclyOpkVLL0E+mHr2G
         gfe8hZd3g53BBfkk+lOXpJL0cfV2CFHcDToVRCWK8lb7wrYRCNEmyHWKDpnfSDGPlWyc
         Smye5pGET/t9Ljhr1bJjLaeKCS+in1zELkP078W4o+Qmpyl9fxKq1U6qw8ikkbAFo3MB
         eg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBpfu35h4utjqAC5v1yFJYStgyqNeVDx3dYPRr97aFW2rGz22G+GNaiUlR/JSaGrt5igmiLkkxmyzWlHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2EIW8jdbv2LsD7dQbtiATb4s4U9uDIcPMw1w1Rux2Xkm+xGps
	ZbmMhtXMuvc4U2Os81wZkcCw2QlGytrOXrNZxyJOTKAGZ6ADClUWw3lkO3ZEUPOeOl//GXM5kzx
	5lx0=
X-Gm-Gg: ASbGncsM7UweVpSggV1wU97v4bxetzqKfLXYcagVnFtvmXXRFOq00ozhBYVpLEuCubg
	pVIOHnqDBrjhNiCuJWSBNfNw1or7Y4v1NsT3BTIuQfhXMYRcy6a1vlGgGFYkozU7T31k6U0MEwb
	7QywaPF8sPnBvanzeuQKUOXG8ok5/KoHbIuZXUH3JNpRsIv/sbXO76iPS3dbZSrRQsSs51gosne
	sbPhcGN+RQX5jfX5QMHLvwYRqrt4QguGuiLXeC6Y13CPAcjaUy5ocHxrNcmHrL7lA==
X-Google-Smtp-Source: AGHT+IG0c0/kJCByoAXTvAWZSCghtb2kRyPv2cAHMRWAM/x2Lb1XI1VpZSJ/qQlmCYfTOguR1LwFBA==
X-Received: by 2002:a05:600c:458b:b0:434:f739:7ce3 with SMTP id 5b1f17b1804b1-434fff41b59mr33461855e9.8.1733829443037;
        Tue, 10 Dec 2024 03:17:23 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm227349055e9.44.2024.12.10.03.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 03:17:22 -0800 (PST)
Date: Tue, 10 Dec 2024 12:17:20 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>,
	intel-xe@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Maciej Patelczyk <maciej.patelczyk@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: Re: [PATCH 14/26] drm/xe/eudebug: implement userptr_vma access
Message-ID: <Z1gjQOvr847-zuwM@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
 <e4401ab1-0562-407a-a0e9-2f6e43e5ac22@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4401ab1-0562-407a-a0e9-2f6e43e5ac22@amd.com>
X-Operating-System: Linux phenom 6.11.6-amd64 

On Mon, Dec 09, 2024 at 04:42:32PM +0100, Christian König wrote:
> Am 09.12.24 um 16:31 schrieb Simona Vetter:
> > On Mon, Dec 09, 2024 at 03:03:04PM +0100, Christian König wrote:
> > > Am 09.12.24 um 14:33 schrieb Mika Kuoppala:
> > > > From: Andrzej Hajda <andrzej.hajda@intel.com>
> > > > 
> > > > Debugger needs to read/write program's vmas including userptr_vma.
> > > > Since hmm_range_fault is used to pin userptr vmas, it is possible
> > > > to map those vmas from debugger context.
> > > Oh, this implementation is extremely questionable as well. Adding the LKML
> > > and the MM list as well.
> > > 
> > > First of all hmm_range_fault() does *not* pin anything!
> > > 
> > > In other words you don't have a page reference when the function returns,
> > > but rather just a sequence number you can check for modifications.
> > I think it's all there, holds the invalidation lock during the critical
> > access/section, drops it when reacquiring pages, retries until it works.
> > 
> > I think the issue is more that everyone hand-rolls userptr.
> 
> Well that is part of the issue.

Yeah I ignored the other part, because that didn't seem super interesting
really.

Like for compute you can make the architectural assumption that gpu
addresses match cpu addresses, and this all becomes easy. Or at least
easier, there's still the issue of having to call into the driver for gpu
side flushes.

But for 3d userptr that's not the case, and you get two options:
- Have some tracking structure that umd and debugger agree on, so stable
  abi fun and all that, so you can find the mapping. And I think in some
  cases this would need to be added first.
- Just ask the kernel, which already knows.

Like for cpu mmaps we also don't inject tracking code into mmap/munmap, we
just ask the kernel through /proc/pid/maps. This sounds like the same
question, probably should have a similar answer.

I guess you can do a bit a bikeshed about whether the kernel should only
do the address translation and then you do a ptrace poke/peek for the
actual access. But again you need some flushes, so this might be a bit
silly.

But fundamentally this makes sense to me to ask the entity that actually
knows how userptr areas map to memory.
-Sima

> 
> The general problem here is that the eudebug interface tries to simulate the
> memory accesses as they would have happened by the hardware.
> 
> What the debugger should probably do is to cleanly attach to the
> application, get the information which CPU address is mapped to which GPU
> address and then use the standard ptrace interfaces.
> 
> The whole interface re-invents a lot of functionality which is already there
> just because you don't like the idea to attach to the debugged application
> in userspace.
> 
> As far as I can see this whole idea is extremely questionable. This looks
> like re-inventing the wheel in a different color.
> 
> Regards,
> Christian.
> 
> >   Probably time
> > we standardize that and put it into gpuvm as an optional part, with
> > consistent locking, naming (like not calling it _pin_pages when it's
> > unpinnged userptr), kerneldoc and all the nice things so that we
> > stop consistently getting confused by other driver's userptr code.
> > 
> > I think that was on the plan originally as an eventual step, I guess time
> > to pump that up. Matt/Thomas, thoughts?
> > -Sima
> > 
> > > > v2: pin pages vs notifier, move to vm.c (Matthew)
> > > > v3: - iterate over system pages instead of DMA, fixes iommu enabled
> > > >       - s/xe_uvma_access/xe_vm_uvma_access/ (Matt)
> > > > 
> > > > Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> > > > Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
> > > > Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> > > > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com> #v1
> > > > ---
> > > >    drivers/gpu/drm/xe/xe_eudebug.c |  3 ++-
> > > >    drivers/gpu/drm/xe/xe_vm.c      | 47 +++++++++++++++++++++++++++++++++
> > > >    drivers/gpu/drm/xe/xe_vm.h      |  3 +++
> > > >    3 files changed, 52 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
> > > > index 9d87df75348b..e5949e4dcad8 100644
> > > > --- a/drivers/gpu/drm/xe/xe_eudebug.c
> > > > +++ b/drivers/gpu/drm/xe/xe_eudebug.c
> > > > @@ -3076,7 +3076,8 @@ static int xe_eudebug_vma_access(struct xe_vma *vma, u64 offset_in_vma,
> > > >    		return ret;
> > > >    	}
> > > > -	return -EINVAL;
> > > > +	return xe_vm_userptr_access(to_userptr_vma(vma), offset_in_vma,
> > > > +				    buf, bytes, write);
> > > >    }
> > > >    static int xe_eudebug_vm_access(struct xe_vm *vm, u64 offset,
> > > > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > > > index 0f17bc8b627b..224ff9e16941 100644
> > > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > > @@ -3414,3 +3414,50 @@ void xe_vm_snapshot_free(struct xe_vm_snapshot *snap)
> > > >    	}
> > > >    	kvfree(snap);
> > > >    }
> > > > +
> > > > +int xe_vm_userptr_access(struct xe_userptr_vma *uvma, u64 offset,
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
> > > > +	for (xe_res_first_sg_system(up->sg, offset, len, &cur); cur.remaining;
> > > > +	     xe_res_next(&cur, cur_len)) {
> > > > +		void *ptr = kmap_local_page(sg_page(cur.sgl)) + cur.start;
> > > The interface basically creates a side channel to access userptrs in the way
> > > an userspace application would do without actually going through userspace.
> > > 
> > > That is generally not something a device driver should ever do as far as I
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
> > > I just strongly hope that this will prevent the mapping from changing.
> > > 
> > > Regards,
> > > Christian.
> > > 
> > > > +	return ret;
> > > > +}
> > > > diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
> > > > index 23adb7442881..372ad40ad67f 100644
> > > > --- a/drivers/gpu/drm/xe/xe_vm.h
> > > > +++ b/drivers/gpu/drm/xe/xe_vm.h
> > > > @@ -280,3 +280,6 @@ struct xe_vm_snapshot *xe_vm_snapshot_capture(struct xe_vm *vm);
> > > >    void xe_vm_snapshot_capture_delayed(struct xe_vm_snapshot *snap);
> > > >    void xe_vm_snapshot_print(struct xe_vm_snapshot *snap, struct drm_printer *p);
> > > >    void xe_vm_snapshot_free(struct xe_vm_snapshot *snap);
> > > > +
> > > > +int xe_vm_userptr_access(struct xe_userptr_vma *uvma, u64 offset,
> > > > +			 void *buf, u64 len, bool write);
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

