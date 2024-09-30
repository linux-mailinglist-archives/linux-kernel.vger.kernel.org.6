Return-Path: <linux-kernel+bounces-343300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D048F989952
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005481C20C78
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082827466;
	Mon, 30 Sep 2024 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDAdDeXQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB14195
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727665196; cv=none; b=gH9M5U7HG9GcWtIOILIqsxxFxwRn5o7fujJtgIOXTpwQQ0PX3tnYr5a4TgBsSZJKjkhCePx6tbNiTLcONDPS7k8TiqApOdvteFxfRTFm++gJ/4epOrY/gOspdPWAGnZ+EbpEPurbhHA+FbxtqMgGKVv4Fx7l7SruljNC16qDAeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727665196; c=relaxed/simple;
	bh=52ETwP6isu6QbD683EQIu95q3mYeXtz+F2oyo0mvDPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvbOmhn1tb4KHiql8S1RzwHIF5mAHBUxVxDV2bT+0o1i1RDAi1nxrZMEvFZ86UhSkHWBRYuKWlJA9ooaQ2JKsHeRsnIo4unZK9kcSnkGLAMe22zJOR/mHdKIDQdg1Jv5mzaT12BxfxwCWC87MU6e1Q6FcCZAiORWKmpuMJQ2o0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDAdDeXQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727665193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=52ETwP6isu6QbD683EQIu95q3mYeXtz+F2oyo0mvDPI=;
	b=hDAdDeXQIM8+OWoIWRsf+MCTXSPoTDdFV4cbrWlZ6r6fyf1LLTa2Fi/p3gRthNMRCIXXcj
	0k1Fva1jk3ULuQ08jZfOlhT/AbWZ+2xddAQfDdJ+KbUREKC20I7luwHkXcH+MWxiDhLhop
	Z5y6Jr4iMjTT2vUczFadE1fscJe5nbo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-uu9o7dTyMtSU1GJ1JgjymA-1; Sun,
 29 Sep 2024 22:59:49 -0400
X-MC-Unique: uu9o7dTyMtSU1GJ1JgjymA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95FB7196C42F;
	Mon, 30 Sep 2024 02:59:48 +0000 (UTC)
Received: from localhost (unknown [10.72.112.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 623FC3003E40;
	Mon, 30 Sep 2024 02:59:45 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:59:41 +0800
From: Baoquan He <bhe@redhat.com>
To: x86@kernel.org, thomas.lendacky@amd.com
Cc: dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-ID: <ZvoUHcDGsCyX9fg+@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911081615.262202-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi,

On 09/11/24 at 04:16pm, Baoquan He wrote:
> Currently, distros like Fedora/RHEL have enabled CONFIG_IMA_KEXEC by
> default. This makes kexec/kdump kernel always fail to boot up on SME
> platform because of a code bug. By debugging, the root cause is found
> out and bug is fixed with this patchset.

PING.

Can this be added into 6.12 so that SME system is available? Please
tell if there's any concern or comment.

Thanks
Baoquan


