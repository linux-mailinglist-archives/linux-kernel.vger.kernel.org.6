Return-Path: <linux-kernel+bounces-315404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DFA96C230
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1883282C03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF71DEFDD;
	Wed,  4 Sep 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RU36sE6b"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D441DEFC9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463487; cv=none; b=YldFXqHawtlJi+4t2b3bv93GDfmhdrXIsp7LGAYdBr7ci0JNBK8zG9hvW9DE3vJRrp/KZUMKBbaOahzoyBftavKVR+OqGMaKwnMFJC5HjSRve87iSbDJ9U1TDhFTPW2sBWig7voPRg8mtV/9Ard6oPlOIXkQalpp7MrsK0H2K18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463487; c=relaxed/simple;
	bh=VQcEr+efDXODQ5pudVtyL2l9yhEYHqzUGVvH+r+i71U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbH1cv9qwKcKh1lc6yoznJ2/FdfiXr3DH/9qKV8ix8K6u73VPSmtKDwaTKeZSUKt9dzW1FrcZHpPSAT6rSjBH6nHTdUHOu1bTLHjazZHHRxezX1J8PAiPxmF6cOmMdzDMsz+HJvi+QMVjWtqC9v25drA7EhIMixs0kywaHdAZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RU36sE6b; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0939140E0275;
	Wed,  4 Sep 2024 15:24:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HbIU3OWoIfIW; Wed,  4 Sep 2024 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725463477; bh=wtI0LNdlpoTQuTlebGWwJzCuCj0wmFTixf7EMfX31KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RU36sE6btCS72NZmHyND2TY802fuEBAj0hta/mgD41tSPAuImQrP86muzOh5ftNoC
	 A3CkTac9MBQ52zd8rDKAE/gTyFIic2/rUGlcHwCDXe0KcuMVpVDwz5yqOlHJLhWc5e
	 EA2TTYlkviHvNcAaauhnN5AP0NuzAMojy00uqKVPLsDkJnr62V9oaPwOSPmkJz7MqF
	 ziLnFiosjlsS5sthIrNRn7e/DnyWZb7Uw0Ux4KG5EF44Z61PE7gyEnaP6vmRon8Q52
	 BiYjmZF7A8UarOZJ2feSoCl7i5qTmoxFdNnAvlNX+BbKVYqBDcBESrM/gUODX2Sihv
	 5aFZYX3KGjcWoP68pwRoF6gPTTOlQ2PUO4NU0B9BFrmdf7whNsgcqV1DArYi8iXCQa
	 OF0sgdYikWf1kvUK9z3+jurliwQjQ2B+z0nXSK+RIBKQuHRixCEi9WWEjq4utGFPua
	 YSpCVj/e1EaS4gjHrKv4/xiBr+wsy+I/cexM5G/yEYQJtGpgDLR6VatkBcl8a2JQH6
	 ncGZ8iaQsTN4f24yMMLX34pgB+Vqc78hOFmywPEe0jvx++I5C/9mcUJPBIe/jwoU+p
	 NHqqpR7EcTetw5pM2icblu4p/0sznNf5/QhgTY8Emp+HwPoVgS9m/gWL6b8oKXk4n/
	 pX3n7FZNf3dRh7HAtBH//2KQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1E5240E0198;
	Wed,  4 Sep 2024 15:24:26 +0000 (UTC)
Date: Wed, 4 Sep 2024 17:24:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v8 1/3] extcon: axp288: Switch to new Intel CPU model
 defines
Message-ID: <20240904152420.GEZth7pPI4NKghUxUS@fat_crate.local>
References: <20240903173443.7962-1-tony.luck@intel.com>
 <20240903173443.7962-2-tony.luck@intel.com>
 <d114d151-950b-49a7-8be5-19c1b8b15d7c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d114d151-950b-49a7-8be5-19c1b8b15d7c@kernel.org>

On Thu, Sep 05, 2024 at 12:19:17AM +0900, Chanwoo Choi wrote:
> Applied it.
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-next&id=089a6e37c5394bc22d34c0c22b14a31b897b5831

Now, can you remove it pls?

It will be way easier if I queue it along with the other two...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

