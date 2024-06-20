Return-Path: <linux-kernel+bounces-222847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 245E491088D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2D41C231F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CDC1AE083;
	Thu, 20 Jun 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="Vjbi0zXY"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85423774
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894177; cv=none; b=Cm265sEmdfxoYGOXX1lA/N/x52c0ZSaJma9yMZu8rGxtpH+Fu5kXsOF2O3gCiYRcoM2FWBsyblwb1vsuiRoHSMXLKHTVjNHsiKaOllpQXfOCDzVDWgaV+9iuZYObCApFub2oG4w4SDWkjeQgtYBosE7b2r1tscWzs/zK0bViWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894177; c=relaxed/simple;
	bh=C/7etpkN1EyOxZMX7kH6rf1YdH7lnLSLobU/qcTAhKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FErDDMR5h5xPTyTlfnYSecWnQ7NVzLIq5aQkrMv0zU5/RnaYxEGOUl9VdX2I/nFgslIYJlRWcUkX5kamyN4M74wd8eQYHKJN/z8Qnn51SPcDn4dIaiISz9Fwmyh/vEIhRMl+glFMX+IXzCK/7briNoMYRep0iWIvkgbFvdzyH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=Vjbi0zXY; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36da84df7adso2783055ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1718894173; x=1719498973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A98UevaERdbTC/YwOFyWmTbSR1N+hw0zQSVldl8RhYU=;
        b=Vjbi0zXYpYweq3mJUapFzCctHjKrGGk0yxW9yXU+KJRbQPYkcP0dow2FwNaIzb/5/j
         xZzLJBhBLaQl8AyagdIxzf3RLNzEEHPrzfSK6mRb5fnNBkqEdnyDgDRmcs79RBowlwD3
         28miW94Ktr+ugSKGSw6pjvAlya6KaI7fMS6oyn9YWgeyK6CkQH5EnN4/a969hklvKnlt
         smR0BJyqyRTGg0cRwDPftQA9QXRrJrsbUSM/VJXKjOg6pLf9SKpnF1lcnJgw1elcNZcE
         3mgpCrhBKh+l3T9SZjVw2FBLUGzXp9dy7zLP6VjiiVtuwL8o8FPnc/pviSSW+uUZ3LCv
         RTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894173; x=1719498973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A98UevaERdbTC/YwOFyWmTbSR1N+hw0zQSVldl8RhYU=;
        b=CxqyfchaKUogq6XJiQ3VWAJ5K5SEUs4gz9l8U+JTXXvUtYxGXtJWCvNNB9YLgvSO7j
         X4dvoEMBC6bQMuSdp+XwktuHlgUEj6A+zbgbjbpKirKqOGFfTFciMs9mqoN+ljkdN4Ip
         e/tAs4mOJC1EvRHydd2vN0OIDjvz221Sf2KVq+59iQxhBtXP9fkGIbZW9qg+1S36K1gE
         TfCwWHhhWharEvLpRcv0R+9cVKhvnrgzt7zg5i9fUyS/BP6SrDaomZJiNgnSV2mkJ+2m
         UvJPwgqDOzN5ZpWx8m1AVfUkh78UKBz7yKt9C0Qzxg74tyjcle2qdpMuTt8RSd64tW3t
         qZwQ==
X-Gm-Message-State: AOJu0YwLbX94l3Kti2X/vG430jNcP/IdfSk7y+LKBTjB1EWj6T9y2bYT
	R6FMVAaTak15lZAkKor+u4V84O/NA8uy5i3aEmJqRy+dmKBkvYnnnnV/zCPQVE8=
X-Google-Smtp-Source: AGHT+IHEX4VWi6NFf2OYvYNfmsh9bNN5+QvL49KMSIcQjonXWJpIa7TVyKkpnYOby5F1SBrP2YKhQw==
X-Received: by 2002:a92:dd0c:0:b0:376:296b:1754 with SMTP id e9e14a558f8ab-376296b17c3mr7852465ab.15.1718894173249;
        Thu, 20 Jun 2024 07:36:13 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9568dfb15sm4517876173.18.2024.06.20.07.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 07:36:12 -0700 (PDT)
Message-ID: <012b7244-fa12-452c-9d76-7768e59f7e03@draconx.ca>
Date: Thu, 20 Jun 2024 10:36:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Content-Language: en-US
To: Hailong Liu <hailong.liu@oppo.com>
Cc: linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-mm@kvack.org, sparclinux@vger.kernel.org,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <20240620063742.7qugmebodtlogn5r@oppo.com>
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <20240620063742.7qugmebodtlogn5r@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-20 02:37, Hailong Liu wrote:
> On Thu, 20. Jun 02:19, Nick Bowler wrote:
>> After upgrading my sparc to 6.9.5 I noticed that attempting to run
>> xfsdump instantly (within a couple seconds) and reliably crashes the
>> kernel.  The same problem is also observed on 6.10-rc4.
[...]
>>   062eacf57ad91b5c272f89dc964fd6dd9715ea7d is the first bad commit
>>   commit 062eacf57ad91b5c272f89dc964fd6dd9715ea7d
>>   Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>   Date:   Thu Mar 30 21:06:38 2023 +0200
>>
>>       mm: vmalloc: remove a global vmap_blocks xarray
[...]
>>   spitfire_data_access_exception: SFSR[000000000080100d] SFAR[0000000000c51ba0], going.
>>                 \|/ ____ \|/
>>                 "@'/ .. \`@"
>>                 /_| \__/ |_\
>>                    \__U_/
>>   xfsdump(2028): Dax [#1]
>>   CPU: 0 PID: 2028 Comm: xfsdump Not tainted 6.9.5 #199
>>   TSTATE: 0000000811001607 TPC: 0000000000974fc4 TNPC: 0000000000974fc8 Y: 00000000    Not tainted
>>   TPC: <queued_spin_lock_slowpath+0x1d0/0x2cc>
[...]
> I guess you can patch this
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-hotfixes-unstable&id=00468d41c20cac748c2e4bfcf003283d554673f5

I tried with that patch applied on top of 6.10-rc4, and the crash still
occurs.  There is no obvious change in behaviour.

Thanks,
  Nick

