Return-Path: <linux-kernel+bounces-413520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5929D1A82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0AA4B22A54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A051E766A;
	Mon, 18 Nov 2024 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IfJRWo4k"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C76178395
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964999; cv=none; b=F2UlcHDK56kpUD5pihKlKN8sYBZADUsQchxwMi11iCqIY1KxqG2VDAZtBEHaANOi7RY494hNrYBFLJwnWEfBPPfST9U8N4vhTx5lOnU6I6PjsW4VTA9gytuI0BkBSHK6DLfZyV48SFj6fus7RCfLoRVgKpNnsx/aZBjcQQwMCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964999; c=relaxed/simple;
	bh=zQrZapCNTmA++R+1yxOgnkiRv1lT4Ubz58S6wkr4b1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P54d6kXjO32XO2O64bObBd22ZI6ndp+t0aq5Xlr8AoCbOMajQsPP5HPJOgNbBp8Grh603bZ/21WhvNXWjzAasXP+HGVbNTvOphQGbw3EVTRmh02m8EDFjKJTfX3mpEEXAsdtY3BuesrtiJzfP+vjyMn1id7h1Jz+xXj6E9Q7Cy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IfJRWo4k; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83abe7fc77eso8120239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731964997; x=1732569797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZyDvAGYi5T8+sdcs8eDCmKmBYh7FKG7ipAEEuipY0ik=;
        b=IfJRWo4k4IMtT/AVf2rNS+je8YjkQz9Cr5xXZhJgpQqDtqDA1AAiPwkj++dU8f5v4X
         aN/vuh2S6K9mNIrDL0eLYWJSM3HLvQ2VW9H6dnfZNQo5zviRGbqsFLH1A8Lh8eyc7klp
         JCRRpkFuskz+BiBkN6TddI0QQv8a0+vvJDEgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731964997; x=1732569797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyDvAGYi5T8+sdcs8eDCmKmBYh7FKG7ipAEEuipY0ik=;
        b=Rn3IqFg0/vEYoyh9kH/CiHKuUh6LUrWOeDT5xK4z2XFpBMxlH2A/rQqgbC9YtaAHT/
         NMT9oN82cx+1fPAlgayCeMpyuTAJ5GMnSacEhUVB18chXTGr4Uw+yatDkg3zi5gYionU
         bMHSu+AxdvNO1xlnKtsAMd6Oc2Rty9Xquhtah23U+vVOwR/i9HzHQmo7E0c7c7XFbA4D
         kT1GrSSlwGh86TfzPQCJi8ADYgVoSg7VqVKvF2lF8DeWQ03lp51um4DfUWqgMRDNhkGb
         VvHzyiqChAn2oO3TpSYyu//S4xCVub5LN/97nwvZEoDJwJdajbRbgVC1p5s8nbVzObWP
         Lp6w==
X-Forwarded-Encrypted: i=1; AJvYcCWFIgXQ8KM6KlzMqvGA55rLNPJ6OVuj+aDx6SOwoPYEZwku0vOEW+k0Wo6dKBYdtsJ2/QDES1lTFvpLWHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7fwv5MuOze3egnFCvgkd0CpscJL3IG9X5bCGzPavtH13oegi
	9nXSg3R0Z7ASmTT4PM61xw4QcWAUJQU6gQHnabK0DJh5Vf6fVI5XixWZ9pMlTzg=
X-Google-Smtp-Source: AGHT+IGftuaEBzutGH+8Aquw3I/5OGKpN71hV5gOnkYelzzleuOKQUzkqND82BIARdwSZ5YNDjxkDQ==
X-Received: by 2002:a05:6602:1614:b0:83a:7a19:1de0 with SMTP id ca18e2360f4ac-83e6c315b31mr1545981939f.14.1731964997144;
        Mon, 18 Nov 2024 13:23:17 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d6eb863sm2310326173.30.2024.11.18.13.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 13:23:16 -0800 (PST)
Message-ID: <c7f483b0-31de-4098-9416-18dfd0944550@linuxfoundation.org>
Date: Mon, 18 Nov 2024 14:23:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: qt2025: simplify Result<()> in probe
 return
To: Manas <manas18244@iiitd.ac.in>, Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241118-simplify-result-qt2025-v1-1-f2d9cef17fca@iiitd.ac.in>
 <2f3b1fc2-70b1-4ffe-b41c-09b52ce21277@lunn.ch>
 <otjcobbaclrdv4uz3oikh5gdtusvxdoczopgfnf6erz5kdlsto@mgpf4mne3uqb>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <otjcobbaclrdv4uz3oikh5gdtusvxdoczopgfnf6erz5kdlsto@mgpf4mne3uqb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 07:28, Manas wrote:
> On 18.11.2024 15:15, Andrew Lunn wrote:
>> On Mon, Nov 18, 2024 at 06:39:34PM +0530, Manas via B4 Relay wrote:
>>> From: Manas <manas18244@iiitd.ac.in>
>>>
>>> probe returns a `Result<()>` type, which can be simplified as `Result`,
>>> due to default type parameters being unit `()` and `Error` types. This
>>> maintains a consistent usage of `Result` throughout codebase.
>>>
>>> Signed-off-by: Manas <manas18244@iiitd.ac.in>
>>
>> Miguel has already pointed out, this is probably not sufficient for a
>> signed-off-by: You need a real name here, in order to keep the lawyers happy.
>>
> Hi Andrew, I did clarify that "Manas" is my real name, (as in what the official
> documents have). It is not a pseudonym. I am unsure if I am missing something
> here.
> 

Using your full name in your Signed-off-by clearly identifies the author.
I would recommend going that route.

thanks,
-- Shuah

