Return-Path: <linux-kernel+bounces-261516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E6E93B828
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6F4B23DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B713957C;
	Wed, 24 Jul 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ial28SqH"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E715132494
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853740; cv=none; b=NkUB4p2UQvPKUB6JyemvYCNt9QCVx7gFEAzCZAAm76pSqOrnSVxYX4i2UfUkMh/eS7oYRkpTFhoXJZmbJW0B+R2GbbBVwGGPz/WwoscKB7jxePIvyrYxjUjvzIqPI1jEuulaN0aIcUdvxZK4gkqGbPN/mPQ/QwWw0+WFYpho+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853740; c=relaxed/simple;
	bh=VFIouTgzioPnV8PxR8/n0LUJ2CqqqOt9c1k3KYsJ+RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHaxX59lJl1PQ/P1n85V7Ow2dHAa8bH7FXk93z2O/+W8IahvVl/Ac4SfpG16mpOdEO9mIz1uH+IY2cExa6CDNuzolYFSH7r0wICmpYz8Ff8r+PFPc7OycSccO4NGiMiCrL87uaqWdWXUv2OOwSSuptlzybTn0UwStixb8fuANPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ial28SqH; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2644f7d0fb2so11447fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721853736; x=1722458536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwfIRXOiJ/heI64+FQNlpZPVBndoeV1RDDhZJ9SjarM=;
        b=Ial28SqHYFLrCG9iuiDdtO25WPHoYZVH9wltjdc+WoNWIu0j77cI4Rn7hgHeYqz/s5
         Tl0ufAIfVMuATzHgOLx2RLnLk5StqxboNsrtzlka3/iB4hh5Hdop/UzO8a9lXrbkprlm
         ZuFObHVaeU/+xbASA9+gc7TmrvwzqvMneNMZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853736; x=1722458536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwfIRXOiJ/heI64+FQNlpZPVBndoeV1RDDhZJ9SjarM=;
        b=WD8/ctbo9nGJhIFBtMpm9wv+uzrClfIz1uQYilN1o93v/QGgHApps1SekNZdxZ7ydH
         gzDz8XHjN4gUKeFA3WCQk4LeD3R/GZ+WPgK3JY3Fd5WHR6/HV4CplrI4XfQsfm3/EkYA
         thv+Et3zBY2HB15ALg1bde61xHp9OK+cwqhkLOjPpBG4g6FACnHNf058TKqW4bBSbOY1
         EI36TcRSxtUjUVfnPu71Q+di8O4ECS9K9ZFR+DkwFJYqO8TMtad69f4eUMgG1R1BOjVS
         pixE/bl23LHxrU5/71JjKjbC6WF0paZP3e5VsTHpFHQJ57AcmvnR5Vb4adGTIiAYDfnm
         4H9w==
X-Forwarded-Encrypted: i=1; AJvYcCXSrmXo13RntUxbcE0xQ4MDjn5t2bHfKKaEvXjmDZ2akbNsMUqAOHtFw3lE4yHOduIQ4VTIEtgvd/1Nl3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHsSqMklQkg/CxTQ5l+yGIOAE5aPnC99yACbDN5p07BTW0SYm
	TVkjrL35pQE5TM4dRGdzbJVMQpo2VclW4AekGNsrFPdCOFly1GFvmxHTIT/gbtU=
X-Google-Smtp-Source: AGHT+IFmjQM/tsv5clvcDuEEZcPj/WQfIe3Hmew0qHt87NCUlyPGfYsebGMK7/9TgEQGvEpYbVMdPg==
X-Received: by 2002:a05:6871:e2a3:b0:260:f1c6:2586 with SMTP id 586e51a60fabf-264c4538997mr198897fac.10.1721853736344;
        Wed, 24 Jul 2024 13:42:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9ec428bsm18707a12.63.2024.07.24.13.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 13:42:15 -0700 (PDT)
Message-ID: <49d2134c-20e2-4042-9d01-9d7ca28af052@linuxfoundation.org>
Date: Wed, 24 Jul 2024 14:42:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: Documentation: Fix title underline too short
 warning
To: Chang Yu <marcus.yu.56@gmail.com>, pbonzini@redhat.com
Cc: corbet@lwn.net, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, chang.yu.56@protonmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <ZqB3lofbzMQh5Q-5@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZqB3lofbzMQh5Q-5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/24 21:40, Chang Yu wrote:
> Fix "WARNING: Title underline too short" by extending title line to the
> proper length.
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
> Changes in v2:
>   - Fix the format of the subject and the commit message.
> 
> 
>   Documentation/virt/kvm/api.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index fe722c5dada9..a510ce749c3c 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6368,7 +6368,7 @@ a single guest_memfd file, but the bound ranges must not overlap).
>   See KVM_SET_USER_MEMORY_REGION2 for additional details.
>   
>   4.143 KVM_PRE_FAULT_MEMORY
> -------------------------
> +---------------------------
>   
>   :Capability: KVM_CAP_PRE_FAULT_MEMORY
>   :Architectures: none

Look good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

