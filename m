Return-Path: <linux-kernel+bounces-211626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D6D90549B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944ED28991B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8DF17DE2E;
	Wed, 12 Jun 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVSuHYBh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288BC17CA1D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200634; cv=none; b=a/wBTg+hdaRUJesC0HZ969/eEPvY8ts3/7go3r6yaredFMGU0WM28ykD8ailG40E2atG8EU32VGrf+L0DFvIydr3brI9tTniL6qw5Fx1SXGekqizCSzTyaFB6u8BM/LnIokzDQI0xesSX4jKUwAHD9P3q8X73aBYxnW/0E5XAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200634; c=relaxed/simple;
	bh=i4c48ygCfSU6WdCIpYbNWrvciGw+hJsYn2TXRdffl3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PoT1B5a0kxhB7bTOIkG1amxCIFR4PPkoWX/REzEXs3eNrHGoWtX+oEfT5w04Ro5c3H9vnz9JAe7mEJQkvb2p1aY6RI2NoOAgaSNNwojZC7Kc0f3wNaBvdrJ5dJW1aRvzZX0B1mIN3jLv151cOKdoUMN6RZL4Bxci6CkLehgAN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVSuHYBh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217d808034so34767635e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718200631; x=1718805431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAU+NAmzf19Ylr7LCKll4QKmndTbiCGZt3MgtjOKBe0=;
        b=mVSuHYBhMVl+hRkgJGyYBSPAxG0Fezsd26hXl7Bk4jInE9l/ZJMQrewbQ98Njt/ifd
         OYeV08vnnEqmtHw+8pumBNNLgcDTrhBwUBUsJAwqk942icGa/ou83mIEfkUcwXZROFn8
         G45j3u2wpBiX+2T6++4B7CNth2N6gI/0Mox7F7RqXrVKQ9F5HKKRmVBHX7KDT5Hd3Qr8
         gQt7sDfpW4fkp3gIuj+DnbTnra4iZ901zPUUb8L/0NHpIoYcI/3MV87rJVsosnRwyJDZ
         8E+a3M/ykF6RLZ06i1iHmUB99NHpbBSfw8CHlxRKtVB7loGC9wWAZa0VZudP6C0fvOff
         G3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200631; x=1718805431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAU+NAmzf19Ylr7LCKll4QKmndTbiCGZt3MgtjOKBe0=;
        b=NflOg8CFT0K3iyTIlSPp6NwGGlSyCOxrPdUpWlBWk5rOj9ch/BcEAYoNXwRDaZRWRM
         V/pcNlezRpKuyhgZGch4GXMP/HLfp5sI7jumEpkANX7Y6n5tuQvuoqyt0h3kfGxqcPnQ
         q9/YndRAXVxLTke64hfTCcNS566E8kyjVZDLmPRpjWQ5h8PsW0NqO1ZeSNasqt1VRPQv
         O5sdugeSV84LxtsBItDN8GwOxFnOdmTxA48epibBab42SgwEsh9fagEY7cmadorTc0B8
         dd3PUOhIGG+93DF1J1jEsSW1bBiaSBgiqTqIwv9xll1uTB7B5bcxEv/A87TA5vbrDImH
         wDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8T4L4XSY6ICyfH2W3gV+uytsXbbS0foD55FYsHcHDwmNmOUnEIOmfniJrAdM/OKbv7E1hFPf57Wt4gpyrlys0DqYM/IsmZL+tRbQw
X-Gm-Message-State: AOJu0Yxi8ia+qhUbfl+JQsCdXCZ2rASVwt3DFDHgCHyZm66M6GvP50x4
	GbB++Qt1mNE2YluO+kyDMLmvXQcmKGJnv8D2fSCev4K4LTv7TXKT
X-Google-Smtp-Source: AGHT+IGgpqrnK9Fy5Po1Nycou3NuX5aDnZs8SefI8hI5wxLt69PZUkXYbM5/ZYIMphSo77xcayKefw==
X-Received: by 2002:a05:600c:3551:b0:421:de31:81 with SMTP id 5b1f17b1804b1-422864af043mr16574585e9.24.1718200631175;
        Wed, 12 Jun 2024 06:57:11 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75c4sm27831985e9.5.2024.06.12.06.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 06:57:10 -0700 (PDT)
Message-ID: <0b8b2ea4-e07f-086f-c14b-0c9acb151aa1@gmail.com>
Date: Wed, 12 Jun 2024 15:57:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [patch 4/4] jump_label: Simplify and clarify
 static_key_fast_inc_cpus_locked()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sam Sun <samsun1006219@gmail.com>,
 x86@kernel.org, syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
References: <87bk49xf15.ffs@tglx> <20240610124258.109097511@linutronix.de>
 <20240610124406.548322963@linutronix.de>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20240610124406.548322963@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Make the code more obvious and add proper comments to avoid future head
> scratching.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/jump_label.c |   20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -162,22 +162,24 @@ bool static_key_slow_inc_cpuslocked(stru
>   	if (static_key_fast_inc_not_disabled(key))
>   		return true;
>   
> -	jump_label_lock();
> -	if (atomic_read(&key->enabled) == 0) {
> -		atomic_set(&key->enabled, -1);
> +	guard(mutex)(&jump_label_mutex);
> +	/* Try to mark it as 'enabling in progress. */

Missing closing quotation mark above.

> +	if (!atomic_cmpxchg(&key->enabled, 0, -1)) {

This can be:

int tmp = 0;
if (atomic_try_cmpxchg(&key->enabled, &tmp, -1)) {
...

and will result in more optimal code and will IMO also be more readable 
because it is clear that the code is executed when cmpxchg succeeds.

(BTW: The atomic_read()/atomic_set() pair can also be converted to 
cmpxchg in static_key_enable_cpuslocked().)

Uros.

