Return-Path: <linux-kernel+bounces-180782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEA78C72FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296D61F229C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A01419AA;
	Thu, 16 May 2024 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b="TcacwMIE"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED81411CB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848728; cv=none; b=uzYaB6xISfBcWKlSEEuKOraOMYh3i6lS6/RaZ1lUwWb51083DJ3ZYH4lrdve5WCATXyyhHMq90aNmJkkMm/m4TwJcHIMMY4poVQDNiDC7a5EFUg4biYvbEettEKyCYAFm46MHmKIorpQP+1AEWJWrtjIDquUP2WMyh2qpdH4g/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848728; c=relaxed/simple;
	bh=lh7fMWPMcn5n6bL+jz5HkQSkNBuVEDIGI5wL//wYXuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MysUABalfPG9iIfgZCJ5wlvwSATBUXP+ZTqIlFF8ZSqbPTFEbmY17pClLQjoiQYugl9kfc+HmJpdSU+IAFH/fotUOtRLSCm6paoNNKAN1EON7ZpomXXiT0Cj1UmuZPkUQBdIMfgdYMsR5qKVaoOjiuzOhW2DGeoK8si+uNpty90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org; spf=pass smtp.mailfrom=cryptogams.org; dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b=TcacwMIE; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptogams.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51fc01b6fe7so552809e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cryptogams.org; s=gmail; t=1715848725; x=1716453525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOeW1i0XSjN8EcRDRG2ima3ZBqcENGXoN19rlekIi1o=;
        b=TcacwMIEwD+LM78G/WEdMeKWTC6AccDZLRdgHOkTlUVYxVAZeGAF5dwjSJ2KMlRSaz
         mIVTpcOL73Xc4v+lYk1YboR+1gOzIzY4YAIYBWTd+l//K3EL+imVNnGIJgJJLbtWV4Un
         NpZvuvAkrFea/VsStB3kWf/7G5VJ9aco4UOduTQfrPLnA9vzmRljNC8l6w6+Rj0KKJsw
         Y0VsBQYeyWBHrNghbt8HwfkiEe+duiT7vLw1tYbNQM4KSo9/1dB2gUwE9bv6yOTuCqff
         dVqQ13DOD5SjiIDiaEgQn8OyO7zlFIaTGFnDPndXBFFdRLOFSopVCwiUZr6leUwh2r7H
         zNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715848725; x=1716453525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOeW1i0XSjN8EcRDRG2ima3ZBqcENGXoN19rlekIi1o=;
        b=KQ4yUV4kRApWtu+nwwtL2igAVbPatAx3EoGJRcskWLsI0tc2hH0pIBPRKjK+rT0d+9
         Sk3/7H1m6YEQY4lo0xosDAJlpsnajGbdcqER216RPOdcRZrFJDEWUQrcZP5pE7q2mvLl
         J7y0yvPKXYoVlLkFmxJBfcN2sffs6lzalDmRyG0NitsXnKNH9f7rptUSRM1/GV51Ij5S
         c6P9F8JCsMC++pCA1ezkz+CHg886Ed5b8vAzYPUsDkloVNUc5oFFr5zeNkvGEVcgvgL9
         OO+ycxFho14GAICUomyQwTCQkOSvLTdKKYcD7NaYof1LcdghjHPxT276Tqw6j7OsQ0DI
         HpTg==
X-Forwarded-Encrypted: i=1; AJvYcCV7sP6F+upqXrgJcXBFqjAyGrasCT8DFmTdsSbg2U3l9f6EyJHCv0oFuiBZW532ujYT/QKZmnfhC756SkSWRYEcCXH7A7Ma/+Wo9gYg
X-Gm-Message-State: AOJu0Yx+rgEiOwm+iFsQ1u7ohc0iUZ4lUhNtFgF/69eBSEOmXiQfr2Fc
	VFLUOEPTbKVh7D2GC8HkeZlyKYq/a3QCKC7ekF/APlh9uk7+NN5rRLJ4KHPivH5BQWxJiqZ1R2I
	F
X-Google-Smtp-Source: AGHT+IH4ciVi2WPFfN4wIB15qPhRg9zSbcHYMDpqRPhOgTsgCJ+nsPiQObpBhEe9fHl4yk1Q/wux9A==
X-Received: by 2002:a19:5f41:0:b0:518:9362:f63 with SMTP id 2adb3069b0e04-5220f97041fmr11199702e87.0.1715848724887;
        Thu, 16 May 2024 01:38:44 -0700 (PDT)
Received: from [10.0.1.129] (c-922370d5.012-252-67626723.bbcust.telenor.se. [213.112.35.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad461sm2876576e87.33.2024.05.16.01.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 01:38:44 -0700 (PDT)
Message-ID: <89e7b4b0-9804-41be-b9b1-aeba57cd3cc6@cryptogams.org>
Date: Thu, 16 May 2024 10:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] crypto: X25519 low-level primitives for ppc64le.
To: Michael Ellerman <mpe@ellerman.id.au>, Danny Tsen <dtsen@linux.ibm.com>,
 linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, leitao@debian.org, nayna@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20240514173835.4814-1-dtsen@linux.ibm.com>
 <20240514173835.4814-2-dtsen@linux.ibm.com> <87a5kqwe59.fsf@mail.lhotse>
Content-Language: en-US
From: Andy Polyakov <appro@cryptogams.org>
In-Reply-To: <87a5kqwe59.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> +.abiversion	2
> 
> I'd prefer that was left to the compiler flags.

Problem is that it's the compiler that is responsible for providing this 
directive in the intermediate .s prior invoking the assembler. And there 
is no assembler flag to pass through -Wa. If concern is ABI neutrality, 
then solution would rather be #if (_CALL_ELF-0) == 2/#endif. One can 
also make a case for

#ifdef _CALL_ELF
abiversion _CALL_ELF
#endif

Cheers.


