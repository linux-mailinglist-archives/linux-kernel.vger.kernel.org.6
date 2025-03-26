Return-Path: <linux-kernel+bounces-576441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD2A70F49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C5D176FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F7315B54C;
	Wed, 26 Mar 2025 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrwXLIP9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D404154BFE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742958465; cv=none; b=mIMZvsGdd6LusvvrEuyIN9egKhv0Nq++qGpUu8p8hrnS2cgjok3T2J25b39GaxingqV3pdJp97stRHyNUBH4skQxsUoKf14EQP5q9zo63zh/2QDbLoI7SE94+GPTzvS2JQPnorWXhzp/y6+T8R3yysStI8Jp9+WcimPQxP6DGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742958465; c=relaxed/simple;
	bh=yN/Lkx1N0OJq5Y+e3NqV/4uO+thy5fSIVb8mX/V8l5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC+LxSR9cjlGe62vshqZs9N9DP4ESQA4IrolGMuTXboz7Dadfy/fBMf69dCLpBpeAE1PYVvMFoL8RlXLmdf57SAFmrtEKeblH8FypJ1lwcBhwptfJ8f2P6ChyHo69H8dCCd6a0P1QeFNYETyJY3t3a8LhYVTm6xFtJBtlM20GN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrwXLIP9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742958462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5cBqfDizozM+WCO0bJhlFa+MM3ZqxFCbpm0gEORpsS4=;
	b=KrwXLIP901XD4nduOb5Lm0gfM5nmrX8Uf8XI8hXgPM5Z7t6IKvP8EIQPUS8Xn2mzSe6Yj8
	ny8AEdNXLQ5fNQV6WHsc6CXd07+/y/0kqhdhbmv/CXDTHgp10u6CL0LTOdS+/2EtXv0zRx
	KtklPb5mWQkydBnjQmVFGnIj/0EjCcs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-oGx5zoQ7Peeu2GShCexApg-1; Tue,
 25 Mar 2025 23:07:37 -0400
X-MC-Unique: oGx5zoQ7Peeu2GShCexApg-1
X-Mimecast-MFC-AGG-ID: oGx5zoQ7Peeu2GShCexApg_1742958456
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F049C1800257;
	Wed, 26 Mar 2025 03:07:35 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CDC6180B493;
	Wed, 26 Mar 2025 03:07:29 +0000 (UTC)
Date: Wed, 26 Mar 2025 11:07:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: ublk: kublk: use ioctl-encoded opcodes
Message-ID: <Z-NvbFqIJgxHisd3@fedora>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Mar 25, 2025 at 04:19:31PM -0600, Uday Shankar wrote:
> There are a couple of places in the kublk selftests ublk server which
> use the legacy ublk opcodes. These operations fail (with -EOPNOTSUPP) on
> a kernel compiled without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES set. We
> could easily require it to be set as a prerequisite for these selftests,
> but since new applications should not be using the legacy opcodes, use
> the ioctl-encoded opcodes everywhere in kublk.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


