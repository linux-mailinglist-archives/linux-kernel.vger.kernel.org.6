Return-Path: <linux-kernel+bounces-288384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2C995397C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B2E2871B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E1348CDD;
	Thu, 15 Aug 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Kjf7pLkJ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278F842052
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744317; cv=none; b=jqJv9jN1I7bYQ+IjL3DkKI1kJ/ar3RMIGTqYYQxKxvhXpAbOPHeMnEyJB4mmPqdRmVPktNQegiSInQkx8l5uc3dlDfjgOVHW891d+C3a1SbFvdUBukRuP7BF6zdt2OSolwTDPGsC7SoM8B45eYs3icUU+SIP4oq1+k9C4N55agw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744317; c=relaxed/simple;
	bh=RRl8xEuGAke9nwsm1o9BTudRbL+q9SiEi23nNOxHjaA=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=e7XBbpTpjjRWVqa93soqcICfU0qeX0lU+kMKK2lGE99hQHac+LymqPljKWvqXUv4h1kL1qV1/Q3DDrMwCuFeyvdrLGQQ5+SLrvQd2AB7JCaAuz6meyvq9SEqY/PGPiKqeClQyw8Liujp/nZqfjInRWbtXpORugXOnmlFI72Ptq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Kjf7pLkJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1d6369acso1489283b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1723744314; x=1724349114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRJah67TbxjThycfUyfvCHfdY4HH94LjxhqJhibVK8U=;
        b=Kjf7pLkJYd3Jxl0roco4YeQ5m7zRbCb+CT3/ql4Hss50+ljxKymBl8mVNlCKRP/ZtE
         BIUqnHf7Y1EYcu2wl4rCGiYX/EZGW9augqtJCDqyzaqRhNHTmNk3LcS4Fo7QaOZBmG7O
         k6QrICsPriEZp47lxC6yQtNxjxrUiQ0uAr1JiP3P7eFRLAvoOMTfkZboRiIOYI+js8R0
         NgOjrl2SgJZVN3FEL4jxJoeT6105xf9aYkFsJQTljv1IwAWcni6ONWjwvKM0DG3Yn6bw
         uXaEf1pPQOnOJYlaF+FmsGUUJmeQY8VFt2pqKzydmuXXOObR0N5qoPVD8COJQzc8Tt7f
         LzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723744314; x=1724349114;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRJah67TbxjThycfUyfvCHfdY4HH94LjxhqJhibVK8U=;
        b=gTaD0VLsyfluavB1gPb1ySJblTNUsWNBWBIVpHkawBNMthkVNvQK6qCrmT5V0fUV6i
         8Bsj8ipYCYSHjwsoBNEcAdyozfHIR1pkMDLMuq1atjdPyJ4hQ1Ecdp8rUGfgRQ9lx5bF
         NQ+pK5jn02S8NXls+4koQgYZumEtjtm5gehI/piQ9KMZkMrSrDkL7FWIuo32b217Jt2/
         G+BwU3ohvbr3RZFpEdx5R+Wz4hllaNSGnhBBdoNPdPLLirnK8e8Qm4DTMQJ2wZv6u4Ap
         C7CRL5GYMlEvOFTizijBaj7B2f97JUqgG9XC/dDtuhi3WYw/3RHcYg+pjmay3yDrcQme
         b4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbvWEBk6UOb3Bvkh5T2NPdSwgcXApVJWEObDZertwrxyXECDNsFB69B5hwYhUluj+6R/XGWPQTq1L4VmoI8A+VnbZBiRfKphjXASYg
X-Gm-Message-State: AOJu0YxyUXqiOMUavTRLJm1yCSXmHcHM3TTA9zRZT6bschutLsJvpRZE
	dNDe//gfBjeylZNFtwFWLWFDYFeyFhiAOQ2giHu5Hk+a3FxDF8Vsvzgw7vzsLqTWVC8Gz1LlLqC
	P
