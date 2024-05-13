Return-Path: <linux-kernel+bounces-177770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809288C446E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38E91C2131B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB99B153BEE;
	Mon, 13 May 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdKjShYl"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673C1474CA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614817; cv=none; b=mNXzeP3SjWkIbwwP9VeNxbAIWN5vAZsNEpXNnoo8XJiMekKzXe/6QTzwL9DrP7SMk7gtst1vpPzM8uZiTjxCVE25ACoPf27rBF4MNAe5NKaGZZ5ufm8NW2V6UGPXVQqhk6EKhiOFJ7b1j0ltqgMdlpSMSs0kOjHyX7e6XYbTtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614817; c=relaxed/simple;
	bh=ZVfGhatBHB5E6pdRmFLQv8AAH+1Knsd5Bw0igbzS4Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOnsdlFvWuQogHjPfD7wC3Dh21THH1zuhA0Ke1R2AGSsaWbf/xZDYQVdZizkp2CwO32qB72U3QYQBnZHqlCb5sgcXEU7n3d6KH/Rp3v+OHENruzOePvqtTujouXRLqX9Ukkky7XIM1UuM6rleWLUUDvo5hNZ/0XYGt4/1QtjSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdKjShYl; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c7513a991cso2936325b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715614815; x=1716219615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GKvjJHkBvG+46DbBchBKPhsrLJF1rV6VbHK0cP+QrA8=;
        b=XdKjShYlTWXMHtWSzB1HFAjFoZgRULy3FqHqk2BpKK2ZVHtozGM1zfYS1l9t92YJmr
         7A5YbI8qAX/s56mwhPbTdlgLougCGhUa+G6rjLShZjnnbHIQ5KCM9Q4cC+PcGQSgosrP
         k4N6NOMmsU72Ff1aOnMsdIwDhVqIVwWXeaJmS9P4Yn0FUd5UhvGzlf7muJvI59EV8m9r
         pBWoOeJIBunyUqXM99FwXoIaVkyGa/A48zUtFuwtDYtMWx+q/GoSX5K852axpBEgdgyy
         hMop+NPRK4wvuZAVmxi+Qbvh+KRETVMI2ZJmrzi3JQTbTkK4H+T2JygrT1PfkPNKJn5M
         7Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614815; x=1716219615;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKvjJHkBvG+46DbBchBKPhsrLJF1rV6VbHK0cP+QrA8=;
        b=w/GbUx6VgwMyz1SE4qMhL2r5h1XC9iJ6K9dTl4jA/y51TDLY2VjB/AWXMiq3gk9F5I
         zKQand6NfsagF0TY9Dny2KYgKLSBYHMX0jP1z75QZiyKmpo4RGyzEjHkSfJIaVP8mzye
         PQykCT0Tmiprv1TVKqfeIFzDtcpocBGonFVDhPOXXknCgl6LOvGcLO6d1kBljUj3aVuZ
         RecUpmb+BdMuH7aygIwQ7eZxkzzkuqq0AF7l/HjvN+ZSnGN37GBik9hV+/m/vWH/Snzv
         JdERFVDLFHt7Q3SOiXCmVMQjpdzwqNSi5U7AdQtLxEFkemB9nlpuGZGU/Zty6+Db5x69
         qkMw==
X-Forwarded-Encrypted: i=1; AJvYcCXhJH0whiygXXhlXVSLo4wX7C4Kcd7kf2MI3IklzHhbj3G1BklBqM5pv0GohyXVV2IXAqKZQsSPHxbyf1nEnM9qvi+UykvsF77JAX2D
X-Gm-Message-State: AOJu0YzSYkIIEpUlOWxxBZ2h7kuJ4PfG6vueAxvZjwjYIR6GDJZ1XdVg
	3euV/XvHi7ZJT0t6l5iuc3SemY2hHzxQrx3+VTcQvmIwKT/yRrf3XU28+1l9
X-Google-Smtp-Source: AGHT+IGATG6TXaPmFiFaUJs8LQq76EEQZVlnYAt8nuGLP79XSKwkZwLLNl/7iJ/N27z22ceUWb0Jxg==
X-Received: by 2002:a05:6808:5d4:b0:3c9:92d8:3f8b with SMTP id 5614622812f47-3c997039592mr10438685b6e.11.1715614814643;
        Mon, 13 May 2024 08:40:14 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f18656esm44228526d6.53.2024.05.13.08.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:40:13 -0700 (PDT)
Message-ID: <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com>
Date: Mon, 13 May 2024 08:40:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Stephen Langstaff <stephenlangstaff1@gmail.com>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org,
 "OlteanV@gmail.com" <OlteanV@gmail.com>
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
 <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com>
 <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/13/2024 8:36 AM, Stephen Langstaff wrote:
> dsa_loop_bdinfo.ko is not created as a module.

The Makefile has this:

obj-$(CONFIG_FIXED_PHY)         += dsa_loop_bdinfo.o

so it follows the value of CONFIG_FIXED_PHY, what is this configuration 
symbol is to in your kernel configuration?

> 
> On Mon, May 13, 2024 at 4:34 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Hello,
>>
>> On 5/13/2024 8:33 AM, Stephen Langstaff wrote:
>>> [Corrected emails for f.fainelli and olteanv]
>>
>> What is the build problem?
>> --
>> Florian

-- 
Florian

