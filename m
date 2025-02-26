Return-Path: <linux-kernel+bounces-533416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F4EA459C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FDD3A5F44
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A5226CFD;
	Wed, 26 Feb 2025 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6T+7QkX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B022423E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561362; cv=none; b=HWvwHtOvu9sDXJLTG3cbyJawtuP63Hy/CCrgvu1RD1PFofsl6Q3i4tj+r0CTT3HfddKljUU4l81i4EqtrfgHploe3dSYzFHGPHJKcv5Vn4FPaKzW+F/yTJGb9kT3qgIO/dPeFxKO3EgRt+/DM/3nbCUMcVDfLHsw9IaovtyKiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561362; c=relaxed/simple;
	bh=CDKpoa6JYhdNvryR/KXhQpYi2Cao8mIK0AzdB0jv3no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCS2vUKH+CjVDXUe8y7JC0VeWcBn81eJuf1W+Kc6CoitObkKyGD4M/hCubgssH+3yBn50NkoclAoJ4WpVgtNOo97hFn13Eu83T4rmNzepJ0jh7XV2+Dmpk9sUzx8JdVGu1DTJYymlZ1Mz2hcR9MuFLkNfQyfyUiqjIuJ1gsYZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6T+7QkX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740561359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XojtBCcr5w0szdy1IeAG4QZH1lkn1vekvukihxM9RAk=;
	b=Y6T+7QkXkxjQEmpTFQXpleuaEk3VGgodyg4FIxHSdvGxGJ/tAOLQW6ZgRK1fYhm3JpnnZA
	yIZKzRyS1uOAeVCl1CXQCMD53HO9uDq8NGoiqNhUn93b80RgPO0aUKB5A4ld/PQBXWp+iD
	2ne8Blx8rNlKsh/xXzSq5RnSBuoiVJA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-d5N_Dd6iMXi-VpZZyq1Rgg-1; Wed,
 26 Feb 2025 04:15:56 -0500
X-MC-Unique: d5N_Dd6iMXi-VpZZyq1Rgg-1
X-Mimecast-MFC-AGG-ID: d5N_Dd6iMXi-VpZZyq1Rgg_1740561355
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 011B4196E078;
	Wed, 26 Feb 2025 09:15:55 +0000 (UTC)
Received: from fedora (unknown [10.72.120.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E71EB300018D;
	Wed, 26 Feb 2025 09:15:49 +0000 (UTC)
Date: Wed, 26 Feb 2025 17:15:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: complete command synchronously on error
Message-ID: <Z77bv8CNoPiwaf1o@fedora>
References: <20250225212456.2902549-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225212456.2902549-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Feb 25, 2025 at 02:24:55PM -0700, Caleb Sander Mateos wrote:
> In case of an error, ublk's ->uring_cmd() functions currently return
> -EIOCBQUEUED and immediately call io_uring_cmd_done(). -EIOCBQUEUED and
> io_uring_cmd_done() are intended for asynchronous completions. For
> synchronous completions, the ->uring_cmd() function can just return the
> negative return code directly. This skips io_uring_cmd_del_cancelable(),
> and deferring the completion to task work. So return the error code
> directly from __ublk_ch_uring_cmd() and ublk_ctrl_uring_cmd().
> 
> Update ublk_ch_uring_cmd_cb(), which currently ignores the return value
> from __ublk_ch_uring_cmd(), to call io_uring_cmd_done() for synchronous
> completions.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


