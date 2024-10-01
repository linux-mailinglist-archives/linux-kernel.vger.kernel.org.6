Return-Path: <linux-kernel+bounces-345062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD4098B18B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A66282B6C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E86AA7;
	Tue,  1 Oct 2024 00:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vuctzrAV"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AAA4A21
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727743455; cv=none; b=BwGY61g+Q+ICaM8WcxlK5xQDCxEUwLIvTj6WiDeeyL6nDYtREZpC/RkAk6NS/psNcelGQBlwSznkxpREegAoJ85HuGKddAD5EP83y2ep3ZRFHiDQtbKGiAgbU1IdZ3Ltszn0SeMxEZykAswsEO8Oi8w6d4afqRmYapn6jPJULj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727743455; c=relaxed/simple;
	bh=GK3M6q9rNAKLq+c75UTaxPvpPpla4aWh8G/7ksxS9uc=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=cxHtSQQk0FCniGUPn4VYTCTAPgnfBNv8K9xaLJom2tiJJ1+xEC7KNBd8EVhT/fAGB01Fmn8/vORInE824Ro1ycIS5+YiYeaUeWNH0liZ76MxPDoUCeTMhx0fhHTK98fHmCn8xlKZ8rN7ADTqw6eJb5rkGxYA1zbzv7zisP1QVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vuctzrAV; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727743453; x=1759279453;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=GK3M6q9rNAKLq+c75UTaxPvpPpla4aWh8G/7ksxS9uc=;
  b=vuctzrAVdqYVUGAqTEZwmrM+RBNgWEazTPDDZogIuLIyf594mp/WNeaK
   zpyC2oY1m449YCvBgF0onv12RaX76J3NXE7GKHXTCZPeq5MWmv0k4IjmR
   qMJUKMzzmT1+8RcysAeUH6IXETxA3GAv6QnJCpbJEICTDfwKYTuh+EIM8
   o=;
X-IronPort-AV: E=Sophos;i="6.11,166,1725321600"; 
   d="scan'208";a="133194019"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 00:43:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:57047]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.100:2525] with esmtp (Farcaster)
 id c36fdab9-30c4-4815-927f-e024a95678ef; Tue, 1 Oct 2024 00:43:50 +0000 (UTC)
X-Farcaster-Flow-ID: c36fdab9-30c4-4815-927f-e024a95678ef
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 00:43:50 +0000
Received: from [192.168.21.242] (10.187.170.9) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 00:43:49 +0000
Message-ID: <322d7585-44d0-42c7-bd45-8896b88e7882@amazon.com>
Date: Mon, 30 Sep 2024 17:43:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <david.kaplan@amd.com>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<jpoimboe@kernel.org>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<pawan.kumar.gupta@linux.intel.com>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <x86@kernel.org>
References: <20240912190857.235849-19-david.kaplan@amd.com>
Subject: Re: [RFC PATCH 18/34] Documentation/x86: Document the new attack
 vector controls
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <20240912190857.235849-19-david.kaplan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-09-12 14:08-0500 David Kaplan wrote:
> +
> +Summary of attack-vector mitigations
> +------------------------------------
> +
> +When a vulnerability is mitigated due to an attack-vector control, the default
> +mitigation option for that particular vulnerability is used.  To use a different
> +mitigation, please use the vulnerability-specific command line option.
> +
> +The table below summarizes which vulnerabilities are mitigated when different
> +attack vectors are enabled and assuming the CPU is vulnerable.

Really excited to see this breakdown of which attacks matter when. I
think this will help demystify the space generally. I am tempted to add
even more issues to the table, but I suppose the idea is to limit only
to issues for which there is a kernel parameter, is that right?

I think it'd be useful to get to a point that if someone comes across
one of the many papers & issue names, they could find it here and have
an idea of how it impacts their workload. Maybe this isn't the place for
that kind of a glossary, but interested in hearing where you see
something like that fitting in. If we could at least add a column or
footnote for each to capture something like "SRSO is also known as
Inception and CVE-2023-20569," I think that would go a long way to
reduce confusion.

Derek

