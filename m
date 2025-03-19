Return-Path: <linux-kernel+bounces-568938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02375A69C47
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A663A9CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2121B18C;
	Wed, 19 Mar 2025 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V80i1v5d"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4761E521A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424444; cv=none; b=Xax9LlSCGBR2KJK8/pSrcGQDxkzekZGqKoHXryg4Y4cV0gv7iuAVaUOcEq7pOQwgFBMzROPtvYsI3iRYbwdzOr2pOT/XLq21bX6KS+K8677PKPUtV4e9kmg7jkdWLxchR29Eatg8Quso3JrS2fHQjPeCO4rN3F5QCOb+KNzAOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424444; c=relaxed/simple;
	bh=//qXs8GC588aDgay/aM/ivBb1fdOOE9Afl770RzDZZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+JX1xWbeKqaDhfmgGrOFPgvjjsrSJIeAHoGqNxbRpBWL2OFO1PrUfaSR92mlsO+ETOxRuc7nBa6JaCOzf2evJ810+8+IEFo/N2a5B0abKw/za8GbdaIpd1BwyZ2JqlA2HqOddeOD6zn1gnT+1GtksJTgQiHVmNax0JcyIdFKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V80i1v5d; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3feb0db95e6so87915b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742424442; x=1743029242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvneRCcyEApkyUDFupFju/e7vL9gMt5adMnD3yGBImA=;
        b=V80i1v5dJA5UI2XylBR5SQnCHajAc94qH5RR4azs8jvejbfcFl/K79fUKjaIKac3K5
         RM2vEGZLntU0TVKKapMnsxcUZNDfqF80u9OVpQGYfOHc/Hhvw3boTcYJUMgut2+TacOc
         RA9O8EFdztmrRpMzIDk/QhXpMqOB+CId1bpdEvtCTAH7MC8kk6s3pcrpoGtmIoV/Gd0V
         HfqxUjbTxhmd2HmGT5p3JZoP9MHSuv1wM4oNPgULkbdTTicapntl5aJ+2041MBwW+xDN
         C4cPQzHmJyDDUmiOcr9J40sNheMAJCMNfGJ98+BtT55IQl1hJM/UY5CGX31zA4RilfjR
         daeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424442; x=1743029242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvneRCcyEApkyUDFupFju/e7vL9gMt5adMnD3yGBImA=;
        b=nSd97YgUqN+HPmcpNx49OG9DIRYf961UMfrLJS1pfnVMMbDvHYq6jRn3origUQZJqm
         D+2n3Vil3PBXWYJrV6T1AwmrzF5Cy3HyZJvQ1CI5xJjEQrzUetRHCAsTNfUZXPp/RoBU
         dQ8jF2LhBRxnx5FafTlW+rGwYF1Xg2Q0b972H2ipzXYE3o/P0LlWLYK+u3TjlUeq3bcb
         sT1V5fukQxBhMSayPLZlylUXpqWhQ5Ee8TsbfYafJH4BAEE3+vR1RFBd1unOFW7e9wA9
         r6X98vl+GVHdfT5A1oD9zyeC5C6Vvop+F9ruwh2y2cYldBRnn0JnaevNyvrZFd/GfKMs
         VO4g==
X-Forwarded-Encrypted: i=1; AJvYcCWugk3enLlfoH2FRn2qtSBdSyQPQqjF4+ciLE3ybM4mAZGTlfw18SCe08itcDVc0/R5hkLpe7PlPvI6F1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTg4evodTt86+7o/jq4sxKTMKdhTSkJY/j6jGycohU+pLcQs8
	E9E0cH9KbKncEu3JC45RUN7ebzROXCIMogpjCbFVX+juJK3L2Hv6
