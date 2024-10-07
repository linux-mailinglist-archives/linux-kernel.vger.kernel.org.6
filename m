Return-Path: <linux-kernel+bounces-352987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477159926F4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA6728283E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C6F18B49B;
	Mon,  7 Oct 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Xn+vuZ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD41155392;
	Mon,  7 Oct 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289561; cv=none; b=pDyWFUAnn76/aTrbr1krZUmxVefnQs1Y5jFfFNjOFn+30+VwMdE/yXRCygMTQCqwFl5cS4Vq596qj6/Q0O6kWAyV7oYbAJfUm0lWXF6J9v0wVZpKz+BFjN8oLLs142SROI6WCOZYpYey77K6/f+2eZ6+J8/WoWnZOV/bAeKfjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289561; c=relaxed/simple;
	bh=QXVzZVpPu6Dv1kvMZgAEHEn7/SvektNGv55P242Yc5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1Q/ZSInfYbiG8xzi0IIQZWA8v+bzBQ3SvCfii2FHqkORwEmpmER5jRcL5n11p74B/eNRUENigP4209aRf3sOeiOvjlZgVlz+o2hK/w2PlrNdTk1LS8IMWNXpkCV04nuOCDWxbkK+4KATxgPFNfEgPk8N3LHW6dr4E+3rAuoAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2Xn+vuZ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso4010581e87.0;
        Mon, 07 Oct 2024 01:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728289558; x=1728894358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nEC4sxdix5mxm3eDfSssfdfmktWvyvI83Va28TOv6gw=;
        b=J2Xn+vuZBIJmIvC1DuREQe8DdYvlScBBcFXHBZ5x3mcWly/0thByYpqer5ezXKy1in
         MHQQPt/fSSftTSYTSIMPTIUwEtcl5Ivljii0TEXsbVNhsZvvDl2qaxi3CIV3ciB5pFxi
         uN87kLNa+EfUd07VoXk1LqU8x6/cndUPY1WV5HMtko59y8rgBwa7bnzbTusY3A8+z6MR
         aJ3SfZDhnuNUCKsktT2xrLul2hrZ2jooKIIwqnB+H2GAXgO33cwKBIa///PEPGFkjNAw
         o9N425s5xzIFVFO683Q5MF1bW26owoJov7tUelZAehf8jBcLa83xTn6VdTWKki1Rp2HK
         Jh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728289558; x=1728894358;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEC4sxdix5mxm3eDfSssfdfmktWvyvI83Va28TOv6gw=;
        b=ltkVS93UPnqP9p+NEofj20kgDfwQS8ZYdJFdKUEJkkrBquSH2QmpPDq2e/JYS5JZ2W
         TUh1RuLRtIF+MEpQZnR2BIXIBlyEuWdlTPoNYGUPbMWeXf3l9bwKrmry7XKNMzXkKNep
         Isd+5br4BV1yrgYL+wxtU2oDJiM4li2SRDQFueXYcUEPcG6+P+bXcXB7jQRPrp3rXzwN
         KBwYF14ZjMrAXqo//MvryoR+7GuKJIpPUgc5aAXcvj0bFOAcJezzg9flCbUW5WQNoFfi
         zmv6BD4E9kTl3CJt5LoIRAHHHLclzwtRTK0tKoqLLJOHlruWA7JHVBKWBtXlzLZSFq+/
         xbfA==
X-Forwarded-Encrypted: i=1; AJvYcCVXawWnjb5PeHUwNNu4uUTsipdpi5JdjvvMPa9rWmLva+CGS2LXBqwzYSMOrT3Xv7uSZ7SqiUyzPiICaA==@vger.kernel.org, AJvYcCVwHvrNwIeKrCmdckS0jDyDxJcObsDMeFG6oHyKimYyA9FzUp+FJB6xArMj5dkEsO7mbYY2WSscytMIccVk@vger.kernel.org
X-Gm-Message-State: AOJu0YybMXIuEGGPHfVtUTgUVZHtGc4enH3UjWhE8OuLzUfMXy3/DEjB
	CBDfI1uDeDgChUZf4bZVRLfkq8y+sNdMHiISA5r4N/tN1gx0lEZL
X-Google-Smtp-Source: AGHT+IE8uRm7fdVL7fZ5UE27WP/vnyz3LbdSSyHRpcGH9V0w+NzvxpYmSvCehkR54tLsCb29nlxLMA==
X-Received: by 2002:a05:6512:b9c:b0:530:aeea:27e1 with SMTP id 2adb3069b0e04-539ab9e6cfcmr5580255e87.50.1728289557884;
        Mon, 07 Oct 2024 01:25:57 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5bbda0sm349079666b.27.2024.10.07.01.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 01:25:57 -0700 (PDT)
Message-ID: <89fe49aa-4c7c-42ef-a59c-c962f4403145@gmail.com>
Date: Mon, 7 Oct 2024 10:25:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH] dm-inlinecrypt: add target for inline block device
 encryption
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>, dm-devel@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Md Sadre Alam <quic_mdalam@quicinc.com>, Israel Rukshin <israelr@nvidia.com>
References: <20241004004152.8845-1-ebiggers@kernel.org>
 <Zv-Ap9E2r1bRT2Wm@infradead.org> <20241004184819.GA86456@google.com>
 <f335366a-3752-4272-8592-fe1ed9f43aee@gmail.com>
 <ZwN1hDK34h0du5qp@infradead.org>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <ZwN1hDK34h0du5qp@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/7/24 7:45 AM, Christoph Hellwig wrote:
> On Fri, Oct 04, 2024 at 09:21:47PM +0200, Milan Broz wrote:
>> There was another discussion recently. I also discussed this with Mikulas
>> as DM maintainer, and we agreed this is the best way.
>>
>> Extending dm-crypt is possible, but the dm-crypt threat model should not allow
>> pushing plaintext down the level.
> 
> As should any other stackable crypto driver, so that's not an argument
> per se.  Allowing to bypass encryption in a lower layer is simply
> broken, no matter what you call the target.

I am talking from the security point of view. Now, dm-crypt does not trust
storage devices. Storage devices will never see plaintext (or key).
With inline crypto, it needs to see both.

My goal is to mitigate these risks completely with dm-crypt, while clearly
saying dm-inlinecrypt will have a different threat model.

(Yes, if inline crypto is used through crypto API, we have the same problem,
but you can mitigate it by turning off specific crypto modules.)

You are right that such a system is broken, but it is too late if it leaks.

I see several self-encryption hardware where it was so broken that vendors
basically say, "use sw crypto" but this will not stop users from using it
in a broken state.

Milan


