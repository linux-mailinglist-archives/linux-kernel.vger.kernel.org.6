Return-Path: <linux-kernel+bounces-554469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE7A59819
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF311889A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EB22A7EA;
	Mon, 10 Mar 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHyVXBF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25041991CA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618218; cv=none; b=CNoQSTpLKamNIzvnqQZn7t+hHXoDxQfj2HW9jAZmM2F4NaT7iZF6swIo38iCGx/hfgd8Rjyt0NqAt0pIPswNHWpWbxdGiiD1PO/1yqRe87wPvxwVk1/NlapYvgUrxO9xEjNqi/aqEJmHhxe+CPCkPHgnbPsitpYwikJWH3/2rxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618218; c=relaxed/simple;
	bh=7GX4AWwaxobu32YDGZtV8fLDRqJFyzG/nb/RigoR1W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEcAtiTG2sJweUHaX1I7RHh+9hzaGmC/AkbnMAYAqR4SdRs9aliTOh/MMdVXkBMx6Q4ShKuL9UMQOmRFdsyBp6KcBsUzD2SVBukvQPMI7hlY0thIZYq3GMtJdlW1iEIc7ye5HHL0h2JlgNfHXlZYmvm4ceoChsS48H4AQtywutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHyVXBF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5C5C4CEED;
	Mon, 10 Mar 2025 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741618217;
	bh=7GX4AWwaxobu32YDGZtV8fLDRqJFyzG/nb/RigoR1W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHyVXBF4g7bEOyHDbW75xL81PBZOtR+0hsFPEG3Rd8BxLfDYHqtsGA5rH4GLzvoZn
	 OkDwUEISQtf/rQnrHLgzGAzbj+b2mxrJL+fP4jA1wL4sYrGeExvIbtepI/2gqcbfEX
	 +Kyp1YIdhn6N4RkcoWRB0fnsUm7mn95cLLq0gaZ3iszwckzZbv/XFLs6rBRr+fSu7n
	 bVXVDlSiZ4ond9l3nr1+UPAY0S5bYu0Wln6uTqYnVH05qAUPdL1fnwRtpoTmkcXV/a
	 9EjaFGNhlXVde1V6nEd0PRhVL6fBY8j4kJVmTKoJuhoUSXn/oCRG3KozeAjPWT4cwG
	 7z9axMBMm5Gxg==
Date: Mon, 10 Mar 2025 15:50:09 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>, Joerg Roedel <joro@8bytes.org>,
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <Z878IRbbzIbUDQvj@example.org>
References: <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <2koe2zg26fndx6d6jcmbg6dzybbgldgrjufupj74nvmav2dmqg@w6bknhosl64h>
 <Z8le_TWUJNebrfs7@8bytes.org>
 <Z8l66FFgPu5hWtuI@agladkov-desk>
 <Z86-3n1-MArVLM9Z@8bytes.org>
 <Z87L0bRi8tcAIsDw@example.org>
 <e9d58d64-ab0f-49e8-ac87-c02bda6bc837@suse.com>
 <Z87ce37GjCqpOLCW@8bytes.org>
 <b2e585a7-edd5-4b13-b904-3d0913177aee@suse.com>
 <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>

On Mon, Mar 10, 2025 at 02:38:33PM +0100, Borislav Petkov wrote:
> On Mon, Mar 10, 2025 at 01:49:46PM +0100, Juergen Gross wrote:
> > 1. Only name the hypervisor nearest to the guest (similar to running Xen on
> >    top of another hypervisor in nested virtualization, which would still
> >    say "xen").
> > 
> > 2. Add another entry for naming the outer hypervisor(s) (if possible).
> > 
> > 3. Name all known hypervisor levels, like "kvm,svsm" or "svsm,kvm").
> 
> /sys/guest it is then.
> 
> Let's just keep /sys/hypervisor alone and as Joerg said, we can link to it
> from /sys/guest.
> 
> I guess that sounds ok...

Am I understand correctly that you and Joerg are proposing

/sys/guest/tdx/...
/sys/guest/sev/...

?

Which path to use for the host side ?

For guest: /sys/coco/guest/{tdx,sev}/...
For host:  /sys/coco/host/{tdx,sev}/...

Maybe it would be better to add the "coco" subdirectory or something like
that ?

-- 
Rgrds, legion


