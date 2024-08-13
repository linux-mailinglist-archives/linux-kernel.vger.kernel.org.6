Return-Path: <linux-kernel+bounces-284157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C79294FDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED240B234F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECE4206A;
	Tue, 13 Aug 2024 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igcconTa"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE703AC0D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529758; cv=none; b=R2qx7zz1KTC8XIyTdMX9x7mgrCaixXieZ075A8LipfnpZZmOcgZ/q+OjLshMtDp6iDfpwLPIgslJZ9z+ubxwOwkvJ3hUaXw2AMcHpjmgRbtgk7N1mlsxBDObjX845nSIzBo0Lw0lUlEWR06HHLH8GuH+5xpN/Od4OtmcyNCNuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529758; c=relaxed/simple;
	bh=CnTV7t6wDLEAWQjG2kc6iJVZpiK2POpsQBLMxXTJT5g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mj/3mjHt8hpcQdq+q2ab+NfMDTVHGDldLB2MYCg2o0O6S3YrEnl24HHwomVPQFBnIWoUtYazg22PgG13qlUEIwDiR5HJLqWdF1Sq5bDH6n846dH1lCvQ3efXTX3rACQpDaX3wKjFeZS0ql+2x7EVAUAdOtUz1Qt+5xnSAa+u14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igcconTa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f1798eaee6so48948621fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723529755; x=1724134555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8oGtIw/pcWW3tXyWgJW8i01oRoVha7ME3aTl6Dtvg8c=;
        b=igcconTaOv6PExSmq6Ymyl73iJCLydHQY78zHqkiR8JlUjumYigcPtSDGi+4TQo5dj
         2Y+Ws8pG0/gu/dm3noCs7bjTlvs9f+sYY3Wzs3hpJJYWoB5Wdr1+eICNL6BjR7gp7/ZY
         FEVxif4CYXI5pZ3wtyX6wY1TE7tJyxN0Q12Y6UdxCn14XftCOZ90ryDESwA792RVHMWE
         bZ07pEtk1I8fgO2WQ04W+dYNU24RFGGDDnMhzVovwqhHiF0qok7h+V+4INHo2MhY+219
         gTkzay6RyrWLe+l2TZDGiGsoRfo4uW6uTuDjU4S8fLSc8Gjd3az8nseVAqZGwDhNNrly
         qr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723529755; x=1724134555;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oGtIw/pcWW3tXyWgJW8i01oRoVha7ME3aTl6Dtvg8c=;
        b=tx28FOfmzpxQ7wILu95h84/BxD757LkyH/1I6tXCOQ017V8ifmP5bG/sO7hHvlfitd
         2idk6ArT7y6BsJ6C97mgWLBEaLRiWwx1jSWJSyy08SLioFwl8Y5kJnaCkR0LTSAwbwec
         LM+pHbYNjB5Cesd6PxX0dC4dSC0w2yeHdIun3n66ShyEb+1dT5NSQWXxxtrdN0T7iYNM
         XKhDKO+7qxg3rSilP3cDueWIx61aKV5gFqOOp+Y5nU+FY0JwQuooGCncUuATBOzbGS9R
         i6SRfEx+Q9eB7eOlvFbUbYRw/Oqfmwz1m7Zqgl/gK9tCHgnXmevAvAo0ApLI21REV3FO
         fKQg==
X-Gm-Message-State: AOJu0YwY26lRywE6GVzNyolgk2E6oeneocN8cbYFLtw5TSVmk6KJ4OZy
	ByN5cJMf2g3t3ZmZ5YK3gcvr7wdS+EPohMTogjK4bdaUWfzb9WP5
X-Google-Smtp-Source: AGHT+IEFK7WPkhTya+soHN2m0x3TCOdjXqoSUU4m6XxmX1qg/vemT20sdNymgU3+YyfhEgtaqPPKmA==
X-Received: by 2002:a05:651c:1197:b0:2ef:2575:de11 with SMTP id 38308e7fff4ca-2f2b714a48emr14315221fa.15.1723529754528;
        Mon, 12 Aug 2024 23:15:54 -0700 (PDT)
Received: from [85.64.140.6] (85.64.140.6.dynamic.barak-online.net. [85.64.140.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7734595sm123630935e9.36.2024.08.12.23.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 23:15:54 -0700 (PDT)
Message-ID: <e04eabb6-fa5f-9eb2-c2a6-812f6a310bc0@outbound.gmail.com>
Date: Tue, 13 Aug 2024 09:15:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH] drivers/xillybus: fix deadlock upon cleanup_dev
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
 syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com
References: <20240813040425.187418-1-snovitoll@gmail.com>
Content-Language: en-US
In-Reply-To: <20240813040425.187418-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I should have sent a response to this syzbot alert, indicating that 
there is already ongoing work to fix this issue:

https://lore.kernel.org/lkml/20240801121126.60183-1-eli.billauer@gmail.com/

My apologies for not doing that.

On 13/08/2024 7:04, Sabyrzhan Tasbolatov wrote:
> syzbot found an issue [1] when cleanup_dev() is called twice,
> causing deadlock.

How is cleanup_dev() called twice? I only see it once in the stack trace.

  It is called in xillyusb_probe()
> in the end of wakeup_all():
> 
> 	INIT_WORK(&xdev->wakeup_workitem, wakeup_all);

INIT_WORK merely initializes the work item, it doesn't cause its execution.

> @@ -2174,7 +2175,6 @@ static int xillyusb_probe(struct usb_interface *interface,
>   
>   fail:
>   	usb_set_intfdata(interface, NULL);
> -	kref_put(&xdev->kref, cleanup_dev);
>   	return rc;
>   }
>   

This edit causes a memory leak, because the reference count needs to be 
decremented in other failure scenarios.

Thanks,
    Eli

