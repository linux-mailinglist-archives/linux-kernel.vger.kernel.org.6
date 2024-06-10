Return-Path: <linux-kernel+bounces-207853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E3F901D03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D370E1C203E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DA16F2E1;
	Mon, 10 Jun 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bH7v0VPF"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA73EA86
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008419; cv=none; b=E0Bs2Xjkd8KqmC6paqqUscsmfSMBzwa/ZX2Vgpf7TFVhy3h/DXAVyPEIwC0olm8rfSwhsviIXn/ZKp8ArN+Tv36lQWs03SZzwj5ebeHjv6pLKJw0eTzV1r7oAAP3gyNWedtuxuuGzX9ey6JUhfX2kzDKwJh/iv0NYEyVMvlbxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008419; c=relaxed/simple;
	bh=ZHwsUlCcj4iOpOQwr3HSU7ofvi8oleP/d1WHNbJiINw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/A+SvUzSjTnd5YXbi0b5gA/HhIzojxEoeqX7uSpjpsjLljALNlHGry5t7OPQPmgRWGQw8zPymSJmZaw99zRPvQT5oXZxKTMKlfpOn6iybMCuyY9eZpzOAqIAe/QLnO8wwnugsHykB88Nl/wBagRFkpKMBlKcmDx9usHiWP0cE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bH7v0VPF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c1e33e283so356927e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718008416; x=1718613216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VONwh53+sI/q+7igjZXIEzywb8W5GjMK/wuw98MkWNU=;
        b=bH7v0VPF1mWx8CLMAcyz3Xj3jJkBzrEJMlg0Gllgs2Y+AHb76rRUf172C1xoKsBZu1
         IDGNetQpxkcXdrXnetbkhPtUR7HH069wOHQWCzcJQJjWNBdS/wTx7yatyCFApWEcHYMz
         JVjT+yedvZX14AotNVijs3/O47v6cOr9k3YRTqa2JCR2wpRD+tQc1YtWJA3TvV55PBeN
         44XiYiit8RlvT6KfYezeDFou77BErXOsdaoIwoLPNJf4ea/NR0f1kDJMZyxPTAMp7SXB
         cg1gcCMXuPzkI7CTJppj5gvME37ZamT2RB4rG/tpZC/E1LtcftUC8wJQ60avc+B40VY1
         EWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008416; x=1718613216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VONwh53+sI/q+7igjZXIEzywb8W5GjMK/wuw98MkWNU=;
        b=NRSKEsCmj4cKLZKFjhK16wBG2T80cIL63+ZQwxfd4sdEExSqzLsRZvwi3i+89rOM4h
         2ZQBHRAURkEFTRtLvJapu1yI4DN9qnF9xBnBC5kmui1aLQTrYycnXu+NF4XDNUmV2ntb
         s8NQfsjHT0emPU3Y4hlDL9rch8xda/vA/27Ge9VqPrtSCeEstLKs4259h80wjUkPnE0E
         bzcH52Bq4Im3MsxyEkryFm80dtwMAbzFU4fzmgdW1WJgN0xgGLKpVsjOAMVEHd4J7lAc
         s4im1aohEAmZyLGBDfn/F/DjRNYEWox7YTaen3EW1Eki8ZbDHNNKrgNpujsC2T9DLGwf
         sE7w==
X-Forwarded-Encrypted: i=1; AJvYcCWVxQ0Vykoqlo6sDWLOMYtpMDMCd+t0gyquaF6E/CoPu7LQiU6rJjof9QsO/gJ/SIoe1bMYx+5yNNwrxBvsRpLs8bwv4/zfgbVRF6gF
X-Gm-Message-State: AOJu0YycgqtuLKaCJ9c2Ty03IXGvd1jSJPNOGsCFeFeA9VYyO+tW5ReT
	i5QAlozkMA2aVb4LvPBYRl43H4xqUiEktA9fi5skhZCbSR5abnrgY1mdl7bB9pIjd8bf/j7QlPg
	KPCA=
