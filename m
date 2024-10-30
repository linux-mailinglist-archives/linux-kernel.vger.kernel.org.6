Return-Path: <linux-kernel+bounces-388072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D956B9B5A21
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B551C22280
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED019342A;
	Wed, 30 Oct 2024 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LntpQzLc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24D4437
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256874; cv=none; b=LsBxcgfkiU7krDrti3l6rMGFTuyHJPcloQDwQ6wclhxpUqRQT43buxF1iVyuGeG6r5Dj65jL71ezjeOOVtbM3030RXw2TE+DXHrShyvWeXAuFuSrXzGWnRabVSx3KXEJPhdpegBxWN6ZqPsI3bTkN/ypCZzAfEEaRJG2b7/Nqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256874; c=relaxed/simple;
	bh=ItLN/nhAc0kcHHAUxgaiSlGdG2tzUPBzkdXwKtbCZZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hivZW/ub9Nb8yiWZUOt5jeISun8yTMs2F7xQSAwkEbceTSXtdUVipEFXgYTNGRjd5KVOyQSpHkl0ahi/dPcg3yZInBc5MPZY9m8F09QQKdAllElbiIfht6FXv4kmawTKogDLL0w5OslhDrgaZ8wMQKHrC2FhhncmzvKq+JdZ31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LntpQzLc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730256870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9MajDa86shltyihCJs2RWiiHVZZLIphX6dVVnM3/Ivw=;
	b=LntpQzLc7hvErYxLiPzCoNeN0hPftz+ZjYKE/XtfUX19IdZsl41UeACVFSaNKLc64VHJT8
	Yk91axlqncEYwU9gSTQ2bosClBX4QaxWMzyHuJpUzIDSQahB/GPicHnO+zYHuFkGzpoD/v
	ABRXggtxyeEqbtbbRPKPpmgdlJmIXhI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-oqLcKpGVNSKeFJnwoe99ow-1; Tue,
 29 Oct 2024 22:54:24 -0400
X-MC-Unique: oqLcKpGVNSKeFJnwoe99ow-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 367F6195608A;
	Wed, 30 Oct 2024 02:54:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58B4A19560A2;
	Wed, 30 Oct 2024 02:54:20 +0000 (UTC)
Date: Wed, 30 Oct 2024 10:54:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-ID: <ZyGf2PZtf4H+dE9u@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20241029182306.04c3451808c8b76e5e96fdb4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029182306.04c3451808c8b76e5e96fdb4@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/29/24 at 06:23pm, Andrew Morton wrote:
> On Wed, 11 Sep 2024 16:16:13 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > Currently, distros like Fedora/RHEL have enabled CONFIG_IMA_KEXEC by
> > default. This makes kexec/kdump kernel always fail to boot up on SME
> > platform because of a code bug. By debugging, the root cause is found
> > out and bug is fixed with this patchset.
> 
> [1/1] is a cleanup.  [2/2] fixes a bug which appears to go all the way
> back to 5.10.  The bugfix patch has a dependency on the cleanup, which
> is unfortunate.
> 
> We could add the Fixes: to [1/1] and add cc:stable to both patches so
> they get backported into -stable kernels together.  But I think it's
> nicer to just concentrate on the single bugfix patch (with Fixes: and
> cc:stable) and do the cleanup later, in the usual fashion.

Totally agree, thanks a lot.

> 
> So can I suggest a resend please?

Will send a standalone patch to fix the bug, and send clean up patch
after the fix patch is settled.


