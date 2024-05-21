Return-Path: <linux-kernel+bounces-184368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87398CA630
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70147281A22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A51BF37;
	Tue, 21 May 2024 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPW/NJG9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641218B1A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258734; cv=none; b=WLrVPTdJGdYCzyALgT8bbOPAzliaNFDOkqVLt0Z1E4AwB7IpuS+8ZRU9dZ8o0udP4kURSs+Bes9cQn9jDQkDG5vi0lNMFLv23Z9m+cpdbSAUGTuKuPGpxKHIWuCiICOECq2VNd6kp5xNii+ajkAk6IKkwNtuvfwvkCU2cFc99nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258734; c=relaxed/simple;
	bh=TxaiOK+n9xLn7AmF/Nk/8MmJvBcjtJjWDr86bLQQoGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcsnrEXZ9sO6QGVTKaSnnguRMhJdeN0hBkbzlZKGXB+0RMZl0vqRWphX1iZvPZLl2TDp1AHHl3WLcv/Qm8rr/PgBq41DTzu0eC2pL5k0d6MghvFOgVBP+AmR3AWhvuP0+0kvG9RR0vqdflDlkoIn+7HjneJnsJZA8YBCRo2pxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPW/NJG9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716258732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Un8QUR/OoDAegeOGSZU2tmkAkH/Qfnn42zoBkjHSFWQ=;
	b=WPW/NJG9dCSi4Gza5PN3Yy+pQfDJyYz89Unx2sHawEyOJuex2ZbMMY+aIQ+L64Utsb0rX1
	AubveTl4NCxH3YkdbMmSZvyqXS9XqsQ/HASwpJTwldE1ZBPZ4m4yc18Cu3IvBHBKD66lSn
	PCE2WehS+fsWn1XPGay2848d0zx5A3E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-jxA6zLjfPNq6lOlyTHTqrw-1; Mon,
 20 May 2024 22:32:10 -0400
X-MC-Unique: jxA6zLjfPNq6lOlyTHTqrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C6CA29AA39D;
	Tue, 21 May 2024 02:32:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 91A8D100B0C0;
	Tue, 21 May 2024 02:32:04 +0000 (UTC)
Date: Tue, 21 May 2024 10:31:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <ZkwHnw6HkGFFq7mR@fedora>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
 <87r0e7mt9w.ffs@tglx>
 <20240520153742.GB921@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520153742.GB921@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Mon, May 20, 2024 at 05:37:42PM +0200, Christoph Hellwig wrote:
> On Sun, May 12, 2024 at 08:35:55AM +0200, Thomas Gleixner wrote:
> > That's expected as you pin the I/O operation on the isolated CPUs which
> > in turn makes them use the per CPU queue.
> > 
> > The isolated CPUs are only excluded for device management interrupts,
> > but not for the affinity spread of the queues.
> 
> We'll probably need a version of isolcpus that also excludes the
> interrupt spread given that users are asking for it.  And I'd much
> prefer that over adding radom module options to every driver to disable
> managed interrupts.

BTW, isolcpus has been marked as deprecated, and it can't be adjust
runtime.

isolcpus=	[KNL,SMP,ISOL] Isolate a given set of CPUs from disturbance.
			[Deprecated - use cpusets instead]



Thanks, 
Ming


