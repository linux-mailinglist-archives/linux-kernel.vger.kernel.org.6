Return-Path: <linux-kernel+bounces-336679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6815983F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA55A1C2264A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2F214658C;
	Tue, 24 Sep 2024 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9HPeLku"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773E770F5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163241; cv=none; b=ltAnGUCkmIKadIJm8vutXOHhCPtI5O1umigeKzz07EPS/AHYWL9PTZjRNM2fnpELo95j+LzdNwvxZxBeRUkRNLxNRfPOb6au8MCJqfP5MJFBbCPE3udTGbdw+XfyVl5F+J4TS9q7r7BcRcQQYU50C2xZSgUDjZiUgQFFRYxHouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163241; c=relaxed/simple;
	bh=slahvCDSyaFHigPJyr/eRdDb9k5kVp8Ag6wFb5ZgudM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3c9MwceBxnp23siyTdTXY8Ts6MZX36hBqKLum+te+mElcatv1xoXvBUMfrUkYJvIbqRsS5/QTJeEYDoVGI19zZAlpyknlBTtoWugOOl47SJgSwfAlJhuA1Zc4f/EcAAbu4VZSQ/Eqvt2xh35ebtFYn7oHcc2F1i9tROVDEm9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9HPeLku; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZyGkSAmnnlavlR7QHFFlMpJmx2qDYHfUoqjHUUNuBB0=;
	b=Y9HPeLkuKNdL3TZYZPjIfN0bhyBF6b4SXOAOR5BZRAF+l3XUpAn3jYQ5b2szpVVmO1VfNY
	dqY7tXjFDOLB+5OioH3fKa68k0ShnT93th5CDF/QUFVi2zY8d6DaJx6qVLCli5VP/bP2Qz
	qD4fuWRBubMjUUQuww5KoI2ub10MLxU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-VjoCK68dOlax6p2j_1KeXg-1; Tue, 24 Sep 2024 03:33:55 -0400
X-MC-Unique: VjoCK68dOlax6p2j_1KeXg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374bacd5cccso2767965f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163234; x=1727768034;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyGkSAmnnlavlR7QHFFlMpJmx2qDYHfUoqjHUUNuBB0=;
        b=H05cvL+hmIaxGGDpv6CjKGJjqnJAEvBIwS1Flb1XL9uefRkn505HRSb3InWUGW4sY/
         aTqO72L5jdUTYB5sWu6bNPBhOM8kecCrn2nOGw9rbDaEjSaLPWj9ofBwxw5V6uf9wRvq
         DEqoqL5U0xG4bLI3YlMBcppCwG4nvvf9dtks7Cn7qEDHOSTWsT6oxoLX50GQcXxRnS10
         4GeLnC0dpj9kBlsRylUL7x1/Gl5yXPL1csZqsdftkSd6qxDoj/0Ld2ZmI1XUtdS7t0yQ
         eEiNcferB7q1ClLiW4H52jUcce8sC7pJMHOarkqPtZddEteu7i/BEpzONpRQzM6rC1Ce
         ReKA==
X-Gm-Message-State: AOJu0YxLnlwmEZmwDP8Txj9F/wsYnWUyvroIqnrjhgxkgG0Wg7ckKJjd
	VoXGJODu3y5JMpH/l4hPk9HDA8mCYYYsPxsrBSL0cmgMvHL1pm+OkMZ3spMu3ge2JOBrSoHVQDh
	n5ElSXGN3HHbPpaE7iC2qjMt3vOnp5HsiQvxJ090J6fu9C4fgAzOkTC15UfhyReZ5LxWzvBa0
X-Received: by 2002:adf:e101:0:b0:374:c847:86d with SMTP id ffacd0b85a97d-37a43157fccmr7620958f8f.16.1727163233842;
        Tue, 24 Sep 2024 00:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg8oAUySuLNqgwyyJJwGURq535cfsWrzS91MYp61VW781fV+1Vf+LuQNNjTs33SP7ITsoiLQ==
X-Received: by 2002:adf:e101:0:b0:374:c847:86d with SMTP id ffacd0b85a97d-37a43157fccmr7620952f8f.16.1727163233454;
        Tue, 24 Sep 2024 00:33:53 -0700 (PDT)
Received: from [10.202.151.204] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e9025ff38sm13191775e9.0.2024.09.24.00.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 00:33:52 -0700 (PDT)
Message-ID: <aa23abe3-7236-4b9e-b237-3b822ac9d186@redhat.com>
Date: Tue, 24 Sep 2024 09:33:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: Define NR_CPUS
To: Guenter Roeck <linux@roeck-us.net>, linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240923235617.1584056-1-linux@roeck-us.net>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240923235617.1584056-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.24 01:56, Guenter Roeck wrote:
> SPLIT_PTE_PTLOCKS depends on "NR_CPUS >= 4". Unfortunately, that evaluates
> to true if there is no NR_CPUS configuration option. This results in
> CONFIG_SPLIT_PTE_PTLOCKS=y for mac_defconfig. This in turn causes the m68k
> "q800" and "virt" machines to crash in qemu if debugging options are
> enabled.
> 
> Making CONFIG_SPLIT_PTE_PTLOCKS dependent on the existence of NR_CPUS
> does not work since a dependency on the existence of a numeric Kconfig
> entry always evaluates to false. Example:
> 
> config HAVE_NO_NR_CPUS
>         def_bool y
>         depends on !NR_CPUS
> 
> After adding this to a Kconfig file, "make defconfig" includes:
> $ grep NR_CPUS .config
> CONFIG_NR_CPUS=64
> CONFIG_HAVE_NO_NR_CPUS=y
> 
> Define NR_CPUS for m68k instead to solve the problem.
> 
> Fixes: 394290cba966 ("mm: turn USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options")
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Instead of trying to make SPLIT_PTE_PTLOCKS depend on the
>      existence of NR_CPUS, define NR_CPUS for m68k.

Okay, looks like we're cleaning up CONFIG_NR_CPUS for good.

I'm back from conference travel tomorrow; I'll then throw in the following
into cross compilers and fixup any other arch that needs attention:


diff --git a/include/linux/threads.h b/include/linux/threads.h
index 1674a471b0b4..e31715e6746b 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -13,8 +13,7 @@
   * bit of memory.  Use nr_cpu_ids instead of this except for static bitmaps.
   */
  #ifndef CONFIG_NR_CPUS
-/* FIXME: This should be fixed in the arch's Kconfig */
-#define CONFIG_NR_CPUS 1
+#error "CONFIG_NR_CPUS not defined"
  #endif
  
  /* Places which use this should consider cpumask_var_t. */


-- 
Cheers,

David / dhildenb


