Return-Path: <linux-kernel+bounces-439849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E689EB4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90D618889D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FEE1BBBCC;
	Tue, 10 Dec 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VGGqgikX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A8A1BD9E5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844296; cv=none; b=XHgC/E/kUIQzWcxa5evYgf9p+Ys3JlRgNKbGRz82gMqm+eWvN6oamSy8CKm4haQihTk9WuZP1L8BN5RFlYBQTK9kUMkcB3xTNlpgvxzIV+swlWf5TRBGyJ5obw5HGBuxscIa8axUIHHRB95eaxyIHyUaxALOAl5hEzkcpOGfZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844296; c=relaxed/simple;
	bh=w7cRW37aIwMgbAxkar4v2dd2jSKC7M4dYC9rA8Lr/IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfVoZxngVmn2WFfLTpduemKCFkQTkYwKxrfMFPQf04W9JIwoHzFWZIZGzmQeEvsuyqhYpDIUk+vEAxAmDanjSQC5J9excMjVPOXgsOhigaQFFr1vfuReLOdh9mxVE97ZFNnvRKYL8VAnTnfVN76JZ4rlcjnM0Jv3eJXCclyG1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VGGqgikX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4E09C40E0289;
	Tue, 10 Dec 2024 15:24:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C6PoGVgyoT7I; Tue, 10 Dec 2024 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733844289; bh=6FZeB9gifnWioTVScw8pWuhLQenwojnd6vXc2RHOVdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGGqgikXXHvfkKpuw2kDpzPpaVSOphdV5NgSkKCi5l69eIIP9Toc1Ts0TVHf94HMV
	 5+ODqG2izIK6P7loow9Kqqeh3ZFMv0hDXo5ZgBdWXle3rKhBK+nNbxxbiBNnq0052E
	 JeQI9Yo9h6h+YtM0SUCANx1y3jjnbX+QlTOzKcBz+1EwH+7lSCUjCmM81ZavOP0WZ2
	 rqitQNux1Tut/moLpihqIDUFUc7mXm9B1BZYODTeJgOiN3CyybsAUoVNgAjvwMQiFW
	 4Ekwv62MwYcxImcE/0NQY5LOE1qzmJiLtXn7zKlAg3fRzpXdDAfqrh8XnJe6e3qFXF
	 9UP+Al+obtc7j8u6rPK+RtL3JZUI4W3X/j0/ddvAfdak/AYK2LXE0UJG9ovGTi8eLt
	 RlfO1qBvnFN0kNYBrWGwkJiQhBbrvxITDHpViUnoX+q8KCJJ2tYJXhfT0bXEst8hg/
	 IpQgsqjMWEaL1J7yYJGpulf7lZzMDYRDXtFTbt4ne/r49Cjtc/mbRsO73cF6XME5Kj
	 UX2maz5GShHoiYU3YlxDDdg/LfXAkVX82ruft6ttgrIc2FWY3r6BbwC181cUGYZL8L
	 uVRyeBtOEH3OvBkwZqXTXXQW/ERDWYmFw3ALiC/QB0UPvP0mjd/TTi5mCqhUCC6+kR
	 hj801TseYkStRFuc2FQBGm1A=
Received: from zn.tnic (p200300ea971f930C329c23FfFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:930c:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DF1640E0288;
	Tue, 10 Dec 2024 15:24:39 +0000 (UTC)
Date: Tue, 10 Dec 2024 16:24:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/35] x86/bugs: Restructure mds mitigation
Message-ID: <20241210152438.GCZ1hdNlfm11njllGk@fat_crate.local>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-5-david.kaplan@amd.com>
 <20241114030343.ewjeiyisjycjlxpo@desk>
 <LV3PR12MB9265C416BD54AC3203389553945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265C416BD54AC3203389553945B2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Thu, Nov 14, 2024 at 03:01:54PM +0000, Kaplan, David wrote:
> > > +/* Return TRUE if any VERW-based mitigation is enabled. */ static
> > > +bool __init mitigate_any_verw(void)
> >
> > s/mitigate_any_verw/verw_enabled/ ?
> 
> Ok

Right, except "verw_enabled" asks whether VERW is enabled while what we want
to ask here is whether mitigation through VERW is enabled.

So verw_mitigation_enabled() perhaps?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

