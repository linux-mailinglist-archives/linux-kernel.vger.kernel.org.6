Return-Path: <linux-kernel+bounces-200947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7B8FB717
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114D6286B74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DCF1442EA;
	Tue,  4 Jun 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmlSE5jw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09DE143C49
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514898; cv=none; b=TDtkJE3lYlmqsNwdXmxAr9iD1jvMwerw7TDl4Pn7YAB3Iy/lCYlE9b+ZjPiwFr6ZdrZXirWOZlIQHS/kzG4Ajt41QoN9TtrpF5RrH8WJ84O9ytmSHGNYkQIyQboTCbR7wrF8JYITG4ZH4uvsgCe0gF84sFpJv9rkFKQxAEyLH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514898; c=relaxed/simple;
	bh=e2aM5bi24fW4jX+euawpljzpEa3P3eFPiNOlYc3CLIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j95uIUya3EBaNff0FX6qSHx0/WVhFSSnFCLwivIObu+nFu+gtm+ltYWR5t7W5EI9Zods/GLlBHA+ZVTqi7zlbddB4jDK4qSuulDpuffckrohLF+9DY52OkdPmPJj2kU57AB46wRdwbdaGH4qwMYu+vksBIuTaDdc5Aviks2SNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmlSE5jw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717514895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vevD6PqPhwnaWMxk5nmU8UGLvy64ajKyPNaDY17hdc8=;
	b=NmlSE5jwD59EcMzsB4kUN/8r5lqRoQyzhrCIH2mJFzrbN4ObHxzOozQ16em6KbFEdXzgpU
	L1eWP2BRUEDEiKNJ8vbFw8yjePTUwpEnW48T1CHggxp0uS4d/5bI/SipaKfHHsqA1T08jc
	ftvMG3/Cv7qxRqs7+X4OFuAmlPgGRG0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-cDvO3kiqP9eCS2VbfKxS-Q-1; Tue, 04 Jun 2024 11:28:14 -0400
X-MC-Unique: cDvO3kiqP9eCS2VbfKxS-Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-794aeada1faso616159385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717514894; x=1718119694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vevD6PqPhwnaWMxk5nmU8UGLvy64ajKyPNaDY17hdc8=;
        b=U/jzNX1bn8mcJiyxQhJ9TeC/BNnUNwsomlgKybsuy2ima7Lj4retPF73oQbOZII0A7
         7emRLv5/rH/ZhfY65clEDiFx11YwAH04LquwRP786UdCdbVywiGmED7z2T6ngjM0YfzV
         PRqOSDqsWiYxKMigYyPNFqps1WAZGI24II+CMfA4qTgZna5o/OlHcIe/NksdUeTlAOQs
         tgsbJvXc1FeO3SaLQAcJMTspFDGDoXlisoJhuq089crOH6CSYwqD9oLB6evjFwuBh1oo
         kuFNcxMJHRp3ZugNvKVARXD9jsCXrHqtAYIiv0I8tMZ4zEAAWM7xnobDaOIv1jdQ+ntz
         qP2w==
X-Forwarded-Encrypted: i=1; AJvYcCWv2pUGaduRH4cDYLTtHFuoppYFC+5p1CdnV6QArAgl0yy9LHi4N38VT/TTjtE9izaD7gKgkSHXJtIsofr/Shin8hUFPw/ymf7m0zKZ
X-Gm-Message-State: AOJu0YyyptnFG7mIRoeF7vUjQ4gDWeGhcu6s86TFpFzhCfVxQX19meav
	0giMy/uFQBU1TpWoVzib8MSo5IzNTpbrFDQ4qNDRGCl1Dv29nA51o58wBNQ+ivH3538pm8sAqnf
	K4+ZYSBNi8Gnd83wqcGB7Bt/X1SQiRLyDjrwCjvcm7howJmJH1qyij6GnVnL9bA==
X-Received: by 2002:ae9:f106:0:b0:794:99d3:d223 with SMTP id af79cd13be357-794f5ecdf6bmr1054585485a.65.1717514893886;
        Tue, 04 Jun 2024 08:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGETiN1xYb+s15NMu7MGoUx3B3zceRz5lcvgQvBjHBrFPnq4rdxvhEXfGZ8IF9We6ruUKMEA==
X-Received: by 2002:ae9:f106:0:b0:794:99d3:d223 with SMTP id af79cd13be357-794f5ecdf6bmr1054583885a.65.1717514893525;
        Tue, 04 Jun 2024 08:28:13 -0700 (PDT)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79522e15a10sm584585a.12.2024.06.04.08.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 08:28:13 -0700 (PDT)
Message-ID: <2830be33-eea3-4bee-9f4d-8d96544e4d80@redhat.com>
Date: Tue, 4 Jun 2024 11:28:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power turbostat: make the '-n' command line
 argument work in all cases
To: linux-pm@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
References: <20240520185749.1404283-1-darcari@redhat.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <20240520185749.1404283-1-darcari@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

On 5/20/24 14:57, David Arcari wrote:
> In some cases specifying the '-n' command line argument will cause
> turbostat to fail.  For instance 'turbostat -n 1' works fine; however,
> 'turbostat -n 1 -d' will fail.  This is the result of the first call
> to getopt_long_only() where "MP" is specified as the optstring.  This can
> be easily fixed by changing the optstring from "MP" to "MPn:" to remove
> ambiguity between the arguments.
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-kernel@vger.kernel.org

Is there a problem with this commit?  I don't believe it has been merged 
or otherwise replied to.

Thanks,
-DA

> ---
>   tools/power/x86/turbostat/turbostat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 98256468e248..8071a3ef2a2e 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -7851,7 +7851,7 @@ void cmdline(int argc, char **argv)
>   	 * Parse some options early, because they may make other options invalid,
>   	 * like adding the MSR counter with --add and at the same time using --no-msr.
>   	 */
> -	while ((opt = getopt_long_only(argc, argv, "MP", long_options, &option_index)) != -1) {
> +	while ((opt = getopt_long_only(argc, argv, "MPn:", long_options, &option_index)) != -1) {
>   		switch (opt) {
>   		case 'M':
>   			no_msr = 1;


