Return-Path: <linux-kernel+bounces-379096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D101C9AD9DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70B41C20DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BDE145B16;
	Thu, 24 Oct 2024 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MXeSpvzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436013BACC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736550; cv=none; b=TFFv2tW6Eah+f1OhocddFkSqJTi9B7bcr4vapccQIp9Ibdqk1z97O1VZ54kJB96h5TCxGFQLw97aj6v6LpsHgIR76afZTeTqTwcxMnGEl/Ub8MCwlzWrTo6KKRBfORvg9+nssNsBWMwWuJkDxrv+t6l8f/GmHPrjUuIZ+c9Yo2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736550; c=relaxed/simple;
	bh=inagGVKt4Zy33/ZhgAeuzXkDRExPeMKmeWkxJN+StHE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Uc730DlrAOBGyZboGoAsPsCjG6/eEU2GGRyiMFq5E0X2O2DJJlrxwrdwbYes4DXrhXNJDBpmH0YtftuSef0ULgGC4JlEYOLnClVnILXJF4n3DYaJuvu1LeRbLzsdxB4wSQLilehQMIKDtxVMur/oqCpV04oAiM7Pobb4EK+bLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MXeSpvzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD7FC4CEC6;
	Thu, 24 Oct 2024 02:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729736549;
	bh=inagGVKt4Zy33/ZhgAeuzXkDRExPeMKmeWkxJN+StHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MXeSpvzNZH3neEpfIqeBYyTuGrfYdNqTJ2UNkCyomcsiNhfK7p03iX8EBK4XpNHxN
	 q2WMUdjTYcnkaHDpSUg6Aj0cXvEyLymTab+z1UuQhpxQo+aplU98X18LEMW9D4xfOm
	 6IIrG145K0vpUS9w6ydRaHBJu9zzOfbo6JW17Oeo=
Date: Wed, 23 Oct 2024 19:22:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <simona.vetter@ffwll.ch>, <felix.kuehling@amd.com>, <apopple@nvidia.com>
Subject: Re: [PATCH v3 1/1] mm/migrate: Add migrate_device_pfns
Message-Id: <20241023192229.64333482554de0135397cb23@linux-foundation.org>
In-Reply-To: <Zxmn6uGSOgi11rO2@DUT025-TGLU.fm.intel.com>
References: <20241023233944.1798835-1-matthew.brost@intel.com>
	<20241023233944.1798835-2-matthew.brost@intel.com>
	<20241023182217.147ee87197b53d47057a4c06@linux-foundation.org>
	<Zxmn6uGSOgi11rO2@DUT025-TGLU.fm.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 01:50:34 +0000 Matthew Brost <matthew.brost@intel.com> wrote:

> > On Wed, 23 Oct 2024 16:39:44 -0700 Matthew Brost <matthew.brost@intel.com> wrote:
> > 
> > > Implement migrate_device_pfns to prepare an array of PFNs for migration.
> > > Handles non-contiguous ranges of device pages that require migration.
> > 
> > OK, that's "what".  We're more interested in "why".
> > 
> 
> Sure can add. The 'why' is:
> 
> A non-contiguous allocation of device pages can occur if a device is
> under memory pressure within a single driver allocation of device
> memory. Additionally, a driver allocation of memory can also be evicted
> under memory pressure. Therefore, an interface for migrating a set of
> non-contiguous device pages is required.

OK, thanks.  But when merging a new interface such as this we like to
see the code which will actually use the interface.  Along with reasons
to believe that the calling code will actually be merged, so we don't
end up with a new interface which has no callers.

Apart from that, I suspect that it makes more sense to merge this via
the DRM tree, alongside the code which uses it.


