Return-Path: <linux-kernel+bounces-236417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864091E1F1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181AC287FC9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1743144;
	Mon,  1 Jul 2024 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4UWJIQk"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5116132B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843050; cv=none; b=OTD9BjT/RnKR0cOE1g3Xk9pIt/w0zagQzzcCmfj6d9zDAz11kG7TR0gTyzmKv1BXHcH4kaiNrwQvNuTzmc+URP4ygTRaPrIaHc4LK3Mmp52gIpxAX01O92Kmm5y5yTqbQz1HWVKfOu5dT2e4kcaatdypqO8cfEp9tR8Hor1K4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843050; c=relaxed/simple;
	bh=tiTh+J3beNdExCpBB6xbk5i9pLLhF9/Oz4oRL3aTYrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPr5NDtPXXDf8FyA+brk0uhlt5Hacwy1zsiZJuOUnLwGisAM7KoR0Nptt7UXAgNSCiKNfGHw+00hKlfIXRr22INKWHG3xQU+oAiE5YbNrZM0xe7PHTtnrd0dU2SIjFbtmkA7G13Pyswn2JOFBZnqKmzxlm7QRKRyfqs1b1gcO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4UWJIQk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4257c6eea33so64715e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719843046; x=1720447846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Km1Ez8bnMs5MXCoo07hLRftaefO9zeRKQ+RQM7Ne4Q=;
        b=y4UWJIQkzby+YTXTxYTJJhz1RKjb5V2xS5VZrA0fmCw6sg+wD400sbfIxeLP//tOLA
         hkGS39seAph+XvRVZxWb2s85bc4poVrev+m07axqAAopHstHOrBpmaCGw0GTCuir7uE1
         xRJvBjM75rDcPe/Eem6PVEz7NGg8sNWG+COYXWuIJdBWbkRrJ2bZF3X28FBZVNTbhMwH
         H0WtdHdGBwx4/n89WKa7Hli+EMEqvIx2mcHIAnjeTZJH0RC7nbx0xfdV5QUnPltFOfBp
         KoFJuDC21MV+lD+/yxnBNAq6xEYOJBCTJNmTkawgonQ1E6GjabV5ffoiTkteWAs9kOZs
         Rtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843046; x=1720447846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Km1Ez8bnMs5MXCoo07hLRftaefO9zeRKQ+RQM7Ne4Q=;
        b=G3JQan20av1E9qnw3qGaJPnZrU6Bs7fK4WnPk82NwtFXXSMzh+sRKr8MFEF0S8PgFx
         QQnEHANbkiVTTU7wGxYtfdB61Ee/omIphaI7xj4p6Y/IbDTd7fxa6b/u91tNH1sWcEHd
         E43ypoCom9I8os6KohHdOE1NfB4FY4ddCVqHcKiy94j4leCftIRniByLDIfAKhSSOnvU
         nI9HjVdWm8lZG19ftSc1JLco7ilmc3GhDuXLlFR+jAQ26p9QS6eRZuvgmvbxW6IE+eQU
         68EhHqBTirsh+4zDMwY6YyDA9DN0+7uFHyKzYEesksp5mrr82Vf3NrL9JaDPKNBTSTxS
         h1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUJcGSH1EGcbaEE5ofG5+7ickVLbyjZplx3qabtbIig33bNDZTjLvuOTr7mODqsUR1Th0Bau3wBa4tJH6WCQgb4Ua11jgZYHGBJCSgW
X-Gm-Message-State: AOJu0YxYeb7XvHoGaZftbHe00pZdjFFOCBo8ZbiVLquBoavb3lZCIku5
	RsnWA1i3fSkBgZisXm7Zrs56ZMf7LQOjhBgv7bHRrL0f7CgalLnMiMHRm0n/NQ==
X-Google-Smtp-Source: AGHT+IFtjX/BZqS+uUZ8PF1mKp7f3Esb11KZRNUo9KxHrxIz4V1iA5bVnL0VunIlYUdBUZha4UJQBA==
X-Received: by 2002:a05:600c:1c17:b0:422:ffac:f8c0 with SMTP id 5b1f17b1804b1-4257816691cmr3222955e9.7.1719843045852;
        Mon, 01 Jul 2024 07:10:45 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55cccsm156205455e9.16.2024.07.01.07.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:10:45 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:10:43 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com,
	ardb@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, james.morse@arm.com,
	vdonnefort@google.com, mark.rutland@arm.com, maz@kernel.org,
	rananta@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v7 6/6] KVM: arm64: Expose guest stage-2 pagetable config
 to debugfs
Message-ID: <ZoK44_CmoDHantBv@google.com>
References: <20240621123230.1085265-1-sebastianene@google.com>
 <20240621123230.1085265-7-sebastianene@google.com>
 <Zn8hzwIEtvBFjdkk@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8hzwIEtvBFjdkk@linux.dev>

On Fri, Jun 28, 2024 at 08:49:19PM +0000, Oliver Upton wrote:
> On Fri, Jun 21, 2024 at 12:32:30PM +0000, Sebastian Ene wrote:
> > Make the start level and the IPA bits properties available in the
> > virtual machine debugfs directory. Make sure that the KVM structure
> > doesn't disappear behind our back and keep a reference to the KVM struct
> > while these files are opened.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/ptdump.c | 50 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > index cc1d4fdddc6e..17649e3cbc8f 100644
> > --- a/arch/arm64/kvm/ptdump.c
> > +++ b/arch/arm64/kvm/ptdump.c
> > @@ -215,8 +215,58 @@ static const struct file_operations kvm_ptdump_guest_fops = {
> >  	.release	= kvm_ptdump_guest_close,
> >  };
> >  
> > +static int kvm_pgtable_debugfs_show(struct seq_file *m, void *unused)
> > +{
> > +	const struct file *file = m->file;
> > +	struct kvm_pgtable *pgtable = m->private;
> > +
> > +	if (!strcmp(file_dentry(file)->d_iname, "ipa_range"))
> > +		seq_printf(m, "%2u\n", pgtable->ia_bits);
> > +	else if (!strcmp(file_dentry(file)->d_iname, "stage2_levels"))
> > +		seq_printf(m, "%1d\n", pgtable->start_level);
> 
> The name of the file suggests sounds like this is the number of page
> table levels instead of the starting level of the walk.
> 
> So instead:
> 
> 		seq_printf(m, "%1d\n",
> 			   KVM_PGTABLE_LAST_LEVEL - pgtable->start_level + 1);
> 

Ack, I will rewrite this.

> > +	return 0;
> > +}
> > +
> > +static int kvm_pgtable_debugfs_open(struct inode *m, struct file *file)
> > +{
> > +	struct kvm *kvm = m->i_private;
> > +	struct kvm_s2_mmu *mmu;
> > +	struct kvm_pgtable *pgtable;
> > +	int ret;
> > +
> > +	if (!kvm_get_kvm_safe(kvm))
> > +		return -ENOENT;
> > +
> > +	mmu = &kvm->arch.mmu;
> > +	pgtable = mmu->pgt;
> 
> nitpick: pgtable = &kvm->arch.mmu.pgt
>

Will fix this.

Thanks,
Seb
> -- 
> Thanks,
> Oliver
> 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

