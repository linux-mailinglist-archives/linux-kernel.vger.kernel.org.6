Return-Path: <linux-kernel+bounces-414140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C6D9D239F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE657B263B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CEE1C302E;
	Tue, 19 Nov 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NimRcjPx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68891C4A1D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012207; cv=none; b=X4Ev71FWLU3e4k9qitBQt0exh68JZJqpts2YhjT06SURzSxjMAcHLrnUm1EJZkhBVOBSIiiqD6Bjgrj/bmCWr5j1HBbrlewU5EaWFDOPYIi0i4Zpy2CFGFR6/3UdE98g6ssDYUc8Atzm4CIkglQywZ5pYoeio2UUYEJMkXP4AOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012207; c=relaxed/simple;
	bh=ly3mNd5YsalM+CzqIwmHDN6pX4o4d/knQWkiqA/Uo3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaRl/OHI80SlN4r7gNNynKaNk2FIEmdkOePeeeqQxkLgLK/kA6JTDJoSjM41tjjlgLWpR4OZTkcKXaYMHKFBka/+t2SkHSo62/Alb/7TFxIK8tH3sfwKfERRRHeFsCylBAWEWSBJOo8eHnRorJXGdqhTHf1sGBITRfthxW1iV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NimRcjPx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732012203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v03iSxWVANhOeJxy3bsm+mYyAEfzffMk3+YdoIoKdjY=;
	b=NimRcjPxuUz4f9SYPghgzs/c/yp+ywSiTO8NmMgELMaUgHLK5Onyn/Ju5p35hHwNR0fXL5
	1rNbO7WDQQ3oAIhPV5zm4GVga9/A/6/Dxa38sc0rJHkKzHRcrSrLaT6uqF5tRTwAmIVYam
	IwZ+KBYbJxo8X/B6f0drLA25ESzBmug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-wlSlW71aN4-R-koTioO3ag-1; Tue, 19 Nov 2024 05:29:59 -0500
X-MC-Unique: wlSlW71aN4-R-koTioO3ag-1
X-Mimecast-MFC-AGG-ID: wlSlW71aN4-R-koTioO3ag
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4314f1e0f2bso22117715e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732012198; x=1732616998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v03iSxWVANhOeJxy3bsm+mYyAEfzffMk3+YdoIoKdjY=;
        b=pqnwmA1JMfS4JzXOr0oDryBHcLgSg3RzfViseqGeybyk/bxhOGe9lplJJkAj4QuJ38
         7nvErz6rqUwEnX0ATlxrmXe/qGQ1EuHPs5kS/+/3GkakLtl7PCfJACnFA2H3aVw3TX+U
         pSmduOZTjbM2Ut7RbUvZ/FUL75ztNPYEw3P97QXL3jCRgTYuua/eK9GaJ3TE4GMPVo58
         b5b8V7KPFN1hFXcWUSoY8OXYysWEkUirzY8nUj/9MxJvXbNT8cXnPfH4JolEAS63HTWV
         H3RRP67frsU8xFA+9pLWEp7P943ZOT2pESGVWmgHDtXDYaZjEvRaIRkwQJW9Il3NcYWd
         ak7g==
X-Forwarded-Encrypted: i=1; AJvYcCW8AYXnZKa2dlILZO2EkSfwAvNakwiXQNcMyKab/lG8NdNAkcfmxAZI8uDVpU63wfkr21xK7fGL92MX3Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtZ0Pq4YtVEPjB5zRQO9iOxYeYSAg6C74CRPGnPP1VFTuCyr0
	+ugMGoxIA7PUPDd2mKBNymhtVxhCC2xMSMxR5HOxx9vEQ47433i7pUi3ufkhlmA6ym9LQWdVCQP
	LF/ftH2KhUAvVRuqCmNqWh4myKMRZk8HqfiXZ/CPiqUtlnuAambbW2ukX2vTaLA==
X-Received: by 2002:a05:600c:808e:b0:432:e5f9:2eee with SMTP id 5b1f17b1804b1-432e5f92f99mr105146625e9.5.1732012198154;
        Tue, 19 Nov 2024 02:29:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaGxrBXvlh0iZlre5SixcTdzb4uCu+PUvt5x46epMLIPAdXpFV9W8760iADbVJYk0QOUROtA==
X-Received: by 2002:a05:600c:808e:b0:432:e5f9:2eee with SMTP id 5b1f17b1804b1-432e5f92f99mr105146425e9.5.1732012197833;
        Tue, 19 Nov 2024 02:29:57 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0aef0sm191873615e9.28.2024.11.19.02.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:29:57 -0800 (PST)
Message-ID: <bf7a70f2-ab0e-467d-a451-a57062982f18@redhat.com>
Date: Tue, 19 Nov 2024 11:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/5] rtase: Add support for RTL907XD-VA PCIe port
To: Justin Lai <justinlai0215@realtek.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "horms@kernel.org" <horms@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>,
 Larry Chiu <larry.chiu@realtek.com>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
 <20241115095429.399029-4-justinlai0215@realtek.com>
 <939ab163-a537-417f-9edc-0823644a2a1d@lunn.ch>
 <a0280d8e17ce4286b8070028e069d7e9@realtek.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a0280d8e17ce4286b8070028e069d7e9@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 03:30, Justin Lai wrote:
>>
>> On Fri, Nov 15, 2024 at 05:54:27PM +0800, Justin Lai wrote:
>>> 1. Add RTL907XD-VA hardware version id.
>>> 2. Add the reported speed for RTL907XD-VA.
>>
>> This is not a fix, it never worked on this device as far as i see. So
>> this should be for net-next.
>>
>> Please separate these patches out into real fixes, and new features.
>>
>>         Andrew
> 
> Thank you for your response. I will follow these guidelines for the
> categorization and upload the patch to net-next accordingly. I appreciate
> your assistance.

Please re-post the series including net patches only and wait for the
merge window completion (~2w from now) before posting the net-next patch.

Thanks!

Paolo


