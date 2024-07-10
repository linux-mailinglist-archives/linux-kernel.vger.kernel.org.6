Return-Path: <linux-kernel+bounces-248097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A952E92D865
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F651F22A95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C203196438;
	Wed, 10 Jul 2024 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQTvqH1V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61E195803
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636886; cv=none; b=NzdWQzZ6CMank8pDCuQbCvxOUMvnUhgmHzeqW33kD1o/B9d1YXgwFZUslntNLELK1Te8a+R/WdPfGPvLxc7RyT77JTpn/B8s42c51smb+5WWi8Ejc90WZrWrmT4m8g6tdtmSVIRFKAFoJgSjlAIFgzpgGWlhHorXo3ShONOKmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636886; c=relaxed/simple;
	bh=jBb2ZgyqNHHzXqzPfyVmH8sGami6SZ423WosKVZ5w2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTOSm5coPEwgx97APwKcnKEOu6aOpoKhjN5G+ptwRD7Qi/yV4U2Ittnli434HjAlmNWKHS1U5CTCPQ3JIWuFQ29G5XDeeBo8CdGcbQ6KH3ZWXxIuh/xQkl+7GBCBOI4my2ZyDPevQ4glhyyi0GYK7ZOKnv/CeBQZFaYtNQIWYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQTvqH1V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720636884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eIVX3Nh3vYBEeF7J3Cswb85HDhmhS0B4NjP2O37xgE=;
	b=SQTvqH1VXrn9Aeo9m4R4YTmFmJBf4WEoW2fqcuCBo5NG6yeuiXKftDZYA1CgjrXS7BENA5
	1oX7SZXS216FmWepvlxj0YLTuHUwr8hOv+UBxn6k4gkfB7VfeYz8Txv51tiVtFaJIxiYfP
	4lkkkN2Omj56okHVNTOoi1jCxsb938s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-9fr8iaBAPJCtVADaHJfSyg-1; Wed, 10 Jul 2024 14:41:23 -0400
X-MC-Unique: 9fr8iaBAPJCtVADaHJfSyg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79f1770b273so1263985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636882; x=1721241682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eIVX3Nh3vYBEeF7J3Cswb85HDhmhS0B4NjP2O37xgE=;
        b=erymcQEfUxGoMHbXamtFmBI523RY8ljAyFpUt34Fa3bZ9C0EGMGW7hn9aCRt59qZPN
         yfLiacWxoiA8Kgxgp32sVoN9clruWxyuxuxErdEsU/QIlhG9wcgNMRzA3FUEhcf2KWUS
         UnND33rbhUApaZS+K9OYhnbio+v6IDiLQNGlI6Z7E0W7foe83mRedDpowCmJQ2JD4N7o
         NFOJ5uXBZ+gyKka3Jq7tlsSlUsswT81kg1b98kPC+BEkootyJy4VXJsgRicDaDX9pT1h
         zC9oQGKh8wcA0h5ZpOuOuTnOi093R9gSmvEA6wYKGjGUyQK9cGx7cTZ9Fl3YZ4oR3Vt9
         xtGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSjjBm9Gvs5egIVRxsK4r2ElzQwKB2kzn7n8Aksiye5Afg2w8cbuMtG0DQ5Qjxy3Ire3F/Qs0ZI4G0cTfrUEe4gVUmirH3KrKD7yu9
X-Gm-Message-State: AOJu0YxpimUpo0d3vnhfe3okM/nrPVlklMmr87uTALunJLuJgWXgVNSx
	GP5MJnlPS+2T4FMZviWSXh9nR0PmyAr9LLm8y1j83A0b5AuBH3qAxk+z1jw0nZUVaJkGxaGgCon
	xThyVPYTABOjIzGaULEnZHpI14JTwmFMcAmfoi94Aos04/196Cu8Z+TENxEVQ5w==
X-Received: by 2002:ac8:4c82:0:b0:447:f0c4:8298 with SMTP id d75a77b69052e-44cfc3fa56amr3702471cf.2.1720636882416;
        Wed, 10 Jul 2024 11:41:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETdUfrXNqDgbDS7Z1BhFJRvI4WQSOwSqIDdD+5+bC0SwiVZqBADzNnXqHzy4Zdi40FUQ/PVQ==
X-Received: by 2002:ac8:4c82:0:b0:447:f0c4:8298 with SMTP id d75a77b69052e-44cfc3fa56amr3702401cf.2.1720636882087;
        Wed, 10 Jul 2024 11:41:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26c83sm22681111cf.2.2024.07.10.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:41:21 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:41:19 -0400
From: Peter Xu <peterx@redhat.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/3] mm: Add p{g/4}d_leaf() in
 asm-generic/pgtable-nop{4/u}d.h
Message-ID: <Zo7Vz_LGUgaf9BGN@x1n>
References: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
 <f69941b076bf8fec89b6bec5573fdb79483c2a75.1720597744.git.christophe.leroy@csgroup.eu>
 <Zo6e1ILgDn6nuhGC@x1n>
 <b37a0bb5-ba6f-4db3-af8f-83e06eec086d@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b37a0bb5-ba6f-4db3-af8f-83e06eec086d@cs-soprasteria.com>

On Wed, Jul 10, 2024 at 02:54:36PM +0000, LEROY Christophe wrote:
> 
> 
> Le 10/07/2024 à 16:46, Peter Xu a écrit :
> > On Wed, Jul 10, 2024 at 09:51:22AM +0200, Christophe Leroy wrote:
> >> Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
> >> issues") added pud_leaf() in include/asm-generic/pgtable-nopmd.h
> >>
> >> Do the same for p4d_leaf() and pgd_leaf() to avoid getting them
> >> erroneously defined by architectures that do not implement the
> >> related page level.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >> v2: Added pXd_leaf macro as well in asm-generic/pgtable-nopXd.h to cohabit with the fallback
> >> ---
> > 
> > Thanks.  I'd drop the inline functions, but no strong opinions.
> 
> Inline functions enable type checking.
> 
> With a macro you would be able to write pud_leaf(pgd) without the 
> compiler noticing the mistake.
> 
> All other helpers in asm-generic/pgtable-nopXd.h are functions so from 
> my point of view it makes sense to keep them as functions not macros.

Whoever fallbacks to the pgtable.h pxx_leaf() will still use macros and
lose the type check again.  I'd rather rely on cross-arch builds and most
of real *_leaf() users will always detect a type mismatch.

Totally no big deal, and I agree keeping them match nopxd.h rules makes
sense.

Thanks,

-- 
Peter Xu


