Return-Path: <linux-kernel+bounces-252500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3001E9313F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2D61F21F81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B318C169;
	Mon, 15 Jul 2024 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RJuG2H3y"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51E18C170
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045852; cv=none; b=k4r4EkZKcgkeIf5wD5j1Oja3YxgPCLu6r98ixI+7Ni+ssu0JcxU3a8CyAtkf5qsYkX48fKVRl78YLFxORyM9A9mGAwn3TagTNr3TnyquFIrme0cDsxEgqIJCoXNf48yIGoc00Dav0jBbXmpHa3+4W19sGUhPvuVT/IK92O+N3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045852; c=relaxed/simple;
	bh=42W8b2dBPueTWFZdOdOwfS1/BzZPdpyWZRA0qbwDSKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfkfAMcXdFOwtSQlmW8uPGVkcVTVxzkau7A4QBN+VFgxlS2zVu9ntT2N9qhKbPkLxkRxi2Eg3jpkVjl+r041VFbBjf/y0xhtcFRMU00QJlDYZ+4Wo0dZNo7aqOGv4HmQx1TASf6kDI21lS9em6j2hLoFQk9YcLi2cwllQ+UwdMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RJuG2H3y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 49D1A40E0027;
	Mon, 15 Jul 2024 12:17:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8Vtsc0DUDhAl; Mon, 15 Jul 2024 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721045841; bh=+YWvB3+WTpnDtMqqGNaMhXgj0kOHzjlz8VXcq8FE3aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJuG2H3y7PA2XfdYWg3onv85NW6uz3qlYRSOVE0DOjjKRPyq7x+cF08H8sNdvbEfE
	 QUoX0yTPqrtHqOCVXr/n9rqJlR6YPp+LeoRlltVaYJiANSRsFxfKPduzBLx2vI8rJu
	 RM9YVLWkRz5tuA3XA58VODQ+hsDVUaIP5MhTEXl5DWsAZPriHkJpzdRR3lUvBkh8hi
	 fD2bsynGkhKJbZLgKdHRyfQLwgg2496EUbSIz3IEdbX9+mDYH43CMR+WdGUM0WioTN
	 jmU1g1frmzTeFcAh4pHTOKfN2Osyr7pfLlUnzLtuSW1MlsXcQPt7rhefso+UOPoeqO
	 wcXCvFSHxqOr4K8txBwDfbU3g1pPI69EWi5V69j1k8R8vIXiLQ1rE/G/ZjRPojgmNo
	 9Bmzj8WT8H4mI9mFrl7RT0yZL1UeGzVLHpvAFcrzM6iMCFHcaVM55BICLrkzD+uMaj
	 tdj9YGdkEye/nqJ+ZeSP2FCfXFbkN924dSIzqSmSN2HXbzvXnBddYlsdbCCacwLLig
	 nhNEV218xEDfUDd5u5kzaKRpASCFRNjCPVWqpeVHAPxGOltNEY2sQgjo8XwoJ+jQkG
	 O5BaZ6tAYCAwojFgmSpdQ+AwNWiqUpddVprR4OZenecMr4MbOX8BQkadfSyWAQZKq5
	 7/uQZ/6klHuyfNgvn8ojoLv0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AA9240E021F;
	Mon, 15 Jul 2024 12:17:10 +0000 (UTC)
Date: Mon, 15 Jul 2024 14:17:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] x86/bugs: Add a separate config for GDS
Message-ID: <20240715121703.GAZpUTP-8TJpZBCWne@fat_crate.local>
References: <20240422165830.2142904-1-leitao@debian.org>
 <20240422165830.2142904-2-leitao@debian.org>
 <20240712172132.GFZpFmHBJHte2xS1fr@fat_crate.local>
 <ZpUSvl5eKgkLeJrg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZpUSvl5eKgkLeJrg@gmail.com>

On Mon, Jul 15, 2024 at 05:14:54AM -0700, Breno Leitao wrote:
> Sure, I will send a v4 and get rid of GDS_FORCE_MITIGATION completely.

I'm actually waiting on the people on Cc to chime in whether we really need
it. The three distro configs we checked, don't set it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

