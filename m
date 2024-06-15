Return-Path: <linux-kernel+bounces-215880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDE890984A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 14:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FBB1F21E75
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579CE3C062;
	Sat, 15 Jun 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="WKqokBrW"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096545945
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718454065; cv=none; b=ab7JzSS7tv64SpV8YYDUEDD0PJUuWi0xHsi4upXtlWLeJKzemcb74ni33FwfiVBoX+o85PuiyRZCcrsrQO7gCPqb8FUb05043oXThVW33zRrmA08Unu0IyrxvH/kv8SJXYlgQTJ0GX6eRSZFn/TBIj/kCy0W/WqRvP8JcZ5RZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718454065; c=relaxed/simple;
	bh=zp6HAHqQzS4bpRHupIiKdAIU861FIU+seO8c8aTOcQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0uabmmCkzLCPN819n6XqDUk9JLYY/y2hZSEZLKV+bIOJCkE6NRMO591vlJtL8Sq6Z4G6KxiNS1AV4NPi2ucvDh5YyjQRPpxo5ENlqbQiKcNuxi57S0uF4FRks8Va8+QPkqykwLwn+EIQwbZdyLBBWin7Q9000k+bREJyd/FXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=WKqokBrW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6fd8506a0b2so2481425a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1718454061; x=1719058861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT0csZvkAyZvRyAkGZAf6VlXj1JNmiQ7p0AcD9y7g2g=;
        b=WKqokBrW0VHb5KAYu27LiHllgJUyLGLnuuuZZI3gXC27GN5/ghh1ypVZ034x9wegBA
         CMi9MfqorvoRKGS9+yuhCMtk41BUixN/PBV1tL11uvyhWiSU2MhaLSBuSw5kXx5HHLAe
         5RKpdWVFWsOMRooWo4CZr+rTGf/doHVlsd8Gi1mZ/03N30d5csW9BLT467Zyru6Uok7I
         sXKXSGVMsEev6Ge2wyWT7naAzXQlEl8SqEN5nBQndNJdlIwIt5ieK38m2/RbvghDEuHL
         PqJDK1kadvlwCGm+C5Hc+t3bUH1qDa9DCXm6UsmPJOlfjHfjVx4Zxg4s1aHygLcjIWAT
         xgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718454061; x=1719058861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QT0csZvkAyZvRyAkGZAf6VlXj1JNmiQ7p0AcD9y7g2g=;
        b=lCsJ0Uc8VHov3q67NQKqk/a7fTSDa3N1dVCToRaQW/7acHY7wb4wqJG2N6fU51ASUv
         1ynV2EHQRCEaHbIY0N/UkpikqbuVw3IcxadgrPdGzUTwl/rialVewSXkgiNIsRI7RFRH
         L79ujJXAy1g9S2FDXYGebR36P5wEJ1UF3h+aDQnJ59/+BRU/oOWFZwSV+t88Mi+XWK/B
         Ri9j1lj/etgCYrcgSWweEOmKHYAQw2tLkxkjC2sRHCnHhvX2wkmBbXidAepwxWUzIQ/K
         WVJ9b0Z1od5RktGXd8Qoevqh362zcZ6HGZvKnL/nkC0zug5aGA2PwbeiTYdcTAHcbMH9
         JRkg==
X-Forwarded-Encrypted: i=1; AJvYcCV7U+ikT2j8eZrYyaSs3uTLI8ba6Y4MY9o8OcJXddJ/joSYHgzn+9ok9w9czlLdSxuEE7vXVsqV2Q8xDh4B+JhszR40XtpJ4hobyAG8
X-Gm-Message-State: AOJu0Yw1AzWMCoTCTDeMVAkrZ+oBBM5LNLzm9Jyw7LaSQaVybYu+9a5j
	WrivdsPHbQfgxmTvyFay7G5navaumkVGOvVoK+g0zjqhHiF7g0pIzketLVAULBA=
X-Google-Smtp-Source: AGHT+IEzu79iKc3+5Cc9cOE0W0brtv3+RnstpaijdqFQTe1Rd1BQ+Wa4C56+pHSK/H9VUqeOFQ1iJg==
X-Received: by 2002:a17:902:dad0:b0:1f8:6bae:28f with SMTP id d9443c01a7336-1f86bae054cmr36156385ad.9.1718454061117;
        Sat, 15 Jun 2024 05:21:01 -0700 (PDT)
Received: from [10.12.168.35] ([143.92.118.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee8354sm48657745ad.149.2024.06.15.05.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 05:21:00 -0700 (PDT)
Message-ID: <3ce68249-c2f1-4407-8415-f08fc30bdeb8@shopee.com>
Date: Sat, 15 Jun 2024 20:20:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
 <bb09caf0-bb8d-4948-97db-9ac503377646@fastmail.fm>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <bb09caf0-bb8d-4948-97db-9ac503377646@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/6/14 18:31, Bernd Schubert wrote:
> 
> 
> On 6/13/24 09:55, Miklos Szeredi wrote:
>> On Thu, 13 Jun 2024 at 06:02, Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>>
>>> When the child reaper of a pid namespace exits, it invokes
>>> zap_pid_ns_processes() to send SIGKILL to all processes in the
>>> namespace and wait them exit. But one of the child processes get
>>> stuck and its call trace like this:
>>>
>>> [<0>] request_wait_answer+0x132/0x210 [fuse]
>>> [<0>] fuse_simple_request+0x1a8/0x2e0 [fuse]
>>> [<0>] fuse_flush+0x193/0x1d0 [fuse]
>>> [<0>] filp_close+0x34/0x70
>>> [<0>] close_fd+0x38/0x50
>>> [<0>] __x64_sys_close+0x12/0x40
>>> [<0>] do_syscall_64+0x59/0xc0
>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Which process is this?
>>
>> In my experience such lockups are caused by badly written fuse servers.
> 
> 
> Btw, if libfuse should be used, it now supports disabling interrupts
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_libfuse_libfuse_commit_cef8c8b249023fb8129ae791e0998cbca771f96a&d=DwICaQ&c=R1GFtfTqKXCFH-lgEPXWwic6stQkW4U7uVq33mt-crw&r=3uoFsejk1jN2oga47MZfph01lLGODc93n4Zqe7b0NRk&m=tF8m9nGSWX4QZ_jfhLnEAE5bia1XekX0a_EojRtTFs2ZqfhKCrhY4cwO6K9UrW8x&s=X5dxXdmPhGVwknoinaLMbPYdHeOnrfVdOXs8HPCLT0A&e= 
> 
> 

OK, Thank you for your reminding.
> 
> Cheers,
> Bernd