X-Google-Smtp-Source: AGHT+IFahvD3U+kTggZzk4bIrxGmCLQrUgdTOQl0vpqy33eDYS/aj7HavpfyJtTvywy7ZbtTTbtAcA==
X-Received: by 2002:a19:6b03:0:b0:52b:bd23:1e9 with SMTP id 2adb3069b0e04-52bbd2304e7mr4688601e87.1.1718008415424;
        Mon, 10 Jun 2024 01:33:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:deb:d879:7179:d010? ([2a01:e0a:999:a3a0:deb:d879:7179:d010])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e674sm135087885e9.6.2024.06.10.01.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:33:34 -0700 (PDT)
Message-ID: <c288f739-2a1a-4fd7-884b-12e360a33142@rivosinc.com>
Date: Mon, 10 Jun 2024 10:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
To: Deepak Gupta <debug@rivosinc.com>, Conor Dooley <conor@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Jesse Taube <jesse@rivosinc.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Atish Patra <atishp@rivosinc.com>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
 <b199fde6-c24e-4c18-9c38-fdc923294551@ghiti.fr>
 <20240603-stinking-roster-cfad46696ae5@spud>
 <ZmNWmxak9Rc80Kpb@debug.ba.rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <ZmNWmxak9Rc80Kpb@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/06/2024 20:51, Deepak Gupta wrote:
> On Mon, Jun 03, 2024 at 01:47:40PM +0100, Conor Dooley wrote:
>> On Mon, Jun 03, 2024 at 11:14:49AM +0200, Alexandre Ghiti wrote:
>>> Hi Conor,
>>>
>>> On 31/05/2024 19:31, Conor Dooley wrote:
>>> > On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
>>> > > Dectect the Zkr extension and use it to seed the kernel base
>>> address.
>>> > >
>>> > > Detection of the extension can not be done in the typical
>>> fashion, as
>>> > > this is very early in the boot process. Instead, add a trap handler
>>> > > and run it to see if the extension is present.
>>> > You can't rely on the lack of a trap meaning that Zkr is present
>>> unless
>>> > you know that the platform implements Ssstrict. The CSR with that
>>> number
>>> > could do anything if not Ssstrict compliant, so this approach gets a
>>> > nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
>>> > it, so you're stuck with getting that information from firmware.
>>>
>>>
>>> FYI, this patch is my idea, so I'm the one to blame here :)
>>>
>>>
>>> >
>>> > For DT systems, you can actually parse the DT in the pi, we do it
>>> to get
>>> > the kaslr seed if present, so you can actually check for Zkr. With
>>> ACPI
>>> > I have no idea how you can get that information, I amn't an ACPI-ist.
>>>
>>>
>>> I took a look at how to access ACPI tables this early when
>>> implementing the
>>> Zabha/Zacas patches, but it seems not possible.
>>>
>>> But I'll look into this more, this is not the first time we need the
>>> extensions list very early and since we have no way to detect the
>>> presence
>>> of an extension at runtime, something needs to be done.
>>
>> Aye, having remembered that reading CSR_SEED could have side-effects on a
>> system with non-conforming extensions, it'd be good to see if we can
>> actually do this via detection on ACPI - especially for some other
>> extensions that we may need to turn on very early (I forget which ones we
>> talked about this before for). I didn't arm64 do anything with ACPI in
>> the
>> pi code, is the code arch/x86/boot/compressed run at an equivilent-ish
>> point
>> in boot?
> 
> cc: +Clement and Atish
> 
> I don't know all the details but on first glance it seems like instead
> of ACPI,
> may be FWFT is a better place for discovery ?
> https://lists.riscv.org/g/tech-prs/topic/patch_v12_add_firmware/106479571

IMHO, doing discovery in FWFT is not the goal of this extension. I think
the "real" solution would be to wait for the unified discovery task
group to come up with something for that (which is their goal I think) [1]

Clément,

Link: https://github.com/riscv/configuration-structure [1]

> 
> Supervisor could query if Sstrict is implemented and then it can check for
> lack of trap on CSR_SEED or straight-away check for presence of Zkr.
> 
> 

