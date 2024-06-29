Return-Path: <linux-kernel+bounces-235049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FC591CEDD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 21:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B25928268E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392813A259;
	Sat, 29 Jun 2024 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IvV0/a6m"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC5132112
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719690090; cv=none; b=o1m74sV/a5f7NXzSrkyY5aHoLsh5Pc3Hzh4X4Bnp9OUxQuNfNt+VPI8WmZ7i/T4/HWunyB+cqgxQws+Irqg24VhX/b+l8l1lxn8TrwkptPlAq4mJLjpFJK44xns3D30KyTJ0aFBjQC0EDu9us8QuVfU8NUIaNn+dHlZO9+zSCF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719690090; c=relaxed/simple;
	bh=7vPF89JqiQ26FpVeIb7dSTEUFz/HFZoHOdmVeUGva9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGp/D9o0rIxDLQDe3g04WBd2HbwOXCZ7Llp1euSiFIm8MKOLVuDeQkiiVP3cGxv6REcGxp4WVcEKFlq6rLnSZZhB4C/sPh4jkIOiECOeB+oBJquqPHQjDnvqvAa91LesrjHDjoghlA7Vi47elMNCMJuTcpTwT9jyP7wdHdNlJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IvV0/a6m; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0AE8740E0192;
	Sat, 29 Jun 2024 19:41:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Awy5ITLtTbDh; Sat, 29 Jun 2024 19:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719690083; bh=q38rzttyvrNSHHoFhRlOeB1rK/rAwV4gpC+ACZtNu7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvV0/a6mcPl0GFFqT0rsz/Y8dnNK3g6Vc9t4fWbC98FFMIRX7W7sX6S7PUTA67ST9
	 EH6WqTyKjJVmrA74uOM7JeQe3E5VeuTAxDePYIP3OMO7d1oHEXWhqx1lDAhuJQjDQN
	 NhYmQ0eKDPyQhDD1l769lZUj+KOf7rCKvsrVDXPswjywddkd2SNiix/piPAi3zEgVk
	 af4z86InPSbAks++JyvvNSRlqTSZ2RPR6XbDpFBjUZ5qcn6GIyTIwOv2Q2+9HktWpB
	 K8hJX5gqozzUedzdwBhItjEHnkHZOSUVtOPbajbB/IJxJEY2up4NjO97xp17/MYsVw
	 fprdOdKDvJdkSLgfh9bCVXsDUHDmzU8ud+w6s5mQvOq/3EjlU5zqmneo6t2X6sNaDU
	 4uhSzugriTnL1BnB9Yw2D2AHtzRF9oxjpLSX/iGSmGli/Bqh2LG16xQSWO9ngWZu/N
	 rsDvgGypVbrHIlPeOrhFYehV+cr2bHke2/VdueBb4Kiq7Vp0Mt/9VrG6Apd1MFwb3N
	 apaHrS2hfMnNAUdqsPRdFVLBpCDgQk+3qXsBLlkMpg7VdzZHx+5GgHiMXoc0SCw6V2
	 1zpTh6T0Kjsyn/X1Qe+pJBvQWmxMGotlTmlTPpYY/WXMMT2Z2Ftf8ksDJfRsbzzWyb
	 WrzOEq1SvWGJL1W09KESup5o=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF8A140E021A;
	Sat, 29 Jun 2024 19:41:09 +0000 (UTC)
Date: Sat, 29 Jun 2024 21:41:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec
Message-ID: <20240629194103.GCZoBjTzC4m9a9yw1k@fat_crate.local>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
 <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
 <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
 <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>

On Sat, Jun 29, 2024 at 07:27:57PM +0000, Dexuan Cui wrote:
> It would be great to add e1b8ac3aae58 to the branch x86/tdx.

Sure we will, once it is properly tested. This very thread says otherwise.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

