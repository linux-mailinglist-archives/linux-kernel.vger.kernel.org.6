Return-Path: <linux-kernel+bounces-415084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BBC9D315B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612BFB21A66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B24E136A;
	Wed, 20 Nov 2024 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UowlDWHd"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DC193
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732061666; cv=none; b=hBx4el0ff0zwggXyvIUjAnnvdHzreiR3uapjlEcKD7mioglUYbo1A9iNrZtWfz2lTsZdmFSSYr5wTn9Jzkw4duKe3pnocguDcVNxi51/vq/3ajy4vGBHYQS+FyLxB8MMoAdKBvGUl2djZv0Rfpm1rKyzkTjsN31eZG738Kw8vmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732061666; c=relaxed/simple;
	bh=Gd/0Xv+NEIlB+gytnCJAHTqTsoWhAKBgTUwAXk+5u6k=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=mJbfxhm3sdzAPPjtGHnMXMZAOqiRh+TCkFCUQBxGmoOXyuIo5ToYNLtniUF3bwElr5C2I2dTH3Zg4RpGJS/HB/V6RO9Yq69QBjfP+AtFhfu4LYCeyT0eMbJPG1RiHvsrikfG479CUz575YJcUY6zdkVieSneXR8PoG6JH3KZvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UowlDWHd; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732061665; x=1763597665;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=Gd/0Xv+NEIlB+gytnCJAHTqTsoWhAKBgTUwAXk+5u6k=;
  b=UowlDWHde4lxLWE+FIxHnTDuZplFZwqSsYNz0qiem1nl8CxFrmnclz+3
   gw0FNCW22Jt4OeLnAhJ9g2Tyhr+uzenEE0WUbQrgRcugqXfPhNnAV6miV
   1tD2b0jpGzDk8tcOT4ZoJQ8lm/pchFMM/uBcy9FIo7m5E0uaKmiEeEmSe
   U=;
X-IronPort-AV: E=Sophos;i="6.12,168,1728950400"; 
   d="scan'208";a="450385454"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 00:14:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:14748]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.190:2525] with esmtp (Farcaster)
 id 9e273278-530d-449d-9227-8033cb9a5e88; Wed, 20 Nov 2024 00:14:22 +0000 (UTC)
X-Farcaster-Flow-ID: 9e273278-530d-449d-9227-8033cb9a5e88
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 20 Nov 2024 00:14:22 +0000
Received: from [192.168.4.152] (10.187.170.35) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 20 Nov 2024 00:14:21 +0000
Message-ID: <543c5064-3ad8-4fb1-b05d-0772d7ce1d47@amazon.com>
Date: Tue, 19 Nov 2024 17:14:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <jackmanb@google.com>
CC: <bp@alien8.de>, <canellac@amazon.at>, <dave.hansen@linux.intel.com>,
	<david.kaplan@amd.com>, <derekmn@amazon.com>, <hpa@zytor.com>,
	<jpoimboe@kernel.org>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<mlipp@amazon.at>, <pawan.kumar.gupta@linux.intel.com>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <x86@kernel.org>
References: <CA+i-1C1zN_GcLagTRgfJqT6uFoZaMZj1NUfxkvP7eG=VGQ0GGQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <CA+i-1C1zN_GcLagTRgfJqT6uFoZaMZj1NUfxkvP7eG=VGQ0GGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-11-13 at 14:15+0000, Brendan Jackman wrote:
> On Wed, 13 Nov 2024 at 04:58, Manwaring, Derek <derekmn@amazon.com> wrote:
> > Personally I wouldn't put too much weight on the possibility of
> > disabling kernel mitigations with these future approaches. For what
> > we're looking at with direct map removal, I would still keep kernel
> > mitigations on unless we really needed one off. Brendan, I know you were
> > looking at this differently though for ASI. What are your thoughts?
>
> [...]
>
> At first I wanted to say the same thing about your work to remove
> stuff from the direct map. Basically that's about architecting
> ourselves towards a world where the "guest->kernel" attack vector just
> isn't meaningful, right?

Right, that is definitely the goal. The approach is like Microsoft
describes in the Secret-Free Hypervisor paper [1].

Call me belt-and-suspenders, but I prefer to leave mitigations in place
as well unless the performance is terrible. Like rappelling with a good
harness but still pad the fall zone.

Derek


[1] https://www.microsoft.com/en-us/research/uploads/prod/2022/07/sf-hypervisor.pdf

