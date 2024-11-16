Return-Path: <linux-kernel+bounces-411751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F3A9CFF2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C6D2836E6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15B19306F;
	Sat, 16 Nov 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzztqluI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFE161
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731763711; cv=none; b=agaqFE5I10hSaOWzDOMNz0U7RkBru4L8SOQ2A5lwF7dmO2jEfZ801lxfKZhqM+zcLw9u2ta1Q8BYcuNRwjKuqqdK6ryqeiIKRnvibJF+AMYh9s9UmhAC2BTGla5Ae68E8hrqQjtJhvckdUhFKv7CtEEW0Su/HQ7GpAC4hkKHyu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731763711; c=relaxed/simple;
	bh=KNmclWt+ATP4SArTRDpLkRCG1qV+1QuWe1Nv/B7rim0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+xP2aSTO/4QIACE9marcmNGnNH9Ffc/x9TIlgZ0560qP/cbUy6s55AuxXEVpYHP6WAbsyGmOw9mk7SlwPaDFC8AmEJ6guVaykUqpUSnhZPI+h1WVSqAYAY5TyMGD+yx3v4U2ximhZPQSonnGOr59wZOhyYVSsQjBBbdOXi9vzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzztqluI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731763708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qq8C4BaiGCD/J7h9VQtTaV3Ol041LIReh2JXiSX3iU=;
	b=VzztqluIIVpSP+f/KGIGRWydefvo4dy7fYgCJLTOzLA6HSrlQnheiCq8QDiZph1Ah3EoR1
	Y6jC1s+us4RjquXNhg2KvgmIJK4BisRhiRWwBkgcE/G9xsCzHcORzPBan1BWx0f90qL0p6
	eyqm+X64wGDs12fsum6Z+l0XX4qpGCo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2--PE7YWDjM-a16tIoBCzwJg-1; Sat,
 16 Nov 2024 08:28:24 -0500
X-MC-Unique: -PE7YWDjM-a16tIoBCzwJg-1
X-Mimecast-MFC-AGG-ID: -PE7YWDjM-a16tIoBCzwJg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65A6C1956096;
	Sat, 16 Nov 2024 13:28:23 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12BCF19560A3;
	Sat, 16 Nov 2024 13:28:21 +0000 (UTC)
Date: Sat, 16 Nov 2024 21:28:17 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/ioremap: use helper to implement
 xxx_is_setup_data()
Message-ID: <Zzid8dMZHAmfyUI9@MiWiFi-R3L-srv>
References: <20241115012131.509226-1-bhe@redhat.com>
 <20241115012131.509226-3-bhe@redhat.com>
 <0dd9802f-ee28-180e-98b2-854c32288a72@amd.com>
 <ZzhZinP5QLwHrPYa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzhZinP5QLwHrPYa@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/16/24 at 09:36am, Ingo Molnar wrote:
> 
> * Tom Lendacky <thomas.lendacky@amd.com> wrote:
> 
> > On 11/14/24 19:21, Baoquan He wrote:
> > > This simplifies codes a lot by removing the duplicated code handling.
> > 
> > You should probably squash this with the first patch.
> > 
> > > 
> > > And also remove the similar code comment above of them.
> > > 
> > > While at it, add __ref to memremap_is_setup_data() to avoid
> > 
> > The __ref shouldn't be needed if you remove the __init from the helper
> > function.
> 
> Yeah.
> 
> Baoquan, I've zapped these 3 commits from tip:x86/mm for now, mind resending them the init 
> annotations fixed?

Sure, will resend. Thanks.


