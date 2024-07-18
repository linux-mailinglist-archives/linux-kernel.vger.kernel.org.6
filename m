Return-Path: <linux-kernel+bounces-256781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D9C937022
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75444281976
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B5E14375A;
	Thu, 18 Jul 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MfxcetQw"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CCD75808
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338483; cv=none; b=hZDccll9o/yywUiMSVZV5HZWFnAaFzdVacG20ZZkHjYgXGEY4RHfzVj2sy/j3Mof9VDg2HjKOoRHFxsIrcxq1nJBks7Me9zjAJOzCndK0dxVXKy+vNAgNs+N7XFPVWXKwFHm95Km98HZfYr9a5OBbKBAnmIrji5w1ueDzjP+hlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338483; c=relaxed/simple;
	bh=4KCBrR/1FAbkFN9EuBapxHz7zR2ybB/HYnvsQhM6krw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgaK+6jcVGoOkzMzDBMhnAq+hYZ3/rKWEfz9XYNPAO/Ebk+9iPIBuFnELeCh9qpzfno/V9nJ/iEtW7dzBh4DUGPxDpyFVn/k+cXvj1U3tvJrmU7Ba25+v/dKJGu8XaOsAlUL0E2ZzAMquVYMYyUn3UKRyvitYEUWR6Iy0FTOg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MfxcetQw; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8152f0c63c1so47712539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721338481; x=1721943281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUtCKtIzqGuY0q5cwXIOFhLdAMxypBe1qmgcMDT+NXI=;
        b=MfxcetQwC/qGAr4NEpF8qEEpvBOGIvUQZVIouDsa3pkxAnFfqg+PGhS1lLdSQO9Qdx
         YBsHx1i71tgkFpM8yw+y4Va1PGhItXABAOElE8NnDWLat/V8D9+J5jHH5unwDn36vPQ7
         QDFvRTZMNGkWYQzh9ZvegDJc6zu5hDE8NaakxwyZFo3VgyO0w4zvv5pom9PUL/NOemzw
         C9Pqf0XYM1P225a+2lJ9haO4u8GbHrRujUqg1ate9sokpheMY4aTLVYufUFRzK5xaNe6
         E3ZI8m9SWDDgXI/OOQZBOJpKrsri4QdYfds98SfnHH0a6gF03nPKaMtLkteNfQmTQf6k
         C3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721338481; x=1721943281;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUtCKtIzqGuY0q5cwXIOFhLdAMxypBe1qmgcMDT+NXI=;
        b=DcNSB46xj7WHjntu5htsbMciqHBKK/a5Oi3ES36Kg3bu8LBpIR11PAAdEhSwcqi+zP
         HmJ0C6WYabFGULvSTUtatXAnlz3W3eo0pFDHEmSik7irkigSSJNLw65e/VRNx3vHHjOC
         1yWav7xwlvrXCDow/yBX+bthKqxpaBlDsBjzXhIStKaUdhiHC/O2mdIuf439WUb9WPJ5
         WY4l19B/oPP91aaaJV0n3Kp7eE8Es47goF8aaPHARvOabLdUAau7+Q4FXr4I8f1DfiIO
         HAqkkvuuLsn+rFvxjOft9+22Xto85NsVNZREO00L4eiiDJSgX23raUez+13NOjppqt9U
         dKVg==
X-Forwarded-Encrypted: i=1; AJvYcCWqfZ+zunBgEj5WzIhZSIoYHPgNOwlZxbIbQpc9m+v2G0+5yNb/ku7Std0zf6XTyNSgo1MhykQN5rgEf8ayg2gfPVv7XpuovmFE2fa2
X-Gm-Message-State: AOJu0YyG93i2VuuWiSkLHn2W2VoZcXZRDrVww5HTaoUFXRa2Sraw5s0x
	QkxS/kLP/FUe0GudL9o9bX6nxl0/4nVDBrLxNv9FvwHK78EP9N0n6NK3mgxgJAs=
X-Google-Smtp-Source: AGHT+IGlIiHvpq47W3PGwq6TDOaf2pcHH3RyIU5b5agJJADcI2hIKDn1U46oKogXvzuHTqteosSwEg==
X-Received: by 2002:a05:6602:1503:b0:7f9:217c:c109 with SMTP id ca18e2360f4ac-81710bd3fe7mr956517739f.9.1721338481365;
        Thu, 18 Jul 2024 14:34:41 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-819aba121f9sm3552839f.6.2024.07.18.14.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 14:34:40 -0700 (PDT)
Message-ID: <75ba30e5-3371-4ca9-9dbd-af7f78907c30@sifive.com>
Date: Thu, 18 Jul 2024 16:34:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: cpufeature: Do not drop Linux-internal
 extensions
To: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Andrew Jones
 <ajones@ventanamicro.com>, Andy Chiu <andy.chiu@sifive.com>,
 Charlie Jenkins <charlie@rivosinc.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Conor Dooley <conor@kernel.org>,
 Evan Green <evan@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-kernel@vger.kernel.org
References: <20240718213011.2600150-1-samuel.holland@sifive.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240718213011.2600150-1-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-18 4:29 PM, Samuel Holland wrote:
> The Linux-internal Xlinuxenvcfg ISA extension is omitted from the
> riscv_isa_ext array because it has no DT binding and should not appear
> in /proc/cpuinfo. The logic added in commit 625034abd52a ("riscv: add
> ISA extensions validation callback") assumes all extensions are included
> in riscv_isa_ext, and so riscv_resolve_isa() wrongly drops Xlinuxenvcfg
> from the final ISA string. Instead, accept such Linux-internal ISA
> extensions as if they have no validation callback.
> 
> Fixes: 625034abd52a ("riscv: add ISA extensions validation callback")

Apologies for the incorrect subject line. This fixes a commit in for-next, so
this patch is targeting for-next.

> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  arch/riscv/kernel/cpufeature.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)


