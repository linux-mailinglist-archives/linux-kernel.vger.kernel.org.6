Return-Path: <linux-kernel+bounces-313805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00E296AA08
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BB71F20CC9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C11EC013;
	Tue,  3 Sep 2024 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XMPpyzA/"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0B1EC002
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398688; cv=none; b=SXDISz6j/Zbxb3ta5Ulc/E5cN5w+j1qfotNfRaVKUtuD1cV0c3PVoZPXx291k4yM5OhU5hDyAhNBVTHLNTpfrHZ9f1DdzjeBgez3D59eeUzVMWHw5p9jhFo0ceKx768g3mAHzZru5b8z8lDUr+eJPOs6EBPA7gBOdrD77pycl04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398688; c=relaxed/simple;
	bh=5Y0EfzLXDTbgzAG1r4O3ziDUSqjx8unhEbyzQrV0/4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBblGk33snSZ6281RzGptLGu9In0paTrv7CxpFUROj+5G8XFRvmOlwiqIt1DVv3J5qg9N7qw3xb8WV+KtI81UHgZzhK6RxIeCNVz8+puw3OhL5MslA0vfqDcXbzgiXedXREfkZICenVQuUF2zdN6cc34f53bwd6AXmgwlQZ2wCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XMPpyzA/; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82521c46feaso253449939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725398685; x=1726003485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVCLBn12rNJQYK6IvDPibD8b2IIiRiXGWkQUmUgIuLA=;
        b=XMPpyzA/Mt0Yte5hE5ERT10jd4jx29F1idFtOwQ1a9eAHz0nEw0zKt/ZrpOv4/h3nm
         bWXt4qhs3kl1ZYEPEbSfnUkf0bBeZBCvD0xZ4Iu7IzREpLOTqdHahL8r3jJATXrgSzLm
         KBxlloZzMtuJR913bxC6hpb2u8TsrSKp1Neu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725398685; x=1726003485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVCLBn12rNJQYK6IvDPibD8b2IIiRiXGWkQUmUgIuLA=;
        b=m7KgKg643858sYNdwbFJ9s79tIWSpM+jYZn1FUpauyOUqvd50x07T+HsDNxD26/wBY
         PprqtX39IVgi8Cuj251jrgXRj2DqpsZG1sh55ZyvRT4O9Fl4ADS8XAJWNgf+NHG1yvBK
         YOfJtIvBs/Lt/0jiM73S0ecd4cAUqaR8Mo239nzsoem0yxdzwCIt7Y3i5gU/Tp9zVA7Q
         g/afMRpzN0V+AukXNtRsX8hzWHvpmRxXX6R7xoOPx1xIWkaAxH1z5uLJuQWdg2oLZ+O0
         L1T9RYDLWQ3rCZ4n3grp2xXCPlqimPB9Omz/d/mJmuKzKLkckeDUPK1u7yeTYul1qSIc
         XAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaldycy452hs0tGV7gQ5DxT87Mxejryw4NB9dmwW/GbO8vZ6InGt34BRX3ErCJ94OH+nnU9JSx7oseWd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9VJFB4pTIwkqJYC3hMO2LGd+IuekaUx+YqJSn1mjGqwwd6SM
	dt4ASMUL53fsS4SXqaVFa0/vBqwwD1DYXbL8tSIQc83vqjXVUnzZpzlbChUaLVw=
X-Google-Smtp-Source: AGHT+IHdA3J8imNuPn1PmrGvvcfBwCu+ZkptHHXmFQlcrLBo+gIjosUQW9ALClJl/O+WhrEXbTHk9Q==
X-Received: by 2002:a05:6e02:1606:b0:39b:28c0:9427 with SMTP id e9e14a558f8ab-39f4f68d790mr111347785ab.8.1725398685424;
        Tue, 03 Sep 2024 14:24:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afc4ff6sm33476515ab.37.2024.09.03.14.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 14:24:45 -0700 (PDT)
Message-ID: <1886e4a4-7c19-4a0f-9689-9edda970d508@linuxfoundation.org>
Date: Tue, 3 Sep 2024 15:24:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vDSO: support DT_GNU_HASH
To: Fangrui Song <maskray@google.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240815032614.2747224-1-maskray@google.com>
 <29c04b2f2b35588824447f4c91d3c89ed3ed8895.camel@xry111.site>
 <f9e2d443-9d20-498a-a2d7-fa2e13fbb3f9@linuxfoundation.org>
 <CAFP8O3JyU6HaHfrRSoSuqvKY3z50mOfwtoAvftFc2PG+2i5pKQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAFP8O3JyU6HaHfrRSoSuqvKY3z50mOfwtoAvftFc2PG+2i5pKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/27/24 07:37, Fangrui Song wrote:
> On Tue, Aug 27, 2024 at 10:12 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 8/26/24 00:07, Xi Ruoyao wrote:
>>> On Wed, 2024-08-14 at 20:26 -0700, Fangrui Song wrote:
>>>> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
>>>> obsoleted for more than one decade in many Linux distributions.
>>>>
>>>> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
>>>>
>>>> Signed-off-by: Fangrui Song <maskray@google.com>
>>>> ---
>>>
>>> Ping.
>>>
>>> Some context: I'd change LoongArch vDSO to use the toolchain default
>>> instead of forcing DT_HASH (note that LoongArch is launched decades
>>> after all major distros switched to DT_GNU_HASH), but without the
>>> selftest support we'll lose test coverage.
>>>
>>> And now ARM64 has already lost test coverage after commit 48f6430505c0.
>>>
>>
>> I am seeing several checkpatch errors - please fix them and send me v2.
>>
>> thanks,
>> -- Shuah
>>
> 
> The applicable change is:
> 
> --- i/tools/testing/selftests/vDSO/parse_vdso.c
> +++ w/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -177,7 +177,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
>          if (vdso_info.gnu_hash) {
>                  vdso_info.nbucket = vdso_info.gnu_hash[0];
>                  /* The bucket array is located after the header (4
> uint32) and the bloom
> -                  filter (size_t array of gnu_hash[2] elements). */
> +                * filter (size_t array of gnu_hash[2] elements). */
>                  vdso_info.bucket = vdso_info.gnu_hash + 4 +
>                                     sizeof(size_t) / 4 * vdso_info.gnu_hash[2];
>          } else {
> 
> 
> Other checkpatch.pl output is not actionable. `ELF(Sym) *sym` instead
> of `ELF(Sym) * sym` has the correct spacing (used in this file and
> elsewhere ElfW in the code base).
> 
> 

Okay. Send v2 with the actionable change.

thanks,
-- Shuah




