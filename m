Return-Path: <linux-kernel+bounces-317444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE696DE3A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233EF1F27BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC1198E6E;
	Thu,  5 Sep 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RwcCILlh"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C64D529
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550268; cv=none; b=leKRRbSSxeyFmBHIJroGZ0rU83366oNUqC/s3GEy55BjMmjTX6y4pw/0cQu59nZCfCjAvEY50XHKUi08+rZ8GIxK+ShJ7Omx6686YSMtpYWgSdfV6kseC2Zleyf0mdK8hxMjbJRcBpNGjXAaDUv8gEjLG7zrlfrORJp3LiVblxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550268; c=relaxed/simple;
	bh=sFctCV7/ED3u2naD+T9lfUOkvUysEjdKMEcKnHtcucY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyjBEzbpihBrVMyOH89yBm1jnjdJwTLIzcm7SSbaSozom9WWSfzSdD0ksZx+q1pyiiAFkYGZPJwsTyAAslq5vm0zza1N5pUcCuZb8xHucvt+og4vQDQHXBe0D1/uzRGPMrjvSjVisf9uFMuT+BlXY655l1h5dIVWXrtzaaEhem4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RwcCILlh; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39d47a9ffd5so3534485ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725550265; x=1726155065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGxruLxENrhmwNeln8hIN5sMLYl6yZ1nExke/ImPg4o=;
        b=RwcCILlhc1IRJ0fNw0kw75rplvSxePP5xgrn5aFNlZf+ElLsuYX0S9uQQUzw6P+Xi+
         9Ga198Dp+X4AinNHk1jZy4/WsPEqTG1TN+gEzkzrg09Rh55rat9mRtQygXvh/JYIBBbP
         LqdycbcvCxEbUpjL3weR9oyRG3Ki9IkUEkw8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725550265; x=1726155065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGxruLxENrhmwNeln8hIN5sMLYl6yZ1nExke/ImPg4o=;
        b=AgDy6PwDC3yjb7Uss4utIEIr7HiDlKpKDM7raUn1ob7EUXjjcioGlgvaSJZO6885ed
         Bo+Bo/KwS+Jsy0tvjcXj71r/cph6odfmqvigvtyR5VOTAIh//NkwBRgwDqWiyWrSHwaR
         j0LUDuLS8ulSZMAc5NBi5O9SK/lnokqkNFmEvIqvx5MNgBJj4fThYclTNYfteCGYRfeG
         qh10PHb9V43qb+P9JTfyn78Wj4nUHp4Zng8Fk+7ocBmdiqYmLWLbWq42ACR5mH4dBWgN
         8QnT4COcDusVZ/Au8hemqXK1f2kEug+4geGsvVkiBh85WmCAKyWU1UXBvFs6Buzq0Zxy
         /IIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfIKe2fmqujxHBSxTXRa/GH/9Gx7+T9W9CLREmFIgfm8vlUKaYB2r7j3r3Co7Z8dgt/czGhi/QzStjjT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBv3014pTvNWVQaSXoSYNzsGk191MvwirXIDfplRaZCT2yDwd
	nK9lTuzP1zbHhQL4dcvTlpMECEfPkV2bcFU7LtJipLYgZxsdRDV3Wl6xFwOod2E=
X-Google-Smtp-Source: AGHT+IEOXpDpThrdKOVlBypaulfSggFh0Ut7W12vTBroojXEFSbngpdruMxSeECIgAtuhvzsgB6Geg==
X-Received: by 2002:a92:cdab:0:b0:375:dc39:cfd2 with SMTP id e9e14a558f8ab-39f6d729cf6mr123195425ab.11.1725550265308;
        Thu, 05 Sep 2024 08:31:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3af97494sm42365145ab.12.2024.09.05.08.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 08:31:04 -0700 (PDT)
Message-ID: <ec735866-7074-47a6-afae-50ec287df7c8@linuxfoundation.org>
Date: Thu, 5 Sep 2024 09:31:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: Fix missing kerneldoc comment
To: David Gow <davidgow@google.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 Kees Cook <kees@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240905024757.3600609-1-davidgow@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905024757.3600609-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 20:47, David Gow wrote:
> Add a missing kerneldoc comment for the 'test' test context parameter,
> fixing the following warning:
> 
> include/kunit/test.h:492: warning: Function parameter or struct member 'test' not described in 'kunit_kfree_const'
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20240827160631.67e121ed@canb.auug.org.au/
> Fixes: f2c6dbd22017 ("kunit: Device wrappers should also manage driver name")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   include/kunit/test.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 5ac237c949a0..34b71e42fb10 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -484,6 +484,7 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
>   
>   /**
>    * kunit_kfree_const() - conditionally free test managed memory
> + * @test: The test context object.
>    * @x: pointer to the memory
>    *
>    * Calls kunit_kfree() only if @x is not in .rodata section.

David,

I sent PR for 6.11-rc7 for the following since it is a critical
fix.

kunit: Device wrappers should also manage driver name

I will take this in once the pr clears applying for 6.12-rc1

thanks,
-- Shuah

  

