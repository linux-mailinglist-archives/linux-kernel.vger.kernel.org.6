Return-Path: <linux-kernel+bounces-416926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4FE9D4C75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C011F21B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1AD1D5ACE;
	Thu, 21 Nov 2024 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aFWaxcys"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFEA1D270C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190446; cv=none; b=cou0pRx5p0aer2vNCv79Xt1H1XnHZMfQXRq4seyHA4wsLVQSXFxAGE8718CTNL9FWhds3IoxGJqY+djfNINffGhGwbqNS9mmtq3KMNU5k4UdNBvwNf3BmdqvFdQE8tqQzv0niVznJLJ+o63dmgTVBMIHL9VmQEjRIFjWvOfz2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190446; c=relaxed/simple;
	bh=MyO5QqG1xiB5nlAGLGeCcTjvMH2F3Lc1pDdC3EIoRxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkjaLV8lXuigpuxR6xHFJjPsTeAuZztzNJbWyqGq8L6FOsfAN+0a9cT+RhjE7RNRrPNAAakvUD9ZH8cwsP8o6CoRBTZ3XDPLjx8HqwuNPZairwrNt7MVto2QsrAsKPnC6uYz5jO3jn+5ASqAEJfHgizZxbgDBl5ezsWyrTtLWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aFWaxcys; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so6996035e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732190441; x=1732795241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EO9H7L51gE6cPNefBYVK5KHtIK+HLO0v1Tul0wks2V0=;
        b=aFWaxcysq+cMjo9gsHfEP4way9IyyS1BoKNAZnZKXujcJpRcU2wamGEeaZdEWmK91Q
         UgcuoP/qmUYgw46KfQOs7Zw2FeTpOhbl94kLOVbIzkhKT+8mvN/m/mIQwgWjQ+mljKQP
         pU0gr8OLot6hW1wg2lfH3R75MVExxCHMNppRmdahMoici+d5pYKZcZAsnkpmEmxFdZW8
         DrmpzDy91md8BZUEnla8aKNLyxWYY1MGfLOf6M6NNYHyiPEWTnwKrYhoRG2zrqt0Ag18
         J3qjwfpK9vaSDXglL5vfneXb9EhBEQB+BlCOHNaOIex/xqRu9SZJnTOEFA8YRUE+fXvK
         Dk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732190441; x=1732795241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EO9H7L51gE6cPNefBYVK5KHtIK+HLO0v1Tul0wks2V0=;
        b=Uyu9pI5VcpSXb0os3mJdXiDLFgy5gR1M/b8oAa8+jpxYg2/JtZV/pl4ZmpohzoKI/B
         N+AvtGueT2WEjhZP4NzO3XwdkG7xVjcSBP1alNwieNdZuEYiOeVbbpGBxEwFHmCYfZvQ
         9Y56aiAT/H2qdMUBDtqH64OGY9QLtQK2H2MblsqTApSKzLWzXKezXp8K9JeJdEQ8Aoen
         F7YFxjGFMaMCYeRMDGXWCCIu+J+qlLbUzAixN5+66HAULxmbfTt12J2X8ubVoCQI5Ebs
         cdjK/hgvoL4j3UEZy4w3Q0qdq31usCJj3NKn+NsUTFqlD8L3XMNjwpvCpDxy708d5fxr
         xT9A==
X-Forwarded-Encrypted: i=1; AJvYcCUzv7lvLl2QwjfLoz+X95sD0HPOYu/sP9qqdXRxhe/RE9DZYdRmS03uR8vtCP1TQ81iH6l4g50BxzVPiM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzUguF2YrjduznBL3M9LdvWHOt3sMCLoadsqFXggmBc6QKTalV
	AKovDrs+V8Adm5NBxWF4AWbkfHTE9FkrojHg4doW8VHKmpSRikekMdHt1viEaBo=
X-Gm-Gg: ASbGncvGnZzHuj4RJYX8fUAcrqjXH2x02frQnyvLurOZxnojV5C3c7J5Nw4Oz1qRcMi
	CGM83gAedl8MBDkLWZToQG00cSzmtuw/anJNAFXs6+mATSMablQrts705K5ptdBdgaYjuzzyyZ6
	zdT1I0JtFArJyYY9twTVFe7S3PaT1o5137UeQpygMWPHjCTpfKOfQ2gKBaOIphfKI+74UzyXBGp
	1TI0PcXbeBpC0P1zE42Y265vGH3HEOcgJw6Vf9/hWA93yDHNNYeb5MuIDSngXPPKz0dgT8fJdS0
	GnJ1Pg/7Algnak7BDTECg5nAXXjwjjTEtt316nk7hEjdU7xx5EQ/mOgtCwqXcxPvscjfynjIvs4
	=
X-Google-Smtp-Source: AGHT+IH/3NH9JKgLe2HMj+sVAVSzV5oHzHhIknlp/HwTvLcOeg4S3MgtK3eWa+wQPxuOZjcu3rfShQ==
X-Received: by 2002:a05:600c:444f:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-4334f017137mr48829815e9.23.1732190439548;
        Thu, 21 Nov 2024 04:00:39 -0800 (PST)
Received: from ?IPV6:2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c? (p200300e5872eb100d3c7e0c05e3baa1c.dip0.t-ipconnect.de. [2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490bfd6sm4799041f8f.25.2024.11.21.04.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 04:00:39 -0800 (PST)
Message-ID: <82dbba56-e803-4332-81f7-225e35048e1e@suse.com>
Date: Thu, 21 Nov 2024 13:00:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: fix init sequence
To: Alexander Merritt <alexander@edera.dev>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Simon Horman <horms@kernel.org>, Alex Zenla <alex@edera.dev>,
 Ariadne Conill <ariadne@ariadne.space>
References: <20241119211633.38321-1-alexander@edera.dev>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20241119211633.38321-1-alexander@edera.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.24 22:16, Alexander Merritt wrote:
> From: Alex Zenla <alex@edera.dev>
> 
> Large amount of mount hangs observed during hotplugging of 9pfs devices. The
> 9pfs Xen driver attempts to initialize itself more than once, causing the
> frontend and backend to disagree: the backend listens on a channel that the
> frontend does not send on, resulting in stalled processing.
> 
> Only allow initialization of 9p frontend once.
> 
> Fixes: c15fe55d14b3b ("9p/xen: fix connection sequence")
> Signed-off-by: Alex Zenla <alex@edera.dev>
> Signed-off-by: Alexander Merritt <alexander@edera.dev>
> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

