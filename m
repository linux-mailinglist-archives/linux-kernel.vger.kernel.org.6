Return-Path: <linux-kernel+bounces-557963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD4A5DFE8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D88D3B7C68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB72A250BF7;
	Wed, 12 Mar 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IV0o9Z0R"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEE8183CD9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792428; cv=none; b=iQ4o0qQMyp/3gmJXuAKNjNYBwo1xbdQEpCvrVSvxw3wOBZkPzAyJiaiT8N9ufG1Cjl3/7+tYMy95ufKFskaCMln2muJZsVO+QZuZfzq8KCpuMu2R5jkBW+rS6gxMDxgnO7BXxHW6eT5mBA0ctoSc7QtMzjwcgbuP6bda2ScuZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792428; c=relaxed/simple;
	bh=MnzSnpIIZ8/JOL3XJtaNEabor1jfWDSv10vvAly0zxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLxu7J+WMDX5+ktGO73EYPXhamoJZas6LZOhAB4+P6w3TXzP9+RNdrV8KbTaybZiMOr/Cl0y9i8XT6TO2JisaoVTOEygNyi1iftdob1DlcL6dADaA/3XEHOjElEH7J+zHhG2fbwBN2B8Ylfa9jvfPcViwjx6U6bGjjnaVNubzOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=IV0o9Z0R; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8C92A45796;
	Wed, 12 Mar 2025 16:13:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741792424;
	bh=MnzSnpIIZ8/JOL3XJtaNEabor1jfWDSv10vvAly0zxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IV0o9Z0RmlHINk3PWEJHX8FQpxOMfZZNap98KJRHKlfLKO7nzXnIkLWaEd6DslPYk
	 O7p/K2DAs/C6FNcTvthmfBGnvY68h8Bh6KecAX4Fjj6x3VX7MqnwWBoHxfcFHlXvZR
	 9mI4XijtDJV1QJZMVb4EtDEO622iGsIsiSSr4nV+1svAF6nlimzkqQLt6NwUTKbYVZ
	 Ht66byXqctY/cLlys57/lD4uS7Gb7nn/MJMWuWVV0IalKIdWN29LdL+NQUZj3S1ba8
	 ufwawJKRNW+tbauKQdLY1qM/nip5/TTKCL9Ba+wBiOZSXA/k6LMUU5tEdcSeITTK9c
	 ilnTgs28duseQ==
Date: Wed, 12 Mar 2025 16:13:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org, hpa@zytor.com, Nikunj A Dadhania <nikunj@amd.com>,
	Larry.Dewey@amd.com, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Juergen Gross <jgross@suse.com>,
	kirill.shutemov@linux.intel.com, alexey.gladkov@intel.com,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/2] x86/coco/sev: Move SEV SYSFS group to
 /sys/hypervisor/
Message-ID: <Z9Gkp6srd4uVz13y@8bytes.org>
References: <20250312144107.108451-1-joro@8bytes.org>
 <20250312144107.108451-2-joro@8bytes.org>
 <6f2d0c92-2614-ead1-0b97-6d1cd4fc07cd@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2d0c92-2614-ead1-0b97-6d1cd4fc07cd@amd.com>

On Wed, Mar 12, 2025 at 10:11:55AM -0500, Tom Lendacky wrote:
> On 3/12/25 09:41, Joerg Roedel wrote:
> > @@ -0,0 +1,10 @@
> > +What:		/sys/devices/system/cpu/sev
> > +		/sys/devices/system/cpu/sev/vmpl
> 
> Shouldn't these be /sys/hypervisor/sev ?

Yes, copy&paste error on my side, thanks for point that out.

Regards,

	Joerg

