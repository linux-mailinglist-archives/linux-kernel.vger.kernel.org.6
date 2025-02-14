Return-Path: <linux-kernel+bounces-514994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7E2A35E67
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CD416E41E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0EA263F5E;
	Fri, 14 Feb 2025 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qBU4l+Hy"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806AE230D1E;
	Fri, 14 Feb 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538231; cv=none; b=cQkvC3Rx/XjsPnG8vD/0mhNYbfVopDZFS7M8EoMWcQIPP+q+J7GvCV332ChENfgZx5x5V6gcicvCaKbRkkA2izrW/oZB/DtZOUlWzKVnKQN9em0oVlzRVUTX1/do831ZpJY5FLt+syrhXNfVrmbmoxYD5a9dgSBf495a++/Veq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538231; c=relaxed/simple;
	bh=kFT27GayLKqiCGudO1VGFWKRq+m74lVsk5f5f4cYcl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4b6Dep8kKMjvU/6n8EVjwRzsmCllKzdQe0tIKZuuckU7lPM0yQ52qONzEmHPr1xhdCTIJnfFZ/k4ZbD35+LFdog2P4KVeaCda/r2U3Gfusc8vM8kskwoDgUm18jpA80BZMrVPHxo5mAvuHWyoZ0g8a2PVEbFPD+BJ5giUF4W3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qBU4l+Hy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qHEYioWxa/PkvZoqEnIF5GglRRCgOnrOcI7d0vuvT3I=; b=qBU4l+HyWakWvkCgFP4gnTRnRM
	1q0Whv0LnNlwU9uNczuCbT/FsMzeaGmXvqwQHgzShiuGcthIOovp6HgtGcvhUcZgQthKN16Tzb/VS
	4nHroTc2PJNXFKV4vI2BLwjtbvsZYa4ptDPye6z9g3M67O8QrMK0U+e5wQF0UsQqc5sNlvA1X0Sal
	wv2R+gbd6Oh2vTJI/OzEoZx6+oC9utFBa9VS2jglNPWr5d6qJHMltbt+ZFVLxXve35dOzQiFioiI3
	3SjiyHdDimVraHI+sjNCHateu+QXxsnLSMJIL0oeGudtzPid8FYxIjsjuWMhWjIZpsh9yU78RnZ+4
	FxMFob3Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tivM9-00000001FMr-41SP;
	Fri, 14 Feb 2025 13:03:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0BE0930050D; Fri, 14 Feb 2025 14:03:45 +0100 (CET)
Date: Fri, 14 Feb 2025 14:03:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/cpu: Add two Intel CPU model numbers
Message-ID: <20250214130344.GL14028@noisy.programming.kicks-ass.net>
References: <20240923173750.16874-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923173750.16874-1-tony.luck@intel.com>

On Mon, Sep 23, 2024 at 10:37:50AM -0700, Tony Luck wrote:
> Pantherlake is a mobile CPU. Diamond Rapids next generation Xeon.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 44949f972826..1a42f829667a 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -135,6 +135,8 @@
>  
>  #define INTEL_LUNARLAKE_M		IFM(6, 0xBD)
>  
> +#define INTEL_PANTHERLAKE_L		IFM(6, 0xCC)

That should have: /* Cougar Cove / Crestmont */ added on.

Gotta love how Pantherlake is Cougar Cove and DMR is Panther Cove,
someone must be doing this on purpose to mess with us.

