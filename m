Return-Path: <linux-kernel+bounces-327158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D1F977148
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD82928C887
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6581BFE0D;
	Thu, 12 Sep 2024 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHyMOkit"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442E188592
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168282; cv=none; b=b7AIedTh98Ti6aFNX/JVk4U7YlvbPTHzlnsomxK/PwP5a7GWgmhp+NX8Gnc88T1FZ3Hf8DOt/UaeEzN1PMuT+jegnPur2Kv6fX1Ct6+J7N4I8H0KqdCwlxw7sN3xRk1d8wKj+16yh90+KW3W/LkM78kpE5Jlcwh0qFnCDor+pu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168282; c=relaxed/simple;
	bh=9pxMsq3kin+w7i0XPqkWPMNX75/Iai09DK3wFfzOpDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EI1T2j+TFQONUlDvCyCxkwoe26ofa8iVGM5NzCMpgaDd/E/jxwp+IUQ1XpiqHm0G7j35aArl1eYDN7s8o2y+Dff2nepiArwh/lSiNH4X8x8wk+gaLsow0vXUzORC9cPKJ+ZB4bl4tkM+SkTeqtMd4Yni/5vyqyheDbpwnaKusHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHyMOkit; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso181707266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726168279; x=1726773079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sl3/RAaMWaN7KZUdljkIsdyNaNAnnUZU/wp9mRU9gvs=;
        b=WHyMOkitHswvnuZTeGmGTPqShXCjqGrj66Cc3pUZZpNKuaS5u8zo+azfAt3cxiEWnS
         WhBSMPLdJUUmM/N9mYBBHnP9fmqvrQT9Y/pu0fDWhb0gGvi3cmU3dhJOeifs3uXJH03j
         MFXQxbp5r21tkli7kf70sGXDjhCICorWLgd+VtW9HkcBG28bmBxrpHqU00E6bwAVEXeN
         e284g/r7Pu2WY3FZ8bhyUgUMmLSfPF1H1bcO8aX3HOYwJOL0/iX0Vt/QqTH5J6RYMaIR
         5+F4lltdWUEEGz6/b2LRZtjyQqpySZRxcORD446EEF5YDST6pFAiMp3WjmfkE3zMiw33
         xCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726168279; x=1726773079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl3/RAaMWaN7KZUdljkIsdyNaNAnnUZU/wp9mRU9gvs=;
        b=q4qFsXlEWvj4K/jxwGq3xWdepQifqiwcarXA475lMHlJmWDKDuNCrTRmV8UJnh/H7h
         pErjm3blVHgW21diq8lOxkAJelCh00x5zgJmi68gJZP8fIGh6kQPWh2LydfSpEAp2lX2
         G3IP1z9sdg6sGP75RYtT/XC0LGTHdt1f1TNhbPH/Bza22zPi7wqAaDO46jptYMLTp1CD
         N7n4nbE5cceFFVvZhtjOXnuu0l1kM+eXfVFxqT9IBXMwqjjHEKd1sWMgjBKjRGbCzyS1
         BckV0AjOD3yvuFKrlIePOQUFgI02ktMVbzVGyG7cUmx/ou68jhe/k+qRmHZp1Rr+brlb
         4u+g==
X-Forwarded-Encrypted: i=1; AJvYcCXFxUXjiPBi8MutsNBXXJc8MRqyIVBbGqEJQcYyMpETzD55qh93f5EDZl05OON3eUenuvDNeXU/iXTvT98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFJLtVnIc+KXL1izwZRO1PpMIWtEYFGHVls6TughitkbECZei
	j4hTzbUYVdPsbCL80k7oVToCh3KBM/fSPIrL0uHRyXFt/g4o7Yll
X-Google-Smtp-Source: AGHT+IHcNFOerQ/D4yBwRvRNcqzJx7r0UcshDu8UsLrFetoBEvuzw+gxeLM+VCafpwaT0zaK4PgpqA==
X-Received: by 2002:a17:907:948c:b0:a71:ddb8:9394 with SMTP id a640c23a62f3a-a902961794emr374570166b.40.1726168278335;
        Thu, 12 Sep 2024 12:11:18 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8557:476b:8cfa:99ee:514e? (p200300c78f2a8557476b8cfa99ee514e.dip0.t-ipconnect.de. [2003:c7:8f2a:8557:476b:8cfa:99ee:514e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d7360f398sm418431166b.5.2024.09.12.12.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 12:11:18 -0700 (PDT)
Message-ID: <6141d6af-a959-41af-b612-33c8f4e16645@gmail.com>
Date: Thu, 12 Sep 2024 21:11:17 +0200
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


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

