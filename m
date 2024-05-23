Return-Path: <linux-kernel+bounces-187662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD198CD610
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55EC1F2428B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE66FB9;
	Thu, 23 May 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NkAsg038"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55533567F;
	Thu, 23 May 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475578; cv=none; b=FD0izhiXKXrlk8QITIcXw1Uox9zcslZP+UM5fdT9h4HNN9QGGtpPO1Tks9A/pUx9K3YpKj2i/DQ581wXBfiB8gSY0jDCpW5oaJlzhX6O4+dZDesmFlSdvXOjvwoo0xyAoQmwT6b6/Xmp62DElCteSHFbsfMs6OnzBRTa5k6Hw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475578; c=relaxed/simple;
	bh=hF9ljzZP9hwPMBp0SExgTSK/RJHnGtr+KaiJw2malPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFTxSXvQH5kjdghgFeeaQzYvbT95jLnk1m7B8KvbG7KPXQLoJjtYWxmZSFQ5/9KFh0FAvgDAIcYIa12x5846vI6Vm5eMtD2fVk7KzJteAcsILeegs6pJBXsYOvCsrVsSbK50w25fqBhoULKrAxP3xUIPSmmxpWMrBXXLnVRzBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NkAsg038; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A6C0B40E02A6;
	Thu, 23 May 2024 14:46:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l2nRQhdxUtB6; Thu, 23 May 2024 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716475569; bh=lMSeCakuwLRl6qGLg3e16nybVlse1JsLGi9aJxe5ftU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkAsg038Z89PME2UN43DYilqftlUXNoYQ0I2xyQ+Dd87EiGQjCd2nHlYvBfwh+hwX
	 GQqXnErGMdybQAuqCqJMt1qbQ5oNP8WRw45nq1DUGAAJGH0tRQWRpVlSeRyp24f2Qr
	 UsoGBxlgCF83MDFxnI3qDTIlHZtAj+XQeCACCTVVkO4GR0V1cgoASkFFeuTyl+4P4O
	 EFaMZ7aOXrgmyqguiWfbw4vsFn5OnQO5Hfljlxn53B4AmauZf/QL4y8IV66VZE1qO1
	 y2Nms1+rheRklnlsw6m+9XtdgeY5WG3O16CucUtSn8S0qF/KMloZkrbw8L6r0vzeai
	 gRjh5MGKTOpMlw86P805CQmNb1QnHi/uXa5insULj9NwWUayOZCAyxm8G64CSZRjjZ
	 xnDcKc8GzOEJi9MLB8QwO3Bc/Hhb3zs1bMFAv/ohVFarLlV5FodOiEAHW0CBTbAKhk
	 KcpxoimWRptFK1V9CPXJ6IavRh5th2QUaNHd5zOWFQwtjQir1HqLiADLfuGGiV1klE
	 viyd4zCpOG5RVEZNgKPKv6VX5uo0GUD+aJT8NJj0O5q56KjltkI5HHxX1btqaGuxwm
	 V98KtpFeJ1V6e6l9xn2DQhfe6p9+yTTVqLuYD/zbX/dizkoOKWmbk3/G6oo3BQHnDG
	 ob4/bbWz/FqktDEHgWCsy1Ic=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAE0740E016A;
	Thu, 23 May 2024 14:45:48 +0000 (UTC)
Date: Thu, 23 May 2024 16:45:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Balasubrmanian, Vignesh" <vigbalas@amd.com>
Cc: "Balasubrmanian, Vignesh" <Vignesh.Balasubrmanian@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"George, Jini Susan" <JiniSusan.George@amd.com>,
	"matz@suse.de" <matz@suse.de>,
	"binutils@sourceware.org" <binutils@sourceware.org>,
	"jhb@FreeBSD.org" <jhb@freebsd.org>,
	"felix.willgerodt@intel.com" <felix.willgerodt@intel.com>
Subject: Re: [PATCH v2 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <20240523144543.GDZk9WlwKpCKx8I3RE@fat_crate.local>
References: <87wmo4o3r4.ffs@tglx>
 <4a090901-9705-40aa-ac3d-d67c52660f22@amd.com>
 <20240522153433.GCZk4QiX4Hf0OuI48E@fat_crate.local>
 <902b1bf0-15e6-42df-8f86-21387deef437@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <902b1bf0-15e6-42df-8f86-21387deef437@amd.com>

On Thu, May 23, 2024 at 11:57:00AM +0530, Balasubrmanian, Vignesh wrote:
> Currently, this enum is the same as XSAVE, but when we add other features, this
> enum might have a different value of the XSAVE features and can be modified
> without disturbing the existing kernel code.

We will do that when we cross that bridge, right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

