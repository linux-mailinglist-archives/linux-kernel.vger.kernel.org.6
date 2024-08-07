Return-Path: <linux-kernel+bounces-278542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BBC94B19B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A0EB22FE1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD308146A62;
	Wed,  7 Aug 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QGsRVJfv"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF2145FFA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063766; cv=none; b=DqE4ChkJqYWvPVbz83sfKbI0nhuzct8Px8+xW4fuj7pc3qexc9RNLaxchjUO7+tF8mmKkGt9l+L9aR5L2FU5TXnJIUIyUh4vw+yqjWb2Dh+4cAqJ6yPS9pvjqUNMcobJLtQsnmIRBy/lZB+9Il8o/RF4ArgYw5E+aTXRJwDocvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063766; c=relaxed/simple;
	bh=A4ifWneIPuKomiFloatclvYw6Xk4unBhHN3C0QE/lo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+DFBtkhomlyjtUvXc3meUxBhBaVd1YpwtN8+iIgWSHcEnDjXNrToQqGlcYHIAvhHPeXDUTLpUTuG6YTS1oiZ3pVCmRwWEdhd8CfA7K65e6GcF75rdokWWQTlGEUrEtx8KAf2nbE+W6ea4W2nuhCKSEgX1BPep0u+hhhLCyTmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QGsRVJfv; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-810ca166fd4so289839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723063763; x=1723668563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A35BH8i+y+G8lGp+6rsc8DzC+k6rWSsJ3H+i3Ublu24=;
        b=QGsRVJfvlAFqqJKWctZsP2dz70cnlo8eJllS9ev8pJhI6SjgBxgzem/XDIEI2cC4Fk
         co0UNaudAY3qgDH6T/zXauFZQH0XndgOkHXw4x+7ibbu6I/0ybFMEM0swzJ7okzwcw7q
         Mk7s4/cZuXvVF/vqByZjfRX1JxMGHGBfuvYlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723063763; x=1723668563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A35BH8i+y+G8lGp+6rsc8DzC+k6rWSsJ3H+i3Ublu24=;
        b=TRq3/0c90dnVyW+DHdCMAVTNIWJ1h9iGK+1bjQKWEIRk5ZbCj850ylh3f+43LEAlx3
         HGwP3wkckR4a36n7UqbR6DQ+LxJZ0zxp/mLWz4XAOKtsJbHSj8W4KYjrxhOGWW5UB58s
         6OQgf0z4hcePWx80LMnemuo+ucay/TYCh0RX9LA/AMFP8Mxf7gwoVIQono1Zrf01HSjT
         o9U99Wh/UOk9i9HE4/enbpPra0lqfzmacaHNxMsoZz5CWK+2QeZO73QqriHzdKzs7PyQ
         uCA0bpaF+GByaiy6XP+SVPwC51YMhDD39BUPBpgoGZxQTuN0LMbTTIWJ36k0XiM8xOD1
         ofmg==
X-Forwarded-Encrypted: i=1; AJvYcCUWhnP937ycHtsk2pTXL3hUrKqrx28J77QQWt7dWOuQHA9pTgE9z+kh5YtWjBOt1xy81yyI8i/DSSSH5t8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrj5HNuydThF9wZXrMM48H30b1twuVCQV7MvmIj4vFObEMi8G2
	3uNma7VPXh5pq2QlVezR03ZnAOJw1rsP8vB1VsOPL/oilnVMLjsyUr6ECI5wcYc=
X-Google-Smtp-Source: AGHT+IHC1uRe6tBWqp0tbGMzIoqWnCCrA+bdekxnsQrOQFruZsBen7mj3WNpnf9rnrR3Xd5pZgqJVw==
X-Received: by 2002:a5d:9052:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-81fd43e5cdemr1169419239f.2.1723063763601;
        Wed, 07 Aug 2024 13:49:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a27813sm2969273173.96.2024.08.07.13.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:49:23 -0700 (PDT)
Message-ID: <81512257-d6ab-4488-b400-aeeda1d38649@linuxfoundation.org>
Date: Wed, 7 Aug 2024 14:49:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/selftests: Run the ownership test twice
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ali Zahraee <ahzahraee@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523124541.7dd4cca9@gandalf.local.home>
 <20240614124151.33ee0dc6@rorschach.local.home>
 <20240807162900.32c8e32f@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807162900.32c8e32f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 14:29, Steven Rostedt wrote:
> On Fri, 14 Jun 2024 12:41:51 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Shuah,
>>
>> Can you take this through your tree?
> 
> Ping!
> 
> -- Steve
> 

Sorry for the delay.

Applied it o linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah


