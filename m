Return-Path: <linux-kernel+bounces-191915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E208D1604
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988071F2327F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528E413B290;
	Tue, 28 May 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2znaVz4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9917E90E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883970; cv=none; b=SGCTSvJ6pvY5u0oZDDVU1EmU8I+YmURU+QW7v11xrULLoFnGWPRqbs8oQ1HhkiJzpfJYLY4n1/P6C/SbKuiTKzVC+D168wC8mt2K68QXDmY1eijf+psjjg3lDtz0PJBa30zS6cf3e/8KPIFwjgjDM3CoX1kKlsKGDmj7QdRzvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883970; c=relaxed/simple;
	bh=pHYIdUvwpmXyHHvE+ScJnWuVgPRd23jG00vDX0YcGas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzQgz5HKEoOBsfFIFyBIqK2F/NlS3PvsK2PSJ/xLahmjr4TUbLs4ATvzrWip0uSH3WcqYf6GTCGCQr58i1V1MA6dsn/9q/MV//q7l4O7Ua8xDGOODF/D8Hd/jfeQtSJJgPpxSxkvSaJm72Rt8W+ClQXoQ0m1fF46XeaGeKKn11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2znaVz4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716883968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKBEPyG+5W8cK/iK+EkQ1hq7j33kk7UmsuoAeszgqGQ=;
	b=O2znaVz4eiLg7qaoSVt3WSy8uShoFflzq99h3Eg+g91wZo5r6thjwUrbDi+xk+c4kOUXJ5
	FcSreIRkoyzzmUAgjkBLk0QAQ/VOpflxuvYXW6mK16pY2Lct/iTrlq9zlWw6cOMN28jzxp
	CyQ863XeJbWoE3TGuyAvmCC30UKRXR0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-hiA-KD9hPpy1cA3TsXBz-Q-1; Tue, 28 May 2024 04:12:46 -0400
X-MC-Unique: hiA-KD9hPpy1cA3TsXBz-Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a626919985cso313019066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716883965; x=1717488765;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKBEPyG+5W8cK/iK+EkQ1hq7j33kk7UmsuoAeszgqGQ=;
        b=s2Tt+ApqS4WKnNbAK/xbO2yMpvJtQev63bKsnX8MxEoeMNl/XVqqXQJmd+RiXWB7nD
         IXN77vzFPnBy9MGHZZ7XeU4s3llqTDxLENq6sSJcw5qPDyMkD5Kco5F9YvadZ2GOzd/W
         QBOtCE31EmK0/mHprKWFo82vT4Ac3zHyxqOdPVcUVNGYh/WvktK1IaNfFpiu6bul3DEf
         0cYZwgJ9dtXPn3v7qD20MCugxTcjmZq0sjjeJB+cRQa8q9ZuzvBMR+HwywicwHcmSluq
         FuhINafDYz1sSDF0yR0VObFKZci4x1d3kgzI1nczYpMdvY1F2ANEa+0UfLyxTS69afcA
         FEnA==
X-Forwarded-Encrypted: i=1; AJvYcCXVuNBeX5aFys7TUqCWJ56Z354BeXmClhvLWCoTEMZVCWO9j5a4yGZsw2L+rxv+tALqBZeQMepuXXNaUL/O14hsl+3sNBoYahPHeC1F
X-Gm-Message-State: AOJu0YzU1Nnj8EnKIQBxemc22hQuNf3hxzhDV7IgYDo4KBONthlXyPE7
	3bzfnt683ZwZGZq+4uwwUrOKaSwIu6RlmWB/Iv9+GSlAqqs5iKq4T6xVcWYn/pD1GH80fe6c4Dw
	/OjC0oVAiSKkuBeec16jks19JndLQKHG2NJ/8bgbc+P1epyDYqeiLWVmEdd859k26p1nsQQ==
X-Received: by 2002:a17:906:b20a:b0:a59:c9f3:837d with SMTP id a640c23a62f3a-a623e9d5525mr1111348366b.30.1716883964829;
        Tue, 28 May 2024 01:12:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtuH6HxaKPGGFkNw5sMowT5kyiCacNEwE8fN6RKVQkS2HpkeFA20AfBGylOpWV4CB7Xbbk/Q==
X-Received: by 2002:a17:906:b20a:b0:a59:c9f3:837d with SMTP id a640c23a62f3a-a623e9d5525mr1111346566b.30.1716883964392;
        Tue, 28 May 2024 01:12:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93bbcesm582971066b.65.2024.05.28.01.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 01:12:44 -0700 (PDT)
Message-ID: <578e5383-9ece-427b-bfdf-06195f9e91d3@redhat.com>
Date: Tue, 28 May 2024 10:12:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Drop leftover comment references to pxx_huge()
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240527154855.528816-1-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20240527154855.528816-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 27.05.24 um 17:48 schrieb Peter Xu:
> pxx_huge() has been removed in recent commit 9636f055dae1 ("mm/treewide:
> remove pXd_huge()"), however there are still three comments referencing the
> API that got overlooked.  Remove them.
> 
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


