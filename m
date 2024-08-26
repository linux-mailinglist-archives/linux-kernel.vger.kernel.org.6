Return-Path: <linux-kernel+bounces-301374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D495EFB4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6ADF1C21548
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF0215530F;
	Mon, 26 Aug 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tUWfctqG"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414FA153812
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671629; cv=none; b=Wy5DUAHwQGVoMWBUvcxyjyD3bK6feWOQ1MBOlTaMkpewyPaAaJdjrmL+ilt0tY8BG/UXB0ha8apWp1GlmRicd3bevuSiSKB7QaXaBxz+FlOeXUC8VO7H3jqrmF83j3MgfYA7NsfyArhhyxdHIORX8RVERyHY3KJGQWLHHYN8iSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671629; c=relaxed/simple;
	bh=T0spuN2G2JzwHL0AT4r8AVwGKYHk+bpHmxpiRQDhRl8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=LrXuJsnpj+oaAThdNxKSadD2UNkrrveSnYBXTwm49KcCYQMXMYd2XrD/2dOEUBCN0qxuXqvMSV3wAIe2Pkoda0oIF+Ks1u6iew+1hz02T1RO3yhVBQbHrKAGCmPVOYn8JooVgLYJoVmWefhiEhlx43vQkjPO+RaKxbGOEeFM9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tUWfctqG; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724671624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJ/1Sezp5GYiuScwqkxpgHxnqF9merpQv3ubFsNqKfQ=;
	b=tUWfctqGadyzuNFW/oEvl0rSLkVGYswKFj1OKYiM0+ttOE5ZHQV62gP266M4nm1XSuWh6n
	hmhhPZltfHRdU+je9YuZhLzDSOyk1rkvy0tRoVbyisW5a8QW8TxrSuXefq5fhRJoj5m1uP
	L4MtHGCeM2CVRKxIRIMwKwMNPouzN/s=
Date: Mon, 26 Aug 2024 11:27:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jeff.xie@linux.dev
Message-ID: <93bfdd5f320ebd62087b932ba9c227cff60ab60e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] genirq: procfs: Make smp_affinity read-only for
 interrupts that userspace can't set
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, xiehuan09@gmail.com
In-Reply-To: <87seurd057.ffs@tglx>
References: <20240825131911.107119-1-jeff.xie@linux.dev>
 <87seurd057.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

August 26, 2024 at 6:55 PM, "Thomas Gleixner" <tglx@linutronix.de> wrote:



>=20
>=20On Sun, Aug 25 2024 at 21:19, Jeff Xie wrote:
>=20
>=20>=20
>=20> The kernel already knows at the time of interrupt allocation that t=
he
> >=20
>=20>  affinity cannot be controlled by userspace and therefore creating =
the
> >=20
>=20>  file with write permissions is wrong.
> >=20
>=20>  Therefore set the file permissions to read-only for such interrupt=
s.
> >=20
>=20>  Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  v2:
> >=20
>=20>  - Updated the description suggested by tglx
> >=20
>=20>  - Corrected the return value from -EIO to -EPERM when the userspac=
e can't set the affinity
> >=20
>=20>  kernel/irq/proc.c | 10 +++++++---
> >=20
>=20>  1 file changed, 7 insertions(+), 3 deletions(-)
> >=20
>=20>  diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> >=20
>=20>  index 8cccdf40725a..7b3a4c92d148 100644
> >=20
>=20>  --- a/kernel/irq/proc.c
> >=20
>=20>  +++ b/kernel/irq/proc.c
> >=20
>=20>  @@ -142,7 +142,7 @@ static ssize_t write_irq_affinity(int type, st=
ruct file *file,
> >=20
>=20>  int err;
> >=20
>=20>=20=20
>=20>=20
>=20>  if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
> >=20
>=20>  - return -EIO;
> >=20
>=20>  + return -EPERM;
> >=20
>=20
> I drop this hunk as it is unrelated to $subject. That want's to be a
>=20
>=20separate patch. Documentation/process clearly states:
>=20
>=20 Solve only one problem per patch.

Thank you for the reminder. I overlooked that single line change, which i=
s indeed unrelated to the subject. I'll send it as a separate patch.

> Thanks,
>=20
>=20 tglx
>

