Return-Path: <linux-kernel+bounces-182524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E678C8C53
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B49F1C22222
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235A13DDDE;
	Fri, 17 May 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlf+SEjN"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDBDDDD2
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715971619; cv=none; b=l/HtapiJpdhpafWlnMGLmmoR7Wr+IG7aVs+R/AXXaVZ0DLx5Pa+GSF80FICVNe5m/l9pxXUJRFK4Ak8gX+HTPv9ye4AgUw11iKSo0Qzs4aR4FwCuyPnft8JJbFV/604EGYl+3eLDZzB9Q52LaeKf3lKWN1vmjEHO60HYpFB1+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715971619; c=relaxed/simple;
	bh=6gZk5G9ksuxMBjlE42/DbLKVatGkz/eNfmbiqI5K4YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Drs1vAdwPTLr/my1D0lOipFinP5Cyl95zhdyUd0lJOEhGMJnOUfk5X2ciP38qbcF1B04QXMBvVpOndi7cE+Nu4K/rzBrTDlwLEeM1QQSoeQrufiqv8YGaNC790/hlES60EVlYyIvy3OQr3NbU8CcE4/QOswhd2mxTMXO8xT7/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlf+SEjN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ed904c2280so16184585ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715971617; x=1716576417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXhAaCaiYyOHYqit9rnfiuIAuuuhWQ3ya3X2a8yBXBw=;
        b=dlf+SEjNQw925gwDJoDecV9JBpu9ohWACiiK6LpKyEjICP3uRRd2K13/rguXm4l4Dg
         wbhON/aH2kpWulRMSQKmdJmNwHB7+fXP23t5OMPxBbQ7hsKhd6ErqiaJn/Ycn94KLEAq
         aUV4dby+PscGq2qL6v5Q2VweFGGLnlzGe80V4A1Na8S2eit0NxLDA67Q6tJ6mGRex/5d
         EhKS3bsW0leqL8BVzSeOd0e8sCJdSdp8E4qx7dK2pIvc6CkjpGs96XMfPAYgpzWs6zgA
         iKzcO3+TY4VJD3ZKcxC+QzZvk1CQMWOIjbVueuYBohDlzs687F2zKYlhYgmK26vobNrl
         DVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715971617; x=1716576417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXhAaCaiYyOHYqit9rnfiuIAuuuhWQ3ya3X2a8yBXBw=;
        b=dPJ3cCZC4NiQ1oQzp2zx1pIQ/tKNytTQAJn1cR48IkoK5job3ufedlND7I0svZl6m/
         DFUQs+MznTUmUAWGz7jGlF+blE4ckCiRCM5aFex6nBv7GVvejJwNDxiL+0HP6VIK+aPY
         LlIXXwWdHS3CuIwSsyAkiKml/RzZilWh6BuybGD+lCLmWbrhRBTg6rIOIHtXTbAylAKi
         AKkTKJitm9vHC66PH1wgi3QOyDp0yJMUUg2grRXqU1LLs41tuKTjNF3D6ijCk6n54Ms0
         40jksK2JNpUbB3Cfbl5XIGcb547TIErIJdG5nSdM8MIVnnPw88dLIqwnDoj4iSTONi1y
         jFDg==
X-Forwarded-Encrypted: i=1; AJvYcCVH6X6zzpbcN3a4ipQs5p2nT17g4InSIPDWShE1x+3aZWGoo204a+cuOuEmWgsRKtxaKxCXF8Ho96VBb7q+YwesZGWhYA+gNJtbnaT3
X-Gm-Message-State: AOJu0YyqFAIQFUJVWWnroc1bRuLz9YQWUIDRyT6gpN9M6TZCycpfavoR
	z/eLO5YA1u5nKjMFwIgkWywoaR+p44u05phnobMrno4l7NtYBOq40zA10+Wm
X-Google-Smtp-Source: AGHT+IGuK4tlv6elKQLXlpqv9JaWkwcM0ZHTpJYNGXMIbwPWXWCLJmWYp8OxQ9zflGZIdBjxOs5nFA==
X-Received: by 2002:a17:903:2310:b0:1f0:99c9:c8b with SMTP id d9443c01a7336-1f099c90e93mr69759345ad.22.1715971616815;
        Fri, 17 May 2024 11:46:56 -0700 (PDT)
Received: from fedora (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c03646asm159891105ad.212.2024.05.17.11.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 11:46:56 -0700 (PDT)
Date: Fri, 17 May 2024 11:46:54 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] mm/hugetlb: Drop node_alloc_noretry from
 alloc_fresh_hugetlb_folio
Message-ID: <ZkemHlBorivxl5-I@fedora>
References: <20240516081035.5651-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516081035.5651-1-osalvador@suse.de>

On Thu, May 16, 2024 at 10:10:35AM +0200, Oscar Salvador wrote:
> Since commit d67e32f26713 ("hugetlb: restructure pool allocations"),
> the parameter node_alloc_noretry from alloc_fresh_hugetlb_folio()
> is not used, so drop it.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

