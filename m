Return-Path: <linux-kernel+bounces-267742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AE59414F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A551C20A15
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FFF1A2573;
	Tue, 30 Jul 2024 14:59:27 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791EE188CA5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351567; cv=none; b=T0zVz+gm4/foSnJ/lqfFQ8qIHBlWdV7TvlxxChg1pLe4Iyd/HMsT+8o4w89r9UVZQpOonTInqBv/5xquowQTte03ICSgtZu4mwXpaFy6zhtyY1f7zmyAy/jtv2Zr6DZniDA8OQ6Nu8zRVZBjXxCGNF60ybbQUt8SH5HsGSKzv9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351567; c=relaxed/simple;
	bh=tbPxI0Kty8tEmLVLppSue3V2MjQ4KE4rXfIJq4dQ42s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwkbjtSb8PMowpNQplsEXNhHvimI8ITKU92q9lvOcw2eFZOQWAMe8/m5CxEmL6Dpux5afsTLjEj59NJI9IJNOe+esPUMgexEUgXQj13QitvT3hY8uuQ0+Z6fF3FT3lsBace0C2DI9WmYmzRJNjUDLTIzuXKjC8FayRGi9v7Mw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.126.21])
	by gateway (Coremail) with SMTP id _____8CxOurK_6hmOI4EAA--.16100S3;
	Tue, 30 Jul 2024 22:59:22 +0800 (CST)
Received: from [192.168.0.108] (unknown [36.44.126.21])
	by front1 (Coremail) with SMTP id qMiowMDxucXK_6hmj8MGAA--.33683S3;
	Tue, 30 Jul 2024 22:59:22 +0800 (CST)
Message-ID: <6db87355-ff1a-71f3-9bbd-5c47edaf3128@loongson.cn>
Date: Tue, 30 Jul 2024 22:59:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] objtool/LoongArch: Restrict stack operation
 instruction
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240730061901.21485-1-yangtiezhu@loongson.cn>
 <20240730061901.21485-2-yangtiezhu@loongson.cn>
 <CAAhV-H5qoaBwJe929+GnYzbrbmcMgTXy5zL8smXDmOSCtAQntw@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <CAAhV-H5qoaBwJe929+GnYzbrbmcMgTXy5zL8smXDmOSCtAQntw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMDxucXK_6hmj8MGAA--.33683S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
	AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2nYFDUUUU

On 7/30/24 16:59, Huacai Chen wrote:
> Hi, Tiezhu,
> 
> Can this patch also fix the warnings of ClangBuiltLinux?

For now, objtool is only built with GCC, I will try to build with
Clang after the known issues are solved.

Thanks,
Tiezhu


