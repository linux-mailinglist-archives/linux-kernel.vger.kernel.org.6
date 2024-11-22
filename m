Return-Path: <linux-kernel+bounces-418626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6A39D6395
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B670B2292D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E6A16E88D;
	Fri, 22 Nov 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auVtE4b1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC2175A5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297984; cv=none; b=UR270/RGq2fIoTI+J7TzszNgMlIlIBrPfrj6K/0JEGLMmJHYcTusWvZizi0fMrRMqCDj0FadZ2/39GgBdv9nUWCgjS8B7u0gyxNKB6c7hBbIg+tyU8sI1FpXdEYt8Psal9TGKXC2HDdHjvVetVyjghamDQemQuU6n8FX04gVv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297984; c=relaxed/simple;
	bh=wsTkX6pJNyPokLpxfhwCoXSmd2PpmgMvlsBk/iZ2Z8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRgEA0NGPLc8fHdvhASFEnGdH1CzlsSl+mHlPwxwBn2vccwH0cg2anSRgwOygVZFt5F9CWIneVl2rFdGv/htUKJLI5GvwT4pZcc/K1+0KHAcMZXQv+9OhqUxt3XuoDWNPxJ//zhdYqPhMstk+d62ZQ7T89+NmAziKOWogs4Om5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=auVtE4b1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732297981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RstFT4v1FTwGEZ6DtgUQEagwPEudbwO0pMDPcVbX3L4=;
	b=auVtE4b10Y/gVx0PXAh5pawjYWaQqBltmEhZF1MXeA9dSog3mZhrLK6F0j4QqlQQNackr8
	Gc8pKB4z+6/YMXJ3NHqhXXPLymj55AbgeRoWBtpsJykRow5hIM7OQ/RVdwJgS/cUXtT/DJ
	QZPkaF49V7geRHBqSsdCQaoaCeoGPjM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-RztWJB03Ok2WATAY3rE3eQ-1; Fri,
 22 Nov 2024 12:52:58 -0500
X-MC-Unique: RztWJB03Ok2WATAY3rE3eQ-1
X-Mimecast-MFC-AGG-ID: RztWJB03Ok2WATAY3rE3eQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3596019560AF;
	Fri, 22 Nov 2024 17:52:55 +0000 (UTC)
Received: from [10.22.81.129] (unknown [10.22.81.129])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1195119560A3;
	Fri, 22 Nov 2024 17:52:51 +0000 (UTC)
Message-ID: <4bd8f843-6dfa-4c66-9e42-cf4245166844@redhat.com>
Date: Fri, 22 Nov 2024 12:52:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: always enable multipath
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
 mpe@ellerman.id.au, naveen@kernel.org, maddy@linux.ibm.com,
 kernel@xen0n.name, bmarzins@redhat.com
References: <20241121220321.40616-1-bgurney@redhat.com>
 <20241122120925.GA25817@lst.de>
 <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Z0ClxgBJG_YBF-Ql@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/22/24 10:39, Keith Busch wrote:
> Anyway, we only use the one physical function, so they're certainly not
> multipath devices here. We disable the CONFIG option because while the
> nvme multipath IO overhead is low, it's not zero.

Do we know what the performance impact is?  Has anybody measured the difference?

/John


