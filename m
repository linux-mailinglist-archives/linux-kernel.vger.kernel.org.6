Return-Path: <linux-kernel+bounces-528232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB46DA4153A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C809516A126
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982DC1CBEAA;
	Mon, 24 Feb 2025 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sjb16AnG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA31C84BA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377680; cv=none; b=WBLrkcZAxJ6De2erlxoTzcyv/4x/oJNmOprSQHp8N9rd9sCLRI/K2wrghKKlt0OGtBYq23M4m1NgJP11MzoUmBBDbIevcTmjx+bESII6lM3twi2M6FLawbRWgacikgk4XXOViFFZy7X0/IbT6B9kq8eSB1hRD513zrrrgHbjIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377680; c=relaxed/simple;
	bh=Sj+WDGRz5MVg3VGq6R+ObJqw+0Ui/+FSeflrv00EUks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3Bl4KQVtwf1EWx/CGZy8OvBY6oF39iEj8qLvsas3PuxG9K9C8vNer+wXAuOQ6y/f8YV8LSQ64Y0yV9f6uzEste6KcqXIKDe1gWTEC0i22MT0ADL/5ADD1G56svXxbenwmOfxvD/Qmov+X03Y+vRD8Ai5gQR3IacxnmVjdi/1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sjb16AnG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740377677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJAE5VQtKOJvPeRIxHRRWordcbnsd54QiHO4iNapbAU=;
	b=Sjb16AnGqbRzfZm69qV3bk1ZxGBfQVfb+ILHdZBRQOc96LY6FAbx0KdUwbHVjM2tHgEzo5
	WsvcJ543gHwCIqUh6ulH/0cYmZVatgSPlpiEDfvuSDiddYkW9a9a2UUzTyEf+Iq5zxjet9
	GPun4T+YZe80P/Dg3bb9J3xoYvGQ4XA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-mIj5mZ4mOF6cCPhbbVyElQ-1; Mon,
 24 Feb 2025 01:14:33 -0500
X-MC-Unique: mIj5mZ4mOF6cCPhbbVyElQ-1
X-Mimecast-MFC-AGG-ID: mIj5mZ4mOF6cCPhbbVyElQ_1740377671
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 276581979057;
	Mon, 24 Feb 2025 06:14:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9565519560AA;
	Mon, 24 Feb 2025 06:14:27 +0000 (UTC)
Date: Mon, 24 Feb 2025 14:14:22 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218225502.747963-3-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Steve, Mimi,

On 02/18/25 at 02:54pm, steven chen wrote:
> Currently, the mechanism to map and unmap segments to the kimage
> structure is not available to the subsystems outside of kexec.  This
> functionality is needed when IMA is allocating the memory segments
> during kexec 'load' operation.  Implement functions to map and unmap
> segments to kimage.

I am done with the whole patchset understanding. My concern is if this
TPM PCRs content can be carried over through newly introduced KHO. I can
see that these patchset doesn't introduce too much new code changes,
while if many conponents need do this, kexec reboot will be patched all
over its body and become ugly and hard to maintain.

Please check Mike Rapoport's v4 patchset to see if IMA can register
itself to KHO and do somthing during 2nd kernel init to restore those
TPM PCRs content to make sure all measurement logs are read correctly.
[PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)

Thanks
Baoquan


