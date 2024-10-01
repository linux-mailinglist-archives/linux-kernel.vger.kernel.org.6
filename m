Return-Path: <linux-kernel+bounces-346734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E300C98C82A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BB4285D54
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066C1CCEF5;
	Tue,  1 Oct 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qSwCjk65"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3C19F48D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821306; cv=none; b=sVc+HvfsIinoAf12h6cHWooM0Ve8jk0sL3rsgGiSxE66aKeuALSFRiZEvs1TNi/7oZhK63TIsUQgxYBaqXFeI+h0Gmh5rsK4fVFQL+kdFcIgeIFk6SmBTRFQlcynR84vwYzIVXTMN9FCGzMSX7xM++VMOUI/SuwY+4xdAFd1wdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821306; c=relaxed/simple;
	bh=xrmizkzN1s2bK0XA3lk1PfCYFqKkmvpZqjWYCaMyW70=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=bxr5uwujMiJdVeSzRpbTQiQGVGQs42QtWoOECag0fxip8WMDt0NmvQjg0ReEVozGTHj5HaqXq/5BZQR19kXyDoq97jpDuKvs9Xkxhv29zIJWehGqFcRzjT6RF8t/JzyQ7XN6m5+dR91fLOwFFiDFnTe4mMQDXTRS7lmShwe5Nwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qSwCjk65; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727821305; x=1759357305;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=xrmizkzN1s2bK0XA3lk1PfCYFqKkmvpZqjWYCaMyW70=;
  b=qSwCjk65NZdts1hM3sheNOZg1y7hFfv3hCy4I2WzXAbrAcLNtRBzVXZ5
   HOOy6EZA4XhY16q7fhv5js1jD9E3IQtpl3BU/XnwFwhKCjG7WcVgzkqNt
   I1PcI6I64rmh15w7Dxf28moVrrCiEhIHLQm2c7Q8iivqQ0kySkrAlZDnZ
   8=;
X-IronPort-AV: E=Sophos;i="6.11,169,1725321600"; 
   d="scan'208";a="338331257"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 22:21:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:43754]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.100:2525] with esmtp (Farcaster)
 id 1a6d3736-1fb2-47f4-b482-180f504faf55; Tue, 1 Oct 2024 22:21:44 +0000 (UTC)
X-Farcaster-Flow-ID: 1a6d3736-1fb2-47f4-b482-180f504faf55
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 22:21:44 +0000
Received: from [192.168.12.162] (10.187.170.38) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 22:21:43 +0000
Message-ID: <7d2e1c7f-d778-4a5a-b566-6f99a1d78838@amazon.com>
Date: Tue, 1 Oct 2024 15:21:42 -0700
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
References: <LV3PR12MB92651C6977B4F6F701416ED294772@LV3PR12MB9265.namprd12.prod.outlook.com>
Subject: RE: [RFC PATCH 18/34] Documentation/x86: Document the new attack
 vector controls
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <LV3PR12MB92651C6977B4F6F701416ED294772@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-10-01 01:53+0000 David Kaplan wrote:
> On 2024-09-30 17:43-0700 Derek Manwaring wrote:
> > I think it'd be useful to get to a point that if someone comes across one of the
> > many papers & issue names, they could find it here and have an idea of how
> > it impacts their workload. Maybe this isn't the place for that kind of a
> > glossary, but interested in hearing where you see something like that fitting
> > in. If we could at least add a column or footnote for each to capture
> > something like "SRSO is also known as Inception and CVE-2023-20569," I
> > think that would go a long way to reduce confusion.
>
> That's a good idea.  One thought could be a new documentation file which could
> map CVE numbers to vendor/researcher names, kernel options, and related
> documentation.  Some of the issues already have their own documentation files
> with more details, but not all do.  I tend to agree it would be nice to have
> something easily searchable to help navigate all the names/acronyms.
>
> Open to other ideas on how to present the info, but this seems like a good
> thing to add somewhere.

Great, yeah if not as an addition to "Summary of attack-vector mitigations,"
maybe a new table in hw-vuln/index would be a good place.

Derek

