Return-Path: <linux-kernel+bounces-209810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5EE903B32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FDE288FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669417C20A;
	Tue, 11 Jun 2024 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEug2285"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDE17B514
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106865; cv=none; b=Ob+GqYyExlN0y/XF8UhkK4Mf2daRQiQq/7Molb5TDCliRPuYOQsyQA6/UjKtBdLKoN8igcZCfko1T5z4iLZC+3tILlY/urcXl/9b8RtoKX+BnvXW9jJibXXhuT0hbpfI5jxE28MpwZhGGGGDYpbsKN/aCBJRRAL4ND/rALI5sAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106865; c=relaxed/simple;
	bh=TPskSCV1ByN6PwkEkrDCakDuKheDqbde4+cyZylMKeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDpzZEmaOIDwkQbmsoL9Xw11OsyAnhEbJprINlnZa6Ce1YmMSKd28eUze1bamfyIKcipjdHxQcfdQGAnuXp3eX1UVZSz4piYPomiOxPAc28whyfUKQG/kCmbQpR6FXiarBH2GMFRIMVE8MhvRBrTeHcmO8NQbFp3Ot1yXbxgKts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xEug2285; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f09b457fdso266705366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718106862; x=1718711662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUpzl6wit0+FDgfySZXvlg7FvtOLZgcqhU3pCudAFIc=;
        b=xEug2285HymjnQsfp7xJ7L8rTWI7csVRr1/GI5GmL/+LojWsIWqEB/+sEO3+aBzwJG
         ZEg18GhOgI0vswfzKOH5xpXLlGrq6uORv8l+GVpB6EVYDzFmFrAUvieqj4p1/9+npyD4
         qapxsbI9HwyjWjZsEP16jiPGfIhYHwSkAYl8qbevo9JPKkb8f0ArpxrM1ACsx/DGHdzY
         G1fAZGVCBS66zW2iyV7m06JMKDEyiUT9A/czfUzNkYMBhRSADotNIiYJzsv4/AOnIXDM
         IxKGk3l59DZzniy/NSJv+SJZNIfWmA5xm2F1tpdqnGePM1vPE+sAn7BlqrJ2332+jZF+
         +ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106862; x=1718711662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUpzl6wit0+FDgfySZXvlg7FvtOLZgcqhU3pCudAFIc=;
        b=o29VFTi9s8imdcWLiACgEvZn+uUs0EIDlVhzOqId35P1u2DNtW8PzxGkOrCnQSLfWn
         AmbvneN4YEB6DdrNpqhWOKPQkX952Cou9l4JbBzB/FCb9V6smPQpjYExQELPG+GXuFSN
         eUdX12/m84P5u5pks2ieUJYTavU7fgGtp4wyfNvAVJb9J6x7ZvjCADJmOIBKdK6NPv/D
         r3l6fzSLkWfS4qjoLEKChBO0pc3nQUp1CyWciUe8a6uyW3N0W/yMocJQ1NFQg/q2KD6V
         F+Hl812XIF0XHQUJ6j0wQ0kf019M1JgtDKf4yZtYvPDC15S0LilBhWSNxjB0IxLO1NR9
         jDtw==
X-Forwarded-Encrypted: i=1; AJvYcCUEGMWHDVL0sBnc+iJR1KAx9/cNxydwedOrh0mwjPcOKw5UYqFdN1y/7/wwEysKCkU7xulVDtKa47HUka+EbA162E43uSrtimTa/2Ni
X-Gm-Message-State: AOJu0Yz+T3cAz87lvTRLK4rbf3JZID6mD6Wn5+Gf0ue5LOJFP93+rV0+
	O/GK7izvdmEDBDNyqkAyD2tVrOLEWQDDz3Jsmf3519n7y2pF1OxnZWgRwyMlQ5Y=
X-Google-Smtp-Source: AGHT+IH5LvLNYVJ1vtJY2LPpr/3oSUYfVlUUAbWo90Ke7DbNTiGbM8niRjZiJ5XYcOsq9yELzeB5nQ==
X-Received: by 2002:a17:906:579a:b0:a6f:16c7:9130 with SMTP id a640c23a62f3a-a6f16c79640mr368006266b.28.1718106862182;
        Tue, 11 Jun 2024 04:54:22 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6f2706d8ebsm180513766b.114.2024.06.11.04.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 04:54:21 -0700 (PDT)
Message-ID: <9518804b-a231-40db-82ae-5f8a44edf88f@linaro.org>
Date: Tue, 11 Jun 2024 12:54:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add missing fixes to FastRPC driver
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
References: <20240611103442.27198-1-quic_ekangupt@quicinc.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240611103442.27198-1-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for Patches,

Please send the patches in correct order, fixes will follow enhancements.



--srini

On 11/06/2024 11:34, Ekansh Gupta wrote:
> This patch series adds the listed bug fixes that have been missing
> in upstream fastRPC driver.
> - Fix DSP capabilities request.
> - Fix issues in audio daemon attach operation.
> - Restrict untrusted app to attach to privilegeded PD.
> 
> Changes in v2:
> - Added separate patch to add newlines in dev_err.
> - Added a bug fix in fastrpc capability function.
> - Added a new patch to save and restore interrupted context.
> - Fixed config dependency for PDR support.
> 
> Changes in v3:
> - Dropped interrupted context patch.
> - Splitted few of the bug fix patches.
> - Added Fixes tag wherever applicable.
> - Updated proper commit message for few of the patches.
> 
> Changes in v4:
> - Dropped untrusted process and system unsigned PD patches.
> - Updated proper commit message for few of the patches.
> - Splitted patches in more meaningful way.
> - Added helped functions for fastrpc_req_mmap.
> 
> Changes in v5:
> - Dropped PDR patch. It will be shared in a separate patch series.
> - Dropped fastrpc_req_mmap and remote_heap specific changes from this
>    series. These patches will be shared separately as a new patch series.
> - Changed patch series subject as this series is no longer carrying any
>    new feature changes.
> 
> Ekansh Gupta (7):
>    misc: fastrpc: Add missing dev_err newlines
>    misc: fastrpc: Fix DSP capabilities request
>    misc: fastrpc: Copy the complete capability structure to user
>    misc: fastrpc: Avoid updating PD type for capability request
>    misc: fastrpc: Fix memory leak in audio daemon attach operation
>    misc: fastrpc: Fix ownership reassignment of remote heap
>    misc: fastrpc: Restrict untrusted app to attach to privileged PD
> 
>   drivers/misc/fastrpc.c      | 51 +++++++++++++++++++++++++++----------
>   include/uapi/misc/fastrpc.h |  3 +++
>   2 files changed, 40 insertions(+), 14 deletions(-)
> 

