Return-Path: <linux-kernel+bounces-525207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C93A3EC68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3175188A469
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7AF1FBEB1;
	Fri, 21 Feb 2025 05:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HaBXhcLM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE81EEA59
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117514; cv=none; b=l4DuSK/dOgElMRZY8VuIRDDrN8fgXgvVu2HXvkNSLUj2fb3Xy5tIebrJByNSJFyi6kX9GMqS+Ip2Yh5zDKQMWqCIr9fMZXTWGp9xd48C/IAQP+8MoRZxqDLe3Lx35Q/INuuHP8dxOObTAXuEWK04TXbF4CgCXzKPT1VG+2eNSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117514; c=relaxed/simple;
	bh=eAuYwlysZ7m/8cEe+oEJgI+h3VQhPc9pSBGB6ags7Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO8VD6+4ysB/6wrZXEAzw/1+XEo4sVM626zjc0qAA4/EUx8PeYH2EOgT8ng+95slPEZrkDAsxYwAKab07Er6kAbGZWU7EfjXBMUSQpl28+jZjxnEoDD+aL5/n3RUz0Mg/WCNI2YUQh7Qqh8xW0W1GsIr4FzeYoK/aZ2MqTjCuEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HaBXhcLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F60BC4CEE2;
	Fri, 21 Feb 2025 05:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740117513;
	bh=eAuYwlysZ7m/8cEe+oEJgI+h3VQhPc9pSBGB6ags7Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaBXhcLMbmXEktGS8xExYWOIRJx4iu28bJYpKdWe6sFRAQEk7X3FmLFtZzdLWTWSE
	 aqGB6WtsmkM80XRAlrAG7qTMEPf795k1FfkObOKuRVqreJSMiKUBSo//CqBUH4gaKP
	 zG6aTDW17Ohe2etUth4Y8w1RT7l3GFtaSk6ggGhI=
Date: Fri, 21 Feb 2025 06:57:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/6] drivers: base: devres: Allow to release group on
 device release
Message-ID: <2025022102-another-balmy-fe4d@gregkh>
References: <20250212200542.515493-1-lucas.demarchi@intel.com>
 <20250212200542.515493-2-lucas.demarchi@intel.com>
 <2025022007-judiciary-broadly-a1f8@gregkh>
 <ky3kd4rwuwm6lehmb3n7bplnaoxiwuje67q6m7tvuz6vt7bnnb@lool6xnskx32>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ky3kd4rwuwm6lehmb3n7bplnaoxiwuje67q6m7tvuz6vt7bnnb@lool6xnskx32>

On Thu, Feb 20, 2025 at 05:48:10PM -0600, Lucas De Marchi wrote:
> On Thu, Feb 20, 2025 at 01:24:20PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Feb 12, 2025 at 12:05:37PM -0800, Lucas De Marchi wrote:
> > > When releasing a device, if the release action causes a group to be
> > > released, a warning is emitted because it can't find the group. This
> > > happens because devres_release_all() moves the entire list to a todo
> > > list and also move the group markers. Considering r* normal resource
> > > nodes and g1 a group resource node:
> > > 
> > > 		    g1 -----------.
> > > 		    v		  v
> > > 	r1 -> r2 -> g1[0] -> r3-> g[1] -> r4
> > > 
> > > After devres_release_all(), dev->devres_head becomes empty and the todo
> > > list it iterates on becomes:
> > > 
> > > 			       g1
> > > 			       v
> > > 	r1 -> r2 -> r3-> r4 -> g1[0]
> > > 
> > > When a call to component_del() is made and takes down the aggregate
> > > device, a warning like this happen:
> > > 
> > > 	RIP: 0010:devres_release_group+0x362/0x530
> > > 	...
> > > 	Call Trace:
> > > 	 <TASK>
> > > 	 component_unbind+0x156/0x380
> > > 	 component_unbind_all+0x1d0/0x270
> > > 	 mei_component_master_unbind+0x28/0x80 [mei_hdcp]
> > > 	 take_down_aggregate_device+0xc1/0x160
> > > 	 component_del+0x1c6/0x3e0
> > > 	 intel_hdcp_component_fini+0xf1/0x170 [xe]
> > > 	 xe_display_fini+0x1e/0x40 [xe]
> > > 
> > > Because the devres group corresponding to the hdcp component cannot be
> > > found. Just ignore this corner case: if the dev->devres_head is empty
> > > and the caller is trying to remove a group, it's likely in the process
> > > of device cleanup so just ignore it instead of warning.
> > > 
> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > ---
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks. Is it ok to take these 3 through the drm tree or are you taking
> it through yours?

As the drm patches depened on these, I figured they should all go
through the drm tree, so please feel free to take them.

thanks,

greg k-h

