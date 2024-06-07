Return-Path: <linux-kernel+bounces-205758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966A8FFFE1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771211C22653
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8B113D528;
	Fri,  7 Jun 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPoo60FQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24095200A0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753825; cv=none; b=nMKHyaixbEVGWpo5vD8/ZfXPkdyrOcFG4rvAwvXc1hlqKhL+3Y77Zw5CZx+uez9Z5YzXmS/GIcDDCzQsoqrFY1/v99EFKkwrqD9sW9hQYfO3UpZiW+U+IxwpN+nTRFZOdgIsZP9ELszn8GdxVLa+UdbN40RToDbNimLnwvXIoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753825; c=relaxed/simple;
	bh=GfdrNxIto9LrX3291I/Ir5iCj0FFVWGDbt2Rv7uvcXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm37qwVTTOTIkaITo/N96GS0EafHPPvJoHH0GO/kKt/b0iF3jS9MMUDOB7aXlzg5ElI3711JR+jrS2GmjYKcLaAa81NjOvjng0VPkVjkSiQrp7Iu5abJttMrrqKV2N7yKxZ0Prz7YB45PO0znRXhCwf+5mLDWi2KDr/jvvGZiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPoo60FQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717753823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgUcKDXwW/3wItiPJn/Z+o3EMy54AtmFeCxWRvfH4ZE=;
	b=XPoo60FQZ6OqbLg22iZEQdzqzWpr8g69PZhAcQ7tH6zq76G4dbGO9G3FnW03hFE2dfROlA
	521rEJDf7kg1/5LyLcVk3dpChXrc4YweFjdWqSpqVmLXCSqJ4EJWaGLMes6Ez++80Zud70
	SFWarj8WCrUaA2the/qxe4FTwdqIdxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-XIAT92ayN7-n_AW4BioL7w-1; Fri, 07 Jun 2024 05:50:21 -0400
X-MC-Unique: XIAT92ayN7-n_AW4BioL7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A10685A5B5;
	Fri,  7 Jun 2024 09:50:20 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 65F2140C6EB7;
	Fri,  7 Jun 2024 09:50:18 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:50:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Message-ID: <ZmLX15YJIhUG/XP3@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-6-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-6-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 05/23/24 at 01:04pm, Coiby Xu wrote:
......
> +ssize_t __weak dm_crypt_keys_read(char *buf, size_t count, u64 *ppos)
> +{
> +	struct kvec kvec = { .iov_base = buf, .iov_len = count };
> +	struct iov_iter iter;
> +
> +	iov_iter_kvec(&iter, READ, &kvec, 1, count);
> +	return read_from_oldmem(&iter, count, ppos, false);
Do we need create a x86 specific version to cope with the confidential
computing thing, e.g sme/tdx?

> +}
> +


