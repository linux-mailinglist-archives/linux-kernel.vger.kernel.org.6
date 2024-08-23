Return-Path: <linux-kernel+bounces-299200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B295D172
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71BB2843CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC50188A26;
	Fri, 23 Aug 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="iH8G4+H3"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C41185E65
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427165; cv=none; b=sjTo9eUzOnXr0DZry//5bU7oXSV+kJZEQ1Z6WV0LFaksElS3HuDMfUpyAyTqeN28BaQl/1h8RWvYh3I/iC8XAjsHdfVCnkchc/c0OzFHd0MZ1Uh7Qe6bMu28nxE+DNIugK51YxV2c2IWSpXUNvWxQi+LI054RLO4BBZ7HQRhUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427165; c=relaxed/simple;
	bh=lRovpRvPDM1FRpXpaw8e8qd/145dPGlknJKCfiOo1UI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sEK2GsiA7eKPGuRhPNtihHjJl9PdIHnkNja+gtV02X32qPSPsqrcyi9b+LopKLsZKIJ9aY64YmMB+xy2x+9ZEYhW2zlfBt5y+LOdLDgwb8llDS2rej6nwgROXv3KztuudVDhMiu1zQqtk9is8voHn9jpnD7aHA23ISCLeakbCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=iH8G4+H3; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1724427163;
	bh=lRovpRvPDM1FRpXpaw8e8qd/145dPGlknJKCfiOo1UI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iH8G4+H3UseIeUMMKYkrBVUv1counoQmR0GgBW6xKnzSHApvTTtDL5uiTCre5jbBN
	 cIMdaFxHQ2JjJifgnfQgYv5hVOQ6cbtdS8lVuLe/IxSAhBkaRd6HK0p0rESry2MN/U
	 2k+AwxjI8GdkQk9zofv/CfBHh+p5GZEX2K0AEPm0=
Received: by gentwo.org (Postfix, from userid 1003)
	id 0EEFC40356; Fri, 23 Aug 2024 08:32:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 0DDD440355;
	Fri, 23 Aug 2024 08:32:43 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:32:43 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, ssengar@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
In-Reply-To: <20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Message-ID: <5a18105c-8e6f-39fa-370f-2d839d9ab843@gentwo.org>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com> <20240705135911.4a6e38379ae95c3fc6bbe7e2@linux-foundation.org> <20240709045750.GA32083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Jul 2024, Saurabh Singh Sengar wrote:

> > > Calling this for each CPU is expensive when there are large number
> > > of CPUs along with multiple NUMAs. Fix this by deferring
> > > refresh_zone_stat_thresholds to be called later at once when all the
> > > secondary CPUs are up. Also, register the DYN hooks to keep the
> > > existing hotplug functionality intact.
> > >
> >
> > Seems risky - we'll now have online CPUs which have unintialized data,
> > yes?  What assurance do we have that this data won't be accessed?
>
> I understand that this data is only accessed by userspace tools, and they can
> only access it post late_initcall. Please let me know if there are any other
> cases, I will look to address them.

stat_threshold is used in all statistics functions that modify VM
counters. It is core to the functioning of the VM statistics.

However, if the threshold is zero (not initialized) then the VM counter
handling will simply be less effective because it will not do the per cpu
counter diffs anymore. This may increase contention and eat up the benefit
you are getting from deferring the calculation of the threshholds.

What may be more promising is to make it possible to calculate the
threshholds per cpu instead of recalculating the thresholds for every zone
again and again.


