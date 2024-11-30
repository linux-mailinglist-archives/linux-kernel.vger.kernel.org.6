Return-Path: <linux-kernel+bounces-426430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB419DF2E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 21:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480832813F9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 20:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE0A1AA1F4;
	Sat, 30 Nov 2024 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lme9PQnK"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444A17BD3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732997466; cv=none; b=WYAn7gTLmW791azukcOpjLZ+UI7LRpMPwyzU8Tid9h45FlkO4fwxNrBobTNrWcUft7pYTf7K8eb4cQBA31hunhoSVBcM27cYu9emXSlSD07EfHKG7fnXe5a9GINBAU9dJgSEAPCNzJDT9q7vLug25NAB6KxjccPzrvfbAChdiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732997466; c=relaxed/simple;
	bh=gzh7UdfZG1FFrOTiOm/bdB68VTmIxA+0uUJLdCo2lNw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eu7eUXCcvFuGQ2qibfoHQsxRWurVqkbec9kAcK5LVnf1TxnheE+f1rPw7UnWi9fB5xWZkIAxKngWvLxjUpTdA+DVZLgKPCLHfXAVuSnt7240StDzqJFkzjtbwGR7P7B+Uo6PDjQjBsdIc+4INFVD8Go1Hv6e+kQnP+0KYy1d+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lme9PQnK; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732997466; x=1764533466;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=is582WBBi937WdWYFufHhkkhP+21AhVYgF4uiSgdXuo=;
  b=lme9PQnKIFhMMROhUB5EN+7ANdbopLN7W5GjH3TDm3Hfn2EZwTGXFrU5
   x/OUnGZLnSCaQf2fQOLy19P0f1Q4qVSmDF7HTQ7qM8OyvGtXCmJ2r9+wM
   +aVhobuj4tnwjwjEI0wtpnpz1LQbgt7+7beZ1SqFUvzyJ5fsvoLmt2hnB
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,199,1728950400"; 
   d="scan'208";a="699401236"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 20:11:01 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:31389]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.11.83:2525] with esmtp (Farcaster)
 id 120978b2-243c-4482-ad00-e4a375ddd09f; Sat, 30 Nov 2024 20:11:00 +0000 (UTC)
X-Farcaster-Flow-ID: 120978b2-243c-4482-ad00-e4a375ddd09f
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 30 Nov 2024 20:11:00 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 30 Nov 2024 20:10:59 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.1258.034; Sat, 30 Nov 2024 20:10:59 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Thomas Gleixner <tglx@linutronix.de>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"naveen@kernel.org" <naveen@kernel.org>, "maddy@linux.ibm.com"
	<maddy@linux.ibm.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com"
	<bhe@redhat.com>, "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"adityag@linux.ibm.com" <adityag@linux.ibm.com>, "songshuaishuai@tinylab.org"
	<songshuaishuai@tinylab.org>, "takakura@valinux.co.jp"
	<takakura@valinux.co.jp>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH v4 2/2] kexec: Prevent redundant IRQ masking by checking
 state before shutdown
Thread-Topic: [PATCH v4 2/2] kexec: Prevent redundant IRQ masking by checking
 state before shutdown
Thread-Index: AdtDY+7g3Mjx3Vru6kGTSk5UpEUWVw==
Date: Sat, 30 Nov 2024 20:10:59 +0000
Message-ID: <0e467b4c2bc34eb59c8f23f36a9a6956@amazon.com>
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

On 11/29/2024 3:32 PM, Thomas Gleixner wrote:
>> This patch addresses the issue by:
>
> Again:  git grep 'This patch' Documentation/process/
Done (in v5 series)

