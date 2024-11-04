Return-Path: <linux-kernel+bounces-394558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BE9BB124
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B101C215A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DFA1B2188;
	Mon,  4 Nov 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPMm5EZh"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC871AC458;
	Mon,  4 Nov 2024 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716282; cv=none; b=LbAvupPyaSm6D69PG4uXrlJVFLzkToa9t2a7hewLwtyh/JVaYsVqsuANAsDP9vHXHJ7dHehkMjrLG/EV880cEJCYqOqA11D3vAFqiXuv+njaBCZ/5FOYuc+KyHqHPEW+MwgMCSkZQeMF/qRPIDe+Nux/mdcxB57LVr4OCuGP6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716282; c=relaxed/simple;
	bh=KNnTuRjeph/PxeFWH2OjkqD6QF+athM8Qh94/GVFiuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffliakHTvFpidUtiEVpDBqf+w1w2DZ7hOozSk0uPYhLRp8RLRs7I0DXEviw7Oyukn76TAaBYFD8BzN5S3dBxBnIpt26Azn6GiQ4G6Ptq5PhbEUso+b+waVXJ1q0GH8FCdIqSmg/KmwV6xKX5sS6EcaKcwfntPnCMpK8nYQw0BTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPMm5EZh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539fb49c64aso5372255e87.0;
        Mon, 04 Nov 2024 02:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730716279; x=1731321079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slUFAVbY5/wKAk/TmOVIAwa4COIPRsTBYPw4oUXG8Jw=;
        b=VPMm5EZhm5+Lcjv/iJrtd5k7lszncWZ1HrjczoBu+P0MOCtaLsm0dmBMUEat0104Kj
         NvgzDkHB7C87t6YXcq6V/vc5eqDNcqNNM1aDO9YzBC7yI2EBf/W+ch6X48Jr+yPwTFDl
         tiRrq+eBCMQDn4PQrFZ4GjJQJj9VzELmNzrCInGaiZp+1mQpPQFi6q4FYrgdmaxNdSUw
         GP75slstaLMJlmMW4GbFKA09x8upgnboG+ymSYtRKY0yuSCAxJYvnxBmq2qTot7w92y3
         kcasDMk2IaBCNjn0QlkGxNR+1m9EUdgilMiYs7G/zbBJOW222ugmHLOF7L/zUguYJkut
         4sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730716279; x=1731321079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slUFAVbY5/wKAk/TmOVIAwa4COIPRsTBYPw4oUXG8Jw=;
        b=n/uMuRlbsbn9x9Gse22henLyJ4/8Wi21s9fa4Lw5kRP2Fdf0QMG5DFEVPuH2lM6UYn
         daRdArCdudWVTJrh6Mux1l1ljhqS0TU1kmGwczLDXf844Y+xHVgghIePfu81N3Fsmb5Z
         XmZ5IXpSu9sBn7BPSq2I9N8ixL/MJ4zpmWuwXYd+rBtATzCyx0aj5OiQH9evb9Q0p0mT
         tvl6kRPs686buGF69qPGCf5PdEyHdUrOzs/J7WDG24n4p5/GCtQ0s6WfUWy0gvYaSwWT
         d9ZQgxsBAKE0FU3WYwEwiNNdKaKPfvJK8gWdBmtSMSVP690GnBTYiurGp9xEyhTbt2Hm
         ApsQ==
X-Forwarded-Encrypted: i=1; AJvYcCULziOa0pGHsh9o4IipikwpTJFp5dBEPj01BoWaSdGDee2DpGeGbNrahX3TfzEGWIRVuse0zx9D9HGJst8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2ycu+t8LhLzOrZBI+IUaoS4uQ2GGhmfpksaOXjG161XybU0H
	ZsPoznzLfRuve17BW1jErn4XQlN8FYbMyBnEbDAHs2SxJe3u4wQ2
X-Google-Smtp-Source: AGHT+IGK+lmHk4o+V9+0ikSoBiJZqg6QykoW+ZRxIDliOFYdRFEcSLMUbdhefW3br9WByiTmjmgPvw==
X-Received: by 2002:ac2:4c56:0:b0:535:6a34:b8c3 with SMTP id 2adb3069b0e04-53d65dca63dmr9144991e87.5.1730716278359;
        Mon, 04 Nov 2024 02:31:18 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcbe44sm1617800e87.201.2024.11.04.02.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 02:31:16 -0800 (PST)
Message-ID: <229a3c3f-aad3-48b7-8d04-18ee1ab8c9fb@gmail.com>
Date: Mon, 4 Nov 2024 12:31:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] rust: add dma coherent allocator abstraction.
To: Alice Ryhl <aliceryhl@google.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 a.hindborg@kernel.org, linux-kernel@vger.kernel.org, dakr@redhat.com,
 airlied@redhat.com, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com,
 Andreas Hindborg <a.hindborg@samsung.com>
References: <20241104090711.3000818-1-abdiel.janulgue@gmail.com>
 <20241104090711.3000818-3-abdiel.janulgue@gmail.com>
 <CAH5fLgisLyW-d9rsHJ8Vp8HpWh7PZxtkXooVQyMTxs445Ah4GQ@mail.gmail.com>
 <f6889ce1-f1e0-438d-a9e6-4340a92cb6ef@gmail.com>
 <CAH5fLggDqXiyXLbmGQfUcgx3nCv+uhsqwWBwk2j522v8jOp9aw@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLggDqXiyXLbmGQfUcgx3nCv+uhsqwWBwk2j522v8jOp9aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/11/2024 12:00, Alice Ryhl wrote:
> 
> You'll need your own trait, or you can build_assert! that the size is
> non-zero in the constructor. 

I think we can catch this in the constructor. I'll try the build_assert! 
approach first as it's simpler.

/Abdiel

