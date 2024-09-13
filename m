Return-Path: <linux-kernel+bounces-328359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C57697826C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5577B20DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FBAB66C;
	Fri, 13 Sep 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jeTg9nsf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202B6FB0
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237232; cv=none; b=Q8DlnRdSde3YKMrhXBVFHV0u+YSfc0ST7DGswGMFWUm03A4mwDAY5bCyhmgli+/f9IPV47qgmSkP071hUvP7HhisPjFX5m6iOGBIA4/GTaKaK0JOF9gKLtR1m4+2iyEK4bveP5GgnOIp8tJpQ4mq1qNYHD2kTVoLQ2P6GLjYLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237232; c=relaxed/simple;
	bh=LbrdxWZP6SmKFDlv6xWujTUAzGWg+nd/jQVvo10eTHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIBKdl8xQR369sGNcj+FDmz1J3nBfs+oH6WYam5MBOyd7zkqgKTsb+bhNDZgy3RHy9sO2qSsNZXdhEcGlipD61VhbQya1Gxrs53ay4tjtf3cpRCruXmBkJon7wwRy6gDVAJpKh/+EGRreiwnued+sZ6dTGZRv9GpasCsVeNaHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jeTg9nsf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4A4D040E0288;
	Fri, 13 Sep 2024 14:20:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SnMObGLRW4gG; Fri, 13 Sep 2024 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726237222; bh=aA11WTU3egHjyLaGShregclRHe8W1dy58KR4A5tHZNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jeTg9nsfW7170PGWd6n7W2bcZJJPR7Z0L777Lej9JOtnCZBPP5Ja1UIxu3Y6+Dck7
	 YYF0IQVGUrjz8n43lbYktovR+zs2hk00k7KvtnD6Z3vOVxJZHASLf+2W+qcvF0/FEW
	 YvppJONsaVjECgl5ZFqpK775B7xc3OlAw+M0Az0xKfJr778tqm5rLabZyKp/Ta8tFN
	 iO31alxKVye735ATuYOQV1q3ctehk+zQmBa+V9PqNxvo1AHKu7xlMBYCKhyWCT4wxZ
	 nGYvA0LVIe/9cnFUhhWjPOvK2PxEmLvYIeDmTKjcDafd4l6r89k+NlL4Vgnf4e0Xuw
	 pGMmmt0PPJB6Fw1ekcvWtNZFIMMC/lXa249oyANjWO44YZxH49VOTVXNSDBGIY/GWS
	 tK/xI/ZIo+vvBErL9SsaJcrb4mhbSok1EhEuKV6z5YMFvRhB+knPOxSk4Q4ND/kawX
	 dt4QC8Z6+9GLDVSLjJjfDv8yWmvNR6DfCCPYqKF8Y/1aUo298ZEnI/YRTuvNtTJ4AB
	 0d7e50Lzt7mU/GmoWMCVsxuk5p6TnLJyq0pxkg5g0Rvsvax5rNQ0ZjOKD+7NVk91gr
	 z1gw0J0p8yHN/YzY8NYN06hZFeoY63eHLB+flnzDyb9vArW4pu3srtvWTd6t5IU4qt
	 eAR84wjR7XgjggwUrnNXeSJU=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A02640E0289;
	Fri, 13 Sep 2024 14:20:11 +0000 (UTC)
Date: Fri, 13 Sep 2024 16:20:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 27/34] x86/bugs: Add attack vector controls for
 spectre_v1
Message-ID: <20240913142005.GAZuRKFXEG9v26rezp@fat_crate.local>
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240912190857.235849-28-david.kaplan@amd.com>
 <8a406835-b985-415a-a944-25d0ebea4fd0@intel.com>
 <LV3PR12MB9265FDD41382B1271DB0305E94642@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265FDD41382B1271DB0305E94642@LV3PR12MB9265.namprd12.prod.outlook.com>

On Thu, Sep 12, 2024 at 07:57:50PM +0000, Kaplan, David wrote:
> > There's also added complexity from having 'enum vulnerabilities' which
> > basically duplicate the X86_BUG_* space.  If the infrastructure was, for
> > instance, built around X86_BUG bits, it might have enabled this patch to be
> > something like:
> >
> > -       if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) ||
> > -           cpu_mitigations_off())
> > +       if (!should_mitigate_vuln(X86_BUG_SPECTRE_V1))
> >                 spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
> 
> That's a reasonable idea.  One issue I see is that there is no separation in
> the X86_BUG* space for spectre_v2 vs spectre_v2_user, but they do have
> separate mitigations.  But I think that is the only missing one, so maybe it
> just makes sense to add a X86_BUG bit for that?

I think we should do that. That's less complexity in the mitigations area and
those are always welcome.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

