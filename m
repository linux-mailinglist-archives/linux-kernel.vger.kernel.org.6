Return-Path: <linux-kernel+bounces-370547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CD19A2E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297091F22FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A61E0DF7;
	Thu, 17 Oct 2024 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHTGDhCt"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A025779;
	Thu, 17 Oct 2024 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196230; cv=none; b=RyxTu/62TYUMfQ08DNDZCyI47W8XJs+Eh+wX5scS1E1ZCzxlS1BArhokm/HKrD/Is1WzQhxhy5frXGdeaqpOUvWunCapzvFvwGSYE+qLO8yVEregPtDmBFvegrswnJUIc5fkMzIxmXhfBsZk7bNZmPe+Uv+oj/QQwUsX6nroTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196230; c=relaxed/simple;
	bh=VoXbOUT+7r+Yb8LrMPapx/77RuQhM0T/wAWw2f3u15E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiOM8Ve8yrU4dvXLRerNL6Z1/LsPVEgKwx8i3Nv/HBTZKWA/svxLsrYV1pcLGDdrH/pE3jhUqehvytQVywpCuSTFJ5gM/cq6ulVdzex1Pl2Uck66EV6e5tmD8wyYxxxEN0tuZrSN63hk5NbHgyEWjk91fU4hnkrz2yaEoO6q7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHTGDhCt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso1464479a12.0;
        Thu, 17 Oct 2024 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729196227; x=1729801027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7nrUnWBkZq1N8eEwJNkYD3GJ/kWHveA5PFsZPbvCBpM=;
        b=PHTGDhCt98L9Leg97ERX+1WhtQQ3rfBK0YrgMZ3FdlctqOCh7lfQPVY5ht0k1uOyl3
         TJT2gruDRkuTWhjbPPgw4za7TisL/UmvaYemJKwA0EBCPZgZyMSTo8DFBqRsNwssWOE2
         oQ3YN5R2t0THIN1SKa0S3gGJGXF1lna3RJx0utNv/7wICwwyKn8xGgPFNQ3HtyTQFoZB
         DwCfYOm9QepFdG8B+zA1/9FFkn999Vb0nUpyUsw5hMAXMZKRWmBcJlNbtHQwEmdZPVF1
         EnRXER+ATQFy3LG73CxvN2YTuqL97YBa9uVbj4EFYiD+VVHlDe1lvNuVyR4DesoBMm+c
         1ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729196227; x=1729801027;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nrUnWBkZq1N8eEwJNkYD3GJ/kWHveA5PFsZPbvCBpM=;
        b=jyhn9teS8McIdWVTQ9WBYEIeW8ANYQkcvxoKn/vZS2yhRqxMEn6MTDgPgHtBayGoRy
         vjkDCr2XFGpHAv38oLm+d0EZxZh53pQ20yhCFGZ6L6laA1D/RHfKXh822I/gTTM/CpUI
         DtmGexwcrv5n5+HPRalgn7cZWGq484EyvJBdh+5AJ3c89BJB4TuDjL8zE+5zcuLtsbKz
         4cAGn2Mdd00kj9JY2KhMzgyoGmVONer1BqPLWxKumDjHQZeaAyJsAdWb5kfW8K9Fo8An
         pXYHkB5aJVBik3WFP+2vqY34DmAxUJyMlOgVxv3pVSC7MSCkk+PDGrMFHflGG2Ig2eM1
         sqUg==
X-Forwarded-Encrypted: i=1; AJvYcCVBHHnXKvViNKdGVtqtRWjyuR8BxdGTpzRv22VByT62qeIm7k/dkQrOulwwyuSA+1jubcK46I+qg6bRpC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dD06U5zx1DfwsNvi8OBMof3vRupEHoyWKq4ADwQlD0ee1nWo
	kMzA+p1jMMTTH3CKCE5+AtFZbu0NuHjvhPkszcnJMdgyg3EadYGIdAl2AQ==
X-Google-Smtp-Source: AGHT+IGCLd6eKeCgckBmJUVKf9oqGJEwfgWYtzABRoaKBzP1h/p6Ybn1dj8JxMo+j/ZY9STG/Qoimg==
X-Received: by 2002:a05:6402:13cf:b0:5c9:3026:cf85 with SMTP id 4fb4d7f45d1cf-5c9951ce9d0mr7101938a12.22.1729196226410;
        Thu, 17 Oct 2024 13:17:06 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d77996asm3118847a12.74.2024.10.17.13.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 13:17:05 -0700 (PDT)
Message-ID: <b8670e11-61d4-4831-8a21-2dda3c5db131@gmail.com>
Date: Thu, 17 Oct 2024 22:17:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 2/2] dm-inlinecrypt: add target for inline block
 device encryption
To: Eric Biggers <ebiggers@kernel.org>, dm-devel@lists.linux.dev
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Md Sadre Alam <quic_mdalam@quicinc.com>, Israel Rukshin
 <israelr@nvidia.com>, Mikulas Patocka <mpatocka@redhat.com>
References: <20241016232748.134211-1-ebiggers@kernel.org>
 <20241016232748.134211-3-ebiggers@kernel.org>
 <20241017194415.GA11717@sol.localdomain>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20241017194415.GA11717@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 9:44 PM, Eric Biggers wrote:
> On Wed, Oct 16, 2024 at 04:27:48PM -0700, Eric Biggers wrote:
>> Add a new device-mapper target "dm-inlinecrypt" that is similar to
>> dm-crypt but uses the blk-crypto API instead of the regular crypto API.
>> This allows it to take advantage of inline encryption hardware such as
>> that commonly built into UFS host controllers.
> 
> A slight difference in behavior vs. dm-crypt that I just became aware of:
> dm-crypt allows XTS keys whose first half equals the second half, i.e.
> cipher key == tweak key.  dm-inlinecrypt typically will not allow this.  Inline
> encryption hardware typically rejects such keys, and blk-crypto-fallback rejects
> them too because it uses CRYPTO_TFM_REQ_FORBID_WEAK_KEYS.
> 
> IMO, rejecting these weak keys is desirable, and the fact that dm-inlinecrypt
> fixes this issue with dm-crypt will just need to be documented.

Hm, I thought this is already rejected in crypto API (at least in FIPS mode)...

It should be rejected exactly as you described even for dm-crypt,
just the check should be (IMO) part of crypto API (set keys), not dm-crypt itself.

And here I think we should not be backward "compatible" as it is security issue,
both XTS keys just must not be the same.

Milan