X-Google-Smtp-Source: AGHT+IEsMGhrczyluFT0sZ5+rH/TAc2rZWVoaPptj0S3ZaI57W71deYHr3CXbzQHzJZZ4EI0XV1yEg==
X-Received: by 2002:a17:902:e807:b0:1f9:e2c0:d962 with SMTP id d9443c01a7336-201ee519f73mr48179245ad.31.1723744314111;
        Thu, 15 Aug 2024 10:51:54 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0302e65sm12779255ad.60.2024.08.15.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:51:53 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:51:53 -0700 (PDT)
X-Google-Original-Date: Thu, 15 Aug 2024 10:51:47 PDT (-0700)
Subject:     Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
In-Reply-To: <085c8332-d7f1-41df-8854-bee06291ba83@sifive.com>
CC: Renner Berthing <emil.renner.berthing@canonical.com>, apatel@ventanamicro.com,
  tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: samuel.holland@sifive.com
Message-ID: <mhng-91e79885-7652-42a4-aad0-f4713e7ac70d@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 08:59:37 PDT (-0700), samuel.holland@sifive.com wrote:
> Hi Emil,
>
> On 2024-08-15 10:07 AM, Emil Renner Berthing wrote:
>> Samuel Holland wrote:
>>> On 2024-08-15 9:16 AM, Anup Patel wrote:
>>>> On Thu, Aug 15, 2024 at 7:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>>>
>>>>> On Thu, Aug 15 2024 at 08:32, Samuel Holland wrote:
>>>>>> On 2024-08-15 8:16 AM, Thomas Gleixner wrote:
>>>>>>> Yes. So the riscv timer is not working on this thing or it stops
>>>>>>> somehow.
>>>>>>
>>>>>> That's correct. With the (firmware) devicetree that Emil is using, the OpenSBI
>>>>>> firmware does not have a timer device, so it does not expose the (optional[1])
>>>>>> SBI time extension, and sbi_set_timer() does nothing.
>>>>>
>>>>> Sigh. Does RISCV really have to repeat all mistakes which have been made
>>>>> by x86, ARM and others before? It's known for decades that the kernel
>>>>> relies on a working timer...

It's even worse than that: RISC-V doesn't even mandate any working 
_instructions_, much less anything in the platform/firmware.

>>>> My apologies for the delay in finding a fix for this issue.
>>>>
>>>> Almost all RISC-V platforms (except this one) have SBI Timer always
>>>> available and Linux uses a better timer or Sstc extension whenever
>>>> it is available.
>>>
>>> So this is the immediate solution: add the CLINT to the firmware devicetree so
>>> that the SBI time extension works, and Linux will boot without any code changes,
>>> albeit with a higher-overhead clockevent device.
>>
>> But this will mean that you can't update your kernel to v6.9 or newer without
>> reflashing OpenSBI and u-boot. That's still a regression right?

Ya, I'd call that a regression.  Updating the firmware on these things 
isn't generally something we can rely on users to do, we've worked 
around other firmware bugs where we can to avoid forced updates.

> I suppose that depends on if you think the SBI time extension is (or should have
> been) mandatory for platforms without Sstc. If the SBI time extension is
> mandatory, then this is a firmware bug, and not really Linux's responsibility to
> work around.
>
> If the SBI time extension is not mandatory, then Linux needs to be able to
> handle platforms where the S-mode visible timer is attached to an external
> interrupt controller (PLIC or APLIC), so the irqchip driver needs to be loaded
> before time_init() (timer_probe()). So in that case, the bug is a Linux
> regression, and we would need to revert the platform driver conversion.

It doesn't really matter what the specs say (aka intended to say in 
RISC-V land): if there's a regression then we have to deal with it.  
It's not like whatever's written in the specs actually matters, vendors 
can just do whatever they want, so wer'e just stuck making the known 
implementations work.

So I think if the revert is the best fix then we should revert it.

That said: If the CLINT works, could we just add a probing quirk to make 
it appear on these systems even when it's not in the DT?  I'm thinking 
something like adding a compatibly string to the CLINT driver for the 
SOC (or core or whatever, just something that's already there).  We'd 
probably need a bit of special-case probing code, but shouldn't be so 
bad.  We've got some other compatibility-oriented DT quirks floating 
around.

> Regards,
> Samuel

