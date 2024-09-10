Return-Path: <linux-kernel+bounces-322432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536849728EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEC5285B11
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF863170A18;
	Tue, 10 Sep 2024 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kke2/a9L"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA547167265
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946563; cv=none; b=PBeA36BcYJlUvDUk2kW7Fhd/Ox1eWSgAsuVhTIGNNI+VAu4Y0YblcWxYG+YUWJzX+wUcxklK+hlL+OsOEBipJ85sJcVANvw/WhxUZJce8JSK1nRKr0w0OvkqP4+vV6QNXhwegcVIpWPJKJ3mUVziYUMuYB+CIFxqD11hEdTZVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946563; c=relaxed/simple;
	bh=/qC3d5HW+DGJD/g6O+fEv4NuAihwErpe5X6U3mHLd7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWNQgvdSywKPJBTAOfAqIV7kuwHuftEmaN2xur3t0+Ke7phf3QHwguzI3z4vclvS31C/Abz/7VQEkqG0bwdw1tGlNFN3XMqCj5l1vb8Za16MPBzXEVvBI7zY3RKeUkFCoIdteEeR2hEtolxbyh8s8dOhHnIhxFO57gZ0wU9Y9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kke2/a9L; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so460574566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725946560; x=1726551360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rob6GRXtYDNA7DhHsgmiePqlSPWTvJEWrfOPcbfODMo=;
        b=Kke2/a9LLb0PFUB0EjsqBInoZzXOyectCael/0TRVj2fHkncPPS3HNBcGLf7q5ZJRz
         Hbonz8u67YkoOvgZrPJCDRwepBeGH9sE9aQrPAl/rP16MKPcmQjCbJ2wpQM9NbvsZXqQ
         ISpWUZ8KiNRLd1S/tpbF90fS6zvqOQa0Rp1VxpKysK/np4OLNyM77lgNwMs+eEYCr4xp
         vGJ8r9KelBDeK/pSBm7mrxgoKl0Ord/SqmpjiZhRpJwaEBgZcpiJp1obCc17/Ilea1PQ
         iYUXrA9dFHHX1sVpHsx1d/QY9HGEtCmrxTvLY+1i4e+usd2ZX4fMfhWp72VQTGV064u2
         G7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725946560; x=1726551360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rob6GRXtYDNA7DhHsgmiePqlSPWTvJEWrfOPcbfODMo=;
        b=RrWkPBBBcSY+YCafRiP0t9SzS+V8bkh+dBaNSYczNE+yFIfi2M5Ypr/wYZ+9Wo9gUO
         zIDeThHvjW6OuQh4spFolu215kOGE2yKT0E/gFoqzxbqQ3YG7AjTHIQ2g7u2Xf8QFolU
         8n4OzvMXSAN5LYfwYWiylad1M0PS1uednX4Vc+W/EJyFyr84Xz3Br5uFJHx4GQPWEm3a
         b5KH14JUsRgI4JNQe81oHk8WiSjNUBfdgrpnJscWSkBHc5EV2FDAbZMRPUFVZ2OUJFg6
         CIZSeZs3xwTyXllBDKIua3p4cHfT5SuWKopDNKrK4SJb3EnQ9InQ4I7mxPwiqxLU/kP2
         A2pA==
X-Forwarded-Encrypted: i=1; AJvYcCWqQLQJLSJbnnDV6z+B/zb5BsjGNtPMGhEisvWpzaxvAgxNljPjVn/O4jPnVOIX01V9y0KgGj0j6QFvw4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjgxMo6G/k8Eo3FlFqcdJ/jy2iS2tKokdRRazeckXE2LYr0D98
	hfa1X91BMVZCHfmcWk51Eu+nw4V8X9qB1lP+ahZ2Ye2Bb6asuGBg
X-Google-Smtp-Source: AGHT+IEe9Pz6RHgUxmA7q53brln0aZhwJ16V895i0+mEtPsa6gF0H0ro6Xl/FUkvGVPIUAnf1uGN9g==
X-Received: by 2002:a17:906:dc8c:b0:a77:d52c:c42d with SMTP id a640c23a62f3a-a8a885bdfccmr1189339166b.13.1725946559741;
        Mon, 09 Sep 2024 22:35:59 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29? (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5dc97sm430359466b.212.2024.09.09.22.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 22:35:59 -0700 (PDT)
Message-ID: <6e2d4e6f-1587-474c-8730-482e702f1dbe@gmail.com>
Date: Tue, 10 Sep 2024 07:35:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] staging: rtl8723bs: Fix spelling mistakes
To: Roshan Khatri <topofeverest8848@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1725933169.git.topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1725933169.git.topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 06:03, Roshan Khatri wrote:
> This patch series fixes various spelling mistakes in the
> rtl8723bs/include/rtw_xmit.h, rtl8723bs/include/rtw_io.h,
> rtl8723bs/include/rtw_mlme.h and rtl8723bs/core/rtw_xmit.h files.
> This patch series is created after receiving feedback on
> individual patches.
> 
> Roshan Khatri (4):
>    staging: rtl8723bs: include: Fix spelling mistake in rtw_xmit.h
>    staging: rtl8723bs: include: Fix spelling mistake in rtw_io.h
>    staging: rtl8723bs: include: Fix spelling mistake in rtw_mlme.h
>    staging: rtl8723bs: core: Fix spelling mistake in rtw_xmit.c
> 
>   drivers/staging/rtl8723bs/core/rtw_xmit.c    | 2 +-
>   drivers/staging/rtl8723bs/include/rtw_io.h   | 2 +-
>   drivers/staging/rtl8723bs/include/rtw_mlme.h | 2 +-
>   drivers/staging/rtl8723bs/include/rtw_xmit.h | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

