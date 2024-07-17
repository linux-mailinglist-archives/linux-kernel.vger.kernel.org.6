Return-Path: <linux-kernel+bounces-255552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEBD93422A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2C1283FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1D2183083;
	Wed, 17 Jul 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2SvuwMT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467CF12E75
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240335; cv=none; b=lzFVAm0nPLVppl2QCIbb33jQK7LdKl9L/h8ik/dk073PESTcr6m+obiPD/izaZfG0UM0DCj6rI9XHFSfFtcv7LIIccKg9Aadr8pSICX6mqYjUBgX0UBE6GWNKGLHPV9xjQQCGZDO51ji+4GiLH0vtE/7KWJGwUJJx/XC48yZyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240335; c=relaxed/simple;
	bh=XMcmwqQeqJJpmKPK58D7Uzbt7GSUvI4exaVwLSATFKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZpOk8QZMBKxKWzssnbJ2Smb5IZLKOqSbeJjTYjmTOJVAwtWTAfybmJzOTj8sw3guN/R5glw9wONkREYSBltvDgdrayvTu0lK0SdySmvfh6ZtDSxh0IDFMUTBR+uXzEHHT1gN6MmSsV4jewbiT79jFDsOEtjQN+JMs3YOuX4cTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2SvuwMT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721240333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJ+DO1XFPA3kG5fZOCBOo8jUV2iAAVsZ3cSbK5/oCdI=;
	b=X2SvuwMTKFIM8ucH/YiT8wp5yKh2JgFXaUjapnw0tRAtDbgr3Ro8GEFru+KWUT0T3yATCI
	uhSLccxEKJ39bOlR4MLq13NA+y7bUFOxvyyGCTohatWkx19K4Vv+3MnOFI+xYOn0Ak2zgU
	ykNAEOJd36vNuJgQMHvJclgrmeypdGc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-Z9YBNzkfPSCEdpDdbWu1QA-1; Wed,
 17 Jul 2024 14:18:46 -0400
X-MC-Unique: Z9YBNzkfPSCEdpDdbWu1QA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2C871955D50;
	Wed, 17 Jul 2024 18:18:43 +0000 (UTC)
Received: from [10.22.16.209] (unknown [10.22.16.209])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBECE1955D47;
	Wed, 17 Jul 2024 18:18:40 +0000 (UTC)
Message-ID: <134fc34c-10b8-4d00-aaca-8285efce9899@redhat.com>
Date: Wed, 17 Jul 2024 14:18:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat
 update
To: "tj@kernel.org" <tj@kernel.org>
Cc: =?UTF-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>,
 "boris@bur.io" <boris@bur.io>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 =?UTF-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?= <Iverlin.Wang@mediatek.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
 <Zpbify32lel9J-5I@slm.duckdns.org>
 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
 <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
 <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>
 <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
 <f448f66b-7a91-4281-8f77-159541cbacff@redhat.com>
 <ZpgB9kCAxAAXAtSi@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZpgB9kCAxAAXAtSi@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 7/17/24 13:40, tj@kernel.org wrote:
> Hello, Waiman.
>
> On Wed, Jul 17, 2024 at 01:37:56PM -0400, Waiman Long wrote:
>> bis->sync is still being used in blk_cgroup_bio_start(). Replacing it with a
>> global lock may kill performance. We may have to use a per-cpu lock if we
>> want to go this route of eliminating bis->sync.
> So, the idea is to keep using u64_sync for blkg->iostat_cpu and use
> blkg_stat_lock for blkg->iostat. The former is the only one which is updated
> in hot path, right?

Well, it can be confusing whether we are dealing with blkg->iostat or 
blkg->iostat_cpu. In many cases, we are dealing with iostat_cpu instead 
of iostat like __blkcg_rstat_flush() and blkg_clear_stat(). So we can't 
eliminate the use of u64_stats_update_begin_irqsave() in those cases.

Cheers,
Longman


