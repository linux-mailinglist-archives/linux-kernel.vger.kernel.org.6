Return-Path: <linux-kernel+bounces-545255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD778A4EADC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0298D18812A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF0825F988;
	Tue,  4 Mar 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NQzlvL4P"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DE260384
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110557; cv=none; b=fqn+KzPmF3lWf1TutQkLgK9mjLnB27WBOSMZGqigUWWNaTq4EUmP0f04YElJ//N1Cqk3DqKe/3liMsAcw0/yHOac/6bwX57Rdc8GqqeKVRkF44ejdMT9iPRAYHmrIHiVqhK8n1FAufyHwr6YEPMKxNSDR5H1kegR4zRDuTJmCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110557; c=relaxed/simple;
	bh=a/NsExaXFh0brcXTlOrd7Y9Oa2VoHQLFMML8Cnz3x8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4xU6HW5MzEKuwpQx9LZe7Szv2WtuYbEagD3mzflI5bxlImwXZRtVzIja8aQGv7TAjhlE9rPoBXfkzMb3xG1TDqm19/C6DFqtYl0ou/6V/mkmF0m1ORddWtGHWigd67w0Kz8Kp4UK8oUS9wwFBacGShgYRhXcqD12/C0NP3bOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NQzlvL4P; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85add67e9c1so1799539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741110555; x=1741715355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIQyE8Y/Wo/k2rg3+kTPzMkjWvoAdVITwTvTECg9USE=;
        b=NQzlvL4P3ffJyregCzibatB6h+EOd/9u2ob2LaC66DSLUJUIY0VqvLWeSBQwpA7Ggh
         DQSZB6HVAAigouET/dQOPg/d3ee4W8vzvujgEeQnJVIrCEH4YfPLzpIhRDoF7VVbD1z/
         vj43j9Lvc5JzmBO513KbcxbUwZIghQsTtThkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110555; x=1741715355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIQyE8Y/Wo/k2rg3+kTPzMkjWvoAdVITwTvTECg9USE=;
        b=qlQ2ibQRwLX51uPR0vwDzKovvAsk5iD8ect2j74JV2uxqt5rqLWnpJNhslqCdUQNnL
         tkcsJkJWwUTIACdQ+VSAU1/DFSV2hYgTqHnNhaCRqpQKbMh6SorPJOpqH1zuWLZfnPJR
         xMdLb+cN+kEnRuClhqJnDfWsuqKK6nKl/uY9JkjOi2eNW4v4vlDu6CUd8BKZsLd7qd1i
         uwsdpETysMHK+qDi6yLst+UVA4BDuxrin5gUWnrx4bXu6vA5riCR1wWdUyC8IUS6qHYC
         8U5HCNdM/1GCR2ZBL7Zmor+Wqwn3BdKqrnUEgz+Alg0T8XfeNVZWKxNVrr1DUdoKHHxZ
         EB0g==
X-Forwarded-Encrypted: i=1; AJvYcCWCcuUDuD++rBIjZvPL1KP7LbUBLH9xhts7jcuXcZBxg/iBWLGJn1Uzgo6Y4eidx0ZL0kL1i4BjuXcGbzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAtVvQ/ySOyd+GOv0/Lm1y0Rf6M+CKlQlS8oo/kTHIkCE+t7F
	GlB3t/qjQfOiX6kHjxd+PKTh/gzO8Ohz0Fyhi3nNt/ajXdbdE32dCLCy3+4/hlJwf3wkFjtVCiR
	y
X-Gm-Gg: ASbGncu0DRtZ4t4AiOQT0J7d7APYVPjwXtwzeK/25DfvgThUFWgEN3KbciovHNj5qIh
	11vY+2zFP11bTEDfdOeFpEelgnmqvOASQj0TMAocz5+C2ObdxqBonzK3bdHW1plXv+9Vj7smtUE
	9kqiBRQhBcD7bfD3kzFc6/f7+1+ss/obUDOe4IBb6qMQCIzTR1LTAe2hwTVMsUWZcTLjNKUjU5c
	eWgUDj7ebDmckEPKC/QagMQbi1rAfwqJOHZOKRq+BbIrSMeIKyJpTGgR95SCjfseo/PeOyucery
	7i2tUDzw47sC5PUzH8k7fj56SV0q5efcDNr2fg6lnK+ThY76zGNaLHQ=
X-Google-Smtp-Source: AGHT+IFe/EZGXyCyM4u01MW+pkyp+aV9q8tehK9bM2e7HADyRWDjWbe46QsDS+SMYJ3Ljp5Ifn3NgA==
X-Received: by 2002:a05:6602:370f:b0:82a:a4e7:5539 with SMTP id ca18e2360f4ac-85aff6300a8mr5572839f.2.1741110555067;
        Tue, 04 Mar 2025 09:49:15 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85875133ebbsm295183839f.28.2025.03.04.09.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:49:14 -0800 (PST)
Message-ID: <a9628a00-2bf3-4d86-8e41-c596079cd8f0@linuxfoundation.org>
Date: Tue, 4 Mar 2025 10:49:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: add 'poll' binary to gitignore
To: Steven Rostedt <rostedt@goodmis.org>,
 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250210160138.4745-1-bharadwaj.raju777@gmail.com>
 <20250303183625.5acc59ec@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250303183625.5acc59ec@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/25 16:36, Steven Rostedt wrote:
> On Mon, 10 Feb 2025 21:31:34 +0530
> Bharadwaj Raju <bharadwaj.raju777@gmail.com> wrote:
> 
>> When building this test, a binary file 'poll' is
>> generated and should be gitignore'd.
>>
>> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Can you take this for your tree?
> 
> Possibly with:
> 
> Fixes: 80c3e28528ff9 ("selftests/tracing: Add hist poll() support test")
> 
> So it should go into this rc release.
> 

Ooos - I applied it for next for Linux 6.15-rc1 since it is just
a gitignore change and not critical.

If you think it should go into this rc, I can apply to fixes and
send it for this rc.

thanks,
-- Shuah

