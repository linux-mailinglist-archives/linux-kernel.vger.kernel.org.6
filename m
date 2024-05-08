Return-Path: <linux-kernel+bounces-173206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B138BFD02
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36C5285BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7E683CBE;
	Wed,  8 May 2024 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zdre9eqm"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAB839FD
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170730; cv=none; b=LxfRiZB+VbfOmjUIBVIF7TaoP22dJNpf7CWY57lyOrxZad2RUJQw+8mgyHlK7Z6+rCBe2A1ESp66OT+VoYEDjhYPzL1pSyz6+lmSzmlsAgXEJCu1Sztd6kF7gmzqxAMYyo0AZRdPEZOZY2JahyM93n6k1/z1rB+2/6Nkqdxnj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170730; c=relaxed/simple;
	bh=Ra5CkaV02rMT+W1YZtiiW7W7NSd3M/Nsg4dEl71TtTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj9cKDPGbsyUYYuT1Lbd2KQQQi3IPXzfBHEZK10xGKH7Njrmh2XOfhZJiCoOnWXz+2STi00PfE6l12fm7TsKG/I+jYlSZcZvPjifNlDMuHF6OAaGATo66IWL2YudQLcQtkYf+8EnnapZnTvVBBzmxtl1EhfVBGVj09axXRMmWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Zdre9eqm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADCA940E024C;
	Wed,  8 May 2024 12:18:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XQyq8Rs12_HQ; Wed,  8 May 2024 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715170722; bh=zAP8WZWIDY0jQdc667ULP2ScBNTHP+zF1XZ2Xi2qwfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zdre9eqm6W74SVfkLa/gHXSJCJs0g9ztPCczJoGzIqos+FM5zlXKPr5JcEl0nHxsr
	 YTGVnJBUJZ+qNWfG+DW8k801y9m61ZmGnPgxbp4SkmR24tCGiLWsAGFRhC5Ez0hjAi
	 kyskakZGM7EtPjtxXQNWF+u3j/Nz+plu4qW0Pd6idZVDjvpYXbQsVIl+JWJ91EGJkA
	 Hx0hNlPOcQ3WNA+6Lr3BXCr3nJXj5wpjz6gKtGmd26vL47o7U+EOyNzNOdEIOe9Qty
	 JRuOZ0raQ33fKRWQA2p4bMcT5THSTuXzlhwNvp30wP6IyFD44rBnSkxfawRlDGR6Qm
	 WnGIXOf3zH24ZbeFGFq9YPaTooXZQu4egcyjn4UUCMDpLO5tEyn2Y2/DNbA3tbyrxw
	 Jez9NkiRwfeXCZB9c8nyuAVSJ5tjNJTvWsSQy5i/O6MPY79C8lVw8FR10aGHiPKF31
	 dg7/gyJmr9g4dL10a/bzdXSlKaSx+4GU3qgLiQHQpReMwyHRrRWXjD3nzLMNlsGPN4
	 iRNXSXxPLxIm+TPnd/EXWMLI1B9PlR+QZ+t88PmZuu4+tABSRtayztkQye+WOc14i2
	 1iJrr3YX2YqPfpx1ICr73bMEMg0ML8GxC7JkBI7FoHSNUtf8yy+mjwSnziX/tsD8ek
	 vb4vp5/LFwT6LdqKDXgRf4P0=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 141E140E01A3;
	Wed,  8 May 2024 12:18:21 +0000 (UTC)
Date: Wed, 8 May 2024 14:18:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 13/18] x86/acpi: Rename fields in
 acpi_madt_multiproc_wakeup structure
Message-ID: <20240508121819.GEZjtti1unC6GEFpPZ@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-14-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409113010.465412-14-kirill.shutemov@linux.intel.com>

On Tue, Apr 09, 2024 at 02:30:05PM +0300, Kirill A. Shutemov wrote:
> To prepare for the addition of support for MADT wakeup structure version

"In order to support... "

> 1, it is necessary to provide more appropriate names for the fields in
> the structure.
> 
> The field 'mailbox_version' renamed as 'version'. This field signifies

From Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

So:

"Rename 'mailbox_version' to 'version' because... "

> the version of the structure and the related protocols, rather than the
> version of the mailbox. This field has not been utilized in the code
> thus far.
> 
> The field 'base_address' renamed as 'mailbox_address' to clarify the

Ditto.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

