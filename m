Return-Path: <linux-kernel+bounces-535978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F747A47A01
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF857A3973
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22731227563;
	Thu, 27 Feb 2025 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9GrcTYQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E51527B4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651581; cv=none; b=etUKNX5ZFiIRytehhdwJFt/pcs/im9BHibKTIVwcGrG0zur9Gcqlmsk24XtZdPNgTYJhvRDlASlVAFCVP00v0Qz5oUc/Ic6jprO3Nc8YQaCSID4Jpn6Vr6cUVKEIBs3x9cmQZ/WHFGs/6YmIYfPL+DXXrjhfYLbSPPLd03IUnqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651581; c=relaxed/simple;
	bh=X4JPAH/sc62VN1bVz4QgZMmPV3NQvGqMYU+FfWMtWCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyw6ybSf8js4jKQiAMzbWK/k/d2PKs+qt4Sbp7fKDDDn8UwhgWnHwGCUuOT+1exBk+J9Xocm2vRPeDaDuBQJvsbW5bbVQngw3dW+JK5qyr+iY6s84lBNzfrWG+2JaUk9JtWoe2aADiN4MJGoUUq5zlL9kTgImgoMAEbXLy94Or0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9GrcTYQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740651578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UFnZA1KqxUR4AS86ehSRALNopd+p33rY6Keht7Hkxc=;
	b=a9GrcTYQXaexE4satWF3s3YgrK6CStuO+kvu6Hbh1VxU/Bh/M19UQ0FqrhF3MSV4w/1IPp
	+UO/1rch44TcmNz0x9zz23nu8PcsAxL2oLeUf/xQjc4Y88RD3XHxa4CsJrCJLVYRXQUnG4
	ZMFDn5frcQhdw/SMtMsVx54f3WwzuuA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-u2M6ZyRsPxm4R0-cV1bAPg-1; Thu, 27 Feb 2025 05:19:37 -0500
X-MC-Unique: u2M6ZyRsPxm4R0-cV1bAPg-1
X-Mimecast-MFC-AGG-ID: u2M6ZyRsPxm4R0-cV1bAPg_1740651576
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so3976615e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651576; x=1741256376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UFnZA1KqxUR4AS86ehSRALNopd+p33rY6Keht7Hkxc=;
        b=SgC8zX/gMKKD/I78uLna7XcA1yrlMyOsPLBMtxT8h977YMgtnsC5faUb84JkPGzftM
         PuZhjsNhYilJWFugsUpqT8P6F8ZyyFMP0KZkFvmvIB9aI9nhcYnAWrTy+9t7cUnjXwO7
         aeU35QlzEjQcjA88laEOiafP0Hz89X6eFydoIhScTOG8N/F/8TAoYX0EWGJg+Uz0AEsc
         2brds1slAJd53el65rQaJldOJzcRGUDb+bFd0Pmp8uVi3Mq42quXaoUPuBuTjF0DexRg
         KlpNIbwiSn1e5tgjvjxELXBAD8sVbr/+BtCSBdgRHzfmudoPuh+09yXrB30dIQ3mGpvy
         sSXQ==
X-Gm-Message-State: AOJu0YyItzge+WYW3qaDACeIOvbKlUw0NPvSeWLT+kVlyvxxJi/9jVgd
	5PS5TYjCrLLw5fnICDBB/h0wwbo84HpUFD+lB0HGCqJ6l906TTUtYvej3ujGoFQNajZGcqfs5Bw
	27VULnHIohkX98JkqT18+nV+9JCoep5fEsTM0VQglxDAHKM7Ctrg45Hpq4vMQZA==
X-Gm-Gg: ASbGncujGPS+BHAuP7t+z6gT27ELItBftNcCp7PZAc71k16hzzqnFJhnhHXvIN7Fs72
	vstNl+ErNmRREpvHVMbBPOMleRnR6MrfB/JFBp62fj5nU+sDoDM3+aPV0BAHipxI+Ewf/Ul1cde
	iKlHCG+t0bHX32vLgV9Q9De9nkotfGR8lPDVQqG7vXLuaMTi7RZspz12dsnJO9ZmagHGcAMpsSZ
	bTVkA0VxS1ohdvyvBmzyGmt5dfiAS9Ne5bXDL+Elx6vD6gUsothixxx9/CPMGnJzTDbhFxeK9Bc
	1UFVQwVCppLStlvSf1wjxXf8kidOno1Apr7OkpL28QmB7g==
X-Received: by 2002:a05:600c:500e:b0:439:8e46:ee73 with SMTP id 5b1f17b1804b1-439aeb2b5d6mr213595085e9.15.1740651576143;
        Thu, 27 Feb 2025 02:19:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Vft26tcnQWraFswBGjedEu4sbaWKbanioc5YQRLPIC1rcPLoyFw5Ul1m0g3Nh69fGEHqEw==
X-Received: by 2002:a05:600c:500e:b0:439:8e46:ee73 with SMTP id 5b1f17b1804b1-439aeb2b5d6mr213594825e9.15.1740651575811;
        Thu, 27 Feb 2025 02:19:35 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4847fe5sm1557821f8f.73.2025.02.27.02.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:19:35 -0800 (PST)
Message-ID: <02e13783-1f87-46a7-9396-96bf17e36a9f@redhat.com>
Date: Thu, 27 Feb 2025 11:19:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 6/8] net: pktgen: fix mpls reset parsing
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Frederic Weisbecker <frederic@kernel.org>, Nam Cao <namcao@linutronix.de>
References: <20250224092242.13192-1-ps.report@gmx.net>
 <20250224092242.13192-7-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250224092242.13192-7-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/25 10:22 AM, Peter Seiderer wrote:
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index ae5e81e62733..bb13a4591709 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -915,8 +915,13 @@ static ssize_t get_labels(const char __user *buffer,
>  
>  		max = min(8, maxlen - i);
>  		len = hex32_arg(&buffer[i], max, &tmp);
> -		if (len <= 0)
> +		if (len < 0)
>  			return len;
> +
> +		// return empty list in case of invalid input and/or zero value

I'm sorry for nit picking, but C-99 comments should be avoided

Thanks,

Paolo


