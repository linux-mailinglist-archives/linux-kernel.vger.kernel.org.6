Return-Path: <linux-kernel+bounces-348198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D07298E3FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570461C22440
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB63216A22;
	Wed,  2 Oct 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TJOoRCxL"
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB781D0E28
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899911; cv=none; b=gJgtZZMLUrS2ySLubMts8L9K63dCaqDf8/SKHnS3OcJ+Ar+w25MfloVEnCWu9gVs381obTPcuAKZjqwlfgoU3nGtj8Kbc5nlp6U2a4wxU1MBJBswNc2Ih96ZWN3UUVObETi9bMGG69QH4NEF1MYSCkraTTvFxiJu/EYSFUShIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899911; c=relaxed/simple;
	bh=mTYcw7zHZJ+VThaFuXmBWm9cyXjdA8SzjFOkKMg0ofs=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=VM03cOUsHtwpyBV0sudIhvrr+6oz4BT5B/p2FEjoF9JjBgA7sCVSE2TVUrQkkOIybf1macJL7JpSTgkP6+x9ARdGMLpUfG/FtH1R9g/gAVG5Y/3i64HsKzw+tq7zO8LRqO980/sYwUpC1QeBXjc0/GgDsJ7pT0K4544NsjcZdag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TJOoRCxL; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727899910; x=1759435910;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=mTYcw7zHZJ+VThaFuXmBWm9cyXjdA8SzjFOkKMg0ofs=;
  b=TJOoRCxLh/ZLAbtoG96jcTCojHh8mO1eNhE+Mq3l5lxiG/zJxC/EM0Zn
   PBN1LOUBaJhKvLDFHjAu0sdLTgTZ22aA+VD6ICyF4IYWZY6y62asTkmd5
   e+G0wZwiV0kXLjrz9477bAWamr8u9DG2r8weFldqDWeWGlKLNaQZZUkmP
   I=;
X-IronPort-AV: E=Sophos;i="6.11,172,1725321600"; 
   d="scan'208";a="30127055"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 20:11:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:55650]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.199:2525] with esmtp (Farcaster)
 id 0a84ea2c-ae51-45bc-abb5-8d36745ecb63; Wed, 2 Oct 2024 20:11:47 +0000 (UTC)
X-Farcaster-Flow-ID: 0a84ea2c-ae51-45bc-abb5-8d36745ecb63
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 20:11:47 +0000
Received: from [192.168.12.142] (10.187.170.11) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 2 Oct 2024 20:11:46 +0000
Message-ID: <f4068cdc-2522-4730-b42d-991e886110ba@amazon.com>
Date: Wed, 2 Oct 2024 13:11:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <david.kaplan@amd.com>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <derekmn@amazon.com>,
	<hpa@zytor.com>, <jpoimboe@kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <pawan.kumar.gupta@linux.intel.com>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <x86@kernel.org>
References: <LV3PR12MB9265C353BEB73FA98A75681794702@LV3PR12MB9265.namprd12.prod.outlook.com>
Subject: RE: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <LV3PR12MB9265C353BEB73FA98A75681794702@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-10-02 14:28+0000 David Kaplan wrote:
> On 2024-10-01 22:37+0000 Derek Manwaring wrote:
> > On 2024-10-01 01:56+0000 David Kaplan wrote:
> > > On 2024-09-30 17:50-0700 Derek Manwaring wrote:
> > > > Maybe I'm missing something here - if you care about user/user, why
> > > > would you not care about cross-thread? It seems to me SMT should be
> > > > turned off for all of the vectors.
> > >
> > > I broke out cross-thread separately to maintain the existing kernel
> > > defaults, which does not disable SMT by default even if full
> > > mitigation requires it.
> >
> > Ok that makes a lot of sense. My bias would be to use the vector parameters as an
> > opportunity to make the SMT stance more obvious. So kernel's position becomes
> > more of "I disabled SMT because you asked for protection with mitigate_user_user"
> > (or any other vector). If no vector parameters are specified, SMT default would be
> > maintained. What are your thoughts on disabling SMT if a vector parameter is
> > explicitly supplied?
>
> Hmm, I'm not quite sure how to do that because mitigate_user_user
> defaults to 'on' (again, to maintain the existing kernel defaults).  It
> seems odd to me that explicitly specifying 'mitigate_user_user=on' would
> result in different behavior.  And I think many vulnerabilities that
> require SMT disabled will already print out a warning if mitigation is
> requested and SMT is enabled.  Open to ideas here...

Yeah this would be awkward. Maybe the warning is enough. It just makes
SMT such an exception.

> > > In theory, cross-thread protection is only required if there is a risk
> > > that untrusted workloads might run as siblings.  If techniques like
> > > core scheduling are used, this might be able to be prevented I suppose.
> >
> > True, though I think it's worth making clear that doing core scheduling correctly is
> > the user's responsibility, and the vector protection they asked for may be incomplete
> > if there are mistakes in how they manage process cookies. Just an idea, but what if
> > users had to ask for SMT to remain enabled if they had also asked for protection
> > from one of these vectors?
>
> I think the fact that some mitigations will print warnings if SMT is
> enabled might be sufficient here.  I can also add something more about
> core scheduling in the documentation file.

That works. Personally I would say make the SMT and core scheduling bits
clear in the documentation and remove mitigate_cross_threads since it's
not inherently two separate domains like the others are
(user/kernel/guest/host).

It should be clear that SMT is the one case where specifying a vector
will not necessarily give you sufficient protection (unless we can find
an intuitive/low-surprise way to disable SMT when required to mitigate
certain vulnerabilities for the configured vector on affected parts).

Derek

