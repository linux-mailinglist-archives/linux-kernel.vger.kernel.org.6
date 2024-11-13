Return-Path: <linux-kernel+bounces-408458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331CA9C7F10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D296C1F232E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6745B19995B;
	Wed, 13 Nov 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kJGCGHqK"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C3118DF97
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542318; cv=none; b=EyVd9xf52yAXABaacot9ba0Y8fsiyDv7VrGMxGJG9JAXYilhFxcf06viK9x/RJyXlVcXUsRK2zJivyxp9Gm8vWLuUOj05R/545ec+XMZIDu9YKarxKfpOVwXOYJ+r+2NxRCuN042Big+WIroBU9Dr8NbhF1z7q9Q6Qc/zDJDJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542318; c=relaxed/simple;
	bh=qNFOGb/475LpTCfktJkSeIqh/NFD0ILfDjkklEJLjX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VwdLX/1UYeEFO0psNWai6OPUYqzTpyv+P2qjzl30euda1a9WZIEe3Ph6OTTtgYaBaklgdFXOV4n+sF5qosxsPto8Lbsk6Kuo1UgN6CLDsIEXAmLCCi9eWFms5eJD7D/GZQ4FkJG87DVqqKLD5Pb1i35rWVCso+CNM2C2IzBlpZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kJGCGHqK; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from graphene.canonical.com (1.general.amurray.uk.vpn [10.172.193.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 100533F10A;
	Wed, 13 Nov 2024 23:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731542308;
	bh=L3vAYpr0FAKJrUrRksYx6expnyYyJNqQs2e9B6fW6iI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=kJGCGHqKMPZB6jlM4615b/cehuceDm9t/A6yo26q3ywIInaGckRwxotpvvEe2P2+x
	 kBOnBYhRO69nb72oCF5JG3OMU9ErY/3aeSzfIKDHKE+LJahnOifsdLAV0EHoYdiwYL
	 U9QSBUz8iM/syKNIx35Yc4lyB2vxWksl1ywNX2CJZan1q1bM+M9pCBQu44lCuzF+5U
	 UG2Jg9xbmq+9tOPLFEIxjTGQtCX9SVmQlCTXrTmDhohAq29LLyiMhqQHw9AHzVyanN
	 TBjGS0wCEFGiCaQ49gi4SkdBKyazrVjlol5EIs3YEi/sXNqzN6LN51u6c5OIUHr4Lt
	 8w3pKO6+Haudg==
From: Alex Murray <alex.murray@canonical.com>
To: Dave Hansen <dave.hansen@intel.com>, dave.hansen@linux.intel.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 x86@kernel.org
Subject: Re: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode
 to be a vulnerability
In-Reply-To: <7fc07eff-b4a1-4f8d-a9de-dba057d5c9c6@intel.com>
References: <87v7wtvty0.fsf@canonical.com>
 <1c1015f8-1a47-4e5b-b088-f83054d2f613@intel.com>
 <87iksrhkv8.fsf@canonical.com>
 <7fc07eff-b4a1-4f8d-a9de-dba057d5c9c6@intel.com>
Date: Thu, 14 Nov 2024 10:28:22 +1030
Message-ID: <87h68avg81.fsf@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 2024-11-13 at 08:00:26 -0800, Dave Hansen wrote:

> While I applaud your trust in my employer, I don't see quite as bright
> of a line between security and functional problems.
>
> Here's the bottom line: I agree that setting a taint flag for old
> microcode seems like a good idea. But I also think that there's enough
> of a "vulnerability" (security or otherwise) to justify placing
> "old_microcode" alongside the CPU security vulnerabilities that have
> known exploits.
>
> I'm lazy and don't want to read and filter the microcode changelogs.  I
> also don't want to have to trust my colleagues to precisely agree on
> where that line is between a security and functional problem.
>

The only other data point then to mention is that all the major distros
(Debian[1], Ubuntu[2] and Fedora[3]) are still only shipping the previous
security update release (20240910) in their stable releases - *not* the
more recent release with the functional updates in 20241029 - in which
case anyone running a current stable release would then show as being
"vulnerable". I can't speak for the other distros, but for Ubuntu we
generally only ship things which are called out as specific security
fixes in our security updates *and* we generally prioritise security
updates over bug fixes (which these 'functional' updates appear be
rather than fixing actual exploitable security issues).

> So I'm leaning toward setting:
>
> 	TAINT_CPU_OUT_OF_SPEC
> plus
> 	X86_BUG_OLD_MICROCODE
>
> and calling it a day.

Does this mean you are thinking of dropping the userspace entry in the
cpu vulnerablities sysfs tree? If so then I am not so concerned, since
my primary concern is having something which looks scary to
users/sysadmins ("your CPU has an unpatched vulnerablity") which they
can't do anything about since their distribution has a different
definition of what counts as a security update compared to the upstream
kernel maintainers. If the sysfs entry is dropped then this is not so
visible to end-users and hence there is less panic.


[1] https://packages.debian.org/search?keywords=intel-microcode
[2] https://launchpad.net/ubuntu/+source/intel-microcode
[3] https://packages.fedoraproject.org/pkgs/microcode_ctl/microcode_ctl/fedora-41.html

