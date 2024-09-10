Return-Path: <linux-kernel+bounces-323732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7C9742A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C52289BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E137C1A3BCA;
	Tue, 10 Sep 2024 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Za3Zw2O/"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463E23774
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994202; cv=none; b=KONZksLJFYu59vyjimSYFvMgJ+DULt+mRWSR//p96mC5rH+JZCqvk/wv6fHGKn5Xcq7jd3NhRtrZgKGJrOF3pEOrVctCNWCOhRXIqP9o2/EqNP59yyzqhAhmL7bZ69ZovVmT1jkl9cQPTK0vdovU7GBaVSjSzb0FnRxnXgTtDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994202; c=relaxed/simple;
	bh=1WdMvYdJoPmD9mMn4XDK4ijpAdELRzGHP0yEkPBv5wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BplqmF0j3Vn0EWzw8voAcfYqmIaU8C2+p6YZFBkVE91ZgDU2ZdSKYKvhDRVok1qYIVJjB3uo/oXzJnZU48ibV4cZqNPFNitsiqAqfNCkkPm83m+NiaBR9z6PHvod+PAPT9bC/gz5Fd5d/zeAdbvdfXgMfeoafyjO6lj67kwcKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Za3Zw2O/; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39f540795afso21406815ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725994200; x=1726599000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+vWHNEoY3B8gMdhj87TmXWauc6HpmVdxTpzf/fN/+s=;
        b=Za3Zw2O/E5jIz0wAMgerVheBc3eec31Pk03gZP7HxHYJl61Ya0KTkDIlkxIXrtdYvM
         q7INNxAhBFvvCC1kCnP4MQHA6LzOlI6ysHdt3FNqPVNxBihaRGbzmeAQWofwMNV3qEGG
         E0dZsNiMbo4KBJKsfxwSqnJjhviJHQjHwwj8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994200; x=1726599000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+vWHNEoY3B8gMdhj87TmXWauc6HpmVdxTpzf/fN/+s=;
        b=AP1360jMAEeIDjnZp+iTVKsBMCVzCsLQPS3HnkUacXPs3Dn2LDG9Nhr81Z/QA8g/tk
         JqNH8WHIGlFdf8MXetpT/L6CF/qPst+2jzkORXTGtsSajji38dyfYLLPRJtZTcA0EJIR
         CytDqip6f3Wdb/SKC92As7y4AVBj7yCANJjYzAK7wLyReNNLmJcPjzChfde7Vt8jU+fY
         ilut4G/hTKuyZLC5driJ/CbJfsQCZEjif5BN2wJdPEeQmvakVVNyewDYkm0Xc7YDagwS
         fsj/ex4LGSWCBrSJZMBDRW5nKS7/TeSSBWgMwN9JsomWE9mE72HY1KxUeACki/kwulAK
         RpEg==
X-Forwarded-Encrypted: i=1; AJvYcCXke8uwFdr3EnrD5o5VxBnVLje4edV3n/wLJT8PX85TK5f/jVbhNZ+tWf1ZgN71xknZ3Kn7m7zy6aZbO0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vDNiq2wakRi3eRr5ZNfQj82uXHRBXTb3hAAylfEFXE4swB2Y
	tJl4JeTSifIRAcFy/X0a++V+HKey7ScUG+0K7zACqhZlCrxw6B81QD8+OTgBojc=
X-Google-Smtp-Source: AGHT+IFkNN43djyLVohLaa+NqGwq6sV8jRgTpy0ojuQ+SqlTmPROviO2CjKjQ87t96vGQGvibwVnLA==
X-Received: by 2002:a92:cdad:0:b0:3a0:4250:165f with SMTP id e9e14a558f8ab-3a04efe9f61mr180725555ab.0.1725994199798;
        Tue, 10 Sep 2024 11:49:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fe56dasm21533775ab.52.2024.09.10.11.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:49:59 -0700 (PDT)
Message-ID: <14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>
Date: Tue, 10 Sep 2024 12:49:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire
 meta-page padding
To: Steven Rostedt <rostedt@goodmis.org>,
 Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-2-vdonnefort@google.com>
 <20240910124541.23426cee@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240910124541.23426cee@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 10:45, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this through your tree?
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I can take this through my tree.

> 
> -- Steve
> 
> 
> On Tue, 10 Sep 2024 17:23:34 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
>> Improve the ring-buffer meta-page test coverage by checking for the
>> entire padding region to be 0 instead of just looking at the first 4
>> bytes.
>>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Vincent,

Can you please rebase these on linux-kselftest next branch and
resend.  This patch doesn't apply.

Also please fix the subject to say:

selfttests/ring-buffer

