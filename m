Return-Path: <linux-kernel+bounces-408998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B879A9C862D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96DC1F22A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBDF1F7552;
	Thu, 14 Nov 2024 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBcQA2bD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757B1D9A5F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576642; cv=none; b=havxmTh1c8F4S6jW7FosBNTLTrBLN89KjvxwHsGHYtqCvF+iIKdlI7kZO6KR/ToxER2EZkqPJvTdoQYiC21qYFvVje/+F+JU40yBS9op/ZT01qso+WnvmKKsGLOhorwp3Fwl97K+DLMj4RBB6mbyNYme5UGfd5DqDUkKUFyjlqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576642; c=relaxed/simple;
	bh=7+vl68/jvb9rfrFLy3IGUNyaEvNIRJWriCxG3wtIK1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ez3P5kQMuHJviAmbG4c6jCO41oSOYch4nO85TVG68RnzinTHwNvhAQOyhwTTpjOdwKLuFziZpgpcJtPHm+iHnJLLYRHDzk3TGwfNrVrhg1NfRhxFM4q8o8/HCBMOFzw1EHyLK508ebTzdNDyXnhYQ/UN5zVboyBT/gc2zVOGpDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBcQA2bD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731576639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrSFgeuHYNgrrJXNzgxPo0ocsurFifsc7fqMwk3A2C0=;
	b=OBcQA2bDseIkLzzs/CoXj98/dLGv38tY4M0wPM1C1zEdjKOVg5A+ERSZT0487rFh5D8791
	DH0V0yRUi/mTwyMVzz14IEPZ+mZO5oCTmDsCLinE7PU45gB3LJIIED4LKJQQmrgkijfyeu
	R9BS5WRYAvkjy1UcF24c0IlRGeJvC/A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-5uTgPtFaOXOMoZDcDajqqA-1; Thu, 14 Nov 2024 04:30:38 -0500
X-MC-Unique: 5uTgPtFaOXOMoZDcDajqqA-1
X-Mimecast-MFC-AGG-ID: 5uTgPtFaOXOMoZDcDajqqA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b155e23851so43539885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576638; x=1732181438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrSFgeuHYNgrrJXNzgxPo0ocsurFifsc7fqMwk3A2C0=;
        b=fMmJNHBL/Js1eaDVNXR6AGws9cLUDBWd5rFWpZp3ahoxmHfm6WzK7OW5K6HugrsIIE
         diz7IQumtM/bf1RCTxGwjDyNYrpxv5RNY8sEcSO7I673VaFKvbU3zachm2m3845sh7dC
         ymdUsn+WlHyKlOsgcnF95Q1o+uJuJNfP4ZVgtWeEJ1e0tEQciNpBDpsCMAKNH9WtNwv4
         Zibn0P7kKc4T/z3ZH4ox/IHmzcdtdA9cvfe3TdhHzfeCghcj/BDNwIGCpDofZuIVfjce
         ohPyXC+NaSWMJIn127WSCiTsAKi0W1MyyJh2N4C9T/kZS0eo46kwSvjQwO+gOMnjsbXo
         vN+g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8h+h8AeJVUYzKkQMBXhdPAkxQaLtVMubOusB01Vl4ePjluovJr5dCLdWsnuG3aryeM0pijuSdkTBC/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh8QxfgB88MDN7mcntc5jn5kTTSHB0msIWuiamYaejUkgWikjJ
	2RoGYQ69D+Pc/tPUkoTTtvmjbxkjdsx5d2ralh5EAII7VNgYt6S9kHJ6qDi3GVay/D/bfjimxiA
	e059uBzZNPdZYRhIvdfj5fWLq1+riILKWrtx5FdwZUtAdIBPdT2V2E4vdE52haQ==
X-Received: by 2002:a05:620a:4103:b0:79f:67b:4ffc with SMTP id af79cd13be357-7b3528ab62cmr730524485a.5.1731576638034;
        Thu, 14 Nov 2024 01:30:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzvl1pJ94zqWs2bFy6g7EW6hsQmcWFqdigUoUrXGkvTzN3HRoBCNsXW3fPATzXvcaenhKuOw==
X-Received: by 2002:a05:620a:4103:b0:79f:67b:4ffc with SMTP id af79cd13be357-7b3528ab62cmr730522185a.5.1731576637666;
        Thu, 14 Nov 2024 01:30:37 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca643b6sm29091785a.118.2024.11.14.01.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:30:36 -0800 (PST)
Message-ID: <406c545e-8c00-406a-98f0-0e545c427b25@redhat.com>
Date: Thu, 14 Nov 2024 10:30:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv4/proc: Avoid usage for seq_printf() when reading
 /proc/net/snmp
To: David Wang <00107082@163.com>, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111045623.10229-1-00107082@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241111045623.10229-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 05:56, David Wang wrote:
> seq_printf() is costy, when reading /proc/net/snmp, profiling indicates
> seq_printf() takes more than 50% samples of snmp_seq_show():
> 	snmp_seq_show(97.751% 158722/162373)
> 	    snmp_seq_show_tcp_udp.isra.0(40.017% 63515/158722)
> 		seq_printf(83.451% 53004/63515)
> 		seq_write(1.170% 743/63515)
> 		_find_next_bit(0.727% 462/63515)
> 		...
> 	    seq_printf(24.762% 39303/158722)
> 	    snmp_seq_show_ipstats.isra.0(21.487% 34104/158722)
> 		seq_printf(85.788% 29257/34104)
> 		_find_next_bit(0.331% 113/34104)
> 		seq_write(0.235% 80/34104)
> 		...
> 	    icmpmsg_put(7.235% 11483/158722)
> 		seq_printf(41.714% 4790/11483)
> 		seq_write(2.630% 302/11483)
> 		...
> Time for a million rounds of stress reading /proc/net/snmp:
> 	real	0m24.323s
> 	user	0m0.293s
> 	sys	0m23.679s
> On average, reading /proc/net/snmp takes 0.023ms.
> With this patch, extra costs of seq_printf() is avoided, and a million
> rounds of reading /proc/net/snmp now takes only ~15.853s:
> 	real	0m16.386s
> 	user	0m0.280s
> 	sys	0m15.853s
> On average, one read takes 0.015ms, a ~40% improvement.
> 
> Signed-off-by: David Wang <00107082@163.com>

If the user space is really concerned with snmp access performances, I
think such information should be exposed via netlink.

Still the goal of the optimization looks doubtful. The total number of
mibs domain is constant and limited (differently from the network
devices number that in specific setup can grow a lot). Stats polling
should be a low frequency operation. Why you need to optimize it?

I don't think we should accept this change, too. And a solid explanation
should be need to introduce a netlink MIB interface.

> ---
>  net/ipv4/proc.c | 116 ++++++++++++++++++++++++++++--------------------

FTR you missed mptcp.

/P


