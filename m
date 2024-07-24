Return-Path: <linux-kernel+bounces-260874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2446393AFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45022834BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ACB15689B;
	Wed, 24 Jul 2024 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ivfhiO/m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CD5155731
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816055; cv=none; b=bkAySauYi/Ee7aKoE+SGJocPgawflmGCKIFNHwAW67VOAa5A4390tFzN1UG6riMEjXGoZD2zMcbyTyWm1W5gN4Tq4mB5ovZnv6aXsie+NIXSeQFJp4x11J7BKD2hWxE8KWg724jjgQBpPr7zsfuUPTtr7D7KKtUNnrwzctxkTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816055; c=relaxed/simple;
	bh=cSMKTDGrrqY6rGKT5DCjn/GFEbxJv9IUxhFPhDTArI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No2YFTP02yW9cenGhy+SCH4tPzzIbZPwjqFJA50cgKVWMNgYQcoQjUW8xWwCZx1chYRazrcdz0LcvjSfeWEoxD7gKTP41kJ58BAgos9rvEY5WzQLvDVpHYmCK5OspTWJ4wGqtmwQnghZepKpnq4ASgWk8uPyetObn6WJpbBlCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ivfhiO/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D10C32782;
	Wed, 24 Jul 2024 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721816055;
	bh=cSMKTDGrrqY6rGKT5DCjn/GFEbxJv9IUxhFPhDTArI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivfhiO/mW+QgqHFulfAHsjCxP/xmmOv0Zmwqqocs5PfjSiDzXQe+WOWGCGKlAhs6/
	 GW4M0oVPb0UXOSQ658Azh+XGHjkbKPwCc1m9I431QDljJpjmGnmm6n3Or7ZNNFguyF
	 iHkZzrgx/nAVGl0G16QIZWXRo9z6agVI5syHkqFE=
Date: Wed, 24 Jul 2024 12:14:12 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-39471: drm/amdgpu: add error handle to avoid
 out-of-bounds
Message-ID: <2024072457-citrus-shortness-c3e5@gregkh>
References: <2024062501-CVE-2024-39471-3dee@gregkh>
 <d5e6930140e85c92e7ab4b7d68642d754ead1746.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e6930140e85c92e7ab4b7d68642d754ead1746.camel@oracle.com>

On Wed, Jul 24, 2024 at 10:05:53AM +0000, Siddh Raman Pant wrote:
> On Tue, 25 Jun 2024 16:29:04 +0200, Greg Kroah-Hartman wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > drm/amdgpu: add error handle to avoid out-of-bounds
> > 
> > if the sdma_v4_0_irq_id_to_seq return -EINVAL, the process should
> > be stop to avoid out-of-bounds read, so directly return -EINVAL.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-39471 to this issue.
> 
> This commit has a bug which was fixed by 6769a23697f1. It should be
> immediately backported, otherwise this "fix" doesn't do anything since
> gcc will optimise out the check.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

(hint, send the request to stable@vger.kernel.org, not
cve@kernel.org...)

Also, any specific reason why that commit was NOT marked for stable
inclusion by the developers/maintainers involved with it and you didn't
cc any of them here either :(

thanks,

greg k-h

