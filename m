Return-Path: <linux-kernel+bounces-278175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3394AD07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E12A1F22146
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F120D12E1E0;
	Wed,  7 Aug 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFBnDi6p"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F012C81F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044982; cv=none; b=JlFxXyXqBLai/t3NkoxPXWoG3ZRCh3I0WkK6Upe0JrDxp6wn6b4F0EE7lgjQjMlebKh++dfk8KA9YeiPY59Bwunpx40vuCtHx8zfBc//Xd1/ifOMxIrnrqwTvodFvhmnoKYn+RWaFeVWWr8NELm1Wxrig/kVBm7TZxZJsuSEeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044982; c=relaxed/simple;
	bh=5EZ6RcfZxVaWFsl9t9m825a8ruotO75Z63YlCfyX29U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSI2elLjZovCsqsh7bnYgR5/7FMCSx8YqEQrJOmfANnNG3O/RKKCrgD9dKEzVVJUiPIX0Rma43hQwqyyiPvugJ/nxUBZSdVXOJbXsIM1MCc9rCaENnnUk3SCjEJcs07XNi2fWmtyKUuCtokMuamrRv/J7Y52aRG2OyG+SZ5ofec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFBnDi6p; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5af743b8fso1037595eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723044980; x=1723649780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z78Gh4UdA0tB35J1jSaWl0lYIs/XnugYt9wPtQMe9vc=;
        b=TFBnDi6pGPIzq8zM3b4GCF2fDYTxxwGkVo+fKpIQpH3a48eCt9WxvVsl1/v7L6LfZB
         vzScwD4/xFAQqnc0s3zJ3xcixUodTOYC/SWWCDjD4dzYOiPLxGy1eQlpuEpeQqnWubs/
         VmrJTZtla5jIkfvHQVLCRxE2nREzFTx5v9x4P8N3Rk/4iXdkCZaca4f0oN86FwooDLnU
         sQVIIzGBSZUexbEKQPIg1ITjTgu42cYLYsH6KMlUSVlNzZwAAdqZaVWSIN7epS5394N8
         eTjbo9xkSeHrx4IFsxZkUckD4ZENf/rgLTdPmkv5v2YzSLqP6lUVZ2DTBZ/uGzJIwyZg
         f5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044980; x=1723649780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z78Gh4UdA0tB35J1jSaWl0lYIs/XnugYt9wPtQMe9vc=;
        b=L+uv8i2oVrqGUskEY8po+43Oq9ngDVf+49jYF0HTvH+ac9g7gmXOFaSkuK//xQpr7N
         jv6kSDDA94+RZDVD8/8AAk26v3q6QD3vKvGB5fvcONBt1MbXH+fWC098pA8Jsb8LMMn/
         DY8zDrkaalghgTnzpNQXT2a33xz6tUSzcMc7gOHowP/Yk9iq5Vuk92u8qUAKJvDUZyfq
         fzhqkMKfAQdVQkYZnXpM6QIks7+8KPzPUeqG7WcVaFc4bLWuqsrHqqfcVZAJDiIE8/1g
         4pQHzOeNwM327SpZndbJb9o8iGFLIK42GnolI84EXF4zhBbKzNwWvxdpKzJdqMUmhtjt
         hXZQ==
X-Gm-Message-State: AOJu0YyGPSU98xgr/++cAtHs3NyaYIhsiv/sXsOASPSw6niaC4d3WIxw
	oyUal9bZFGzoK5mR22dD+ArhbdqPdlv77N7UlNpNY2/FEOKEnDSRXIQv63rER+g=
X-Google-Smtp-Source: AGHT+IGUXN41/a8lfOzUtOLVFUKQ+fLFIHCfxxqCtkNlGSlS4gqUSvF1myBpfCNkg8rXaCgULVNxMg==
X-Received: by 2002:a05:6359:5a4:b0:1ac:f13e:49ab with SMTP id e5c5f4694b2df-1af3baf8185mr1158957055d.26.1723044979810;
        Wed, 07 Aug 2024 08:36:19 -0700 (PDT)
Received: from [192.168.10.4] ([43.224.156.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f23esm8388747a12.15.2024.08.07.08.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 08:36:19 -0700 (PDT)
Message-ID: <a65d0b09-466d-415f-9bd0-cbc5ff3539e7@gmail.com>
Date: Wed, 7 Aug 2024 21:06:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [build fail] v6.11-rc2 from "ARM: 9404/1: arm32: enable
 HAVE_LD_DEAD_CODE_DATA_ELIMINATION"
Content-Language: en-GB
To: "liuyuntao (F)" <liuyuntao12@huawei.com>, arnd@arndb.de,
 linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
 harith.g@alifsemi.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
 <c11ba413-89f6-46b4-8d59-96306c9f1f14@huawei.com>
 <52518ac5-53bb-4c70-ba99-4314593129dc@gmail.com>
 <2812367a-49ad-4c88-8844-8f8493b15bbd@huawei.com>
From: Harith George <mail2hgg@gmail.com>
In-Reply-To: <2812367a-49ad-4c88-8844-8f8493b15bbd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07-08-2024 20:52, liuyuntao (F) wrote:
> Thanks, I reproduce the link error with toolchain
> gcc version 9.3.0
> GNU ld (GNU Binutils) 2.33.1
> 
> with same gcc version, just upgrading ld version to 2.36.1, it does not 
> segfault and build completes. there should be bugs in low version of ld,
> and the ".reloc  .text, R_ARM_NONE, ." triggers that.
> 
Thanks for confirming.

I guess we need to add something like
#if !CONFIG_CC_IS_GCC || CONFIG_LD_VERSION >= 23600
around the entry-armv.S changes and maybe select 
HAVE_LD_DEAD_CODE_DATA_ELIMINATION in arch/arm/Kconfig only if the same 
conditions are met ??

I had screwed up the CC list when I last replied and LAK list got 
changed to lak-join email id by mistake. Fixing that in this reply as well.

Thanks,
Warm Regards,
Harith

