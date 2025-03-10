Return-Path: <linux-kernel+bounces-554234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B8A59506
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2AC188248D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A69C226193;
	Mon, 10 Mar 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="cWLCqolv"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99012206AB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610779; cv=none; b=nDpPw8c+HOeCtGPxqvsihBjNjROSTfh5sqsqlUsrBiG6+hMKxpFHWnF2ITv8RNid28T4ppUzVAc2u09hnEok6OBmVeuDZhqaCuxhuKGvLJy1PSVM0YDeIyN9QDr7pPWez0yYT4QF267QnrmujyNBvj2kEtVxcoou+mGc4aj0Rx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610779; c=relaxed/simple;
	bh=0nO/xIXwJzgoohFYLquOfcauO0xNrITVqz/4/CuB8Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggPS4CUzLrcPjgn71v5RyH7U7GlOll7/ISw0O4DglRyFRBiSCpa31lSK7HTTDRTwUCeW3DJk9CqOgTmCNS+dLVHnaq/6I6q+6iQ+R+BL3gF/eByJUWHRn+Q/qdZdkDp8c3XbhS0Sj+fcSkB7+KeA+cmrqRyQUxT4CcNpmOQ0SsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=cWLCqolv; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 532DE45265;
	Mon, 10 Mar 2025 13:46:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741610774;
	bh=0nO/xIXwJzgoohFYLquOfcauO0xNrITVqz/4/CuB8Vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWLCqolvrtaMsr3ySSe1f86PECMhMQVtno5DjUqXSpLihEACGRKlplPETnru1nIrO
	 GP2PolUz+6JkpjHwc6HhaghR3s1XnrOMEo0/W53PUGQIEQ23hlnCYwPaYvvHKdBq8F
	 y05OHIfn4/HmeSN73c2yj03g1wSFUSQZeR7ZIUk3KpJy+SBwq3V3qV7dxP3+ZGALHP
	 xXXbBEMFm6k3xXjhDJzojSjZAOQFMa3RDBuHSAjTdNC89wHyPbz4C88iiwgMyDgJIH
	 qBJjUURjmUkCXClZyIVu+/PJUMjUb7RiJjifbUbVdEvuZFzwmONIX+8s3d7H7nlqaC
	 dZStc0JpWacyw==
Date: Mon, 10 Mar 2025 13:46:13 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z87fFRbg9V_x3u1v@8bytes.org>
References: <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org>
 <20250310110202.GEZ87GqgEJyhJtde0I@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310110202.GEZ87GqgEJyhJtde0I@fat_crate.local>

On Mon, Mar 10, 2025 at 12:02:02PM +0100, Borislav Petkov wrote:
> ... or you can drop the "common" thing and use only the "coco":
>
> /sys/hypervisor/coco

Common is less likely to be mistaken for a hypervisor name than coco.
But if there is agreement on that naming I can live with that.

> and then you kinda denote that while it is the hypervisor hierarchy, it is
> related to confidential computing so it could be consumed by guests too.
> 
> But I still don't see why we can't simply do
> 
> /sys/guest
> 
> It is just another sysfs node. Or is there a particular reason to stick to
> /sys/hypervisor?

/sys/hypervisor/ has the best-fitting name imho. Unfortunately it is
taken in a very non-generic way by Xen, with no clean way to make it
more generic without breaking Xen or increase the mess. So /sys/guest
might be a viable alternative. /sys/guest/xen/ could then link to
/sys/hypervisor/.

> And putting it in sysfs still doesn't solve the human-readable aspect: dumping
> a raw SEV_STATUS might as well be simply reading the MSR and if someone wants
> to read it, someone would need to go count bits. Imagine the following
> scenario: a user reports a bug, you say, ok, send me
> 
> /sys/hypervisor/coco/sev/sev_status
> 
> you get it and you dump it through your script or start looking at the bits.
> Yeah, we all have scripts for that but it ain't too user-friendly...

Right, it is not really a good human-readable interface. On the other
side SYSFS was always an interface targeted more towards tooling than
humans, therefore the one-datum-per-file rule. The use-case I want to
target with this patch is also tooling-related.

We can add a human-readable version of the coco-features somewhere else,
if wanted.  You already suggested /proc/cpuinfo, which in itself is
designed for direct human consumption.

Regards,

	Joerg

