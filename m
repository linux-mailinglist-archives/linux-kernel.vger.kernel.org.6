Return-Path: <linux-kernel+bounces-521619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB647A3BFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFE518840DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35831E5B7E;
	Wed, 19 Feb 2025 13:30:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379F845C14;
	Wed, 19 Feb 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971830; cv=none; b=sIvgZ9TWcVVfc0N+bH5x5vh4kFLEIzIsRkdpreXu9Qv1eNBCmb+XWw+aDkQZWrJTz3ARJv8L7P6inhC2tMpWS7FEPDvEUWUtQF04tgD8bKFchVNPfWBaDzvLoRgHie53ClStHEe2IBucoZ02eG/n70KAjEZf1lOnebXbDrFOgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971830; c=relaxed/simple;
	bh=dFMCeJ7t4DLVGLCE/Oqtjh/QIoS5YYqkSRw7tgjyIks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMt0aGhOdcD8jbFP+/Zy1wNPEcP7gXOk6h2OMthmMsV3IxdzOE21/IMbuNOYBpjcayqyyQ0pz2AusKvV0tv16dZXx1qLuyiyYrc5QSQxhhGQp1vAP9YtJ+mNCGOxptYedUjCWp/pxMHYPouN1yh6ilpIUi8mSwpGOZCjltWhU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A27311682;
	Wed, 19 Feb 2025 05:30:46 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7931E3F59E;
	Wed, 19 Feb 2025 05:30:23 -0800 (PST)
Date: Wed, 19 Feb 2025 13:30:20 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, tony.luck@intel.com,
	peternewman@google.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
	rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 11/23] x86/resctrl: Introduce mbm_cntr_cfg to track
 assignable counters at domain
Message-ID: <Z7Xc7Oxm9ByWhIEy@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <30652061d4a21eb5952a1323b76ca70927412a30.1737577229.git.babu.moger@amd.com>
 <b88868e1-52b2-4a66-bec2-e0846394b74b@intel.com>
 <7375cacc-5800-487c-bd8a-7ea11e694598@amd.com>
 <2f1d5857-7f32-4bde-9b12-77fb2b4464da@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f1d5857-7f32-4bde-9b12-77fb2b4464da@intel.com>

Hi,

On Mon, Feb 10, 2025 at 10:10:26AM -0800, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/7/25 10:23 AM, Moger, Babu wrote:
> > On 2/5/2025 5:57 PM, Reinette Chatre wrote:
> >> On 1/22/25 12:20 PM, Babu Moger wrote:

[...]

> >>> MBM events of a monitoring group is tracked by hardware. Such queries
> >>> are acceptable because of a very small number of assignable counters.
> >>
> >> It is not obvious what "very small number" means. Is it possible to give
> >> a range to help reader understand the motivation?
> > 
> > How about?
> > 
> > MBM events of a monitoring group is tracked by hardware. Such queries
> > are acceptable because of a very small number of assignable counters(32 to 64).
> 
> Yes, thank you. This helps to understand the claim.
> 
> Reinette

Do these queries only happen when userspace reads an mbm_assign_control
file?

It might be worth documenting somewhere that writing and (especially)
reading an mbm_assign_control file is not intended to be super-fast.

It feels like userspace should not generally rely on reading
mbm_assign_control files except for diagnostic purposes, or occasional
read-modify-write transformations.  Or do expect some other usage model
that makes this a hotter path?

Cheers
---Dave

