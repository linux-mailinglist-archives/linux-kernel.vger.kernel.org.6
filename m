Return-Path: <linux-kernel+bounces-333243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC5A97C5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879E21F236B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D9D1990CE;
	Thu, 19 Sep 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux/2guPp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FC194C9E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734505; cv=none; b=pOyUbdLpZTU2/YSH1i50NjwsQy4zSwkis73J51TsGQCtBeDmwJhHu78FsO8auoujT/UndxT1/LIwrh8RQ7BYwdsX7JG/Avtms//WU/fePkg0XXd/4UhhUB/ZiNgcS10kAurleBw8b5uECAYmLtgPVgd/chRJcKuan2JzSSa7lOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734505; c=relaxed/simple;
	bh=2gP72M6YFehKxS7DvcQxqVtz0w8XMZ6zsRmrqlVay9c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V/4yQyzSzdL93hB69tov3T4YkwDWWTFN0O6PH6/ja2xqiyoG0EvhCNkJBw7mb0Sc5q9L2LQTWhZ9dczZ8nEq90zWfuHM4k1NbMyIhkepa8L54R0YG60ldJ2l8Xt0SsoeF6epvjLtQGZjvBt/wMY3BcnKb7L4+mmu+1fNsDSEnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ux/2guPp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726734501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIvo4RERn6UxJSjQ1HziLRAQS2oan3Er/vAsptTFqv8=;
	b=Ux/2guPpN2kj7fkXi3Zw/BxMxn1NEkT+VuZsPHj4x9fTsRx//tplJE9bOInHJAvrkm9LT5
	zKuPDQQhyKmnt77fwvFhQr8TS7X3oRPGv5AB2e8fK7X7WNShb6e02aDAg9D2v0VgQDIewI
	36J1/Ma6ZnERFm/Xodwl8w3G707+Drs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-xn7BYHJjMU-BQIBc06PsvA-1; Thu, 19 Sep 2024 04:28:19 -0400
X-MC-Unique: xn7BYHJjMU-BQIBc06PsvA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c25d886aso244596f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734498; x=1727339298;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIvo4RERn6UxJSjQ1HziLRAQS2oan3Er/vAsptTFqv8=;
        b=qQkJFXhorja751jbSKAbYE5qsoP+n/IHIeFZ+LYyUgUX1MBT1LUtt154OQPnW2FHEc
         wJZ7eZii7hK48nFIZ7Mf0vWU2CIIjDhMoYf67of5KOn6iOF9NHCzxz5EYvQrB4PgnA/p
         9FnE2m3rLfh8XxCSdEbeXkaP5WokkvmQ7xHaNw/2UefQFqYJ/cnAQ+l8pdu/hZuyIUit
         YjntQx+WVs9AyCc+/QwSbP974KBU9qw9XRvPl2hNxPcI5Z5rDmy4Pt1EJCa+puPe7qgq
         jISQ0BU9hhEOeaopcq/4MPsVBuw1f4+ibmRr9NCuEPHc7PNVhZOopHu2cf0BDm/6QIMr
         +RmA==
X-Forwarded-Encrypted: i=1; AJvYcCUkexUaNZY0Pn2TucF8u8blW/N0LWmYGck1607TobvJgn72aX/Zux4ytQGHFzX9fSJuHgPt6e7wE6jdDN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKk6d54dqq4oyekcEjxJzcuoheGJjQahoOz0HoFZJG+IhDRGOj
	Na03otXUmNOkp49ujpMqgYcoeyh0BCgtw6ctvTdZR2RnZg3HrijTSIOyu9bij1d0RzrDdEHVauZ
	1NaJC0ACy9dvQCf6lHegri+JdsKDSyD+mj/eY9yPMOFrRtKyfgbi1ksrJgx5AEg==
X-Received: by 2002:a5d:5c88:0:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-378fe6e51c7mr4537704f8f.5.1726734498280;
        Thu, 19 Sep 2024 01:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKAUzDZrvhgfNjEKeku8qMzKR68uKK/JreYx9wIbas9L0dAYzL4X6Z2WGnz1JAE1Og2rQx7A==
X-Received: by 2002:a5d:5c88:0:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-378fe6e51c7mr4537686f8f.5.1726734497887;
        Thu, 19 Sep 2024 01:28:17 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37a3b340c9csm1107459f8f.84.2024.09.19.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:28:17 -0700 (PDT)
Message-ID: <404e37dd-2794-49b5-913a-2e3455f8c07f@redhat.com>
Date: Thu, 19 Sep 2024 10:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 V4] selftests: net: improve missing modules error
 message
From: Paolo Abeni <pabeni@redhat.com>
To: David Hunter <david.hunter.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240914160007.62418-1-david.hunter.linux@gmail.com>
 <a2462a8d-97b1-4494-8bc4-c5a09eee7d1b@redhat.com>
Content-Language: en-US
In-Reply-To: <a2462a8d-97b1-4494-8bc4-c5a09eee7d1b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 10:10, Paolo Abeni wrote:
> On 9/14/24 18:00, David Hunter wrote:
>> The error message describing the required modules is inaccurate.
>> Currently, only  "SKIP: Need act_mirred module" is printed when any of
>> the modules are missing. As a result, users might only include that
>> module; however, three modules are required.
>>
>> Fix the error message to show any/all modules needed for the script file
>> to properly execute.
>>
>> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.11 and therefore net-next is closed for new

FTR, typo above        ^^^^^ is actually v6.12. The rest is accurate.

> drivers, features, code refactoring and optimizations. We are currently
> accepting bug fixes only.
> 
> Please repost when net-next reopens after Sept 30th.
> 
> RFC patches sent for review only are obviously welcome at any time.
> 
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


