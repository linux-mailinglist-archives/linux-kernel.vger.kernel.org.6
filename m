Return-Path: <linux-kernel+bounces-519670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967CA3A076
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4AD18853F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B156826A0FE;
	Tue, 18 Feb 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0iZJQxN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3D262D1C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890172; cv=none; b=OcrtMPJAWlRSWOIze6xAcKJmNjrLwcMVTgY1899TOzGBMEU6lGew+F4IwSxRg9BVUhY6jkSNhRbNlyafEfDrdAdcCYeGBald1GkpBckmzOVbRj/uozmHu4Bk71a7ZiYabhGetPHFgFSAW+g1HztHlFZubsc72qVs6c3YtnyKlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890172; c=relaxed/simple;
	bh=UVGVBuu6e33jMGeyfiLTBPJGjbrgPrDhUZRv5B1e3oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce0SrjR9NfQ4O3Fy3eLfOPMCph3cgeWW29VTFoIZxS/OE3XHgSddbLM5rhusolz2o/cepQ+jD/N6FwyiumO77DG0jQYVLvEPLuwZNiTrHDreFAv1qZCuDr54sQOHaQoWSN6su30gaJwdZ4mzG5liHykwXuR5nI0O3AwOLCBphgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0iZJQxN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739890171; x=1771426171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UVGVBuu6e33jMGeyfiLTBPJGjbrgPrDhUZRv5B1e3oo=;
  b=h0iZJQxNgGPKd5HI5Xk2dV5Iq7r+4/cHAoiiGOtsieH7mAujNU3gsJmO
   qYDL9alRBh2RdLsMPtjqQl62RE/1ZAz0y0AMZE2plQ1vfi3j3v/HxRoZb
   6Xb90ZdC44Ks78IJWCdahKyitp/AqT1h5oBWKlsAlVXPOnZUkVLDHHmew
   GbaPPvSyYQcexUL5mm9UNx/UTUZOOpYqQljc18R+04OXt5OlFXCW05odw
   LIHgTpKend+wL/TEPc4yyrjrCIsaXoYH/CJeEsPe1B4S0ti4hnpA8zBVE
   j1O5clviPqLiKLMM4plVxA8ow7YLsqbi+MayiihzneR/XKZOGlXS9973m
   A==;
X-CSE-ConnectionGUID: dS0zmsI/QuWBjbD14zmPoQ==
X-CSE-MsgGUID: B5tGiOz5T9WbHwI7SchCAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51227841"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="51227841"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 06:49:30 -0800
X-CSE-ConnectionGUID: IzJFd+DHSfumLx2XFcJAZg==
X-CSE-MsgGUID: MS49BogmTkSPwqIUagHD6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114884797"
Received: from sosterlu-desk.ger.corp.intel.com (HELO himmelriiki) ([10.245.245.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 06:49:23 -0800
Date: Tue, 18 Feb 2025 16:49:12 +0200
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: "Xing, Cedric" <cedric.xing@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
Message-ID: <Z7Sd6FuDDMgExEna@himmelriiki>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>

On Thu, Feb 13, 2025 at 03:50:19PM -0600, Xing, Cedric wrote:
> On 2/13/2025 10:58 AM, Dave Hansen wrote:
> > On 2/13/25 08:21, Xing, Cedric wrote:
> > > On 2/12/2025 10:50 PM, Dave Hansen wrote:
> > > > On 2/12/25 18:23, Cedric Xing wrote:
> > > > > NOTE: This patch series introduces the Measurement Register (MR) ABI,
> > > > > and
> > > > > is a continuation of the RFC series on the same topic [1].
> > > > 
> > > > Could you please explain how the benefits of this series are helpful to
> > > > end users?
> > > 
> > > This series exposes MRs as sysfs attributes, allowing end users to
> > > access them effortlessly without needing to write any code. This
> > > simplifies the process of debugging and diagnosing measurement-related
> > > issues. Additionally, it makes the CC architecture more intuitive for
> > > newcomers.
> > 
> > Wait a sec, so there's already ABI for manipulating these? This just
> > adds a parallel sysfs interface to the existing ABI?
> > 
> No, this is new. There's no existing ABI for accessing measurement registers
> from within a TVM (TEE VM). Currently, on TDX for example, reading TDX
> measurement registers (MRs) must be done by getting a TD quote. And there's
> no way to extend any RTMRs. Therefore, it would be much easier end users to

TD reports *are* available through the tdx_guest ioctl so there's overlap
with the suggested reportdata/report0 entries at least. Since configfs-tsm
provides the generic transport for TVM reports, the best option to make report0
available is through configfs-tsm reports.

The use case on MRCONFIGID mentioned later in this thread does not depend
on this series. It's easy for the user-space to interprete the full report
to find MRCONFIGID or any other register value (the same is true for HOSTDATA
on SNP).

The question here is whether there's any real benefit for the kernel to
expose the provider specific report details through sysfs or could we focus on
the RTMR extend capability only.

-- 
Regards, Mikko

