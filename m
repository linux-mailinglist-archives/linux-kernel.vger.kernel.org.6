Return-Path: <linux-kernel+bounces-437926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F79E9AA0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32BD284EF5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D1B1E9B32;
	Mon,  9 Dec 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GiJqLTKm"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F691C5CAA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758280; cv=none; b=NCA4NnDXInQELd/7SAou0Qo749+8KNppyIbX+6mSFPBjSuoKuSEjjRjrZ4D7Ruo9wmdYYKS/vIQJBPCaaUKsAkKpQGhHoRKwxA49Y4eh7E1Cbbf65cmou5gUXikNoP1UT3WHsW4eX1bxo2kKXHx0hAvfey36/HYuh+kQwlAGL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758280; c=relaxed/simple;
	bh=BaGqG3p0lGAouP4kzhuxA8hs33UqSVdMZEJdNZbjOuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrIH9yXz/xB5S9QDHsfQw47GlRHPKW7d4cEQYTFD5xevzT1KCE50j7XRWWk0mRuCYEeVrOEwlF9ZmdQJEGoMUFysp/qzA+fj5OTrJ292p1VwKmYbfUTAza3YLJAyMLH7SyfpY0PVNt57kcVbR7PHwP1CA2+h52I9YJgH8tPqk2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=GiJqLTKm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3863c36a731so939902f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1733758276; x=1734363076; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRrwKagbDkhwxnLFjd7MS7qeMP3V5ZX0pRGxISFGQGY=;
        b=GiJqLTKmthemG+RMAzWUYXRCU2ICadh7sTNvOKYCjBFXID461snnsFRgYcJAJnaT78
         fcS82xWvzwNE/8YxffaOaXVn92gogCs10FNv0pw9UXazSiGTRzUEv6KZMo5Hml1aX26G
         qX2amjUYPtYFj+vnemCGwBaapz6K5U+pIrbeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733758276; x=1734363076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRrwKagbDkhwxnLFjd7MS7qeMP3V5ZX0pRGxISFGQGY=;
        b=lE4fS+zEtqqMuDSmNcvLDZZIraiUh80+4G3fMMyD+Kcpbbs20AhUaidp+JHIKpscHz
         3hXLZZVZ4pxK+yiBMYoR2ZkLd0dM2UadgW+qeVEfqPd8KiamoA8Gexd4xh4ViRdEXeMh
         XgoFEvaKecX2ZsG7TqZ6Y9GW8NDcYiXsDiJmwaR1wcEIdihNX5MLc/+7nMmX2c48P1Sw
         S2DWMi6ZUzSCSsgkwPG/x5WETAGPmJ41t8W2brnAhCKs81yug89GGp7qmtLkxXiKhnIN
         ZD0M6tvFyfB7K60R+jsJZu1iwzKQK9pBYqXKO+194mKB/pTxHmqp8h6lI3rK4f7UfSbj
         pDug==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0VIR9Y/tfABCeTz5td6cfcGtcHYug5IW97CRNVhSmVtZaz4aEDK62hk5MEkcihdq/74EPhSfozZDwMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Gz6yLr+94GJgMv646WpzYrjgdazZyeahZgd/+SOrC4AnbBtY
	/lGcDnyWnOK8WQgqJsMiMCR6YVTlymNaDS24ko7hqZP7zmpfYQRUWTDBc5ZuKZOF6w4ZNtIwYVE
	iVdI=
X-Gm-Gg: ASbGncvLRpJthQKXcPM0lYDnijDxyABEWT1HgwGg70a1wH7k3ee5klZsbZgg9VwP8Tf
	B0lF6pTcjBv4PJetlajuIwnop7j7xP0kk+jPvnzMGti1n/ZTaQD0xFqaUsTSILRHBVv0mZkij6R
	4vxKrQqofnLgzalLNUREisjK3wtKoZpHJI3iODQRulLtlXyaSchKtOawbRpw90+1ZURXoXOOvoL
	peYKxPUs/hMoPa7m4utCmDCrGULy5s9bf+nIZZKxgYpZG68VfwCbZm4/RuYdA==
X-Google-Smtp-Source: AGHT+IEa2hI71BSfv72l6DzkdT7Sj5cETKMQ7Bq7s1zyr891Bbd+K0P9g6YcWBCA6YUOOgULQ7HHrw==
X-Received: by 2002:a5d:5f45:0:b0:385:f2a5:ef6a with SMTP id ffacd0b85a97d-386453d6876mr751537f8f.15.1733758276345;
        Mon, 09 Dec 2024 07:31:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38637a0c6dfsm6814580f8f.93.2024.12.09.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:31:15 -0800 (PST)
Date: Mon, 9 Dec 2024 16:31:13 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>,
	intel-xe@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Maciej Patelczyk <maciej.patelczyk@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: Re: [PATCH 14/26] drm/xe/eudebug: implement userptr_vma access
Message-ID: <Z1cNQTvGdAUPp4Y-@phenom.ffwll.local>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec42fe8b-9be0-41cc-96f4-f1869c6bb7e6@amd.com>
X-Operating-System: Linux phenom 6.11.6-amd64 

