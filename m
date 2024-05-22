Return-Path: <linux-kernel+bounces-186469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D407E8CC490
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E272283CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE8613E04E;
	Wed, 22 May 2024 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHdVEMMT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B1210EC;
	Wed, 22 May 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393451; cv=none; b=fHnm1oNS5wC0yTo0ei1Zjo8kzZ2j7aePNqLGtZ5XYZ1oSezG5L3nJXxdv8WGcz6wusVVJVzQgwbfRVGiVAJvZbhSzjfZaeWTP6nXGa75+xjbB3g+wNpFRzzXWREKQ5Egyg4HGkmQTnv3fub0P1yqYVWcbU2DEY759/Dvhstb4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393451; c=relaxed/simple;
	bh=s7fLrqlLqrdwUt4HwOiHRqZ1aWTDKv1ZtetuvCqzHYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxaAQKjV6DVfYW5vEF4KZxgyqNA45rpWHOIBcUmJ+bLonP0ncfzSSbDbA8XTjJd2MBwZK2DXoYP/Hs71IQrmHtvZ/P8osE94mdlLJksgvXHK83PN2ilCDeZmjrUzdJqS4W5P4DLDe2RquKOEop60y2VRb3d/Ji8iVWHBQ9mjfjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hHdVEMMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D99C2BBFC;
	Wed, 22 May 2024 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716393450;
	bh=s7fLrqlLqrdwUt4HwOiHRqZ1aWTDKv1ZtetuvCqzHYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHdVEMMT7yEeHEjRb8AKs6PdTe0Jz5DckgqlVSGU2qDb7VPWIn129BstQFh8me2tl
	 MVDouGgbq1ahnznEEuianDx6MpoStZKRn8SwW10V70H3t6nc5HNL8b/9clprSR3I/c
	 TNHToQXWpk8ktl2vvl8V0wR3SqsKyYwjt9rb7bT8=
Date: Wed, 22 May 2024 17:57:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Roland Xu <mu001999@outlook.com>
Cc: ojeda@kernel.org, boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: kernel: make impl_has_work compatible with more
 generics
Message-ID: <2024052258-trifocals-engaged-8d80@gregkh>
References: <ME0P282MB489023110AAF1163F0A4B2E1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
 <SY8P282MB48866A68C05C6444F0340A00CCEB2@SY8P282MB4886.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY8P282MB48866A68C05C6444F0340A00CCEB2@SY8P282MB4886.AUSP282.PROD.OUTLOOK.COM>

On Wed, May 22, 2024 at 11:45:33PM +0800, Roland Xu wrote:
> v2: apply comments, wrap lines at 72 columns
> ---

That goes below the --- line.

> Make the impl_has_work macro compatible with more complex generics such as lifetimes and const generic arguments.

Columns are still not wrapped :(

Look at example submissions on the mailing list for how to structure
this.

thanks,

greg k-h

