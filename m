Return-Path: <linux-kernel+bounces-227720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49E9155D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BD2B22C87
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519501A00EF;
	Mon, 24 Jun 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya+BIR/a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D382718039
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251434; cv=none; b=tlPe2fOkTu1x7dPMA78sZI5op9/E+2pUScifNyakTACwdKf6Hr8Y5XDfYDyqBWuBJjnMsXImG+i4EUNdYkoeZ2o4KcPe0lsTitasaH/F0erDhjZVRVPhPCBD7UaxrrTz+SQkuS4jO3/jEdXB5Ti70beJ57FujM+36rEgOYaqKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251434; c=relaxed/simple;
	bh=gZftF0+OJJJzKq1B6PLPz5N5tPdGv2hOweR6F6bZ0ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJo1uTw/C44XXB0rCnHNWo2rI4XyQjR+6PcSjTzJ5lkEy2JX/BHspU2JKSlEI0Vgp4eUQi8XzfaIjXQ/MkzbCCkCHx77gsSd872Z/BlxtPkuJfbbXrLhjDALJVYGmtCM1TJWbPWqRlEkSjQ3C2l492LkdGtr5gDIXB4SEq3YXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya+BIR/a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719251431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOiS5FoPxiz3yCGlJ3uxJuLKtY3Ob/DdJ4UYYfEkG50=;
	b=Ya+BIR/aDfNBpf5eIi9oV/mXV17y8LLuN2hwmjNSGoZmbUU49X4py/e0ee1SATd2E0dAP9
	z0Xowc0yK0TUqI0dGmgvcEy1SKUxIkG3M8fSuRQc/PZ3XA5k+ifeAnQqimMpMUfeXf8amN
	Vin1uI8E47+baWbJ4s7m5ENdOdtxaSQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-jrghYZZyO1q-m9qtYVT7ww-1; Mon,
 24 Jun 2024 13:50:27 -0400
X-MC-Unique: jrghYZZyO1q-m9qtYVT7ww-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBF52195608B;
	Mon, 24 Jun 2024 17:50:24 +0000 (UTC)
Received: from [10.22.34.111] (unknown [10.22.34.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73E4F1956087;
	Mon, 24 Jun 2024 17:50:22 +0000 (UTC)
Message-ID: <59921b0a-1e16-4f39-bdda-9e11ba2edbbd@redhat.com>
Date: Mon, 24 Jun 2024 13:50:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, emilne@redhat.com, jrani@purestorage.com,
 randyj@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org
References: <20240619163503.500844-1-jmeneghi@redhat.com>
 <20240619163503.500844-2-jmeneghi@redhat.com> <20240620065641.GA22113@lst.de>
 <d4ae4b0a-b3a4-40db-87e3-c9a493408172@redhat.com>
 <20240624084627.GA20032@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240624084627.GA20032@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 6/24/24 04:46, Christoph Hellwig wrote:
> On Thu, Jun 20, 2024 at 01:54:29PM -0400, John Meneghini wrote:
>> How about:
>>
>> pr_notice("Changed iopolicy from %s to %s for subsysnqn %s\n",
>>                  nvme_iopolicy_names[old_iopolicy],
>>                  nvme_iopolicy_names[iopolicy],
>>                  subsys->subnqn);
> 
> Having the identification as the prefixe seems easier to parse
> and grep for.

To be clear Christoph, your saying you'd like the NQN in the prefix of the dmesg?

E.g.:

root> echo "round-robin" > /sys/class/nvme-subsystem/nvme-subsys11/iopolicy
[Thu Jun 24 11:44:20 2024] subsysnqn nqn.1992-08.com.netapp:sn.2b82d9b13bb211ee8744d039ea989119:subsystem.SS104a iopolicy 
changed from queue-depth to round-robin.

Correct?

/John


