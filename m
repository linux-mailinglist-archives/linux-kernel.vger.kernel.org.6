Return-Path: <linux-kernel+bounces-557636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D5EA5DBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDFC37AA4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A923F381;
	Wed, 12 Mar 2025 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wgy90SDO"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99194125B9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779861; cv=none; b=CmEs2j/iJKmEov4DLMt5O4aC140HcP1sSxak0SKwrE6oEquOM2KYNynRpRkXbBvuA/RlX9nPd1gFcglVS2Tl8GhGg3q0TkVznkDYsK8UpVYMIcgCnmW4BiOvjRf9+n+c2LJdwFoJ3rtYqiI/UqOFKNFXx6H0V65q9rw7NGRSJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779861; c=relaxed/simple;
	bh=ZFCKMFVYzNpv0Ew3/PBCQCLnP7czEt7QhS7DeQ/FVnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXi7nhT8hR1wEbYn8kj7s01Pppa2PGUK+S/p0SBkXzNHvw2w1LUhUr0M/QJKGulJdxyBiQ13No1pE24riQXiDDLyEQdMOH7ZH9sAEey2o4d2odGYvDn0dHPuGWYVCoZ9nh7OuXMGlXFkIbwW4As8JIbNMKtSnFJhdMuXFkdOh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=wgy90SDO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2F9D445400;
	Wed, 12 Mar 2025 12:44:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741779858;
	bh=ZFCKMFVYzNpv0Ew3/PBCQCLnP7czEt7QhS7DeQ/FVnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wgy90SDOHbnwylACo48iC7a/GjY8Siktpl4WZtm43XqQV8AEKn7TCEXZT5a/p8NUC
	 kyniPxTK/pzTXGElQA2LO7gprjHA+AMQPmyGnN0TKSLYSEFVKsPqOjblZONx+pvzmO
	 BJ3APIceceMn7sdaBcB8nK58tsdn1WEDK0QKEG7cGMlPaMFlYeFrhM0q9bNSwkz0Bv
	 AUnVLadqsDDdgBqxQ97EWBa7Oe4J3Mm1hK3ou+qd46nCHJ/IwijZjQLYaI11KXY0zw
	 jKlX6hubXcz1NpMd/B/8cr54Epvy/3y35Mn1sbfc3j1Mkt74ryvmcGbH0ZO2D3hrFn
	 sGkJCBkOMRu9w==
Date: Wed, 12 Mar 2025 12:44:17 +0100
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
Message-ID: <Z9Fzkbc-5JmOOa_N@8bytes.org>
References: <Z9AFyG7798M4VNJQ@suse.de>
 <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
 <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>
 <Z9B_yS_d8ny9hYUX@example.org>
 <Z9CDjecpydOsRhUy@suse.de>
 <dzs3mxfvac2t7itqcv2vnz3cidspwvjinimkbn3ddygxunc2q3@akdoea7e2gon>
 <Z9FEcYssvcaZab1c@8bytes.org>
 <pskj4f5fitd5ytb7gq4negloioihl2rfbpfwa47fnw74gxmlvh@vpoijhxcee64>
 <Z9FO1CefzO89syGg@8bytes.org>
 <2eopafgnsx7pktqfqhu2nye44ib7ifz2cppqt7gunrltpxrnj6@i7jwe6jrun73>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eopafgnsx7pktqfqhu2nye44ib7ifz2cppqt7gunrltpxrnj6@i7jwe6jrun73>

On Wed, Mar 12, 2025 at 12:59:50PM +0200, Kirill A. Shutemov wrote:
> I am not sure I understand your point.
> 
> In TDX case it is as trusted as the kernel itself. If the system is
> attested, this info is going to accurate too as kernel gets information
> from trusted TDX module.
> 
> But nobody suggested to use this information to judge the security of the
> system.

Version information about the TDX module is required for the security
evaluation at the verifier. The question is whether it makes sense to
expose this information in an untrusted way in the guest (even alongside
a trusted way), or if that makes tooling prefer the untrusted source
because it is easier.

The guest kernel is also only trusted after (runtime) verification.

Regards,

	Joerg

