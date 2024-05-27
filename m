Return-Path: <linux-kernel+bounces-190755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 334E28D0245
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B22B2304D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0E715DBC7;
	Mon, 27 May 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PDOWOD46"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1626215ECF8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817890; cv=none; b=aGS6ORipUfQEpvx41CsiEptUp1bgh0JDOlXBXAggLxkPtx40DnkNd/l7D9l4GjrvQ4LPZ9e1kCLS16QJkJfIAu2rSbAQThbPIh1CGf70k92/5i8RRnlipg99WVsl7vWp8Woj6yFDMI4/MzVBOMpVAICjkZxfXbwRzuMRNe/tHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817890; c=relaxed/simple;
	bh=3SLmwhe1BG8k1dOTLMosKY+YaYjuv7dkAru+9Up3axM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7oMACEiF7/2xfTxgLmHwvH8m9hSV7Jfgns8C8PYLe3/f/tIeuLMoqRlTTjn4UGAwaSe447MPJK8uOZVLUOTUT8dGd2m00wYoSg8Rg+XPWnhgSTN5TKj1VLmv+/uks2NluuuVv4ipMUqDqKTtdSl3K2pJGFlbm83Li5C0mRbFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PDOWOD46; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B4BC140E01E8;
	Mon, 27 May 2024 13:51:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Oq2UhWKWQFUl; Mon, 27 May 2024 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716817883; bh=+od7caDLEPXz4QA7OiR3Y4qE0Xp9CTT3BbEYpXhsbzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDOWOD46MaTked/eyXcWeCGd9lUl6+OwvmUj15L2UV3K//S2TEtmWvb+2f8hij7oe
	 ARCtWuTYwKadOfNLq2eL0puJ/RhDQMC+8mk8kt0gLEF5dqE5SkV7QHiDGlbxQbsXHv
	 r2rz0jj47TJ1gb7LunkbPQxVq0hytMTVAese3XvFH1S+AfSDf0GcVBW7fHpgHIi4Dt
	 SWkmmoqKrih7i/F6xhY/2PNiHQPTYq30OO0or2O70YfXFlAk8uEakTPyCdOKD7BEDZ
	 oNrFdjiXdtU39XSNDyJJAoHvTbvucvC0zzmYDfbvMphsDjbaYmusWHz2q3l1csbFFg
	 ejKaZiqzCkfreZXP9A1GkSqUhAjcQGihZ4ak13S9jAy+xkiOsG9naawfM33L+UW8B5
	 seggOrBBpRQM4SDkVpgxmAfY8sZOIa4pr+/SF2OIkEoaSqN6l/ojbYWOrqfZw+QA9Q
	 whhEHr3lpSwIHLj+NbR6f/SePqkBBOJgERWyfYsW7g3W4mTeUArHMMPN+NGhHnX0UU
	 nYu9xPFO4+WIJJoMVRqDVyZHx4J7WWqCkN6vHbTJivy/7oX/sEY6i/0mjiExwsKuRw
	 MS+mKGQZKk94ykDf0bV5Fiirz3gGxeWLjFot9m8u6wBjz/QQqn/PH9IT7c+8D/cW/3
	 /Nw85SErsxXvvEjQ8/pejOZ8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5FC3440E0177;
	Mon, 27 May 2024 13:51:09 +0000 (UTC)
Date: Mon, 27 May 2024 15:51:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 09/15] x86/sev: Provide guest VMPL level to userspace
Message-ID: <20240527135101.GBZlSPxQ6iBSlMDefY@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <435f78e07c76e25d2d857138724098bc2a729b0a.1713974291.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <435f78e07c76e25d2d857138724098bc2a729b0a.1713974291.git.thomas.lendacky@amd.com>

On Wed, Apr 24, 2024 at 10:58:05AM -0500, Tom Lendacky wrote:
> Requesting an attestation report from userspace involves providing the
> VMPL level for the report. Currently any value from 0-3 is valid because
> Linux enforces running at VMPL0.
> 
> When an SVSM is present, though, Linux will not be running at VMPL0 and
> only VMPL values starting at the VMPL level Linux is running at to 3 are
> valid. In order to allow userspace to determine the minimum VMPL value
> that can be supplied to an attestation report, create a sysfs entry that
> can be used to retrieve the current VMPL level of Linux.

So what is the use case here: you create the attestation report *on* the
running guest and as part of that, the script which does that should do

cat /sys/.../sev/vmpl

?

But then sev-guest does some VMPL including into some report:

struct snp_report_req {
        /* user data that should be included in the report */
        __u8 user_data[SNP_REPORT_USER_DATA_SIZE];

        /* The vmpl level to be included in the report */
        __u32 vmpl;

Why do you need this and can't use sev-guest?

> +static int __init sev_sysfs_init(void)
> +{
> +	struct kobject *sev_kobj;
> +	int ret;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +		return -ENODEV;
> +
> +	sev_kobj = kobject_create_and_add("sev", kernel_kobj);

In the main hierarchy?!

This is a x86 CPU thing, so if anything, it should be under
/sys/devices/system/cpu/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

