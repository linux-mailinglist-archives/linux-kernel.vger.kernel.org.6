Return-Path: <linux-kernel+bounces-523686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1220EA3DA05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7475A860F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790A41F560E;
	Thu, 20 Feb 2025 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ddVPCUca"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB811F473A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054263; cv=none; b=oVsVx/xCxjm2goCwYNz+BLi2UsdVKKRlfFQhV9aCRSVUE2o04ydpaCZuT92kiaX86iwOAEtTUuHynT0rRYxluq+runZ0Z6mFHDsPcm6cyuXEthM/FrzsqYTdxxf4zaiRYM3uk6hk/3xJKZkNldr6MwcyG9630QE4d/XXhnmJA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054263; c=relaxed/simple;
	bh=SxZ5pAEGWdtBNEet9Ndp7pxpdZnMI7osiIrQlY/cItY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM2QimzxOi6tQ8DrGx7OYXrqNgDfkZKvY6IDErdswN+y3iXVv13i6B+f0ytu6mFLe8Oor+kHGk4hh8J2bYzQNRQicIZ9e7rzIqULcfu719Y5rD4BHYPOl8DxFkj6iJhKZTRSORmEsi4ah6RUEtcLZTCSHqnT+ugsVItrCTgxDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ddVPCUca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021D7C4CED1;
	Thu, 20 Feb 2025 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740054263;
	bh=SxZ5pAEGWdtBNEet9Ndp7pxpdZnMI7osiIrQlY/cItY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddVPCUcayAGNvIt6g32kpYTE7g00AYZiCL8F1wnMVJbuVk7wKnIbo7nTibOCxafJ4
	 u87PlqdmX1Jn54P42D+655STOi7vsrf73OpQ7cuNojrEU3b1RsW4W5U7HLYH47wjVC
	 xusyIl8ZN23bDUik4/fcP7ZQaeluK3qXE1t+/29c=
Date: Thu, 20 Feb 2025 13:24:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/6] drivers: base: devres: Allow to release group on
 device release
Message-ID: <2025022007-judiciary-broadly-a1f8@gregkh>
References: <20250212200542.515493-1-lucas.demarchi@intel.com>
 <20250212200542.515493-2-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212200542.515493-2-lucas.demarchi@intel.com>

On Wed, Feb 12, 2025 at 12:05:37PM -0800, Lucas De Marchi wrote:
> When releasing a device, if the release action causes a group to be
> released, a warning is emitted because it can't find the group. This
> happens because devres_release_all() moves the entire list to a todo
> list and also move the group markers. Considering r* normal resource
> nodes and g1 a group resource node:
> 
> 		    g1 -----------.
> 		    v		  v
> 	r1 -> r2 -> g1[0] -> r3-> g[1] -> r4
> 
> After devres_release_all(), dev->devres_head becomes empty and the todo
> list it iterates on becomes:
> 
> 			       g1
> 			       v
> 	r1 -> r2 -> r3-> r4 -> g1[0]
> 
> When a call to component_del() is made and takes down the aggregate
> device, a warning like this happen:
> 
> 	RIP: 0010:devres_release_group+0x362/0x530
> 	...
> 	Call Trace:
> 	 <TASK>
> 	 component_unbind+0x156/0x380
> 	 component_unbind_all+0x1d0/0x270
> 	 mei_component_master_unbind+0x28/0x80 [mei_hdcp]
> 	 take_down_aggregate_device+0xc1/0x160
> 	 component_del+0x1c6/0x3e0
> 	 intel_hdcp_component_fini+0xf1/0x170 [xe]
> 	 xe_display_fini+0x1e/0x40 [xe]
> 
> Because the devres group corresponding to the hdcp component cannot be
> found. Just ignore this corner case: if the dev->devres_head is empty
> and the caller is trying to remove a group, it's likely in the process
> of device cleanup so just ignore it instead of warning.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

