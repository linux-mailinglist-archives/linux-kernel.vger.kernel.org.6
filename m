Return-Path: <linux-kernel+bounces-441496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99E89ECF39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BBA2810DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E801198A38;
	Wed, 11 Dec 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Toi6SJl1"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C46246343
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929256; cv=none; b=cCGChjqOeUwTQL0xoSa3uLxNx3+y/wc+9TtU0vpLpAuyFGBsKBTy+udkzObmxHukzfEn7Ye62gi8k3qJzwvFt0wtzGELUlPFU9qx1MIAUGcSETdrmS6ZnxzxicB0b/IpbFPJLEirabShIAlWXAcIuwFyGNXoiQXSlbjmUNpgYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929256; c=relaxed/simple;
	bh=tLszuGjmr5DmRzuJ37tFeyxJiAHTkhXYikVmA7/gTV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH9jSnB+X8wB9o2ySo/e/iWfsN83k4qXzRuBthPLe0dEdJzYfFRef2U9enKRtW/eVoTOqFG+KIIby09pqIgE0EUrqNYa7MMdIDAV9YlgkPfpvyu44Nojn98rjLOhm5+YKccIFGr+LXzfhypwTBMfR99b5E5tnn4f7exJVlen89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Toi6SJl1; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b676152a86so71967485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733929250; x=1734534050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrtmwbffSfZyT6YxRWc9FPtrtY5w8qbaif6a3GhziHU=;
        b=Toi6SJl1+npOzcW9+TeiwHI0XkmlgzC7E9QHi4dIhLCs3M2nlMP06dauO2Jq0phb5Q
         k/3Y/bxm4sspN/ruZxUdywsywb7kYJ8xdPRy7uS99AwnCvUAcHkR7skAU9wg2So4a5Ro
         BJUtlrPtZGrqdddLLcwv1agZ4vW9cVlBmqfF63sJMHRxwt+Xb3C3F7SCyhVrHOlSECUd
         i9h6hOuDyWCBPq2QaVxN78WUXl79Z0rIJPmrkuzAH992pynXaE9PlUUv5HWKTFVz17Ov
         Jg4k2SGAiqylDcVRUxVed5Vsezx6v1ElbVKErzdnW2JkWYUITDDPSmrKqimS0h78bssn
         0swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929250; x=1734534050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrtmwbffSfZyT6YxRWc9FPtrtY5w8qbaif6a3GhziHU=;
        b=uMdvKMt5qHLXc0IX4MLt31PwgJ9mS04oqVDPEdcVCVNajY42+2peW7UkvGHqxJkmRe
         TeyeVTX3DwbKToKTEvy9xS4+RromHXI6MTSyMRKRlvk0ZjXTQP01MoRYFmJRjnL7BsvU
         2CB6sBvDj50m/fS98XtakyAfggBQK4xKc+WOCT6Phvs9z2d1JXF4VB1u53kigPa675dY
         wjg2uuQN1yUFdS54bN3OpaIPZoza+suUrS6/uWow0p1rd2f1MH6LhmODYAGNDwil0JiB
         1ULM92s8SZD50NhCKH6R73KDjZVR3J5nxAYYtvHMuZup14On78wfB5kt6hmffutwODOx
         PvIg==
X-Forwarded-Encrypted: i=1; AJvYcCWhSavFSq4hSTC0Vmyr73PclrtqhK8ulwavqz2hgEOdGCQi5J1wOi6fLzy6mcY2gYslPgltC+OArS2gsAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16vh2gqWRKLiOJgGEtMPwKVOLI1PEqfBkvk78kAaviiG8QaUy
	vW73KYinjKj7PXNcI7fpLyM/OhcW0BNUqmJ3gpqNJtVFrq6iej7ksQzsFqc6NBE=
X-Gm-Gg: ASbGncv56AFMRhJ1oXgOrGkKhhAY9zQMwn7NQQJwlwQIHj4L3HeRSeeNxZMkOa/vjHF
	JFVXKxSQfpqS7GDSRc2JfT2mPALRJwKOFmIGALTmUa+60Kt8jensbdp8DJd6AdVq8aIxhC1mdQR
	ffz1i5eu1peQqv3g9IAPyOTremcqLyMUJ5p0q8gojeP2Bt3DB9v5lRZY4IrPTyEZOwrRnp/KZqd
	VU2hOtGCzlIWZHd852w0tPDuAb98YnIcdS0nB9AO3QO4XhknpXmTRHnMkw0R68Fncvy4henFGzX
	MANJb9GQbP9EHo0vyt4KMdPvvrk=
X-Google-Smtp-Source: AGHT+IFQcbIbj/UVOC6lgBpyonYbHxz3lu1y3vK9mVU+Waihpf9zpnAftHXTy27rea7DKFP+zHsrCQ==
X-Received: by 2002:a05:620a:4488:b0:7b1:4a2a:9ae0 with SMTP id af79cd13be357-7b6ebc2ded9mr501476085a.9.1733929250259;
        Wed, 11 Dec 2024 07:00:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6ef71409dsm29466085a.121.2024.12.11.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:00:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tLOCm-0000000ADPI-0U4U;
	Wed, 11 Dec 2024 11:00:48 -0400
Date: Wed, 11 Dec 2024 11:00:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org, x86@kernel.org,
	Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <20241211150048.GJ1888283@ziepe.ca>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>

On Wed, Dec 11, 2024 at 09:19:04AM +0100, Stefano Garzarella wrote:

> > After that, there is no meaningful shared code here, and maybe the
> > TPM_CHIP_FLAG_IRQ hack can be avoided too.
> 
> IIUC you are proposing the following steps:
> - extend tpm_class_ops to add a new send_recv() op and use it in
> tpm_try_transmit()

Yes, that seems to be the majority of your shared code.

> - call the code in tpm_platform_probe() directly in sev

Yes

> This would remove the intermediate driver, but at this point is it
> worth keeping tpm_platform_send() and tpm_platform_recv() in a header
> or module, since these are not related to sev, but to MSSIM?

Reuse *what* exactly? These are 10 both line funtions that just call
another function pointer. Where exactly is this common MSSIM stuff?

Stated another way, by adding send_Recv() op to tpm_class_ops you have
already allowed reuse of all the code in tpm_platform_send/recv().

Jason

