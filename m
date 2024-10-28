Return-Path: <linux-kernel+bounces-384401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC849B29A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0276B209FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92F1D5CD6;
	Mon, 28 Oct 2024 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndIHjEOC"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B771D5AC6;
	Mon, 28 Oct 2024 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101921; cv=none; b=cGP7VlCPwW+0RcqopqjTBJzGEw8iUEGdbkiAKdHRaUjPaLO358kI/VzRnQ1nVan5d4i9f/UjFr5lTn+p+tjxdyCmRA3377Bj/hTVA99csGjNRu7Ek1Rx+hv3dcRtDxpnU9fOmETbku9cu/k6/wUw6+MzIQ94WL/UcSkP0qX6Q9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101921; c=relaxed/simple;
	bh=8L8SBjVc+uA+SfZvx5iBf5Qoo6mVUp7FizerDJZPIEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPFI7ApBKGRQfRXsmQZdaSahBifbiVVDlAsL5uSR5ag2hcW+Xoy82LUSZfpsEm8/6kzTgfmCT7aRnE2obYIwmOVi5r8fRPt8v5CM05dDtOkNPhbfxHVZ8Y/iiQTzSbunWt4ojCecGKvHt6Z118RV5uFUEgzizVdG3br25UpLak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndIHjEOC; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e59dadebso4636292e87.0;
        Mon, 28 Oct 2024 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730101917; x=1730706717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2t7PRpXCWMJEMwx+JkIvQ8UmWLLLuKvDIeT29JMOGv4=;
        b=ndIHjEOCd6K3pOEEhJmzTR572M7kxU7GdUIKa4z4zybNZzG8fcfHNgoX4OhxZhATko
         4QikAjQkmSjcBrbysRPKTQeHw+Cacmg++JXEVWhKfQ+Rafp43iC4SELedeSuIWko9CWk
         UzU1MKhEXEvUUfyjszYHMasNhv9oOWpXyHNx9o2HtiVrKbolXuJbOqPef4GMvnqIbkks
         u36JXzHbDrz6DOM6r2XvxzJ7v1imCgfQKF2R7nAhxcCBOlLszaFAvUp+oLYjbpEmtjoo
         KVOMeNEnf47H0Tvvisx4yJX6D0IotUDMSiEC59MM6gDj5nTy6IS6IbzBqXYDq/o0bMWs
         6hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730101917; x=1730706717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2t7PRpXCWMJEMwx+JkIvQ8UmWLLLuKvDIeT29JMOGv4=;
        b=o6TEg4Ga04WL1+1H8cEOSnsoVMUugZp203Loe41yfU4Iqdx5nlruzHDhY5CUwpqQVI
         ZcCXuG4UfCIYwjAtO6OQEprofPJWS29TJRXv8beDhJWAhLJdvhVxmktLqniQWKmSMAtw
         mKQdIdQTKuXygAxfxb26E/4orV0UyDru5qsIo9gE9Vhw8E1gNI0q0NOH10d/Xce13Q17
         NzK8I4gvBt+BRKdMIoUxe/AfyoNSGNGbRA+kyshyLm/8riCo//isB5rr4bfQRkuy9oP/
         XUABxkA8eCSld21pIpAK124vxU0xIvXzMkbJxPyAL4ZdyzqMa6ewrF1FTIPmz7HY0tj7
         0y/w==
X-Forwarded-Encrypted: i=1; AJvYcCUhaYsQi30ob+8NGjwr9LDDDFJGRjwb4VdYvheRHuHGy+FfCO93Tj6Qv+zYuicdvdZ0EV85OzwwmlJvWXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM23hZJT6d9zmcIEy9NqZDKIXKSVGCDpBXRtaGXe93fPA80kCL
	bB2cxzhaOkp8D/sPmL9P+ikaJQceOqwPZPMCg/PiloNM86kuCZ1iDlJMnw==
X-Google-Smtp-Source: AGHT+IFW6TuSGnQiPxqiYcrHg9zWINYMHlpXAWM7scBW7VsygkzbAV32/7q6NSFOD2XtBTB2kk4nLw==
X-Received: by 2002:a05:6512:3b98:b0:539:fb56:7790 with SMTP id 2adb3069b0e04-53b348ec010mr2832964e87.6.1730101916820;
        Mon, 28 Oct 2024 00:51:56 -0700 (PDT)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1af34asm995502e87.144.2024.10.28.00.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 00:51:56 -0700 (PDT)
Message-ID: <4387755c-896f-4fd7-be2f-2f54c5b074bd@gmail.com>
Date: Mon, 28 Oct 2024 09:51:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: add dma coherent allocator abstraction.
To: rust-for-linux@vger.kernel.org
Cc: a.hindborg@kernel.org, linux-kernel@vger.kernel.org, dakr@redhat.com,
 airlied@redhat.com, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com,
 Andreas Hindborg <a.hindborg@samsung.com>
References: <20241023113309.1724992-1-abdiel.janulgue@gmail.com>
 <20241023113309.1724992-3-abdiel.janulgue@gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <20241023113309.1724992-3-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 23/10/2024 14:32, Abdiel Janulgue wrote:
> Add a simple dma coherent allocator rust abstraction which was based on
> Andreas Hindborg's dma abstractions from the rnvme driver.
> 
> This version:
> - Does not introduce the unused dma pool functionality for now.
> - Represents the internal CPU buffer as a slice instead of using raw
>    pointer reads and writes.
> - Ensures both 32 and 64-bit DMA addressing works.
> - Make use of Result error-handling instead of Some.


Ping! Does this approach make sense? :)

> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>   rust/kernel/dma.rs | 153 +++++++++++++++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs |   1 +
>   2 files changed, 154 insertions(+)
>   create mode 100644 rust/kernel/dma.rs
> 

