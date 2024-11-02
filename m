Return-Path: <linux-kernel+bounces-393071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774669B9B8D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F20D2829A3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE978F77;
	Sat,  2 Nov 2024 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8Qh4QYH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75D6AB8
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730507031; cv=none; b=j29ynrnn6I8ObXuA85jL7mTpjTvrCYlNN+tP9RCZ28sD5LVZQwAE9KN2wl8HN9Qsft8JWq3L65lXQMMlxcKBcohNs3aDSSe9ECZVhZWmQn6N2mYrL5Pq+8j5NZ245MS0ULnpotc7PmmhYx6WXdGt3fBdvTkUWT1qbr79rHHLa40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730507031; c=relaxed/simple;
	bh=dEma5aIn0mASXtsHj8nPn7zriiz22/Bds1DIBpvkIjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+GfQJCP+lUtatftjo5gU/tiP4xRWsm3Ww0BlWKv+ngFCUFQrjGeCByccoTf1pzhVZovqjQGOtKOqyn0VC9bFJFSyPkcDzUdjpY0bQ+UqTPX3TZU8KGPUBupUuJ1/Wcv0HYdPjtJ5ZUQkrZbwxql/nLjVy/smDO/ShPLfjgm2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8Qh4QYH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730507028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVZopAEbNBIrE6Pzb3BRalzXXCBqMKqri4Yq7OKfFwA=;
	b=g8Qh4QYHPLmeND5lL/k5c7hg9ntCdcKMdeahjs75lgCYw7TdpRS8cBKxb1wXphi2j+1hzr
	8Ne0WXSiQWe2ioLdfkUkV6ajCMSq2lD9ovtgUp/8431xYsJGtdrQn8MymPeHu36EX1pnrJ
	At03WaD5VPjTQL2ZCd2h9sNPaFE0KNk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-dCoGU5loNI6vRHz0pLacCw-1; Fri,
 01 Nov 2024 20:23:42 -0400
X-MC-Unique: dCoGU5loNI6vRHz0pLacCw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 603EB1955D94;
	Sat,  2 Nov 2024 00:23:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C399719560A2;
	Sat,  2 Nov 2024 00:23:38 +0000 (UTC)
Date: Sat, 2 Nov 2024 08:23:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
 <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/01/24 at 05:18pm, Borislav Petkov wrote:
> On Thu, Oct 31, 2024 at 11:41:12AM +0800, Baoquan He wrote:
> > Should I send the fixing patch alone and clean up the useless argument
> > 'size' later, or squash them into one patch?
> 
> First the fix, then the cleanup.

Sure, will do. Thanks a lot.

> 
> Btw, that fix wants to go to stable no? Seeing how it breaks certain machines
> with IMA and kdump and SMe...

Yeah, it should be added to stable. Distros may get both SME/IMA set not
as early as the bug introduced, while anyone doing so in an earlier kernel
will see the problem.


