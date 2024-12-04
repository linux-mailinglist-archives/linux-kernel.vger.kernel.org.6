Return-Path: <linux-kernel+bounces-431604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74759E3F52
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A939D2814A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B920DD78;
	Wed,  4 Dec 2024 16:07:54 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0520DD67;
	Wed,  4 Dec 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328474; cv=none; b=i9ueRZ0fcKs+OEPvslDqsNm18QTGsNcYeV/d06g2j94emkxOrtPCWEI2++fA5jRFrmlf1zy3ABVgfNCilT3irm8OHDA0tWwnFTLG5Q80odHfaeQfjxov/RLg5xKs7MBVyT6d6a5bt3w1eTDRqyE4QcZX8BFz/9O2s+EeIPiKC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328474; c=relaxed/simple;
	bh=FZAWpzbgZnGBv55kdagrp1n5uPOb3F0pMbM/76Ek6Vc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qoKD9z2koe53KzE4IiDEr/RZpn0TzyR/XR9N7Sxx6xBCstoqZPJVdtVEMhfiIiXH74AQffrN29EVzYLfblS5s4+CrjjP5NoEMEbY0ci2gdv6gpJWwfxlzI2sLEDUUPvmvn/Gx1ZwID9/OOFf3U7V+YknRXIU7HmkUJUm7pxFjeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tIruX-000000006yw-1zTy;
	Wed, 04 Dec 2024 11:07:33 -0500
Message-ID: <0669c39395c544bb57e1ccd21010ba53147126fb.camel@surriel.com>
Subject: Re: [PATCH] x86,mm: only trim the mm_cpumask once a second
From: Rik van Riel <riel@surriel.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Dave Hansen
 <dave.hansen@intel.com>,  Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Mel Gorman	 <mgorman@suse.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 04 Dec 2024 11:07:33 -0500
In-Reply-To: <Z1BV7NG/Qp0BNw3Y@xsang-OptiPlex-9020>
References: <202411282207.6bd28eae-lkp@intel.com>
	 <20241202194358.59089122@fangorn> <Z1BV7NG/Qp0BNw3Y@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Wed, 2024-12-04 at 21:15 +0800, Oliver Sang wrote:
>=20
> we tested this patch, unfortunately, we found even bigger regression
> in our
> will-it-scale tests. and for another vm-scalability test, it also
> causes a
> little worse performance.
>=20
> we noticed there is the v2 for this patch, not sure if any
> significant changes
> which could impact performance? if so, please notify us and we could
> test
> further. thanks
>=20
> below is details.

Looking at the profile, it looks like:
1) switch_mm_irqs_off is somehow taking more
   CPU time after these changes, despite
   removing an unconditional atomic set_bit.
   I have no good explanation for this.
2) Moving some overhead from the fast path
   in the context switch patch (switch_mm_irqs_off)
   to the slower path in flush_tlb_func isn't
   right for the tlb_flush2 threaded test,
   which basically only does madvise and
   TLB flushes :)

However, I think we can reduce the overhead
in the TLB flush side a little more, by moving
the jiffies test from tlb_flush_func into the
calling unction flush_tlb_mm_range, so the
jiffies comparison is only ever done on the
calling CPU, not on all the CPUs that receive
the IPIs.

Let me send over a v3 in a little bit.

