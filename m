Return-Path: <linux-kernel+bounces-439758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E6B9EB3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3401889718
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A791B3933;
	Tue, 10 Dec 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WPTuXQXz"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48211AAA20
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841629; cv=none; b=fhPNj+21dQpeWRnDtFUvx7Je++ytxk9bIccJwamkY1xPZi4lc4JzWJmu6iqPNCWimSBQbRwFp4myOC+RJYIXDL7iIGUzdru2IxRgeMXpT+jZb4QM6K8XvhR3dFJMU15sNvYxWlNzUgHMfE1TG3xnwurI6wdfP5Jmvd1TPBxd75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841629; c=relaxed/simple;
	bh=JoIVFUb4lqiuj92k/cmstv6/5QcjCYKPkCz58/ijs6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaMnbeJg0ZqURqgWsk4RbH2MV+GiLG61b6tJ9fyz+c2H9hbsOOxa13SYiC2EjC4XCmsnF1IUoL0mEYr0R7NrOCslkuIjYWbwCQyFJBzj5chByAE8pjlIWI6qA1GrtDpeaW7IOYVt6rCPKPxOqkZMveFmz3HHoa1FeQNHPOUDpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WPTuXQXz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4674a649083so24431371cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733841627; x=1734446427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=taRWKmra+p/mbT7xIVp84lXpkBlUdolqun+ITMGMMTc=;
        b=WPTuXQXziMlHsrLczT8kwWvWQGLqjT/KnyqLoTGt4K/afL7l6qA46PQVReK5QKwdX2
         fD4It1RI0keA41ovPRaYXRcH5YxyF7qhZLZ9k6aEoZ4tEzNzzT46mp5cFQtl83C+0b2T
         0tOdzi+oo3MlUaKb4NtvhEEqN17/VEndh7uBOZ472VZsuEmezWNQ7wa2sM2dvze53eVM
         7WfY97VrUchwiXHLQ30RO3ytnNHreoJ1/PJPtsUoIrK/1sfY/DzQ9PrFw2nEBtC40+5S
         qH5qMTl7fkS8DFjqPqVFqVuIb0Xbhd1mpdVzIpYQKWQiWU8u0sYJDDD/7VTqd/CW7qVh
         3AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841627; x=1734446427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taRWKmra+p/mbT7xIVp84lXpkBlUdolqun+ITMGMMTc=;
        b=jbx2jpWnQyeeyrcPlDOJWrez1dIRPPFXpWElKuMUhpEYeaWqIfSduh3cGLcBLx3P73
         uRU24y24kN5fEvoSbYzYrGAgYf7ay4fsjuMTzj4ipZgD3EJvNb8A6DVABP9X+2iOFWs1
         kOAK8uBoaYQKaCP9mwmjGbyw50btTvBEVF5MptDkOC/d+ILHxuP4jF5aDobFLoQgb3wZ
         4iMJ0jELMXAo7vPekAV3IZYowNIZeinHSR/ca6a9hmlqT4o+34FA5rglc0BwhK7GRVSe
         zA0RWXihaW3Z1I/BI+vDGihdiG6SjTexX2SEj+YBIPIZtf5Gq3dnqmyDRdOYXfNz114X
         W0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCV41ILTJRhPzkg88aEFTMflqwWB7V8uCl2iHP5uuV7pdyyCzYyEPyerRzfJRhRtIfw0md6j2DA3s/HCGUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVRTrkuC9XXpu3tWACqtZ9ea4QrsyXcQkg26wVVa/o2jeVM/Vx
	BVIFlKMa3joT8RmVNSxu9skCAp3coNSh/piozfwgQWA6ZToiSAZ7hV9la08USNI=
X-Gm-Gg: ASbGncuR4hRwfYNZzFLGimzjSU6mDXREpD6YKWGdB5z0p8XKI4gLMwurfuURkxonilK
	bxOSJZ7bK+b9+ZXC0xKUqbqfz25H2/GlB33o6dPwD9pbFX7Try7ysjc5kSP0SQ4eDTZbFzMvsQI
	sZoT28iyfIHwHqGyzYw0UhmLMMrGRqAqslWzQ8yFbWpf4Xv2y1jo/2AUamn6tAMeq9o8Q5zSy74
	+kctQYr1CrSk9mKoLkfgbTx8u7QCYCrYnSTtSSsYW6E29By+37QixM9C3NOeng6Zb6nRjiOBONv
	0NPWIax2GIpATuF+mxkhEk/il7c=
X-Google-Smtp-Source: AGHT+IFkLP9MbL2WiKPj9SIjMVoZeZhAPlq2JNQ88ChV6UcoHjYV2Ck4cRh8p9LeNsUH6YMFLbLSZg==
X-Received: by 2002:a05:622a:98c:b0:467:4c21:e396 with SMTP id d75a77b69052e-4677205d427mr91007131cf.55.1733841626900;
        Tue, 10 Dec 2024 06:40:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm26750421cf.30.2024.12.10.06.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:40:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tL1PV-0000000A2bC-3DVn;
	Tue, 10 Dec 2024 10:40:25 -0400
Date: Tue, 10 Dec 2024 10:40:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <20241210144025.GG1888283@ziepe.ca>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210143423.101774-4-sgarzare@redhat.com>

On Tue, Dec 10, 2024 at 03:34:23PM +0100, Stefano Garzarella wrote:

> +		if (platform_device_add_data(&tpm_device, &pops, sizeof(pops)))
> +			return -ENODEV;
> +		if (platform_device_register(&tpm_device))
> +			return -ENODEV;

This seems like an old fashioned way to instantiate a device. Why do
this? Just put the TPM driver here and forget about pops? Simple tpm
drivers are not very complex.

Jason

