Return-Path: <linux-kernel+bounces-247780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1ED92D472
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129CB1F2295A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7AE19408A;
	Wed, 10 Jul 2024 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsiJig+c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71EC193476
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622631; cv=none; b=GnwoYTJuR/7BVyWLT9lOnuMATVvg7GUb8ggIvTh/s0GpB4TxchZ3Ny5uAsbYBGtvddtUnEwVgVN/y/T58mW+Sgn+gBKJZ7/0vyyVdm8baBOY66kToCMIupCD3QcgWVlW3a/U72tfIGMB9q4u7eDTi6clNZgOy9SVrO2AX3ZrmP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622631; c=relaxed/simple;
	bh=wxUf7+WncWeXLeiWfLfp5uqEz6LxO4feTNrN84VH3Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPp3XVIGPquhtUTC7qEMYLT5QxbyLtkyBKjHSneAf2YzR2EZLquaJNmx6r4gdVJTwq4JscYvZLlrmp4mwgS2TRlDOgGj1OCwkOmp0VlfOxYomj6XslzMwY/r3Bhbfruz2dFSABFujUxoIVzdGE8prOsEhIsDcC3FrpmsVgSSuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsiJig+c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720622628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvC/1briAqboclLx4gZNfSMQXCaqMLqhaARp61h92zQ=;
	b=UsiJig+caOeVUj1lqS+X54m05X8Og+0zgxdXNANBLkfbFw0pjbuVUw4WG0xpO778JTRXAA
	t8PW+7EBMUPU2gY0Ae2IpswvuAp0vMwn2JMs1RR+T7Ce1MT7doLEWcnb27kqTvOmW/QsFG
	NEDpY3xGSGp3yNZfNmxOqggyC8pmITI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-mnHkatc_PHujBBOSE2qf8w-1; Wed, 10 Jul 2024 10:43:47 -0400
X-MC-Unique: mnHkatc_PHujBBOSE2qf8w-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-25e8c18a7c8so750059fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622625; x=1721227425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvC/1briAqboclLx4gZNfSMQXCaqMLqhaARp61h92zQ=;
        b=WZ9qH1siV+pR/92M7mLqjvtM465Ml0N2cwh8BH+nyB6OuABR1bE4TVWlqmKDV7AWBz
         Zo0CifmxBmkUpMF1YGm1Gkgea+UVWLXWUdvaEUSFyNheqd6VAKSaWyp50iCxT5A6l/PV
         9UkGJQSE3Ju5aAAUUGTYWOKj5ahT631DGA5EJkrscoFZfrgt95X8Ok0oBNXGNKdWQnaD
         +FPrwUBG7jkfkkWjYM2RdQ+klyxw8+eO4uSq2zYshl6FVtV7kla7Q2K1HJhm3gdGx6ii
         z68z4iZfLtE1dE+Oi52haudPBxXJZhjLQZL+LRBVz3JtxKy/JwtrzlNvW+2FPjFLkhyK
         L49Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIz0cVGLq2J+mifN6p1J77BMQstiV7q8Au5LEEsVHzWfAlPcZ2ntqUASvdhD3d3AJYsOsAKHiRiFitcHd7BWR0WHmzZa93+lgu0GL1
X-Gm-Message-State: AOJu0YwmozlFWGdvJWE9Z7dTa9eyDWvov+W0+Bwy/cxPn7pe68SO2YUJ
	LpIAKo/euENaPVeybJXt/30BTiHmG0rVw4xX+S7JBo/gR42mxb+3F9APlQvEAfZFJMfICHlgQ3a
	HgaoydUdkaaPiAQz14PEMzyDoiBilJmTWDAQgmUkUO+toYTtYtgtrP2kBKF3MYg==
X-Received: by 2002:a05:6870:610c:b0:25e:180:9183 with SMTP id 586e51a60fabf-25eaecbbec3mr5784206fac.4.1720622625421;
        Wed, 10 Jul 2024 07:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTD/gcLKLatwoODGC6PBmZLpDHOquqnlFmI5MDo6NjD0BVLxBJxqbPHflFRf/y2o8S5g+V2w==
X-Received: by 2002:a05:6870:610c:b0:25e:180:9183 with SMTP id 586e51a60fabf-25eaecbbec3mr5784188fac.4.1720622625106;
        Wed, 10 Jul 2024 07:43:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19022e5dsm199404585a.57.2024.07.10.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:43:44 -0700 (PDT)
Date: Wed, 10 Jul 2024 10:43:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org, linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 1/3] arch/x86: Drop own definition of pgd,p4d_leaf
Message-ID: <Zo6eHVBcUyznRalN@x1n>
References: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>

On Wed, Jul 10, 2024 at 09:51:20AM +0200, Christophe Leroy wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> We provide generic definitions of pXd_leaf in pgtable.h when the arch
> do not define their own, where the generic pXd_leaf always return false.
> 
> Although x86 defines {pgd,p4d}_leaf, they end up being a no-op, so drop them
> and make them fallback to the generic one.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


