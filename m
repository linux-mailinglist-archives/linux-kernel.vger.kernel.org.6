Return-Path: <linux-kernel+bounces-438076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3AF9E9C7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83F41887B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78B1547E2;
	Mon,  9 Dec 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="UFAplIny"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0C1552E4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763709; cv=none; b=tbTUbpXlyBTYqPYl01rSzvuebeiHa0vj/JhnesW6jAawpZGjXdyZm53byXgf4dQqWy0nRsOx6HdpYswjo7emYTSCXbMb2OHU1G+ceum1Kahy4S1UGVSLRH4Yzv6bx4sj8WPfipaVp++HLAbDQ4RyNntzgDkwOqZnCXRV9BSwh7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763709; c=relaxed/simple;
	bh=i928oX/mpne3k+HYSwPwJdb5jtaB69wVPcl0yRy8D+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2vFEj3eW2H+8SPX5c0KeIGZY4ccyXgiwFJR17f/pnm/+vt9hqTXNK5dSmSj1l1/l7JhbDwknK+nzdXP8futsHM3raaRxq5aTQpjz1LtGn6ibD9K8fijiCrj1w7egNBfLjnF9a0rVzB00BHi2GGZyns7TERIuNs6TJRSruhh2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=UFAplIny; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa689a37dd4so225662766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733763706; x=1734368506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWY3t5+dr0QM3b3J+VJ0zV+Hq69sDwu812ujN+kk1Ho=;
        b=UFAplInysOZrVH9y3MIXxl+euWc9+Glq9kJcDSWLYhZSN/4lEqYhcinjBbuifzsD/s
         stoUe3XBCpRirAHM7UGvIqMggnzgYDKOjGu4BWILviYnUMgLjDTAbCYtRPP6ZrtXxNsg
         oJuLJzgaeYnd/0WID0gouwnta024gAHJxuLyNvbGYBezGVn9C/EjGzlQX4nOmXXf0VR3
         6kTlDMMcqFv5Gc6nNM0iF3CGBaEWlbgN/X2oby6vHLXKa/7zi9Mm+jWrOpe3TtKyqMCD
         vOkEd8jHCIWplnHOM5JrsZyqMrbGE7eVGuVw4aRIgDYPuv3lzNGCczFU/5HLAw+RZwIM
         kPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763706; x=1734368506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWY3t5+dr0QM3b3J+VJ0zV+Hq69sDwu812ujN+kk1Ho=;
        b=FVHZukDlo9+oxOmhkxv9EXITx5G76/+YHfjWmlfU1yIfV6FqBopw4+3xIYdhTWBLvK
         o+vKugiL63P672F1AX3fnDUN/DBWgkquXRIRiMvL4UUKwaKQE91pib4MMoCEeW43iMj3
         XflsTPHoppLRHrbeL7wYl0mG2HV2wweMj95X56L/v4XeKiUkVj31NRB6KImDOvBf8O04
         WPbZ8+ljojg0QXXPm8VDV5/2qWCN0C2NczO596pTHK3c+6qykMvAZSvtcYii/XFhzlv1
         1vy5oCRRZFpoLFyzP0Vb4Wa/+/5nW0ZN+a1aX0XaUzkME/Qek4GdJ5lJksP6SVmn4SXd
         tkuw==
X-Forwarded-Encrypted: i=1; AJvYcCVArVGSbJ0DvmGowyET6pjOjs+cDvFNRc14NhWpDjcsc3xxkHJi29yNC2fDOeh+Qy3HAEYj7Fh514AJsc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ssfqkdyRvxFu4LcyEBtmb2XWZc4gX6vYq4MxRCSoMP1Rle2O
	v/h0Q1WBChR9wKlAjqH6XIaZzIJm2DxnljBofBR/J9pgjWHgsd9ReHQ2bkCi1FU=
X-Gm-Gg: ASbGncuIY3/YX+2H9Af3CHjU0WHESh09LYiy3Adsv0+knzxuKs+qdzBxkZTXyBCIRlO
	fLd2QC0jCAYecYd576hzHWLD0WzSKa5IH8yN42kq9Sm/HIniKh/I8PvCvT52tFdRzOv8kRTMx5q
	WKAz1N8NkHihEzyfHO6A4IPPuqP8BowXZjZfYprQ+4irWJCuVLdGsqCwMMd7V7+Ijy6sJjNZkmV
	3YfDr02gK93qT4x5AIxdiZdZ1m6eVjcsCjmCFLBWCMe9xXyV40bClpdFiO9UB70
X-Google-Smtp-Source: AGHT+IFgCY0LV0E2i86E6uIyabSZKNK/6D6PE02hwvn//+8qGUtJWg0NJ0RhDHb5UusO5237JV3OiA==
X-Received: by 2002:a17:907:9557:b0:aa6:34b0:5c73 with SMTP id a640c23a62f3a-aa69cd53746mr135583666b.30.1733763706154;
        Mon, 09 Dec 2024 09:01:46 -0800 (PST)
Received: from [192.168.1.12] ([87.13.127.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683de38fesm209821366b.108.2024.12.09.09.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 09:01:45 -0800 (PST)
Message-ID: <ca871055-0b4c-4380-8f32-a4a7152345c6@isovalent.com>
Date: Mon, 9 Dec 2024 18:01:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Probe for ISA v4 instruction set
 extension
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241209102644.29880-1-simone.magnani@isovalent.com>
 <20241209145439.336362-1-simone.magnani@isovalent.com>
 <11d588c2-febe-46c4-ab49-8fb0ed80faac@kernel.org>
Content-Language: en-US
From: Simone Magnani <simone.magnani@isovalent.com>
In-Reply-To: <11d588c2-febe-46c4-ab49-8fb0ed80faac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/24 16:20, Quentin Monnet wrote:
> Looking again at the probe itself, does the second instruction serve any
> practical purpose here? Don't you just need to test the BPF_JMP32_A?
> 
> Looks good otherwise, thank you!
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>

I wanted to keep probes similar to the previous ones (especially v3
and v2), despite we never check their return codes. This means
having as 4th instruction `BPF_MOV64_IMM(BPF_REG_0, 1)`. However,
to do so, I also need the 2nd instruction, otherwise I'd hit an
`Invalid Argument` error while calling `bpf_prog_load()`: I think
that would be due to the fact that no execution paths would
execute that instruction otherwise.

An alternative approach less consistent with the others would be:

struct bpf_insn insns[3] = {
		BPF_MOV64_IMM(BPF_REG_0, 0),
		BPF_JMP32_A(0),
		BPF_EXIT_INSN()
	};

Please let me know if you have any further questions, need
additional information, or if I could improve the patch.

