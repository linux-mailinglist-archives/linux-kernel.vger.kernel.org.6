Return-Path: <linux-kernel+bounces-234566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643891C815
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E141F22F82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5F7D41D;
	Fri, 28 Jun 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O1dHgMdV"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CD47F7FD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609941; cv=none; b=GeTQl3XRNHSsbIISv3kinSwBFMMea6YqDm3IdYsw3lYlR0s/kHJZoijtAfkXBTQfWotXdOLvJDA7I3UIji0gAwatR1TRfEFAmT2xhGssaxpwag/0nwdbrJLboONi5egoxwqsLNLre+YG9SSVlB1polp2UHtneOvx4U7s1mRMPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609941; c=relaxed/simple;
	bh=scWs8AjqfrqRGXwxciWVjYMi3tdfJ1iOV0WlCKbBrRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9ywxfJorz3AlpKjmHijPkfb4ns0gQ0696r1k5hwnmxF5RBNg7bbYqMd6OJUkLNup93UrNIwEciHZOp/3/RxQbtNNnNlLQUSlHBU4/5PX8Pqk9iinHrWJxR69DIv3gAfr4OFDT/DibDmZOp7AIDk3JAFtZvmEzXwexpBzoyxbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O1dHgMdV; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3762c84e120so762885ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719609939; x=1720214739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=It+RDzHG+5ogUHKIy7nb7bB9vaKghvmsmBT3k+kyomY=;
        b=O1dHgMdV2D8QoNBxDpspyNDLcoAT44XjQd8rhcvZ5z7exJ6RHsQhHk79pqCUiMSGAC
         ggyitmoUggrHHJQ8jn21FeUr83ZFFh2l4unT0PnYN3f5+JZMNZorc/3PqiiZ0D2IamJp
         7IlMYrvfLAhsmlqtdr34TztFVS+usZbEkeVeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719609939; x=1720214739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=It+RDzHG+5ogUHKIy7nb7bB9vaKghvmsmBT3k+kyomY=;
        b=HJWmy6AVPkx4z/Mdlkiv9DKtr6mXZxuak8CAk1dGMvTeYNTc4s/zBtPTaLuRWLZT4/
         KNSCR3nmGOlYCrjOCv5JxWYILJhCBqGsFZXjyw6XmJJ8tfPD1HvuzJ8GYT7VCQgByo+o
         o8nYb5fNg4t+uXi9HoUSB6tw4V5GQL7TCbDHGgMNLLatkyX04SeVTZnK5/x5RlzMmlUV
         blo9MEIBo78mmAQcx6M+1k2s6StEGKsL3AvpX+gcqiiGfAzg1QMQX8vhObZ+j4P5VyVn
         7yWAdIKqn7OoJB27OpTSYn3woVNYc4E+NhyT0yPVL/XCDXNtSJNcUdmTpZCoWb1qebXo
         VosQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTU3wJUZprhOjp6Vpr6Nlz5J6LvV739Um3Ss0lRiAVBJV5Yq1naM/uJo7vdBcgdrBpi+slCTtiAtZCbWZjWlW4oRR0rRbLldh9nbgd
X-Gm-Message-State: AOJu0Yyt5r85KQ8GzwcHudOUgCOddbnYhuAZv7gzb7857679JYDFUKP9
	VG20llQ4zWVCdJsqmOV2rFMkxizrflTVsdZNTVlvzBTIhT9LeQvvA4EWl1kaAjQ=
X-Google-Smtp-Source: AGHT+IHiUQdGE9H3dHPJzOzgKCJ1Ty5wnxw9nJM9Yar3NdvtWjfQ+U2E7MMQ8jVQti8VlicMejQ9yA==
X-Received: by 2002:a05:6e02:1583:b0:376:408f:585b with SMTP id e9e14a558f8ab-376408f5927mr199339285ab.1.1719609938755;
        Fri, 28 Jun 2024 14:25:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370bedsm6015165ab.67.2024.06.28.14.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 14:25:38 -0700 (PDT)
Message-ID: <91d2f8dd-0de5-4959-8fd4-4c142b6a4f62@linuxfoundation.org>
Date: Fri, 28 Jun 2024 15:25:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: kselftest: also use strerror() on nolibc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
 <20240426-nolibc-strerror-v1-3-76a4c9c5271d@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240426-nolibc-strerror-v1-3-76a4c9c5271d@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/26/24 05:08, Thomas Weißschuh wrote:
> nolibc gained an implementation of strerror() recently.
> Use it and drop the ifdeffery.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   tools/testing/selftests/kselftest.h | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 541bf192e30e..f4bfe98c31e4 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -161,15 +161,7 @@ static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
>   
>   static inline void ksft_perror(const char *msg)
>   {
> -#ifndef NOLIBC
>   	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
> -#else
> -	/*
> -	 * nolibc doesn't provide strerror() and it seems
> -	 * inappropriate to add one, just print the errno.
> -	 */
> -	ksft_print_msg("%s: %d)\n", msg, errno);
> -#endif
>   }
>   
>   static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)
> 

Sorry for the delay o this.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

