Return-Path: <linux-kernel+bounces-302897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65509604C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398C82814AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A3D19D8AC;
	Tue, 27 Aug 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="h+fQODdo"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8489619B5BD
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748370; cv=none; b=jkTtbVmE6l/WS6ObnvtLxQ5cad/lkV8Sb22gcDk/d5dt9lLQ+f0WZjtAyUCkOQahQL0RIjvT2FaYyalsHNdHU03J9YcwKLIE8eBu+R4jVJoa039rEC9Dgq8twuARs7DOABGPZL4z8pguXS7gi/8U6+IGcXuCLQ4EDduMnsQf+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748370; c=relaxed/simple;
	bh=Dvtxa4V6Bs/3XTqDUK5hXuOrmNm/uLiTA8qDmC5Ji38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4n3ZBYyN12CX6FNsikNc9UYmzxUEBuYIVUWSf55W/BFvpgxTNFCK5zvIeVznZilAONp8nAMW+mZsS1eh1vRu1Pkw2DsTBVBgzVPPJAkZPSUdzMaiUF2AyqcgRha+LU52DdD1MeYtBMdzP/LVXbkniFmPTpFqK+CFGQR3aYLZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=h+fQODdo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2020ac89cabso46800915ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1724748368; x=1725353168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtUjisoxweORZrg4fn1Xiko5y3WtxltGnudKvdq1pXQ=;
        b=h+fQODdoWZJ+Fk5d1lmlGU44vL34EQBzk6/Plj6HQe1tyJW6LSjBhUytgPr9nGjIwD
         NVAZY1nlC+6wN+R7LgpeWJz/uTgqKc3SS15EuEVH6qnlBMBqdwCtcFMRwbwPnjt2nuLy
         yQgblqsK29GVTgPQjekH1X+GlegMCkKEuUShNAv8fTYVazRTU7eGZjJhgMVZGfTXOjzG
         N9bww7PqzNNp9wA6/Ffb17CFJkPFq0zFY+a8C8jW2diBj63o1FyicUWvn5wnhT0fhqlp
         Y8cn9FkyUYiijRu8yZQT0W7ex2MrcimZxW41qpZUYSCy0DfP4v5R+7OjopPhRIesY6V6
         RCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748368; x=1725353168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EtUjisoxweORZrg4fn1Xiko5y3WtxltGnudKvdq1pXQ=;
        b=b67HTvL+DpN2g5B8hhq3PaG6mKglYA+2D8WIZrCJ7CCzxsVfHiSk2mbKkR5kyWMF/A
         2HXWOqoW1YsmRCkP0XGu8oBOlSyHMmctgEQ+bQGUxcis+b8znm5hokNJtTmwxImEobAX
         3tI5Hbte1hz4Q5C+JkRExYK3eT1FTwRHSuAk4wKk+2qB3Oe6tyIsHB2teoCofqWjqgb6
         w1tPTWoDCPFXecaXdy7+dz2dYSVwutF/w/YxSLNt/yJTQSs/i3rg/p/bCQap+XUzAZoG
         1XK78p62AlKRmMbp8a1H6I5tof4yz2JecOQ2a8ShKx6LqZGFcl+YIe3G8Lrs4Fdq34YA
         3oNg==
X-Forwarded-Encrypted: i=1; AJvYcCWOheoE/dgK3r43UivgKq/ftqe/fPvYBcgZwHm0KRtyx/qCDEIUYhJ+g7dhSRTYKl9jBfNyRF6C2JS+hI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGfk4N7G4aAYnunMlRQRYGE5ND2VXMi5szfPH/G1aUaSV9b7S
	7hxi+kRHt6W2W8AZuf4K8/lqjXGCzbJrscmT7i6cbHfmrK/OMjpzOeBxipOP3is=
X-Google-Smtp-Source: AGHT+IFEYNcVeNvgpnWZk7ub9utvpNMkrMxOy9OnSeoCyv2ylz5xO4JD3XynfJlL8kiscLvthY7UBA==
X-Received: by 2002:a17:902:e888:b0:201:fd52:d4e7 with SMTP id d9443c01a7336-2039e443abamr168681155ad.2.1724748367746;
        Tue, 27 Aug 2024 01:46:07 -0700 (PDT)
Received: from [10.54.24.59] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385564ae7sm78761205ad.55.2024.08.27.01.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 01:46:07 -0700 (PDT)
Message-ID: <12c30542-27bf-4e63-b4dc-1c9193863062@shopee.com>
Date: Tue, 27 Aug 2024 16:46:03 +0800
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
 <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
 <CAJfpegsvzDg6fUy9HGUaR=7x=LdzOet4fowPvcbuOnhj71todg@mail.gmail.com>
 <39f3f4ae-4875-4cd5-ac2e-9a704750eff6@shopee.com>
 <92427273-edeb-42b2-8f3c-5256d5a4b056@fastmail.fm>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <92427273-edeb-42b2-8f3c-5256d5a4b056@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/8/22 01:38, Bernd Schubert wrote:
> 
> 
> On 6/15/24 14:19, Haifeng Xu wrote:
>>
>>
>> On 2024/6/14 18:01, Miklos Szeredi wrote:
>>> On Thu, 13 Jun 2024 at 12:44, Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>>
>>>> So why the client doesn't get woken up?
>>>
>>> Need to find out what the server (lxcfs) is doing.  Can you do a
>>> strace of lxcfs to see the communication on the fuse device?
>>
>> ok, I use strace to track one of the server threads. The output
>> can be seen in attachment. 
>>
>> FD: 6 DIR  /run/lxcfs/controllers/sys/fs/cgroup/
>> FD: 7 CHR  /dev/fuse
> 
> I had missed that there is an strace output. 
> Would it be possible that you describe your issue with all 
> details you have? There is a timeout patch now and it would probably solve your issue
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_20240813232241.2369855-2D1-2Djoannelkoong-40gmail.com_T_&d=DwICaQ&c=R1GFtfTqKXCFH-lgEPXWwic6stQkW4U7uVq33mt-crw&r=3uoFsejk1jN2oga47MZfph01lLGODc93n4Zqe7b0NRk&m=5Vvh_Xul4vraWltHaaiJGAV6x-UDqHBp5rxONeLnrrClC8HrZVWapSodWQUOIYiT&s=PsUk37fgf2VgSXOxE3UlYxu5su7eWMPCoErBzmRj2u0&e= 
> 
> 
> but Miklos is asking for a motivation. From point of view that fuse server could 
> abort requests itself Miklos is absolutely right (the product I'm actually working
> on has that...). And one could even add a timeout mechanism to libfuse.
> But question to understand your main issue and if there would be a request 
> timeout needed.
> 
> In general, it would be helpful if you could provide everything you know, already
> with the initial patch.
> Later on you posted that you use LXCFS, but personally I don't know anything about
> it. So it would be good to describe where that actually runs and what you do to trigger
> the issue, etc. Details...

In our production environment, this issuse happened serval times, but we don't know why the lxcfs server
didn't send reply to client(received SIGKILL). So if the fuse server can't abort the request, the client
thread will hung forever.

> 
> Thanks,
> Bernd

