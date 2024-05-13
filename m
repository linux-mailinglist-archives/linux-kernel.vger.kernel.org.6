Return-Path: <linux-kernel+bounces-177767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B4C8C4465
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630D81F249A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785AC154426;
	Mon, 13 May 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLYNKUSo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2218F153BE8
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614677; cv=none; b=BBai8Rh0Dsr9BWluIeWqEq6aN8Mrg7+otmekYbgjdnCqBBkWz7DvThyCCv1TRUvFVxg/f5xMKmIMrY6jlWuEifZf5huhTkcSHY+yEC41wdZ5hCSC9dXkGoIq1ExcSlJXu8+N5z+lCqXg/0CozBJyyrxsY+G9cOeoIApsBBcBfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614677; c=relaxed/simple;
	bh=0IPgfXi4YsIdu7St5I/mptJOobgfC66LagFw65H2aO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnGr0N3XyuVbECpistylTm5U+Cx8995wC1b90UD2sMgBV+23Wnced3mRocnruNpqhlYa/hsSnqQEa2t4fexqC34NlyyS0xtnR7kD047ncEltoedrnAGv2+CjTodECdZVwhyxBYRDqve4kVlA7rjYExtglcJeTUtwd0x42PSizyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLYNKUSo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715614674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wJzejjZ7wyC0pvU1EsabLwRXWb+hBDMA4WAJxO+ZbbU=;
	b=gLYNKUSo74ACO8y4SZaYqffzkvRvBnXt5rHh9sUh925LMgy5dBOWzzaitQMwG5avmdYSF9
	XhLSKOzkylYy37W7s0P1mFctcQm1GC8ChfiTyTI7qIQ42YUAVZArurx5LYfC++QRRtkhB/
	kT6vKmpUKwtOsZ4Ehh4J7KiTXi2+ZN0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-J4REKAndNlGr1V2C8l5HMQ-1; Mon, 13 May 2024 11:37:50 -0400
X-MC-Unique: J4REKAndNlGr1V2C8l5HMQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d396a57ea5so3510073a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614669; x=1716219469;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wJzejjZ7wyC0pvU1EsabLwRXWb+hBDMA4WAJxO+ZbbU=;
        b=crLGjbdxptcqlqXrDXlueJuYrNKdl+/0ycla1GMrJZ12pHhRMO4/Sxw/5h9N43fe+D
         lywQ9C97/xVZuvlmNbrdGSQBPCaYUV9hhF8zAvuVi9yOWHZZMGaR3Ujx18HfF+grJzdC
         f1aGHKCVXjjrRoXC1US/ETVvl0BqH3EJ631C+ttX3FyLBNhiNdtwWk1yc6y9R7W2zuZO
         OyTmeFXVMEpCP4y9tqhIgMBPmR3+WJlJlcVVw3wwSE6eJrR5fQhlhaUf+zMYfKkzvgfa
         tqeCQFiyhSmQCPBo8OK1h4MyW3bLg1m4gFu3yUpWqCU9aO4Sw/pPMJzqswQuSxx5Pn0P
         tBAg==
X-Forwarded-Encrypted: i=1; AJvYcCXMnu1q9mZJnhOs2IYXQoW7byzwGbF0kURHXJZyNaQRzJ6YjPAa+OV/hVPRH7t4Vc2O8rR9D+K6EvSj4KPvaDm8U+v2SUZlzq8s7SXH
X-Gm-Message-State: AOJu0YxEfFSIYiDWeRdVon1a0ovDgoqu8nkBoWmmS2EdD/j8IOUBh/gA
	pNBsB5xuZvoCjARMgK1XxiHMvP9Gxg+XZQp11drMVIKv7pZiQr4GbWg1YM0PikBrmPUff4hEeTw
	PCMk6Rywu554WGb2NR88wXRagVJjEMB6+gWWClbsyW7NhE4upt4QRQ7vZUYeU0A==
X-Received: by 2002:a17:902:f693:b0:1e5:2883:6ff6 with SMTP id d9443c01a7336-1ef43c0c9e8mr122433845ad.11.1715614669022;
        Mon, 13 May 2024 08:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIagRKbnk2PsYN6IJltSoikH3OKsV/glVRLpzmc1Uk0bbHIzQ2eLNRb+ZccYA4eZJoORARMg==
X-Received: by 2002:a17:902:f693:b0:1e5:2883:6ff6 with SMTP id d9443c01a7336-1ef43c0c9e8mr122433565ad.11.1715614668469;
        Mon, 13 May 2024 08:37:48 -0700 (PDT)
Received: from [172.21.1.2] ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c256587sm80346885ad.296.2024.05.13.08.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:37:48 -0700 (PDT)
Message-ID: <7a4d4992-4c8a-43b9-8c41-a938bc3cec67@redhat.com>
Date: Mon, 13 May 2024 17:37:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: optimize folio_move_anon_rmap()
To: Chen Taotao <chentt10@chinatelecom.cn>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240512123555.8358-1-chentt10@chinatelecom.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240512123555.8358-1-chentt10@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.05.24 14:35, Chen Taotao wrote:
> When a folio belongs exclusively to one process after a COW event,
> folio_move_anon_rmap() always moves the folio into the anon_vma
> belongs only to this process.
> 
> However, if the folio already belongs to the anon_vma of the this
> process, we don't need to move it again. In this case, we first
> check if the folio already belongs to the anna_vma of the this
> process, and only move it if it does not.
> 
> The above changes may improve the performance of vm faults in some
> scenarios, because the performance loss caused by WRITE_ONCE() is
> much more than the performance loss caused by add a judgment.

Please proof that by real numbers. I don't think it will make a real 
difference, and we likely don't want that change.


-- 
Cheers,

David / dhildenb


