Return-Path: <linux-kernel+bounces-379537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D49AE01B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36219B23233
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCE61B21A5;
	Thu, 24 Oct 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsxteRP0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01541B0F2C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760741; cv=none; b=u+0cNkbdsSCjwpXoN58h73Her7COMX5Gmby3wXLCiqCjQXuerTjk5HIIvPf0k80hcP1R5U1QWclXTpKJr3OPF9C0+Vl4YVYiiOFmylgWBqYF95ORRXFG/+Ig6IJHiEHpOvn84ZxXtg809j/eIbfQ6G8poa0du21xi9ljVp66m5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760741; c=relaxed/simple;
	bh=Z32bqkdyvIrXas41lz6iz5PGpFo2gmvCedA9F9R4I0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHdVqQzQStgB0ycdsp5y2rUAE9EAvgQnRqkcQehlAgqq8eWFto+b/4rYai9l9TN30DWY/5ne+5SWV5Hl+2ZCETx4Mm47sN198HRDEHUkb7KkR6dTf5nZxaF0yjl0uneaLKsas/MK+RzE21on6RMKO33in3uOai0G3izcBLJO+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsxteRP0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729760738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u70sIwyFm0suH4CDe5A/iIejFVl9J+uk9rhnPzF4Ntc=;
	b=QsxteRP0s+qOeqTQGgnm0UKS9mgIUVyKTfZq3YrlNZmkx6cjH6mUM99BfeQh48bI/Ofj82
	vaL9IRX0Cr9BUnFnH3s9Bcm+AULWDMzDv+HAjbbTmyR4ojtgbg4McBWiC4xOhAkKx3Ul3p
	kgUnYh4pAERnLUTEwqCGcoCFy7hAdvs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-AvbPqrulPmmo4b1OlbWfwg-1; Thu, 24 Oct 2024 05:05:37 -0400
X-MC-Unique: AvbPqrulPmmo4b1OlbWfwg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539eeb63cc3so413194e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729760736; x=1730365536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u70sIwyFm0suH4CDe5A/iIejFVl9J+uk9rhnPzF4Ntc=;
        b=ZegZ0VCTK9PqUYvTWQGO3b/RlAGgKM7Hl/vAWz5vDjBA1hUU6xwKgVlqFcMgLLK+oW
         s1pacFOGTXgSqfG9TFnC4OS+3T3qJYbt+KXPwvmLEd5XvExDc7/+rt85SDIHe4UEXcmL
         /ydDhTXoSKLuy3oayJXUJwBQYHilkd4+QKAgBEOmX/7ypSSqCN3AID7OAR38bmjlY61s
         h8I/teqXZprhvbhvONuhihsd9yH+xlorUCjDJ8FraaXrwN9OHpxJDNfxkNHqMtibGFys
         BX792IC7R9qKLXW/68H8aH+AZkL+YNgwOXY1IhQSn6pgj9guD1dESfskO1XBtDBzvHJL
         ZAJA==
X-Forwarded-Encrypted: i=1; AJvYcCV73LrQELtQzyz8Oy5Y8KX3ZgJpgw1Bpd8xU0aJWEEPRKRNfNRqx3/QH2w4YqJAVg4LFAGaeroWNqlIxvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfOLdRcu3WnNq6cBVSsHj+2dJSEP/XOajjFBkmKmh1MpbHvPw
	oZTzq74CIpdAeHRIYal7QEa1P73lTy5vl1sLgY3MgrNyDf0Bij5wlwkxBRkkL+lYsD27PGP25xe
	kgzCRUq7IVNfdfsPrFQLEk7NnfAZ3Dxn9RGgAXfW2IQrZOpqWyfWvubKqvz4dTQ==
X-Received: by 2002:a05:6512:2392:b0:539:f8cb:f5e3 with SMTP id 2adb3069b0e04-53b1a375b33mr2937455e87.48.1729760735840;
        Thu, 24 Oct 2024 02:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExoOpe615O7V0Vd9OGAHQxabxJ1jZDno5UnaeKOorq+8MwKq3jNe31QuxTpcKXM4fOXZjb5g==
X-Received: by 2002:a05:6512:2392:b0:539:f8cb:f5e3 with SMTP id 2adb3069b0e04-53b1a375b33mr2937433e87.48.1729760735411;
        Thu, 24 Oct 2024 02:05:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4b26dsm10814443f8f.45.2024.10.24.02.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 02:05:34 -0700 (PDT)
Message-ID: <add10dd4-7f5d-4aa1-aa04-767590f944e0@redhat.com>
Date: Thu, 24 Oct 2024 11:05:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 00/14] Replace page_frag with page_frag_cache
 for sk_page_frag()
To: Yunsheng Lin <yunshenglin0825@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, davem@davemloft.net,
 Yunsheng Lin <linyunsheng@huawei.com>, kuba@kernel.org, linux-mm@kvack.org
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <CAKgT0Uft5Ga0ub_Fj6nonV6E0hRYcej8x_axmGBBX_Nm_wZ_8w@mail.gmail.com>
 <02d4971c-a906-44e8-b694-bd54a89cf671@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <02d4971c-a906-44e8-b694-bd54a89cf671@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I just noted MM maintainer and ML was not CC on the cover-letter (but
they were on the relevant patches), adding them now.

On 10/19/24 10:27, Yunsheng Lin wrote:
> On 10/19/2024 1:39 AM, Alexander Duyck wrote:
>> So I still think this set should be split in half in order to make
>> this easier to review. The ones I have provided a review-by for so far
>> seem fine to me. I really think if you just submitted that batch first
>> we can get that landed and let them stew in the kernel for a bit to
>> make sure we didn't miss anything there.
> 
> It makes sense to me too that it might be better to get those submitted
> to get more testing if there is no more comment about it.
> 
> I am guessing they should be targetting net-next tree to get more
> testing as all the callers of page_frag API seem to be in the
> networking, right?
> 
> Hi, David, Jakub & Paolo
> It would be good if those patches are just cherry-picked from this
> patchset as those patches with 'Reviewed-by' tag seem to be applying
> cleanly. Or any better suggestion here?

We can cherry pick the patches from the posted series, applying the
review tags as needed, but we need an explicit ack from the mm
maintainer, given the mentioned patches touch mostly such code.

I would like to avoid repeating a recent incident of unintentionally
stepping on other subsystem toes.

@Andrew: are you ok with the above plan?

Thank you,

Paolo


