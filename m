Return-Path: <linux-kernel+bounces-193940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330238D3447
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22D42844B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60317B51E;
	Wed, 29 May 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gt7pDulx"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7ED16936C
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977763; cv=none; b=srAXpJwuakgHRejYSh2cyM3DchxLVg98pldxyHWtBaYFh4MoGkLX/ostkuyG0Y283gRrEeOTWRbRnw3dGcSZdq66f6Fw24DOYWJQ3BLDDTXNcSaVQN5+Xoo+zxOoRkXCip0aNXU8m/py7LTCwY6F0w0l9n2Sdyd6Go0moD58tdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977763; c=relaxed/simple;
	bh=IoSfn57HZC0NC4WiSWUxGPzk+tktpN7HgZ6fjrSfHt4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7ZUtHamHQTfowYKmNX8hBg/umzrIw0YPUb+09LfeRvGsnOTgkeOrRZTkoHc+hQR5i1ylNWK4wqDpaMqKXn6++mC8CksbazXIwgb7bmjDBRS5mP2HcXqLb/Iuxx47gGRL8Rrjd+esQ1J85hQrFBZFbfd1rWSF4jcwRN5tV6Hnyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gt7pDulx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4211a86f124so15854475e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716977760; x=1717582560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4x27AVMz0iSl17rfIwR6hT5YsDwoPYx2gnD792TvxbI=;
        b=gt7pDulxBf+sjVdunUngxN1VATgCMN6RDpJScvCkP0r8v9TdtEZSrH06+nDab80GK5
         wDmcG0pk+bUMmRQeM8V+fKJn4Mc2cvDa8L4aQA1J9ywlyKH1PS0rsm79eykKmdJ27TOE
         9EYKQxdGq8/WLowI96lXrpKid8mCs2rQUKshKZPLrmwEV2XPNoa7qg/vUHeUmo6w6t8K
         D6kL6KYofJdr9CW982aCCa3F+Hj2AkucwmGoUgyWipQkivWbnPMjSrekj/ev53MVJxt0
         nGV68osHK3v3hRUto4geEs6tcO/QLMfga4oghIVe79Igm3agaX2F5CajAXQPsVCICY8a
         pv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977760; x=1717582560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4x27AVMz0iSl17rfIwR6hT5YsDwoPYx2gnD792TvxbI=;
        b=GFPF73at831U1LhoGCb/NLd+6dGP0FQA2LQX8Rmi2n+5wIpfomp1u0eU6ishQnilpe
         PBsHGIuAKqP92k+tU4GrE2Z/EbfVS4SphzwQ06fjVm5bf3oZu7mgb2hOtNiKEXfTAbLJ
         l5+TtvwtU12D+WOAkZ2N3D9T0v7oioocxf4l8jWFMfPo4M+yuBDCyqsy7KG7jA38rwrk
         QsTJM/YGXQbbsqyzDtRKhEBE7o0u1qysFztREhZRxsgB+QuK4hn+MhLZ+gHwSHBMUci4
         VeiV6xjgYUxRRhokI1il137PkQIk2a62d5BiY3IaVofOwF10M254hqpxrOblmyk9d/eP
         hBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnKkEiMZQ3yFOy6oGui5O5GCRLyfFyJUwA4asyXQXYl7PglRy4d9NNmXQwEmImXRCBsVYpWk7NwqpF3J/wnuJVCdpL+DQjd52Ab8Ql
X-Gm-Message-State: AOJu0YwL6dMkQGi5Eb7g4Iw3ZiHab6fNC3JMofdpvkeWqp1Cf69vruLg
	fRVL+bu3rUhzWvO9nKxP2TOgKTgSGsOflQqjuj/d7E2ZK4pwITG5CFAxTFsF1HI=
X-Google-Smtp-Source: AGHT+IHqM8vBSZQLQX11IaWlIhjemGFoCG5dMTyPcAeygvinoSDY4HDbiRu9hgo9s7sf/V/iTTF9Zw==
X-Received: by 2002:a7b:cb16:0:b0:418:e04b:ee63 with SMTP id 5b1f17b1804b1-42108a21421mr117679005e9.36.1716977759946;
        Wed, 29 May 2024 03:15:59 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4211e43e8easm54635895e9.16.2024.05.29.03.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:15:59 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 12:15:57 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Oscar Salvador <osalvador@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v4 12/16] powerpc/e500: Encode hugepage size in PTE
 bits
Message-ID: <ZlcAXTMBSMt69ulX@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <10eae3c6815e3aba5f624af92321948e4684c95a.1716815901.git.christophe.leroy@csgroup.eu>
 <Zlbh5Bwsx7WqEEWr@localhost.localdomain>
 <3cf95f5e-cc8b-4417-a3fa-80dc3b24ac63@csgroup.eu>
 <Zlb-9DNmRzIYRdJO@localhost.localdomain>
 <3186e950-fbf8-42c4-9eed-9564c8374019@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3186e950-fbf8-42c4-9eed-9564c8374019@csgroup.eu>

On Wed, May 29, 2024 at 10:14:15AM +0000, Christophe Leroy wrote:
> 
> 
> Le 29/05/2024 à 12:09, Oscar Salvador a écrit :
> > On Wed, May 29, 2024 at 09:49:48AM +0000, Christophe Leroy wrote:
> >> Doesn't really matter if it's PUD or PMD at this point. On a 32 bits
> >> kernel it will be all PMD while on a 64 bits kernel it is both PMD and PUD.
> >>
> >> At the time being (as implemented with hugepd), Linux support 4M, 16M,
> >> 64M, 256M and 1G (Shifts 22, 24, 26, 28, 30)
> >>
> >> The hardware supports the following page sizes, and encodes them on 4
> >> bits allthough it is not directly a shift. Maybe it would be better to
> >> use that encoding after all:
> > 
> > I think so.
> > 
> >>
> >> 0001 4 Kbytes (Shift 12)
> >> 0010 16 Kbytes (Shift 14)
> >> 0011 64 Kbytes (Shift 16)
> >> 0100 256 Kbytes (Shift 18)
> >> 0101 1 Mbyte (Shift 20)
> >> 0110 4 Mbytes (Shift 22)
> >> 0111 16 Mbytes (Shift 24)
> >> 1000 64 Mbytes (Shift 26)
> >> 1001 256 Mbytes (Shift 28)
> >> 1010 1 Gbyte (e500v2 only) (Shift 30)
> >> 1011 4 Gbytes (e500v2 only) (Shift 32)
> > 
> > You say hugehages start at 2MB (shift 21), but you say that the smallest hugepage
> > Linux support is 4MB (shift 22).?
> > 
> > 
> 
> No I say PMD_SIZE is 2MB on e500 with 64 bits PTE and at the time being 
> Linux powerpc implementation for e500 supports sizes 4M, 16M, 64M, 256M 
> and 1G.

Got it. I got confused.


-- 
Oscar Salvador
SUSE Labs

