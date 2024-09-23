Return-Path: <linux-kernel+bounces-335980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65E97ED71
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929F21F21C20
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253D13D51B;
	Mon, 23 Sep 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuVdc0JG"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D16A7E0FF
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103302; cv=none; b=ftZfjNarb9gjTCBPl+K+6m/V4Kj50aVbWSFJzhUrTv+3UZ+Jt9gs9Z08xzyRQNH2IabDg3vLsSVNNppwUJ4JjgQ8kTP1o/ESMGfqYsWfvVyXRcCZBty8+dL1NIEhD5V/M1CYSWML8sAQTYLWaG+/B3cjMtrjXqTK28V1ZeNjvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103302; c=relaxed/simple;
	bh=XKeuQDRlroaTrolQVJlSNOoK9e4PS0GEXWkcQRn+2qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxKLrZJzDZ6k0fFvI9LrGEOrqjIq0GqAWj2yyZjbJEm1jCaok+8wYvi2eAB2qfHZxz7ChKcsjUHCpCXqK9OxWd2FjDA7aCNBPQbPTd8kHwx64qDBTSfNWPBa2B63csDGYLbCSKIXzaX6k+Jow7p5Imrv/3jYE2xikXXAXLcLtDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuVdc0JG; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2705408a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727103301; x=1727708101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wxnXbR4cT2MVr58RQM17wq1+KzSw4bvuUxFwW4eph5U=;
        b=MuVdc0JGH3DQUCNE/g+63y0NuKKzw89WY/KQJlzFOO2m6vY+M97r/WQsDtc83yW6f9
         q/11shZ5Wq3uSsRgtthywcW7OELbZFpHU6YWrC2JchQ/eM4QRhEpAldV0qZL4DhkFHQ8
         UkaDMwzXhW8sdPcBPptEc7SPc+9nLaidenqJSlJD5i8Opol+RFCQ5eKFP1cLF6/sd0la
         7IFpjIokaa05yFLL+G0YQ6c4oa8mwOuimmXjDWdJiu3W5eafzIRt7KHwNGP/ngPGCC0H
         Jw/EfD1cC3LYRqD+Bg1/rTebqd/Q1v/ibSgLrAkOW8f7deEPaA4GicOaKYRL4ArgMYl8
         KZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727103301; x=1727708101;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxnXbR4cT2MVr58RQM17wq1+KzSw4bvuUxFwW4eph5U=;
        b=Yhie21Pa3vSeadLX/AbV94zI8MZDPcvSoVZaDufOd5g3d1EiRkgOcjTmmF/V8DV6FF
         GzOrVGZs/bg3USRxa2xtwzCH6SsFYSpSMtPBb4WHF2DFDMP/IqhE12pbBsXYI0dVIJND
         KGD6egcmvROGVI29o4boo6/t1mHp4J/74Ri9keNfcRbu5C8+URhO51n8DjZvwOX7fhpi
         DVIztzoMqjkiuFOd5RmqVoQUVZebFwVIX0PlXsqS9qsdGkaanzbSiW1AbyFl7exdeYfa
         UGUTKLJ9mlP9DcpspsJV7A8KCqEs6EFMUjtBtP9qtE+nE68MfOmuGHfbMruL2eshUSWJ
         pE/w==
X-Forwarded-Encrypted: i=1; AJvYcCW1rHLW2mKE1+7dmxnTcxJ5QFg6lw60zNKyI70uhBudTUy26S5xWEN7T+xOUNs2CrbyRs0eE+uxlRm+O3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1KuZ9g02s4uqe1tgQgDisZloZID3PAd7KyHfNbYwbMwNIeZ7
	NgTnY3B7QU0022aO/crqopGjKuyAOHprH6CiwfqC5LuzQcgYdYS9zOiPEw==
X-Google-Smtp-Source: AGHT+IFMaO1gc1hgLL8SroCmg4ai8SlS+2oig9HP9T5uXQ1kbeJQc5VfsNINv5VPtUqVMFtpai/dNA==
X-Received: by 2002:a05:6a21:398a:b0:1d3:294e:6c86 with SMTP id adf61e73a8af0-1d3294e6ca5mr6056347637.31.1727103300737;
        Mon, 23 Sep 2024 07:55:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab50d6sm13971165b3a.75.2024.09.23.07.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 07:54:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2ece7321-f6e8-4d4b-8092-8ff7d3dc760f@roeck-us.net>
Date: Mon, 23 Sep 2024 07:54:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Huang Ying <ying.huang@intel.com>
References: <20240922225041.603186-1-linux@roeck-us.net>
 <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
 <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
 <CAMuHMdVZWWj8aLvRfX4xH_x1v0gMg34jaX24bqB2Qc4Q75ZFhQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdVZWWj8aLvRfX4xH_x1v0gMg34jaX24bqB2Qc4Q75ZFhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 06:47, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Mon, Sep 23, 2024 at 3:39 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> Interesting that you get that to boot. The q800 machine crashes for me
>> when trying to boot it in qemu with the latest upstream kernel, in function
>> __pte_offset_map_lock(). It bisects to commit 394290cba966 ("mm: turn
>> USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options").
>> Reverting that patch fixes the crash for me. I guess you are not seeing that ?
> 
> I never used qemu -M q800.
> I have just verified that -M virt boots fine?
> 

Not for me :-(

Run /sbin/init as init process
Unable to handle kernel NULL pointer dereference at virtual address 00000014
Oops: 00000000
PC: [<000ca784>] __pte_offset_map_lock+0x36/0x7e

This is with virt_defconfig.

Guenter


