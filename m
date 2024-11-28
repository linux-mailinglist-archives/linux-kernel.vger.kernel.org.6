Return-Path: <linux-kernel+bounces-424404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A639DB3F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A6A166673
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26C1514DC;
	Thu, 28 Nov 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gpTO9RCM"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9314D444
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783392; cv=none; b=umki1U4WMztJiPIJXmJqcdW0Ikw3Q3vOh9g/q2pHdAPBdzvuW02C9Z4oVsC5Wnuid1/PGq9tP0gQC0Rsw6bHSiAGnsAtZCQB6D9QW3xwr0E3Ouc/EtgXkU1kt+1rxGyPvLDEzpzF7X/wAUjqRjplKhcvUUoaESgDvZ5zBZSAaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783392; c=relaxed/simple;
	bh=eD0BKTile3avGYgb6esO7NcB7LFOjudhnPBYvOtuu6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/63Lo42EfmI9AWhVjOFmx38mC+mrvUkgSz/mB3+3VwrRheRHjXPF0rB9b2whGNArVYVmEhyu+qW6Q6IobLuUUFGYgXBHb0ZUO/EmM1VRc9msR+DSuQ3GI7Odht2nQT55KCLmgp/nB7iq1HlY0tAuORFjRjPcKQO7mLZ9JuULuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gpTO9RCM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa532dcb470so31384766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1732783389; x=1733388189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMHb2Kr+9Gyds+XTGzQnx6NFjRgDvoBkrYDD0zxb/+k=;
        b=gpTO9RCM87lRTmvEUOFaWOz57bO62fWTAqgf0Bw4ZEXrYqHHa34J3LKUURTedXEeh5
         GAnrAmMAjn3lvlqVjXNOVZCkY4O8YIlalLkNu7frgvpOMPp+8NoG0xYnTQz9bMyNN7IJ
         Oo2aVsrnft/1cMgoelpO+U4Zu0IlicHtNlQq+P5E+uLLED/aQaYPEldmxeYuhUSQbobQ
         eTFYASwZBDCLrBPHUXuRUU4hAr0xZ1qqk+d+YSDEBVD4rzsWU2p2u17Ys9qMDfsdsckn
         2Y2RlOHHdMuJHG2t/1UIjC4OTldpTq4qQPbcRjC5dFqVI1/YnBKotwBhaQi/JCt2XMnp
         gNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783389; x=1733388189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMHb2Kr+9Gyds+XTGzQnx6NFjRgDvoBkrYDD0zxb/+k=;
        b=v2ZPsiZfSjU9VjJvTUbCiOVwgF9x/i0u6m9/NGQbtWtHvAitDmsFtmsvpqsBslQkd7
         H+fU9ZRpz+lAb05qecOS03FnJEpTSN1luz6PAe+ZxJ4aPAM/crnNvZTrx6fXcQHhkLRT
         IzaA98LW+lTumH48/PEtIwMSPr91ANma16FwSu0+509OE0wCBi6UxutFE8R/KXm6L+9S
         yWiU2bsmkzZT3wApei+XApRuHLdtP+hLWZB+zn2Js6ZINGhe7YagsmTCAjI8jx2R7J6F
         39iJTUmaA99QCWC9SvRs+dZfSladKynbPXrQi9p/CYrJN1bs5QB8+dfRWZ/clQ2ClZBx
         kUXg==
X-Forwarded-Encrypted: i=1; AJvYcCVB02ZYtfaCppLsgXHjDEQEu3fOa05g5unAnUwqPtBSoEQ2EcYGJPZ9tfo5AkWESN5qYttqeKmD/Uzj8E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJ02Wfohjpe2PIZc5KHKw1yg38U2926370WhQ/7mQLzGVP2qT
	s3snlNYDrK47rtO58BOAbXrqZMotUIhtTgJCLaApRavybpoPv08wW+CytNKtb4U=
X-Gm-Gg: ASbGncvB4ZbqHXwQnz+j0OftANoYGK+rzozhMVkJDn6Vh2LVtaA+pX9wkiLFYLpYJdj
	6gnxaZB40CoZjoxfnPaFvZCTbTquTayV5/HqBy8072bNN0EcCYO6Q0T06AYgzW0sFhcUOy1xTJJ
	jfMSVQl3PfLYsmdHXnPtTCpQvwPDFyQtGPWxal1d8BpnH38Kp0W/8cZADCZLsQfHsvWW8wb6f6g
	eY1dSnxQ1Mbxjw3UrSCrdxSyuM1KEIcOQ9Zwc4/Ky26n0XgwFoIZLrDNu1U+kHVbWsw/7hRK6pI
	AcBjSlgOWUSkFGsmCqdob2ZQnaJf0LahxY4=
X-Google-Smtp-Source: AGHT+IE91WdNXINf1ttfiGq0DeG9vnUXdI7yQdKbewyZQW5Jp/++7K5EDj28/C2AmS8X01ObB7bPuA==
X-Received: by 2002:aa7:cfd4:0:b0:5d0:8225:aa19 with SMTP id 4fb4d7f45d1cf-5d08225aa9cmr4768526a12.2.1732783388739;
        Thu, 28 Nov 2024 00:43:08 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8f649sm493828a12.59.2024.11.28.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:43:07 -0800 (PST)
Date: Thu, 28 Nov 2024 09:43:06 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v4 15/16] KVM: selftests: Use canonical $(ARCH) paths for
 KVM selftests directories
Message-ID: <20241128-d7a5061ce8160000cd5260bd@orel>
References: <20241128005547.4077116-1-seanjc@google.com>
 <20241128005547.4077116-16-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128005547.4077116-16-seanjc@google.com>

On Wed, Nov 27, 2024 at 04:55:46PM -0800, Sean Christopherson wrote:
> Use the kernel's canonical $(ARCH) paths instead of the raw target triple
> for KVM selftests directories.  KVM selftests are quite nearly the only
> place in the entire kernel that using the target triple for directories,
> tools/testing/selftests/drivers/s390x being the lone holdout.
> 
> Using the kernel's preferred nomenclature eliminates the minor, but
> annoying, friction of having to translate to KVM's selftests directories,
> e.g. for pattern matching, opening files, running selftests, etc.
> 
> Opportunsitically delete file comments that reference the full path of the
> file, as they are obviously prone to becoming stale, and serve no known
> purpose.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Acked-by: Andrew Jones <ajones@ventanamicro.com>

