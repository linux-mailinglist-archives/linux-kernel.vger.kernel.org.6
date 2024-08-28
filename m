Return-Path: <linux-kernel+bounces-305504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60066962FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939E71C23D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3261156649;
	Wed, 28 Aug 2024 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvNY9uF6"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3E2747B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869166; cv=none; b=nJZdOUwwvcp+q1Je9fMTPJFGH8EK6ujHyCXxGRlgP9aCI/G+uZjlBPwuHZnDLwDVo1b1OyNPcRzcys+4mVRg2LCMGmsOqlqX46KNz+0apf/AljhkBv6HaM7Zh7oVjHtIVpYJIksEjU4Mj9vjLxlmlwKBmLwggPCIh4T4D+GP2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869166; c=relaxed/simple;
	bh=VYf0FLEIruLhqU+c7pX10cJgxFA9uzvQv4RY7T3laNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2b9G2GsyhaZ+8SBiiXyvSN0qo08iUijnA33OkbtQDCxfYrUCTHNlWgO17idXg84L7wzTWRxwiYOm0FD+QJBrmTcBKi2eg/8K/7yAifhPhujJPQ9HtebJf/JLw4OYm7yozs5V5MJ6PGPorFcpCuOOSy610+i/eT6zq53hvjsZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvNY9uF6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a868b739cd9so846961266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724869163; x=1725473963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ll9ymQRK3c89EjXOhHQT99dVXSCw3AdvtufLABRmB1w=;
        b=VvNY9uF6onUFUeDadoyNjdfGtywonHsh6T5hY3fQ52fg6e5GptxUiqYwvQoSkHT/dj
         aQNtpNTH1GLA2rubDstGd/c0Mvgvh3+WutYXxEd98+yPPPid5F/x5OzjFOaTlYof7WjX
         FFJ3KeFVq/mM7TYlUzs/atyvx6R7k+fFDGZp/zS6wzFPj41wNgA7Lo4Tu0WZS18Oa7eb
         syWeWNwvr6UyeEk31e/2tS4k9nbBHdgeyI5q7egNo3Qk3f+MyZvS3mcYU3bii00a+auq
         AaqNAQ6kabID+LdaM+yu3axagjfUOkPVeI3iAdE3ftgRXxOSPSmHfaGx2mjQPLWXEdeX
         lBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869163; x=1725473963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ll9ymQRK3c89EjXOhHQT99dVXSCw3AdvtufLABRmB1w=;
        b=AXFt19V7aG4LlGq1tNpP03ZiUn/jBU4T+M7LXy3Ji2NWvYZ6de9zYhvEX/au6ZeBtw
         /0DUiH0XvnJCGV34sJc2IztCixmrFvqY8YnSKHTDwq2iYHmP4E7QGlyBkom0VIHtcSGJ
         8p+B3dXoB3YFrHwbCspB1MsUGo/gv6LmgaonSDxbL3z6ta0wbMcNyI3wqK6m3RT925DT
         2K3HTAJZySMorraBmXUDs//27bMLd4ZrGUau8HAvt7wMVjlN0zRumqGowtvggnwD4l5r
         RfGTNXmAytAH9gYQSUKn/qVf0IwCWT53NGXoNpp6M+r14O29+X4cFPh/nm0GbHiNiRH9
         8gxg==
X-Forwarded-Encrypted: i=1; AJvYcCWA/BHQPGA+D92sK6rhYbhoD2zHcqqzv5fEzh+cIARHAy6GRAFcgnbyh6DewaxoL78QnrLYto6JNFgOjV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6EjVJsmD8pG2bwdmj7dVDf/Ox3Na1GkJ6WeN6Mm5E43KAdWO
	Qd9gQnsrG+nMjC1f9gDafGW+3hHgafeVQnij9haf4QPBtWqHtmTm
X-Google-Smtp-Source: AGHT+IFC2Ev0cl1EQk+8n2j5eX7pDfbLUfTbTHVX9l3u/QRBzew8sNGv73RCGUqMWrcarR5Lyc0fyg==
X-Received: by 2002:a17:907:da5:b0:a86:67e7:c740 with SMTP id a640c23a62f3a-a897f84bbf3mr24063466b.17.1724869162561;
        Wed, 28 Aug 2024 11:19:22 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8553:56e9:1165:4741:30be? (p200300c78f2a855356e91165474130be.dip0.t-ipconnect.de. [2003:c7:8f2a:8553:56e9:1165:4741:30be])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e594e5c3sm269743266b.216.2024.08.28.11.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:19:22 -0700 (PDT)
Message-ID: <6d8c9d38-0df2-4aef-975d-6a0eb9594513@gmail.com>
Date: Wed, 28 Aug 2024 20:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vt6655: Update maintainer in TODO
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240828144545.76022-1-dominik.karol.piatkowski@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240828144545.76022-1-dominik.karol.piatkowski@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/24 16:46, Dominik Karol Piątkowski wrote:
> Commit ed394dbf5371b03a5335a7ba1973ba124c0ced3d replaced Forest Bond
> with Philipp Hortmann as vt665X maintainer in MAINTAINERS, but
> drivers/staging/vt6655/TODO was not changed, rendering it stale. This
> patch fixes it.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> ---
>   drivers/staging/vt6655/TODO | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6655/TODO b/drivers/staging/vt6655/TODO
> index 63607ef9c97e..529bc22cd608 100644
> --- a/drivers/staging/vt6655/TODO
> +++ b/drivers/staging/vt6655/TODO
> @@ -18,4 +18,4 @@ TODO:
>   - integrate with drivers/net/wireless
>   
>   Please send any patches to Greg Kroah-Hartman <greg@kroah.com>
> -and Forest Bond <forest@alittletooquiet.net>.
> +and Philipp Hortmann <philipp.g.hortmann@gmail.com>.


Hi Dominik,

I propose to remove this two redundant lines from TODO as it can be 
found in MAINTAINERS.

If you like you can remove this information from vt6656 as well.

Thanks for your support.

Bye Philipp

