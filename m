Return-Path: <linux-kernel+bounces-238580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DA924C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C79B2177B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA817A5B4;
	Tue,  2 Jul 2024 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgeKNCNJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DA1DA312
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963948; cv=none; b=GqCOy/uE8uWW6GwXf97e9wjY8DYTIo87qHp1FiEU7+dfLpQRmq4zYeVMPwdxJeic+GNQkrYPQwj8IHNUiaMkqmAY4jn/RdpdstCtOrQmdPIQASRto30fTLDUdSQ7IZs6BuNOGhdAgQ6cyfeZCH1XTqURT+80jJxNBP007KCpGZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963948; c=relaxed/simple;
	bh=ngbXr5S4NO+359k3fdchEPv1amLfBhw6o2USdVHy0O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jg09l4CKoGvDNTSJHrFcKkn6cQlcCbcA50yrRm7+7lFlRb9jgjrwRvfyiUfu6H8JBkg4Arhxt9VLRojW62reSQMn0U2a9C7BfyxlDlLqmhuk1OKszi+fdvZiKxGWDZqt+i3kpMRQoGaavhCiYTA8lDNNfJo4/hdQ4iV5tVvg4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgeKNCNJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719963945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOfOaTN8FR3CJJcu2Y1S4txQuiktnHa6A2KoG2WP+sU=;
	b=fgeKNCNJ3eGVE3UX+Oo7Rl8EdSjifaRh03Nnm9bg/juEsXocFwS4MMjhmQQyTi0QJBVN8K
	n5mDwhX87mDgfWledqVdxwCeJyCpia1yOP+iDUWhoZZFmOyRUcLHd1sLLCzPJU8o/HBRdx
	0gPjostfonXdGIYaHx3u6/4kBdj5NWg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-r87MrYAWOD605KVXsyp2KQ-1; Tue,
 02 Jul 2024 19:45:42 -0400
X-MC-Unique: r87MrYAWOD605KVXsyp2KQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A02D1956089;
	Tue,  2 Jul 2024 23:45:41 +0000 (UTC)
Received: from [10.22.9.99] (unknown [10.22.9.99])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7705019560AD;
	Tue,  2 Jul 2024 23:45:39 +0000 (UTC)
Message-ID: <3b4c72ff-7894-4772-a918-7e20d00fac1b@redhat.com>
Date: Tue, 2 Jul 2024 19:45:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Prevent derefencing NULL ptr in pfn_section_valid()
To: Charan Teja Kalla <quic_charante@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240626001639.1350646-1-longman@redhat.com>
 <bf0d9278-2b57-079e-cca5-21163e187ea3@quicinc.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <bf0d9278-2b57-079e-cca5-21163e187ea3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 7/1/24 09:50, Charan Teja Kalla wrote:
> Hi Waiman,
>
> On 6/26/2024 5:46 AM, Waiman Long wrote:
>> Commit 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
>> memory_section->usage") changed pfn_section_valid() to add a READ_ONCE()
>> call around "ms->usage" to fix a race with section_deactivate() where
>> ms->usage can be cleared.  The READ_ONCE() call, by itself, is not enough
>> to prevent NULL pointer dereference.  We need to check its value before
>> dereferencing it.
> I am unable to see a scenario where ms->usage will be NULL when
> pfn_section_valid() is called:
>
> 1) In pfn_valid, valid_section() check ensures that pfn_section_valid()
> is not called as the section is marked as invalid.
>
> 2) In pfn_to_online_page, online_section() check ensures that
> pfn_section_valid() is not called.
>
> and in the update path, we do:
>       kfree_rcu(ms->usage, rcu);
>       WRITE_ONCE(ms->usage, NULL);
>
> Could you help me in understanding about what I am missing here, please?
>
With the below timing sequence:

      CPU 0                                      CPU 1
      -----                                      -----
                                         if (!valid_section(ms))
                                             return 0;
  ms->section_mem_map &=
     ~SECTION_HAS_MEM_MAP                <interrupt>

  WRITE_ONCE(ms->usage, NULL);
                                         READ_ONCE(ms->usage)->subsection_map


In the time gap between valid_section() check and accessing ms->usage,
it may have been cleared leading to dereferencing a NULL pointer. That is
why it will be prudent to do a NULL check first.

Regards,
Longman


