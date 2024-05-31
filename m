Return-Path: <linux-kernel+bounces-197434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75B98D6A89
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A101C256B9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867917D374;
	Fri, 31 May 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="z11G02qy"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722041946F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186393; cv=none; b=JB8jhyrMJCea7X6/T9S9mE3hpayQnq4O5Y3Gp/ojEK7yPy2NJ4dkMtDsL1CpcZ91fQyfmPKtB/w00Up4lK+du03OkQ4RBqHRkhHXIFmosJ6VOas4xHksLhmA9OH9Ls9e6IgdAZPjzSuYrcb9G2AtqM2+O+QC86RJalHDk4mifUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186393; c=relaxed/simple;
	bh=owRelOuZ9GUsLTm5zFW5nkRRmeAS9ZJO4Lf1/VSYga0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3iTeTlDMLTMaNX5uCLKQ7PwMapn1iQg3oxqoQ5QJkGiZFewqT4Ukvgd3mhX0xn4rLDcQ07B+Yh8ryejddBiUEw4iacQ+TGDqqEJaIsnLcaXoTRCFQL6ebkVk55Bj4E2yXq6LN/uOHEgqD7ARadBDgCf5EakRJIyvV6SE2C8hoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=z11G02qy; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VrZ7C6HB4z6CmR43;
	Fri, 31 May 2024 20:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717186389; x=1719778390; bh=dZtTBY5FcMwiGk2Tdn2cq8Zh
	A5BMk/yzSD0uHXVEwp8=; b=z11G02qy8Yu34iUu3zZ3RWgZJsyYnQXIWPfvcTsZ
	SfP2zoPwAGKx+cyTieNWrbkacL3d+zJ82RApFpHl6NmPNYnBOGuer/NbMVmqw848
	5YH3+6wA26SWGvFmUjIfkpQSFs+ifpwsKq6fDON9fuPTGV4tvsSaxHeuUMInehKj
	aufpWHQSLWbGXKo2R+k8Su6yKpqNNILJBIHQtNOgrxuVWpWCGMLIeYdqxPSZ1P3B
	gScTcSrXgB3Y1KPT45dyRm0g1Jy5i9QBLVp4lbeXeiT0fdkAeJvRpA2yFQ1XQ5u+
	8Ky43uLPyAIpcPK05mFEQDtuqFgZsn/sJrwLQEIfXsO7Ng==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wgAnnmK_mDdK; Fri, 31 May 2024 20:13:09 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VrZ785DNVz6Cnk9B;
	Fri, 31 May 2024 20:13:08 +0000 (UTC)
Message-ID: <e1719623-a42e-4394-b840-2741975ead37@acm.org>
Date: Fri, 31 May 2024 13:13:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: uapi: Fix compliation warning of using
 IOPRIO_PRIO_DATA
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk
Cc: dlemoal@kernel.org, linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
 ke.wang@unisoc.com
References: <1717155071-20409-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1717155071-20409-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/31/24 04:31, Zhiguo Niu wrote:
> Generally, the input of IOPRIO_PRIO_DATA has 16 bits. If use format "%d=
"
> to printk IOPRIO_PRIO_DATA, there will be the following warning or erro=
r.
>=20
> fs/f2fs/sysfs.c:348:31: warning: format =E2=80=98%d=E2=80=99 expects ar=
gument of type =E2=80=98int=E2=80=99, but argument 4 has type =E2=80=98lo=
ng unsigned int=E2=80=99 [-Wformat=3D]
>     return sysfs_emit(buf, "%s,%d\n",
>                                ~^
>                                %ld
>=20
> This is because the output of IOPRIO_PRIO_DATA is converted to "UL" fro=
m
> IOPRIO_PRIO_MASK, which is not reasonable. unsigned int is more suitabl=
e.
>=20
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   include/uapi/linux/ioprio.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index bee2bdb0..9ead07f 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -11,7 +11,7 @@
>   #define IOPRIO_CLASS_SHIFT	13
>   #define IOPRIO_NR_CLASSES	8
>   #define IOPRIO_CLASS_MASK	(IOPRIO_NR_CLASSES - 1)
> -#define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
> +#define IOPRIO_PRIO_MASK	((1U << IOPRIO_CLASS_SHIFT) - 1)
>  =20
>   #define IOPRIO_PRIO_CLASS(ioprio)	\
>   	(((ioprio) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)

This change is safe even if the mask is applied to an expression with mor=
e bits
than an int because of the integer promotion rules. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

