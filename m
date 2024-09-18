Return-Path: <linux-kernel+bounces-332888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0097C057
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60871C20B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BA81CA68C;
	Wed, 18 Sep 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF9eW4p0"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE41C9848
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726686768; cv=none; b=LOGBm205K9wzblXD21wfrMRi6cYu2YtTtAfQMR7g2yntYLbPk5iiedecNnLvDWyWe0rdMjbtcEUytFi2j8B7y71FeD5TGFIFxE6L4whT0CNWINsT6RWy1Z/SYzBE5dtWuDLWn9tjl5Qx02BAEBXS6ibl+oqEmLxNGV59cQ0wBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726686768; c=relaxed/simple;
	bh=UqEGQlrhAKMaTVYXRHkKz4RHnw67nO+dOwEvga7bsRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhGUsHKNuRcWsfD7/CsAlXefzn40hi9ue8dmw1tecFwoFa4JN8QBKA/SBfD6mp7MqF7XFAFn5pi8Y/CF7pwecFxDeDv2z6hZiABpbDX0Nc/OKf0/G5r9Ms0V+t6L4wwa/gRRfvQjT+hgaKLfZzY7TUFDN41gqNVirFQlkiYzQk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF9eW4p0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso546566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726686765; x=1727291565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3Xn3OJOyNbtekRi4Pk798R2NjV0eBNwlc4vGJafrlo=;
        b=QF9eW4p06DcetkAQn4b/1B+tI6CJhpaqsV7aPqvV5KSqIce0RVCR8EpOEJ0TSnlJIT
         F59/ET2iE00E8fe6mncssD/rfg9McXdzpUvOW7SCbrvHPKTqT+LQSlsxIwi+Cdem5Lyo
         2iQ8hef3mm57IsD+tvSN7soyeextt83ZewQdERTUTIBm47XbqAhak8sScQY3rIHr4PqH
         cTFdftW3/xgFB1R/IaD6dAxktmfYtvVK2VFimERGEcXE/cD5NwZcLmWk3GNuVhRpWZGj
         EM+ilkoZ1EcJVMsEsZSriWnycy/mguZlP4mlzSCjCtSYAnciH3R+qdFS1ZP346sb7v39
         pjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726686765; x=1727291565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3Xn3OJOyNbtekRi4Pk798R2NjV0eBNwlc4vGJafrlo=;
        b=j5PpX8V9tJlNYxU4uKMXlBVEn5FVxmcVZkkfZTNgggwmmIKbTmPJ1ZX7rIIYw2K3eU
         l/a0x65W5xgEGB5+LG1lZveDfIOjuQhG/hAtmhNLOanKfGdIAYigGa4GyyGTI6hvnsxW
         KDo36JOaza73jb5ypwse2ruaLELlMWaVGeuXnXb3k0dcB22yueVxN1jeR11+7ShlwGfj
         VohxGW+WuYXPO9ohcjNDEjShcsIRjSUSvGGI0eifHUxtzxlXsL+7KTdarCblmn+5Dz3Z
         jKRiz7e4QHucQBnM2RnS2qguKAWPky9DIvVjtIlF8TSpSL/cF9Zym/GSOa6FUKLqVCHZ
         5itA==
X-Forwarded-Encrypted: i=1; AJvYcCWfYcv9p47LaM/worBm8auCi4SPMXKjVSRkpqFyQrw4VCiw5YIvdp6BcWzqb8I8xtSVwi6C8TQPp2fTqpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBCoVFy828EiXvJ3wXKbtRucteBRPCBkKxV9Jm3d+sVpYGNu+i
	RaA6hBQa0oqDuHWEifUqRYOCeaZBRAftJdhuZENp9loC9N68if2O
X-Google-Smtp-Source: AGHT+IHKUneLxo4fzRCV8XQ/DIJf9ok53JMFlYNox+EnndkhFO5fNxb+Gn9qOvNgzuIxUOELME3ScQ==
X-Received: by 2002:a17:907:e619:b0:a86:96f5:fa81 with SMTP id a640c23a62f3a-a902949a158mr2344756266b.32.1726686764469;
        Wed, 18 Sep 2024 12:12:44 -0700 (PDT)
Received: from [192.168.2.100] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612dfdcfsm619165366b.150.2024.09.18.12.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 12:12:44 -0700 (PDT)
Message-ID: <8faf5f05-8651-4601-a70f-7d417bbdee22@gmail.com>
Date: Wed, 18 Sep 2024 21:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vt6655: rxtx.c: Fix too long lines in
 get_rtscts_time
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240918165052.30386-1-dominik.karol.piatkowski@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240918165052.30386-1-dominik.karol.piatkowski@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/24 18:51, Dominik Karol Piątkowski wrote:
> This patch fixes the lines exceeding 100 columns in get_rtscts_time
> function.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> ---
>   drivers/staging/vt6655/rxtx.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 3705cb1e87b6..1ea17e86e3ee 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -202,20 +202,29 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
>   
>   	data_time = bb_get_frame_time(priv->preamble_type, pkt_type, frame_length, current_rate);
>   	if (rts_rsvtype == 0) { /* RTSTxRrvTime_bb */
> -		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
> -		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
> +		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20,
> +					     priv->byTopCCKBasicRate);
> +		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
> +					     priv->byTopCCKBasicRate);
>   		cts_time = ack_time;
>   	} else if (rts_rsvtype == 1) { /* RTSTxRrvTime_ba, only in 2.4GHZ */
> -		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
> -		cts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
> -		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
> +		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20,
> +					     priv->byTopCCKBasicRate);
> +		cts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
> +					     priv->byTopCCKBasicRate);
> +		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
> +					     priv->byTopOFDMBasicRate);
>   	} else if (rts_rsvtype == 2) { /* RTSTxRrvTime_aa */
> -		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopOFDMBasicRate);
> -		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
> +		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20,
> +					     priv->byTopOFDMBasicRate);
> +		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
> +					     priv->byTopOFDMBasicRate);
>   		cts_time = ack_time;
>   	} else if (rts_rsvtype == 3) { /* CTSTxRrvTime_ba, only in 2.4GHZ */
> -		cts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
> -		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
> +		cts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
> +					     priv->byTopCCKBasicRate);
> +		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14,
> +					     priv->byTopOFDMBasicRate);
>   		rrv_time = cts_time + ack_time + data_time + 2 * priv->uSIFS;
>   		return cpu_to_le16((u16)rrv_time);
>   	}

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

