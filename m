Return-Path: <linux-kernel+bounces-393313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959119B9EFE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525251F21811
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 10:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56E1170A1A;
	Sat,  2 Nov 2024 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="TRMf/qhZ"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0E2E40E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730544224; cv=none; b=uDBegTFtQ1nTAsR20bGsSxcBivVgTPBOa3mlDGT8rGwzxRrT5z7fVUqAlmxvgEvCzBMm6qZc8GG+eZ05fSXttPhhXyXio++qqnfRVKDTmhCVCTdQ6rXl+NWtfujPY1XD22TIB8hn4pKZcK7NI2ClQGXwW1wKZB1FotvuDZ25Cqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730544224; c=relaxed/simple;
	bh=j2a1LW7AkCNYtiAHKl+WpY2EDHs10dxIy/hiRkkE8M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6AIIouieo04a7kG3eFs4ku0f8H20lmIvrjGR2Nc869LcQJiuCbbYh4Idv5WW0dBlY0Miil5wlXmeWZhNQtxxhSAGEQQatSl47ql/fzRf1rT9+F8QSSZVDeQP1v/X0XzJZ2Tv+eoqzy20/q49Q3ecOVXVoJqpLlj0+z1ASB+M1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=TRMf/qhZ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3b8b34be9so9787345ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 03:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1730544220; x=1731149020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5E+zPbIeW2NpGExKCJwVS0jdkrwjIk/vifgXOVF84OM=;
        b=TRMf/qhZDVDV1+JA3QZJX3Jo3oojkJlo+YaZgI6bbKyIkQIwan9TCFECIPA1shejkE
         nbh2drMzAWPORWtvRj0y1fR3reEjMZi3JhIkhYSh+0uG6zICz3J7Xw+Kvx9DAeqoFlm2
         p5OoWKbsFQ8Aqon+xtAuO0AouR22WvnzRyz1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730544220; x=1731149020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5E+zPbIeW2NpGExKCJwVS0jdkrwjIk/vifgXOVF84OM=;
        b=djmzCTmCOJr/UySwTQezlxibUNXfrlLeE3jqVUgsy7KZL7o1lbJIWHinwFbjkqFTCZ
         2o3zzexyx5ZHi7njZVw6lSl+Bu5xD1x32hojdHnCLV+FLKFbukStyfeCAOIAE5rbSGt4
         bvbMgRu4yk9IgRve5i2lhGXHbvNncCk2lE8DJ2lxRQRaf6uEduqBuD3jLfVVIsfK8lOV
         hL71U7sMM0AHM4optMRi3JbVx4uCfDDN1EEryFGCf0dtKb4fnoRtdSbDvjLoDRtizizO
         BEPkAIYziWDC7C5ODtQJ8XI850Gn44eJKmh2lBwNB0nI9XyZavZ/blYrVZ8+zRWwC/6s
         au2A==
X-Gm-Message-State: AOJu0YwMLHBPljSx9kDEsuj4NUN1DR4d81i/74KdwgNBx/ZKPf2o/U/8
	nhtTci8cg44AL/OKputWSkFUribjAAGz62mPoXb3oiJ1jRTcKS9rp0B+IHRGPg==
X-Google-Smtp-Source: AGHT+IFIRQe2VBYWUfM1dViJ0/6r91ZBIV79oZXOk0wloU6pWapZrMDRHrlB1fFtFHkqUCgQyhXoAQ==
X-Received: by 2002:a05:6e02:1c2a:b0:3a4:e99a:bd41 with SMTP id e9e14a558f8ab-3a6b02be160mr70648375ab.12.1730544220349;
        Sat, 02 Nov 2024 03:43:40 -0700 (PDT)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4de048885absm1114575173.29.2024.11.02.03.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 03:43:39 -0700 (PDT)
Message-ID: <171a7284-100a-4850-989d-63b9f7782db4@ieee.org>
Date: Sat, 2 Nov 2024 05:43:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: Fix a typo
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 greybus-dev@lists.linaro.org
References: <aad9d19c20ea0463974b7652ba7f2f8d9fec1186.1730540152.git.christophe.jaillet@wanadoo.fr>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <aad9d19c20ea0463974b7652ba7f2f8d9fec1186.1730540152.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/24 4:35 AM, Christophe JAILLET wrote:
> s/interfce/interface/
> A 'a' is missing. Add it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/greybus/interface.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
> index d022bfb5e95d..a0f3e9422721 100644
> --- a/drivers/greybus/interface.c
> +++ b/drivers/greybus/interface.c
> @@ -780,7 +780,7 @@ const struct device_type greybus_interface_type = {
>    * The position of interface within the Endo is encoded in "interface_id"
>    * argument.
>    *
> - * Returns a pointer to the new interfce or a null pointer if a
> + * Returns a pointer to the new interface or a null pointer if a
>    * failure occurs due to memory exhaustion.
>    */
>   struct gb_interface *gb_interface_create(struct gb_module *module,


