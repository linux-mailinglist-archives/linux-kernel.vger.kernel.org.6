Return-Path: <linux-kernel+bounces-554205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB2EA594A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E484168366
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506AA225413;
	Mon, 10 Mar 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="2bd2YLAf"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385D220687
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610112; cv=none; b=T83s1yrsaq2111v6GbAAfHFod4AtU4ZTHCdnZJx2mKeuQ5odJVlBbOCWrZr3rv0O8UHP0WsIFO6XFYRRUfoXRDJYtT5OZM1GUzR4JF9c8pGu/znmzbYAHPt1UnrkTCGC29QohlLArWJHgNJ77ic7pbUhzaH7x07+H8G/ArL7wmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610112; c=relaxed/simple;
	bh=HhXOLi/3CeOtVR5inmB3Pzf5XZSwuEMjTr25ldCYss0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSXXna6Sl3IfJoz+8ef2sej5kgLXExIKIgcGFNMNk3qRYBDPg2yPh8ezUqueR7E4fUl9T3FRyHVpXXfDYC2sFzelPAyLH+CUhOrkMdA3Lw7hNc4s1r8dKTbGqac9ZBHPLZT3vuNMhnPsfCQAepR2KFv8lg8dYqWvFC2LMXl+OTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=2bd2YLAf; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E826C45174;
	Mon, 10 Mar 2025 13:35:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741610109;
	bh=HhXOLi/3CeOtVR5inmB3Pzf5XZSwuEMjTr25ldCYss0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2bd2YLAfTH0cTtK0cWwz/yZa+boAmWBZyJ3qpTE9KTDCZo/eXb2JrVHZTeetct6tt
	 EGs5ZkDwWV73m0uwSZ44BieEi2VEgV0gCjA/gBpZVU8KHZi/S6sDLGCaZ5odCO9onQ
	 6F0W/ucltnlaoag1r1LbrcWRCqJTWAiLQW7bFoJH8FBPc98m2GNaIJnK4RPb9TEoff
	 7/AlGjRqibHoLwb6AeSEkVVvW+MVVXPSnk78fzM8bHfgIs6kKXwwYm+OZ28oMLwrJA
	 KUKm7VxcDs+5k5zquJjLvV1DHrN5CUl1GRk15QnSPrAW28GkHUwGkDN1TQiJpa/a7L
	 QvIUSfhj4e3IA==
Date: Mon, 10 Mar 2025 13:35:07 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Juergen Gross <jgross@suse.com>
Cc: Alexey Gladkov <legion@kernel.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z87ce37GjCqpOLCW@8bytes.org>
References: <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org>
 <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>

On Mon, Mar 10, 2025 at 01:28:38PM +0100, Juergen Gross wrote:
> We can (saying that with my Xen maintainer hat on).
> 
> There is /sys/hypervisor/type which should return the used virtualization
> environment ("xen" when running as a Xen guest).

In CoCo environments there can be more than one hypervisor beneath the
guest. For example KVM as the untrusted host, SVSM or another para-visor
as the trusted in-guest hypervisor. On TDX there is also the TDX module
in-between, which is another level of hypervisors. ARM and Risc-V will
have similar architectures.


Regards,

	Joerg


