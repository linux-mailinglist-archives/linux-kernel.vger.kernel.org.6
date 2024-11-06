Return-Path: <linux-kernel+bounces-398775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FAC9BF5E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948D91C20E57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E103220ADFB;
	Wed,  6 Nov 2024 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwC7plbh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62C209F20
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919561; cv=none; b=lDbUyv1GYMOiuqovgDVRPU2lQSL5mxnXAZF4ulw7kLgV1MjTap2aKUhRVmcjNGUIWYIcjojRwSjC/KpgBpodXkrdCkUnAZiAkfKb0jlPCspzG+MX5k987T5e7YU8owGuIpfqOzYeKO8czDDvbN8kPkIGCKroKPnTWwAn3suy9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919561; c=relaxed/simple;
	bh=CPTlwe4grbdyPIOrfvUXMEfBRZ6IkY8r9X/KnDxuWHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udmnBdjf+0CF2zxEUww246DyZESoiAU9jOu6WC30/dYN3gOb6y49Kk1M7E4bS3ICA3V6/Mbykk3vs7PxVl404cpfPlRpLPkXupgKWVsPAl5PsrUYWks7uhVhsPAytTycAphOuBB+pt0g4t/JstF2dBKH+ldVGiXsJeJ6ZR/sChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwC7plbh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730919558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKSTA1wlPf7ylAPAEuFscDQ41z0q8//fTZB4PW5qnTQ=;
	b=gwC7plbh1sSmYsUJHflKTKpNGwl4EtMnayV9YmbIZniRC3n+EHoz8BkkoSDiqhxvp0ss//
	7epJhXaHCx5OnHGmzwgZ40kDJqd0PWD38YsJYVjsvBZB+M/TGXIMCeiWSJmMXwc0bcg78x
	2t4Ai+RUV3L7lskeEFBflXc7NWr5LXQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-CiTsiHVqPhSfC9X3prgwwQ-1; Wed, 06 Nov 2024 13:59:17 -0500
X-MC-Unique: CiTsiHVqPhSfC9X3prgwwQ-1
X-Mimecast-MFC-AGG-ID: CiTsiHVqPhSfC9X3prgwwQ
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aa904b231so15129039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919556; x=1731524356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKSTA1wlPf7ylAPAEuFscDQ41z0q8//fTZB4PW5qnTQ=;
        b=Z4MlZFGUVOkP2DHj9G/ry61Ruax4CXolvwYgCYDFH3814IDod4ou6oqXdPrNBE2VoB
         XOu5SfObtwv7kfU0DKmGZS75PETEyIX95HURvBj3gXD3UJn4lyH1BC0qudpwZlx+An8N
         ysGF0Mf+yN/xBGooeAu4C7xiDX8cWfQUrTWFOVzcH0EzpT8tSGFw3k6EOAz/A6IFqQBz
         CGYnYT/jZXVUFwWU28vOr17mpmcJJXTSHj+c14ngFwfx5G0qt4QEu8It17iALs1S4kiC
         m1CJ9Ro2PqKedv1bQXPOhiRFfqkp9qQIetRYMdkR4Rb87YDDUWwUu4aZXU8tSs19Keyh
         kVeA==
X-Forwarded-Encrypted: i=1; AJvYcCWwnx6vC6fWiuTBSxWJIeVs7ZeKWFogt95kfxELlYzxfZJ5DPtAekxa0NUpC4VEjocezCN0Qej66uiTf4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjflDKGjqmI4UGRaluEw4KASge8aSGfbbOa5LkYrkuHmtNeHwP
	jl0VU3Jigq5x93KCej2WaWUJloCohpUua3DC/ah22NDBlvQtEbdvCYam6au4tpPZwg1gOH1tdfa
	JvQ2SfdjxZXHC8knj7x2T0b58TSxW/z0G8m00Bg3RQCjOJL9EdSXCEZHWGbDoAVvJJ4blaZ0m
X-Received: by 2002:a05:6602:1589:b0:83a:a8c6:21ad with SMTP id ca18e2360f4ac-83b64fc3438mr2044469939f.7.1730919556590;
        Wed, 06 Nov 2024 10:59:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5fu+BQk98rvYiawDn7mLMHhKgFT39Cp/7oyDEILxh0dPNKOUBpYjLOIhed6eg2JByxajWpA==
X-Received: by 2002:a05:6602:1589:b0:83a:a8c6:21ad with SMTP id ca18e2360f4ac-83b64fc3438mr2044468639f.7.1730919556276;
        Wed, 06 Nov 2024 10:59:16 -0800 (PST)
Received: from [10.0.0.71] ([65.128.110.20])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67ba907esm328037439f.25.2024.11.06.10.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 10:59:15 -0800 (PST)
Message-ID: <9fa5857d-4d3f-4406-8241-20905bcfcc7f@redhat.com>
Date: Wed, 6 Nov 2024 12:59:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] isofs: avoid memory leak in iocharset
To: Hao Ge <hao.ge@linux.dev>, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20241106082841.51773-1-hao.ge@linux.dev>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20241106082841.51773-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 2:28 AM, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>

...

> The opt->iocharset is freed inside the isofs_fill_super function,
> But there may be situations where it's not possible to
> enter this function.
> 
> For example, in the get_tree_bdev_flags function,when
> encountering the situation where "Can't mount, would change RO state,"
> In such a case, isofs_fill_super will not have the opportunity
> to be called,which means that opt->iocharset will not have the chance
> to be freed,ultimately leading to a memory leak.
> 
> Let's move the memory freeing of opt->iocharset into
> isofs_free_fc function.
> 
> Fixes: 1b17a46c9243 ("isofs: convert isofs to use the new mount API")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Agreed, thank you.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>



