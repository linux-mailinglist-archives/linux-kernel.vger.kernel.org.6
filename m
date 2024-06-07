Return-Path: <linux-kernel+bounces-206059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFF39003C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C978BB22466
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C7A18FC63;
	Fri,  7 Jun 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efYtRcnK"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE827187324
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764067; cv=none; b=X3rtftsU+sFua6TxkDWuCs+00U5dStC+h8PlvL11vCgUIhm1PcxKdIb8GKoXx9HNedTsMZ1z4V92yNru9lWOrK3ApU/LSKdOcuWf2dsyj+e0mFibLnqMPpS1XD2HuhfTI1auGL5QXIT/oitZ87qRfgc17NfChhQmbaliTkd3MhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764067; c=relaxed/simple;
	bh=CpI4EdqIwC1Bi0MB6v53eSkac80cwlVCjpiZwtFiwTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKEX/Wwvw4Hmz1oHzZ5r1ZNYfEhZmi3IDRpIybCRN/rFDeV5OBdzBb2btOj/gCyn3vy2FyaEo+gfiZ7vN6UZbNVgsmv6cBlofMd+ZbPPH8k6tulacCdsDfD7Z7RFpdwIXz7Tmm7qUMtn7wkj/YCiPlVvnR5KRY772S1/xFPVaOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=efYtRcnK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a68b54577aaso270107666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717764064; x=1718368864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9VE2Rco2+OBq4k6yMk2HFwn9iF2JPDlMzwkzy0fHug=;
        b=efYtRcnK4af8nIocPb+LcfpzKhkcyUjoJi2sF0DRhbEPnzfx1NeWKMG1MYS6qm7Jjk
         LftVXWCEQXEE6Wc16fKlAUVXv/Mz3mnNFWbxaA5GGOQfXFYnnWXocixnN+w/a75rTTEK
         3XXhUzEwD7S7uJVVJPqsl9xhdSILWM+Go8FGOpnaS/Z7C5hCIouOAhuaLVkNEt9n+8z7
         PdMUtllBZT8Xlu2LWHTjWRWimnDLYkREzsmzkfux0Ufx2zBrjbtAsUgGtRefPFzGU713
         EiD9txHFlkW2IwPpGqwez+1ZQ1eCpus1A7klS1/G9j3cbfw3LnJkpsXJj4jpj0XFAaXC
         ZKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717764064; x=1718368864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9VE2Rco2+OBq4k6yMk2HFwn9iF2JPDlMzwkzy0fHug=;
        b=MqMDC5Fx0/9/j3JI4o07h1Pf919zTGiQcpruz2CJxPhhEVndj0HPA9nXTJbWCCS2zi
         yZhbqzMpm1iQx0/T2tObH/Sy80E5fyNbv1voPZNMvoTDImRpeBNW6qKB2cR2mY0scKUZ
         HfZIvls9EBHLMcp2pE7brliFk9ExaCCKN2zRzrTOE4zNe/Z5f/4/A5oHSiTJ4g9vtAWx
         vAhuY1q5fOH2Sjx0uwjc5ObZm6lN97AcMAMhO/wGLcluFRJ58rj3Ej2B5qSAcAF75cSf
         yg0u4smFFBj7fQVk06uq0IW3xPW8uHCoqVCg56K2ynH0RT3lmU5/iQAHessxQ2B0cKUK
         XKag==
X-Forwarded-Encrypted: i=1; AJvYcCVBNbKANXLWqgL+e6Y8woMWhSuefWuFD+fPwqh5PmXRjq5Qvw4ba4y8Ubd35JTQwyBTqBewyEQqxoWRz44YPpSnHLwFhaXT0vTcWPCv
X-Gm-Message-State: AOJu0Yyh4G2coQ4oxfGPzybSWGoGTlDvOK7w23tuOnHZDJvzKeuRJxJI
	/VGCdaRkYtasxH0lFmUXnaeCmIxxumAhYSvkqPisZBPPEZxZU/Q6LYe0eQu6hhU=
X-Google-Smtp-Source: AGHT+IGJ04zgDm+tzQ2v/+kw3WCAzIV8Doek52h/npy2UFsZjhGnxknFHS7QSERFdX/CTXzMcNteQw==
X-Received: by 2002:a17:906:1b19:b0:a6e:f6d2:5012 with SMTP id a640c23a62f3a-a6ef6d26d99mr13562466b.2.1717764064232;
        Fri, 07 Jun 2024 05:41:04 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805cdd32sm240659866b.79.2024.06.07.05.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 05:41:03 -0700 (PDT)
Message-ID: <1c85847f-ea6d-437e-ac15-93346d414761@linaro.org>
Date: Fri, 7 Jun 2024 14:41:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] misc: fastrpc: Add missing dev_err newlines
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, srinivas.kandagatla@linaro.org,
 linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240606165939.12950-1-quic_ekangupt@quicinc.com>
 <20240606165939.12950-2-quic_ekangupt@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240606165939.12950-2-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/06/2024 18:59, Ekansh Gupta wrote:
> Few dev_err calls are missing newlines. This can result in unrelated
> lines getting appended which might make logs difficult to understand.
> Add trailing newlines to avoid this.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/misc/fastrpc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 4c67e2c5a82e..4028cb96bcf2 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -325,7 +325,7 @@ static void fastrpc_free_map(struct kref *ref)
>   			err = qcom_scm_assign_mem(map->phys, map->size,
>   				&src_perms, &perm, 1);
>   			if (err) {
> -				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
> +				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
>   						map->phys, map->size, err);
>   				return;
>   			}
> @@ -816,7 +816,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
>   		map->attr = attr;
>   		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &src_perms, dst_perms, 2);
>   		if (err) {
> -			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
> +			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
>   					map->phys, map->size, err);
>   			goto map_err;
>   		}
> @@ -1222,7 +1222,7 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
>   		 * that does not support unsigned PD offload
>   		 */
>   		if (!fl->cctx->unsigned_support || !unsigned_pd_request) {
> -			dev_err(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD");
> +			dev_err(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD\n");
>   			return true;
>   		}
>   	}
> @@ -1285,7 +1285,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   							&src_perms,
>   							fl->cctx->vmperms, fl->cctx->vmcount);
>   			if (err) {
> -				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
> +				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
>   					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
>   				goto err_map;
>   			}
> @@ -1337,7 +1337,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   						(u64)fl->cctx->remote_heap->size,
>   						&src_perms, &dst_perms, 1);
>   		if (err)
> -			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
> +			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
>   				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
>   	}
>   err_map:

-- 
// Caleb (they/them)

