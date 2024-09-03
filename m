Return-Path: <linux-kernel+bounces-312504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11DF969780
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD8F1C233BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440B1C9866;
	Tue,  3 Sep 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alGuxbQi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C031C9854
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352893; cv=none; b=e4Evfn4WVrhx9SoYMl/yzVZ36Z0Wfbnco8qXLEYOpnZ5U/4e9IZ4Dh+uVDKRImblt83WlKbqdj9o32FVp9F5xNXl/h0TOBq+NbWF6fpD+MFhtbWbuXqmTlHMr8WkOFtvdcrllDW+6pq0OrSDTNJtlFTIjkMdmV7jypUUMCyAdPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352893; c=relaxed/simple;
	bh=GcsHOfPjVD1Tsf9xv7NQ/ggipDQui9jg84eq37UAxeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PY4HwDYnnrEmbYcL9xVQaHbNNaQoJZgjmrkSXMkWi37zChym9G/ap4WBieRL79cAAKmpMD7HUSwa96Eip7F5DbJnC6PZk6zxDHGY7Qu6KINovAUMd1t6sVxx6I8e6kBboHSge3dH2wvc3UFvjMeCNu4Ap4GesoQPUsIm5insN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alGuxbQi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725352890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIyFkWntwYJHuCFsPUclu0LiqtlYkXUwoVXphp9QG1c=;
	b=alGuxbQiG4VRWsZwxX/9Dq9pjZeRtMUaALQGIAkNcJAAFlVWxzVQUzLlQ14/tYOqVJ7UGH
	c5h1ql1BLuWqONdCqg3aeu7bby551zkNHFVXn2AmAk6Oz4vZ8Cwhc7A+FFT73MgLqdnTUD
	RI/GodYqtlUkS9bUR9qYvAzHRVsQRf0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-JDX1ZZb1Pw-uoZ-C1hH3Lg-1; Tue, 03 Sep 2024 04:41:29 -0400
X-MC-Unique: JDX1ZZb1Pw-uoZ-C1hH3Lg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb2899d57so46516645e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725352888; x=1725957688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIyFkWntwYJHuCFsPUclu0LiqtlYkXUwoVXphp9QG1c=;
        b=nO/j4VdbrRx7JJoRESuSncMykrZg/uiHdIdt1cZXUCHf+cSjphJDXzNsivQxbJDjGf
         fmQUfUC3NPktXa9trkMS3NFBVKhwoMCXG21JibkeCrkRt4pLSSCQxW2ySgW9Fvlk7tVZ
         AbYlDpV1CSVdUcJYg3rTzPnGjoVjC/AGdBfUjkBO13eQPD+vEZm7WXGjagw1f92zuXA+
         vNG4+mv4L60HCwkFHWCENDBZkyTdlxmmiDvrHfAaYAyCvJyGpV8H4zgckSoGxKvso0nI
         rlecHBhRjvFCtuFq82gTjehMS6AnxpxZYrWaqdO8zNe/i3ePaejtR2Aw5nK24vTCnrUN
         L9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVLIh8XV8aIaMDUB70dOt9Yj6eJ9NmGw0RO+e7/40fZlh/8s61L4cYrMaM1a3Yjnk1t6nv+Vxan707EzsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjqd2ifU8IVAgFwB2eWPYIiqLE0uv/0AWVv2D7eib/Gj/57/JC
	rf/sMD14t4IsDsp/KeX/9sD40P9JsLseDSLYhdlzAr+6G4EdQInKn1/rKp59y877xmRPo8WV9Rg
	AOyzzzASkUEbrY7d45cfucX0UgsEUImBpUp0WA8pjWii2Gb9WcjWdibGrl0LI7A==
X-Received: by 2002:adf:f68f:0:b0:374:bcc7:b9bb with SMTP id ffacd0b85a97d-374c9460ff1mr4030014f8f.35.1725352887956;
        Tue, 03 Sep 2024 01:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgwmdCy4NUtWdtKm1Q+pyYuJIGnQfjLhCqesCGn2S9nUYC6eJTestPhcYKIh6CvSMf76smYw==
X-Received: by 2002:adf:f68f:0:b0:374:bcc7:b9bb with SMTP id ffacd0b85a97d-374c9460ff1mr4029982f8f.35.1725352887452;
        Tue, 03 Sep 2024 01:41:27 -0700 (PDT)
Received: from [192.168.88.27] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c15705easm8227536f8f.33.2024.09.03.01.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 01:41:26 -0700 (PDT)
Message-ID: <f55302d0-4b16-42b7-9f19-420de2279d7c@redhat.com>
Date: Tue, 3 Sep 2024 10:41:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ipa: make use of dev_err_cast_probe()
To: Yuesong Li <liyuesong@vivo.com>, elder@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, lihongbo22@huawei.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240829030739.1899011-1-liyuesong@vivo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240829030739.1899011-1-liyuesong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 05:07, Yuesong Li wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
> v2: https://lore.kernel.org/all/20240828160728.GR1368797@kernel.org/
>    - fix patch name
>    - drop the {} and fix the alignment

Meanwhile Hongbo Li's version of this patch was applied by Jakub, this 
is not needed anymore.

Paolo


