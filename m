Return-Path: <linux-kernel+bounces-287987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB48952F01
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D249B1C2369C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2E919E7E6;
	Thu, 15 Aug 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFunY7t0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8617CA1D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728308; cv=none; b=IHsLHUG914sWFpIadYd+a5Gmz0PJLP+L8H94lh1RDstt0PO4T7nHrSnkLFJMntTjLlHQy0m4t9diJ9ZE+gcISvBkCf4arxHufRXfsGLR5TnUFNej+qhP+Sfp3zW9b6DAUtRPpQyuswdeMSTM3PquNGFaaVseE+MA9W4AgKrByoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728308; c=relaxed/simple;
	bh=G5+XfiPM6LQ17WiipMjgZYP1kkhGBD84tmDH4lCo29w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6J4NUY37A9I/1800fAtoXtL+/6MS9J9pKwyJLFQ9cl4WqT0PMin+9RmfoAcrB4MHCLt8iCV0c0IYFf+Zpi1hLqfem7PCt1SY+5mEgW9y/kpnTTe+MRbe9htI1uQSRwk0De8W8ocX6JNEkJs7JrEMx0ufzNVpAS4p+irDMJn9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFunY7t0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723728306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G5+XfiPM6LQ17WiipMjgZYP1kkhGBD84tmDH4lCo29w=;
	b=PFunY7t0MomUrIt8RIKk8Q8ByZOBKCaQKFtxeVGGC2iM2YQ3gHUwY0de3uJs+URBUhaAZM
	cFY/Hqy3PeVVsAxe04PUEReCw2Ag7WReS7O4TbkiZMMDphidNptBerhGpEbUIi0tvISZMt
	TsIOd0GRgX1VLRAvtR2CiCeEyNY1FX4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-AWDy-QXUPCaqAvQ73czgkQ-1; Thu,
 15 Aug 2024 09:24:59 -0400
X-MC-Unique: AWDy-QXUPCaqAvQ73czgkQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AEE81955BF2;
	Thu, 15 Aug 2024 13:24:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 49ED23001FDD;
	Thu, 15 Aug 2024 13:24:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 15 Aug 2024 15:24:53 +0200 (CEST)
Date: Thu, 15 Aug 2024 15:24:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 00/13] uprobes: RCU-protected hot path optimizations
Message-ID: <20240815132447.GA15970@redhat.com>
References: <20240813042917.506057-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/12, Andrii Nakryiko wrote:
>
> ( In addition to previously posted first 8 patches, I'm sending 5 more as an
> RFC for people to get the general gist of where this work heading and what
> uprobe performance is now achievable. I think first 8 patches are ready to be
> applied and I'd appreciate early feedback on the remaining 5 ones.

I didn't read the "RFC" patches yet, will try to do on weekend.

As for 1-8, I failed to find any problem:
Reviewed-by: Oleg Nesterov <oleg@redhat.com>


