Return-Path: <linux-kernel+bounces-255810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913CF934570
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABF4282F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB539139F;
	Thu, 18 Jul 2024 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtgWglNw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E71620
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721263313; cv=none; b=pplFJPe+biM5YelAwOqa8s/EXWZKlYuCE0mXuEdR300f9+MTbpyDIB9PEm9MEHO/VjxP2EEHPBZ9fURGZ7Y889v+42DxK5P12rIoe3js/IYVF1j60y15ApoOvi600pePs980xwlbbOdpYcANmSdb9OBGchwSO9o5tV74UfIRO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721263313; c=relaxed/simple;
	bh=lSvybALRWvHF1rtJfkzZbYfr1p9w9Mz+LEDj5AiDpEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amZcHEBvBht7i4vtcywnSpPNWy0D5oe/RVOsTHdyTGtI0oOEpuMC1ch4z7iSmfxzTC7XjmaSp4eaA2jYWb09LSV8RM4CIL9PJMsJaX2xpNE4ulv67POKOVlNfGR5GkmurXCvRwjrqKey6MIJYHwjY7XK2I2R8+0OaxK9vq7IpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtgWglNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721263310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdT1Q8DUAxZNiL7SNTBgQkDNeP4OE0UKnHCkmEwALTQ=;
	b=RtgWglNwi0PThelDK40zSmj6k1cUJ5j0+X3m9ifuIaP8O9BBKtNDvod6+5vwXLF6N1XGUQ
	ar+uICdBxfu7FmDs1Uq90W2nORXwdl2We3Sz3gu3NSwn3bKbnYrNL4OTw55WHNqWYi4AnQ
	BHH/V581KrVvMDzSRVTQeERCtH0b3uU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-1K_buE-fOEKq7ZT6Gsqghw-1; Wed,
 17 Jul 2024 20:41:49 -0400
X-MC-Unique: 1K_buE-fOEKq7ZT6Gsqghw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEAA91955F43;
	Thu, 18 Jul 2024 00:41:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF99319560B2;
	Thu, 18 Jul 2024 00:41:43 +0000 (UTC)
Date: Thu, 18 Jul 2024 08:41:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crash: fix x86_32 memory reserve dead loop retry
 bug at "high"
Message-ID: <Zphkw7sSmdIXzicY@MiWiFi-R3L-srv>
References: <20240717070904.2671147-1-ruanjinjie@huawei.com>
 <ZpfJYcjZ0QmFUpPf@MiWiFi-R3L-srv>
 <20240717124916.0535d675cadf2feeee9752fe@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717124916.0535d675cadf2feeee9752fe@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/17/24 at 12:49pm, Andrew Morton wrote:
> On Wed, 17 Jul 2024 21:38:41 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > 1) revert commit 8f9dade5906a in Andrew's tree;

Thanks, Andrew.


