Return-Path: <linux-kernel+bounces-530037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB080A42DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469A41897C88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4807245026;
	Mon, 24 Feb 2025 20:36:28 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DD24290C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429388; cv=none; b=FOu2h8EnoU6mlOceM5HQbNuY1Yb6BIuhgwhAMcZCGAomNVv8rweKYab5dsEMP7K/CWZ6ipp+KjfNZUh2eLRRMNaO1bq93qJd3w5OFXvrswObWqdifj7pqVcMK1ikdLTutkTxztrewIXFfw5IR0PHFf8DhlqstcAsuLxSHYK0gjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429388; c=relaxed/simple;
	bh=9hrDDJBuLNyuMK6zoX21Iu9fEGGGwvWy6rL9eUg2umg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq5TtE4h2jXuQMNTMLqNc98vcOXdnB54iVRunYLSOkKGcdC+6Hwfr9SIvkhfLBcSHiUh2Sb4Z2e6qlItqQsfdr02q4+JxwC402DJ3RIQn/sI6LLgrqnmgGpIQhHK9kqAJZCRBmwM2DuFy2Uj5scePCEF37w5ECNYpgG/azYcBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 023fc062-f2ef-11ef-a29f-005056bdfda7;
	Mon, 24 Feb 2025 22:36:22 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 24 Feb 2025 22:36:21 +0200
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] x86/mm: Check if PTRS_PER_PMD is defined before
 use
Message-ID: <Z7zYRWTf87HZsAvN@surfacebook.localdomain>
References: <20250224173940.219820-1-andriy.shevchenko@linux.intel.com>
 <76b8174e-3c4c-4db4-83d0-aa8d241c7afe@intel.com>
 <Z7y2W8tsAOPhqNfn@smile.fi.intel.com>
 <d2a1dc6e-640f-45b2-972e-b168ceb577dc@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2a1dc6e-640f-45b2-972e-b168ceb577dc@intel.com>

Mon, Feb 24, 2025 at 10:37:50AM -0800, Dave Hansen kirjoitti:
> On 2/24/25 10:11, Andy Shevchenko wrote:
> >> From reading the "Closes:" link, it appears this is a new issue that
> >> originates from a new compile flag. So it doesn't seem like it's worth
> >> backporting.
> > FWIW, I haven't put any Fixes tag nor Cc: stable@ 🙂
> > Also note this looks like both compilers complain about the same.
> 
> Yeah, I did note that.
> 
> I see a lot of patches where folks simply forget about stable and Fixes.
> Unfortunately, I'm not super clairvoyant and when I see an ambiguous
> changelog without stable and Fixes, I can't tell if it was an oversight
> or intentional.

In this case it was intentional.

> It would be great if contributors could be less ambiguous and save us
> the trouble of having to ask!

Sure. For _this_ change as it's clear now, can we proceed for v6.15?

-- 
With Best Regards,
Andy Shevchenko



