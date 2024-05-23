Return-Path: <linux-kernel+bounces-187958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A12008CDB39
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4591C21314
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A484A50;
	Thu, 23 May 2024 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4/jdE9G"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20700535D4
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494975; cv=none; b=Y17Mrv63AGt7mXSH7W06WG8v4AObc3s71FljQa1pPMw1IPqBtjeLw1r5GTQEhERrgd97Ml3zkOljG7NPi5FCv+DzIUuBgu7kls1juzzorCpjC0O0VZICqgWRSQ3ceLxkNZ9Nq7u/AOHt532EQxvthFgeeVcxdtRyH8KNS7OYQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494975; c=relaxed/simple;
	bh=ArJMrCW5f5eOOzqibuD1JnKN6EEAQ7gxEaRMKdMQfu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxuOLXx8WqkCgs0ZVeqH2lKOO+XcmFEnfmFF9Jx1zAxt2RWiiZgtpMtDsuclb6GO0/2BgqEajzXdJvJHbU1FgCQsL9z80M2qFcEesKuiehL5RCaS7jkh/LlghXv7dFLQ68CtnAttDlQl6jo9oyg/tIDXsz7HIXFJvB+fG7P72gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4/jdE9G; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-681907af6a8so122745a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716494973; x=1717099773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a0MM+0CT8+BMBh2MswpjwUs4gOrRefAii9GT8UvAhVk=;
        b=i4/jdE9GyitD4URvrfNiIkRMR0jNfmalJoqS5FRYOHPZ/iuOOaVF2fCbmls/37ztoa
         se7W3FAi2m9zh/RIA5mnWTf14g94JGz+KwkjnIxGCToWsSh6Qy1CqiBnajqN2wlv38kW
         fT2O/FG274wBNpA2D7geyPXYBeRidQidVkjsXESwnC1fztetL9AuSuFYAbzyjXholzST
         eOdedgONMR428gD0rCOBfnEK7tneA0jj4KaWoWU3+i+mPU8fbvBCp+R0Vs8sKuKQh+t0
         OS5nx7bhFMY/VHEua9cgUiqqy6Ow4IIxikALb4z7pSkdSYf8VmfPEbnB0QE4nZ6gct7C
         0NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716494973; x=1717099773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0MM+0CT8+BMBh2MswpjwUs4gOrRefAii9GT8UvAhVk=;
        b=XSeTmvm+SQT/ZQfHdwSrcdXhFhzWFmwPHY2WUYwYskqjuFXMfXXMuyTIgV7XvSa0T+
         l8DpTxtHgM3Lv6OX7RR84er4iqZ2v81/D73yqjlWZjo+MRmWfyVUB3oU6BDe+/V5UQoY
         pLP/JNO0Zv7wJUo+uHs7HNXL/K7+69GUowdqvP7PE0XQoo94JV2jtghT5SDS3KIv7/Dc
         XK6kJ9REPhbYqT3DaY+N9e9ndbqRswZv2jdgcYco7B2IJEQ3hourteilEMhoy+p9HF9J
         WuhL8ygUROiuBO9lfozQNvqD2DC6hudVWmBm6/NrEW5iqit8T/qbM8saKiuAvoed+XHv
         6McA==
X-Gm-Message-State: AOJu0Yz7wAK7N4XEKorl1Z15PjupHt47sw2dJOYNIUYLItjmiaUDbT6Q
	gxyvKJASZs25+oFkhpwjAR5/M9nlJIyxnsPYyxgo6d9tordkLi1e
X-Google-Smtp-Source: AGHT+IGHdCZIQCG/QbmeWRpiT/DPFT1nlMkhoDyqqmneclDYJu4mY5OhR2rJJGHLWaW31QwkSv0AXw==
X-Received: by 2002:a17:90b:2397:b0:2bf:5793:630b with SMTP id 98e67ed59e1d1-2bf5f109e47mr207277a91.43.1716494973258;
        Thu, 23 May 2024 13:09:33 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdda14e538sm1957193a91.49.2024.05.23.13.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 13:09:32 -0700 (PDT)
Date: Thu, 23 May 2024 13:09:30 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] gcc: disable '-Warray-bounds' for gcc-9
Message-ID: <Zk+ievkF4huCOtCt@yury-ThinkPad>
References: <20240522225830.1201778-1-yury.norov@gmail.com>
 <20240523130026.c57a8e1e7f4140d2642c84d2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523130026.c57a8e1e7f4140d2642c84d2@linux-foundation.org>

On Thu, May 23, 2024 at 01:00:26PM -0700, Andrew Morton wrote:
> On Wed, 22 May 2024 15:58:30 -0700 Yury Norov <yury.norov@gmail.com> wrote:
> 
> > '-Warray-bounds' is already disabled for gcc-10+. Now that we've merged
> > bitmap_{read,write), I see the following error when building the kernel
> > with gcc-9.4 (Ubuntu 20.04.4 LTS) for x86_64 allmodconfig:
> > 
> > drivers/pinctrl/pinctrl-cy8c95x0.c: In function ‘cy8c95x0_read_regs_mask.isra.0’:
> > include/linux/bitmap.h:756:18: error: array subscript [1, 288230376151711744] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
> >   756 |  value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> >       |               ~~~^~~~~~~~~~~
> > 
> > The immediate reason is that the commit b44759705f7d ("bitmap: make
> > bitmap_{get,set}_value8() use bitmap_{read,write}()") switched the
> > bitmap_get_value8() to an alias of bitmap_read(); the same for 'set'.
> 
> So it seems that all kernels which contain b44759705f7d should have
> this change?  If so, and as b44759705f7d appears to be in the net tree
> then the net tree is a suitable place to carry this patch?
> 
> Or I can send it into Linus this -rc cycle and things will sort themselves out.
> 
> Thoughts?

This is a real build breaker, so yes - I would like to have the fix in
this -rc. No preference regarding the tree.

