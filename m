Return-Path: <linux-kernel+bounces-444581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BF9F090C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFADD1679A3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6021B415A;
	Fri, 13 Dec 2024 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b="C1PSvcAg"
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9903A1B6D1C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084334; cv=none; b=tmWoF5W9OxfgGcrHqOuBhhd0zZpzRUuV/d2XGkfS+wsPjoDfqU4SacjqPCMg5QstN0MxMJe0aS2nptQLnY5RRUBs0CIP307osFt0n2y8LwelCEzDVZMIJdbPSIvxGwYw3M5FyUfP3OTQGQnoBDO3k8ENPWFZT0xwEtfN+9BUREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084334; c=relaxed/simple;
	bh=tH827m4h4XLHI6oAAXVZE+nLImUPaQ79hjHCS2ChNZg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ke39rNbV70DINIRQcUF4ZEfXp+3VEdZr5Kk6bZBPABnPeECjNJEhdAysKKU1l8lXgv9jI1935RB7iICXbkHa9y8a3uL3gHO75Vwit5a65LcPsrULgppN/ZS5khQIINyif5FMG6cdoCFQmuQE0AWhypJwy/uGXuou0T9O71oI2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com; spf=pass smtp.mailfrom=hughsie.com; dkim=pass (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b=C1PSvcAg; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hughsie.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hughsie.com;
	s=protonmail2; t=1734084324; x=1734343524;
	bh=tH827m4h4XLHI6oAAXVZE+nLImUPaQ79hjHCS2ChNZg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=C1PSvcAgJ+w3YeZgnXpRL+A4V4qpOa2UBMFNfzgNUSx/Kj+Qwz/yyCo3tebwd/S0t
	 C9G8FQc1Po3HfUlQ6JluyGfSBKYXihKNA8loSBYvny8e9Fi21MPvlF6dIGZQnfDGGv
	 4qbgCyXUybIKHg7gMzeaprKvKF4KfWPmqeKnDvKym6wRuEZCjtcfQQHxxSZ/0VbY1N
	 wNpsaxx/o8Ps1OHtaEgtcXFu8rAfo3j5IioBdp1XdufXFIV/Dq/7yswj4hi6vnnE4j
	 jhpccPYZzOWlaTEp7nyruz+JSj/Lai15h+v5srYVpAPZ3PnRZUUNpbZ8uT88XSk+1W
	 Dc+RN8Ur9+Fjw==
Date: Fri, 13 Dec 2024 10:05:19 +0000
To: Mario Limonciello <mario.limonciello@amd.com>
From: Richard Hughes <richard@hughsie.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Richard Hughes <hughsient@gmail.com>, ggo@tuxedocomputers.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some Ryzen chips
Message-ID: <vVLu9MdNWVCG96sN3xqjkmMVQpr_1iu61hX0w0q5dSQtFBi9ERc3b6hSoCjobPSTNgkIp3PBheheyUlayhMeQjShsx62zNqxWnPsrHt-xaM=@hughsie.com>
In-Reply-To: <20cfa4ed-d25d-4881-81b9-9f1698efe9ff@amd.com>
References: <20241209193614.535940-1-wse@tuxedocomputers.com> <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com> <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com> <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com> <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com> <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com> <6a809349-016a-42bf-b139-544aeec543aa@tuxedocomputers.com> <20cfa4ed-d25d-4881-81b9-9f1698efe9ff@amd.com>
Feedback-ID: 110239754:user:proton
X-Pm-Message-ID: 8c998f637c16f699820e7fb8c69c173bc45aab2a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, 12 December 2024 at 19:01, Mario Limonciello <mario.limonciell=
o@amd.com> wrote:
> > > > > Sadly fwupd/LVFS does not support executing arbitrary efi binarie=
s/
> > > > > nsh scripts which still is the main form ODMs provide bios update=
s.

Of course fwupd can't do this; it would be a huge security hole as the nsh =
script isn't signed.

> It sounds like some bugs in the implementation of the capsule handler
> for this system.

I've seen this with AmiFlash + BIOS.ROM, but never from a capsule. I'm pret=
ty sure Aptio builder is more than capable of constructing a capsule file w=
ith the correct DMI data.

> It's not an Insyde problem. I use Insyde capsules regularly myself from
> fwupd. I also know several other OEMs that ship capsules to LVFS that
> use Insyde.

100% agreed; Insyde firmware makes up more than 20% of the updates on the L=
VFS now.

Richard.

