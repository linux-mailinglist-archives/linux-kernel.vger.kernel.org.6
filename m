Return-Path: <linux-kernel+bounces-362967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC43999BBCC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1316E1C20CC3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB23147C9B;
	Sun, 13 Oct 2024 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0h7plLNB"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C32AF1E
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728852377; cv=none; b=sF/uRXEt6dEx4ASXyslDKcsBGyuWb/ia0cD1j9MbgjOzMYJNTD+bldv723J3mOGBgLEz8sQuFkJaypnFWrR9piEBWkaCWSUBbrp1lgEwUrAy+Vkof+623jiYEtMpm+HQs7uAQPDokga/5Sn3EgYeiFqpvdbP5UiHBSKbLVpyfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728852377; c=relaxed/simple;
	bh=yI3chi67vc41fo3CXhT/TlzKTkgLqcT0IPa7i3PC/0Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l22uKEbFvAL/YGv/PPo3NCZm9ZJQQx4JLPXnoJ5bH9WgQRLGjzvtxws1Hi2LbB1142vfHyVFoYTOaJTkpSfZ2SfdiVyLMqt4FQHrG2lWOS6oPMl7cDqwOUIlIAjD7ELDLnrD2itYgeT1xabx1wNjxWrmGm901D2CvaZv9WfIb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0h7plLNB; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so511095ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728852375; x=1729457175; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzrPGSF9sPSxB1fjq+78A8m6tr308rxiQmG+priBswo=;
        b=0h7plLNBG3xOtUaokT+a73lZlDS7rDv2JCOta9XIgILIP6wyqo34DDCutZRBxGm8Bm
         DBBcEgZXTILKUY4dfObKGAdJ4WnKncDokNaBKHZU9frR7jg5eyHIjo9GDqqDuiN1fKl9
         n/xi7C6sQX78u8oTIRHOoRkMPTO9x5lhDD4MgleBthmOSPBTDmRxKOEG5x7O2Eby4oRF
         /xCGGEbphie0jedFBcv9oMJz+EoCYyrWp4vvGVIc59CbgbtLr3OvSCJlYqt+qTM+2KUC
         xzDuLM1+2x39UAk/noyQ3oRIbbY6BjrwuooOs56Yw0zExIbzG+E9TJX1D/sYhbQBxUZ3
         olhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728852375; x=1729457175;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzrPGSF9sPSxB1fjq+78A8m6tr308rxiQmG+priBswo=;
        b=O2bJOxjubGeM+7ev+AiyZpmtDBGY68JXxlqAVdlBZ9MivWew5twUiER/OnAo8sQUCV
         TN1+KtaJKSl9/6MW0hCUYeQMPrVOjvaCseYtsN6uTW1FkJnF/l2SrcG2FdQOI80JkABU
         dZFoHqjDFEPG0qRe7gZRG4V38GtcyNDtXTWyAAovYW2g1xvZU4VDv2NVlyXGQH/LJB1P
         gjPEIr7LEneertYEdJ1NYnt26sUIFIAdkjzdbWvyq2yeV/JClovGbEDUx74Q8RYu+tLK
         S7Q/1Y00T85ZmpPWaCMMCqPzno2lYw5DqBVFhtY7gIDGGHgYiDaidDES1Vmw+LNVhJLH
         hB7w==
X-Forwarded-Encrypted: i=1; AJvYcCUq9774SHPVJ/3a0ZdqjeubfdnzJW6M3leglqvp05Oko1is11eUXhh0k8E8+gHK6ZNCZdfXxbS/klnN+C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpNcBdnvQZc0wwLpEn2h1Xs9IA9NAy/w2pbfVF7aXLFs6ECam
	qCaAsfeFQP97BslKuLYLUCMhbkj8Um9+yZocT1A/Cn7arAqdQBieANvfy7wJlw==
X-Google-Smtp-Source: AGHT+IEHGQO8HxKY7uuhKGsoLz1zdLwZN2fc1QCZousb1o7sa+WqVyaK5FBaPWGNo3cek8C6TYaC6Q==
X-Received: by 2002:a05:6e02:1562:b0:3a3:b07b:6d3 with SMTP id e9e14a558f8ab-3a3bdd3457dmr5846485ab.9.1728852374974;
        Sun, 13 Oct 2024 13:46:14 -0700 (PDT)
Received: from [2620:0:1008:15:278e:7bb9:ac44:ba28] ([2620:0:1008:15:278e:7bb9:ac44:ba28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea448f9380sm5560091a12.26.2024.10.13.13.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 13:46:14 -0700 (PDT)
Date: Sun, 13 Oct 2024 13:46:13 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: "yuan.gao" <yuan.gao@ucloud.cn>
cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, penberg@kernel.org, 
    iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz, 
    roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slub: Avoid list corruption when removing a slab
 from the full list
In-Reply-To: <i5vqm2ucpjzfbeteamphorouzoep3qxmh3prq5d76g4sazjarf@d3rfku3r5735>
Message-ID: <572f7473-1781-388b-103e-d4382f58f2f9@google.com>
References: <20241011102020.58087-1-yuan.gao@ucloud.cn> <c7b03b1e-e000-279d-f845-5808653ac3bf@gentwo.org> <i5vqm2ucpjzfbeteamphorouzoep3qxmh3prq5d76g4sazjarf@d3rfku3r5735>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 12 Oct 2024, yuan.gao wrote:

> On 24/10/11 11:07AM, Christoph Lameter (Ampere) wrote:
> > On Fri, 11 Oct 2024, yuan.gao wrote:
> > 
> > > When an object belonging to the slab got freed later, the remove_full()
> > > function is called. Because the slab is neither on the partial list nor
> > > on the full list, it eventually lead to a list corruption.
> > 
> > We detect list poison....
> > 
> > > diff --git a/mm/slab.h b/mm/slab.h
> > > index 6c6fe6d630ce..7681e71d9a13 100644
> > > --- a/mm/slab.h
> > > +++ b/mm/slab.h
> > > @@ -73,6 +73,10 @@ struct slab {
> > >  						struct {
> > >  							unsigned inuse:16;
> > >  							unsigned objects:15;
> > > +							/*
> > > +							 * Reuse frozen bit for slab with debug enabled:
> > 
> > "If slab debugging is enabled then the frozen bit can bereused to
> >  indicate that the slab was corrupted"
> > 
> > > index 5b832512044e..b9265e9f11aa 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -1423,6 +1423,11 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
> > >  			slab->inuse, slab->objects);
> > >  		return 0;
> > >  	}
> > > +	if (slab->frozen) {
> > > +		slab_err(s, slab, "Corrupted slab");
> > 
> > 
> > "Slab folio disabled due to metadata corruption" ?
> > 
> > 
> 
> Yes, that's what I meant. 
> Perhaps I should change the description from "Corrupted slab" to
> "Metadata corrupt"?
> 

I think the point here is that slab page corruption is different from slab 
metadata corruption :)

The suggested phrasing, "Slab folio disabled due to metadata corruption", 
sounds good to me.

> > > @@ -2744,7 +2750,10 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
> > >  	slab->inuse++;
> > >
> > >  	if (!alloc_debug_processing(s, slab, object, orig_size)) {
> > > -		remove_partial(n, slab);
> > > +		if (folio_test_slab(slab_folio(slab))) {
> > 
> > 
> > Does folio_test_slab test for the frozen bit??
> > 
> 
> For slab folios, slab->fronzen has been set to 1.
> For non-slab folios, we should not call remove_partial().
> I'm not sure if I understand this correctly.
> 
> Thanks
> 

