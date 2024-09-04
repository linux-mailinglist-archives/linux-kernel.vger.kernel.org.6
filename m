Return-Path: <linux-kernel+bounces-314470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348A596B3C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BDE2890F5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A7217C985;
	Wed,  4 Sep 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlXdQOeh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D021474A2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436915; cv=none; b=nEo0INLzNBv2U6Iemc93CibLeZcdIZcRZlrEfV4wmhNEvSf3QKHS/Pl446mNPYchdHA600u8Q1VxCIquGs6aas2OC/YMywfj1LXi1gQYJk7XMSw4zsX3sbeJ27BCONBjssJxFs/Ye4oRg8W+rr7IW5I7AZb0LYMQSdFFEyjEj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436915; c=relaxed/simple;
	bh=uqOMba/The6pJSKp+CbA/Iwap7Vm6sY76UDDUe8L3Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUh8qJTJVLK9v/Un1cwfylSjBimbCy24sDQnWDgrWq0a3BqkRIjLBHi+hiJLJR3hlE0LIvwosxN70ThUd0w1B8h1DsMi5NHLK/yrDVlHGno4+gBPkY40YkF1dEnvV4ZCQ2L0XqcoiKFn5GHpifJWU/6V4I75Y8tLeU5cfccKqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlXdQOeh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725436913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1hrffS5UHJg7kzezTrDoIdBib7K1M8RXAnPgDpUGMI=;
	b=VlXdQOeh7PphWCh3m3jB3gPFOZQglruKI9ynewIAkf7caOpuDdrNy2/8PLus/9H1v/ZB/y
	luY+QVfZhTHjgWlJDaEd12i6df0VPZKP1IR5M9sPXQVn/F82tmPdopc2cF7mWgIwi9960D
	RmbNMunn4wKGZsENFAeAxX6Q18qMKqw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-Omr3cNLRMdagnJLOcCK1Dw-1; Wed,
 04 Sep 2024 04:01:48 -0400
X-MC-Unique: Omr3cNLRMdagnJLOcCK1Dw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD8F01956089;
	Wed,  4 Sep 2024 08:01:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2A283000239;
	Wed,  4 Sep 2024 08:01:42 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:01:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: ZhangHui <zhanghui31@xiaomi.com>
Cc: axboe@kernel.dk, bvanassche@acm.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v3] block: move non sync requests complete flow to softirq
Message-ID: <ZtgT4HhEsyRJMoQH@fedora>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903115437.42307-1-zhanghui31@xiaomi.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 03, 2024 at 07:54:37PM +0800, ZhangHui wrote:
> From: zhanghui <zhanghui31@xiaomi.com>
> 
> Currently, for a controller that supports multiple queues, like UFS4.0,
> the mq_ops->complete is executed in the interrupt top-half. Therefore, 
> the file system's end io is executed during the request completion process,
> such as f2fs_write_end_io on smartphone.
> 
> However, we found that the execution time of the file system end io
> is strongly related to the size of the bio and the processing speed
> of the CPU. Because the file system's end io will traverse every page
> in bio, this is a very time-consuming operation.
> 
> We measured that the 80M bio write operation on the little CPU will

What is 80M bio?

It is one known issue that soft lockup may be triggered in case of N:M
blk-mq mapping, but not sure if that is the case.

What is nr_hw_queues(blk_mq) and nr_cpus in your system?

> cause the execution time of the top-half to be greater than 100ms.
> The CPU tick on a smartphone is only 4ms, which will undoubtedly affect
> scheduling efficiency.

schedule is off too in softirq(bottom-half).

> 
> Let's fixed this issue by moved non sync request completion flow to
> softirq, and keep the sync request completion in the top-half.

If you do care interrupt-off or schedule-off latency, you may have to move
the IO handling into thread context in the driver.

BTW, threaded irq can't help you too.


Thanks, 
Ming


