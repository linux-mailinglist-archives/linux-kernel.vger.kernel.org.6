Return-Path: <linux-kernel+bounces-282122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C794DFCF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FDE1F215E9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 03:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128D5EAD5;
	Sun, 11 Aug 2024 03:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AARIWC/W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853D1757E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723346885; cv=none; b=SfoDc6oIKneyslDE0zLhvaolEVHRZOXEL9kihhcAwEq1eaUrTNf3g3WPIoMQQ5YfmHD5mQo2SqQGckm9YERjRGQ+/xYyDqWhQinOKQz0WITuRrqXlwtXD+gRCcnzQyL5VvfC7UrIg2DkIvsODVnTfi6b9TJNVI3VHQtrnq5dV1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723346885; c=relaxed/simple;
	bh=RY/IUzCz5GxjM0TGOgjQSg4yMvLbYZbnv0gYvHvdIV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4e0mAkJyzZHkgu+grUMTaX1TCWLyL5+nTYp1kET/+vVacfLzFei396jwjAJWXttQMXtXa4YkajZArMiV4HQp5yEOj5SfyL8i+ydZdpfAXJAxrjpcb0s7LSD00DQ0a1uDR0RNqY5g8OcjdfNymvOBcBZg5CxSCnW7laRn5pb75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AARIWC/W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723346882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkbI7FgNDG6AaNAB/6pL3QoE4GGqJVF4YrgSIZaguyo=;
	b=AARIWC/Wrt5ewRxA+TnPspGmaiE+F+g9V4SGy3fFxUwulm106PQZzcsMGHs3A4mrimQmuG
	6ptZaTaBq5QmWxi2SSN4CMYhiuW4DpKNVpIUdwOXAWe727g1BBlknIH2/OSykT3Cu/Xi1H
	zBlxstF0lKWZa3vZzsm5Pto+XDpSE0c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-lLZae4IvMOSNw62RZ3viJw-1; Sat,
 10 Aug 2024 23:28:00 -0400
X-MC-Unique: lLZae4IvMOSNw62RZ3viJw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B1CF1944F02;
	Sun, 11 Aug 2024 03:27:58 +0000 (UTC)
Received: from [10.2.16.6] (unknown [10.2.16.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E94E630001A1;
	Sun, 11 Aug 2024 03:27:56 +0000 (UTC)
Message-ID: <88c188dc-3664-45db-b54a-11feca59d7d2@redhat.com>
Date: Sat, 10 Aug 2024 23:27:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] padata: Fix possible divide-by-0 panic in
 padata_mt_helper()
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: steffen.klassert@secunet.com, daniel.m.jordan@oracle.com,
 akpm@linux-foundation.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Zrbm--AxRXgfHUek@gondor.apana.org.au>
 <e752f094-adb4-4448-8bc8-e2460330eaec@redhat.com>
 <ZrgXtLI1R5zJ9GFG@gondor.apana.org.au>
 <91d29649-ca88-4f6c-bf1d-19e49c9555df@redhat.com>
 <ZrgsU-1PdxvUVMOW@gondor.apana.org.au>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZrgsU-1PdxvUVMOW@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 8/10/24 23:13, Herbert Xu wrote:
> On Sat, Aug 10, 2024 at 11:11:07PM -0400, Waiman Long wrote:
>>> Unless I'm missing something chunk_size cannot be zero before the
>>> division because that's the first thing we check upon entry into
>>> this function.
>> chunk_size is initialized as
>>
>> ps.chunk_size = job->size / (ps.nworks * load_balance_factor);
>>
>> chunk_size will be 0 if job->size < (ps.nworks * load_balance_factor). If
>> min_chunk is 0, chunk_size will remain 0.
> That's why I was suggesting that you replace the division by
> DIV_ROUND_UP.  That should ensure that ps.chunk_size is not zero.

Now I see what you mean. Yes, we can probably change that to a 
DIV_ROUND_UP operation to make sure that chunk_size is at least one 
unless job->size is 0. I still think the current patch is a bit more 
fail-safe.

Cheers, Longman



