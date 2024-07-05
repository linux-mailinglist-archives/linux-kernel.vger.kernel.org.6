Return-Path: <linux-kernel+bounces-242712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44491928C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E352840F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21EE16CD14;
	Fri,  5 Jul 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VCigcpwi"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED69149C7F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720195469; cv=none; b=XRRCm7dqjR43Kxyt9YaMtFXs02n22G/qGntcKyex2joKKhLv4c/KuLwr6pWYoSHIB2tF7ZKJUGW6TJ7vgpZbxexwggtGv4WLL9CBBFiOMuD+Xu6ykDQW+B92DahTC/52dgBdwNN5jt534FklODu4tb3Kkxm7L/LIUq/l4wzzclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720195469; c=relaxed/simple;
	bh=FNTBsX+63uIgnWKLXkG5pwYCpWKOxAZZwqQ8X2x73vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcM0RIFzRx7L9zpR3yimlJ2EfKOuxg09EYyjuxMLP36dpQ4KItL2B/smGhmpuoLSDneFm53DtbmhnSiyAnzfHZ2IDbw6to8SJmgpIFOBmrwc0gRFzRc5QB3G8o53Qg3qh3VUF2ZHQR/+eDheKjP/Xy5EUG3UyX+aSL3ZIDmlXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VCigcpwi; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso1239348a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720195467; x=1720800267; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0j8hAyQWJjGjX5p48jR0ZeFa7oUdUxgMcRMAfmdz3I=;
        b=VCigcpwiMEa87gj34MO+kStN38HY0QF0Wx5yxVrnKyFC69AY1ojtgXHqpGdaeNDUpm
         rzuBqvjQW6TcidsPJ03K8/ovgUJ+WOdBNcLxgjnElbIMGWmz03lhDPvxwWIv7ZSZmKWj
         1LO2T/gw14YwDLP8CxSpXjhvX1WqsL1E/+YbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720195467; x=1720800267;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0j8hAyQWJjGjX5p48jR0ZeFa7oUdUxgMcRMAfmdz3I=;
        b=cdzTP8/UkbkcHuf1wJV6ELZ/dXL7lZV+TUl08N0XjVLcEsWcB8UtXNNFT4OPwKKfu+
         cA5erxl3u0j/eDpY35YqFFNVl2cuQbeslwtxCBsQOgYU/FamIbzcYJu+HQl5iFo9Z4YF
         Z+pemyoBQNLaEydQXxPsRQqdFthgVyc0LQfISinXHLfFbbthRWlq/KtsImtOMgp9E7xW
         NKt/GyUr63nmaF9OFgs/5Bum4sowyNFpCd9IcrewpNrfNpXZ4g+z80yMURV89MIKl8Sd
         f/rldhypmUw6OxWWx2GP3wrgTl/exoc68tISO3YF9Nbv4U0WfOB40uSXiDkA5IzILQsw
         ZtaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlzK51JtZZxTOZ1GVzxH2iTQwni7Lb3R32+SrMhLkzVH1FQ6tRgpVo/ILoTI6WJJtSfDfa82eaWSraQ3VjTFk6KQgr42yhccHcaFP2
X-Gm-Message-State: AOJu0YyCpaqVSSPPBgdLR7fJDtq/pPuviDOJ7Gj1zEQ1X1a+bagwGpy2
	GyQZDWxtK1SGb6TyZ+pDWhPTbMSGoNIwH76eUnAeUUcAIE9zXfY9Z0W2ZVCF8A==
X-Google-Smtp-Source: AGHT+IHgkOSaePxDDnJHq1U7KDyApbljJxbvMpXvGQArIGdlvWKuaNaFIdtcRXK3XVmYMcGfw2r45Q==
X-Received: by 2002:a17:90b:11d4:b0:2c9:74cc:1c1b with SMTP id 98e67ed59e1d1-2c99c504127mr4043383a91.7.1720195467069;
        Fri, 05 Jul 2024 09:04:27 -0700 (PDT)
Received: from prme-hs2-i1009 ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a992c43sm3576853a91.30.2024.07.05.09.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2024 09:04:26 -0700 (PDT)
Date: Fri, 5 Jul 2024 09:04:17 -0700
From: Tim Merrifield <tim.merrifield@broadcom.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Brian Gerst <brgerst@gmail.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, alex.james@broadcom.com,
	doug.covelli@broadcom.com, jeffrey.sheldon@broadcom.com
Subject: Re: [PATCH 0/2] Support userspace hypercalls for TDX
Message-ID: <20240705160404.GA15452@prme-hs2-i1009>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
 <33874bf0-c115-4185-85ef-684794de3c8e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33874bf0-c115-4185-85ef-684794de3c8e@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)


Thanks for the response, Dave.

On Wed, Jul 03, 2024 at 05:18:22PM -0700, Dave Hansen wrote:
> 
> Could we please be frank and transparent about what you actually want
> here and how you expect this mechanism to be used?
>

Sorry for being unclear. open-vm-tools is currently broken on TDX and
the intent here is to fix that. The idea is that versions of open-vm-tools
that have been audited and restricted to certain hypercalls, would execute
prctl to mark the process as capable of executing hypercalls.
    
> This inheritance model seems more suited to wrapping a tiny helper app
> around an existing binary, a la:
> 
> 	prctl(ARCH_SET_COCO_USER_HCALL);
> 	execve("/existing/binary/that/i/surely/did/not/audit", ...);
> 
> ... as opposed to something that you set in new versions of
> open-vm-tools after an extensive audit and a bug fixing campaign to
> clean up everything that the audit found.

I understand the concern about inheritance. I chose prctl primarily
because of some existing options that seemed similar, mainly speculation
control. Is there an alternative approach that doesn't suffer from the
inheritance issue?

