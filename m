Return-Path: <linux-kernel+bounces-393565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6BE9BA266
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12C21C2216F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3D1AA7AB;
	Sat,  2 Nov 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ngsqHqKa"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104354EB50
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730578615; cv=none; b=Mq6lG3PgaGNM2xrqSqXyZob/yNPRA58sMxFs7ATzqjNKvscjy4eWO9H4g+l9LjQEeOS28p/9XvqeBz8kn+vDAW7bDcBIpvHRWHuKrR+2zGhPNOPhSPYbB0FV7UMjjidnkIAyVD4X5WsxeZiEL3VdaywjRe1/ODLU/5gubCfLPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730578615; c=relaxed/simple;
	bh=fNUEyevbI6VLnGpzfI1HHZkT9gshIAU2rw1DWgFu3WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4MRQViADw3eSPzhS88RIvtC8Hc8DRwERNi5pZnQu6Ozy1sQghCE8m6urH+n+Wp5DWg5YzlYdBQnhQgqyjFUg3kyrIaYWbXUxzOBomPoMDYeCBoB8bLrZwA5kQ6gGZLrvMkw6fJiGG6qTvMu0QflU2M3oYotVCNw2WQ+wUMl3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ngsqHqKa; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83abe7fc77eso122605039f.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730578613; x=1731183413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfwK4sEdTx9F/aBDurQK3UATh0DRHqT2tqgZLd5JDpc=;
        b=ngsqHqKaxqX12PU2ibSfFyXOh/uMiJnu2MDsLSTNpvWdh+RrHO9zdUTazdesPoHkzc
         eGuiPV6USLfR4ZuSumm0jpgYMY9Ydh6C6Ls+ozK9Y0YR5EMppqSg7s5C5epEjK6F6wvn
         /psU07cV6r/Dwr1U/TaoMCTygXul5Nsd02OSduSyvdNJYcMRX6unF7nrc4DTq0IqOOjF
         1s3ywQbwtDLPwUojMiJpAFEend4yNmSXPpEhqPqlhReGz1sNPlHx9PCNz7r0ac23Gzkr
         yeNd3gn9JyTE0Owvy7oNwGbrQuG9NSP2I91uvPjU11wLinF29zEvfv09WTr4+GvycMts
         XPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730578613; x=1731183413;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfwK4sEdTx9F/aBDurQK3UATh0DRHqT2tqgZLd5JDpc=;
        b=f8mh/9udjSIGDuVFtyemRSXpOpJNwVy7JU11zRHS3/yqthyq96urD5JR/WLcvpaTD2
         4So9DzA+NfFX9LfyZ67DLmMOv6GRHwAhQHvj6qLEjI+JWz63L+uth9lIsqwwM5CoHKXH
         vg2fmIoFQN4MTB7gtk3aklkZnxMchF3cy0JvIlgsP/n1DuK2jAZy8W2uMfTpYWF7gx9R
         SWSH0+H1A0KB/Dd4ZtHizlzVztf7ZOtObYK4Mvhxb5EzQnye8xnbZXk7t67jDoad3+SI
         ibtsUL9kgTiB2XdKYLmlmhftpY0s7qyABM3X9saltfziaJe33scBGYVVLc+MFwEGFcgq
         +ErA==
X-Forwarded-Encrypted: i=1; AJvYcCXZjuxYDS2VXEe6Bgy/1txodQEAkKfq/Nmb7n6BfyLr4mND5x79f+mTs0/B9i/yrLWS3FxpEdFLhfOILJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbn7LUD84DLtFdSaWRXwUqiVLeCKpTpnPqDIotn7ogOy1GtDOM
	+ErHn9WWeokbliJ7Q04vg6ifTUxLk5aLyv3UNdW6Gv/GX/27Ecrn5gRj1DERi10=
X-Google-Smtp-Source: AGHT+IHxkCjpiwvEUT4o38BUaI3lSwIPU5kBEbJUiHJaWVt4Bg1m1dEkBKxTOmT48n1sycp0+0I3CQ==
X-Received: by 2002:a05:6e02:52e:b0:3a5:e3bc:c1bf with SMTP id e9e14a558f8ab-3a5e3bcc3ddmr127637225ab.23.1730578613043;
        Sat, 02 Nov 2024 13:16:53 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6a97cf520sm14786615ab.25.2024.11.02.13.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 13:16:52 -0700 (PDT)
Message-ID: <43f05f71-71f7-4073-ae3b-5f5fa35ad2b8@sifive.com>
Date: Sat, 2 Nov 2024 15:16:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] RISC-V: clarify what some RISCV_ISA* config
 options do
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, xiao.w.wang@intel.com,
 Andrew Jones <ajones@ventanamicro.com>, pulehui@huawei.com,
 Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
 Pu Lehui <pulehui@huaweicloud.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
References: <20241024-aspire-rectify-9982da6943e5@spud>
 <20241024-overdue-slogan-0b0f69d3da91@spud>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20241024-overdue-slogan-0b0f69d3da91@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-10-24 5:19 AM, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> During some discussion on IRC yesterday and on Pu's bpf patch [1]
> I noticed that these RISCV_ISA* Kconfig options are not really clear
> about their implications. Many of these options have no impact on what
> userspace is allowed to do, for example an application can use Zbb
> regardless of whether or not the kernel does. Change the help text to
> try and clarify whether or not an option affects just the kernel, or
> also userspace. None of these options actually control whether or not an
> extension is detected dynamically as that's done regardless of Kconfig
> options, so drop any text that implies the option is required for
> dynamic detection, rewording them as "do x when y is detected".
> 
> Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c554f75a676c@spud/ [1]
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/Kconfig | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


