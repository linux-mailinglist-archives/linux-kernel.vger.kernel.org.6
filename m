Return-Path: <linux-kernel+bounces-186545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307238CC571
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D991528448C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC061420BB;
	Wed, 22 May 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCOI5nOJ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7152B9C3
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398582; cv=none; b=DsHSFjo1AqvFklGZr3HRVT9uv/3/69WZog7Cw3/mLMGX6R1K+RgqewjQXyPBErj0vJduUEVcUPuKE0afAbzL57Q66BIcaX2rkfzCER8gWeypuX3Bt9YlzDlgwigmaHMukgaBRWVBjgO9uK4BLrlll0X2WEtKwfukUpfRVu482ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398582; c=relaxed/simple;
	bh=ica08yqQx0deZpRCdIbr/DJ65JNpQBTW69iLP+ogSzI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5lm6wLswiS3W9ON2C8uhmphgwpzeLCw7U9emLfZkK5q4G5262JTbvS0r3oKJLTYOFyCzOUrzyxremOqav0r/JQkBoaac20ZoLme9IZpT8ohvbTOvNLk4y9xUugR/WDxeUN18AWnY2tCAppD8hmdPqo/T0RwCO9TydlI8tul88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCOI5nOJ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51ff65b1e14so7804554e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716398579; x=1717003379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hKhh70jMeptWU7ZZ/ftWiaVt+5czwlS5uWtiZA1kFo=;
        b=BCOI5nOJzlSdK6kakSvLxED/XWIMxYY8uIiOYdyzHDWm2jJGl0UfHP87khXVsHa1u9
         p/8w3W2hvynfG/9xUBjLkwhLl7cnXm0NM1AEYj5x05TJ5KKpASRqWpjnqh7FQaTjBi99
         6K3lLbhbXkDSGsAyjqwwGNfoA7VpPkTCPw+p6MG1BrA4josVm8DPwCcfdWN+SeAYWG6C
         oLzHSDZTKVWlaAXwrgPD4pnCwRcMD5FShVhmlkojpV71L0A/3OMQHpm0d/mQLw1LlVNl
         smtq8yjdlF/HHWkDNWfS8S6wKr/yoEaTgfet4hj0b1SD/nvQ2Z7/C+XprFtBxJhHW0Y9
         zdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716398579; x=1717003379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hKhh70jMeptWU7ZZ/ftWiaVt+5czwlS5uWtiZA1kFo=;
        b=H8TTU2Np3p4AtDilk2R3Jo8vCSTAzemmeHhlcChhAx/4Ze6lz5HUlcy6LlC8KrW3+l
         R7QWhxE7EBKB6Ok0GYDYu7i1G3aC2bzBp5p75QFxb1CCELmhNLWWY277WPcejv+oDw7w
         LdHVwe0FodfyszFKT+9H2IEEJSFsaMLFTW9XZQWhzgxJJq7E2N7Obfc3GOFWVGntI9aj
         AIHoHV3vLVZRSOyIpwULISspTS7n/SQg+XJxx3Pjd1ROaLaIxLM7TRaEySfaxEXVc3h8
         2WnA05CyUh+0uiHxq9/D8za5xUwUc+JpKh1Ad1ZKD2S7n0gMApxobUtbeQGVFonZP0i4
         m67w==
X-Forwarded-Encrypted: i=1; AJvYcCUboa/3SRkLIApHQt2ZrWiahr12IWrxtvPrrrKxzezgnhYmyOhuZp9pAeR9cMsWXcJpVl4ZJlaMw+p9M+L3k2PQWzzkL7MZ8bOyPCDb
X-Gm-Message-State: AOJu0YzD3HInUEvTAWsKuvvrjk2RFm2SOSFgaxYVBiZtck3YWh9WIe5V
	IYIOK3tKhsw2lCaLdHOl5gOQOiovpE/nuhjTb3SjbuoRVv5okwYh
X-Google-Smtp-Source: AGHT+IGPJ3i5nUpc9c4LI4ItTOdGFOaAJybcYO4oMTgcCTCP3WcUbMHOGvS3axUGJdizHrNQUcn/Cw==
X-Received: by 2002:a19:640a:0:b0:521:b1ca:9c99 with SMTP id 2adb3069b0e04-526be8d483cmr1706903e87.5.1716398578612;
        Wed, 22 May 2024 10:22:58 -0700 (PDT)
