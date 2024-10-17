Return-Path: <linux-kernel+bounces-370554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150119A2E76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29161F239DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51B227BA9;
	Thu, 17 Oct 2024 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZYzJStJq"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25BC1D0411
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196845; cv=none; b=Jt8niOSALrPfyVinMUG9OlZ0v0aHMyfQsJDXlQFd4aTC33x+7lK9CIR+ehzdXhCSKTEC6w+y744j9ZCgXZad5uwOdB338hWZBDwaImtKonJ/+m3+Sw983Uv/ANSOXucNY1RiYbZQT3X4uX1FEzO/o/lf6IBtj7LZPrVxSMcBrEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196845; c=relaxed/simple;
	bh=XQQrB+BqmcD4LcSj1KMeDy2opfoF996hSV6qgCl8kak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNsPf79Mu3vRzQPqpQMDZ2Qz9+vKrI5ztPTDol9ExmRpC19933qIcyow5TscKi0zQ735JeQFlfm2oPXbgO2EMnLj/b+j2hvcMVvNNLSkKthxIvUUz+b+IgioXTkZRnzy8sK17L2dklTnBNZ0dv6a5ASHspCn41EpZLRBhUgjEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZYzJStJq; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83aad99d6bfso58329139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729196840; x=1729801640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0S5MPorG8STFHi4ZHKupmmCHSXBZxKErXkagXcshGng=;
        b=ZYzJStJqb8QBz8xp4UUPqApOzSoa9HBP7GODeDAfS8laRUJgPVOf5bESi2ZMkFvGo5
         7IdAnYtwRZTzjmHPG3BSMW4+KqkKoLnI9CDFPOPaWd8O8diqquqmj8R6/LOFkmE87s5b
         uwLVT59wXfAkEojCH0+2ENv6RRIdd+VtC1N6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729196840; x=1729801640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0S5MPorG8STFHi4ZHKupmmCHSXBZxKErXkagXcshGng=;
        b=Pkn3PjTb+7xbiZ0v0UDkFbtKDb2AIem4IkySHtYCM4YUPdPiGfKTkvvG7SAhSoTfeX
         cPGO1MYaOlSOYYHJ04QPr+Z77cefMGv01FbrzOSwNcddxIzu11WMniSF+kkZgUnh5K7g
         RtKBRzo1kFQpKYaPGuiVDmshH0xDGXnfQDTWRM94QUC3lGVl9YHRSoQIXpOYB/pfEw9P
         N+IIcYZXTFHsQ7m+9fPS8Bxy2immgqbRy+U2Tv+P6Jsb/sq0OnsQmrXijoZdZMTY8iVH
         kLeyeu8Cv/mDOT6TUl3jX4tRfASlTlbL2Q+4DWwNR47mPHcIgBl3hMl2/UaR3beLuAHu
         ZCfA==
X-Forwarded-Encrypted: i=1; AJvYcCVodBbAmn4DxOU6MkpnYR2fOFK+py7LNqn2PFfV8SnxB/Qeh0WBmNh3C6SOKv0fU3vyZXPd1Wn/yV3vvw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzH9mFLiuY3aSESl27m06+rJn35IdA7YVuwYkorOQ3LRtAbQIH
	FfAEisRk83pOUP5jZ+PXg6+G5F+KPU8gH7J/l0P2SiOd5A5RykQOrBjyVC959ZE=
X-Google-Smtp-Source: AGHT+IGDaL6jHQzbs+8GZfOyqS4uzH8LkR/xzgp5DkEAqRKTqgwzskUM+ylwLNVAshxcMDeXjcSh1Q==
X-Received: by 2002:a05:6602:6007:b0:83a:b188:7a4d with SMTP id ca18e2360f4ac-83aba3054b7mr10651939f.0.1729196839721;
        Thu, 17 Oct 2024 13:27:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10c67b05sm41578173.157.2024.10.17.13.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 13:27:19 -0700 (PDT)
Message-ID: <878d5f26-ef05-44f4-93e8-01f66088c0cc@linuxfoundation.org>
Date: Thu, 17 Oct 2024 14:27:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] kunit: qemu_configs: add LoongArch config
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
 <20241014-kunit-loongarch-v1-2-1699b2ad6099@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241014-kunit-loongarch-v1-2-1699b2ad6099@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 10/14/24 05:36, Thomas Weißschuh wrote:
> Add a basic config to run kunit tests on LoongArch.
> This requires QEMU 9.1.0 or later for the necessary direct kernel boot
> support.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/kunit/qemu_configs/loongarch.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
> new file mode 100644
> index 0000000000000000000000000000000000000000..e7bb7c07819677dfdefac012821a732555813cae
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/loongarch.py

Missing SPDX-License-Identifier.

> @@ -0,0 +1,16 @@
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='loongarch',
> +			   kconfig='''
> +CONFIG_EFI_STUB=n
> +CONFIG_PCI_HOST_GENERIC=y
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +''',
> +			   qemu_arch='loongarch64',
> +			   kernel_path='arch/loongarch/boot/vmlinux.elf',
> +			   kernel_command_line='console=ttyS0',
> +			   extra_qemu_params=[
> +					   '-machine', 'virt',
> +					   '-cpu', 'max',])
> 

Please send v2 with all the reviewed by tags. If there
is a resend 3.4 and 4/4 in this series, send them.

thanks,
-- Shuah



