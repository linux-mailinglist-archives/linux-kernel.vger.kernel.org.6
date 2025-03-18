Return-Path: <linux-kernel+bounces-566784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D1A67C66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AF119C4F72
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759F1213243;
	Tue, 18 Mar 2025 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hw0Pjc9L"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3C211A33
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324155; cv=none; b=irNumPzmuZhT/6ztqJ2+6M+lXSq80VXQQViWmqH7L6VEGvmJ9UN9eA4jRJetib2C/9vSk8ANMas0EFnlolhih2NWCbK4Cmqg3rdzyRy9K0Wd7qw3adOKhLWl9fe53+qgbL86/jggaF3m8LAGU86FilwcGWJQsIPJl2YOImaF3Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324155; c=relaxed/simple;
	bh=TMyo8gbuXK0lIV1lDMeUJzqGDwGr5REmhccLiuoeuWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuQzwTzzHXTMjvuQ8szGmfUhXmGEjF9CnzRf4iwleQRoNBatOAnQxzx2W/AKuLnwvdNdREitfOlkk28BTG4oW+tW/wcMShnk6dkmp04zCY3IMmVc5RocIsW7PSxGUVkl6NNa/8F9yw7oLfGqVkKg95Xy8MQ8PosgIx2doxH3hfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hw0Pjc9L; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9952440E021E;
	Tue, 18 Mar 2025 18:55:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dMRoGKY10yrW; Tue, 18 Mar 2025 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742324138; bh=bVU12d8vc0ThIR9ofnvoWSzWZ5BjfILHSyzp4KSMSvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hw0Pjc9LIOtW4EWitT8tFCn/70CUvCRZAsGpbSQMxCudRATATvqhnCjy2DvVdo4mb
	 YaaX3Kq1ioqrLRnBkHQZEr+cQk+KvUb4GmZnxa0gBwvmX+fGHlzFIFKO9icIId4BbQ
	 wxOS4Onzv2NWWSbHdQKh6HprZst/2gWQhUah7msinlR5NuXC8iCkI/Taeta+UoxJzP
	 K//zj+F1Z6DkP/FWSP+sLje6wVXLBbNgS+BqsqjonujqZJoUx7nol9fytX+Cgph9ZM
	 Ya/qNid0PEDRxlfpNZ8nPzqfCFjMQsYNLg/SybXAQkiHcKXD8ZzV3Ubt1LJJm61ooR
	 RXogW2MdUwMQ02Zb4mcUMdbbMfHLET/ZAuu4tChSPzsmb6KMnyq9Ov3vJnjnkU3SiM
	 LwBbwo0fRIi2KL/5Nx/NMeO9L1k74whhvozPdruhTpZ6KH0kHtBXsVXzgleOWt7z6X
	 hv5qX4IaFSRiyyJ4zaAlFC8ZwN5Yx3xW6Ik/hZ0yLb/TCRHasyPcaJ6crSJoW6XBdX
	 w2SxO0BPlGV5eBNJBPJONf9x1Y03NZwc1U//HM65TzAtQKtOxpxPkx9IA5kMFuJ7k3
	 KNr91a9uMJntmSpnGDwKhGNa/WVQz08pamKztKDaGR3T2Dd9vRqsOUWMCY3Mkvm2I+
	 eKenW0ej1EMD0hZinoC3ElGU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4CAB40E01AC;
	Tue, 18 Mar 2025 18:55:26 +0000 (UTC)
Date: Tue, 18 Mar 2025 19:55:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: MMIO and VERW
Message-ID: <20250318185519.GGZ9nBl2VUP4ysb-tZ@fat_crate.local>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
 <20250313192606.iijythngqtpx4tyy@desk>
 <20250318141659.GDZ9mAWwa3dkQDHkCk@fat_crate.local>
 <20250318162505.3ptnegnjz46hchep@desk>
 <20250318163451.GEZ9mgq7XsE1kIyiSy@fat_crate.local>
 <20250318165645.lnutevfmtld3vu4d@desk>
 <20250318173708.GFZ9mvROyNagmhawEV@fat_crate.local>
 <20250318181515.42jf2p5onoueeg3v@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318181515.42jf2p5onoueeg3v@desk>

On Tue, Mar 18, 2025 at 11:15:15AM -0700, Pawan Gupta wrote:
> :D Totally agree. A machine readable format is here:
> https://github.com/intel/Intel-affected-processor-list/blob/main/Intel_affected_processor_list.csv

Nice.

> Likely yes, I will give this a shot and see how it compares with the
> currrent implementation. Thanks for the suggestion.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

