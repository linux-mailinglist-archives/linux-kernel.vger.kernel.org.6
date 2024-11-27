Return-Path: <linux-kernel+bounces-423625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BB29DAA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03DACB20B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E331FF7C2;
	Wed, 27 Nov 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t3dHPBKM"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374123C488
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720724; cv=none; b=rmAKTFz5IKU8IgCr/FAGvbQgvGxHG6ZCc4SGj5FRYViQCiwNe66+NnL4mDaMjhtxEeLj7ND6z5FYVVPXdCWxcsieNh+zr1rcjBgI8me5sr1zkA68Ali1XIObjWazcShNHrMhVKX3r0cB6Hh2goXlmDlxZmypZLWTqKrxCNlgWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720724; c=relaxed/simple;
	bh=AfZhUOwAGIe7rH/g8ot0VbCKG6OXOElzYXSFwCIXqtU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lBYoxF8Cw4LI/9EMw9jtl/B+B3tKpkJMfpga1SoKnyQ8ky4MCmryFjAUCpnU3Dkxm1nOLyXZO5NQaqjkYWoiOXV3A0gHf4spwa7iitXW1/HV2D9DGRen2Mcw8WL9ypDFAwSt0hiNEXQq3Zu7KuySIr758lx0lgfjHlnxysJ6Hr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t3dHPBKM; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732720724; x=1764256724;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Dfz7ZOwEsGUW2UNTOixOKdO6jXaVBAsB8AMeK1A77Qw=;
  b=t3dHPBKM3OQSfEEAgqt5JR6nmeBquzBklkoc39S/nhkxPfoIDdWmDN43
   IyTx4UvRUKzXQUVZ3n2wyGqDgTs+LO4JqraSI29cQN1gKFdr8WBHaHd25
   /TxcAhQNoZulRx5rRSjP8xSgT46AZ1hdw/+wJDIH6mWi37WJV/wQEuziC
   c=;
X-IronPort-AV: E=Sophos;i="6.12,189,1728950400"; 
   d="scan'208";a="446501929"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 15:18:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:36701]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.101:2525] with esmtp (Farcaster)
 id 6122bc30-f8c1-4ef2-a44a-11ca49975a65; Wed, 27 Nov 2024 15:18:39 +0000 (UTC)
X-Farcaster-Flow-ID: 6122bc30-f8c1-4ef2-a44a-11ca49975a65
Received: from EX19D013UWA002.ant.amazon.com (10.13.138.210) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 27 Nov 2024 15:18:38 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D013UWA002.ant.amazon.com (10.13.138.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 27 Nov 2024 15:18:38 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.1258.034; Wed, 27 Nov 2024 15:18:37 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Marc Zyngier <maz@kernel.org>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"bhe@redhat.com" <bhe@redhat.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH] arm64: kexec: Check if IRQ is already masked before
 masking
Thread-Topic: [PATCH] arm64: kexec: Check if IRQ is already masked before
 masking
Thread-Index: AdtA331124poMU/IPU6G/kDrShffzA==
Date: Wed, 27 Nov 2024 15:18:37 +0000
Message-ID: <78d8b93342124112bd4a9b64d9a93020@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Maybe a slightly better approach would be to simplify this code for somet=
hing that actually uses the kernel infrastructure:
>
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machin=
e_kexec.c
> index 82e2203d86a31..9b48d952df3ec 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -230,11 +230,8 @@ static void machine_kexec_mask_interrupts(void)
>                     chip->irq_eoi)
>                         chip->irq_eoi(&desc->irq_data);
>
> -               if (chip->irq_mask)
> -                       chip->irq_mask(&desc->irq_data);
> -
> -               if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_da=
ta))
> -                       chip->irq_disable(&desc->irq_data);
> +               irq_set_status_flags(i, IRQ_DISABLE_UNLAZY);
> +               irq_disable(desc);
>         }
>  }
>
> This is of course untested.
I tested your suggested approach and it works.
I will publish V2 for this change.

Thanks, Eliav


