Return-Path: <linux-kernel+bounces-325457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28569759E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EA71F24939
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E21B3734;
	Wed, 11 Sep 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="FhIx/nO1"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855F2CCAA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077956; cv=none; b=YjeR7E43CJ5UwGFTpbM0oHclBDI5nhYyPtTVtdfQx2NC61lU81pXLfrsW1TCPhS7cyC3IeBU6sNJ8YKnKOafn0RPrCab/ZeuSWUS1deQyZ4NzmiFeKNTww1tl9y7Y9wanRleUx9CRkUlBLSh/fNrQOTn1WPMEvy27lF5Z2Y8wMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077956; c=relaxed/simple;
	bh=78931USUkSOlqGnmgmQGJYTIhjGkoMBJ0hWB/dF0QEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uz02b0I2zLoXvStJEwrC1zSGdnHqZKWWgVuOExiGcS3ZDtwFY55OQM/Z3cua3KP8Zk5/2PzvYdswZ8JsW7vy0ZEguTkxlvtPH7hPv4tc8qwzYXe/YLi+z68yeq50CJ4K7oT8QyGhJrfGfV8gFeBC4HlItCep0N3rphEA1x0kT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=FhIx/nO1; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7d50532d335so100031a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726077954; x=1726682754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPdsxUdu3ZLqIS+/4uXoHqqeUOuJq80zG19Uh2siaVM=;
        b=FhIx/nO1qbChPP4IiBJ8eNHfmB7nKkmkA6UYhGFgb3RRLdMC8rLK+h10qjZcGuHScI
         d6S51d4APmlVquIUPl4EXrk2EjnxFkmPogyjZ22iDAsxHgSNVGGNmALpZOZQN/MFqucL
         bBifN7FP8KY0MnOZSw+pMqsbFQOep66IxPFYDZNPcB1PDqz8n2Kdn7I8EfxHWUidC5rI
         mZiRMJfcVF4SiM7f4RS/CgwA+TJZsVRtjOjIV5neEg9qAvfQBaVziJqmklYczkfQr8ZY
         pxgqcjSYJsWUKmSDMDlSRE9EOt/lGyH+InItmkBsf+eQhab4lkGNOCrAfAyZ45M62SeG
         Z9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726077954; x=1726682754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPdsxUdu3ZLqIS+/4uXoHqqeUOuJq80zG19Uh2siaVM=;
        b=P4yFzA0TD9W0FE8BlaOicA3N2wpH3mZgZsrvwty0HpB1OPHTQchOwQARXQhaOm28iA
         5ErXZMkTfNOv0aqLGumuiwgvfgoLAMzqh+zTN1GVYwj9ub+Kgc0FfFyqyfR1DuoupVgS
         5OsQswCsNsqE0h7O5Ab374zDfPhHJJbG10hMlty26xvg7pCrhEbF061IKB8pTfcTwWly
         CD99XNDPCP7YmPIwBl8znYslaYjpBp8jha3+UMyNbwPpYO5BSVpHvmzWF4utUZ/9OeAc
         y8ebtPozeFhkY5jyNw5+L+ZIZX3AstrflYsw0AvEWcRwLioTilGQIWdmYTC6aJ5/Itzr
         Schg==
X-Forwarded-Encrypted: i=1; AJvYcCX6A3Ez8PYeCW2YqhrBkn41RZAgovvPwbm0MKTZDJreqmTo6UWMgBA+axeKEg+4s/UAgT3lEu1kAgcOvNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuEgWYXpkujYjBABkThq+DLs8FDyGqR/v1NVpG5ToWrN6/s3J
	i4GYIdcXpTNe63SJrLPjQ7i3P/YRnrkARPI41cLQ7a7Gsmm4slWB+TAkOS8sgA==
X-Google-Smtp-Source: AGHT+IHJfl0jqiL9U3myZiASEiYJyc6sHjUAZZiTehS6OzcD8jJ66gAgSfHPxeYKVEGFaegklSLYhQ==
X-Received: by 2002:a05:6a21:3982:b0:1cf:2438:c9e3 with SMTP id adf61e73a8af0-1cf75ec5c7cmr151962637.16.1726077954392;
        Wed, 11 Sep 2024 11:05:54 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090c37efsm3247602b3a.187.2024.09.11.11.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:05:54 -0700 (PDT)
Message-ID: <ba9a5ae8-c5af-4045-9e22-28363dc94d42@beagleboard.org>
Date: Wed, 11 Sep 2024 23:35:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] rust: kernel: Add Platform device and driver
 abstractions
Content-Language: en-US
To: Danilo Krummrich <dakr@kernel.org>, Ayush Singh <ayushdevel1325@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
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
 <20240911-mikrobus-dt-v1-1-3ded4dc879e7@beagleboard.org>
 <2024091106-scouring-smitten-e740@gregkh>
 <bd542178-af1c-439d-bde4-9865cf6c853c@gmail.com>
 <16d70285-cbec-4378-98eb-b522a0efbbe6@kernel.org>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <16d70285-cbec-4378-98eb-b522a0efbbe6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 23:09, Danilo Krummrich wrote:

> On 9/11/24 5:52 PM, Ayush Singh wrote:
>> Sure, can you provide me a link to patches or maybe the branch 
>> containing that work? I also think it would be good to have the link 
>> in Zulip discussion for Platform Device and Driver.
>
> Sure, please see [1]. But please be aware that I plan to rework some 
> parts
> before sending out the next version.
>
> [1] https://github.com/Rust-for-Linux/linux/tree/staging/rust-device


Maybe the branch is just out of date? It still contains the generic 
structures for IdArray, IdTable and RawDeviceId.

Has something changed since the discussion here [0]?


[0]: 
https://lore.kernel.org/rust-for-linux/2024062031-untracked-opt-3ff1@gregkh/


Ayush Singh


