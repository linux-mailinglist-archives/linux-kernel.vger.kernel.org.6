Return-Path: <linux-kernel+bounces-376784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234619AB5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E5628449E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CF31C9DCB;
	Tue, 22 Oct 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bx7k/30G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DE1BD516
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620841; cv=none; b=rWsCLk2a5qTU/iiPQ+7z6CkA7PeHJxz//Pm2ANd8Al4UuyBkQY66RZ34wUnBhqRQgs4gipOBk5/Q51D7Wlu2rZBA0MxTOmGM9naeWG06lZQzw1+4TdjwuLqBqnOKAXppxFCgE08BPy/pqnFzM0ywbNXYETvJ66ZuUWB0EGqKR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620841; c=relaxed/simple;
	bh=R1ADCcmYY8bcO+znJxrVQjEFw/yCprdH8NZua8vsz8I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cp52YnMBfDi6hb0DhIhQwY3lllPEAnju3AAUyMyeOYPC7aB+34FclsJ5wZgiA5c6HhIMwzdpQu7Y1JkZwexebclBdHu2igkUF1Tlmsr5sLv5GnbVOB6gW8o5XkRXTwRK1qSDreZZnWxvzbPMkY9w14Kv1kAfzJ40IFO+A5t5jE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bx7k/30G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729620838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nmEAuKJ1898rv/iT7aiiwZ8w/gvt2Ka8z3DW8Hbnbus=;
	b=bx7k/30GPap1cKWdgdUXj1S9jVNDLGqwDOq3E3BUrFEydSfJ7WFfresTyHDhiCvelGzkkO
	GHpFQ/e4/jZf/N8Z6Qa3Nzg8G+NmnDT9/M+gMpX0HZomg5qHfOFmJDSYB5cbNbWF5l33qJ
	M00kBd9bV6YQh99bQsr4AYTxaVNbZ1s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-lVuCDymPM_O0f_Ao7c2T9Q-1; Tue, 22 Oct 2024 14:13:57 -0400
X-MC-Unique: lVuCDymPM_O0f_Ao7c2T9Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4317391101aso17713725e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620836; x=1730225636;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmEAuKJ1898rv/iT7aiiwZ8w/gvt2Ka8z3DW8Hbnbus=;
        b=cgSkvfPEJWvPIaK8smstJc8/QD6pjVlCDHxwHAu2YhUfpGEJTWIFewBLOVm6XS+0mj
         12RcBjozaD+PODEWW+PB/51vpuMJpUn8JtEHW16zi2BZV6h4hWFQOygdJM49/93Jh51g
         0y9ZvRCe/lpaxnw6kjSwQdQS47VD3t/SXYiG+LFy9IsYv6V0FXoPODDjR+fpcgAVWmS3
         lZFEKicwbdi1Hfg/0LVsl5OQkopCPphyHjDLB/Ir8o//TQcLlqzcOTWXx65e2KBIS22u
         NQ5J/poyb+MHdb1dE07VxfJ9Juq3z18ao/a7qz6DGiGPHKzbDfGMRrYVEalTHHovEZ1K
         15dg==
X-Gm-Message-State: AOJu0Yyvh+rloaJbmSsD5DckzNOWvC25exJsggLnjqvYUKIbOO6JX5V1
	1lwoiDcr0l2clKLG2woriy5QRATRnkSZIy8A5/rXvdOCELYVPxEKYMWuDSK7rIz65EhUqChf4h5
	JWA2e/5rusqtfSo5OYyjz4OACaSaDTVadAXF96OxL4YsjDJDYwmpBLrH4Jkc7HA==
X-Received: by 2002:a05:600c:46c8:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-43184209b20mr589225e9.19.1729620836190;
        Tue, 22 Oct 2024 11:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgVuJF3tNyoKR0ZpMUyC1gfyUykk6LdqiHXZPy71+bi7Q8XRE563mRg53z0FisKX5Op4RymA==
X-Received: by 2002:a05:600c:46c8:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-43184209b20mr589135e9.19.1729620835815;
        Tue, 22 Oct 2024 11:13:55 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2b46sm94231575e9.36.2024.10.22.11.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 11:13:54 -0700 (PDT)
Message-ID: <834e8e07-b77b-4921-ab42-87cc434f50e9@redhat.com>
Date: Tue, 22 Oct 2024 20:13:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] microblaze: Remove empty #ifndef __ASSEMBLY__ statement
From: Thomas Huth <thuth@redhat.com>
To: Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20240502173132.57098-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240502173132.57098-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/05/2024 19.31, Thomas Huth wrote:
> Likely an unnecessary remainder of the scripted UAPI cleanup that
> happened long ago...
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/microblaze/include/uapi/asm/setup.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze/include/uapi/asm/setup.h
> index 6831794e6f2c..16c56807f86a 100644
> --- a/arch/microblaze/include/uapi/asm/setup.h
> +++ b/arch/microblaze/include/uapi/asm/setup.h
> @@ -14,7 +14,4 @@
>   
>   #define COMMAND_LINE_SIZE	256
>   
> -# ifndef __ASSEMBLY__
> -
> -# endif /* __ASSEMBLY__ */
>   #endif /* _UAPI_ASM_MICROBLAZE_SETUP_H */

Ping?

  Thomas


