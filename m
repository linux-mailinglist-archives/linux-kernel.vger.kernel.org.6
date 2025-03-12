Return-Path: <linux-kernel+bounces-557433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88151A5D8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB19D179D42
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF85238172;
	Wed, 12 Mar 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="vyW8G88A"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D301E8328
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770457; cv=none; b=UM1aiK23fLU2WoceA6Q5fITgoy4h3106NCAZozZYBTJAhhwx1recwesdgFIGYOZSOvDeCbIcY+vQBB/nr+AWQ/wWsjIpU6KjbwxFwR72R90RPSRisJsoHYhXvj1/mE9mS7gqZ82XWUl7BnU2dK0UL3yfkLiQFP0fQDeqsKJVHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770457; c=relaxed/simple;
	bh=2xtik8ZNjcv8YFpKcN5TMzwZKRCzMaZ5Gi4/BrubDos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou3x4HfU6DaIQ/hgR+hROLe1kKmGLxS12V/LpL0TOPzNDWCQZyLjTeEWDdpTIHBnqbcnh45ED92NbV6/NaSbwYG79HKD61dQzDFiRJaWlE4X//QldpNdc4YJRdgHxBaJRRrrrR5+WrnSXePAV9+GVGQGLkIBHkaz6LYax03mU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=vyW8G88A; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DBFEC40E03;
	Wed, 12 Mar 2025 10:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741770454;
	bh=2xtik8ZNjcv8YFpKcN5TMzwZKRCzMaZ5Gi4/BrubDos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vyW8G88Ak5OwKJQOIEjJbMtdayD3+0Ob3NUSFqxeEuLBPmBUKReBs7CAusxTNu8Q7
	 FI04VSBsTnmD89Pmkiri/yxIrF7p7LJkaldLS+QKS8pgCvpogfR9TxpHXJbiCS6jk6
	 bCiPPVdRpDFc3NLD1YXhf+rUt3Pzjawl4HpRDlaaaSSqNjR9j5xknlTxOvdbg9FLU1
	 afUy/dd1YIdsZ/8235V5jFfD4KMADuUSMo+gPWmrpSI+PVvPaZtHBBaFDx9WaNPGzb
	 gqMTWgiyTd/wokzr35Upcxgsi5wPlgrN7OVcjFZNjerTZ2RR46yXa5iItZ7bhgLOd1
	 78nUK+2Eoy16A==
Date: Wed, 12 Mar 2025 10:07:32 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>, Alexey Gladkov <legion@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	=?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z9FO1CefzO89syGg@8bytes.org>
References: <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <Z9AFyG7798M4VNJQ@suse.de>
 <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
 <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>
 <Z9B_yS_d8ny9hYUX@example.org>
 <Z9CDjecpydOsRhUy@suse.de>
 <dzs3mxfvac2t7itqcv2vnz3cidspwvjinimkbn3ddygxunc2q3@akdoea7e2gon>
 <Z9FEcYssvcaZab1c@8bytes.org>
 <pskj4f5fitd5ytb7gq4negloioihl2rfbpfwa47fnw74gxmlvh@vpoijhxcee64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pskj4f5fitd5ytb7gq4negloioihl2rfbpfwa47fnw74gxmlvh@vpoijhxcee64>

On Wed, Mar 12, 2025 at 10:48:37AM +0200, Kirill A. Shutemov wrote:
> There might be a value to have consistent structure for host and guest
> information in sysfs, even if they are presented in different places under
> /sys. There's subset of information that is common for both guest and
> host, like version.

I agree for the host side, but for the guest side I am less convinced.
Any information exposed via sysfs on the guest side can not be trusted.
The only trusted way to get this information in the guest is a
successfully verified attestation report.

The same is true for exposing SEV_STATUS, btw. This can also only be
trusted together with a verified attestation. But the difference is that
SEV_STATUS is not part of the attestation report.

One might say that this does not matter much for debugging purposes, but
the question stands whether it helps the security posture of the TEE to
expose an untrusted interface which tooling then uses instead of the
trusted variant.

Regards,

	Joerg