Received: from f (cst-prg-19-178.cust.vodafone.cz. [46.135.19.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17892471sm1815056766b.84.2024.05.22.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:22:58 -0700 (PDT)
Date: Wed, 22 May 2024 19:22:25 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	vbabka@suse.cz, lstoakes@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: batch unlink_file_vma calls in free_pgd_range
Message-ID: <fxrzu3h6qb7mptx4av4e7k55iod6amaob75tisg75eg2x3jmpk@2nkifqbb4yiz>
References: <20240521234321.359501-1-mjguzik@gmail.com>
 <v4k3u3h5b4xkss3qlltfqnlmobbihzoelqhnmjbhc57jup52wp@csaqg7h45co2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <v4k3u3h5b4xkss3qlltfqnlmobbihzoelqhnmjbhc57jup52wp@csaqg7h45co2>

On Wed, May 22, 2024 at 11:19:45AM -0400, Liam R. Howlett wrote:
> * Mateusz Guzik <mjguzik@gmail.com> [240521 19:43]:
> > Execs of dynamically linked binaries at 20-ish cores are bottlenecked on
> > the i_mmap_rwsem semaphore, while the biggest singular contributor is
> > free_pgd_range inducing the lock acquire back-to-back for all
> > consecutive mappings of a given file.
> > 
> > Tracing the count of said acquires while building the kernel shows:
> > [1, 2)     799579 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [2, 3)          0 |                                                    |
> > [3, 4)       3009 |                                                    |
> > [4, 5)       3009 |                                                    |
> > [5, 6)     326442 |@@@@@@@@@@@@@@@@@@@@@                               |
> > 
> > So in particular there were 326442 opportunities to coalesce 5 acquires
> > into 1.
> > 
> > Doing so increases execs per second by 4% (~50k to ~52k) when running
> > the benchmark linked below.
> > 
> > The lock remains the main bottleneck, I have not looked at other spots
> > yet.
> 
> Thanks.  This change is compact and allows for a performance gain.  It
> looks good to me.
> 
> I guess this would cause a regression on single mappings, probably
> within the noise and probably not a real work load.  Just something to
> keep in mind to check if the bots yell about some contrived benchmark.
> 

Trivial tidy ups can be done should someone be adamant there is a
slowdown and it needs to be recouped, starting with inlining the new
routines (apart from unlink_file_vma_batch_process).

> On that note, kernel/fork.c uses this lock for each cloned vma right
> now.  If you saved the file pointer in your struct, it could be used
> for bulk add as well.  The only complication I see is the insert order
> being inserted "just after mpnt", maybe a bulk add version of the struct
> would need two lists of vmas - if the size of the struct is of concern,
> I don't think it would be.
> 

Looks like it would need a different spin on batching than the one
implemented above.

Maybe I'll get around to this some time early next month.

> > @@ -131,6 +131,47 @@ void unlink_file_vma(struct vm_area_struct *vma)
> >  	}
> >  }
> >  
> > +void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> > +{
> > +	vb->count = 0;
> > +}
> > +
> > +static void unlink_file_vma_batch_process(struct unlink_vma_file_batch *vb)
> > +{
> > +	struct address_space *mapping;
> > +	int i;
> > +
> > +	mapping = vb->vmas[0]->vm_file->f_mapping;
> > +	i_mmap_lock_write(mapping);
> > +	for (i = 0; i < vb->count; i++) {
> > +		VM_WARN_ON_ONCE(vb->vmas[i]->vm_file->f_mapping != mapping);
> > +		__remove_shared_vm_struct(vb->vmas[i], mapping);
> > +	}
> > +	i_mmap_unlock_write(mapping);
> > +
> > +	unlink_file_vma_batch_init(vb);
> > +}
> > +
> > +void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
> > +			       struct vm_area_struct *vma)
> > +{
> > +	if (vma->vm_file == NULL)
> > +		return;
> > +
> 
> It might be worth a comment about count being always ahead of the last
> vma in the array.  On first glance, I was concerned about an off-by-one
> here (and in the process function).  But maybe it's just me, the
> increment is pretty close to this statement - I had to think about
> ARRAY_SIZE() here.
> 

I think that's upgringing on different codebases.

Idiomatic array iteration of n elements being "for (i = 0; i < n; i++)"
to me makes the below assignment + counter bump pair obviously correct.

That is to say some other arrangement would require me to do a double
take. :)

> > +	if ((vb->count > 0 && vb->vmas[0]->vm_file != vma->vm_file) ||
> > +	    vb->count == ARRAY_SIZE(vb->vmas))
> 
> Since you are checking vm_file and only support a single vm_file in this
> version, it might be worth saving it in your unlink_vma_file_batch
> struct.  It could also be used in the processing to reduce dereferencing
> to f_mappings.
> 
> I'm not sure if this is worth it with modern cpus, though.  I'm just
> thinking that this step is executed the most so any speedup here will
> help you.
> 

I had it originally but it imo uglified the code.

> Feel free to add
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 

thanks

