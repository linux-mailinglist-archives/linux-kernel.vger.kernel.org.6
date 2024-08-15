Return-Path: <linux-kernel+bounces-288153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4295D953686
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751291C24DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170991AB525;
	Thu, 15 Aug 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JDzRdTYw"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40BD1A76B7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734195; cv=none; b=cJQzRDq5OxTu8gy0T+isyrvFsYz6SVzTGU9K97Mfv/CoRRLCzjfujRrHRGzlUYIIBw0hLMveeAK0a0OzrM8qq3Bn+OEy2fj3WzkjsUlNoBwwQNTqy3yD7S71h+xIht2IEfbxMDMa5s6TVJcGSLFwgMQJK0tGGEybhOKMXjpOCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734195; c=relaxed/simple;
	bh=wb4j00D5UDtvObBs7WCbZfamAEdsFCIXr45DRUBc5tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRosVUFLPviKKIuwVNxiMsn12uzqeU2/f7f5oRNhhhwJ0JWt4W5s3pf1CR8J0rdoBBXDhsQRUQ0L/8w2goHyXcjRuUIFG0UjWRTCkfjHEGQzNX05QqijYGqS7+pB2juNLNQC5Zrb2D70I9RaoMIy5SzgYaxVuI6q3p18HqO0muU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JDzRdTYw; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-824d911b6c4so41074339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723734193; x=1724338993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mPSwAWscf8tHZseb+W+n2ONsrgl0K3y6yaW/7nWS8k=;
        b=JDzRdTYw3NCJ2Uc8GYdwhX0Ig+RHfz7K3ksXmHn0SWtesyaSZIWGqACHRZ5Y0jTLvk
         ffkH3b5FhT+XsI/AzgC+BMfvXlqAZU8YkQ3oUO+ZtHeB4JmVgAod/bZiW72oBCuPm9c1
         X1Qg2u96oKVehkhKuuTHSlzNDHlf2JWbJLXuWheFTouHwnx/hrS5ipdp9ED91aXU0dXV
         iuliKqda+xANugt4Yd5ynxt/6eMV8BBMgn/4FjiBI9OcXA42tdNVoP7YaESwvTt01Fz5
         GJJeJC+WVzzwckgL3U/o4ifb7US2D0lGBZE1amUD9t4jHLuLZaVUXRcrIugS0sHjrbSX
         dJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723734193; x=1724338993;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mPSwAWscf8tHZseb+W+n2ONsrgl0K3y6yaW/7nWS8k=;
        b=KuXfNqjKMe/ieLr7edwQlHFa9NhRB44LSxcC/bl8ViCfd57tyMhVn9PZTW4gyoocNi
         Kt0D9vzayPqQy05xfDlZxDqQiygwqSianOpSPLXnqve8dRIYRT10oCOQHmNEqYtYJh/X
         Tvz266Ou96pdpxPiamxKdw7+VWyN8tKmtqo2pTT3dDPdIOLyprsu+/zVjST2M78WYujI
         7Mkw8gTSb6ux1wKHMtgYczUNAh/MU3FFqm3LZ/YBPJyGupaJ1aGtk5pIMkTbCU+qraRg
         7fiXWb88iedSo0o6mmX+2SSUktxEjhXXlHfsT8wHuONgzdK7Xd8x/QAvL7B7XIHip8V4
         7W3g==
X-Forwarded-Encrypted: i=1; AJvYcCUs8IMzI7cnD/W3Q6SwE2O3KGCY1lH9LUVnXZezRw1sGZ7v8m4EVV/mX8Teu86JvQkalV9W5HVYD8f8aDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwSsSlt2NsG2iRarFWbL2crKA0G8NYjr9CZbpKKSMM3HE238NY
	bdv/7UHDDXLYCVnkMyCoyb69IAh2dMT0OgVw1/tT9HU5sJokFjo7CpkmnEjRHio=
X-Google-Smtp-Source: AGHT+IF2Y36Z2WJheMtc9w/yNlpCQH/p4fRlXJ1oZRTUH/ip1MnrhF7mpnTwcuaMC5DPS0f5LA3azg==
X-Received: by 2002:a05:6602:2b8b:b0:81f:69c4:e026 with SMTP id ca18e2360f4ac-824f271eb1amr5205639f.16.1723734192531;
        Thu, 15 Aug 2024 08:03:12 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6eb7291sm534290173.82.2024.08.15.08.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 08:03:12 -0700 (PDT)
Message-ID: <7902c26a-d719-45ad-85d5-61ce6bbc9459@sifive.com>
Date: Thu, 15 Aug 2024 10:03:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Anup Patel <apatel@ventanamicro.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx>
 <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx>
 <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
 <87plqalyd4.ffs@tglx> <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
 <CAK9=C2VHfPnYx8gMjodJNLu9+yR4KvuPXeQZiyZcbu1Mvze-0Q@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAK9=C2VHfPnYx8gMjodJNLu9+yR4KvuPXeQZiyZcbu1Mvze-0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Anup,

On 2024-08-15 9:30 AM, Anup Patel wrote:
> On Thu, Aug 15, 2024 at 7:02 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>> Yes. So the riscv timer is not working on this thing or it stops
>>> somehow.
>>
>> That's correct. With the (firmware) devicetree that Emil is using, the OpenSBI
>> firmware does not have a timer device, so it does not expose the (optional[1])
>> SBI time extension, and sbi_set_timer() does nothing.
> 
> OpenSBI uses platform specific M-mode timer (mtime and mtimecmp) to
> provide SBI time extension to Linux.
> 
> The RISC-V privileged specification (v1.10 or higher) requires platform to
> provide a M-mode timer (mtime and mtimecmp).
> 
> This platform not having any M-mode timer is yet another RISC-V spec
> violation by this platform.

You've misunderstood here. Allwinner D1 (T-HEAD C906) _does_ have an M-mode
timer (a CLINT). It is just omitted from devicetree that Emil happens to be
using, so OpenSBI isn't using it.

Currently OpenSBI allows the system to boot without a timer device, and the SBI
specification does not mandate the time extension. If consensus is that either
of these should change, that's fine, but currently I see nothing in either the
privileged spec nor the SBI spec that guarantees the availability of some timer
to the kernel in S-mode.

Regards,
Samuel


