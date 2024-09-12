Return-Path: <linux-kernel+bounces-327172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C297716F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277111F22A92
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CEA1BE85C;
	Thu, 12 Sep 2024 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2EN2xZ+"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770631B654F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726169348; cv=none; b=Er7tFkq5AYAXkuM4Z7Ad68nnQJPPEl9UPDMbhSRC7vbzScBjhxs8LKKBhoElZ9P2X8sIqPYPkJSaxHLCLNAUwMiQ+9YnW7xPeeBqjrrrOfb+ga5pVOucntUUtfNDjjAeVLcW5iisAvN/1Kar08npWQCLW1NgCPCmrPo5ZZwYvsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726169348; c=relaxed/simple;
	bh=mY8kmFlJmauWSs4RBZciRQXsogkFRL/xcmlYJazACdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UURa++q0fFl7abDROkKzx91LuOJC5MnycQRLmdlGDjEb5QS7uTszcAaVxO/L2J8u1NzBRps2K4GzvVIjG/1pjoMiwCpGHsaUXSIKVfuqZljUq9WeJ6R3s/ZjuqhqrDzZsqkrwJliyctUJsHnDZYal5eE/qtMeoio2U8/XF8702g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2EN2xZ+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c4d4f219so903805f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726169345; x=1726774145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLazog7s8K1rTrWlaTrxf9Z8RgSArRCMR7o9K2wdNHQ=;
        b=R2EN2xZ+R/kcKG5Pcjp/58OimzZMpgY6WFoRai8X4EV2api/t/LTCBQoQMloJAN35x
         5CjNPbP2wh6sTiMeyu7JX1gEIUSzplkQvqKQJMOknbDbJVe26TfQ1eQ4skG2t4D9+SwT
         OUcuNg1oMLLI9xytSedHCTFCy3h5xOXCo7tu3AlgzGRyykfK2OIclt0qbRWJAUMzNW+D
         62wR1RMUH9dH28dornxlHR5jXjeLJBxh7yHF1MWga2PzIRF0FbQyY4DD7kL7KrWDK0cH
         rzVRBE7EuBfvslUjVqoC4lO6StKo6c1emLjD90fRXcde7cMNejFSwcpE9hEeavKOBapF
         u28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726169345; x=1726774145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLazog7s8K1rTrWlaTrxf9Z8RgSArRCMR7o9K2wdNHQ=;
        b=UwxXtcTzi4tWXiGfbnM3c58EC0+dDtlheoQ698CZsu+qp9t+TQrvTKKaTpuhxvULSf
         V0mTuKsoqWpfNAgipvXyRrC6dkyPCeZ0o/kadpOU+UXIKXCPIro7ZZgI1C78UPqroVKQ
         G1w/iXxzOY5+uAFOB81sIhnGprzX3AjeOVxYJAVvDA0XqfGw5NPt4O/n0ADiwxRrvxHb
         FhTnYg1qTadBVMEjudunzCIK5z7aYWt55bLXjuzi9DnrbDvNPJAuWFHa93PP9LO4KKYX
         C+u4qMOm224oGq+QdPIXrzQQz/0HCSgiKUcY7ohNSdI6r8Fk050ESDfOCY8f7KqAhQrk
         U1wg==
X-Forwarded-Encrypted: i=1; AJvYcCW841Wg6GLDcjrM9G4LesENrGOXf6KgQdAnQ35tFOaz6uT9hqRwJockcfyjeE7v514G5f0AeEK3xXuuYRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGQAdW5yw1aQhOeMC4VnTc5CGUDTkjGA69+ALyWWh5XUe4P/6
	emPQvvAiRj92+wvIh7lLi1g24xzEdin0ENTEPSDSg+8wryYjQArS
X-Google-Smtp-Source: AGHT+IHGmmw9ddltXtCOaDOAvfUtOh/3b7g5A5OOuBz883Lm7wj/eh6DdPBaE0Yqlwi6rckUTlFllQ==
X-Received: by 2002:a05:6000:c86:b0:374:b3a3:3f83 with SMTP id ffacd0b85a97d-378c2d617cemr2256594f8f.53.1726169344445;
        Thu, 12 Sep 2024 12:29:04 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8557:476b:8cfa:99ee:514e? (p200300c78f2a8557476b8cfa99ee514e.dip0.t-ipconnect.de. [2003:c7:8f2a:8557:476b:8cfa:99ee:514e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd424dasm6917806a12.9.2024.09.12.12.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 12:29:04 -0700 (PDT)
Message-ID: <f4e58090-0229-4a72-9bb6-d57757eb708c@gmail.com>
Date: Thu, 12 Sep 2024 21:29:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vt6655: mac.h: Fix possible precedence issue in
 macros
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240911180149.14474-1-dominik.karol.piatkowski@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240911180149.14474-1-dominik.karol.piatkowski@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/24 20:02, Dominik Karol Piątkowski wrote:
> It is safer to put macro arguments in parentheses. This way, accidental
> operator precedence issues can be avoided.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> ---
>   drivers/staging/vt6655/mac.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
> index acf931c3f5fd..a33af2852227 100644
> --- a/drivers/staging/vt6655/mac.h
> +++ b/drivers/staging/vt6655/mac.h
> @@ -537,9 +537,9 @@
>   
>   /*---------------------  Export Macros ------------------------------*/
>   
> -#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, iobase + MAC_REG_PAGE1SEL)
> +#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, (iobase) + MAC_REG_PAGE1SEL)
>   
> -#define VT6655_MAC_SELECT_PAGE1(iobase) iowrite8(1, iobase + MAC_REG_PAGE1SEL)
> +#define VT6655_MAC_SELECT_PAGE1(iobase) iowrite8(1, (iobase) + MAC_REG_PAGE1SEL)
>   
>   #define MAKEWORD(lb, hb) \
>   	((unsigned short)(((unsigned char)(lb)) | (((unsigned short)((unsigned char)(hb))) << 8)))


Hi Dominik,

git shows your name with the following characters:

Author: Dominik Karol Pi^Etkowski <dominik.karol.piatkowski@protonmail.com>

I think it is better to change your name to only english letters.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

