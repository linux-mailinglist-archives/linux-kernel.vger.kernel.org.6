Return-Path: <linux-kernel+bounces-543086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A79CAA4D14A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF2C1897848
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69615747D;
	Tue,  4 Mar 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lm8zRq71"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666015383A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053412; cv=none; b=Vgp2rS4hp8ZHVy9ltY9YsR78YtdsO6spE+nPjza1CmL85TgjJuxBjFdIPjQfqo6caoV3/2n2RqE41T8xycHuKFIDlgnlaLVDqiyuvUjj8yVAeXs54LiAFZ/oUPrN0KZk2l2cUcvldxt3rngyHYGdte2sRh88slZyqSJ6zGr5+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053412; c=relaxed/simple;
	bh=ckwES0wRXBhpCdcj4WA8NtfzZH/0wnwIVg6NCZ4v9Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSzP+FT8egfaEjGWI2EcQoeJXNDpc7rzO8BRQ5ca6OloRDBxQRKq4xNHZfKtoLJUx1UYA7XACKfJtSEnVejqsyIr2SwBk6sI7Ei+8eW3g4b91Xlpftj8CtDvqX2ht4jiw5w6uJAc0pucDRryaDbYKJkaaLbwY4/hqClW//+ekTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lm8zRq71; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741053410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSm2mAYGj6WACUOO5bbq2aEV25O4CvctarLFrMmLDPo=;
	b=Lm8zRq71iXM+wNdCAY/04X4JW2AeNP7jZ2I1Jo6vrPZxl4We1nCHQeSoWPExkjaJDipjYA
	KbTdF4vhPoxpZTtXcNzuacC5d8P7mvIv2j70J2Y/Ul5tRo4Yr4P4rjHwkJIiQcsVAG2smb
	6UKbMuHVfA5sOKtZdJIKYGrW+NBaTqE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-5NMN1ISPN6Sds1r6Q59hqg-1; Mon,
 03 Mar 2025 20:56:41 -0500
X-MC-Unique: 5NMN1ISPN6Sds1r6Q59hqg-1
X-Mimecast-MFC-AGG-ID: 5NMN1ISPN6Sds1r6Q59hqg_1741053400
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C691819560BC;
	Tue,  4 Mar 2025 01:56:40 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F4563000197;
	Tue,  4 Mar 2025 01:56:36 +0000 (UTC)
Date: Tue, 4 Mar 2025 09:56:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: don't cast registered buffer index to int
Message-ID: <Z8Zdz9cKSAadx7-F@fedora>
References: <20250301190317.950208-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301190317.950208-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Mar 01, 2025 at 12:03:16PM -0700, Caleb Sander Mateos wrote:
> io_buffer_register_bvec() takes index as an unsigned int argument, but
> ublk_register_io_buf() casts ub_cmd->addr (a u64) to int. Remove the
> misleading cast and instead pass index as an unsigned value to
> ublk_register_io_buf() and ublk_unregister_io_buf().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


