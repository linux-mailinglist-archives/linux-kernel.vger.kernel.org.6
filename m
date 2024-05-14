Return-Path: <linux-kernel+bounces-179112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB098C5BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9B41F22D66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CCF181325;
	Tue, 14 May 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZfnpfGN8"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1D180A9C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716336; cv=none; b=fkxFIffT9Ln+bvGsIM6unhQ/xt1ndwAcXqXDGMrcwv3rgHj4UyljYaN9yedWrg+lcaQp86iDFok4R1ufEQG/KTvyU5VLnreeG8mG6lp1G+9MOxDy356OC3OEH7qSX5vTyX2ap8MODik3agPa8OqotwsUYcuOp7tCf6HYLeQv6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716336; c=relaxed/simple;
	bh=sZP6tHo+9CZUoeCNklvRvOlqbMBw89gzuROoS4J3Mzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqSQokXdmrYVTU7WhV352/A4s2qHLeK83CUTx1i4ATNKdAp7BN0m8HDYc+OtX8KFGu/rQQ2TZinWpj9SdUIJCmMxo6a5iag6lEiUkNATk2tVjuhexQDLI1/niVofXsSEfCVaeB2GeQf5DyAsrOYumLDWFyDPQ7givSym61af/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZfnpfGN8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ed96772f92so48483545ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715716334; x=1716321134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh5lqeIFxmDIv6drPBD1UeOlHcOcbwmzayc2S6c55cU=;
        b=ZfnpfGN87jzG0rt/lfhe7vQg/eTCzaodROzOlcQIx6Vet6mWXxV+LrOwJQblYLeni/
         dJGrz1RnoNb1mWjELi77HQlSyyf24fbpmVjwXGl052q2NvRXmG4e1GlPytFtJhtpAEx1
         B0izW07S5S2J58Qg+Fj2123oqlSEPnqklv1WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716334; x=1716321134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh5lqeIFxmDIv6drPBD1UeOlHcOcbwmzayc2S6c55cU=;
        b=Vf0XhImmkyqLduS824jofAz5d6R5PzBbJdmsgDP2ehqlSy3pq07cqBrWIccFAtOr2S
         JTTYAuqIRq3slPnOUOxhhACD6BKZ/ki/YMahmJwKyP+2aWcx3j4kpCHGHUdDVP+rhTFT
         o0ygZfG74qzvz5DmBNft1eUf/yuMwNVdV9jthOSZDgjU99U9XnADXir0fgvGmt3ywM/3
         nSMegLXmxYYYrHqBQFCtTyq1PWAfkYNaJDUJuqWg2sn7tYSE+yE2ioeEmJUqU04neDXh
         w/Bq4VRQ75xSMTgddRTYuHyfW03EdzNU3fnRUd7NxJO6Drit6efzcNKuUgf44g+TXycm
         Otig==
X-Forwarded-Encrypted: i=1; AJvYcCWcl+kUO2wjLPrtIZ+vZaELNJzjS9tbsI/5lUGg2T4P6AIGX4VITIxYKZrtDFROCDUSxQertTNoyQYwyuXN7Kw5YEh43xJ83ORjbPVt
X-Gm-Message-State: AOJu0Yz6Oi2vty5NtKPQiDUX50HfeMBImSH47gXrfMPdW3p+cclMn3bA
	fMIl3dfVucLXuL8PxwMdmfgXmlnSjdRcP8ifPv8VMw2ysbJBd2+50uS+mibHiA==
X-Google-Smtp-Source: AGHT+IE4USN+kE7T6RZD7G5inzqpecMh0wnrqgy4EQ6oLTRU7SRnjNyHXsSdHHrK+4e8wMQQLJM0Rg==
X-Received: by 2002:a17:903:2290:b0:1e0:b2d5:5f46 with SMTP id d9443c01a7336-1ef440495b7mr159207695ad.46.1715716334549;
        Tue, 14 May 2024 12:52:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c038c4csm104274535ad.226.2024.05.14.12.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:52:14 -0700 (PDT)
Date: Tue, 14 May 2024 12:52:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeffxu@chromium.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	corbet@lwn.net, Liam.Howlett@oracle.com, surenb@google.com,
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <202405141251.8E9580E@keescook>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>

On Tue, May 14, 2024 at 10:46:46AM -0700, Andrew Morton wrote:
> On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
> 
> > This patchset proposes a new mseal() syscall for the Linux kernel.
> 
> I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> of the total lack of Reviewed-by:s and Acked-by:s.

Oh, I thought I had already reviewed it. FWIW, please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

> The code appears to be stable enough for a merge.

Agreed.

> It's awkward that we're in conference this week, but I ask people to
> give consideration to the desirability of moving mseal() into mainline
> sometime over the next week, please.

Yes please. :)

-- 
Kees Cook

