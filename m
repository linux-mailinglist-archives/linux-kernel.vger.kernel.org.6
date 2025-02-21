Return-Path: <linux-kernel+bounces-526065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B51A3F973
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC016860C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157401E32C5;
	Fri, 21 Feb 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtPhxIaQ"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7E1E260C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152795; cv=none; b=k5sxyv5gWDwtjvJRl/MK5CgI2UAJaFNTGdFHBErBUuUnE04IfmW6+myiNmAq7slshULp9RakyrWM+WIenautoaVE/nlFEloKbbnwQ49a+TPSWUZFaDEgZpqcQWSFBZbt8UAS6bp6ClqRJic7J4SQKVTZAigS+tKQpAMiZV+flW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152795; c=relaxed/simple;
	bh=WBcmWGrMeB4GHMlv6u5IaHPt74W6BHCLh+gX5YUMXik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5098/mfvg7n3Az7KUiDq9NI3aARC35dQ/TR6bHV4R9SIjwXXJ/DmrFmHrDp2MKXXpgEAFITcAztbhTDcpmRdbyXJBGvQLRI7buJFPCJY+WwEZykhS2yTvtjnnuuLg4HF3DvISj63szDxUaQfHz4msFo/fsbxTgFyfJjN/cm1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtPhxIaQ; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-855b77783e9so63533539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740152792; x=1740757592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBiYF95UsjyWdAhHtcE9LoaRvojgCkUDYAXBAvVvRiE=;
        b=gtPhxIaQu+jO8yh2mJqNJRuxkLw1LHsQQMQ57D/lMBLDh31CcfzeUXm1smB35JVIUd
         sY4kwcRbygz5D87nD6q7NRro8wnZRQZqOgjC0GekDy3F33o3uSyWvTnbCW6cPCARSAYd
         zKDq3oE55+HGBGOAiq+692u21DNFgv9HiWyb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740152792; x=1740757592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBiYF95UsjyWdAhHtcE9LoaRvojgCkUDYAXBAvVvRiE=;
        b=cdAHw0bDrpjUias2Jvgesd3X7Woay4H79ej6SOgj418a4Gv/ZV9vDlIrOiom5MDVGj
         TqqDlE5pLYiNeCUqWKRbNcx9jhYw2KO7IPz+VuC4QY2R6xLqhh0U43oLENA6AgnAOFsi
         g0ATwuMOyJgIk4jGkseuhsaBXsOlfppVE5NNpP1JZPP0di/KMCJBsEbgBbHMHx2r62VN
         SJ6hBNeLzrWvFASmi+Ex2MD6efUJPACWAFi4wJmAcw1Jxriaz5sGT9f5hsi/63ud9EDk
         9k84uWGZZG5uchlkgfbmkzFCjVn3p5yy9b5zPhOomVYOG2j8H8gs/i65+qLV5tgZNtXJ
         LIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE1rAaDNfGeJo04wyjG1fvspY1OBn02satNcEeQ4EhM8CGDTDOyksvEimChAeuAY+zHbb05t6XgOlAimk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8keP+97NelDhjlQ7v7QLiwL8h3do9feYfPdmK1h3dMNbSGih
	wAENlrF1UYaBr9tB/XH64/KCtSmG/teA8+52NkgYm7cM2uHFB1IG6xWJnqHhCak=
X-Gm-Gg: ASbGncuOlUs7KICrM+MCPuMZv5Bk1s1iRr+MN5RVV5Z+4Dc2xCH19grtbLIHJxJ7g55
	AuDcQIFjvBjKoizwYSqWbPocNXghNnX6f2Q/WjZ7DrWb5H0LxFzyhmZ5kGvbjH57ceFr8Z+ZwqL
	vxiDii1NgOthAntVqXP1QahV6X+anuYQeGoCetL8lQ+PZIwMHA/xEt+XoDuIzqE6uFnDtXull2V
	ST53LwwWZhz2sdimncRYNXhpnDuMdhZI9ol/exkOIcN32+LOk95Z34qcZmeNjcRUGsq9JT1Xwon
	mrBGPMw+qE2RhpTxmAZnf+ez6vjNlXEBulxj
X-Google-Smtp-Source: AGHT+IEga5vn53JmlL3d8Oi0yyIj7dh/m2xR1iBFPscuiMuFWIE4D6fI6Y3cq/aGDee5PHEi6Nlu6A==
X-Received: by 2002:a05:6602:6004:b0:855:8f17:cd8d with SMTP id ca18e2360f4ac-855dac41ffamr424960539f.14.1740152792517;
        Fri, 21 Feb 2025 07:46:32 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea5b25cafsm2158929173.118.2025.02.21.07.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 07:46:32 -0800 (PST)
Message-ID: <b62b6dbf-eeb1-495d-a86b-38f05a17d60e@linuxfoundation.org>
Date: Fri, 21 Feb 2025 08:46:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/user_events: Fix failures caused by test
 code
To: realxxyq@163.com, shuah@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yiqian Xun <xunyiqian@kylinos.cn>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250221033555.326716-1-realxxyq@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250221033555.326716-1-realxxyq@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/25 20:35, realxxyq@163.com wrote:
> From: Yiqian Xun <xunyiqian@kylinos.cn>
> 
> In parse_abi function,the dyn_test fails because the
> enable_file isn’t closed after successfully registering an event.
> By adding wait_for_delete(), the dyn_test now passes as expected.
> 
> Signed-off-by: Yiqian Xun <xunyiqian@kylinos.cn>
> ---
>   tools/testing/selftests/user_events/dyn_test.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
> index bdf9ab127488..54c9412f8dee 100644
> --- a/tools/testing/selftests/user_events/dyn_test.c
> +++ b/tools/testing/selftests/user_events/dyn_test.c
> @@ -127,6 +127,8 @@ static int parse_abi(int *check, const char *value)
>   
>   	close(fd);
>   
> +	wait_for_delete();
> +
>   	return ret;
>   }
>   

Adding Steve for review.

Steve, please review the patch. If you are happy with it
give me Ack or Reviewed-by if you want to take this through
my tree.

thanks,
-- Shuah



