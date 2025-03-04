Return-Path: <linux-kernel+bounces-543888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B86AA4DB20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B51E188F0C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405D2063D1;
	Tue,  4 Mar 2025 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="FjtZgQEH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B52063C6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084719; cv=none; b=nWvcYzxjELaDvaPUjZhA/XmxgLP0GjyufW2a/wq7PYzGKR8u5DAOuGVAsVj5AqIN99NNSJCFRpSvsy5URjqKK7VdT7yKRrcAOGYT1vZnYL4i1tiODQoT9pAxJUSNgkobRjMhBK3k6h7EWfSs1e4gX/8sRL8hf7pzUcWmA+gcmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084719; c=relaxed/simple;
	bh=+Bw7XirvpxT5oKw5f1yKqDDpyEZbMtAIUVlUkrhS4eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbAeW3A3bZrZpKsOQJ8EISoE0Xknrie0Y3pe58jhGlTmfCUJbGCW6CBwOGEFxPYAdhv9+u9jauBx8fwxIEZ+11JtCS2pNMytsn1FnuxnzHeVnfw67klfbTF8sOm5BD57PdGQKmFXZSUSzLYP5a9eDOBfvXbowhk3ywQHWaz/avc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=FjtZgQEH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so14136675e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741084715; x=1741689515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W4qVVOExrtRW+entKLUaKt+MVkIEX24hGaFt2+MT4Vo=;
        b=FjtZgQEHzsSyFRa1nacgbUbOwVTQAcRQ5MFw8cQ8LZFdu3yZgN8ozviVTc6Idutc0y
         vaW4gyMVFH0wTeDwnJ9Qo9IDMKbtkf03kr5EiIX9laBGFzAVWms7+uQjgBl4hYxnhnBX
         zklCF5hDou187DRbphdollKt9r+VxfsS/qhMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084715; x=1741689515;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4qVVOExrtRW+entKLUaKt+MVkIEX24hGaFt2+MT4Vo=;
        b=vvkVv2jGktkiSoxIxmdxS+wWaZ/veaFqrObyGBSakI60YWvcMljUlZ7ppFDXZykHI4
         E0UJwWJipPHLlYfNCnpISZsAIv5AvVwpuRaNTudgWFPOJjJhp4vFnWL+Z6a+8FjXVeo5
         1ulDoUjt0AErhi8BVxWMCFxvvSUTIwSe8mWmwLyV/iPP7YAUAwYh3YJF7mqi9gJLv5cz
         PPCMD6N3TJnieF13uUqMa1CTg6lwwr2belqM3L4TmB2LI1kSbWllEc5Y7FW+aJ6Qj1qL
         RTwlFE+1PVUBGCTkcOOsfzr7SZgfzzynBO6WWGyCDOAGazCQDhrvr9EwUe1I0YjKZB1M
         hRIw==
X-Forwarded-Encrypted: i=1; AJvYcCWyiU28AwV6baZkMaR6X2tPjL5w6aX8EMmCxR9EeEfBoggcJveKwwVr49KIr75+mxDX07rC34iJ8EbfXTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9WXGSp9wTC285tHzG3OMugGsDul3XPJnddcJpsAug4JJzQmb
	6xkwpoYjgfDEDKr6MnYemoPcAKQs090Q1ScmipHCtVU9T3RaEhISEiDiLNGkd0A=
X-Gm-Gg: ASbGncuUMLCAcStDfi8uAnF0z6jsl/1bnnP+rmznAJEneDyCrw6c1CfSOxXdqriH1Za
	80rw5FXzcc3PFhgTstDr/2vcUmFTicPBy3kw4EDnrNhBJUC/X6j5yvOqVLwjNjYpx6ta7QDhihr
	7gROhOcVpEtVGyMEbflBg0o0roor7X1rwRRalRK3vl+EW4GqJqFjk9LlhWo/PtrBVoGw2TxOHlF
	weNzesEG51lp6AopIPRudygwpxq3cBD2jTb6zVgFYyR/IBr//RrrZWmh9Rg4Xf4qC8ClvmwoQwS
	6lF6ePfnS0DFgJPiubcIlknmy+pqAi0yZ3pGqUcEau/mn6gg65+F10bM8fPpNoH2G60ZwWJMHd2
	MaF0FJu2i
X-Google-Smtp-Source: AGHT+IGDzu80tz1rHJvOV0uZWSIgAnFYmFBxu/NV0NJKiiusnGA5MNIT3f8/IIJK2mMGb4yfc07nQA==
X-Received: by 2002:a05:600c:3ba8:b0:43a:9ef6:77ec with SMTP id 5b1f17b1804b1-43ba697ef79mr129556435e9.23.1741084715192;
        Tue, 04 Mar 2025 02:38:35 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28b285sm194398265e9.33.2025.03.04.02.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:38:34 -0800 (PST)
Message-ID: <01367a6b-8eeb-417e-9a66-e7a64d518319@citrix.com>
Date: Tue, 4 Mar 2025 10:38:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 37/40] x86/cacheinfo: Extract out cache self-snoop
 checks
To: "Ahmed S. Darwish" <darwi@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, x86-cpuid@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <20250304085152.51092-38-darwi@linutronix.de>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250304085152.51092-38-darwi@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2025 8:51 am, Ahmed S. Darwish wrote:
> The logic of not doing a cache flush if the CPU declares cache self
> snooping support is repeated across the x86/cacheinfo code.  Extract it
> into its own function.
>
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>

I know you're just refactoring code, but the SDM has basically reverted
this statement about it being safe to skip WBINVD based on SELFSNOOP.

It turns out not to be safe in cases where the underlying physical
memory changes from cacheable to unchangeable.  By skipping the WBINVD
as part of changing the memory type, you end up with spurious writebacks
at a later point when the memory is expected to be UC.  Apparently this
is a problem for CLX devices, hence the change in the SDM.

~Andrew