X-Gm-Gg: ASbGncuROHWTsMWwGbeYMxIETu12fydBwnXOIa55eDhXyp6feqXqK967lrZ9OflvZ5+
	05RvG0MUO0ty15ce1abipT1nmaXl0kgMrhkfYbTSbBzfzUauGSr64DJmmxxSX5YF+rFslRtOsEC
	JyiNbglkXLd/jqlbrWnrP/7zn6sG+htkZoQvCcHkjTXx4Qybq6YNxR6UbGY5cFmGE0xhjaHZBl9
	nK3fXSTRWkhQaSx1FFqpxfyxw8Kszau6T6y2ff9HQHahYwprG6AswMQaqnva6C/Eg7+54N1BEOE
	H3U60zy5c+4IgNXjERZt/tzz55fUn4E3Tjr/geog2L1jsPG2MFfUAlFdo9OK
X-Google-Smtp-Source: AGHT+IG/enYdDnAVljshROZf5lLoBS7nS1WZ676mWNkuGpQyBGM02m9xUEYixJ8ySTbCtsEDWlwGmw==
X-Received: by 2002:a05:6808:2123:b0:3fb:3059:3789 with SMTP id 5614622812f47-3feb4b8ca75mr724787b6e.32.1742424442207;
        Wed, 19 Mar 2025 15:47:22 -0700 (PDT)
Received: from [10.69.34.111] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd45235f8sm2833602b6e.19.2025.03.19.15.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 15:47:21 -0700 (PDT)
Message-ID: <4937c9f8-fbc7-46d4-a14f-262a0244f1f0@gmail.com>
Date: Wed, 19 Mar 2025 15:47:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/18] nvmet-fcloop: allocate/free fcloop_lsreq
 directly
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/2025 3:40 AM, Daniel Wagner wrote:
> fcloop depends on the host or the target to allocate the fcloop_lsreq
> object. This means that the lifetime of the fcloop_lsreq is tied to
> either the host or the target. Consequently, the host or the target must
> cooperate during shutdown.
> 
> Unfortunately, this approach does not work well when the target forces a
> shutdown, as there are dependencies that are difficult to resolve in a
> clean way.

ok - although I'm guessing you'll trading one set of problems for another.

> 
> The simplest solution is to decouple the lifetime of the fcloop_lsreq
> object by managing them directly within fcloop. Since this is not a
> performance-critical path and only a small number of LS objects are used
> during setup and cleanup, it does not significantly impact performance
> to allocate them during normal operation.

ok

> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 53 +++++++++++++++++++++++++++++---------------
>   1 file changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 06f42da6a0335c53ae319133119d057aab12e07e..537fc6533a4cf5d39855cf850b82af739eeb3056 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -342,6 +342,7 @@ fcloop_rport_lsrqst_work(struct work_struct *work)
>   		 * callee may free memory containing tls_req.
>   		 * do not reference lsreq after this.
>   		 */
> +		kfree(tls_req);
>   
>   		spin_lock(&rport->lock);
>   	}
> @@ -353,10 +354,13 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
>   			struct nvme_fc_remote_port *remoteport,
>   			struct nvmefc_ls_req *lsreq)
>   {
> -	struct fcloop_lsreq *tls_req = lsreq->private;
>   	struct fcloop_rport *rport = remoteport->private;
> +	struct fcloop_lsreq *tls_req;
>   	int ret = 0;
>   
> +	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
> +	if (!tls_req)
> +		return -ENOMEM;
>   	tls_req->lsreq = lsreq;
>   	INIT_LIST_HEAD(&tls_req->ls_list);
>   
> @@ -387,19 +391,23 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
>   	struct nvme_fc_remote_port *remoteport = tport->remoteport;
>   	struct fcloop_rport *rport;
>   
> +
> +	if (!remoteport) {
> +		kfree(tls_req);
> +		return -ECONNREFUSED;
> +	}
> +

don't do this - this is not a path the lldd would generate.

>   	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
>   		((lsreq->rsplen < lsrsp->rsplen) ?
>   				lsreq->rsplen : lsrsp->rsplen));
>   
>   	lsrsp->done(lsrsp);

This done() call should always be made regardless of the remoteport 
presence.

instead, put the check here

         if (!remoteport) {
             kfree(tls_req);
             return 0;
         }

