Return-Path: <linux-kernel+bounces-365735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C82399E919
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42886281376
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AA11EF0A5;
	Tue, 15 Oct 2024 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCd+k2Bc"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA181EF09C;
	Tue, 15 Oct 2024 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994303; cv=none; b=PFefYN1dPrROC1fN9yo71E2ByO82C3Rfn9ZL6mc1CU7qdIjI1rqi8KSRvDSupXDLDy9EGjjkHhfqQRHQiJecsFHBLNz6N9kieA+GQR4ALuwkoIupjr16ifkPJE/PT0BGuaiP5KSXx+BtTgZKdCrwutMRMZ3ruq9o0MZYxAOn3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994303; c=relaxed/simple;
	bh=B2xMX+6SvKORwecMy2BR6MpBJTzerC2mW0RZ3VND/KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkDP7Yw0LevvCX/+jRhD1wwwnd2k1Hd4Xbng4YxysiITq98mzMSHZfwubDgLK4Z6ycT3zPoK7gxnNJkd6HEVcTNJvzavFEbva7XQDBdEqGVEQ42tGEIwAigYzGGoHHmMZG4/L6Us/gqbKZT90u9gor00mwhFndjtAW7oU+m/a/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCd+k2Bc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e1c91fe739so4057519a91.2;
        Tue, 15 Oct 2024 05:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728994301; x=1729599101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5kR93BfcYG8S010p0eA+geMSLv40hGuP+w3xQj67PSI=;
        b=cCd+k2BcHWLeL1GjUvXUVgS9hYQegGRQUSQaB4pvA+Dp0MqiU1umLYt3jaJmWZh4kG
         8x40BYueE5BJW6wx2EWEInA+gY6a3IjNG6/QGDzSSuk9XR8k8DPEejdprh/9jP9NNduw
         cUl+6CisWRisd0cDymxpZismoiFJw3tnWsbfG78yKfk3CfkKZz3kiLK4q0P1NNndrAU7
         ns8Ge8Gs2diTl7mBUamn+XVVtmIR5lPUaMmpTwZQ7jYCwzlqbj9r+EJYNXVS1dkm0rd3
         LRSE1adfRIq68SdfxikxGhwVsw1DmhzWt6Gi3h4GF6S31jQJMyUlDo5WHuKKgWtbO0Zb
         MRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728994301; x=1729599101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kR93BfcYG8S010p0eA+geMSLv40hGuP+w3xQj67PSI=;
        b=tATvFNHEHmazHoWVpLB16WNA4fTjJapTuz66n3bqPJ27i7rc2g5id5kgYq2AhUVq/c
         cvH4Oqy5LQdFBiW/2DaknvNbaReAb14Dn/XPEDVADzW2VL+7paFj7QRFlxihsNkdbTRZ
         peqcAFYW12HsiNmpWLm3pBG9DaEY5QLbKJsFZfdqv07LrOPRgmFOkOCX3L/ZgEftN05d
         I4smspjMKe37hK4AUK6Qrl6QwpSzAS0O29r50XlGz7xzNnuifQhFgzdNwhARjzbXcfkK
         eKjRWGmTXSDlZ9pR7Ln0JF9NoIC6eeyeaFHMt647YYgYneSGKRiZe/c6oj7QG0Ozoyeb
         HXpA==
X-Forwarded-Encrypted: i=1; AJvYcCU5cPHFVo5KNHQjpbI1w+HGDelZPmiESmtOHUyJtNi3ge/DzYIdNRA4x+Nfs7UG4JhLol+f5H6BiH+Y@vger.kernel.org, AJvYcCUzx9KRonOi/cSIgiC4KDJ8QCuRabwVXnVUx4E3UnosrWUNyqE+c5Dghq34g55J+8UVm0ReldBXzE9qq1HT@vger.kernel.org
X-Gm-Message-State: AOJu0YwL6e/Gkszbcayg0MxNSXc2gp06JZKBZU0Ifoy3/omQOw55S7cA
	o3Pb7CZ9BCModViBkXvFVWOo57C+DFOVwqNqSUd4hnl82nUcwXPVQBQZGQ==
X-Google-Smtp-Source: AGHT+IFIzl/30qM45epLPZCQITKrZBt1dkSO9qHNajeeKYGWRShGqz/Kq+Gs+dPNUskAsu4ChEg+zg==
X-Received: by 2002:a17:90a:8cc:b0:2e2:c64c:a1c9 with SMTP id 98e67ed59e1d1-2e2f0b2b844mr16980466a91.24.1728994301311;
        Tue, 15 Oct 2024 05:11:41 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f62f09sm1552323a91.35.2024.10.15.05.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:11:41 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:11:26 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Guo Ren <guoren@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Yangyu Chen <cyy@cyyself.name>, 
	Jinyu Tang <tangjinyu@tinylab.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
Message-ID: <fzwgavmdfdm6ffzqggdfcf7p6d7vbnrsmt6vxc2whx6t6e4pif@mjvchtdmgh54>
References: <20241009224410.53188-1-inochiama@gmail.com>
 <20241009224410.53188-3-inochiama@gmail.com>
 <87ldyqfxm0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldyqfxm0.ffs@tglx>

On Mon, Oct 14, 2024 at 06:38:47PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 10 2024 at 06:44, Inochi Amaoto wrote:
> > +config THEAD_C900_ACLINT_SSWI
> > +	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
> > +	depends on RISCV
> > +	select IRQ_DOMAIN_HIERARCHY
> 
> Lacks
>         select GENERIC_IRQ_IPI_MUX
> 
> Other than that this looks good.
> 
> Thanks,
> 
>         tglx

Thanks, I will update it.

Regards,
Inochi

