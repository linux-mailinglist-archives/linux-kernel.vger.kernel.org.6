Return-Path: <linux-kernel+bounces-187773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C668CD818
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4C9281658
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1750D171A5;
	Thu, 23 May 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0qas++7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83578171A1
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480487; cv=none; b=HuFUhA137/1NcQmEuitRr98Y45yYsDy9NB5mdHpDKROyP29uGjiSJZfL9FQ2fa3L6K7hz+F89Nu2wZ9XmGUlHLzyNg5XWsnsZMirQLtY8STh+FiEPjSRi4IeSXGkI/6z5zu+PUh/QuarkWpdLObNbDCu7xGMTas9NulZya1Kszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480487; c=relaxed/simple;
	bh=2wSsrqg2JJqfyPOD45/x7ExHNa182nGkL5a4mKJU7HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMuBB01zHgvH7xqndUcXwt3nkQqw1MC8iwfgExlFPpiut1+DUCfNgajBci2sKaM5THmxVnx20W1H56icaC/eZ347AYn6+QdbEl3mnh6/nAz0XEQL9gGUnGs4c++AZv46CtMj+2BqIpUcDl1cv/CfVlYeTG50tJAjz1lpjHyqi7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0qas++7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716480484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyOyMy//HFcxns0f7jijZb/TUu6PDOes3felM7DzeZM=;
	b=E0qas++7Won7kixP/atlX+HXTHlAYAjP93TdsH3+48PTGaFjrKuiPVzN573/GxqfKFqjT4
	Y4G0UO30QkKqPsMCtlX1Ml17M1RApxX3xDPM/GDPf8bLAXQuYkMJS+deLrymyyYsDr6mRv
	S50yMrhMj9N5RROL2t+7jfg9CchgOAo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-D2cjl7g-NJm4Mvu64GOBsw-1; Thu, 23 May 2024 12:07:59 -0400
X-MC-Unique: D2cjl7g-NJm4Mvu64GOBsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3864C800CA5;
	Thu, 23 May 2024 16:07:59 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E3D811054820;
	Thu, 23 May 2024 16:07:58 +0000 (UTC)
Message-ID: <f1f52715-78b3-42e1-bc25-9984dd178321@redhat.com>
Date: Thu, 23 May 2024 12:07:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, emilne@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <20240523081443.GD1086@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240523081443.GD1086@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 5/23/24 04:14, Christoph Hellwig wrote:
> Oh, and there is really something of with the patch format.
> 
> First the subject line is completely wrong, this should be:
> 
> nvme-multipath: implement "queue-depth" iopolicy.

Will fix.

> On Wed, May 22, 2024 at 12:54:06PM -0400, John Meneghini wrote:
>> From: "Ewan D. Milne" <emilne@redhat.com>
> 
>> Signed-off-by: Thomas Song <tsong@purestorage.com>
>> [emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>>        and compilation warnings, updated MODULE_PARM description, and
>>        fixed potential issue with ->current_path[] being used]
>> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> 
> Second the patch author needs to be the first signoff.  I'm not entirely
> sure who is supposed to be the author, but either it should be Thomas,
> or if the patch has changed so much that it's someone else the original
> signoff should turn into a Co-Developed-by.

This patch was originally authored by Thomas Song, an intern who worked at Purestorage. The original patch was almost a year 
ago. Thomas no longer works for Purestorage, and he is no where to be found. Ewan and I have both made many changes since then, 
but the basic concept, which adds a controller scoped atomic counter in nvme_find_path(), remains the same. Ewan worked on the 
patch for several months, trying different counter implementations, all in an effort to avoid the atomic counter.  However, 
nothing else worked and in the end this patch retains the essential features of Thomas Songs original patch.

I'd like Thomas to get credit for this patch, so I've changed the author from Ewan Milne to Thomas Song.

As for the Co-Developed-By: checkpatch.pl is insisting that that each "Co-developed-by:" be followed by a signoff.

   jmeneghi:linux > scripts/checkpatch.pl --git HEAD
   WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
   #26:
   Co-developed-by: Ewan D. Milne <emilne@redhat.com>
   [jmeneghi: vairious changes and improvements, addressed review comments]

   WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
   #28:
   Co-developed-by: John Meneghini <jmeneghi@redhat.com>
   Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/

   total: 0 errors, 2 warnings, 197 lines checked


So this is what I currently have for a message log.

Author: Thomas Song <tsong@purestorage.com>
Date:   Tue Nov 7 16:23:29 2023 -0500

     nvme-multipath: implemented new iopolicy "queue-depth"

     The round-robin path selector is inefficient in cases where there is a
     difference in latency between paths.  In the presence of one or more
     high latency paths the round-robin selector continues to use the high
     latency path equally. This results in a bias towards the highest latency
     path and can cause a significant decrease in overall performance as IOs
     pile on the highest latency path. This problem is acute with NVMe-oF
     controllers.

     The queue-depth policy instead sends I/O requests down the path with the
     least amount of requests in its request queue. Paths with lower latency
     will clear requests more quickly and have less requests in their queues
     compared to higher latency paths. The goal of this path selector is to
     make more use of lower latency paths which will bring down overall IO
     latency and increase throughput and performance.

     Signed-off-by: Thomas Song <tsong@purestorage.com>
     [emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
           and compilation warnings, updated MODULE_PARM description, and
           fixed potential issue with ->current_path[] being used]
     Co-developed-by: Ewan D. Milne <emilne@redhat.com>
     Signed-off-by: Ewan D. Milne <emilne@redhat.com>
     [jmeneghi: vairious changes and improvements, addressed review comments]
     Co-developed-by: John Meneghini <jmeneghi@redhat.com>
     Signed-off-by: John Meneghini <jmeneghi@redhat.com>
     Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
     Tested-by: Marco Patalano <mpatalan@redhat.com>
     Reviewed-by: Randy Jennings <randyj@purestorage.com>
     Tested-by: Jyoti Rani <jrani@purestorage.com>


