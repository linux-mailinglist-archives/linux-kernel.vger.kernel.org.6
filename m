Return-Path: <linux-kernel+bounces-305549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D1396304E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DCC1C21BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA801AAE34;
	Wed, 28 Aug 2024 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1PLinB2"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B81AAE06
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870542; cv=none; b=RDyhNMtoUlXSziM6c0fm6Jh+1MbZuGqP+2Dlzebb4RwqcBf4OsPNMVpTMFwDOgBqU1zLZI67eDS8/XJjPdoz5K82yIeM23GZfSyJBewEoryRdoe25C7WacybFDgKRKdW/EtgU5VbN1nJv9H/PaTM/QL98EDuxMXPOkDMP2LSJEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870542; c=relaxed/simple;
	bh=QEeLNZFZcwxCcWYnW4z2tA2QeHYs3Q65T8g1xBDn/3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYpjo9lSMlSubbn9lEuLDFqhxpI1Bo3SMe9i/gT8kPp9qAc5S9qbbp5DzTNcG9z3LTqWKfpKSIhu/gD6dpdP6b/w8hI/9lpqRrOQkP+6Z0lHS8iIZ5yXEVY7QnGpf7hgTJggpXloCeiS4M3PK5i8C7FWfiOYvG0y4zqKdG3E/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1PLinB2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c210e23573so1597453a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724870538; x=1725475338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcJUfphvBgi5vqI+dp18oOC2QkxqROcaEYjyHdODKlI=;
        b=D1PLinB2CgGSoSUEpzxQAZ7+lsPBRowYP2rMHh3ljEwcPv+4XNrW7FLrYmEpdHWCKu
         0yBxlp+gxgxI3DG+E9m9FlmQaPEfoXQ5jumdTHip4hBI/USGfMy36anBPdno00hhg9L8
         z66etL2gKYAEV1U49pZP+m9kwcgRYtE3oASH5ON0wfxog/sQ+rQKYBOI4wuHJNNmzyuv
         OukpdLOZJEa1uzIOo7ocQfua+p67BJ0kJD8C0LQHQ4LuG2v7vJxOwVct2LaviUNSQ3uk
         Yv/uBOaJOT+MbwwozM5ixrbJvKvz9c321EDC9DUUhggWYVJnAJnyv+4qEImUx2ql3nsN
         Jsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724870538; x=1725475338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcJUfphvBgi5vqI+dp18oOC2QkxqROcaEYjyHdODKlI=;
        b=OKNWMRNuLNYLHwa9Mzj5JeyLxoL6Mp1O+qatHN+edGx4Ka/xHqnY/6N9qXsxUwZAEN
         utMc91us1ucJ+XONcurA4LCuLocqXBJPvJJm4VXL0rd+ulng3JopDgA75qEuUhiQnXqm
         MXIQdPzVinQhbJPn7eHtDIvLENIdy7tZUL00PRHHdIoe/Ty6oDcq8w4hKAo/1YXkcYST
         RJTcscijSrLm7kWLPZp4/QT2d+mbi6/9jo6vB86OGHBNlHE8jAD45NzecA27vIUsSk87
         zprQiJos4YLlKucp95w7JMqZSgkrAwHsiE5e8rOCKEhloe3e0skN5U89pX5D1xLqWIbX
         fdvg==
X-Forwarded-Encrypted: i=1; AJvYcCWW7Agj+X2crVPCAGqESlnYIkDWIPpkRypKbtP1adu1MZNYdqpGEhCol+J3xrT2Py2kO/MRINt8bFEie+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1yBZ2aWdgz/8XdifzNB2o1RjC2425X9x5aUc2tn6U3XSJrp7
	mfEfpVFAlKU1b5lOfk8fP55LlommijaovjAEen0P67bEU+kF4eJlUBBPYfoA
X-Google-Smtp-Source: AGHT+IFSYYUBjtV25MXc6g5dPq8jQvkJmvS3NCJSaw9RZDiIevTdrXKjvwx96J8zHon6guUF042z/Q==
X-Received: by 2002:a17:907:60c9:b0:a7a:9226:6511 with SMTP id a640c23a62f3a-a897f92005dmr21597566b.31.1724870537317;
        Wed, 28 Aug 2024 11:42:17 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8553:56e9:1165:4741:30be? (p200300c78f2a855356e91165474130be.dip0.t-ipconnect.de. [2003:c7:8f2a:8553:56e9:1165:4741:30be])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e594a000sm273830166b.207.2024.08.28.11.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:42:16 -0700 (PDT)
Message-ID: <7a042b36-4e1d-45bf-a9b6-e4e248ade30c@gmail.com>
Date: Wed, 28 Aug 2024 20:42:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vt6655: Fix block comment alignment
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240828145923.78004-1-dominik.karol.piatkowski@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240828145923.78004-1-dominik.karol.piatkowski@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/24 17:00, Dominik Karol Piątkowski wrote:
> This patch fixes the "Block comments should align the * on each line"
> warning detected by checkpatch.pl.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> ---
>   drivers/staging/vt6655/device.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> index 0212240ba23f..32d9cbd55222 100644
> --- a/drivers/staging/vt6655/device.h
> +++ b/drivers/staging/vt6655/device.h
> @@ -189,10 +189,10 @@ struct vnt_private {
>   
>   	u8		byBBType; /* 0:11A, 1:11B, 2:11G */
>   	u8		packet_type; /*
> -				       * 0:11a,1:11b,2:11gb (only CCK
> -				       * in BasicRate), 3:11ga (OFDM in
> -				       * Basic Rate)
> -				       */
> +				      * 0:11a,1:11b,2:11gb (only CCK
> +				      * in BasicRate), 3:11ga (OFDM in
> +				      * Basic Rate)
> +				      */
>   	unsigned short wBasicRate;
>   	unsigned char byACKRate;
>   	unsigned char byTopOFDMBasicRate;

Hi Dominik,

please make your "Subject" line more unique. Consider that we may end up 
with having dozen of commits like yours, all of them referring to 
different removals and all without the necessary information to tell 
what they differ in (except the driver/subsystem). So it would help if 
you add the changed file or function to make it more unique.

The description can be improved. Please always consider that checkpatch 
can be wrong. So checkpatch is not a justification.

I propose:
Align the * on each line of the block comment to improve readability.

Important is to describe the why this patch makes the code better.
You can mention the tool which gave you the hint but you do not have to.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp



