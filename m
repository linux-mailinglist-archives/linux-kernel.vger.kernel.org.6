Return-Path: <linux-kernel+bounces-570741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0727A6B415
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB2F3AD866
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48D1E7C1E;
	Fri, 21 Mar 2025 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rozz1upq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324112E7F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742535307; cv=none; b=Gl4ASyE1Nh0ZQ+Kji/x6QuubWdErE2ePAxPozZqnURQeFur0K9vem9i+sOqI6I7NUIIyC81/FwEP+Jys+xGfiXvQfIvmha2X4o5v0DiLOqUz0yaMuPexEwLtHP3DH0nBdHqHuJ8aNJYg67FYYnS9Aok/ki/M2ZcoLB0Yy1xNKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742535307; c=relaxed/simple;
	bh=0a7b7Wx9t9BfDXpog/fI+iSKPBahd4wY4JXa4z0TCfA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F20fa6Nh3A2vIkuZYX7uwxvHqfiBc8LD7wFin/xpYumq2CbOB5rV5ERUYtEeVsDP/n4pTvmAWZx4myvuJe5RJsOBDEsPnCBqw3atxHjC3nywNWW+8NJuZXcnWnGu0H/xNiS0P1SwY7EC3FfOJNYxymdfvUt90eqBzPwD6KxXC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rozz1upq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742535304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMjAUNZ4CwTQAOy+D76GwsLMdMyaRCTmvcyaAxjE49I=;
	b=Rozz1upqIxLiEw7a8GfObmmCnvKtrmsq8lM4TOfqLF6HvM4vGXqtbaqzGWnR/TkdvoUgHp
	hR+CSyQstBWLhqygq84UG526CYpmdyuoCnAltN7eETXtEYBa6jrBc/hts10VPgBkZSZ4od
	bTU5UL7bthkXuunaLh2XPzIrYr+2qBg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-zR_RjSglOxWgz_GHt4bxOQ-1; Fri, 21 Mar 2025 01:35:03 -0400
X-MC-Unique: zR_RjSglOxWgz_GHt4bxOQ-1
X-Mimecast-MFC-AGG-ID: zR_RjSglOxWgz_GHt4bxOQ_1742535302
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2240a7aceeaso24504395ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742535302; x=1743140102;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMjAUNZ4CwTQAOy+D76GwsLMdMyaRCTmvcyaAxjE49I=;
        b=vW9tGM4lJ2oMjyjaCokMSjE86CLM/968AUodNDfaYqOz7M5rUofFG8QoTuPXkF1RfM
         BB0PV/CjmeOQO4mQ3nzMp5BLTwMIT5wTfOxF4mX0pxuCRTyUfeuuqCajeK/SD86KXL6o
         DrbHkAP4b2IhzilNhswAoNI8RShztW9t+SepUc0kx8lpHgkx326WCw+WMEyPk4dxFq3X
         ClZJ3DFinZLNCYdlRZd61zhZ3kSMoSPPTTbNLKYUTAz99vTzyATKgYqF8p4MEgaFn4bG
         UYEaiL/3tBwus262yv4zj2+rNAAHDdlRQAnUgc8RvVo5QFsxzkMtw/klLGZ4DrwsmUcL
         fpqg==
X-Gm-Message-State: AOJu0YwoeHtOJxZD6Ul36GJjriCMl+BF2WlB9aYH+6N6BtIrpgTBURZ5
	RBK5UZ22Rkwtsqo+B371E+b8pWpHBmamVhsDW1RvQ3aC2h/tJd1q/+9BidfgkmGdIjc28UnwUn7
	5lQNKH/buxp+7OUj94y/JHwlp3kyBDdsulEN7Nu/vTc0kNK+5o0cef34Pw5/+cw==
X-Gm-Gg: ASbGncslPnYcAsi7pAEynSvmUcwgxkDsgz9Ozk7IZ+423L2cYeaPqFlXWmrUWb/gF4w
	D4hpqpo/HoHr29xn2nuTrL7H54bxiS1PN6IEd1u2y7jTyDkRZ2qNu/puE86vnUzDtLzYifCg9aX
	uPJWP+W+D+h6UUybUMStCabgS0Vg0Tp7Sh8nNvNwvpsObMurv9qmklLWov5YItFVCjXK3EA5X7n
	y28V3n1xyyUhcpd0V22fT/xR2Tyi7bLJBUxhe7pffA4cHALzMcBp7a4h13705d9vx1w1htMeJfv
	3qGaVi0VMM+qC6W4oA==
X-Received: by 2002:a17:902:9042:b0:220:fe51:1aab with SMTP id d9443c01a7336-22780e3fcdcmr30779845ad.38.1742535302187;
        Thu, 20 Mar 2025 22:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+5TFY5QIybOCFPYbufZRYyuUOXtI2NZTA5/SN98eAr4pap9KU24UkSVHZM8SKIV+dQ4A53Q==
X-Received: by 2002:a17:902:9042:b0:220:fe51:1aab with SMTP id d9443c01a7336-22780e3fcdcmr30779675ad.38.1742535301908;
        Thu, 20 Mar 2025 22:35:01 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3bbf8sm7927415ad.23.2025.03.20.22.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 22:35:00 -0700 (PDT)
Message-ID: <141f7331-43fd-4bf4-88ca-36c18b02b133@redhat.com>
Date: Fri, 21 Mar 2025 15:34:55 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix parameter passed to page_mapcount_is_type()
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, david@redhat.com, vbabka@suse.cz, osalvador@suse.de,
 gehao@kylinos.cn, shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
Content-Language: en-US
In-Reply-To: <20250321053148.1434076-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/25 3:31 PM, Gavin Shan wrote:
> Found by code inspection. There are two places where the parameter
> passed to page_mapcount_is_type() is (page->__mapcount), which is
> correct since it should be one more than the value, as explained in
   ^^^^^^^
   s/correct/incorrect

> the comments to page_mapcount_is_type(): (a) page_has_type() in
> page-flags.h (b) __dump_folio() in mm/debug.c
> 
> PATCH[1] fixes the parameter for (a)
> PATCH[2] fixes the parameter for (b)
> 
> Gavin Shan (2):
>    mm: Fix parameter passed to page_mapcount_is_type()
>    mm/debug: Fix parameter passed to page_mapcount_is_type()
> 
>   include/linux/page-flags.h | 2 +-
>   mm/debug.c                 | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 


