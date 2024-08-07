Return-Path: <linux-kernel+bounces-277817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C4F94A6DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38541C2087C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A81E4EEC;
	Wed,  7 Aug 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5dz570C"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F821DD39A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029701; cv=none; b=LKp7cUm+UVTu7FX4YI0n0/lLSfc6Tg4OaLu9KvVb2rc5+d4SFvQ0stFozHGcCnV81Ae7VWIETGyjlEyvOLYzVt8P3bF6BX81eATamrQmBvbYi5VfNhN/rdDKkTlJkubiCIIEHdAySIAxs0R/LVaUf1MecOxc5hieCIf4IhkM18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029701; c=relaxed/simple;
	bh=RwnvOquDPDvRt2YTqOQwvBD4CKdq5nos1b/qFHZUktI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clmmedNE255XreZxflVr2q7gRI4o/nub3pakARtbXMdpfYzh3/LHv4Z1A2l7HnBzajGphm+XYd5JKU8e4rbR0ugCRzAfmPfmetW7RAxRFcgz6BYWW+j1YqPzxWTFA7BUwsjheS8UsP+MlAYgw22yinAQV+m2WEMRRaauutSLA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5dz570C; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710afd56c99so606131b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723029699; x=1723634499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCdKYi3sPRP/qCDtPeI0jrPzv+sStSXrnyLa3zgQrYE=;
        b=g5dz570CCkWKhRXMZ8zSSR8RQqz/Fxi677Z4irj/XLhd13SwuP+Uuwidtge/Y0ZMZ4
         Hpp/aOk4RIye8knf4V0P72ds/CtOjBy7QUagMi1GFN3Fp5akbqfJytlFu4cAc6zCjY+1
         SO9uP5/yulaq7SciBxwDrHSb5BwLYDCdiHdMqgWR6dQRWGSho85cE+kIZ6PFzQCm0/nE
         gHlhiEqA0/eSCRYAUh3KvuyjDbnCEvQjcVDoBZx6fIdDpb6hhhv6WOLTJ6kdROPr9Njk
         eIyPYpc2t5u26nfX18Ad8u5QoWxhbpx1TmgR/3EUGERdScPvbjI7nUO0uavSohqEvJGI
         IA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723029699; x=1723634499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCdKYi3sPRP/qCDtPeI0jrPzv+sStSXrnyLa3zgQrYE=;
        b=KUiViJsC+f5RCGX3CymupTUTndbSnAxKKyEv1dvFzny8Hke4OtaDeUfmazMgTOG1cu
         3t4gIfZA46PoXvfWhAJFR4GOu/x5r13IzFVQo4L847rcXzx34m6JzdSl3bhTFlSDvScb
         xWuDQ7KHTomYt6cay1xp2By+Evs4YQ/PhR2b0mdpp4KPlNniMeU4TlNZ019tGTFGRJeP
         FRLmtJvfYmgYtRrKjKWGMs11Awv8SATqIL97ks5cb71jFMNjFSRvNQLOzk6MV3l7AKT9
         EgvBiZTTRB9kmyhP/u9Qfj16CRyqGx4RQu/oVtPNxIHmmo0N6/ResIVf9f1DoPFXj2kW
         z7XA==
X-Forwarded-Encrypted: i=1; AJvYcCVrygZPmSxM9Oz+5annGP2SXRv+1+Za1ODWr/+CXLalmiCLJ5AOrJRy1ZMlI88Tst5Tx1RdwkHlu18MrL6q8Mo1xEqeZqdqNMPprA+h
X-Gm-Message-State: AOJu0Yzg2DaM0k3MdTuwlI3gBP+yuOFlwbyMrXF6J169uhXM5O7gylTx
	4ef7ztvzXdFs6w98vT195785toUcQJagS8o7t5lFG6B5vvMbH47A
X-Google-Smtp-Source: AGHT+IE9r01eb1u8VuWM7MLKYhRuXu4g/wcvInqH0qlb4SQBnh5CYU/6R23kTg1X8d86iB4+fWuTiQ==
X-Received: by 2002:a05:6a00:3c86:b0:70e:98e2:c76e with SMTP id d2e1a72fcca58-710bc8393e5mr3244568b3a.6.1723029698828;
        Wed, 07 Aug 2024 04:21:38 -0700 (PDT)
Received: from [192.168.10.4] ([43.224.156.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f2acsm7021172a12.3.2024.08.07.04.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 04:21:38 -0700 (PDT)
Message-ID: <0c725174-d67d-47f2-bd4b-29af8b8d6b1c@gmail.com>
Date: Wed, 7 Aug 2024 16:51:34 +0530
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
To: Arnd Bergmann <arnd@arndb.de>, Yuntao Liu <liuyuntao12@huawei.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Russell King <rmk+kernel@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>,
 harith.g@alifsemi.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
 <acc20caa-79b1-4174-98e5-97a651012685@app.fastmail.com>
From: Harith George <mail2hgg@gmail.com>
In-Reply-To: <acc20caa-79b1-4174-98e5-97a651012685@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07-08-2024 15:40, Arnd Bergmann wrote:
> Obviously 'ld' should not segfault, so there is at least one bug
> there, possibly also a kernel bug that triggered this. Can you
> try with newer binutils? This should hopefully either solve your
> problem or produce a more useful error message if there is still a
> kernel problem.
> 
> Any of the binary toolchains below should work in general,
> the latest one is the gcc-14.2/binutils-2.43 version I uploaded
> to kernel.org the other day.

So, I tested with 3 more gcc builds.

gcc14.2 (x86_64-gcc-14.2.0-nolibc-arm-linux-gnueabi.tar.xz) and gcc9.5 
(x86_64-gcc-9.5.0-nolibc-arm-linux-gnueabi.tar.xz) from 
https://mirrors.edge.kernel.org/pub/tools/crosstool/index.html
works and in both these ld does not segfault and build completes.

But gcc9.3 (armv7-eabihf--musl--stable-2020.08-1.tar.bz2) from 
(https://toolchains.bootlin.com/releases_armv7-eabihf.html) resulted in 
the same LD segfault below.

+ arm-buildroot-linux-musleabihf-ld -EL -z noexecstack --no-undefined -X 
--pic-veneer -z norelro --build-id=sha1 --orphan-handling=warn 
--script=./arch/arm/kernel/vmlinux.lds --strip-debug -o .tmp_vmlinux1 
--whole-archive vmlinux.a init/version-timestamp.o --no-whole-archive 
--start-group arch/arm/lib/lib.a lib/lib.a --end-group 
.tmp_vmlinux0.kallsyms.o
scripts/link-vmlinux.sh: line 49: 3802905 Segmentation fault      ${ld} 
${ldflags} -o ${output} ${wl}--whole-archive ${objs} 
${wl}--no-whole-archive ${wl}--start-group ${libs} ${wl}--end-group 
${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 139
make[1]: *** [/home/amol/hgg/mainline/linux/Makefile:1156: vmlinux] Error 2


Thanks,
Warm Regards,
Harith


