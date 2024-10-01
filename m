Return-Path: <linux-kernel+bounces-345579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A098B7B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD421F22140
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAD19CC00;
	Tue,  1 Oct 2024 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzhOIvZQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2119AD8C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773021; cv=none; b=gYiEvBn5+pEpcpoV/DQtnShtBgUpV4zrB7ZwCOh8kxxSehE4+EJCY33M4HOI8Q1t8nDO9VLq/qKSlcSF4xCNGq/ebyK8qtfHl9FhtTiQTsasjEmgdFM0T9hQKDwhZvW89y9rK1ZQjdbeaGm6NesWRGQJoP/ZUBFrGomFRP+fJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773021; c=relaxed/simple;
	bh=b9QfWqsgPJr0mtTApyLLRojRTWemhFwB9SNS9Qh5tg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkiQclJcdIo6+fIgzOoeD4KdsxyI8o2rBwkG6KNckJZ2SxeoO4xUW0TH4IuWQUSc4Ha0WIZIiSnjyd+Hr3XISByUKnOe5Q8fhiYz0TFrQ2rlRsHs3ZjkTxm4iwlrUX6w4yUDyVriQES1Ja+KN/HjCmYp5KtTnaVFfHC+G+1tHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzhOIvZQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727773018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g4BMvIXvNNaCPVGu6e/diRbs+QMYslxcPJVRTr2AJQE=;
	b=dzhOIvZQ9TJypH1367GEBUFNK33X9TlLrya6mOzWe4o6MquHeEDMYsujUoR+jYMOTBufNT
	b9zMz7hecBQG4eVhhDwkRMxINQwrMMhuW6Kcmf75Qo2QolVpXOK0n7NSTd7dXik8YmbESw
	YF3JUL8/ITlXrNlymvfkQKhXvfNWfsw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-2uCYKlsyOdaVzN4LSqBc8A-1; Tue, 01 Oct 2024 04:56:57 -0400
X-MC-Unique: 2uCYKlsyOdaVzN4LSqBc8A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8711c48990so438965266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773016; x=1728377816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4BMvIXvNNaCPVGu6e/diRbs+QMYslxcPJVRTr2AJQE=;
        b=KcW98+6hAcVpgSuVrZQOQwgaChnYQH0HitOlhn+ZL21lnoy0RzCLsWO29XmRPCrb68
         GPxw6qFLQIakRcSAFHt2D57LYacjZZE3b9wOi7i8TX7Gll7PPHyXmVl2rNJ296a+dc/m
         JhJancSJYi3IQRs0r4s4QSUUiTn9DVKNEytSceQFYOkBFFa14hjpTI0BegtiQLjxmpQZ
         hcAT0wYT2SwafcGV0Izab+uPUaweB8v5WZzcH+v2Jrh419Qo1xVmEvGOzSHVFYFLhdON
         lEYmoDRxgr6gJl5/mwrhhMSrd05LCnXk4IyeJeq1MlZqEr/pMBriufI8fsTn5LJ0bzBX
         byDQ==
X-Gm-Message-State: AOJu0YxFDHTaqBFIp4lde7AkBSOw36XESV9JoyGPIrp+wwuiWITn+ORf
	e0en5QeXY8X6lwK/SI+v1k5/oVkWmUilCAvHt7aoZSOp5OqxmotUoHPqRpnffi/eNuV8w0gh+GC
	0OSXTfrgPf1xZSJfLLHJKC9rw9ywwvM7VdOsm8I8l/QMfavGWYfZYqCBTZCnWCg==
X-Received: by 2002:a17:907:781:b0:a86:894e:cd09 with SMTP id a640c23a62f3a-a93c48e80c8mr1623558266b.9.1727773015831;
        Tue, 01 Oct 2024 01:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGy9+7UQRw4H1RY6QI0dnOP/L1CJDhBodjL/25CNWH58/W2xClwExiqoPP+ViSpi9Uh12ZTQ==
X-Received: by 2002:a17:907:781:b0:a86:894e:cd09 with SMTP id a640c23a62f3a-a93c48e80c8mr1623555666b.9.1727773015306;
        Tue, 01 Oct 2024 01:56:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93cd958fabsm604470566b.22.2024.10.01.01.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 01:56:54 -0700 (PDT)
Message-ID: <80930b34-3b31-46d7-8172-6c0cd2ee497f@redhat.com>
Date: Tue, 1 Oct 2024 10:56:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
To: Ard Biesheuvel <ardb@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mike Rapoport <mike.rapoport@gmail.com>, Kees Cook <keescook@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20240926130159.19e6d0e2@rorschach.local.home>
 <CAMj1kXF1=2wLgM8HP6BvUxdZLK4EdnaORLUTjoDJSZP-hhDJwA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMj1kXF1=2wLgM8HP6BvUxdZLK4EdnaORLUTjoDJSZP-hhDJwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1-Oct-24 8:17 AM, Ard Biesheuvel wrote:
> On Thu, 26 Sept 2024 at 19:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> At the 2024 Linux Plumbers Conference, I was talking with Hans de Goede
>> about the persistent buffer to display traces from previous boots. He
>> mentioned that UEFI can clear memory. In my own tests I have not seen
>> this. He later informed me that it requires the config option:
>>
>>  CONFIG_RESET_ATTACK_MITIGATION
>>
>> It appears that setting this will allow the memory to be cleared on boot
>> up, which will definitely clear out the trace of the previous boot.
>>
>> Add this information under the trace_instance in kernel-parameters.txt
>> to let people know that this can cause issues.
>>
>> Link: https://lore.kernel.org/all/20170825155019.6740-2-ard.biesheuvel@linaro.org/
>>
>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index bb48ae24ae69..f9b79294f84a 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6850,6 +6850,9 @@
>>
>>                                 reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
>>
>> +                       Note, CONFIG_RESET_ATTACK_MITIGATION can force a memory reset on boot which
>> +                       will clear any trace that was stored.
>> +
> 
> CONFIG_RESET_ATTACK_MITIGATION can force a wipe of system RAM at warm
> reboot on systems that have a TPM enabled, but disabling it does not
> prevent it. Also, there are many other reasons why the trace buffer
> region may be wiped and/or reused for other purposes, so singling out
> CONFIG_RESET_ATTACK_MITIGATION like this is not that useful imo.

Since the userspace parts to clear the CONFIG_RESET_ATTACK_MITIGATION
related EFI variable after cleaning cryptographic keys from RAM has
never materialized CONFIG_RESET_ATTACK_MITIGATION is pretty much
guaranteed to clear any traces on any modern machine (and at least
in Fedora's kernel config it is disabled because of this).

I agree that there are more ways the RAM might get cleared, but
since this will clear the RAM almost 100% of the time it is worth
documenting this IMHO.

I get the feeling you (Ard) see documenting this as some sorta bug
report against CONFIG_RESET_ATTACK_MITIGATION, that is not the intention.
Quite the opposite the documentation is there to let the user know
that CONFIG_RESET_ATTACK_MITIGATION works as advertised and that it
will (almost) always clear the RAM on reboot and thus conflicts with
keeping traces over reboot.

Regards,

Hans



