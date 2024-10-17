Return-Path: <linux-kernel+bounces-370639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3B9A2FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0AB1C2040F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071FD1D63F1;
	Thu, 17 Oct 2024 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a6ZAwRub"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A11D61AA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201263; cv=none; b=YE23o5MEIIIq8mfi/Zdy4pQ8EayGp6mPXUBRMJYyuCB8haP9e74G+jIq/0XWUJK2uDK5PMHNJaqZrM4DdLWNLGlIqHr+wB/820vh+kTK8BFBKkMXmkykjvmQ6/2NKIsoDt4RYzreE0iaBJg9Mih8hHanwkkDOc46uNsdCHAmb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201263; c=relaxed/simple;
	bh=Dy+Krcn+NAwtr8XQ9BK/8dVkIlRxjcHkbLAhfwfIsww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljUjyE0s+2jqrg9aC8bCbpY4LILxmzZEb646rVyBnKYGQHO+XeCh/OCfRzD//RXlhacKnSIgCSFsenW18+6QBw/1wFBAlzcXzTiEoisR5ZtPvA5MD2cjXJsoQoZlGwJKy4DoeuAe02SrWJQYzl5sDSQzkTbKGYNYPb//3J1iIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a6ZAwRub; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3b6b281d4so6017535ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729201254; x=1729806054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ll7dLpi0Jr/OVsosHkE6envnHo0rijYZjtHd0NM6laY=;
        b=a6ZAwRubN6eAEEA1Fq7vhVkJ+ziA3MxXaHEff10FZ5F5qwING0/bc2tcEfRVqsY6qd
         pxZpZWfkoomXTxF/SYFhHYVbXZgMmQOkxHlhGB7wWeKqzKDV04u8g57bFrtFn1s+D0iz
         LzYLSG8jtMHyeMvvsINg9KekBw3MwQx4EnKlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201254; x=1729806054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ll7dLpi0Jr/OVsosHkE6envnHo0rijYZjtHd0NM6laY=;
        b=dFbHFstM+iyx4gzwjFbJKatM4l0HHK9kCrw3rZuaUZzX5XboAY2UjJvFGs8U8Wl0t9
         /0emO8tk1D1xCOMRqMBtsQWlWXQ4wz2ibFSla/vNzPluFxgqUVirWmVveqYF3Ujraoi7
         v7N+IBrknQeuZQnBstnwPyy1P7QSlsm/kJ1AS4dc7UmMH8UEcHMOEATSd9uES70nyKfU
         DdBxkPjL9lJhLXIBzlh9x2CW9KLAqRhk1lqcgLPFmxhLpbJxUDkgGwoiptkb+7oyQDI/
         ZYFLw1gxz2meb2M/8ycnPswZt41GhIHmjDS65ljb4l/lpFfoCVqrZ+omdMK+q97nbM1E
         6KIw==
X-Forwarded-Encrypted: i=1; AJvYcCVPeNoM6UQzSzrw656hpk9HfJO0mdta9KUxCAsy4bPSHAD2xhg30rz/VcQlsXUs4kpjtZuzZY0JoxSoSYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+2OKecJsVWiyi9Z5k1MX/5nVH0KHdU88PgiSwFwrqux9wP6l
	HyGiPiE3WIqWQeNzdJqffVHfRjBdL932EbNlDvahtM+7VuL7vmF3aArMXMi1smI=
X-Google-Smtp-Source: AGHT+IHxewqw4CYVd2Ce6M3WdW++reuVJi6/l1j1eFwpDBwHfKcH7N2Jr8ePShvV8qjHjNbKlKlOyw==
X-Received: by 2002:a92:c56f:0:b0:3a3:b439:5d09 with SMTP id e9e14a558f8ab-3a3f4060aabmr2519305ab.11.1729201253329;
        Thu, 17 Oct 2024 14:40:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3f3fe48edsm439885ab.22.2024.10.17.14.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 14:40:52 -0700 (PDT)
Message-ID: <9837c95a-2366-4733-b26a-9bfd27261f56@linuxfoundation.org>
Date: Thu, 17 Oct 2024 15:40:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 23/23] testing/selftest: add test tool and
 scripts for ovpn module
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
 <20241016-b4-ovpn-v9-23-aabe9d225ad5@openvpn.net>
 <a86855c4-3724-43e8-9bdf-fb53743cd723@linuxfoundation.org>
 <12609df3-4459-4d86-a505-e4f2daccff93@openvpn.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <12609df3-4459-4d86-a505-e4f2daccff93@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 05:27, Antonio Quartulli wrote:
> On 16/10/2024 23:14, Shuah Khan wrote:
>> On 10/15/24 19:03, Antonio Quartulli wrote:
>>> The ovpn-cli tool can be compiled and used as selftest for the ovpn
>>> kernel module.
>>>
>>> It implements the netlink API and can thus be integrated in any
>>> script for more automated testing.
>>>
>>> Along with the tool, 2 scripts are added that perform basic
>>> functionality tests by means of network namespaces.
>>>
>>> The scripts can be performed in sequence by running run.sh
>>>
>>> Cc: shuah@kernel.org
>>> Cc: linux-kselftest@vger.kernel.org
>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>
>> I almost gave my Reviewed-by when I saw the very long argument parsing
>> in the main() - please see comment below under main().
>>
>> Let's simply the logic using getopt() - it is way too long and
>> complex.
> 
> Shuan,
> 
> while looking into this I got the feeling that getopt() may not be the right tool for this parser.
> 
> The ovpn-cli tool doesn't truly excpect "options" with their arguments on the command line, but it rather takes a "command" followed by command-specific arguments/modifiers. More like the 'ip' tool (from iproute2).
> 
> The large if/else block is checking for the specified command.
> Moreover commands are *mutually exclusive*.
> 
> Converting this logic to getopt() seems quite complicated as I'd need to:
> * keep track of the first specified command (which may be in any position)
> * prevent other commands to be thrown on the command line
> * come up with an option for each command-specific argument (and make sure only those required by the specified command are present)
> 

Thank for looking into it. I would like to make a suggestion to
add a parse() routine and move this logic there instead of making
the main() very long. It will be easier to read the code as well.

> Are you sure this is the right path to follow?
> 
> The 'ip' tool also implements something similar after all.
> 

Sometimes argument parsing takes on life as new options get
added. It starts out as a couple if else conditionals and
expands - when I see a long argument parsing code, I like
to pause and ask the question. Sounds like you case is more
complex.

thanks,
-- Shuah

