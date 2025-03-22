Return-Path: <linux-kernel+bounces-572234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABAA6C814
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB067A6FDD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF1193079;
	Sat, 22 Mar 2025 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTrRL3jK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC2187554
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742628834; cv=none; b=jG0M73a4TIGSuOdPwqDhC/lcoX39QBon2yf08+Hc6ElIKEjaV9MOvcoHQa+nVoRJTJ0nltBF3qm1wB0ic76me7AC1uYfLqZ0PJnGzKvRT6u80EI2bUdV/zR6HIsdeJZxWeWMX6l/TP4rwyAE1SZPa8dVXBtSaPmGJ0/tBUstUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742628834; c=relaxed/simple;
	bh=hGu8+u0b1DLw8e28+tuafsDLk5i+SSFEYTwazDx4bI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/N12Jfekn6jKPiZNUNDadGCd5hQYSJSstiRNzAG5KwnfnJDj7wzEFjuAfRPmLY46HP9iAjdov9gbaG3arXedlt6CUXvDRUoKNDwUTqMdgt8H8JKNLvW3NJRx8HnuLptArY8KUYqLihWK7k7qxXGXI3x2aGDzFvJMqz5cLCnWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTrRL3jK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742628830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2+qeq0JgnGOpt+C/CZ/JR6EIs1Cxtjx4y7+UO1YN5s=;
	b=QTrRL3jKqC4iVTePUOH046DQ8PT34WPNyoj2/uWr/cGdqImz0uFk3dNjf40Awbw3xHwDaH
	Cen/oKrFcRNp7AMhscEwocBpZqSH9eTZmO+JPCa0SIdO8lnbLAcFFhwc2S09Tsw+89b2Zi
	diLD6kxNAPM4hcpm5pGcpHVkUN/gVvU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-zJ8_zrk0MiuB6v8_0t0EuQ-1; Sat,
 22 Mar 2025 03:33:47 -0400
X-MC-Unique: zJ8_zrk0MiuB6v8_0t0EuQ-1
X-Mimecast-MFC-AGG-ID: zJ8_zrk0MiuB6v8_0t0EuQ_1742628825
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FF681809CA6;
	Sat, 22 Mar 2025 07:33:45 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0644E19560AF;
	Sat, 22 Mar 2025 07:33:36 +0000 (UTC)
Date: Sat, 22 Mar 2025 15:33:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/3] Consistently look up fixed buffers before going async
Message-ID: <Z95nyw8LUw0aHKCu@fedora>
References: <20250321184819.3847386-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321184819.3847386-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Mar 21, 2025 at 12:48:16PM -0600, Caleb Sander Mateos wrote:
> To use ublk zero copy, an application submits a sequence of io_uring
> operations:
> (1) Register a ublk request's buffer into the fixed buffer table
> (2) Use the fixed buffer in some I/O operation
> (3) Unregister the buffer from the fixed buffer table
> 
> The ordering of these operations is critical; if the fixed buffer lookup
> occurs before the register or after the unregister operation, the I/O
> will fail with EFAULT or even corrupt a different ublk request's buffer.
> It is possible to guarantee the correct order by linking the operations,
> but that adds overhead and doesn't allow multiple I/O operations to
> execute in parallel using the same ublk request's buffer. Ideally, the
> application could just submit the register, I/O, and unregister SQEs in
> the desired order without links and io_uring would ensure the ordering.

So far there are only two ways to provide the order guarantee in io_uring
syscall viewpoint:

1) IOSQE_IO_LINK

2) submit register_buffer operation and wait its completion, then submit IO
operations

Otherwise, you may just depend on the implementation, and there isn't such
order guarantee, and it is hard to write generic io_uring application.

I posted sqe group patchset for addressing this particular requirement in
API level.

https://lore.kernel.org/linux-block/20241107110149.890530-1-ming.lei@redhat.com/

Now I'd suggest to re-consider this approach for respecting the order
in API level, so both application and io_uring needn't play trick for
addressing this real problem.

With sqe group, just two OPs are needed:

- provide_buffer OP(group leader)

- other generic OPs(group members)

group leader won't be completed until all group member OPs are done.

The whole group share same IO_LINK/IO_HARDLINK flag.

That is all the concept, and this approach takes less SQEs, and application
will become simpler too.


Thanks,
Ming