On Mon, Dec 09, 2024 at 03:03:04PM +0100, Christian König wrote:
> Am 09.12.24 um 14:33 schrieb Mika Kuoppala:
> > From: Andrzej Hajda <andrzej.hajda@intel.com>
> > 
> > Debugger needs to read/write program's vmas including userptr_vma.
> > Since hmm_range_fault is used to pin userptr vmas, it is possible
> > to map those vmas from debugger context.
> 
> Oh, this implementation is extremely questionable as well. Adding the LKML
> and the MM list as well.
> 
> First of all hmm_range_fault() does *not* pin anything!
> 
> In other words you don't have a page reference when the function returns,
> but rather just a sequence number you can check for modifications.

I think it's all there, holds the invalidation lock during the critical
access/section, drops it when reacquiring pages, retries until it works.

I think the issue is more that everyone hand-rolls userptr. Probably time
we standardize that and put it into gpuvm as an optional part, with
consistent locking, naming (like not calling it _pin_pages when it's
unpinnged userptr), kerneldoc and all the nice things so that we
stop consistently getting confused by other driver's userptr code.

I think that was on the plan originally as an eventual step, I guess time
to pump that up. Matt/Thomas, thoughts?
-Sima

> 
> > v2: pin pages vs notifier, move to vm.c (Matthew)
> > v3: - iterate over system pages instead of DMA, fixes iommu enabled
> >      - s/xe_uvma_access/xe_vm_uvma_access/ (Matt)
> > 
> > Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> > Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
> > Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> > Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com> #v1
> > ---
> >   drivers/gpu/drm/xe/xe_eudebug.c |  3 ++-
> >   drivers/gpu/drm/xe/xe_vm.c      | 47 +++++++++++++++++++++++++++++++++
> >   drivers/gpu/drm/xe/xe_vm.h      |  3 +++
> >   3 files changed, 52 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
> > index 9d87df75348b..e5949e4dcad8 100644
> > --- a/drivers/gpu/drm/xe/xe_eudebug.c
> > +++ b/drivers/gpu/drm/xe/xe_eudebug.c
> > @@ -3076,7 +3076,8 @@ static int xe_eudebug_vma_access(struct xe_vma *vma, u64 offset_in_vma,
> >   		return ret;
> >   	}
> > -	return -EINVAL;
> > +	return xe_vm_userptr_access(to_userptr_vma(vma), offset_in_vma,
> > +				    buf, bytes, write);
> >   }
> >   static int xe_eudebug_vm_access(struct xe_vm *vm, u64 offset,
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > index 0f17bc8b627b..224ff9e16941 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -3414,3 +3414,50 @@ void xe_vm_snapshot_free(struct xe_vm_snapshot *snap)
> >   	}
> >   	kvfree(snap);
> >   }
> > +
> > +int xe_vm_userptr_access(struct xe_userptr_vma *uvma, u64 offset,
> > +			 void *buf, u64 len, bool write)
> > +{
> > +	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
> > +	struct xe_userptr *up = &uvma->userptr;
> > +	struct xe_res_cursor cur = {};
> > +	int cur_len, ret = 0;
> > +
> > +	while (true) {
> > +		down_read(&vm->userptr.notifier_lock);
> > +		if (!xe_vma_userptr_check_repin(uvma))
> > +			break;
> > +
> > +		spin_lock(&vm->userptr.invalidated_lock);
> > +		list_del_init(&uvma->userptr.invalidate_link);
> > +		spin_unlock(&vm->userptr.invalidated_lock);
> > +
> > +		up_read(&vm->userptr.notifier_lock);
> > +		ret = xe_vma_userptr_pin_pages(uvma);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (!up->sg) {
> > +		ret = -EINVAL;
> > +		goto out_unlock_notifier;
> > +	}
> > +
> > +	for (xe_res_first_sg_system(up->sg, offset, len, &cur); cur.remaining;
> > +	     xe_res_next(&cur, cur_len)) {
> > +		void *ptr = kmap_local_page(sg_page(cur.sgl)) + cur.start;
> 
> The interface basically creates a side channel to access userptrs in the way
> an userspace application would do without actually going through userspace.
> 
> That is generally not something a device driver should ever do as far as I
> can see.
> 
> > +
> > +		cur_len = min(cur.size, cur.remaining);
> > +		if (write)
> > +			memcpy(ptr, buf, cur_len);
> > +		else
> > +			memcpy(buf, ptr, cur_len);
> > +		kunmap_local(ptr);
> > +		buf += cur_len;
> > +	}
> > +	ret = len;
> > +
> > +out_unlock_notifier:
> > +	up_read(&vm->userptr.notifier_lock);
> 
> I just strongly hope that this will prevent the mapping from changing.
> 
> Regards,
> Christian.
> 
> > +	return ret;
> > +}
> > diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
> > index 23adb7442881..372ad40ad67f 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.h
> > +++ b/drivers/gpu/drm/xe/xe_vm.h
> > @@ -280,3 +280,6 @@ struct xe_vm_snapshot *xe_vm_snapshot_capture(struct xe_vm *vm);
> >   void xe_vm_snapshot_capture_delayed(struct xe_vm_snapshot *snap);
> >   void xe_vm_snapshot_print(struct xe_vm_snapshot *snap, struct drm_printer *p);
> >   void xe_vm_snapshot_free(struct xe_vm_snapshot *snap);
> > +
> > +int xe_vm_userptr_access(struct xe_userptr_vma *uvma, u64 offset,
> > +			 void *buf, u64 len, bool write);
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

