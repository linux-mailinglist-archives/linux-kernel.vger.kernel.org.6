Return-Path: <linux-kernel+bounces-551943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF1A5733E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFD01898F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B45C23FC54;
	Fri,  7 Mar 2025 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d52wElvr"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99A192B7F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381382; cv=none; b=ihK81DsdADdv5eRhpe2e77ln/o8rcNBQt/sJ6QYXtl5puP6Es4+BBX48AbgY/SpQFSkwErWAJyHOEZzrTXDrWFDagI5r76V4twC913LO+lK2d3Yfu2pSBIAzvaCGnFaS5hnrB3ZSXWiNCPBGRPl46lqLxRyCCAtgtKf9enc6sA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381382; c=relaxed/simple;
	bh=sg0V/ibZCyw+zHj/2Li32UQZH++dSgU/mySlElz8RZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBxHBOh/zEbwCpsNET0qudTSMKa3HpYAw5JuWP1ROZZYrpLNGvXUr58ZEfsgWYvT6TpxreGLZChluMQyFSsu+sZ5zfwQhfnHOzrzqCwycNe7/+TtDcBKO5YpxxT8TtD2/kPSSbQdDdev1aR2SYMBhEmAgDXqj/H7ns0WK8ZNlgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d52wElvr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bd03ed604so19439985e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741381378; x=1741986178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1pIO3W6UHho5/y6qR/VqXNkL6ggB/e6+WfIGEybHyU=;
        b=d52wElvrDs0AKDV66Ntr0H3nO6TiRE8o0TnnS02sLafb/MKS2urjiyNBjkGz4v+/dn
         F4WR90XWgWehmdd3SUYxXr56+T3EbLupzf2NeOAy5Uj7C1MA3IlryD9oHZn9FfBWdFI1
         Ru7cxBFrdi7+qd7TUf/kZ7CMJvUm2DEqM1X+NIr9fcsC2v9cYVQFMl+9xK3KzjjmBgmZ
         0OauEQ4GiGm+gRZD0b0R4gHqsWsruDu+TiWmlEGegmBBZUnr+Skab6ripUAMcZ3SBAWe
         9biFSq2F+OkOjEZkdswVdZkLQiHeZWgO0uXoP9R3bv5ohkr83/t50LbDKrtSPLrK7ORx
         Ll8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741381378; x=1741986178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1pIO3W6UHho5/y6qR/VqXNkL6ggB/e6+WfIGEybHyU=;
        b=b0hJrYtJ+wfDIXrBu7XnxOcDbEssljUrog62zz2+uzxB09E11E2AQuRMj/H3bLgCVe
         sNcHLGoBKBtGZB5bKyWF1zPgM6nHQu8rX84yq+OgukJwEJYjy/3q1PhYuC5LMh+R4UUP
         wP8MFNvMnh9vQR4LITkrMLvXLB9Y1Wgq1+QQD0OHnlFKxUT2xf5mLuDj7goDIsBvE/W+
         jGizyrisV72pE3QJ05VYnU1d56lkaS84vo84AP0DB7aS9dorOPqvIqXvluFnFc/nig8j
         cRHlwkvuBjkwAcUBqwtlmO/kB7k0AYILqrqTaw9J5TTvelT6inOILvLnQ1l/XwXNsfVo
         xB+A==
X-Forwarded-Encrypted: i=1; AJvYcCUzr3/6dkZ+pULFn2n3Q/ZrLaqYHcgWIWeAo/en6DV+EixqhpSoLdIFGwzzCCQgVKnDr/Vvl8rWLvR++M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyycOKBv9e0vCpj584T6rZSBVgMzuqBvDuV70M0dFH8FtY210Eu
	ipYs4hr7TbmsPyeVR4B8HL5GczFWCDY/uSG0vrCjg73uJpJ3qVkOMqBILk1HafujEh2TzHiOV53
	w5ss=
X-Gm-Gg: ASbGncvIP4iIVu8l9pka4QH5sgjpfIoZ1iMveWrtvxXCVbUcPtiI7hmDggF5jJ3BJ6W
	7uIVnoNLpZHJhdctzumB/Dr70SWZMtKMpPbTxv6nXm9aFzsXfAZLKP3xvnbwkOSPQ/6SbrEpp0Y
	xPIX6/mCrlMvBhS7QMtm/GjVHa3jThUpGyNrjIf2iHBZ/hEOSLnCuSa+F9JgQ1cX8WkKYJHuMZX
	vfcTaesiBx2/IbA/UFfAXEXWy3oHEhlVAfeaVeOXBdCpJHl7oqnZtJdkxjfDU/baohx+6N892aO
	4eDq9yjFyPy5FDlseudlhxWH2Cl1sgPporiiPz89+OeYAjiFWriE7uYqThzmIwCUFENKYpOaAl5
	HPOTcbOpvz1Qg
X-Google-Smtp-Source: AGHT+IFnECB2WJgp4h3URm4FZPTxJWKmnEDM3Aq2p4c4hzaxYSIhwVdcFCF4TerCDIJ8dTIfi5XEXA==
X-Received: by 2002:a05:600c:1c05:b0:439:6e08:f4 with SMTP id 5b1f17b1804b1-43c687014f2mr30261315e9.26.1741381377638;
        Fri, 07 Mar 2025 13:02:57 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c11e9desm6344762f8f.101.2025.03.07.13.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 13:02:57 -0800 (PST)
Message-ID: <26709015-6fac-48c4-80a2-cc6a4150d3a4@linaro.org>
Date: Fri, 7 Mar 2025 22:02:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/20] Revert "hw/acpi/ghes: Make
 ghes_record_cper_errors() static"
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <9cb6c734f32f01206db562b9a406829bf81e19d9.1741374594.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9cb6c734f32f01206db562b9a406829bf81e19d9.1741374594.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/25 20:14, Mauro Carvalho Chehab wrote:
> The ghes_record_cper_errors() function was introduced to be used
> by other types of errors, as part of the error injection
> patch series. That's why it is not static.
> 
> Make it non-static again to allow its usage outside ghes.c
> 
> This reverts commit 611f3bdb20f7828b0813aa90d47d1275ef18329b.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   hw/acpi/ghes.c         | 6 ++++--
>   include/hw/acpi/ghes.h | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And I apologize for missing to relate the 2 previous series.

