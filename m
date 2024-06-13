Return-Path: <linux-kernel+bounces-213200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB5190709F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF5F1C2329B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCD013C68A;
	Thu, 13 Jun 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqSx6spB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391282C76
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281747; cv=none; b=SYeI9NI/fo1BecyGw1YGHCo0f6YIz95ww3XYtSVgUtbb7x5EONW1ExWe9x9pHWbAA5GpgDvSICpwHi8g+WRvkJ6yoX00yFWT9Rugs/cULf69LvRZ6vhZWSdbRY/FYIturU4IeVfLf/fPaKxTWj+BmFE54Mqr0L0j8c+4gEuxeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281747; c=relaxed/simple;
	bh=ZQr1/K4f23/ybKQFINkZ4Mvh9i6Y52jFysbDIWiMqSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emI3iF/vUYRpBp8gxS2jL8nA6UPNdjWrxWctt64V0WF7a54Iio338cJHVGTYHyIGGrEwkTfFP2Qz8esenNb78dR+/UxbgNq9ROAJavntN6i6pOcALPPToCIfQ70EreuKSQxHgAilYn8qtIZUSJrGOGoXmglnUTocpieI4w4m6R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqSx6spB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4216d9952d2so78475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718281744; x=1718886544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0fEuFqzalyC11tgCJL2olWAZeSZgE1wRxfqpcISgXM=;
        b=CqSx6spBXqMrQFwplmHWhoi9JDNwCuIDuIB2vLALHYm2hTZQU+b0N8LX9/pul3r9Ko
         HJ2KbfYcsa3olXVNV4e6pO4anpKVl0xGafvKhFj1rDitmVis+i19T4+jN/pc+1bDwLGE
         vKsEcgt7cyHAS+oimIwGYEGS0pJarTE3/ufdHEQwEPZ6MsrytMmdft+je/daSEts6z9g
         CKDJ843oSroGTy+iGGxtsCeP4qPrIU3buPg/ck1/wNX/+uXtLuuKQFcwnp4ithn9Z83W
         fbnvUO2vWISDdOXIHJZQIIPtAsmNqjjQuxq5hdYskl+BFfh4nvKY7NX7fj0dwa2rakUQ
         bDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718281744; x=1718886544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0fEuFqzalyC11tgCJL2olWAZeSZgE1wRxfqpcISgXM=;
        b=TTeYXCsyEQjYOixRUahXEAXKcFVD8eIzgQI2v9pVo3XZZi1JsdL6BDb5JOZNMvrohn
         cJC4N1ZmQBNbDVMO1xGfVo+mu/2ognezrmgE5BEI0yPgrKwzZk+ZRRBOuiwq0a2/yNK5
         bG3wHn1fADWvow82DwnS3H2hGUZ7zTJeHyg7Bk+u3Mg/p2N/awe4EAs6G7E/ERl+os0l
         5k5nmJ27f54iARETbHgPWwNaeV3S7qjciMpkp2tHLG2IyNfmPsbUJdcHorzba9qY8jRh
         9YpW5onZKdH4TJZwwv8+wwhju0zA5NT2BPeUBh6o7vU1yr2Vo7zaniI94QWrS0NQStSD
         bLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOqkQxLon8GPisFFsUk8wHXWYhtGJMX6W0qx/V/r9/M7ciiaJFtvzEOGjLSH2meudtuFj+3yyiYnywnsXCZwxSiMDVaosLiSvzXf4/
X-Gm-Message-State: AOJu0YxpR2LGM2t/x5mTTEDcZIA4hapvoJGZ3kFFdEg2Aw6ELUzrx6WJ
	bxqTF/AejbskpnPJgo1Qqn8Hxuxa355CdtSB3lf1Y/mSEzkxwYdAYMlj2y3cEg==
X-Google-Smtp-Source: AGHT+IEYwF3dbYa8WWBR2FOETBShap+ZaRRBpIecfX014Bk1dlr42J+E8CnlmGuDyWnxRW8ohwrAxQ==
X-Received: by 2002:a05:600c:1e1c:b0:41b:4c6a:de7a with SMTP id 5b1f17b1804b1-422f2aba180mr1330895e9.3.1718281743540;
        Thu, 13 Jun 2024 05:29:03 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca390b493sm133521e87.161.2024.06.13.05.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:29:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:29:00 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, suzuki.poulose@arm.com, tabba@google.com,
	will@kernel.org, yuzenghui@huawei.com, lpieralisi@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/4] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
Message-ID: <ZmrmDHEoZoOXmSd4@google.com>
References: <20240515172258.1680881-1-sebastianene@google.com>
 <20240515172258.1680881-3-sebastianene@google.com>
 <ZmmxBWIerq5Durve@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmmxBWIerq5Durve@bogus>

On Wed, Jun 12, 2024 at 03:30:29PM +0100, Sudeep Holla wrote:
> On Wed, May 15, 2024 at 05:22:56PM +0000, Sebastian Ene wrote:
> > Handle the FFA_PARTITION_INFO_GET host call inside the pKVM hypervisor
> > and copy the response message back to the host buffers.
> >
> > Save the returned FF-A version as we will need it later to interpret the
> > response from the TEE.
> >
> I don't understand the context of the above statement and this patch.
> Did you mean use the saved version to take apt action/decision within
> FFA_PARTITION_INFO_GET handler. Or is it just missed cleanup ?

This is a missed cleanup I will drop this part from the commit message.

Thanks,
Seb

> 
> The change itself looks good.
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> --
> Regards,
> Sudeep

