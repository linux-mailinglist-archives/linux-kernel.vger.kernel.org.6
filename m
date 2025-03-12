Return-Path: <linux-kernel+bounces-557313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9B4A5D732
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FBA3B8B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FE01E9B19;
	Wed, 12 Mar 2025 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhiQYPQV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B619D087
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763977; cv=none; b=D3yppifHbev7EZd6NK+TVypI2N9R99tip3i7jpf8qyyDvfe+4X9PbsiFyIAwTO6h64by6AFhkGyTDf10Bsl6nM2580q9JkDohVLznh2wmUOqqeS3DQN/eQe29O2bbbvDnrv5q5Dnr2vZ+XImZk8BW/EYlI8G0IkjtMq+c+mTetQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763977; c=relaxed/simple;
	bh=j1MmPAJrCJiyEHj5wHX6rQ9J+oKq+bu9LCn1BxNo39c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+MmFonzaXCOU70bkVMlU5U1aFupOh+y95/GNrn532G2t3YuwqTErzA5tuhvQLgfXoRU/BcY82rsrY+cx6kzntXjnAk+a/PfkW+mKE9UqsttNcg6K3iYJCEEQdQ/PKRT7BeNlECd7tOqRKH+4bhwinrRJUppTxoiE0yngM/jaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhiQYPQV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741763976; x=1773299976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j1MmPAJrCJiyEHj5wHX6rQ9J+oKq+bu9LCn1BxNo39c=;
  b=IhiQYPQV/K68zpvGcjpoTtm4u2CyKJ21ZwucFB0DrECUtTKiqGfOOStq
   GLBP15pG7Wa/AGWjirhupnz0fg6h9GFIV4Wq3F0tzQfCvI8+arQoeC07h
   u5gRwu22PY23wiShbjPvCfLq/EGb6UOFA+deCl+Ros9BvUSL3jUF+7Z44
   PSBWHbW0vcx0NaGkfPxWdiAwJnompqd4tthBH8gjCkYxU0vxB4Z4NJeLu
   fixum1Z+D/8dBVNBdIxNqwqfD5jSKYUPb7q+il7fRVWzxqN0jdckBe0VE
   qlePPApeQ6PRaaAbXoC5gv27sCWV3HWMntk5xRr01VJPHFKV5JZi2ttBg
   g==;
X-CSE-ConnectionGUID: Gix7ZoGCSpuZUbL5Kcnl9Q==
X-CSE-MsgGUID: 4YErzOK0QmaYC9tnSWz/BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42552054"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42552054"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:19:35 -0700
X-CSE-ConnectionGUID: NV311y7mS8Kwc1SBdy3/8g==
X-CSE-MsgGUID: gKryZ21NStm1k3nTkaYWmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="151368636"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 12 Mar 2025 00:19:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9DC581FC; Wed, 12 Mar 2025 09:19:30 +0200 (EET)
Date: Wed, 12 Mar 2025 09:19:30 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Joerg Roedel <jroedel@suse.de>
Cc: Alexey Gladkov <legion@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Joerg Roedel <joro@8bytes.org>, 
	"Alexey Gladkov (Intel)" <alexey.gladkov@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, hpa@zytor.com, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org, 
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <dzs3mxfvac2t7itqcv2vnz3cidspwvjinimkbn3ddygxunc2q3@akdoea7e2gon>
References: <20250310133833.GHZ87rWfuV6WgQTsoh@fat_crate.local>
 <Z878IRbbzIbUDQvj@example.org>
 <20250310151154.GOZ88BOinZVkbYEx0w@fat_crate.local>
 <104b6d4f-2848-42f4-a134-3373d12d9424@suse.com>
 <Z88Iv0w8_l9i7_8l@example.org>
 <Z9AFyG7798M4VNJQ@suse.de>
 <29fa0d10-0d3d-47a0-8832-b2c7fc04f637@suse.com>
 <20250311110748.GCZ9AZhPYYAz-MXErv@fat_crate.local>
 <Z9B_yS_d8ny9hYUX@example.org>
 <Z9CDjecpydOsRhUy@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9CDjecpydOsRhUy@suse.de>

On Tue, Mar 11, 2025 at 07:40:13PM +0100, Joerg Roedel wrote:
> On Tue, Mar 11, 2025 at 07:24:09PM +0100, Alexey Gladkov wrote:
> > On Tue, Mar 11, 2025 at 12:07:48PM +0100, Borislav Petkov wrote:
> > > On Tue, Mar 11, 2025 at 11:22:23AM +0100, Jürgen Groß wrote:
> > > > I can live with that, as long as we make it possible to make e.g.
> > > > /sys/guest/xen a link to /sys/hypervisor (if xen is the hypervisor
> > > > the guest is directly running on). This means that /sys/guest/*/type
> > > > should not conflict with /sys/hypervisor/type.
> > > 
> > > Yeah, so Joerg and I came up with this on IRC:
> > > 
> > > /sys/hypervisor/{sev,tdx}
> > 
> > This directory is for guest-side information, right ?
> > 
> > > 
> > > * It should not disturb the current hierarchy there
> > > 
> > > * No need for a new hierarchy like /sys/guest - we haz enough and besides,
> > > /sys/hypervisor sounds like the right place already
> > 
> > The /sys/hypervisor is for host-side information ?
> 
> No, all under /sys/hypervisor is for guest-side information. There is
> not directory for host-side information yet. The question is whether a
> directory in SYSFS is needed, or whether there are other means to expose
> the same information.

TDX module information (version, supported features, etc) is crucial for
bug reporting. I think it makes sense to present it in sysfs.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

