Return-Path: <linux-kernel+bounces-424579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C249DB63E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F10CB261B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDE9195385;
	Thu, 28 Nov 2024 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6GhhOoj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C119342B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792065; cv=none; b=tmn+d+ufhVBq3mHPKmrwt5RdQHLr1xZr73tiVagnjemJP88SEoGjR1JGtq+p8QFTD/rVyWTEQf1bvP+5fbpuM/4UbKAZ7qm1RpTfsZYw0spARnUEMii+ZW1wrpRTLM007H8V2VWBA+yQE5F77o9PU2u18sKoT75TDEiMpm76v6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792065; c=relaxed/simple;
	bh=dtEbl+eAxjNtqIHD/lA/11e457LY7bQDSZJVQdho3vc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UQEQw2zacLvWFkbcANN5S6EUt3oujn2hh25Rt6XJ920CZJUlqEKITLWQIz+FyUm/JGfSS0oE1xU2KJ1o/tIMP/hj4+m4P/WyMBih9mT73Gh2wDvHX8dVdc9w5EigLYwOrTQkqOH0JHa1KclxC1gbmn9nmkaqdXLJn4Po5qEfPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6GhhOoj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732792062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YLK0mLTOGgTQPMKHKX0ABr1QZ2jKPpEqJQKsnJzJ90=;
	b=Q6GhhOojHt37Ha8CIwT7qIGJ9Wegin62EiM2KL4MsUUNON2G1LAQOQlVwTJXtq9I5gRciW
	rbnfkhlEC2PMNi+SKBfyQqN+tG9/1XxfPh7gjY4EQUFeqWwS+yWZY6DKVANLnI05ei5nYx
	BNyeQiO+25COEGzuwzb+diJEkMahpME=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-awihWePcPumnccUz72PY-w-1; Thu, 28 Nov 2024 06:07:41 -0500
X-MC-Unique: awihWePcPumnccUz72PY-w-1
X-Mimecast-MFC-AGG-ID: awihWePcPumnccUz72PY-w
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-382308d07dfso384586f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732792060; x=1733396860;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YLK0mLTOGgTQPMKHKX0ABr1QZ2jKPpEqJQKsnJzJ90=;
        b=SwUZAUXCtMf5uh2lOY+X2K2F9yxgpO32g7y+iBF6NjHnIe5Dbbf63GZyN+XtfH+rt9
         hGFu/uaAHnmti44cpukifhFpNsMM5WJI5bioHFznUqja0TvD/P9Yh+1VkDcJorh+oHHm
         LGH7fPlIjOSMgYBcglMyGC83YUFbCTc0d7+8vTjJE7+p3709q+EhBN2HnQ1MPU8z2WBo
         jQVJaXsyoICBH4jZNy3sFgGy86TPGopDd8ZDFqa4lK4n56tlmWa7IPYWqE2fdApO4ZiW
         lgsHHOmtqlzFsphOg5IdDW3Xe4D8T/iH5ZHeztOp6k8h1LCw00AbeinM03D7MYUwGZmH
         SuZA==
X-Forwarded-Encrypted: i=1; AJvYcCVFxca7bv5L7XtubpjT1QMYASieGUlDvbZZD5wt3kdaNpucFXgp9IqjZd2nNmkTTxOBatZRJ/xDqzJDf3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0y3SGz9xuTLSbRbutNVjOGRAOhtCJeGfnrPNoLFSVGPWLyeiv
	VZruOPhjo1LTM0MTCW1fR0uCeRbBk8I+bzK7+HLs+AQejR4K70oJFTghYsbGjtRILNkOf7hJ/Iy
	DVE4kMc4uT9LIi7Vmfe6fOYjrt/7wGXLlWQiecsl2q24FW+V81VDiBoIb89Mnzw==
X-Gm-Gg: ASbGncurajQeFfJHOF21pwT41suBOeFfyjhNjk6j2Jw1X7FuONt3HwTF+0TGm9j3X/k
	mqUPLU1eT8KOXF1u/HgAM9rkFhjRGZOJyQYpjNmew/3K2kxs0Wp+zarvBt4yQvy8kDeJkxAwEzQ
	MgJb8zf/02iET4w2Hff1X/T0qap69iJEKYvXqKLej2fps/OQccVxVCHW0L/T8Vt96b55Mzr2Gp6
	Gq5xSi6OdZe7fnhV3uUL4hQgNEY+9nla7FlkF9JtTdc2zGXIFALTPNay+oKiN1IGExXVoRAifiE
X-Received: by 2002:a5d:6d0b:0:b0:382:450c:25ee with SMTP id ffacd0b85a97d-385c6ed74c9mr5453030f8f.40.1732792059858;
        Thu, 28 Nov 2024 03:07:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeEhbHAnt7UDcnIN9QSU5mCAPewp86pSwIsK84xm7VJfZBGKBADTHurkaCfScNk20JP2YEcQ==
X-Received: by 2002:a5d:6d0b:0:b0:382:450c:25ee with SMTP id ffacd0b85a97d-385c6ed74c9mr5453014f8f.40.1732792059503;
        Thu, 28 Nov 2024 03:07:39 -0800 (PST)
Received: from [192.168.88.24] (146-241-35-20.dyn.eolo.it. [146.241.35.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2dba8sm1393832f8f.1.2024.11.28.03.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 03:07:39 -0800 (PST)
Message-ID: <d327579b-45de-478c-963d-fb3b093c2acb@redhat.com>
Date: Thu, 28 Nov 2024 12:07:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fix spelling mistake
From: Paolo Abeni <pabeni@redhat.com>
To: Vyshnav Ajith <puthen1977@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241121221852.10754-1-puthen1977@gmail.com>
 <fc0bb8a7-8c6e-49db-83ba-f56616ebc580@redhat.com>
Content-Language: en-US
In-Reply-To: <fc0bb8a7-8c6e-49db-83ba-f56616ebc580@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 09:08, Paolo Abeni wrote:
> On 11/21/24 23:18, Vyshnav Ajith wrote:
>> Changed from reequires to require. A minute typo.
>>
>> Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.13 has begun and net-next is closed for new drivers,
> features, code refactoring and optimizations. We are currently accepting
> bug fixes only.
> 
> Please repost when net-next reopens after Dec 2nd.
> 
> RFC patches sent for review only are welcome at any time.
> 
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

Uhm... let me reconsider the above statement. This could land in the
'net' tree as well. I'm applying it right now.

Thanks,

Paolo


