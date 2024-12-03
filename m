Return-Path: <linux-kernel+bounces-430238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8179E2E63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D768DB39CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED79208990;
	Tue,  3 Dec 2024 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKNNlHaB"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994FB1F75A5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262297; cv=none; b=CWwA3xfHYoS0lkdQ9teWpNcfKNG6q86eSK23FJ6CW005MZ8vS1r3MLi2sQzFlHoXHAXDpVtBD68z8Pzuws4gxB0hthO1TtIWmm34B+MJ7bJYJFqt93vc0lQjhyAmvg3oI2aCZULnjDti1iUbsEjf8NzkDV7FHWCxLaKnAlNRmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262297; c=relaxed/simple;
	bh=RaRshClhY4KrLtC1pJyKALI5gNkFNuidObb3rlxOKuc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTt2VifRY0bJGaJ5I/ZqM8nKeu70raBeL189HZip8aFnDjpAcmjguZ1K1XmRRpD7V8OnttsgIJtyJbyyUaj6Nsr9GzzORZMWiJ8JWfgXYIu14gJziO+lA+U1ABmGOFcF72l5EFe4HiL6YtUbcewdfvOx6o0A/CX5ruJNSizA2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKNNlHaB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7251ace8bc0so195580b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733262295; x=1733867095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xf5vjKYPPx2Ac8Z/x2a1sc7L/LY/sKKwAb+DY+th8Eo=;
        b=DKNNlHaBEkrsdcCB0hORT8CCI0RX2EVusMDbiH6NN2XqErgnLLymTF8Jbqn11197za
         T3d0mMLCQQ6GrVeZLYm4q8PLLGqytVMylf/GefTo6mrc1XsgYGrfAVkuamVt0nxjNmel
         +4FJm5/CnxSPwXGBrhfV//FT4O79l7cupFiWP1ke0du9Qkpg6xl/a/mUJDWSF04F5sLi
         Y0shRG0AmULN/hpYVPM1gbDVJfdLYHqklkt4JRYNEjKEJKNtXwZDy+egYPzQkAb8sY4F
         lm1UouENh/dPtKjdy9TQMVOxjapW1IlW3aSJD5e1RkA4tH/HFZ2TNjHMJX8jkk/K6v4+
         FBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262295; x=1733867095;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xf5vjKYPPx2Ac8Z/x2a1sc7L/LY/sKKwAb+DY+th8Eo=;
        b=b7kK54ZwW4RWjjxwT+0q8Zv+M2fvPnY5cxDFmsAftN3VPYlQrXMlLFWYUjx8xoeAUZ
         JtiTgOGzQ9/xxO8njnxQMhifoaCVgUjNoZAUb9YEfg2CuBKHwtPSKhp8eaNw4bFnzoxW
         OPLtUDTXwbw1DptBwXzeyDzyLm5Ua2aPPprl/F9YRSSitB+zJarZ9IhxLJQSntzEypHP
         DDEF6doAU0GWX99br2nQK52GK3gWE852yBQda68XuN2EGhwZ16SbUTt+oWZYXJ7GOnWR
         YPanLjY6qoPi5ZqByPMiBxSDOsS5mPCyqNJjNCgZIdIyvZ9j4ETk2Oo5oXA8oEaOl8VY
         6JxQ==
X-Gm-Message-State: AOJu0YwN1pFePyC1y/yEM0A342Tcep9ufQnlmCK4DEKeZG9irAlx7FtM
	GZgQZTNkKtzIuCcvxFhtKE+lMcEjMoIWCt2bmNuCqkXnIBrwaKE5
X-Gm-Gg: ASbGncsZxRtQEVr1ycS4INkrd/Fm3cbKYNNDroqd5tbTfBt5jGYfnmBpYd2k4Ra2R+T
	yXvo5Y3jnbOnWkPCStrG+zukZuBYES4p/xfQjPLOYBpWgb/RIoHtHgSbA2dV4h+EuFef7naf/Uj
	kRLBIA7ALWwcHHjghBiGM/2hsXoBp8R4LYPYCZhFFaLGG12MyzTJTDpHz006yQ2v6Tk4xFfBN3G
	xKqS6AkkorFk3ndgL2MH9AXzC96Gb1hsZgbazLVwB62UB/ETVMm0lGPf/IEl/Z3890miQiUxwFr
	FGbTOHq2LrLdRUWSZMw=
X-Google-Smtp-Source: AGHT+IGXAzBoLsm4nq9TP7u0h5KWxHe0yGv+SK4jcpVhgiu/OjXsXaNSNLM4ROUlCD58SwZxgHirjA==
X-Received: by 2002:a17:902:e743:b0:215:6c5f:d142 with SMTP id d9443c01a7336-215be5fd2f8mr54723325ad.20.1733262294783;
        Tue, 03 Dec 2024 13:44:54 -0800 (PST)
Received: from DESKTOP-DUKSS9G. (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530753d15sm92216385ad.52.2024.12.03.13.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:44:54 -0800 (PST)
Message-ID: <674f7bd6.170a0220.72078.c192@mx.google.com>
X-Google-Original-Message-ID: <Z09701IR1DF4sp3V@DESKTOP-DUKSS9G.>
Date: Tue, 3 Dec 2024 13:44:51 -0800
From: Vishal Moola <vishal.moola@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v2 2/6] mm/page_isolation: don't pass gfp flags to
 start_isolate_page_range()
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203094732.200195-3-david@redhat.com>

On Tue, Dec 03, 2024 at 10:47:28AM +0100, David Hildenbrand wrote:
> The parameter is unused, so let's stop passing it.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

