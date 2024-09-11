Return-Path: <linux-kernel+bounces-325333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBC9757F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D9DB2321C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC01AB6EC;
	Wed, 11 Sep 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="hx3SbFYp"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4B1AB525
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071005; cv=none; b=p0gB3LS5HxoVR+zw209s+yH+RKCa0lhrdbJ//U78zvsSvCUTPi0+Ael5Zq0AJeaeIxdXDR7urFgCN/Sb7MmJIQj39rXz+8LfFaNTxrqbUgZSEDcHmZknmUjC8SU/vuI6fJh8YM1fAsHpkoT4ABcbj2kkjCK9PBkzQvMg+Hgladc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071005; c=relaxed/simple;
	bh=EyC1asarizN+wlHGUbEl5egryrMctUQ9CjTYigbQumg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3zZ4oF/0/S+PhcAOIJePTfzt4/1pXTMk/nVjh3Bw9zwG3eFXCL9Leg6gkQFP1/lbjcCSFvGJYaXWcq7dnK6DbdZKsAn9kdWhtfh4SNd0+W3xHm7znK35dsSoLHNiYYbI3L0+kWWK8gpZaDUVsh9S5n919SPrbiIDZDdU1CqPj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=hx3SbFYp; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20551eeba95so284765ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726071003; x=1726675803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7UT67gV1cwJybIxBArzSTyhlTWk6LFWkBtDrmyARac=;
        b=hx3SbFYpKbxVhdF7hZdOkiAzeCAYdMtfQheuJ/LRRFWCQUa+9mTAVrp7tH+rnCGt0k
         dsqnuhVwotmn+YP7sayfa7aJ7RBFV0RuaT9cuGh+8WKMbCQ+n4+eGg7xVBbcwjvjuHin
         5FIA5nLt2xK+Ft5OQ9p+mjYWmeqOtCDw6EI+rZFrKvbVMLrhWwrryQAeUi3jpU0qq//q
         HN/UYaTw0iiB2cvw6baNv7Ic7Pl1sMrvJ7RQpdUwotjdWjZkuWDEeHj8BpoHyXi+c/Gl
         qPQrRFC7N8GjAJvGAdyJC820dEjakrIZwj3qSwHo1eFBOE6HuXv2hDjZZM4J9eYV4mlq
         /XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726071003; x=1726675803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7UT67gV1cwJybIxBArzSTyhlTWk6LFWkBtDrmyARac=;
        b=BDG3Ce9pm+PkaH74s8y3Rlo1XvVrAa1siOM4mVKpls75Y9YTOS8HM3e2xAMMQ6NRk2
         KV/BgALVOf0CHk5nP4WMz9GfWqS8LdIRYDVeEciP13v1bO42fgLLGGt1gAphY3PE9dWC
         GUBoTwi9oTbNHFpy8jPhWsHHfRBnPoXLcATHCNfSbHR8fZ0iHf85R3mXDpXN3swO7uM+
         pD0iJBo3Ubff2r5+j6tM2IbrKUtdwlNlvbmKY8qJAUcijN5OU5gtPFL2Y1WRhjK0sfK1
         CAARZlrymoJ01j4LDBirlZu6E8jMVUoNg/I2ubbs9Xk7LNvUX7KEpMuw1pixcLN8aYI/
         CQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxXJumXayeE+vc8JT98tFWsX3u5HiXNuAi2psAFB8pngAgx+NOC4/81n0m1uUAoKYUg+dX7AqpMxyzUxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nAHQz4OL4ZYWo7s4Xw/dt1Gb6/XY3/JK/61tzxkHnzzDV/Yg
	V5hhmJq5uryYFBasHxiHH9CnascX7moGSRhtexV4JIVo1Skp24LtC5kAPKudEw==
X-Google-Smtp-Source: AGHT+IHxqgzZVxYEvY9qL7CLZSUAdKuf7UAGYqozKhceMgYQsh8xQE8qJwCqlU3Otnp7XWn00TTRiw==
X-Received: by 2002:a17:902:e546:b0:1fb:90e1:c8c5 with SMTP id d9443c01a7336-2074c643e20mr54026305ad.33.1726071003325;
        Wed, 11 Sep 2024 09:10:03 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076ae3fe19sm1602505ad.0.2024.09.11.09.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:10:03 -0700 (PDT)
Message-ID: <ef948bc7-aa2b-4b45-8e6f-32c28b7d6684@beagleboard.org>
Date: Wed, 11 Sep 2024 21:39:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] addon_boards: Add addon_boards plumbing
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
 jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-6-3ded4dc879e7@beagleboard.org>
 <2024091147-graveness-manmade-d070@gregkh>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <2024091147-graveness-manmade-d070@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 20:30, Greg Kroah-Hartman wrote:

> On Wed, Sep 11, 2024 at 07:57:23PM +0530, Ayush Singh wrote:
>> A directory to store and build addon_board overlays like mikroBUS,
>> Groove, etc. The overlays present here should be completely independent
>> of the underlying connector.
>>
>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>> ---
>>   Kbuild                         |  1 +
>>   Kconfig                        |  2 ++
>>   MAINTAINERS                    |  1 +
>>   addon_boards/Kconfig           | 16 ++++++++++++++++
>>   addon_boards/Makefile          |  3 +++
>>   addon_boards/mikrobus/Makefile |  1 +
>>   6 files changed, 24 insertions(+)
> Ah, here's where you add this.
>
> It should be below drivers/ right?  But what's wrong with drivers/soc/?
> Why is this so special?  Why not just under
> drivers/microbus/addon_boards/ ?  Why is this tiny bus/device so
> different from everything else out there?
>
> thanks,
>
> greg k-h


Well, it can go under drivers for mikrobus, but there will be other 
addon board connectors which will not need any kind of driver. In fact, 
the original patch series this is based on [0] did not have any driver 
for the connector.


As for bus, see my reply to the other patch in the series [1]. 
Basically, while the name of the standard itself is "mikroBUS", it is 
not really a "bus" in Linux sense.


[0]: 
https://lore.kernel.org/linux-arm-kernel/20240702164403.29067-1-afd@ti.com/

[1]: 
https://lore.kernel.org/all/ecd1fff8-9c15-496a-982f-36e6c58e906a@gmail.com/


