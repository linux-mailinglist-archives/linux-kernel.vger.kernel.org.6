Return-Path: <linux-kernel+bounces-179983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DFC8C686F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB691F21E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F80813F44E;
	Wed, 15 May 2024 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b="UwqTwUIA"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4776214D
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782821; cv=none; b=qy/Xt7IQ2RTKCQWiz0nuqw5MvgkQ0NdWYRa7Fy64CbEaGAnegWGcxq6883mwFF0CyzFUrPiP1KTAr5XugPlFMVyTmFdZhd9Gpuohw5mG2PZBZQa1YNdIxBa93XUmY2NVAsb+5U4b2igijmUzJWzZgNjWzgcHn5c7j+9RXwWzlm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782821; c=relaxed/simple;
	bh=1C57CUiL1Kka2D5i9WpkZM2PY3ffkcQ24tMi/9DBSTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxt25SbE/SMUXRbGiGKast5gEjWFaCoMSJ2lmnecz7VTeIYfLC+m6cJZpEcj2Yg00STtOuwNnkdEKl9tVIZUnKS1+MyjfeSnnNF0pTd5yp870D6F+EaBSTX9insYvumfJjsMWaw4848/t6PdfynlAe6JUW/sCy5w/mBR4JPJ+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org; spf=pass smtp.mailfrom=cryptogams.org; dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b=UwqTwUIA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptogams.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5238b7d0494so1451235e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cryptogams.org; s=gmail; t=1715782818; x=1716387618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16qftxrB5EgdSgH7j+99BTnIlGUnb8pcrY5C9J7hC3I=;
        b=UwqTwUIA2IgoMWanw9qiSqp+JKR0knI3sUIFvJR7l7wYRYsNjPv+xFWCZsRuolhrQ1
         QvuGR8FIwva5i34IF699WPDgAdPnV0tJVFDnU1C11cGd19u1dJd6UnSL8VuG7m4/ShkX
         /1JVjmfMem/hB2xg2ak0S7jGFiymSVm46tdlIpZ1CuzeM1nIz/auT0spSgC8BRDD+mnx
         bUDjQyvQYGwSCgc710JrlY3YUyo39f4d2Wa2qrX9Xa7KAdx5kgn17lKCQwu/soTqlcBi
         A3YXPTY39QLE6M1DnjXVqibZPstFyAM2Sd7kW6yop4rf6GzZuZmQFJBGeF75Ib15wgf4
         SrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715782818; x=1716387618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16qftxrB5EgdSgH7j+99BTnIlGUnb8pcrY5C9J7hC3I=;
        b=SyfOCA1bP6sspRneafyxuPw3z4aMaWkbQ1JYLT8DCy+zAgFf5mf5OCrENF0ic3oF33
         zTmT+8Ut7F+3qvQK+zDQUiWgJEnerW8mlEcji/UId6r8Benw/+t3RSghW3c3qKo2bi5k
         5AJCKACE0LJOzB/Vej125R6XmUNLzSVrfCzQaHowdCZcNmueX9Wz3b5BdpViDpBAhgpf
         XmRDoyPtxkzl4KvFpOUoGm8Xct/ANRWWRJPnTFkg822rbi1fj2r3uhVWn/jvgO0ibeRJ
         460+rGncomDtFJHyCAkWBUdA7lYsnMMz2LTQxMKQ0icxgqE7NCHVUNTTuus0zx6dWlOr
         d4xw==
X-Forwarded-Encrypted: i=1; AJvYcCWvTzcW/BdSQycv/NgJd9FzKvgtU1osZr75A6ZMEr57P7x6r7xLGluaSgko6HW9BcuVdjJllW24t5xuS/1OdqVJBwsazCDR8Q4obvt1
X-Gm-Message-State: AOJu0Yx98CF0ae/LDZVnlJ0Si/WghZRocs8gRyYALyV9RRkRobIM1I2+
	KSHsMsAbB1vG0GpAVKe1O4nTnj+0pABLY7IrqYf2k6KgSSZ9cHpJHgK9UY0ivus=
X-Google-Smtp-Source: AGHT+IFpgBj/DAxqhrrPpTiW6l24RSbRhMtwGY7avTDZ4wHHSHq0yDBMJDQD8AtftGZW6eRvsGhAAg==
X-Received: by 2002:ac2:5f89:0:b0:51d:6790:b788 with SMTP id 2adb3069b0e04-522102779dbmr13134213e87.56.1715782816422;
        Wed, 15 May 2024 07:20:16 -0700 (PDT)
Received: from [10.0.1.129] (c-922370d5.012-252-67626723.bbcust.telenor.se. [213.112.35.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2cbbsm2531960e87.277.2024.05.15.07.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 07:20:15 -0700 (PDT)
Message-ID: <200be7b8-a245-4d72-9514-eb5402a61b77@cryptogams.org>
Date: Wed, 15 May 2024 16:20:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] crypto: X25519 core functions for ppc64le
To: Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, leitao@debian.org, nayna@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20240514173835.4814-1-dtsen@linux.ibm.com>
 <20240514173835.4814-3-dtsen@linux.ibm.com>
 <847f2e4f-ace1-415d-b129-ed2751429eec@cryptogams.org>
 <7eb6bf4b-5510-48fe-aa6c-ac5207d5a2c1@cryptogams.org>
 <7859e867-ddf4-494f-8ddb-2949aafbb40a@linux.ibm.com>
Content-Language: en-US
From: Andy Polyakov <appro@cryptogams.org>
In-Reply-To: <7859e867-ddf4-494f-8ddb-2949aafbb40a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Thanks for the info.  I should be able to do it.  I was hoping an 
> assembly guru like you can show me some tricks here if there is :)

No tricks in cswap, it's as straightforward as it gets, so go ahead :-)


