Return-Path: <linux-kernel+bounces-262595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4426593C92D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6722F1C218C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD3852F9E;
	Thu, 25 Jul 2024 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="Pe/xwgN+"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6B51C5A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937190; cv=none; b=eWKfogcfmg5cla7jz8rWnsoLQRygC1+Agr4Fx7KC3JK+RakPn7PEwATJIzJQId+AcqBz2N9q1dQ1qM3KyGGCGiD2CllT8xd3lKwtRDi/rUb4GMKApsC2IoHPueWeUy78htzhLVVkuvQ+BaxoeELqCAN/y+YqRabsWDdjLysiPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937190; c=relaxed/simple;
	bh=qrjAX8ZtHszttz8vYdvcF125vc7Dv4IRgnScP5SMCZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4UJLxh7T/yFzC8Fz7fpFtetf+Nh5PP6T6j1kcfL+amCv+/fov5PqD/LgutKnO/gMMs1OMgFfwi6+IwPGd9Bosvax5pULbJU4Stw0gmMylJ2AxQXqyeU7QnztecHrSkDSQgjHhg0j/Q64EKEeRnRJXeSLV5gwRQjOIJd6dHvs9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=Pe/xwgN+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso962258a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721937187; x=1722541987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yatjSPCxEhwoast5v6pfaV1MSY3YApoRr8CTZJv1ZFM=;
        b=Pe/xwgN+XshlstaDPMStX4gkrVOFdgAhI2/0qr0AnX9UUsKugiuZvwdLHyrehihkfX
         x6ujJWl4uFgRrVFFv7RRNIEh2Ae+qEjX1FgGIXk4VX4t0z9Jb3rfmM6lgUqM259n06zb
         syLysvxCZzPM+I6zxBIU1cR3bN4zzO9X9SMfaLNGN4YaIa+FiRM30eU25cieJ6fvEPtX
         7yi+8961By0VcQGqpZJuIUvyKPB3A09rydutQkCICSTEOV8rvvo8gT31XVMVT8IAcn9Y
         zMW+APJwwl8OwZNWiYVYW0kAIZz84Fpfu6O7Fd0K4XycKDJbZuY+iASWYfB45YbkRRGn
         mz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937187; x=1722541987;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yatjSPCxEhwoast5v6pfaV1MSY3YApoRr8CTZJv1ZFM=;
        b=XZfqtO/nEZTbvqIE9MaJsHIsd+/MxqYf2Jc8vcHYXwE6GUUYHviUZZ2nY2B33jqyDH
         5eINutkXGUsbdO+RnkRLkhCzf/bSyWtTDf2xdinRzJnzJetxnCSp+pucNLls3Na33WKV
         0pi7T5gAW07GwErw3iPdB3OBJoO/zJTQIcjL/y2NglBmgEp5PdQxMaa5W3K1e9NLs95r
         WW0UWdnfJTtgEhTaDMX0wXEVUUNJbYQOtcNZfGRPZT00l6KtDTK3eYiGgdii3YT9U3md
         KlxvgklpJmNDTDA3X230CLFuVxoHzIsDmR/b7Jb7MVNQ9nqyXhbJ6hNR738cjUhDqmXf
         4yPg==
X-Forwarded-Encrypted: i=1; AJvYcCXB3h5M3/3i3RZ4WznOpULGGMGsJ2j2gDoBfeGc01Isy72lOvvuQP2li+3AuTkmarJmzpIanVIbZQq9OxM1LDEod5F+PKEvkuXXbtNJ
X-Gm-Message-State: AOJu0YwLOhgj16fYMTH3cTzavDHjHH/m0JtiLh49aCft586f/xcELhuh
	0O58n4q5BSIiZSNox3jNyL9Px6rT/ruImd4NuWOsOamCyvTbHWBZbIF6sJd9NHo=
X-Google-Smtp-Source: AGHT+IFs3lsnbIAhS4feK8PTtWLYT9H0xjTGQ5V1Cz9O6ywu3vLst4rAEJ0budxAVRrhMcoSy/Yzqw==
X-Received: by 2002:a05:6402:2684:b0:57d:3df:f881 with SMTP id 4fb4d7f45d1cf-5ac6203a217mr3720133a12.3.1721937187016;
        Thu, 25 Jul 2024 12:53:07 -0700 (PDT)
Received: from ?IPV6:2003:f6:af0d:f500:3285:7112:e461:c95c? (p200300f6af0df50032857112e461c95c.dip0.t-ipconnect.de. [2003:f6:af0d:f500:3285:7112:e461:c95c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b5a7absm1111914a12.54.2024.07.25.12.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 12:53:06 -0700 (PDT)
Message-ID: <b8d5c42d-160d-47a9-81e8-289b49606c9d@grsecurity.net>
Date: Thu, 25 Jul 2024 21:53:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tracing: user events UAF crash report
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
 <CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
 <5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
 <CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
 <CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
 <CAD2QZ9YAzq3jq8CyAcoG9YuMD9XWHbk3jKxAmszuSkJ3mtGoGw@mail.gmail.com>
 <20240725131021.788374d0@gandalf.local.home>
 <20240725131632.64cab267@gandalf.local.home>
 <cff51d4b-80eb-4587-b4ad-bfe7d7361b19@grsecurity.net>
 <20240725150517.3184e078@gandalf.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240725150517.3184e078@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.07.24 21:05, Steven Rostedt wrote:
> Here's the proper fix:
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 6ef29eba90ce..3a2d2ff1625b 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3140,8 +3140,10 @@ EXPORT_SYMBOL_GPL(trace_add_event_call);
>   */
>  static void __trace_remove_event_call(struct trace_event_call *call)
>  {
> +	lockdep_assert_held(&event_mutex);
>  	event_remove(call);
>  	trace_destroy_fields(call);
> +	call->get_fields = NULL;

That should be:
+       call->class->get_fields = NULL;

>  	free_event_filter(call->filter);
>  	call->filter = NULL;
>  }
> 
> Can you try it out?

Just tried, dies the same way, as expected.

Thanks,
Mathias

