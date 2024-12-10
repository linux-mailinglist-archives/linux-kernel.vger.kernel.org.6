Return-Path: <linux-kernel+bounces-439482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9109EAFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E090416AA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4B378F5A;
	Tue, 10 Dec 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LfSQ/UfL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4920A23DEB7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830105; cv=none; b=XQTjRhqnk2DnHLETisH7Puo4i4jR/ser9Tn5vjl4J26NXuFTfz6w9aAJqGevel63vIT28FtxqchGmvW2T/+L658DHyUd346jF8YubB/I35qK1r3CYoQ5J29a0tlAY/IiOxjZHxFJswpQE3YYCDxx4zMGSDJerACiFFm0SWBlofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830105; c=relaxed/simple;
	bh=BT+KWs/DEoL8o52mfCU9DsihDZYvs6kfs+RfORWbP30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIIPTQvTaRwo2t6DgoEEqfjUQykfaUvk1LRLWkTQD5WPB1G2cyiSISVrEcCwvqn9mYxI0BxX2/rO2VXHx7OERpIKza6zk99Pr/QJq548UkI4n/xC0OlpwPtvixu7l3jtvvxW/m/+uGnbaTiphlMBLgAWucAOTRXj91K+c5YMSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LfSQ/UfL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D5F5540E02B9;
	Tue, 10 Dec 2024 11:28:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BPFLbg9650fi; Tue, 10 Dec 2024 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733830097; bh=AHdK4NL4kso4f9cpx/i1B65BeDVwp3tlcCg0GkYo6fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfSQ/UfLrIkUaesH3ztIccGgMaguDVUEtC8m4Dww8OSL33U1Wl1NzB+1m0gMNwNnU
	 87K2YW9KCRP1cu0c6TB/v/bDu4o/Z63vySS5/QyWJWTGXvNLB5uyTq1peIizAuhdH3
	 gM92knt7NiTUrAPRGvtLUsGeg+ygxPRbBijDMpwqhlP8GI7we+PwIqZ6RESFVOkfMe
	 jg2y0dDYlNAz2ERd/g/battkD6TNxm55lOg/NEyKnsSwWT6f8VZxQTIFs+TwzZAxXG
	 yX8BxujEClBkKnxD2MmNYYKbWeqiP1/k1/9WPnsFufwqh3Yx++bzxDbDRKe/NyIOrF
	 b6luesoOOdgOlj2BzJ8avA+1aWZhRoo64LKfmVotCJC6vIGjoTG3X31Pacw37COvtW
	 8ukycMpz2s+t9vxkmQlPdhJ1sc8k0lT+JfBA5sWqG+RiGrEwRibZmLAn3BxGxAfO3m
	 WcKXjokiMmhwez1E16wDZk+iD9jQbEefpdZN3z7QpK2yEif/bsMCUm31lOvXFlc7T5
	 FVepmlhl+wsDvGAwhf19aWZGphaY82l7yB+97wZrAYQBLH42zOZcN1J1heXBYkCrdL
	 Ox4a58JDim/X8qMmRi67DXGcQa6JCWIzJYU8/psmK4AgDzA3gUODtC/efnDhAQB9tt
	 ok24+bXpqyg/eQ93A/Qjfs/Y=
Received: from zn.tnic (p200300eA971F9307329c23FFfEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B14440E0286;
	Tue, 10 Dec 2024 11:28:09 +0000 (UTC)
Date: Tue, 10 Dec 2024 12:28:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH 11/11] x86/cpu: Make all all CPUID leaf names consistent
Message-ID: <20241210112807.GFZ1glxwOx7Nlm_edI@fat_crate.local>
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
 <20241030213329.3253F5F3@davehans-spike.ostc.intel.com>
 <20241031101834.GGZyNZejzr5A9bNL8J@fat_crate.local>
 <4d606240-a8c8-40e5-80da-57c9b4d48179@intel.com>
 <20241129182747.GEZ0oHo1eR0l7sREJY@fat_crate.local>
 <d6680add-f4d2-4d65-a711-3f80bfd43f6d@intel.com>
 <Z1cajm9oqRZWDp_4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1cajm9oqRZWDp_4@google.com>

On Mon, Dec 09, 2024 at 08:27:58AM -0800, Sean Christopherson wrote:
> > > And having a "CPUID_" prefixed thing and a "CPUID_LEAF_" prefixed other thing
> > > is going to cause confusion.
> 
> +1.
> 
> What about CPUID_FN_xxx for thing architectural leaf function number?  E.g.
> CPUID_FN_80000007 or maybe even CPUID_FN_0x80000007.  CPUID_LEAF_xxx is arguably
> wrong anyways for entries with sub-leaves.

Makes sense to me.

Especially if the name already has the function number in it too, which is
self-documenting.

Vs.

CPUID_FN_XSTATE

which will make me go lookup what that "XSTATE" function number was...

In any case, I think having a clear distinction in the naming between

* arch/hw names: CPUID_FN

* our own: CPUID_LNX_...

should help.

And once we're clear on the nomenclature, the conversion will happen
"automatically". :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