>   
> -	if (remoteport) {
> -		rport = remoteport->private;
> -		spin_lock(&rport->lock);
> -		list_add_tail(&tls_req->ls_list, &rport->ls_list);
> -		spin_unlock(&rport->lock);
> -		queue_work(nvmet_wq, &rport->ls_work);
> -	}
> +	rport = remoteport->private;
> +	spin_lock(&rport->lock);
> +	list_add_tail(&tls_req->ls_list, &rport->ls_list);
> +	spin_unlock(&rport->lock);
> +	queue_work(nvmet_wq, &rport->ls_work);

this is just an indentation style - whichever way works.

>   
>   	return 0;
>   }
> @@ -426,6 +434,7 @@ fcloop_tport_lsrqst_work(struct work_struct *work)
>   		 * callee may free memory containing tls_req.
>   		 * do not reference lsreq after this.
>   		 */
> +		kfree(tls_req);
>   
>   		spin_lock(&tport->lock);
>   	}
> @@ -436,8 +445,8 @@ static int
>   fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
>   			struct nvmefc_ls_req *lsreq)
>   {
> -	struct fcloop_lsreq *tls_req = lsreq->private;
>   	struct fcloop_tport *tport = targetport->private;
> +	struct fcloop_lsreq *tls_req;
>   	int ret = 0;
>   
>   	/*
> @@ -445,6 +454,10 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
>   	 * hosthandle ignored as fcloop currently is
>   	 * 1:1 tgtport vs remoteport
>   	 */
> +
> +	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
> +	if (!tls_req)
> +		return -ENOMEM;
>   	tls_req->lsreq = lsreq;
>   	INIT_LIST_HEAD(&tls_req->ls_list);
>   
> @@ -461,6 +474,9 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
>   	ret = nvme_fc_rcv_ls_req(tport->remoteport, &tls_req->ls_rsp,
>   				 lsreq->rqstaddr, lsreq->rqstlen);
>   
> +	if (ret)
> +		kfree(tls_req);
> +
>   	return ret;
>   }
>   
> @@ -475,18 +491,21 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
>   	struct nvmet_fc_target_port *targetport = rport->targetport;
>   	struct fcloop_tport *tport;
>   
> +	if (!targetport) {
> +		kfree(tls_req);
> +		return -ECONNREFUSED;
> +	}
> +

same here - don't do this - this is not a path the lldd would generate.

>   	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
>   		((lsreq->rsplen < lsrsp->rsplen) ?
>   				lsreq->rsplen : lsrsp->rsplen));
>   	lsrsp->done(lsrsp);
>   

Same for this done().

instead, put the check here

         if (!targetport) {
             kfree(tls_req);
             return 0;
         }

> -	if (targetport) {
> -		tport = targetport->private;
> -		spin_lock(&tport->lock);
> -		list_add_tail(&tport->ls_list, &tls_req->ls_list);
> -		spin_unlock(&tport->lock);
> -		queue_work(nvmet_wq, &tport->ls_work);
> -	}
> +	tport = targetport->private;
> +	spin_lock(&tport->lock);
> +	list_add_tail(&tport->ls_list, &tls_req->ls_list);
> +	spin_unlock(&tport->lock);
> +	queue_work(nvmet_wq, &tport->ls_work);
>   
>   	return 0;
>   }
> @@ -1129,7 +1148,6 @@ static struct nvme_fc_port_template fctemplate = {
>   	/* sizes of additional private data for data structures */
>   	.local_priv_sz		= sizeof(struct fcloop_lport_priv),
>   	.remote_priv_sz		= sizeof(struct fcloop_rport),
> -	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
>   	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
>   };
>   
> @@ -1152,7 +1170,6 @@ static struct nvmet_fc_target_template tgttemplate = {
>   	.target_features	= 0,
>   	/* sizes of additional private data for data structures */
>   	.target_priv_sz		= sizeof(struct fcloop_tport),
> -	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
>   };
>   
>   static ssize_t
> 

-- james


