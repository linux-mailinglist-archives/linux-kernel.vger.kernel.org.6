Return-Path: <linux-kernel+bounces-548455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD98A5450B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB211893CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC820767C;
	Thu,  6 Mar 2025 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4KbLu+fR"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54E6224FA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250310; cv=none; b=bkcE9241dnEE/yhtfAKY6yNNY+W5b6slrl+kxzln0eWTdzv7oqLb4fU4DddQYpaBmg0pbHhFvG9S/6fZa2oWaU2zl6neamvL2cQ/bHlf1TBjUGyCDWJQfEdiENqj8+z/BuTQn033YsTBh0Hb/tx+nVvZkk5pyZrc/SmyGCgUyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250310; c=relaxed/simple;
	bh=e3zB1SRexAvSOxKceijLlQepb4BVkWWKRzflYMQeI3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzZj1aGWgK1ZoqPggkf/wyQbUA1ldgg3gYSv9N2ZQquk5rT1lyIsYHZ5NnbJbAorK3wBV/OQZErabDyracmj5wokM8+ZbseZm1wv8XGIbGaFSZGhJ1rAVLbgHXilVnOwNCVLBKe/9oQjrul4JRjbSMNRkYA+r5SDMKqvw2ni1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4KbLu+fR; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 792D6413AD;
	Thu,  6 Mar 2025 09:38:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741250302;
	bh=e3zB1SRexAvSOxKceijLlQepb4BVkWWKRzflYMQeI3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4KbLu+fRtZe6OIx/LFQTsVdVj9nuPFQzQDKRfOF6v+752onzGxtbpiAUH0Wk7fVVe
	 KC8FjHWKec/HH112QLLKcNYgFamupREFUNCdks2/jZaNAnQjVDP4e+2WHzDhoN5rjz
	 N+kNUCqHdpdRnVahxKvH5781P+C3i1u+8iuQPnK4FEjPYy8NirLwfbaNNk9PQA9uaH
	 EApUD+0rWaNYbpeteNg4gEbNT971s/kJbMoVl8Bzy+xqjU5rQvVueN53T3Cot0aos5
	 41WQnUknaG2weRm2ACKMKsrPDb+7nWTOKXSIGKg+tU9s/NbT1+SaL2lZBJd9Lw8M5E
	 Z81gIJ449l0uw==
Date: Thu, 6 Mar 2025 09:38:21 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z8le_TWUJNebrfs7@8bytes.org>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>

On Thu, Mar 06, 2025 at 10:01:17AM +0200, Kirill A. Shutemov wrote:
> Alexey looking into exposing TDX module version in sysfs for both guest
> and host.
> 
> I think it would be useful for guest to make attributes and TD_CTLS
> available via sysfs. So far, we only dump them in dmesg on boot (see
> 564ea84c8c14).

Okay, do you have ideas already on where to put this information in
SYSFS?

Regards,

	Joerg


