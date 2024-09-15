Return-Path: <linux-kernel+bounces-329716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1189794E8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C4028285F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96E71B59A;
	Sun, 15 Sep 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="nZYfpv0O"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199BC8BF0
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726383314; cv=none; b=vA4NDVAtgJdgS+q/78NeR3GKJuiz4r5POp+WzcrERV0vMMn7FH5lxG0BeZ9TypqA63ZHW54TSVOaFFgfr6vezZuMHZh9tCrRuMNBZrykEJUjcp/jsx8j4LCScx/+WJlp5iw1bLwDLitRYmFrckereGfaaiWn/8SWlckaOpt099w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726383314; c=relaxed/simple;
	bh=UGD8FmToycF4xnTxe8+Q6LU5Uz9q/aHgkrfiB5aJ18U=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=JdnlvYumxl/UbgXIzeDMSgxvMilbFfGbZH5k8pFSNJSdBZfFV7Vvp+aqAfzxqlVjpHLYiDLNQ3BXls6Llq/J3fHvnhVvLta3P38eelBdKt/2cfVgSP/I5HaRGKwLbhcKV0z8Pdb3hrl7QuLuiV4lHVnOQZJM/gf+P2i9lBcDgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=nZYfpv0O; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db0fb03df5so2666634a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726383311; x=1726988111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=badvYfFNP1rbRc7ngSF4RqGpw3ma3l0TsCCk3hbSSxo=;
        b=nZYfpv0O7f/R60pBzPOPpHAFMt44q6aiJerrYAGzC+L6x7Pw8C6ZZ1w83ygh39zq2N
         xSERAulYwwmt+orPytbqfzHa/xi0kA5zKsys5GRFqx3+5ospbk1qI0I5Vdy3+MeexXgo
         k7W6kjT7+amyXz3yX3NfCQIC9bivNNVOX0B30q8BGnZ792oPnxWlLRyihRkFcTM/eMBW
         EOIAZee1qoW58GxJOEfYCWHFT1RYe+WDHJ0MAqrJRS/8LE1bvvWEwu0WppJCpiEMSDlC
         ZpDkHXldIoQb3NFz6e7XDcur0Y6B7kYgAOXdtdqAIF44zF9xLL9w6OvzLOUg51E1O6Eg
         lBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726383311; x=1726988111;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=badvYfFNP1rbRc7ngSF4RqGpw3ma3l0TsCCk3hbSSxo=;
        b=DoDe5SLv30HZTIrj8dNBG4eVN1VuULQ8W+CQ0WZDBZQZ3Nzc45bJbY4u50eFYF5U3n
         JBi0367k4Te/SVz+9ZUftD5y9cCYWQ8PJvj7gDFD/dMz5biN7oIjKhl0DrhHmuP5jiUQ
         nEbrEhQWNmtrcp5R6YvFZaWb5aT3Mm/g6mnmNtRvMZ6nLf9dX6uqVCB2B6OMEJMfRQTA
         YpJ+K977YBdMP+a/mz98Td5qGFIGZEFryXq6lWYjIxWmdapATKciPPkObHcnYshKEJ9M
         45esNciel65kpHHOK3PgDxwO8HNBX3gw2VRmCvwEbw6VvW50FHDCAfGXMZc92jZJHybf
         NfZg==
X-Forwarded-Encrypted: i=1; AJvYcCXrklJT3/yNg2nwbjRq8cEmWUgzK2v+pshd7BuH77cu+XCdRaYgObAsDnGfJTJsjYrsuMt6n1oxFlHPdYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmVOBSilsVNQZAU1i1lUSjFgZYEnaTZxzORqn1yrDQWZPqFzsk
	jyI2TwkVPZsBSGjXx9aZlSnyFK+4OAplXiSjQqZ8xSsv0ZTvBzyPqVzJe84cvb4=
X-Google-Smtp-Source: AGHT+IETA6Z4D3JR59UejDAMZ1frEAeYjfn/w/Cvh8koJDcKyPO/lIAoIqsnGxccs4z27UspzeCEyg==
X-Received: by 2002:a17:90a:6c96:b0:2d8:eba2:ac6e with SMTP id 98e67ed59e1d1-2dba003b576mr15824006a91.29.1726383310916;
        Sat, 14 Sep 2024 23:55:10 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-c000-190a-3ae2-f6af-1d55-9e32.ipv6.o2.cz. [2a00:1028:c000:190a:3ae2:f6af:1d55:9e32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c4a253sm4768129a91.4.2024.09.14.23.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:55:10 -0700 (PDT)
Date: Sat, 14 Sep 2024 23:55:10 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2024 23:55:00 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: define ILLEGAL_POINTER_VALUE for 64bit
In-Reply-To: <ZoiUwsFIHcteBSms@xhacker>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: jszhang@kernel.org
Message-ID: <mhng-97d5d590-cf1e-43a3-bd93-337840a0cac8@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 05 Jul 2024 17:50:10 PDT (-0700), jszhang@kernel.org wrote:
> On Sat, Jul 06, 2024 at 01:02:10AM +0800, Jisheng Zhang wrote:
>> This is used in poison.h for poison pointer offset. Based on current
>> SV39, SV48 and SV57 vm layout, 0xdead000000000000 is a proper value
>> that is not mappable, this can avoid potentially turning an oops to
>> an expolit.
>
> Maybe I also need to cc stable? This is a secure hole fix patch.

Ya, and I guess it's just been broken forever?  I stuck a

Fixes: fbe934d69eb7 ("RISC-V: Build Infrastructure")

it should show up on for-next, assuming the tests pass...

>
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>
>> Since v1:
>>  - fix typo:s/SV59/SV57
>>
>>  arch/riscv/Kconfig | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index c51b32a8ddff..c992eabbd002 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -313,6 +313,11 @@ config GENERIC_HWEIGHT
>>  config FIX_EARLYCON_MEM
>>  	def_bool MMU
>>
>> +config ILLEGAL_POINTER_VALUE
>> +	hex
>> +	default 0 if 32BIT
>> +	default 0xdead000000000000 if 64BIT
>> +
>>  config PGTABLE_LEVELS
>>  	int
>>  	default 5 if 64BIT
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

