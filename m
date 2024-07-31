Return-Path: <linux-kernel+bounces-269548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 550EE94341E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F373A1F2287F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246CF1BC075;
	Wed, 31 Jul 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOu/zhdA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A041799F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443238; cv=none; b=OUfonTl9vwJnCRLzJaJSPSDJGjTl8XIT/rIvRHypzd1GKgUQ8trq4PfM0Kh6vY0+ldg72naA3rEFvV5ofzefrXTd6+1BIrN2QYNT7NyRJzIW0lmBK56cOIPOGjIu0So81X0C7OWbIyVLnDg+r8bq70ma4icd7a5VDBqeB0C1siQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443238; c=relaxed/simple;
	bh=6MTBTOFgscLG+ns0zexJUodY6X3jKNyieaQSLz2kb/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vCOG1jD9/s46u2gUXFu/di2TMx5PvaZ5dO866cRhdQC2W6NQG1f7neEX7xfiszuFKY5n+iBE5rHR8RkacqpZYqUTnb1fjCw+XIeuiceIMbReAymCy2aJDw4EHA7AbfFYOvy52DH+4ftftsnfgtamM0m9CACvi+wx+NVSsBoaSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOu/zhdA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722443235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0mBAGnXHl/olCTlGA2xTK5HrQdrCWUfp+Vx9tKZMRQ=;
	b=eOu/zhdAylzeCDGtaP48diqWwwiJWJ5Rf7M30wozIDhDWTgKGS+f9UwA2KlCrmO0cWoE/T
	IPJ5oHDKztCFtDgt6Gn9f/HhxlPV+rktVTiT2RMWjHf5XsEANv9lOra6yQ1TCeKUK2mxeL
	yr6eeXMD9vyqGZGxFrfAwzj232nWUm4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-3xhpCYXtOg6IUOXmFk_Yng-1; Wed,
 31 Jul 2024 12:27:12 -0400
X-MC-Unique: 3xhpCYXtOg6IUOXmFk_Yng-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C684B19560A1;
	Wed, 31 Jul 2024 16:27:08 +0000 (UTC)
Received: from [10.2.16.69] (unknown [10.2.16.69])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE8973000198;
	Wed, 31 Jul 2024 16:27:03 +0000 (UTC)
Message-ID: <ea55bb29-c3ba-4e71-a76a-f788c4a7ea16@redhat.com>
Date: Wed, 31 Jul 2024 12:27:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/13] riscv: Do not fail to build on byte/halfword
 operations with Zawrs
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet
 <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-3-alexghiti@rivosinc.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240731072405.197046-3-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/31/24 03:23, Alexandre Ghiti wrote:
> riscv does not have lr instructions on byte and halfword but the
> qspinlock implementation actually uses such atomics provided by the
> Zabha extension, so those sizes are legitimate.

Note that the native qspinlock code only need halfword atomic cmpxchg 
operation. However, if you also plan to use paravirtual qspinlock, you 
need to have byte-level atomic cmpxchg().

Cheers,
Longman

>
> Then instead of failing to build, just fallback to the !Zawrs path.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>   arch/riscv/include/asm/cmpxchg.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index ebbce134917c..9ba497ea18a5 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -268,7 +268,8 @@ static __always_inline void __cmpwait(volatile void *ptr,
>   		break;
>   #endif
>   	default:
> -		BUILD_BUG();
> +		/* RISC-V doesn't have lr instructions on byte and half-word. */
> +		goto no_zawrs;
>   	}
>   
>   	return;


