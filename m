Return-Path: <linux-kernel+bounces-325312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41A39757CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C69B2B164
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A581AD9CB;
	Wed, 11 Sep 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPiAHl/6"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457331AC8A2;
	Wed, 11 Sep 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070182; cv=none; b=MTvFYNEZToj/lt9fUE2VtUC6gWyZMxTKtwQ5+gVUFy1tExN3XiZsIP0tj5PNLpysPCGrCPEUyqxgwaDLwByfkAJ89EdPcUy2feGO+VIeh5nyU03XWamcAq0bm9LWqT3kkAWDpMBdQ00PJf/TQfU06Jdmlt9MacGb546qUDCVS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070182; c=relaxed/simple;
	bh=3RzPUMFytqwEGstKy+pM1kJth/A7eKAmDwDt5MnkrsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpRCdRogzvPDbw9BSHSx3XTThPwL2y9d5KhpNTodl6zAryrjNV8L5MqzuJgF+3RLyhAQyv27FKGzxT8M1cV5gOrMGx+t6JoKc7guY7x838hVGuVXfja+seI/uCMSwBIyo4Fe43VFGz/jstXmZOMLnqgVP3V6rI0M2lSGHLee7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPiAHl/6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so5486157a91.0;
        Wed, 11 Sep 2024 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726070180; x=1726674980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekEGS5LhVrz52kPhdjD1qBU5D/FHKxR2d7m0EFtF8wo=;
        b=NPiAHl/6NRqQlh7axFtTNJWyaSDPZKTSyWgk38VD7vXakEexRqpD63bT5kjYJ8xh0L
         03wxrKO7gq47UcBWWAXttjDECp1rqlp2BJ9K/yD/YfKXjR60tDoAnkGPuOt6hh97x7+U
         NbCndbJUcVu9SiF2HrVYo9LUZwXU06gzFwLuiHle8B/XY7ykwF0aofVys5WzFlzvG7lg
         nxRPrmPWCyha77wXC8pTloM614DPzpJPdcCpul8QqvYgUF5oPZe0DLGy7fqLjEM8UUIT
         NNRzsB8hlilAH57/DgVjDFiXy7kEoohKu3C4IigrbLM/N+dQ57sz0cyOhHUBE/FpODut
         e4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070180; x=1726674980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekEGS5LhVrz52kPhdjD1qBU5D/FHKxR2d7m0EFtF8wo=;
        b=PbqlAR7hHBNqk18DWHLP5PTsfcB79USzdBSPVt3/s9j4P0aPglXf/1/Y17Pw6rwPbP
         60qkTbvlu0IkMPE9lLv1rkec/3AdiVIk9wTjd4kOmF/zckqieru8mgxmHHLYDs4Qc3Jz
         1ORYHN91gPFBIqradBr/GwhY6XbgcxN30QvFe0JlrcCtsWoMVN1KpVfzEemWaHWazpwN
         f2dBKtAtJaKlK4ZHdfZrzBl8X7aIh2/AaWYjxR4NEPNU4HlROSy3CZipIvs3V7OMK26f
         tT/ThpIMj5RcRzyetGDtG+yCtUAM37wbW0yBg2ZYs9KEDRERqdkw73kosymVDl9kCLCu
         W22A==
X-Forwarded-Encrypted: i=1; AJvYcCU9GBAHw6+XxMALScaSIe0gJvmnKENLu8Zq2vehtmFw0gSJvM7HZd0W5ov4HQqnK7NhUcqDuqo3+ItjvhhD@vger.kernel.org, AJvYcCWS6jp1kk+ItZPhD9SoPZ8UbI73RrkpK1UGyrGYSIbOi+Iv6uQyb9McBLp/yW+2Vie/NFgze1JSUG/1zYProxM=@vger.kernel.org, AJvYcCXyEuTwvIIi3csp86CnUWQWuwtQkQpVxTe3U2QYwGLKA/PK1J987vUp5a3XZCtONBhdcKbqG8hu7t/u@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+08MUVzZ1GyaJx/MUI3hkk7YHLdC6/oKZA8cqdPWCzRpzz3r
	nSe7rbnwCJDtbTbuqbuJtdaopElGacjxDy8YIhy746alVfD8s+In
X-Google-Smtp-Source: AGHT+IHnhAO56F3iLPQNKaaUfn3CT/B+2/Stp03j6qiLYfTfQdKSUV5CbkgI8VGevBOXfRC1CJw1Ow==
X-Received: by 2002:a17:90a:a08e:b0:2d8:8a03:b90d with SMTP id 98e67ed59e1d1-2dad512d6f9mr21023583a91.41.1726070180261;
        Wed, 11 Sep 2024 08:56:20 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadb42e6fasm10838752a91.0.2024.09.11.08.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 08:56:19 -0700 (PDT)
Message-ID: <44039255-159a-4284-abd8-a0f558ad006d@gmail.com>
Date: Wed, 11 Sep 2024 21:26:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] addon_boards: mikrobus: Add GPS3 Click
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ayush Singh <ayush@beagleboard.org>
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
 <20240911-mikrobus-dt-v1-8-3ded4dc879e7@beagleboard.org>
 <2024091149-vocalize-composite-6e48@gregkh>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <2024091149-vocalize-composite-6e48@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 20:28, Greg Kroah-Hartman wrote:

> On Wed, Sep 11, 2024 at 07:57:25PM +0530, Ayush Singh wrote:
>> - GPS3 Click is a UART MikroBUS addon Board
>>
>> Link: https://www.mikroe.com/gps-3-click
>>
>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>> ---
>>   addon_boards/mikrobus/Makefile         |  1 +
>>   addon_boards/mikrobus/mikroe-1714.dtso | 28 ++++++++++++++++++++++++++++
> Odd top-level directory for the kernel, are you sure this is correct?
>
> thanks,
>
> greg k-h
>
Well, it is kinda a temporary location, since well, I could not find a 
good place for board overlays but a top-level location seems better than 
putting them in any arch specific location. I am open to moving them to 
a more suitable location if we have one.


Ayush Singh


