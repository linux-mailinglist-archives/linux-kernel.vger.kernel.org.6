Return-Path: <linux-kernel+bounces-235114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040B891D050
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356A71C20A95
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 07:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B2433CE;
	Sun, 30 Jun 2024 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERaYyiH7"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE239AF4
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719732987; cv=none; b=RN9rRaGN7tUKTpZFrQ1JCLIedVEDgPISPC5Z/q5t41QMaVfKGJobdQ8YKCWitnq8haa9lxQqwmtcK18U2K3DW8bG4GanJzLuGFCEkyXkLG5o0WFxtWJqpSFqqFFa2shtql4oD2f4TT8zBmlgZGPjB3lsbXFVT6zb61pbBBO69yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719732987; c=relaxed/simple;
	bh=K1yqXabSmtFTytE5tJ/NwZ60gj1gIUj2rF6t5hWQhb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpYVaNUpPDkW9p5ZY2HKUeHBPs3/zFJMbvmMc9sB3poppTGL4WzqvJGT0idVSfoYBvIStepqjMjNPxC/Sv5pPs4TzNR2045tObHUCEPRe4YxIUFCGQZ+n6jObNgGR0fayWs2IleL2L1y7aHS83Ob6zNhEfnKSYPWR4rd2194mFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERaYyiH7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5869606a790so298050a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719732984; x=1720337784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVieZ92jBl/CzR6Z48+iNSy4zfBATYYDszkc1x7Stus=;
        b=ERaYyiH7CAZU8wyrzkMz4YlkZ7fiscxhyK2+gQ7vS8QxCVycE5imuPlDRvnLUcCxHE
         qIPimKxHiJJgRMfmBizS5t8beDq65FHqMEstvq2xUF947W57d8VAFoB0kQoDIDGTvAtT
         ek+j68KHWucsVdbY+2As0M9hAoHTuIltwY07qr8LbJ/jBxz08ZLTVDZxnZtOx/Y6LTbT
         hCS+unPdrY4+vk3CgANRPV/mxxvglQBAETCY5I810p+aHq5eXK9iLWW/SwdJJHTxp9jS
         Werdv8MhHabvrSnfZTcuHsGmmkMg2Yggx4nuB6kHrTsz375TKgeRton7eWrdGoLcL6Fi
         s6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719732984; x=1720337784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVieZ92jBl/CzR6Z48+iNSy4zfBATYYDszkc1x7Stus=;
        b=tm88AsG7B8h+ihJaF/dIw7EF6AHH+JOK6IHn9dmUAiIQ55DkP0E6aDjn4nLsp5zzWz
         xKXMqq9cVEGuOcbnHbv0EU1P0Y0Y5AKULnoeEJuz5acu9GqSfyI/YlB9fZydCrxSV+Yp
         EQhWHiWC+HN0asrpBbptSsh4fvrQLn5UptrmzPQr19z0ZR7Bn+ysrIyPL51qm7czMGDV
         hrHwlDBrfU0fltFbdutQnRQQXpIMa4/+dUmpr+1Uip5A1X4YX1lWT/y7vtnOqiwV6NKv
         ov83/X51TB1cUO1M3gcrFHm+7iARzCyqjQ9iZhsoMbYE4A7bfZOsM0uJhKWm7QBNMSzr
         Ckrg==
X-Forwarded-Encrypted: i=1; AJvYcCUobUpsyKhcmXp1wXKMjurVcZMQBqgBYBpLCI9DDanobvx4+TBxi/zztoKEtVNA5WMajAuHGIZs+k1jYU2WwRPNhCa89zKWfNfXgu1u
X-Gm-Message-State: AOJu0Yyi0/zNdclHq3C6+KUdKCEjDeSq0Uv4pJ6mOeLhov63OJIEv55g
	1WkXIImxXbuhHQBqSDhS3yme+WmuHRd7VkkYNW2LixJxyC7Rr9ge
X-Google-Smtp-Source: AGHT+IGfd4k2I6+RoqvedQxvg5gbs6CEm3OyhzbhPXQ1ph2NJ25JDEw0LI2JIhi4R/tL3Y12XcOmgg==
X-Received: by 2002:a17:907:7213:b0:a72:b5c7:d635 with SMTP id a640c23a62f3a-a751459c4f1mr168176166b.4.1719732983559;
        Sun, 30 Jun 2024 00:36:23 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7315bc5185sm134339166b.41.2024.06.30.00.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 00:36:23 -0700 (PDT)
Message-ID: <43cae9ee-e05e-4447-a62d-eac8307e9670@gmail.com>
Date: Sun, 30 Jun 2024 09:36:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Staging: rtl8192e: rtllib_rx: fix alignment
To: Bagas Sanjaya <bagasdotme@gmail.com>, Yusef Aslam <yuzi54780@outlook.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>
References: <CWLP265MB65165E806F938F87CB67BF87FDD62@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
 <2024062727-diabolic-lusty-7baf@gregkh>
 <CWLP265MB6516AB499D407C0AB0CF106EFDD72@CWLP265MB6516.GBRP265.PROD.OUTLOOK.COM>
 <ZoCeul3pAjZLOT8E@archie.me>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZoCeul3pAjZLOT8E@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/24 01:54, Bagas Sanjaya wrote:
> On Thu, Jun 27, 2024 at 07:09:50PM +0100, Yusef Aslam wrote:
>> On Thu, 2024-06-27 at 15:43 +0200, Greg KH wrote:
>>> This all should not be in the body of the email, please use a tool
>>> like
>>> 'git send-email' to send patches.
>>
>> Oh k thanks, I was trying to use git send-email but in the end I just
>> copy pasted the email into Evolution as msmtp was not sending emails
>> for some reason.
> 
> Authentication issues?
> 
> Confused...
> 

Hi Yusef,

I use gmail. There I have 2-factor authentication enabled. I am sending 
my patches in via mutt. To be able to use mutt I have to create a 
app-password especially for mutt. I have no clue if you need to do 
something similar for outlook.com. I recommend to use gmail for sending 
in patches.

Feel free to write to me directly for further questions.

Bye Philipp

