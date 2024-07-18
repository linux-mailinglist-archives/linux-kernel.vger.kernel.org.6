Return-Path: <linux-kernel+bounces-256119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E13934935
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037331C21D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121378C7E;
	Thu, 18 Jul 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBJGCTRo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4078685
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288960; cv=none; b=HLheZqsYY3UXJfumqF8iJX49zIk7+/q1AFso8/m30GrnY24Hyd0crZhDyDb880NyhAbBIJepiBGkGMI+9nYIsEBzsD3YhJgshWQP9cIJcPeZ6qsc4OOCWwONP2t0AIolx7oHO9b/ZEKOXO2SU8jsE4xlgTtKw4K3KRFC9oiXWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288960; c=relaxed/simple;
	bh=RyArBk57Wg2qcvjzc6Ynbf4X1sU+TR9SeIgR5+gOiVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wc1pwrzDF/3+7EuvoDI/S7/1bJ7DBvHUdxx5rxx0I+4jPaZ3zEFU1inEWf45NBBvaM9RGaQlIlqCyQ53/6Czchdzx45wDDDNrsL43IcD+vh4ISCUe7tDmCzW4lPDUm5ug9H0D/53aR+brs1C1NcL2GOhjoDYSw4kGe5ET1uhsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBJGCTRo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721288957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/jsSOpv/topEHxrEoKqtalPtg+NFFfMqa3rhWyHbwc=;
	b=KBJGCTRom1SyOXEqACIU0CAFMGdMYkLSafmDNNKVX64Dxo1mIIvnqWbEIpqZstWat4rUxz
	iDteMxTy9VNkDnjT13LqEvUM9R+m4OPGJriJQM7Xd+X/Zh+a17WPvS7mEnL+94O7Fy+FPF
	SsL+k0P9GLg9PQtcNa4A2RndgBQSOFA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-CK3eR8u9NrKuFnwKaw29DA-1; Thu, 18 Jul 2024 03:49:11 -0400
X-MC-Unique: CK3eR8u9NrKuFnwKaw29DA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3685b7bff66so52066f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721288950; x=1721893750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/jsSOpv/topEHxrEoKqtalPtg+NFFfMqa3rhWyHbwc=;
        b=kNQ+9kMkZYASiYTwYAgpZQJJRGQMwOyr4Va7HZ1sevDJnm6/2P0zWRRmt/7RZ8tx0c
         gAo1GPyPcJy8mKSh0lyWUWvYB74H08LqlkkVqkaHT7irnjVQBE6iSKv2s2Xszkde9r/y
         liZfBKxWjdDu0acxOD/6leAP5/V/A1w0KAzwc6jTphXb3JTaboqlhTYE5oLCtFCzfFNC
         BYwvGEl4oDy8dW7wPVk9cDdiEVmrI43k/TwZt7POLeOEw+3yFFQbGIzXPQA2rgSsf/bu
         B+58BMQ6b65Gsv1SQhmSMUrIDyzHPZIjUZ9DaUoSc7VOhK1qPwLWCNNnY4VRc4mQPtsB
         a3QA==
X-Forwarded-Encrypted: i=1; AJvYcCUtdVY5oSwhlGuz0L0lMEGvwwVlqoycZ32UM/6tli6n6UEgsQZba7QXYOHIUopjm0GG213Yo2Ygcdod9PycKDt7PXqWTTiqCcSCQqLX
X-Gm-Message-State: AOJu0Yyt/TwgwzE0z9qT0csjrk/dwaEwn49bijn5oov8zTmF4ZxhDQP7
	voh3YkzghI3vXIwlzMqilUeMsIInVMqsraI1rynMfBc+7ys/HBGGcLJxRxNyThw4f585FYwJtLi
	EqEkRuJGTErPPEKldCdeWd7nukcrodGE3ksyGDw85jCeXc7AfRstDCxVWen6K5w==
X-Received: by 2002:a5d:47ad:0:b0:35f:2929:8460 with SMTP id ffacd0b85a97d-368315faa3amr1829628f8f.3.1721288950277;
        Thu, 18 Jul 2024 00:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOwSqkFCBYl+vpRki2BkvTQtGbBhu58SwvtAjQh2OZiquk352S608BaeruDC7K5HwF2uKP1Q==
X-Received: by 2002:a5d:47ad:0:b0:35f:2929:8460 with SMTP id ffacd0b85a97d-368315faa3amr1829619f8f.3.1721288949787;
        Thu, 18 Jul 2024 00:49:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24? ([2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3c159sm901945e9.8.2024.07.18.00.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:49:09 -0700 (PDT)
Message-ID: <4d496d91-a83c-4ec6-ba69-ae594a50e45c@redhat.com>
Date: Thu, 18 Jul 2024 09:49:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str()
 on error
To: Tung Nguyen <tung.q.nguyen@endava.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Shigeru Yoshida <syoshida@redhat.com>,
 "jmaloy@redhat.com" <jmaloy@redhat.com>,
 "ying.xue@windriver.com" <ying.xue@windriver.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
 <AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240717.110353.1959442391771656779.syoshida@redhat.com>
 <AS5PR06MB8752F1B379BB6B90262C741CDBA32@AS5PR06MB8752.eurprd06.prod.outlook.com>
 <20240717083158.79ee4727@kernel.org>
 <AS5PR06MB8752E506B21D2922F7D08BE4DBAC2@AS5PR06MB8752.eurprd06.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <AS5PR06MB8752E506B21D2922F7D08BE4DBAC2@AS5PR06MB8752.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/24 03:30, Tung Nguyen wrote:
>>> Reviewed-by: Tung Nguyen <tung.q.nguyen@endava.com>
>>>
>>> The information in this email is confidential and may be legally privileged. ...
>>
>> What do you expect us to do with a review tag that has a two-paragraph legal license attached to it?
> Please ignore that disclaimer message. I am still asking help from my organization to remove that annoying message.

The unfortunate thing is that the message has legal implication which do 
not fit well with formal tags. If you can't trim the trailing message 
from your corporate account - I know it could be even very hard or 
impossible - please use a different account that you can control more 
easily for formal interaction on the ML.

Thanks,

Paolo


