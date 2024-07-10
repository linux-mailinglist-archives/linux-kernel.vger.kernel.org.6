Return-Path: <linux-kernel+bounces-247781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DFD92D478
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3622AB22209
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F63191F90;
	Wed, 10 Jul 2024 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QATPHmBg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A494BE4E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622755; cv=none; b=SL9IXy97L5vCgPKgT0R49A4OPPsD93R/6vI9RV9YsRc7PtCBVylkYTd/Dt4yL3JoXNRMTbeVTsMHIXz7HvM+3U/wXf6TS7oT8Iv9FG5wOutKOVTL1hYybKSNxdtD7CGE2fu4n11VS2cNuYdrkscEUlznt7p8XdmWptidfyU4x2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622755; c=relaxed/simple;
	bh=9nIOIEZMQJBL0jBC0K6U7ns8CsE77OW8WGl+1sgYk6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1DB0JbWiMp2SSAeaTwWsQbWSjaDhpdIY0iLZJMhpvjPGO80hf/rfjuHOYUtcOYm+vajHPGYj8Fws3SAuS02Xgc2cJ7DfMcf67owa95EIcirqrnGR/uVkHue8R9sLgLYWv6fltnlZqQMfMYShcsM0l64UTSl1iDqbjKlqRZUE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QATPHmBg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720622753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vuZByBoQ1AErbnDxFMqwKYDz5/nj+PfxoenuXb+QI3g=;
	b=QATPHmBgVNiz6upotSvwdSVS9ZSWl+JNZjcs0tsrAis0l2bcca1oXynXalw3ZsjazLJRxf
	jJJkFr02oPJoICUG7DODBDJplHlmSH6o7m4bzEG04NeI7FaR2GwJS1SWb4V/o+TDHVu0K+
	fI4yGfW4LMAmPnWfbyd1Cyjzh3VaxjA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-izBB9mhWOJKJpWBMCKHhqg-1; Wed, 10 Jul 2024 10:45:51 -0400
X-MC-Unique: izBB9mhWOJKJpWBMCKHhqg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3d9db343109so181749b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622751; x=1721227551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuZByBoQ1AErbnDxFMqwKYDz5/nj+PfxoenuXb+QI3g=;
        b=JLJXIwnMjaakCpnI3LWlfgVeghJjYnB6oCGt5KxAY+qLnOavnPR15x8REcWcKnVIfd
         StIwgngHEL9Zle8kJVSZqXxMg/gGzjYTS41KKs7yJezXOi9PMVhadrrlUKggEKcnVBNK
         IZ/YU2zdLhQM/UyYGWhPKh1AJ6JcBeWyTerQUTl89Qfdfeh6KEfb21WptR1WjLggR/eM
         5oMzXHo9S/6kRYYnKd9kxhXQwdWt9lOalyRcdO03HHnJruXSTcX17uiLbeXZB2RpMPFc
         RmMyq8tKUfeuvDwfOg/coMYCz182to2+8pkPRiupRYW/G74DcCaOPqu1UQD4/RaZJsTU
         Ja0w==
X-Forwarded-Encrypted: i=1; AJvYcCUkWJImjj1LfjT3/G7FHyy5drQTQD3nadN+m12bAm4TpVciLr04R1J99TEGeFX4Ff1IwEeCEoRdGvzxWi34YeAymabWNGMmoUN+k5b6
X-Gm-Message-State: AOJu0YyndgmCG5Bsht3F4h75mxopRJOtydPwC2uFoyeYk5T+iG/3DEYX
	sPwFwwmPK72xt4kY6Bo4XsoaDzUwsZHUkce41hYLkhr+9A2NkHVe8Ctc2WTCwKr+xR30E4dG/GC
	rwWzPUO4io9h2WgDgA1TLYrJ0HzwFIxg+8bJYjmQaX8bUg5P0pWBbtJMItihMuQ==
X-Received: by 2002:a05:6808:2386:b0:3d9:33c1:29ef with SMTP id 5614622812f47-3d93c07c3e8mr5459843b6e.3.1720622750845;
        Wed, 10 Jul 2024 07:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYFNo60WHX386FdDYkulq2RlUHLqK6H506/igBHtgzdpVY0R4HJ/zDzB+r5Z2zD/uJfYuagA==
X-Received: by 2002:a05:6808:2386:b0:3d9:33c1:29ef with SMTP id 5614622812f47-3d93c07c3e8mr5459824b6e.3.1720622750528;
        Wed, 10 Jul 2024 07:45:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b5a662sm20972631cf.54.2024.07.10.07.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:45:50 -0700 (PDT)
Date: Wed, 10 Jul 2024 10:45:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org, linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 2/3] mm: Remove pud_user() from
 asm-generic/pgtable-nopmd.h
Message-ID: <Zo6enCwreppncIel@x1n>
References: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
 <c31a39463929daba6c91917598ec05cf47103af5.1720597744.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c31a39463929daba6c91917598ec05cf47103af5.1720597744.git.christophe.leroy@csgroup.eu>

On Wed, Jul 10, 2024 at 09:51:21AM +0200, Christophe Leroy wrote:
> Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
> issues") added pud_user() in include/asm-generic/pgtable-nopmd.h
> 
> But pud_user() only exists on ARM64 and RISCV and is not expected
> by any part of MM.
> 
> Add the missing definition in arch/riscv/include/asm/pgtable-32.h
> and remove it from asm-generic/pgtable-nopmd.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I assume you double checked the riscv cross-builds on both 32/64. It looks
correct:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


