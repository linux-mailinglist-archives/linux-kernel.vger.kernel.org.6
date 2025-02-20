Return-Path: <linux-kernel+bounces-524667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4CDA3E59B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CAF3B97F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55145263C91;
	Thu, 20 Feb 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABvlcWPF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C81E5B6C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082132; cv=none; b=obFonp2CHLyxcW37o+Ym0i7Gs5iel7B4FrFm/fjf8g+eQQfPz853k2AhmMC4INVJNrJAhJFTPIznt+i0GaenyUd8GEziXNi+E0FHFQB1dJNezausFAifRSEnDXYfB+qSgMJTIQFrN4baxnD8HjWpS3iJ7XAYGihyt6X/8wgIFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082132; c=relaxed/simple;
	bh=bUcgl4rVXmQrKngoe1WbznKw4ox2Os8zmuoIyBD7sx4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l0uYi6BIqFyYmGJpQj3TTkEpxTSLDtMFt8w7g8Fbd5mDsy0wdxo2ZjmCfCbVlOTvmZ4n69mZzWmiZeywCFUHphN/UkRys1pknEBln0HmtW+2RhEMHrIlFLI5SwTyea76Rla8opuGEisQCgrl3JkPrk9iPaAdlTK5UYLr8wm1+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABvlcWPF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740082130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUcgl4rVXmQrKngoe1WbznKw4ox2Os8zmuoIyBD7sx4=;
	b=ABvlcWPFBLq5dFFPrwG89GlxtsOBm+Uv+Or7/aJaj+YMv7fuzU32x59pU/G7+c1H0kmUAP
	PcWI3k7M58PfjGmC21/9zjWYuzuJbuv7wf2q0ekVX2xij9nYC4TbSkrd/6iYQ6YHH/i8j6
	1Sh5VOuPmhaCFihWKtOh7xDa1Ei6CPs=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-zLheuhqaOQ6msqY_DLr0UQ-1; Thu, 20 Feb 2025 15:08:49 -0500
X-MC-Unique: zLheuhqaOQ6msqY_DLr0UQ-1
X-Mimecast-MFC-AGG-ID: zLheuhqaOQ6msqY_DLr0UQ_1740082128
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-2bd106fc853so431305fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740082128; x=1740686928;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUcgl4rVXmQrKngoe1WbznKw4ox2Os8zmuoIyBD7sx4=;
        b=CYjgCqleHEb2W81Tg+996NKSt8ru2AEw2RW5FjOK7M8FwFoyeXlSdkJeqWrZ8Ran7K
         ZEzPifKw2EP7WWIbQpFYdpCXgHHTBf8hOTrgTuj/RDO9c1F1cuNKndTzVrS3fReONoQO
         EY28crIz2oHVxe+oB7dwx1bMPI/B6PlDyitTRfhzf/kbOyHFEcBMfyIYMY3OXZzufy4A
         JsKaNGyui6CFSwrZxVdPAr5/hZ3jJPfNy2LCHbPntrV9pxObfZwa+UbjljikMHl4f7wS
         ICmIJ+7GVZPeZFhBK7lBGwdhiB5EA3qs/2LKxNUa5odkAIYHY6zUwp8KN62FFH3niaMb
         UUuA==
X-Forwarded-Encrypted: i=1; AJvYcCUm+m8ftCLW6/Z9wfxzljU5+MVxoUQrhfyjMi8hnS3IKP/zYQmKPQMTwNZbNx9SSZbaidhkq9eSWOrcsM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4k36QMvKA5U02jx/UHy7Q5BS+lcyEKY2mULsMU63GFEPZIQox
	eBv/jawoGVGBca5q/1rreLnYprpQuJSSISCiEflIWMwDnM7sr7c5navVsYyISMO8aFG80GhDazA
	Ed47PMvWFoPLdivgTUttrCv9gzPBYiWHlxrHt7pQcSsuXRKkOj3jZE+ExPa7Uv+soWwkwVQ==
X-Gm-Gg: ASbGncumXalV/w6Q7RDEt2ZKtQYAwXEAQKRHvy/M5dXxif7bycCDdkvCh+QE7ZwbC79
	yilpnf+33SmHzU3hlnmbfydSEEmMT15EQ6ikSbLq47SWZRUvZI4/1ri8WEQ2xrMM6yLXohMmU2z
	j2pGKfPi1Lw8MFun+VguVmrPzFAvzhwGaHLb63LjycazrLcuuua4T6RheQ+c9EBpavuXuYw8+NV
	xSTBNCf9YJ4ctXXq02Rs0eJABULMirfo4GT94MIuRQOiYtX7NlBL/B4nptD38hhrvfQrUIvGqac
	gMdz
X-Received: by 2002:a05:6870:b95:b0:29e:49b3:c50e with SMTP id 586e51a60fabf-2bd50ce4bbamr370617fac.13.1740082127988;
        Thu, 20 Feb 2025 12:08:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe9342oPIZG//g9JgOUMui0T25XJrgIig3V0XkaOGhuWgvmb9iP2uS/sVjbqH8Nkoz2prZdA==
X-Received: by 2002:a05:6870:b95:b0:29e:49b3:c50e with SMTP id 586e51a60fabf-2bd50ce4bbamr370591fac.13.1740082127624;
        Thu, 20 Feb 2025 12:08:47 -0800 (PST)
Received: from [192.168.2.110] ([70.52.22.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b954875e0esm6549636fac.14.2025.02.20.12.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:08:47 -0800 (PST)
Message-ID: <dee18de8-7938-4df1-badb-c00832d6995f@redhat.com>
Date: Thu, 20 Feb 2025 15:08:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at arch/arm64/mm/mmu.c:185!
From: Luiz Capitulino <luizcap@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org
Cc: ardb@kernel.org
References: <a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com>
 <fe95f4c8-4b09-4d8e-99c9-987ddc2761e3@arm.com>
 <9f5600b3-6525-4045-ad1f-4408dfc9ce0f@redhat.com>
 <cf2b32a4-2217-4a31-b6d7-e60a9f4ef7dd@arm.com>
 <789c17e6-5ebc-4e37-93cd-19d24f148fd8@redhat.com>
Content-Language: en-US, en-CA
In-Reply-To: <789c17e6-5ebc-4e37-93cd-19d24f148fd8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-19 09:40, Luiz Capitulino wrote:

>>> Btw, I'll try to bisect again and will also try to update the system's firmware
>>> just in case.

I tried to bisect it and again, got nowhere.

Git bisect says the first bad commit is 8883957b3c9de2087fb6cf9691c1188cccf1ac9c .
But I'm able to boot that tree...


