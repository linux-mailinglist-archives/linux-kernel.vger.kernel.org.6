Return-Path: <linux-kernel+bounces-557382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB2A5D80E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720F93A98FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97ED233D93;
	Wed, 12 Mar 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="n3VHjQBu"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1222222FE10
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767798; cv=none; b=H0hSwEADhT681cJLjWc3xY4uoQaCf3gYJquuPtSVHCaSWGN7nevatgHbgo0Tf5ZNqR9a88KPf13qZy1Z0TlzQm6kt/QrHHwFmSsa6pzYcY/fsiBIwbILnTeRZkRPqKKNyO9PrqD6ARR7FVYmrdJmKOjii+uqXp7wdTPC01v5mcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767798; c=relaxed/simple;
	bh=wmN9njbrOp06Jz992yjPTQLaFEbX0G2GM09PiUP7NWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbByzICObX8XVv+5OQuGyym5xCoJ98n9C2MsbtjggDtnqUELC7/yV5dtPfABTSB4UdojNpIGVkG/37cdqnv+DWzT5h4FpqUvUXjdyWtUqCRXkpmDT2SiZEX226nl0dmyOGtnlHXZ7v0zXaPQHEE0sCSx7/eF1Wvg3JkxGv+gWjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=n3VHjQBu; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 94237454B4;
	Wed, 12 Mar 2025 09:23:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741767794;
	bh=wmN9njbrOp06Jz992yjPTQLaFEbX0G2GM09PiUP7NWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3VHjQBuUTP+I92Ank4nr/3PPHN2d8tbknI5Kvnm8XbaZMZ71E21jREnYwbb+3iUp
	 FMsiq5ULV+RChd+NRG74reAv+/N3ODYCBq6RZjzN1Ltnjx+ztI9quwIHn+ObkK4myt
	 B2nr1tBJaG35ArRCfkxfJwg2IHyEsxxeqXG1NJgjkLBlk2KmJYPQv3Vw3qgLBsKp0A
	 0b4nGbKUQcIu5QddwDGH/mLRZyqj/PP6GWG3CwjLVhPGpCncVIRiNMd/kK12vFV0EJ
	 QMm/Ism4JsqVdVwKiTg4T0/W753h9tt3nCrJlRUrJhlGD+vCJ2jA+PlSmzhqgmagST
	 XGVQAH3xRGNVw==
Date: Wed, 12 Mar 2025 09:23:13 +0100
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
Message-ID: <Z9FEcYssvcaZab1c@8bytes.org>
References: <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <Z9AFyG7798M4VNJQ@suse.de>
 <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
 <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>
 <Z9B_yS_d8ny9hYUX@example.org>
 <Z9CDjecpydOsRhUy@suse.de>
 <dzs3mxfvac2t7itqcv2vnz3cidspwvjinimkbn3ddygxunc2q3@akdoea7e2gon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dzs3mxfvac2t7itqcv2vnz3cidspwvjinimkbn3ddygxunc2q3@akdoea7e2gon>

On Wed, Mar 12, 2025 at 09:19:30AM +0200, Kirill A. Shutemov wrote:
> TDX module information (version, supported features, etc) is crucial for
> bug reporting. I think it makes sense to present it in sysfs.

The SEV side presents this information via dmesg and /dev/sev, we
can also talk about a place in sysfs for it. But the place to present
host-side information is a separate discussion.

Regards,

	Joerg

