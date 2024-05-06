Return-Path: <linux-kernel+bounces-170241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAC88BD3FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0026B1F23351
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5CF157E94;
	Mon,  6 May 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CF041HXr"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93A15749A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017442; cv=none; b=BhkRmo0ej/hVCWrWkK4vKIxTyZqKgZCAfKlBeZl5pVijpaC9iLlxQLzPe2FANtzIFPTSsud4wVcBbCWDz2QvVFGWSD3iSX939N4XjtdlSETEBTbvw5TPxERr050SmsvXOYC5e9KWm7/wOxctx/X5Sp5oH3f6cqN9EJE1fg7tBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017442; c=relaxed/simple;
	bh=NrQdyQAmxtGDrr/un2msxGNjav0moWDiCcc8IHL04QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnszKlrS+XsQOBdfaw7Pi3YfOboTm7K1z7zas0t4hrd/Uujg4UDjHibDaBFQ3EYGcQ5giZurT+ljqnq/0pSyxGJ1hSnSeOFpGO4x6jN8RZk/VtvdfWt633czKDFZCd1ePiORnGYObKqjAAeu2kUQao8NKJrh1cjkcqq7hx+X4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CF041HXr; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23dd4dca5dbso1022171fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715017440; x=1715622240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrQdyQAmxtGDrr/un2msxGNjav0moWDiCcc8IHL04QU=;
        b=CF041HXrrPXGfxUu58vlQv3lFaMywi9n3PsXrTeF+uLEUQ4A8OADFpBy8jULsKeekL
         bAP4dt56m7ZusIOCRcsF1mJ0Brp/3NtOwdjz3e5RcmxhjsxIz49TZl+Z+KZl8rf0K0lA
         1Ds0UK6gAEvaahfVG5VuV1lCtcqwpXDHGbkn4uYOeTjnnCc+axEtKmpAt9I3KMckgBRJ
         Zpcj8CL48A3+OuSSiIylxaBt48i1tUg67TkNmuLAgRMTQdTcUJWmG7WLnEnl6f/nnze3
         LjZUxbgOQFT8L54FqQ0f6d3Nl6a6z7YecC1JfqxtCi+f44ThBXyR+kr6SwHo9os6JXkh
         KlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715017440; x=1715622240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrQdyQAmxtGDrr/un2msxGNjav0moWDiCcc8IHL04QU=;
        b=WuY4d/+F3tikZSkn8fx0/G1Fb+mDUl+oWi6DabwFALKrXfQT9bARSth8kNLd87qviJ
         XRah62Mxs4gTRVzqX4SbOwSN5jvZ6Uf2nhCK9057080J/cL/VM+yTS3QgzVrewBHmajs
         7ZCmOhMgghl/6q4FlK+8maj/+BTa9qMxGgWazilgdYWm2EC+tomlKW3EHDrZgPTJKosl
         I7dxbvZdouWV9hOqvuY3hytUBmHHtL7BiqAKypezsZgql+3FqFHJRS438baoTLpg7Z/c
         UW7Sj+CNYf8Ig6i+QSGzhOkMdpAV9uE1ul6JGiP+YdPkkAFtc3tNpKuYiCxVwOEKnnw4
         U2lA==
X-Forwarded-Encrypted: i=1; AJvYcCXzVo7sQkNzPKAdVtKIf3oa1xkPed88e0lDAwlzkNFHD4dkXWjrJuKhFfCbOQR6OKgpTbvthk1AXOSKXN4YJu3jGgjr/DEekNOl9msE
X-Gm-Message-State: AOJu0YzMpdYv15K+S25tjW5wtZcChMLYuTzM1S/uyuwT91vD6DiipyBK
	IC7u6EAh1VpsERQ1LV88aw+xmMD/t91wl3sTpYvPkfHrdfKz9GwZxJ63ww34Bn0=
X-Google-Smtp-Source: AGHT+IFfws1Gcb6acoXVWBj5aeFUz+NzC1+evoEYOr7ky0Ifa7neFHPAAV511Z8X/ku679UyYkztmg==
X-Received: by 2002:a05:6871:3a10:b0:23c:49e2:bac2 with SMTP id 586e51a60fabf-24019c343admr143784fac.18.1715017439642;
        Mon, 06 May 2024 10:43:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id co13-20020a05683065cd00b006ee2fc97885sm2030608otb.72.2024.05.06.10.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 10:43:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s42NZ-003UHM-8o;
	Mon, 06 May 2024 14:43:57 -0300
Date: Mon, 6 May 2024 14:43:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, mpe@ellerman.id.au,
	tpearson@raptorengineering.com, alex.williamson@redhat.com,
	linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, gbatra@linux.vnet.ibm.com,
	brking@linux.vnet.ibm.com, aik@ozlabs.ru, ruscur@russell.cc,
	robh@kernel.org, linux-kernel@vger.kernel.org, joel@jms.id.au,
	kvm@vger.kernel.org, msuchanek@suse.de, oohall@gmail.com,
	mahesh@linux.ibm.com, jroedel@suse.de, vaibhav@linux.ibm.com,
	svaidy@linux.ibm.com
Subject: Re: [RFC PATCH v2 0/6] powerpc: pSeries: vfio: iommu: Re-enable
 support for SPAPR TCE VFIO
Message-ID: <20240506174357.GF901876@ziepe.ca>
References: <171450753489.10851.3056035705169121613.stgit@linux.ibm.com>
 <20240501140942.GA1723318@ziepe.ca>
 <703f15b0-d895-4518-9886-0827a6c4e769@amd.com>
 <8c28a1d5-ac84-445b-80e6-a705e6d7ff1b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c28a1d5-ac84-445b-80e6-a705e6d7ff1b@linux.ibm.com>

On Sat, May 04, 2024 at 12:33:53AM +0530, Shivaprasad G Bhat wrote:
> We have legacy workloads using VFIO in userspace/kvm guests running
> on downstream distro kernels. We want these workloads to be able to
> continue running on our arch.

It has been broken since 2018, I don't find this reasoning entirely
reasonable :\

> I firmly believe the refactoring in this patch series is a step in
> that direction.

But fine, as long as we are going to fix it. PPC really needs this to
be resolved to keep working.

Jason

