Return-Path: <linux-kernel+bounces-190588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BEA8D0016
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F84D1F23396
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673E015E5D5;
	Mon, 27 May 2024 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzdbb6fq"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44C15E5CD
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813189; cv=none; b=RFy8ekQ2Fc3/r3+aogxoyWiHMKsIF6kGmr64KD2uNGVUvXHe1aXPMuXB4I/EeXRQkHBUTkUipubKt6BiLc1d/QRv06in9T/7mG8/Uy3k6nc4d5UlBJqXfwro6L7FEeo39HZPndOfLUnYLybwQxr5eccs8hA/vfD4XdGz07IeYbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813189; c=relaxed/simple;
	bh=6gpy4QnlXfn+3VfnJIdKkS3eQTcH5CkCvAbl/LBAL7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rubrhJ4vLZSSJ3ypBHrTXuaqMq6sc+nRWn/iJEkTGZlNH9RRoTaporveCo/kZNNnsLdfJJkKSLmGbs/KfIo6z5tNAIfYjRmZ6t2NAkF2KyPcQz1z4P4C2iWkVHol+L8o7/Cs+zjfUXj+nho09rdG8lnAwSV8xUG/mZ3zs4jJh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xzdbb6fq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-354fb2d8f51so3216892f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716813186; x=1717417986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PbKr6F4qyJEGh68m1meo5rRQR6WxkeJ7FMZXKENRV0=;
        b=xzdbb6fq0LJntuZkZBwLuTISb20CAGSt8MJhSIqpmOu0fbKFrJBjur2YzKCkG/3zlF
         BieO76tfiki5EqA4MN6au6YEbknU+cWfL5ElLfvjUsfgWmSndXJn3IjbWeH0FTxTXto1
         6b/j3y7CSxSspyexMO3FV8dqakGw6w8kN5MUjDSSSZJaF8+JppoAeYKklOjZVq+xqk/b
         sLoKvZqjE9pf4cwpxEkwrFiqm6B/dEjLB1O/EcDzO3sunHSD7gISnWUIWaUphIkNZYK1
         oOl7tpzlZxe2iuoNgrvVeNLiTyHlyu/HMZy/beD6Vm1ssbxsd1ZPHSKqhoUTSM7I1T0L
         ciCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716813186; x=1717417986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PbKr6F4qyJEGh68m1meo5rRQR6WxkeJ7FMZXKENRV0=;
        b=gYnTKlkaO7KmLKJd4N1L/2jj61VRwVKvYqUdqpatx5Wh+KaPm+FXhXGxkL+u70RnUi
         G7mC4jTuEouhxd+ggXRn9KBOCgZ1ZkiiahefQS3NSYLPIEMvFNEzQpqJ9xTCtuQgH/WC
         PGldBijckX3TzcuymCRhjuZRCjoHjI0k5wendMxUhfPzjRx90Zfy8gRKXs0TYMuBV6P+
         p0/23TwhcCjAyxrTsfSCOkGA4yGWALpyynkaE1esk+13l91m0Cb66IV+Fch/3cNtOJ/M
         05sZ+jBKayzoeeysGXBUBRqRUn77FcdKj84OX1wcU/aFVXLvmb7KP45cFJVMX7fUcFFC
         zD2w==
X-Forwarded-Encrypted: i=1; AJvYcCVyXTfX8Suw0juDTCILkyyD0OGE7xUUH7cECtTqlc3ZiafE3saGoHFaNdREIpmtn2JBfZaYvtcFPZ3uwN8jSVpVW/ERvleQm4fek8xe
X-Gm-Message-State: AOJu0Yx597LcToy/om8Uaxd2c5VmD97ymWCiN+pMNHHJIxzMRjNx6FNf
	qDeLVPwx5bfs0uZoSrybUxEA/JOSRdhlzRrzn4iVm/7HuC/sbdEGpWsLBmjntqg=
X-Google-Smtp-Source: AGHT+IF3YzofNuY7fs0Qc1CTGRPqO/DtJKUbJFULuqF8piYQueCYqw+R3VAn7929Wkj5lhKwclJHmw==
X-Received: by 2002:adf:eccf:0:b0:349:eb59:c188 with SMTP id ffacd0b85a97d-35526d67290mr6935711f8f.5.1716813186518;
        Mon, 27 May 2024 05:33:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08cc1bsm9025986f8f.45.2024.05.27.05.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 05:33:06 -0700 (PDT)
Message-ID: <bcca84a0-f12b-490c-a61f-b10a9fa0395d@linaro.org>
Date: Mon, 27 May 2024 14:33:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] MIPS: Loongson64: Include bootinfo.h in dma.c
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen
 <chenhuacai@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-mips@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240507-loongson64-warnings-v1-0-2cad88344e9e@flygoat.com>
 <20240507-loongson64-warnings-v1-2-2cad88344e9e@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507-loongson64-warnings-v1-2-2cad88344e9e@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/5/24 20:51, Jiaxun Yang wrote:
> dma.c defined function plat_swiotlb_setup, which is declared in
> bootinfo.h.
> 
> Fixes warning:
> arch/mips/loongson64/dma.c:25:13: warning: no previous prototype for ‘plat_swiotlb_setup’ [-Wmissing-prototypes]
>     25 | void __init plat_swiotlb_setup(void)
>        |             ^~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/loongson64/dma.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


