Return-Path: <linux-kernel+bounces-554341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18DDA5966F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B94E3A48B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F53D229B1F;
	Mon, 10 Mar 2025 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Kau4rZI8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB122423F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613798; cv=none; b=FtvRdLARPi8L/tN83zWMwXC5rNPFEMlNfW6LHNMgVIe1I5o2GPJn2Enp9BpUeZ6YhW9HQDuwP8li78otWWXmRCgeEL7Nq42YBzg/sm6xHOZ8JTl66wyiEiE5sdryWZbWvQ0Duxxr2LxouD91EYW5soxHVcVt3U7Jy0LU+19Gz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613798; c=relaxed/simple;
	bh=zPZPUSL+xxtxKpQAw4EcOLFGmXy81ebmY5Mt9sxzg7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SteffyJK57VO4p+D8RbDapELDa3A+CkdF/H9jjFPvD87EJ4UOJ1yDr1Y+Tz1V8AeUPSDU8ulnmOVnSQCVT4MoF1P39M4RubXtWazRC1LfVZUcd2pvCImKp8zpExuKbEwqO9KxlPTlduJL2Jm0bdLCty3W5bMQqpQZ1tWNp48jxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Kau4rZI8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1FB0040E0217;
	Mon, 10 Mar 2025 13:36:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Dompv0sQB_t6; Mon, 10 Mar 2025 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741613790; bh=AjksVXTEZQDSlFCd0yXoXcufe/xKz9QfW62wg7r11Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kau4rZI8UGAx+KBmiY3Gughu7GgnDpxiMXUxYw8EnZeAwTmRQIapcD1a+CtASzj99
	 uFY3cYdV7amfuF0Komo3GC+CDesWmgqHZl9cKqt9bt9T+3ZYzw+oTjiLnDt8m8mwp7
	 hiBqNNea2+zQJHjkylc0TwCqGMMXND+m+RwMUYdfiDogttBJ8Qg3UevtGcRpLqcDRP
	 rHOA0TAMTQkN2cDWKOPrdHfZ7p4QmQ9yPR2CcgrsgUj+NavMT1+Fj2yKyenG3I7ksv
	 heQYM328Ni6GKF6YxTPVI0FW+RqTXb+1V6R66pumfNe5SHPJo1xzHLoE/MhH9cMxf6
	 vH1qiVMq1MToj0Bju8pk5Kgj9s7mXWdUmKi88Ud0i+y5rear/Focj0g3t69+sn2uHL
	 hV6aZ9gZygUWhqPQijjxqRWnD98exak9AdHoZ62iwFFVNfp5oR6wfgmzbCRNIDz3E5
	 Zs93JsVa2cVDtUdK1tvWrJRPzATTkcEOXaZJBona2vb+aGOMlGe3T8Di+QEZD0249C
	 eQp8H0dDJStguY/1qBDz4EvgGdDmT6PV22lThANNf+EPGXFTbPqraA9EK9WG5nyDAQ
	 0SO7uz1IUsMaeUdX6BsqqD4wlAIlRd21r6GCQpk2QykQWgTKrjSPFx2SUc5HONDBwK
	 qd5SWPt1bJTyMRG5HA3nGta8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37B9F40E0214;
	Mon, 10 Mar 2025 13:36:18 +0000 (UTC)
Date: Mon, 10 Mar 2025 14:36:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250310133612.GGZ87qzKTHsjHMY9U2@fat_crate.local>
References: <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org>
 <20250310110202.GEZ87GqgEJyhJtde0I@fat_crate.local>
 <Z87fFRbg9V_x3u1v@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z87fFRbg9V_x3u1v@8bytes.org>

On Mon, Mar 10, 2025 at 01:46:13PM +0100, Joerg Roedel wrote:
> Right, it is not really a good human-readable interface. On the other
> side SYSFS was always an interface targeted more towards tooling than
> humans, therefore the one-datum-per-file rule. The use-case I want to
> target with this patch is also tooling-related.
> 
> We can add a human-readable version of the coco-features somewhere else,
> if wanted.  You already suggested /proc/cpuinfo, which in itself is
> designed for direct human consumption.

Right, except mingo thinks /proc/cpuinfo is per CPU and there's "duplication".
I say meh but sure, we can design a special one of really needed. /proc/guest
maybe :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

