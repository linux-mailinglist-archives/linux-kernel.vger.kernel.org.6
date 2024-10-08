Return-Path: <linux-kernel+bounces-354490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B9C993E35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2316E1C23E35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A09613AA2A;
	Tue,  8 Oct 2024 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHzY7ajq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E013959D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364316; cv=none; b=Ukd1Yv2B2UDutTtSiAJ6S1beOCGVonXAfvVvuUjBjHysujobrb9U9uIynrWkE4MgPU7UB5h6RFO5RKkJhHRgmwTse2dtcf9zucsZyk+Be4JSLsctqCX4zFSAyI9LvYGLP4ikFbzITqbtjKQnV2PtA5vTiLbL53glr7ODAUun1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364316; c=relaxed/simple;
	bh=SLh25qXOWVmw4SCKmmsEBzMRI0rs9M22+5MD2EXMFRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jb/YsvDexHEurCVizFIMJ0gBVpbeA/zMBiMpUSTnvr9HrWoQyRRyeuMwjtZ5+TPPVYeF4ZIP9lUB+lgdWAxnRs+1Mqxk1Zh08IGsrAZ4itpE3mK94RChGwleboJx6ath3QcKVW3wQmP1FM0PBYMpLL5AF2VMORPwzAXdy4tBhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHzY7ajq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728364313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tic6eRj2qzs0tb10TUTBxQR/oXtJbgGmgQXaAU//xHA=;
	b=HHzY7ajqd1HaV7hQwKuu/l9GH4hHE3igb3GefV9FjeNHI+m8Jxn+5WaOlAxBoO9erUVsQv
	KWo8edv8QKgdxSe4K9dOESC2N38FJpIql9xTSP8aW6BGOTaJUFJv8c4E8tcMVgk024+Gfb
	1EvadcMck+3kJEmqsNUhvqHhRJoM6qs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-IC5izF0iOJeWtF3i8dXzbQ-1; Tue, 08 Oct 2024 01:11:52 -0400
X-MC-Unique: IC5izF0iOJeWtF3i8dXzbQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20b4861f942so53812615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 22:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728364312; x=1728969112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tic6eRj2qzs0tb10TUTBxQR/oXtJbgGmgQXaAU//xHA=;
        b=tLC5WJwQV7lyYuixMY0C+fyCw4P8ULwX7uVOIakrb/3iRE1rKnjn+9WYdO5AtiveuL
         /bi3w6/Tvm0/Tb+pd3WUnoeEd/d3IxSWQT17BVNTss8wCG7HAMS2gb7nt+KqS5rm5sPG
         VVxlpIamge46nm/OfpWsnl7dH77I6fkevjRqm314b4fjKoVnUTxfzA7oMf3pNRUtznMi
         +jUOKAx+G5QjZvWZru1DibvNQfee6ggwYZ/0y1FZSj7ZzI6VK+YAdXQb8vqN5U7fKsZY
         FgkXtGbovjIuQ1gz2Q/31bkNqjgCOdfAB52tzQn6HfrQYyjTU0mca7gmxv+RJCbvPHv1
         A4SA==
X-Forwarded-Encrypted: i=1; AJvYcCVLDupk/6b1g7RqnTdLxj5OE13IASrrdxROckDpcZzyDZYM7tv7CVgiFjyu0Ug3KbMo+ghL7qaYUdu/zFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcEOoEWVR00aPv1zUbalNIbyxUDwuptV8QCCSWHfq0UFosfka
	nSmqZ9TxWn9KWn1/A3ia7GV2Hc5FH58G1sTI5VCmCm5aZlcMkE1BqRc9ZKSyGM4zCSR7OnxiRgc
	YcBf5acOu4hLerPW9VllC/b3aPmqN4KWmDbAVGGvMxGtCsJFHQT1B9CC89ttgNg==
X-Received: by 2002:a17:902:ecc6:b0:20b:7250:e744 with SMTP id d9443c01a7336-20bff224cc5mr153889815ad.56.1728364310155;
        Mon, 07 Oct 2024 22:11:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0Uxz8LXRrdNf1WhECQYg5MY0qjfcxniTa+aF4mi4a2jy2Z32EREelBAIdcmIUg3bfv1+WZg==
X-Received: by 2002:a17:902:ecc6:b0:20b:7250:e744 with SMTP id d9443c01a7336-20bff224cc5mr153889655ad.56.1728364309790;
        Mon, 07 Oct 2024 22:11:49 -0700 (PDT)
Received: from [10.72.116.34] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138d0cd9sm48174755ad.107.2024.10.07.22.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 22:11:49 -0700 (PDT)
Message-ID: <b21e1214-20e5-4dc8-846d-d3a14d66fc1a@redhat.com>
Date: Tue, 8 Oct 2024 13:11:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ceph: fix cap ref leak via netfs init_request
To: Patrick Donnelly <batrick@batbytes.com>, Ilya Dryomov
 <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 David Howells <dhowells@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, stable@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241003010512.58559-1-batrick@batbytes.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20241003010512.58559-1-batrick@batbytes.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/3/24 09:05, Patrick Donnelly wrote:
> From: Patrick Donnelly <pdonnell@redhat.com>
>
> Log recovered from a user's cluster:
>
>      <7>[ 5413.970692] ceph:  get_cap_refs 00000000958c114b ret 1 got Fr
>      <7>[ 5413.970695] ceph:  start_read 00000000958c114b, no cache cap
>      ...
>      <7>[ 5473.934609] ceph:   my wanted = Fr, used = Fr, dirty -
>      <7>[ 5473.934616] ceph:  revocation: pAsLsXsFr -> pAsLsXs (revoking Fr)
>      <7>[ 5473.934632] ceph:  __ceph_caps_issued 00000000958c114b cap 00000000f7784259 issued pAsLsXs
>      <7>[ 5473.934638] ceph:  check_caps 10000000e68.fffffffffffffffe file_want - used Fr dirty - flushing - issued pAsLsXs revoking Fr retain pAsLsXsFsr  AUTHONLY NOINVAL FLUSH_FORCE
>
> The MDS subsequently complains that the kernel client is late releasing caps.
>
> Approximately, a series of changes to this code by the three commits cited
> below resulted in subtle resource cleanup to be missed. The main culprit is the
> change in error handling in 2d31604 which meant that a failure in init_request
> would no longer cause cleanup to be called. That would prevent the
> ceph_put_cap_refs which would cleanup the leaked cap ref.
>
> Closes: https://tracker.ceph.com/issues/67008
> Fixes: 49870056005ca9387e5ee31451991491f99cc45f ("ceph: convert ceph_readpages to ceph_readahead")
> Fixes: 2de160417315b8d64455fe03e9bb7d3308ac3281 ("netfs: Change ->init_request() to return an error code")
> Fixes: a5c9dc4451394b2854493944dcc0ff71af9705a3 ("ceph: Make ceph_init_request() check caps on readahead")
> Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>   fs/ceph/addr.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 53fef258c2bc..702c6a730b70 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -489,8 +489,11 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
>   	rreq->io_streams[0].sreq_max_len = fsc->mount_options->rsize;
>   
>   out:
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (got)
> +			ceph_put_cap_refs(ceph_inode(inode), got);
>   		kfree(priv);
> +	}
>   
>   	return ret;
>   }
>
> base-commit: e32cde8d2bd7d251a8f9b434143977ddf13dcec6

Good catch!

Reviewed-by: Xiubo Li <xiubli@redhat.com>


