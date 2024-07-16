Return-Path: <linux-kernel+bounces-254508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BAF93340D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481021C22EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38CB143733;
	Tue, 16 Jul 2024 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gkb/WLmL"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A05D5FBB1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167224; cv=none; b=LwIEgqvKyAN7M91n9xRp1kmj3PCbaiqLSqy4PxjSmYHsQXMdvgrjp0EbcHmsyjKKqb1bb+0Z8AEfl+NkomunUtoD/Zxzpz11B0SUI6LdJXJuGJrN1KWzQMyyshl1GrGPMIf61AcaBh4g8h7mXdncHXYm3q7ymTwK4e3hNRQSG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167224; c=relaxed/simple;
	bh=1R7wr/CSPAA1iHr/h8MuMIditUBxtwJRY7Nbns8+sqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVnUcqJhrZya9096X+n+3x12kwh1idMAXxtznwMtUI9CflBJDUI8sXnxataEmpHGnaHUn3mfNVfl2Gqs2eWUqjiXwMo3TLyaXhyN8jrurfwTLOdqEgPZd3gyulcpoa3FOOEAjvCOdLhOBY7OT95o4EQimmreIkfh8bPbXPvP8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gkb/WLmL; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f70a7470d3so1156139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721167221; x=1721772021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D43C5TtbFu53O2HFSds4/+8o7M/kPrl9sujLKKNyGx8=;
        b=gkb/WLmLVdkCV24pmLzLbZMrgaIrKa+Gv8CrKENnZyvY+XvA3yxcnR2/TCqBZjJUnN
         a/AMSH7uusOPEU6i/aukUP3vXp34Xq4QFsv7kFmHbfdKCUaNOFxXKXNsr5iJokXSTYbu
         oJPFN0RI4e3ae0EDeXgpf3PwwUR8/X6qHAn4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721167221; x=1721772021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D43C5TtbFu53O2HFSds4/+8o7M/kPrl9sujLKKNyGx8=;
        b=fiAwXsUxIfLhPoPrNaJqqAKRDM89/wbq5WNYNbZ6WIiftQmBG9561Fz23BX0q9qv5Y
         ZMRGThoJMrWU097EXaK9orKecw9QFvUYUVD/foUYrCQUHe1aIbv+cOnx/6VtBeF9A3cN
         I5N8/Z7Z7WTcZzw1bvGtPfw9vU8/lUBoiWmv14MkVw+kYl2bGnDvLCnZA8ap2N9yxpnu
         PdUXYRPqRupZMbB9a+OjIGAXtm+l0BJIl5YR1Y271xW5gsY1OyVTbvaQRTtrYv+pm08m
         YMmeZeqNMAHzxBYuhgYQlj40H2HNZyvYMVeMyk1s25dwJo5LhFvhWiRn02D9EjBlrcNU
         oKLA==
X-Forwarded-Encrypted: i=1; AJvYcCX/aovYvmI47ZDQjevfHw/5tm4IOw7R9/Ki7Dh8/wTL03uc/PtAdBf+TNTT6SV+VB4TOecASyzbgQQwInmGbdapykPQbW1Tx1l/iLli
X-Gm-Message-State: AOJu0YzqAMJxn10L+2ol1iMNvk/HftktWShl35nWp4/EAbDmhwchw/bB
	cpytESwMduC/npyqzIghkfLjwP8zQ/OfYxTdQZn8+TrX3ombBtPaJnYIfqBMC/E=
X-Google-Smtp-Source: AGHT+IG1OOoDocWaqpAynyoemwtS+Ij3u9aPSsTymae4wzjO7bqNyaMRiC7XHDUFhRvJW5/wrIM2jw==
X-Received: by 2002:a05:6602:1605:b0:7f9:444e:4918 with SMTP id ca18e2360f4ac-816c51c7e48mr68814539f.2.1721167221509;
        Tue, 16 Jul 2024 15:00:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-816c1e8e118sm17824739f.28.2024.07.16.15.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 15:00:20 -0700 (PDT)
Message-ID: <37214c0b-4b75-44ed-8801-56a09b71040e@linuxfoundation.org>
Date: Tue, 16 Jul 2024 16:00:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: x86: vdso_restorer: remove manual counting
 of pass/fail tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240712073045.110014-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240712073045.110014-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 01:30, Muhammad Usama Anjum wrote:
> Use kselftest wrapper to mark tests pass/fail instead of manually
> counting. This is needed to return correct exit status. This also
> improves readability and mainability.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

As mentioned earlier, include before and after output from test run
to see the improvement clearly.

thanks,
-- Shuah

