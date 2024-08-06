Return-Path: <linux-kernel+bounces-276653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9818F949697
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5FB1C235CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F085446450;
	Tue,  6 Aug 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZu3VXr2"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B6B56B81;
	Tue,  6 Aug 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964829; cv=none; b=Vu9+eMD+nbOMHlPUm3rho+VS9cBuGwjiFZolFiQluojne2V7/f8L3q87cQ5jWKMvr5Nqlv/8393A/GWfoWisiqEYYOlNTjQ4+ZWQ1rbpfr+8/BDPEwqSxCdBwRZforwFEP/8tXB+2G1lsjZaw2ia5GVQ1NIrI7qzI/prGG0i5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964829; c=relaxed/simple;
	bh=RF4+R4AYY88oE0qW9I2HnZL76wRUDyJ0GGKOQGzO1UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRhezCa+O7JTla8sdITXKFLsDylPlYbVRnT7X3x26wQKINOPJ9vXO+I9B7WCYNKIhlqkfySrJIGvynhPL9o3OnfeiDZwbQiRG0bUUOk/Wy6nb6BrcKHNvtZ1nbFx1gdyr4Acp/2HevtEx30zM3AlPfuOkAQMuzsUsjPHv5Buh5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZu3VXr2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd66cddd4dso9919995ad.2;
        Tue, 06 Aug 2024 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722964827; x=1723569627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKvy5s8I089cQ4Mv7A2bneNgkN9GheLOFUPEna3g4Is=;
        b=kZu3VXr2HVOZdXVXc65R+43KuUsKdTqIXONZfssZPcWHj1pFQ4No/PfADWO45rWzZK
         bPcgh/Av90amnGMLYVlp6oiM9pvsU023JtMM6eBEsJJt0yA44QznzxghH4s9EMcOgE1C
         S0xXbgGOTbJ32HPnND8t3FfYzDttxfbtrUTfFUfizjgwaxAC49/6jCdxTVtO4j82O8DQ
         RnGRwELZxsTZc6iZmktb+6Q4Nu4apC1AMkkKotzx44zsCSW8Zf9/5xDzpH2rFsjNtapE
         zR5ibb7mARPXK8jz8ed2cYIcnv6d568GH8d+1P4+A5RWjmplA2RZaEpR4HwqCV1Ik9Qp
         ZDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964827; x=1723569627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKvy5s8I089cQ4Mv7A2bneNgkN9GheLOFUPEna3g4Is=;
        b=tibMF5kIine/dqPYEh2jWXPSmhY3LmS+W5jtfN7/E5CmsAItLxfxdoHXIFofkswHXW
         qoTXM2sEc9VtcDgQ+8VRdOPliwTf6MMRacALwExJeGAp4aFprJYNfmQNjQNadoHsvvau
         NxKpm6oLv+xgXeRrb/bs8GvTQfrAwzvhnktLc1HqosXCXSMKrr9i4uKTin2HCTjoqGv3
         vtf7fP8bLEhsHp+glXuHUSd4N5U3F0rJVPBP1dg6F52OX/Q0EZ/jCII19wcJRe1b0K0k
         ZqOyC8P6/mp/f3xgC5QScqAB04NozLk7uR+G6sk2y2m6dh6A5l3vidoCoej+RWRhmXMd
         NiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4DygyN9J1vTs9EzynIqMBzTqkArb+6J+Ro4ypsKjiXuupc6wZMmAhAlGikxqYzeNbQ786yZLyRkfj9yiPFIT34JG6h9IahX4JUsNEoJ8y07wygqlVg6ZuOOq586jmtjEt9wXzZBd+fXs=
X-Gm-Message-State: AOJu0YyhRxAF/6G4U1nvLSOLsR0AaiHHV6CqjntCOxb3BcUWWUkDEnAj
	hQwVuNDfK+BcTmfKo+0vJCGikjjqub/zG+/Hhk7CU18KcHFQWqCRP3gdPjTe
