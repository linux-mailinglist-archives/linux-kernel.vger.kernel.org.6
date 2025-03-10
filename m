Return-Path: <linux-kernel+bounces-554526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D12A59946
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF903A5CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CE422CBE5;
	Mon, 10 Mar 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CKQn2HDb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4022CBCC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619539; cv=none; b=TiQhX3TxakjlYbc6quyURsuC1ttjtlfSDxIhNG8qx27k7WzAwlFV/qaVBV7qC0P3Lc2qDNkBxg3xn2CUXf2yuNtekA+wep2XbIfQ6xsh8pNitfHVT974lfYwARsO3Is0HTlKht8G7D+LAPmioLmq3pnEnIDiaaw3iTLHQ9Mn76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619539; c=relaxed/simple;
	bh=DME2SwO8b7ZBt/TsHuhQzAmd4YlVhkofri53ykVfsg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTU2j/G7gjG9U1xYmRZpshQto5laTU1+1zFk2x1QqR7AKBlhxWVzeKBTAML3S2ByT0k8kLkUI1rH9tXboOWnJSTtNkdhAowlXcfh6cNemETn9ZVz7kcPwlndvpF0NrZMbBVMOlqreUFc+x8ds9Yg4evPwBPtghAUxbYfef5tHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CKQn2HDb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 302C040E0217;
	Mon, 10 Mar 2025 15:12:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t-wtFpHsHOr2; Mon, 10 Mar 2025 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741619529; bh=pQSxmlkxlccvpDW5jsYkjlJjniEAJj00sl/3YTg+wtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKQn2HDbVULJpJ/bwJD+YjA/oPMiEkR1+iXwpM7VS8Nkzy5QgrZF3NP9gjeemAxqE
	 W4XoCnaEoWFB0LQnOL6rwuga09vgHYVAIncCAY8F+SGIos/q47mubYJtq5doP/4YSO
	 nN0MKKFvK4FgLkXdU9fwXkJ4HIPu+6KuSV9Tbo/DSnLZ62+fA2Ul5GSPTW/sxcgGo4
	 kllPISXtdOVNqoRx6x7p8uXtS21xL17olIWvPr0t1GAZBmKoe2MZyxmbfTPyv2yMsU
	 PGSRR3NldO1Lx0+rsNbaxcSZ7HRhgWvjt5akfCgkFdnqwBVEFwUrMZ4P9fKRz6/Hgj
	 QdeBlOcxT9p0TEscLe/Xw5CsyiieSO8gE1sxXJC2J34ISehTVdSOKbGFzczSIkg/PK
	 gJD74Jwll+2UkPp7xnAY3QyamC4ioJkEuBe35X8QIBb3HoxOBEg/BG3d1LTJHGV0H1
	 RYGL97LyKxugM4/pMD2rxxoEPBRlRrUor2KNk8yhrsY8cIAaaLgsf4bwuxpBeEP57o
	 jagiDa+yHv3kBux1weYl3Xxz7VySDQ++O7Qrqb2ZnVfJmvhURw1WEzBb1q/2M+odm1
	 HXKV8Un5a7ZMlFebbs9n8Ncdorc8YdMEMRxxN3rvRjKILivTHpXBWcWJDaRnMfuTFr
	 k+pQrrlXfPo7dJSMJZnqCrEg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2537240E0202;
	Mon, 10 Mar 2025 15:11:55 +0000 (UTC)
Date: Mon, 10 Mar 2025 16:11:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Alexey Gladkov <legion@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
References: <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org>
 <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
 <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z878IRbbzIbUDQvj@example.org>

On Mon, Mar 10, 2025 at 03:50:09PM +0100, Alexey Gladkov wrote:
> Am I understand correctly that you and Joerg are proposing
> 
> /sys/guest/tdx/...
> /sys/guest/sev/...
> 
> ?
> 
> Which path to use for the host side ?
> 
> For guest: /sys/coco/guest/{tdx,sev}/...
> For host:  /sys/coco/host/{tdx,sev}/...
> 
> Maybe it would be better to add the "coco" subdirectory or something like
> that ?

Hmm, so we can do

/sys/guest

and extend

/sys/hypervisor

Or we can do what you're suggesting.

If we do /sys/coco/host, then we'll have two different places to read HV info.

Or we can stick *everything* coco needs in

/sys/coco/{sev,tdx}

but then it is coco-specific and if other guest types want to put stuff in
sysfs, it'll get ugly.

So I guess having

/sys/guest
and
/sys/hypervisor

kinda keeps it all clean, hierarchy-wise...

Right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

