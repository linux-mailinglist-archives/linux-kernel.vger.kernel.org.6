Return-Path: <linux-kernel+bounces-518962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E666DA39673
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDACB188C420
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8C52376ED;
	Tue, 18 Feb 2025 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TM7IWVuz"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666323770A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869447; cv=none; b=uqH5rVgNZDSXb/ZYEIC3mDax/nxPXHX+oPBEVHSgbe9VpckbcvpMAyjutsb11W+n0vCylkdV45ZBNDc3G5qgAyXMLWqxnQj85sNK1R8Ff4ZVdKqP3Y9IsDma1e8jhhuMKKWjo83VonIZUwJAHKCAJmkLlN1Js0TFu+LLtniEoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869447; c=relaxed/simple;
	bh=AU+g46/CbMuyMB9VsiQa3jenuOKVgav9FO14zc51omw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km/DNLkzsDta8Hyl0PIgjfEkDvNfY73V9dSbTryAQ0vGIWw4pxJWw8UnXvPfDmmOXixd3xxlpSzmvwZjTLmGEBzNGGm7JthyGB8HfcycrvQEqVfygudxrdJrLrE2O8MfXRLZJqV7xU+Zrh8avXzjOygWI8bkPaEk0E9IuYVCxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TM7IWVuz; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4398738217aso15503625e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739869443; x=1740474243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OOuWtvfuWKTYVgnpUiEm2zwjY3WHke/k/7QdNEipwSg=;
        b=TM7IWVuzcZvSd7pn0/3NjDB/4rM16zC6u0a5PW1KGAmO/v4RmJ7K7Np/Eq1te1gm87
         r3DfRCtz0wiQUthCbeXnawateAxo3JxOMuwYvpC/fo8MaqGlmOiUtQ3T7NUx4MXUPhTA
         ZQ70ITwjQ0ICYrLQ1+V/sVf2OGSEy5onH0RtKVMrR0aBu40FvYNBgHXnubNb0NeSxnII
         vnRTXWqisIgAucnPGYZGO8OXKF/MWt3dLyFPlQ8N+DfbW5MmoPF3f0/O8Rt8wDTxyigx
         39l8fa4Pvw5Ul4+JOHuHVG4kCgIIJsFQrRyCRhdqvS2EqLXdVn+wYKYDL2VPH3w2xtOc
         9nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869443; x=1740474243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOuWtvfuWKTYVgnpUiEm2zwjY3WHke/k/7QdNEipwSg=;
        b=cvMbfXf7jeqO++/4RMLgEDysn563mZ1kO4yhXKQSdoSIgz870sMdcjnLOXtNONm5IB
         gbbmYpU8NRQ8cylO8dRcKMtL2Lmijb3x5z1cjy78n7Ao9TAN5+I0P7Henx5Ck9Qc3Qa/
         q/8m0tZd7xifGi9W2abCeNdHrL0u4qMH+kCgOcTHC+3vF9hntfQ8lZdjHgj2rrMi/LQI
         gPhLHRdrleSt7N4zlI5zsbjtMJ1B153jMn3HZPyzRgRmoJJ6KDh12DymkmZgiNINh6j/
         KmY71Vwh7QjUafzikGvCXe4fDd4qAfEfUMjAOWuSutBzBfn5CzpK4qWPUC0cH4tCwtyY
         4r+w==
X-Forwarded-Encrypted: i=1; AJvYcCUOrNOutRj3fRB9Oy7Bl3YZ43JtpzLmS6rOp9cwkwwFXPK4OGmhdOThFdOJZJjzp82lCEg55GIzN/Zp/yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5iAosYogdfd1qZveSS/G09/vdZG5cvkyPEnZkjikn3eZ5ETDk
	LfGJ44odZ53wu57QOmO1/MxTGLsAIeulqcpo13aIK8WrlthhFGpTAAf/gAt3AwU=
X-Gm-Gg: ASbGnctuXJt6bMDEPp+Ea6IDHkUPKVmvV4RDF1OFYPrldi6d8pBxrVBflF5ECIiKEqW
	J0Yrzf1ZxIkbQH73D1gbK5h4649guOYsRsiyGG4y/5ViFHtJ4RwCICEtsw6YkA0MAHEg1f/KjJD
	rzVQW6CjZdcnXTTtxwPQVWE89waMj7P0dusNi32nGfN64gM1lRfuffVXzeoH+sraHDvsUEbj63B
	URbVUeUXekn141SypJfogfC9ng/uxeUP+si/T8iyio6XBvSb2QGKa8FzKwrRMfRnyBXxml+hd4d
	T9VViGgnQw==
X-Google-Smtp-Source: AGHT+IG2nhkIDDAtinVM3Jx4QA/rzGqnaGj34iRwHF/a7XzoUFdDFjPd1BI+cElsZnPQNz0UhFlZUQ==
X-Received: by 2002:a05:6000:bc9:b0:38f:2c04:7a7b with SMTP id ffacd0b85a97d-38f33f27555mr9624706f8f.14.1739869443499;
        Tue, 18 Feb 2025 01:04:03 -0800 (PST)
Received: from u94a ([2401:e180:8d00:54ae:3b1e:ed6a:2e2:626a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55916c7sm84435935ad.243.2025.02.18.01.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 01:04:03 -0800 (PST)
Date: Tue, 18 Feb 2025 17:03:20 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Segher Boessenkool <segher@kernel.crashing.org>, 
	Vitaly Chikunov <vt@altlinux.org>, Abhishek Dubey <dubeyabhishek777@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH 1/1] powerpc: use __clang__ instead of CONFIG_CC_IS_CLANG
Message-ID: <lnq5canqlg62lga2bxzihu6ufelvytwwbrm4taihzewrpevfac@cncvdlbxc73r>
References: <20250218044802.17302-1-shung-hsi.yu@suse.com>
 <Z7Q8m4131_7K44qn@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7Q8m4131_7K44qn@kitsune.suse.cz>

On Tue, Feb 18, 2025 at 08:54:03AM +0100, Michal Suchánek wrote:
> Hello,
> 
> how does this happen?
> 
> On Tue, Feb 18, 2025 at 12:48:01PM +0800, Shung-Hsi Yu wrote:
> > Due to include chain (below), powerpc's asm-compat.h is part of UAPI,
...
> >   include/uapi/linux/ptrace.h
> >   arch/powerpc/include/asm/ptrace.h
> 
> There is arch/powerpc/include/uapi/asm/ptrace.h
> 
> and if the installed header is used this is what should be included.
> 
> That does no include other asm headers.

Ah. Then asm-compat.h not, my bad.

I thought bcc[1] was pulling the kernel headers like a userspace
program, but it's actually pulling them in as if building a kernel
module, thus include path has arch/powerpc/include/asm/ptrace.h before
arch/powerpc/include/uapi/asm/ptrace.h[2].

> Thanks
> 
> Michal
...

1: https://github.com/iovisor/bcc
2: https://github.com/iovisor/bcc/blob/5bc97bb/src/cc/frontends/clang/kbuild_helper.cc#L81-L120

