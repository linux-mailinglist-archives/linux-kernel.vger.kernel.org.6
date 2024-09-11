Return-Path: <linux-kernel+bounces-325305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8389757B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966B7B2A8D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221F1B1429;
	Wed, 11 Sep 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7Qj8nik"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87481B1402;
	Wed, 11 Sep 2024 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069938; cv=none; b=UbsnmWy+WU5YXFb2m/xNQndW56mKPT4/fkswJO+TXiXbZ5xXjjtAR9acBUqpaomHA0ZWWXo7xFrBn8BpZKBXSkx11IJmuOQ21TuOdObbvwek63zkCk/zRX36eOBNskC4We9XvM3/eaMAo1Ek7Bl+JZ/hqgun/M1qz3mwgCUteIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069938; c=relaxed/simple;
	bh=3Ud0mb7Fg1HcvD+rEM78PvP4bHo6eppubmq0ZnrppIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vbge+EllCcpdr177qg/TIWEPR/g6IG+xKVIF7StHf25f5C6CakD6R6jr2ur6WLW3nVVoKB5i8zMGt+qxYCeqRY/lVityPIR6EQYfg2lxD78ja9PBdTtb/DFsZV1u4YEfDBJnvYYa+W8RppiQlcejsiSqYZ9zTnoxvD1rhcEddKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7Qj8nik; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c1324be8easo787913a12.1;
        Wed, 11 Sep 2024 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726069936; x=1726674736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhFBnUxhXfUiwp2BIfSInO3F3yOJroJO17IaiZ1i4bw=;
        b=k7Qj8nik1FHzciJZj1gDIHSJfGVRrwZMglTBsfCq1FIPqogWfz1aA6YdjCsd3HEiPb
         q5nRjflYYfoY2LzuLDJX0f9dNroBwnl8X59Nwn8WgcQ7qOV3RjM1O1ZAI7T0N+CTGtz1
         l+QopIPAPqr7VY2diaVi1NEMJNhjw6zel/6dUoA6azndATATqQ7raPHHOcG1BLsKiFt4
         jHWdJygEIlvvJmvmdtuF0pSNgbngguOJvlvjOTXa30CLf722KJJ0ibdHgFCFqWo6Ml8G
         GR3jXJGIoOWCrqDwV5QrNWA/SpBS0a3WUANgDMgu1MQbwBKMOXDKRhdKbN6wrLq6L0Ru
         Qe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726069936; x=1726674736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhFBnUxhXfUiwp2BIfSInO3F3yOJroJO17IaiZ1i4bw=;
        b=wwn6rgwW5Dgx4q7xCImtJ21sOGpfmZmgc1sxa3pUIjV+Fo/3919fTAtFmpFolSxXdr
         IBgR72+4Vo1Jm4mj48FQ5RpYs8aoLJf4wMf6nua5IG0uv53b1aZJXWf/O/eRQ0PmJdz5
         uVOvdYZ4kOVd1JDUiNtS4Jhu38QjcQUXijiEJDz+8dUTaap0ARTcR4YENUfUTvKsS5eg
         bGG7OpWxmG6Gs1MQrizEnaNC2trWDKan+MWpEepeTJtBuH9bPk0Z9Rbt35v860qnk9x4
         jJ8v+f/c8JpdE5Altm8AWUisZQQra+DkJCPLtf3fuWJcOSCg09ewPyZbCHayAiQA+F5q
         HAQA==
X-Forwarded-Encrypted: i=1; AJvYcCUh0BVjDTDD3Lo3f+lMF8ezZJH2PcHkxzKyDtzUa+HGXA0NmGXDQxVWx0xbpnsQFybcBieTSAd1g71rdc6j@vger.kernel.org, AJvYcCWhqBDiP1CMnoJDTB/s3YcT2LXyoNp4Xl7vDghHA+i4KAFniDbl3fkBc3PcFcZ26MsCGdXb5pwuoYFy4mDHz2M=@vger.kernel.org, AJvYcCXV5cB8En+C0BmSHty3VeboPO0MVNsKXPOueNFitPI0q41FwKH4UQMlXULwQ/jF5aCJnKtp64sha+2s@vger.kernel.org
X-Gm-Message-State: AOJu0YzDookNI5kEdaXmi2avzlTA1iLR/H1i5JsiOxCjINm7DuJrxzJP
	KrNBqPvlVteDl5LsFkxR2Xw/ip71IdRYXT727JbeUbxcNzZbwQed
X-Google-Smtp-Source: AGHT+IGOs+PCUn2enJi/POGctcONbWacbrDES/fFDJJ5CFqIcJeEOmHs8RNjPCcMjrve1Sv401LJXA==
X-Received: by 2002:a05:6a20:8424:b0:1cf:4a7e:117b with SMTP id adf61e73a8af0-1cf5e1b9c2amr7477090637.20.1726069935654;
        Wed, 11 Sep 2024 08:52:15 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fdee1f0sm131274a12.77.2024.09.11.08.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 08:52:14 -0700 (PDT)
Message-ID: <bd542178-af1c-439d-bde4-9865cf6c853c@gmail.com>
Date: Wed, 11 Sep 2024 21:22:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] rust: kernel: Add Platform device and driver
 abstractions
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
 <20240911-mikrobus-dt-v1-1-3ded4dc879e7@beagleboard.org>
 <2024091106-scouring-smitten-e740@gregkh>
Content-Language: en-US
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <2024091106-scouring-smitten-e740@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/11/24 20:26, Greg Kroah-Hartman wrote:
> On Wed, Sep 11, 2024 at 07:57:18PM +0530, Ayush Singh wrote:
>> +/// An identifier for Platform devices.
>> +///
>> +/// Represents the kernel's [`struct of_device_id`]. This is used to find an appropriate
>> +/// Platform driver.
>> +///
>> +/// [`struct of_device_id`]: srctree/include/linux/mod_devicetable.h
>> +pub struct DeviceId(&'static CStr);
>> +
>> +impl DeviceId {
> <snip>
>
> I appreciate posting this, but this really should go on top of the
> device driver work Danilo Krummrich has been doing.  He and I spent a
> lot of time working through this this past weekend (well, him talking
> and explaining, and me asking too many stupid questions...)
>
> I think what he has will make the platform driver/device work simpler
> here, and I'll be glad to take it based on that, this "independent" code
> that doesn't interact with that isn't the best idea overall.
>
> It also will properly handle the "Driver" interaction as well, which we
> need to get right, not a one-off like this for a platform driver.
> Hopefully that will not cause much, if any, changes for your use of this
> in your driver, but let's see.
>
> thanks,
>
> greg k-h
>
Sure, can you provide me a link to patches or maybe the branch 
containing that work? I also think it would be good to have the link in 
Zulip discussion for Platform Device and Driver.


Ayush Singh


