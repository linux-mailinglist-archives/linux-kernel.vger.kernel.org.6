Return-Path: <linux-kernel+bounces-201223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1856B8FBB2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A500AB2B3BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D6214A4CF;
	Tue,  4 Jun 2024 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DLU+I6Sn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674914A09E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524170; cv=none; b=XfDx6M4ZddyHPIKORNXRYnBkPhoeZfxK8Rq57WEQDj0ht7H3aX5EC3g4yaMC9HH5NPZ3JEZAc06Xrw0/LKNogN1xZOGSm0maIAhH2bdYfF1KNEWJRdaHuMNOim36WWGnYWV0XrTKdBZzhXG0XZ7JGol24+zlUKYqUSP5h4j77n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524170; c=relaxed/simple;
	bh=Gb/snQsBVNfy1o6BzXAP6qQrBBYg5gFWkOAd71sStzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOCfzdqHfjdAM2BnrIoktGL5GfsABHLjNZqgMobHxFAci0U74hENnmjvn3fYi5zn/rYWCp8F6j6u6s65PJ2X8g5tnhGNQIAS82FuO7mN6nijVmpe6KXneBQgpjXYkOd+eV+IchRCWs+NrfU4jeeD+0WoidYfmqvJ5Se+bJR9JVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DLU+I6Sn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1992040E016E;
	Tue,  4 Jun 2024 18:02:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cMhfAxGU5kPl; Tue,  4 Jun 2024 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717524163; bh=GWrStZRjxuM92GFSBVDFKrufEIiFs1jygww4NQi9psE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLU+I6SnPlxE3Vi8Wxe3ScNZB3EkLajXpOeoexSJ3FsF11DOmq/kF7mUQWCTh2ZZU
	 9zC+xV6TAt4Ah13vFL2KhnpeImQh5VqXLrXNCRxgdqmPuwF/2lM+rMy/J4yj4Iozin
	 ZxTnySap2CgtkGMC9pdh3ly0va5Ab2W92LnO+AaAjUsYECWulD852NoRmi59uFRFfU
	 72PgimdmMwcBk0tvmwsfVjcFEczVP9MQnuu4DKwdb8Sc7lOB+dIw/7406ijBYvLDS3
	 b07CVT9qArX/RZjTB+qzs9rI0AfKYtNuRqP+YF+HaJPYra36zyWQ2mAMZE0hpL/ZAc
	 BPWBKnbypK0uhFRN23NWzm/KCqpEWOShUSmPDaIGJebyCKUafVrsVelPv36dLxzxH7
	 uvDy4Lm1OXwjTEnCvLQVj+3ePXJ1qXVcnsEE4Ie0oO0I0A7dhS1FRyuHujx94CEY+p
	 ZlAsAnS98zWsf5NoLQSrMoJ548mt0Hu8T6gCJN1CLkwqcX5ErL2aTWMb8iIXGlZpxQ
	 DTTlQ7UKT4e2wsy/0C9wHlbpIynoCuu3EpPYAu9jiQvD8OWDe3+nypU5dr7ChFcwLp
	 eg1R8UeQgPrdpM4heVAXU4L3nloB0w/+1MUkg/RNSYuKWIjoRUPTgMUrp2BvirSN17
	 C96SzSZAINkxGsML4ERfHRHc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B340740E016A;
	Tue,  4 Jun 2024 18:02:13 +0000 (UTC)
Date: Tue, 4 Jun 2024 20:02:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Young <dyoung@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local>
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
 <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
 <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>

On Tue, Jun 04, 2024 at 07:09:56PM +0800, Dave Young wrote:
> Anyway there is not such a helper for all cases.

But maybe there should be...

This is not the first case where the need arises to be able to say:

	if (am I a kexeced kernel)

in code.

Perhaps we should have a global var kexeced or so which gets incremented
on each kexec-ed kernel, somewhere in very early boot of the kexec-ed
kernel we do

	kexeced++;

and then other code can query it and know whether this is a kexec-ed
kernel and how many times it got kexec-ed...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

