Return-Path: <linux-kernel+bounces-259592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89911939912
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F82A282A20
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B6D139CFE;
	Tue, 23 Jul 2024 05:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AMNoF6Vx"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB38213698F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721711094; cv=none; b=d0cmTopBOv72kfxHKxzLbYXVJkQepedbBwoFW/sLcZGJXiLt/gu3HyLKqRDRlxhKD918+SrDNQP1aF0xX9TVh9Z3NH228MmIi6SA811NbHmazh2sFaEfAv1/tKOm9vdpHZrvPuzjw5QfZkgDcxeHBv8bGs44I/n6iPwZHK4L3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721711094; c=relaxed/simple;
	bh=geHnqkq8xk12wPityzUZkTxDWx0eg8t54QFrTLDl80E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVCftFYE6kj2bdiByBMVWgkadyxSkQ1BX0LX5HQsZfDg4W/5ZNkKzr9MiT5A2p2bQrtzc+VV3gSSY13Va3LOFFrCH1+kO0kfKWGVXDb9FnAQAfhRZhZ7Bdzoth4Cgry3yIl5l3P8MW3MK6+ebrAcGBNJCIxUuSi1YbK6U49b8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AMNoF6Vx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb682fb0cdso2683787a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721711092; x=1722315892; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geHnqkq8xk12wPityzUZkTxDWx0eg8t54QFrTLDl80E=;
        b=AMNoF6Vx9inXoBIkX3W7lmCSNpG/VDkK84LbFd6Q39p2wD2Y1I7pltPD0qGFP6Tfsr
         Kvf5ZLFxDqKrpIMJNYWo+iZCwLyJWnAHkwoCLODS5SX2PTJkVwNlXn7/1alJB5zvFd9o
         +D5dI9+RYptK/tEciQ0wuUE1+dUiLTKfBS7XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721711092; x=1722315892;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geHnqkq8xk12wPityzUZkTxDWx0eg8t54QFrTLDl80E=;
        b=uZ6Hs1l48bqklj0EixYFz/ixQbrSQj/m5uN9OoL8atX4DxAiBHBUwe9BxYY6TKkUYC
         2W8XRIAg1M1Z53UmvGlvtM4ngpMdS5uFuuxyHD19moDweBqO1n5zFSyBkzNRS55J6XeO
         2UTOTKYGJJTceYd1HibCVdtnpW86zHmOOcmDJosfLLm7teyWqK3MGt00VC4UjGEZ2ras
         7f9QDqa40mVRe9Spa3zlFlcZrZ0fCLvi2bR0wD/mMv7pjTwlN0hdjiwRMUvYhR7nqhY4
         /ENchExqMNO9TMkjK5XQr88fcSAfNrpRONfjvKGrQ7DY2snqpZ4+AO0aAdJGVhctSYyt
         Zbhg==
X-Forwarded-Encrypted: i=1; AJvYcCVwviz3s5JH0tNYM78rvD1k6dfhlXnVRQ4E2DefklxEIRyDKkI/44UQFMI0GRY+dJSN8xykrU6ddjLtR4GLz1rQDWV5l7Fon+8LT64+
X-Gm-Message-State: AOJu0YzwHQoXGvlEjKjFbKKnq8AsbFw6iV2wQquNayXTR4J8jYrsHGpx
	NkRb4mnPyOA78lD+bhR2wJT90QuqzKgVWcGfRZKVlat+0ppylW4H2Af8fprrcw==
X-Google-Smtp-Source: AGHT+IHy5HHrWxb35Qqa7ZXc+sIM2Hmxg63fti34eqUQtbPkpYiSD64YHv5F+p2M5kRN5sYRROf1zA==
X-Received: by 2002:a17:90a:c593:b0:2c9:81c6:b0e7 with SMTP id 98e67ed59e1d1-2cd274ade2fmr5022887a91.30.1721711091951;
        Mon, 22 Jul 2024 22:04:51 -0700 (PDT)
Received: from prme-hs2-i1009 ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b2c5edsm8048204a91.3.2024.07.22.22.04.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2024 22:04:51 -0700 (PDT)
Date: Mon, 22 Jul 2024 22:04:40 -0700
From: Tim Merrifield <tim.merrifield@broadcom.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
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
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, alex.james@broadcom.com,
	doug.covelli@broadcom.com, jeffrey.sheldon@broadcom.com
Subject: Re: [PATCH 1/2] x86/tdx: Add prctl to allow userlevel TDX hypercalls
Message-ID: <20240723050431.GA10164@prme-hs2-i1009>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
 <90bf00599189c34e77aa77986674be2d5fc19f9c.1720046911.git.tim.merrifield@broadcom.com>
 <wufxrry6smwk25qmsajabx6vgx4vgsrbvtmun2zw4fxz3lo4b4@nfpkscueapt6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wufxrry6smwk25qmsajabx6vgx4vgsrbvtmun2zw4fxz3lo4b4@nfpkscueapt6>
User-Agent: Mutt/1.9.4 (2018-02-28)


Thanks for the review, Kirill.

On Mon, Jul 08, 2024 at 03:19:54PM +0300, Kirill A . Shutemov wrote:
> Hm. Per-thread flag is odd. I think it should be per-process.

This is the only point I might need some clarification on. I agree
there doesn't seem to be much value in allowing per-thread control,
but I don't see any precedence for setting per-process flags through
arch_prctl or similar interfaces. Am I missing something?

