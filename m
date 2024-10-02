Return-Path: <linux-kernel+bounces-348167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6445498E39E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019371F23EEC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D718215F6B;
	Wed,  2 Oct 2024 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aoxU6X7p"
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABF12CD88
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898019; cv=none; b=l2X4A8SL4XFZb6nNsDMfNktks/V8gIKhxYX6QDz7WZH504nYLhiUl9nykpH2qGsB0t2zaDYL9ZXJ88n6Km6jNjLDTKFSEbjftX8xbJ4u2bQvUa6ZgtSxjYQSi3QNyHH0sa8vkZBw+x+VKCEfanqbnt8tAYbPXQmGEGmx1TV2U1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898019; c=relaxed/simple;
	bh=iwh+oqeRoBL92+0CLMrUOc7HkwgYFMPLmpYEri2SiyE=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=nqCYLubu0YrX8HnwTGyzwwhPpEyVWg3037P6hfhcEV7WkJY8G1ZcZ8YnlgG0DDU2REhfTVDEx3bpmwchypuopeMGlUUES0xHASRUtNGfOjPobgHIyFUYAC/x5vj0S8N09gENIE2YwGrZehnPXg09qAjCENBcU/v8dPSuDyZd7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aoxU6X7p; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727898019; x=1759434019;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=iwh+oqeRoBL92+0CLMrUOc7HkwgYFMPLmpYEri2SiyE=;
  b=aoxU6X7p+dpPcI0/W/Q8DWs3MDE21tfZkaDhxRQy35btERkJ1aU90C+l
   ZKKgnWJdbMFO22tvMSA4GWTvFVZuJc9/Mb4vjfFYG0sI00gtq5RHs/Eeg
   5v6UCtHEqWxtWXLRw5UTMCBo1JX8hmqi1NuzgNeNvuwYu0brkHkVruArA
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,172,1725321600"; 
   d="scan'208";a="428357647"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 19:40:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:56435]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id 15db980e-35fd-4128-9ebf-79431764d76a; Wed, 2 Oct 2024 19:40:15 +0000 (UTC)
X-Farcaster-Flow-ID: 15db980e-35fd-4128-9ebf-79431764d76a
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 19:40:15 +0000
Received: from [192.168.12.142] (10.187.170.11) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 2 Oct 2024 19:40:14 +0000
Message-ID: <f5398702-18d1-4b1e-80ee-d1643c59b643@amazon.com>
Date: Wed, 2 Oct 2024 12:40:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <pawan.kumar.gupta@linux.intel.com>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <david.kaplan@amd.com>,
	<derekmn@amazon.com>, <hpa@zytor.com>, <jpoimboe@kernel.org>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <x86@kernel.org>
References: <20241002155049.zblyafe4zmnghqtw@desk>
Subject: Re: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <20241002155049.zblyafe4zmnghqtw@desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-10-02  08:50-0700 Pawan Gupta wrote:
> On Tue, Oct 01, 2024 at 03:37:13PM -0700, Manwaring, Derek wrote:
> > On 2024-10-01 01:56+0000 David Kaplan wrote:
> > > On 2024-09-30 17:50-0700 Derek Manwaring wrote:
> > > > Maybe I'm missing something here - if you care about user/user, why would
> > > > you not care about cross-thread? It seems to me SMT should be turned off
> > > > for all of the vectors.
> > >
> > > I broke out cross-thread separately to maintain the existing kernel
> > > defaults, which does not disable SMT by default even if full mitigation
> > > requires it.
> >
> > Ok that makes a lot of sense. My bias would be to use the vector
> > parameters as an opportunity to make the SMT stance more obvious. So
> > kernel's position becomes more of "I disabled SMT because you asked for
> > protection with mitigate_user_user" (or any other vector). If no vector
> > parameters are specified, SMT default would be maintained. What are your
> > thoughts on disabling SMT if a vector parameter is explicitly supplied?
>
> I think attack vector mitigation like user-user does not necessarily mean
> SMT needs to be disabled. For example, for a system only affected by
> Spectre-v2, selecting user-user mitigation should deploy STIBP and IBPB,
> rather than disabling SMT.
>
> IMO, unless explicitly asked by a user, the decision to disable SMT should
> be left to individual mitigations.

Maybe so. Agree on preferring targeted mitigations rather than
disabling SMT where possible.

Derek

