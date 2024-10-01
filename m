Return-Path: <linux-kernel+bounces-345065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A338598B192
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D6A282CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F724A28;
	Tue,  1 Oct 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nQMkCisv"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B84A07
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727743816; cv=none; b=TcmYP1QaoZVdr9dQOBTRW4WQIt0efX3d90rPAuaWg5PcRpeW62oFBss0i3c7GMN64ECj9mnWXk0CgzP7+e7yw/RO2F0C/1ak6joKREqYcja+B4J4ccgp5C2pAFEtuz8aenQE4J6yLHJBC05rM9V9sVlEaLHewZWmS/BpIhd/StM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727743816; c=relaxed/simple;
	bh=nUsnwNZT6KTTkNS2id5ETl35QdiaRUy81YzL2of80Do=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=dbI3SqQZcF9rZ+I1j64NXSeQN+KIVRysPzfVTXjMe781VyM2hhF9QevLExYlPNjjT5d2B8vmUQwebDyDXmLZbNGhMi6YwZEpyGldBamTRe/885sOrMr366guHShKlRlkQM4GOLBHesanof2rUBAmftL4aj5eIOn8Q4RvFwJaQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nQMkCisv; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727743814; x=1759279814;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=nUsnwNZT6KTTkNS2id5ETl35QdiaRUy81YzL2of80Do=;
  b=nQMkCisvY8ZBBucqmphNiE5B0xZPjPpJhgWJZx9Sk/6AOYTdTyGL87rd
   VGNcMe8qI02xOmOCVC9xWz92jRFapmXecfIFs/yIJzZdJtOWqS3ubS1DA
   0fxBUft6XtqvRGyO6F2tL+CnhiANC/31pOXLQRBTaDrQatkJ7xXlItIxk
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,166,1725321600"; 
   d="scan'208";a="132718745"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 00:50:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:65129]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.198:2525] with esmtp (Farcaster)
 id 0666dd8e-fe00-4345-b966-ed7de26f925d; Tue, 1 Oct 2024 00:50:14 +0000 (UTC)
X-Farcaster-Flow-ID: 0666dd8e-fe00-4345-b966-ed7de26f925d
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 00:50:14 +0000
Received: from [192.168.21.242] (10.187.170.9) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 00:50:13 +0000
Message-ID: <2957b59e-25f4-4510-9053-8ad5067a60e5@amazon.com>
Date: Mon, 30 Sep 2024 17:50:12 -0700
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
References: <20240912190857.235849-22-david.kaplan@amd.com>
Subject: Re: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <20240912190857.235849-22-david.kaplan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-09-12 14:08-0500 David Kaplan wrote:
> @@ -446,7 +450,8 @@ static void __init mds_apply_mitigation(void)
>      if (mds_mitigation == MDS_MITIGATION_FULL) {
>          setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
>          if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
> -            (mds_nosmt || cpu_mitigations_auto_nosmt()))
> +            (mds_nosmt || cpu_mitigations_auto_nosmt() ||
> +             cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD)))
>              cpu_smt_disable(false);
>      }
>  }

Maybe I'm missing something here - if you care about user/user, why
would you not care about cross-thread? It seems to me SMT should be
turned off for all of the vectors.

Derek

