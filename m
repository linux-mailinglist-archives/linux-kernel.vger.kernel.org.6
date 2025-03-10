Return-Path: <linux-kernel+bounces-554610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D6CA59A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B66165F99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1B722DF8E;
	Mon, 10 Mar 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E8GgY0rh"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E41DFF0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622162; cv=none; b=HDNBjhtK2tj2cRFQb05aCUUiS6klLu+u0BuLH3Pxs77u/eNFZiyOuKnxEMq2EQKb7Eq/5VkwlRSULRXbyWLslqtbfDbf4xCcRyU3iLamyV3+PN0EToxmLv8ZUWmdd2ha05xeC3QbAO+3tAxpgtTdVVsJV2aAQ1zWfVxtWQAdopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622162; c=relaxed/simple;
	bh=Vpib4HknDTcWF0+SOM32JnezkrePARgvbNr3p5pKfxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHTKcjIziCsqw/sZ0Pi3YFNT4dHk+J9HEDMceSmd3wPCwkuqioH4VYE+rOzgKWnf4bT17MkmgZEqQsQYwWFWz7ESTDSomltjnQ0gIG2waYoGSJQBLClv+LLCB98x3kIKusl88JH33gzcd7Fht7rBx33M7cEwiAVB5sRNvkHRZ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E8GgY0rh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7EA4B40E0214;
	Mon, 10 Mar 2025 15:55:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3rCujaEF5c82; Mon, 10 Mar 2025 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741622153; bh=ytO3kw2/VnCOnax+CiIDtQsCcsdLqF1YX6RbNsPln9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8GgY0rhVvOteJgFJu7PHUiNx4uPmnHsDM7jyNq1S9R0ArkMgvEHev+cJKh/722Wn
	 9FIGSlHohhe8t3D3cfmNx5RISE4PGsVNYxl9vtd7almZ6aZYMC6p528hRyHTPYXoLL
	 GGgvYUm9Kw2OlY5ie+bjOPJFXIaHqIjz0zAOU8I5wPhnJZ2M7DFsVTRpDGkISbELbz
	 LOhDBroNYFIyEaKzECW7B6gKktbHrBV1nuzIoB9xiGuYSKDn6lOo81kE8lxBkgEd92
	 zKgIPoKXwZTJNq1fGeSRxLvTql3CxzAY3Knd4AUcPObeZ7xhhWYeV+wEuQo0iQBf1h
	 tV0XPNRlgn/nagokllamFn/tT0qknwoxxAjmQMx67qmNyJu4+64Iqlu9sRqit5V9/6
	 wWaXGmQ1Vidqg0cj3wfy8DnfaJx3LJuLRZp/G41ir34j7yZtoM/ynRF2TdVzK5Ozc4
	 SBCO2ehigCxKY1Xd8eeXFhc5u4nfeFoxeiBfnyEgAIILWeqfYnUJIHU3Cb4uZW2g7t
	 PDeKcSwoqnEoMOGaBvfZACx9fiNUiqCzEbLr1lcKazLhFepNx4SvOjgR9rxH/AUFhJ
	 2CnNfa3UJBg8PjDL8kjXAlV7/8ZP8XhGaFdNgcnhQ1X+vnwLwk4mQ8ZNzBnJNNhz5j
	 WTxE47UG/tUzuHdEXALm8RGE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E64C440E015D;
	Mon, 10 Mar 2025 15:55:38 +0000 (UTC)
Date: Mon, 10 Mar 2025 16:55:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Cc: Alexey Gladkov <legion@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250310155537.GSZ88LeX9PQQpeCCaU@fat_crate.local>
References: <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
 <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57b64adb-c7b6-445c-b01b-7b05bd7c919b@suse.com>

On Mon, Mar 10, 2025 at 04:52:37PM +0100, Juergen Gross wrote:
> /sys/kvm/ might be a good fit when using KVM?

What are we going to do when Xen runs coco guests? Or there's no such danger
in the near future?

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

