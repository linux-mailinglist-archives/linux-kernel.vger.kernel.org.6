Return-Path: <linux-kernel+bounces-399586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB189C0122
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D44B21ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04E194AD8;
	Thu,  7 Nov 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O31T7Sux"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A1DBA2D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971815; cv=none; b=imPCPlulZhDYy02wIx3LGRe4r2+R5YCDJUx+Uena09lMrgaJ6WZkB/5Jc9hWsAY3cXIVnY+aJvtZdTw3FiR6ThKjuVFEtz/kd9fWx2D4xQbjWoPdQhgvQ+GLjQ/lSG8ZVHzb3xtFN9md0WiHRMBSVLmQcxUSD2ylJPLXv0hoaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971815; c=relaxed/simple;
	bh=ECBRb1H0TgVscUduxBMQPxRkHND3R6pcvjRm2pPWj/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwbsVxe6z7PDyjRzlOuiI0ZIUO6WxexXf+Z+0urnqcwBrvqJ+jaUWpeIWmtTnK7By+xY4EnMedxBuefSZhzY1HoQG6ALZkjHi9wWoVnfTsJ59mOdgaH6jB3V/Nh+LcxDjSAo4f+o2rSJJFfoGAFOAsOMbjKP4AIqMC4ZasRfMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O31T7Sux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730971813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zP+DJ0/7LJ4723YZGZpKMGkLZrefkCQcMD0ml6N+XeE=;
	b=O31T7SuxcMBigd65BzWrMFvAweyOT+NSJfh4FjrmPhMUDO4r6RUH37LplJda5HiF44m/Kd
	v4fkfZ+p8J0XaByNTEtShr4lIO//XaSRtVIqXHZNzLMBx4VtvT1sOfP54VhcQzc6C2vt9h
	p0v6DgKg3Ot6LBfyFki21xXdFsYfPUc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-hAfAq9TUOdq7hQ4jkyeavg-1; Thu,
 07 Nov 2024 04:30:08 -0500
X-MC-Unique: hAfAq9TUOdq7hQ4jkyeavg-1
X-Mimecast-MFC-AGG-ID: hAfAq9TUOdq7hQ4jkyeavg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D5BE1955F57;
	Thu,  7 Nov 2024 09:30:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.155])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B7EA1956054;
	Thu,  7 Nov 2024 09:30:04 +0000 (UTC)
Date: Thu, 7 Nov 2024 17:30:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <ZyyImAlkcpTHlszJ@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
 <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
 <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
 <20241102110618.GAZyYHquhmVJd4yM9O@fat_crate.local>
 <20241106112052.GCZytRFKTESZI8_3qD@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106112052.GCZytRFKTESZI8_3qD@fat_crate.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 11/06/24 at 12:20pm, Borislav Petkov wrote:
> On Sat, Nov 02, 2024 at 12:06:18PM +0100, Borislav Petkov wrote:
> > Ok, I'll take your 2/2 next week and you can then send the cleanup ontop.
> 
> OMG what a mess this is. Please test the below before I apply it.

Just got a machine and building kernel, will report here when testing is
done.

> 
> Then, when you do the cleanup, do the following:
> 
> - merge early_memremap_is_setup_data() with memremap_is_setup_data() into
>   a common __memremap_is_setup_data() and then add a bool early which
>   determines which memremap variant is called.
> 
> - unify the @size argument by dropping it and using a function local size.
>   What we have there now is the definition of bitrot. :-\
> 
> - replace all sizeof(*data), sizeof(struct setup_data) with a macro definition
>   above the functions to unify it properly.
> 
> What an ugly mess... :-\

Will clean them all up as suggested. Thanks.


