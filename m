Return-Path: <linux-kernel+bounces-262354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ECE93C4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8D01C20AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B184D19B5B5;
	Thu, 25 Jul 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FA9/85m+"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1394F519
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918751; cv=none; b=dssYcR9XQnKZi1KgZCgAfGXJsLQz/Q09WeM9DUW3r88oQI5vpLr7SiA3iZjXGKdH+gmWlK8ZPi8kqUtK7n3NK9YdWNeUrpc92BgAkb2FJeoS6SQPKt5W6SG/z5zXEkpMS4jEP8G9x82rk9zfIaIZhHOuy8ynAHaZgN8gEEPHDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918751; c=relaxed/simple;
	bh=HNpY12jj4QLeaUYSmrnBsn/6c/SDnsMCihydOP0VV84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q33c+Z9sQncAMeZ3BSwXh+Lpo4+8VbYv3fcoKKW6hYwpc1DzX7caw3+xBL0OHSwMTyT5huaAGEJ6cHIGUFiyoUd14//yPIR7C0I817hRIWKXwI7iWPb4Fap/ILTWlA7oxI5LKro6hyZ8pvep+YxB8JzPLRjmPXX8NJf2DO8jneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FA9/85m+; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7f906800b4cso1553539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721918749; x=1722523549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tV9Ff2+s1v7f6qx4CAWym2ax1C/xlwD3BYRxTZaNSbo=;
        b=FA9/85m+mhAw/AHNb3oV5YvJXxn5qgkUtV2nP9fkSC2YY5nLjCDXBaGhx14MvFAHue
         P1H3KG4/JiVfMFOL0yr2+P4F8BB0t8w71xO/gZ9DRr4ZghunGnSUG/vhKpUpn4njcxe5
         i3Iu3x3GSDZixb8v2s1hHywq1cNm78HalJBb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721918749; x=1722523549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tV9Ff2+s1v7f6qx4CAWym2ax1C/xlwD3BYRxTZaNSbo=;
        b=LoojVl7pjq2X8kIFsApmY2nf7AJMDXRfklXxYBTCjoD/+LOoRNKDpnRk9jgrdNSR0m
         pejXMC3eZapmRXc6O5a7THG+bjrwZS32VXvx/oodcKvr5bMb4V4vD4J4zXVRdXGKugMO
         aGB1nDJNrcIhlDC4360pIlXdtx29r7Jx+gy3B9wMtOWP7+jZ1I44Z+miYM7ViTFygBPP
         3L+oYqO3cxr5KMrriiDV1dO36HhbwtBI9PMnVwPB8fcH4AGxBbRpMZuUFqcR39mctL7Y
         A+T4CW/TOy+V9pMngEw4/83Dv9ZDG8oKDuAG7++ErVjJWW4wA7YCIr/gkl2CwHGRjEGS
         zSRA==
X-Forwarded-Encrypted: i=1; AJvYcCVz9wujXM6DTkWhDge+GAc6kbt+72Cn273tYud0f5zZmoXJ2mI8IPTx6RDZkPhSr9pOWUabE3T/kZ735atECGjV8AxyEGh3jtBMuluK
X-Gm-Message-State: AOJu0YwIwYxe+VJDeuQ05BJ96HtHRPY0PYPBCC6kiRlrec/prSrNCjRH
	/DIyz+r2dj2QHLBVKO6N/VfG+p3WXpVWiOlpsyxpgrp9KcEDHle4bcHlwbCpn08=
X-Google-Smtp-Source: AGHT+IFAR2Fptni/HLPp1bBC/jZNTR5cC4aNUfqTa598sJH5Fx/l0WNYz7GcIhUtqhb7DPF1I+Oikw==
X-Received: by 2002:a5e:c105:0:b0:7f9:3fd9:cbd with SMTP id ca18e2360f4ac-81f7cf3f757mr203391839f.0.1721918748887;
        Thu, 25 Jul 2024 07:45:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29faeeec4sm344591173.77.2024.07.25.07.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 07:45:48 -0700 (PDT)
Message-ID: <2bdd359e-037c-4b7c-84e6-db381a619dcd@linuxfoundation.org>
Date: Thu, 25 Jul 2024 08:45:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: lib: remove strscpy test
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725121212.808206-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725121212.808206-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 06:11, Muhammad Usama Anjum wrote:
> The strscpy test loads test_strscpy module for testing. But test_strscpy
> was converted to Kunit (see fixes). Hence remove strscpy.
> 
> Fixes: 41eefc46a3a4 ("string: Convert strscpy() self-test to KUnit")

Remove fixes tag - this isn't a fix and we don't want this propagating
to stable releases without kunit test for this.

It appears fixes tag is being used too generously for things that
aren't fixes. Let's use it only when it is a real fix.
  
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

thanks,
-- Shuah