X-Google-Smtp-Source: AGHT+IFsPaIm8ghmwUQ3CRGHxVOj1l+zaHds6DmBqTosUveeJiqHqLH9hMwgMdARJUDCiXVDp2vbBg==
X-Received: by 2002:a17:902:fb0b:b0:1fd:a1e9:29bb with SMTP id d9443c01a7336-1ff572ed65cmr146259685ad.38.1722964826755;
        Tue, 06 Aug 2024 10:20:26 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([122.169.160.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905c86esm90069295ad.168.2024.08.06.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:20:26 -0700 (PDT)
Date: Tue, 6 Aug 2024 22:48:32 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, oswald.buddenhagen@gmx.de, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: emu10k1: Fix coding style issues and warnings
Message-ID: <ZrJa6IahC6Edlitb@embed-PC.myguest.virtualbox.org>
References: <20240805155206.463035-1-abhishektamboli9@gmail.com>
 <87cyml8vj6.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyml8vj6.wl-tiwai@suse.de>

On Tue, Aug 06, 2024 at 06:29:17PM +0200, Takashi Iwai wrote:
> On Mon, 05 Aug 2024 17:52:06 +0200,
> Abhishek Tamboli wrote:
> > 
> > Fix coding style errors and warnings in sound/pci/emu10k1/memory.c
> > reported by checkpatch.pl. Changes includes:
> > 
> > - Add spaces after commas in macro definitions.
> > - Insert blank lines after variable declarations.
> > - Consistent spacing around operators.
> > - Remove trailing whitespace.
> > - Move EXPORT_SYMBOL declarations to immediately follow their
> >   respective functions.
> > - Correct spacing in conditional statements and type casts.
> > 
> > Fix the following errors and warnings:
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > +#define __set_ptb_entry(emu,page,addr) \
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > +#define __set_ptb_entry(emu,page,addr) \
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > +#define set_silent_ptb(emu,page)
> > 	__set_ptb_entry(emu,page,emu->silent_page.addr)
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > +#define set_silent_ptb(emu,page)
> > 	__set_ptb_entry(emu,page,emu->silent_page.addr)
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > +#define set_silent_ptb(emu,page)
> > 	__set_ptb_entry(emu,page,emu->silent_page.addr)
> > 
> > WARNING: Missing a blank line after declarations
> > +	int i;
> > +	page *= UNIT_PAGES;
> > 
> > WARNING: Missing a blank line after declarations
> > +	int i;
> > +	page *= UNIT_PAGES;
> > 
> > ERROR: space required after that ',' (ctx:VxV)
> > +#define get_emu10k1_memblk(l,member)
> > 	list_entry(l, struct snd_emu10k1_memblk, member)
> > 
> > WARNING: space prohibited between function name and open parenthesis '('
> > +	list_for_each (pos, &emu->mapped_link_head) {
> > 
> > WARNING: Missing a blank line after declarations
> > +	struct snd_emu10k1_memblk *blk =
> > 		get_emu10k1_memblk(pos, mapped_link);
> > +	if (blk->mapped_page < 0)
> > 
> > ERROR: else should follow close brace '}'
> > +		}
> > +		else if (size > max_size) {
> > 
> > ERROR: need consistent spacing around '-' (ctx:WxV)
> > +	psize = get_aligned_page(size + PAGE_SIZE -1);
> >  	                                          ^
> > 
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > +EXPORT_SYMBOL(snd_emu10k1_memblk_map);
> > 
> > WARNING: Missing a blank line after declarations
> > +		dma_addr_t addr;
> > +		if (ofs >= runtime->dma_bytes)
> > 
> > ERROR: space prohibited after that '!' (ctx:BxW)
> > +		if (! is_valid_page(emu, addr)) {
> >  		    ^
> > 
> > ERROR: trailing whitespace
> > +^Istruct snd_util_memhdr *hdr = hw->memhdr; $
> > 
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > +EXPORT_SYMBOL(snd_emu10k1_synth_alloc);
> > 
> > ERROR: trailing whitespace
> > +^Istruct snd_util_memhdr *hdr = emu->memhdr; $
> > 
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > +EXPORT_SYMBOL(snd_emu10k1_synth_free);
> > 
> > WARNING: Missing a blank line after declarations
> > +	int first_page, last_page;
> > +	first_page = blk->first_page;
> > 
> > WARNING: Missing a blank line after declarations
> > +	char *ptr;
> > +	if (snd_BUG_ON(page < 0 || page >= emu->max_cache_pages))
> > 
> > ERROR: space prohibited after that '!' (ctx:BxW)
> > +	if (! ptr) {
> >  	    ^
> > 
> > ERROR: "(foo*)" should be "(foo *)"
> > +	return (void*)ptr;
> > 
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > +EXPORT_SYMBOL(snd_emu10k1_synth_memset);
> > 
> > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > +EXPORT_SYMBOL(snd_emu10k1_synth_copy_from_user);
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> 
> Thanks for the patch.  But in general, I take this kind of
> white-space-only patches as a preliminary only when coupled with some
> other real fixes or improvement changes -- especially for old driver
> code.  Otherwise it'd just scratch the git history.
> 
> So, if you have other actual fixes for this driver based on this clean
> up, let me know.

Hi Takashi,

Thank you for the feedback. I understand your point regarding
white-space-only patches and I'll keep this in mind for future
contributions. Unfortunately, I don't have any additional
fixes or improvements for this driver at the moment. 

Regards,
Abhishek

