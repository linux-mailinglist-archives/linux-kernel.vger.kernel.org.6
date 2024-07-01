Return-Path: <linux-kernel+bounces-235805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C6591D9E6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5942C1F211D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28097824BD;
	Mon,  1 Jul 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hqt2utyx"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D631804A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822342; cv=none; b=cvuyRaR20jMvwiyiClG1pSEzUM66znNuI3hG5oixILEltseeYpy8LN8ovMcHZGxFrc3dMfYSg20Y40gsVGyYfutdyYiUHRfv9BjLjoGiEhx9NACpc6LrQnmrXnEcOB/dzJbMes8F51r3HAWKPqWSpBf1lP6ljXGBYvJWRMGXDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822342; c=relaxed/simple;
	bh=gLUct8rcDDst3OiV93/SJPrz4/rOAOI63IiekwKP0h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODkCfJN+mKNvUtOE+7slpsSW7VuVIDwdSp8YqEBW/5f8fVqIVOo9jvle1diupn1hWHIS2LH9CmAZyLsZd1pJdOZ66+t54XFUWpQTshwSnwDtNAugmq2EDCTTyLKCtFlai2j+2Obf0KV6vCMp5NHv/PxkL1P4Vquz+dZIpkC22ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hqt2utyx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a724b3a32d2so294297366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719822338; x=1720427138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2HT4hATmlGuJxaDUc5KV1URVwYIGXkgBvqpIWR1IlU=;
        b=Hqt2utyx1mcgehbDSlrjLlPEfDzn0bI7qoos4YsSuVqOZ1upvKBY61KNbCBQH5ZctX
         N2/6r7S40ORfdyEV/e0tWRiGhw6jSqYuiQJCJj6VM/ApZ6S7HOy21kxj1N4OJD0H/do/
         B8r3BWOCMN5z7FaczXgfoymYZMtOH+dYCtpv9Ki4b1meLxk2Bc+nD5FaLPJrQD1sFlnO
         I0fqLv3kycc2mW+kvlsHucwopXyntAKJszdKWC7JW5hAgN0ellIH2Wt0I73uMpDXLf5j
         lWV6J+GzcCbid5GIzw6chEvbeP+GVr55cjS4onndd/hR2/cOQ1WSUvsqsqoVeGwPn+Zk
         fYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719822338; x=1720427138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2HT4hATmlGuJxaDUc5KV1URVwYIGXkgBvqpIWR1IlU=;
        b=gSGQXGfXah3DDesRytOQIzufIPG8YtL5ftP1rLFup2eZ25W7P+vF3V1cQE9UE4K2it
         zunysXH76IqodF9hECI8WC0DhdnSWIQA/CGRAGLHmbok6Mz9j1nL/qlPTo5iIT+0mpuL
         0zXAYLIAEFuGEYmpQHI+jqHWc3yAm7wjwmfPVg8AI6ytsYMk+7JX9NFEZCUabcy1tPF/
         Y/vSXT166HLAqTFhS+t05CoaPM86EqNLSwwC5T3iVIdf+0aks7iyl4RlqrjoeEuAX8ZC
         wvR+abkwcCZZCiZlSAK0fnNYlGfnbX6fIDF5hhBjbdWgJxP7F1qsm0SHFduz+LWChZ0M
         YALg==
X-Forwarded-Encrypted: i=1; AJvYcCXosKTdVPQOKefkiYmPvVvHl5JV8+9cqfHobuiy7CEXJY37Qk6wLc201Ef7fuy4sZZvP/UuCroU1tIptb6kV38k53PTpSPXLbSFTckD
X-Gm-Message-State: AOJu0Yw+oOt+w6rGt6UV+j7kqZdNVRI5fXChNVJVi9KKDHejmtIbcGDQ
	cWQP2DSm4CbzSSU5otdcefmpiDX5ghGztKsyB9YNo0S34Z7A9ZKvFNwLMionsP8=
X-Google-Smtp-Source: AGHT+IFNIGavJzId+B0jfQxw7gW2PaPV3S5uawQ3l+IpGLodohtrkmAXLbHIsdTAntg4ZVBTEfEO8Q==
X-Received: by 2002:a17:906:d78a:b0:a6e:ffa2:3cce with SMTP id a640c23a62f3a-a7514498cb1mr267074666b.41.1719822338499;
        Mon, 01 Jul 2024 01:25:38 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf18c99sm308790966b.2.2024.07.01.01.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:25:38 -0700 (PDT)
Message-ID: <098c5197-bd3e-439a-ae4c-72e05a06a9a7@suse.com>
Date: Mon, 1 Jul 2024 10:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/xen/time: Reduce Xen timer tick
To: Frediano Ziglio <frediano.ziglio@cloud.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20240619104015.30477-1-frediano.ziglio@cloud.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240619104015.30477-1-frediano.ziglio@cloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.06.24 12:40, Frediano Ziglio wrote:
> Current timer tick is causing some deadline to fail.
> The current high value constant was probably due to an old
> bug in the Xen timer implementation causing errors if the
> deadline was in the future.
> 
> This was fixed in Xen commit:
> 19c6cbd90965 xen/vcpu: ignore VCPU_SSHOTTMR_future
> 
> Usage of VCPU_SSHOTTMR_future in Linux kernel was removed by:
> c06b6d70feb3 xen/x86: don't lose event interrupts
> 
> Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


