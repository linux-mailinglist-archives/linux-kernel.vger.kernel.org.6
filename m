Return-Path: <linux-kernel+bounces-194671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF988D3FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9A9283914
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568361C8FB4;
	Wed, 29 May 2024 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6SAQqVB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BABE1667DC
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015358; cv=none; b=aDX7/a1oOOrk3XlK+9OybVlhO5/Ex1Po5fDcJbT/8+YQ/Jl1aYI77vt2gNm3qBtOdjvi/lDRKdvQdbl9SGKTnxzDxX+EQDQ2GVfMjiBKnEdS/C5zGMkYsVa01H4/RSMR4nNKdfnJ2cvww5BwxkjXQZF7NOzhqw0TW7mqlsqZB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015358; c=relaxed/simple;
	bh=kRnV8TdpAAzmsRqoJw0zXYQjlaCP2Cs+nOeOuqf0XiI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qOp8nkdKZip+vO9YsvGTwyAF0dMKD12s3anjzShec1xwwP1ChK06dk6rFPC0GRJON3yP4k4W4SRY+gLvGYMRxMSJ8O/Jzq5W39e7AMzKkxquc6cWTC1J9wnY5qVrOBA49ws1z/eqXnbFE6EQU9QMgUlpqoMK/d2Z6zQqUZTCngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6SAQqVB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717015355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUVJ3fbNLwOwh+kwklXiSY2q2oGK1D3qkvu9GcJ3p7o=;
	b=P6SAQqVBs/ibV1KglL2Lj/GF1RA/rWBHaQa4so43BE9aAwkZriKz6+IQQzQBD7KjYBkpPm
	tCXYZahSp+17n3xYvGLfgecDyLKmRu5FJspRYnTFTXJ9x0/AtxNZtwo7C4X7nBhKEekGVc
	zRXxn80fxNwnK/s5y7HI4nTG0YTN+qE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-xD75_HeLMgC8LL4m6CaGow-1; Wed, 29 May 2024 16:42:34 -0400
X-MC-Unique: xD75_HeLMgC8LL4m6CaGow-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f6174cfcf8so1815715ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717015352; x=1717620152;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUVJ3fbNLwOwh+kwklXiSY2q2oGK1D3qkvu9GcJ3p7o=;
        b=RL1fBhf9vAxCldmMbC8sjJ/VwX6ai/oZcNg/44ecB2xu5syhF4kWMvE/xLEadKbL5A
         Wlr1QI7dYjbyo9ZrX/FKUTa3+epTbVFIrv7AiSukXMPgZMUI8KWCQh8Rv/RyZooha4sw
         cMnhdufURfXqx048YJk4Azb00ZRUxv6c7H+s/xWOwaWT6Nkjv9jeDXBGrK/xbrdG80zO
         epWSo5/Lt8sPYTWe+6BYS0vbwGeNb9+FP+MCN2B9BIp+4Gvqvwl/+s/s1pJHu5nxNAX4
         f1O99MzUSqjEeRhZFVGQmJnVhlCA9tOWXx9XpDcXmy7hksXvsCxP114kF3WH43zWnWrj
         dXeA==
X-Forwarded-Encrypted: i=1; AJvYcCVQftYYT2HVQVUJJJXCLXxVBX95foNg7FlQ15vnt5lksGJGLHzex2Z1gVxyBPmyD2ZFjP5GWS1+ulER1bIVYpatB9PR7XZvtl8JtaGb
X-Gm-Message-State: AOJu0YxkS6gsM+OKOLy/DPMziJjA1NfFqSzXLrhVoFUukWilPp3c1RXK
	1Vvjh2EXnkdTrHKTlh2qd8S3/AUN6S80Wyqy6QUl9Z8Lmtyze49Kiy/T3nzlxODJriGNg3s+OW7
	edZ8VoDptPlC9c7hXtqNVkQzCSmqYPtARQwuyw6atQgAeHPIvR9tOfEvXUNYeycQ1X/CD
X-Received: by 2002:a17:902:d487:b0:1f3:964:bb7c with SMTP id d9443c01a7336-1f619b2ca1dmr1365475ad.57.1717015352433;
        Wed, 29 May 2024 13:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6sdrN8Jvq/Qmloiy0EOHk78bp4D0qaaCWvMgN7KEA8n+4SbRL6d5bFRuikU9OGpXDn5nNvA==
X-Received: by 2002:a17:902:d487:b0:1f3:964:bb7c with SMTP id d9443c01a7336-1f619b2ca1dmr1365195ad.57.1717015351952;
        Wed, 29 May 2024 13:42:31 -0700 (PDT)
Received: from ?IPV6:2001:569:7cd6:cc00:99d0:471c:5800:8739? ([2001:569:7cd6:cc00:99d0:471c:5800:8739])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6176325e3sm1571965ad.165.2024.05.29.13.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 13:42:31 -0700 (PDT)
Message-ID: <21c943fc-f82a-4dd2-ab86-3e31ed8ab1ef@redhat.com>
Date: Wed, 29 May 2024 13:42:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Adam Williamson <awilliam@redhat.com>
Subject: Re: Intermittent inability to type in graphical Plymouth on UEFI VMs
 since kernel 6.9
Content-Language: en-CA
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org
Cc: jforbes@redhat.com, rstrode@redhat.com
References: <75c17881-68e9-40e7-821c-5655d49d7c0f@redhat.com>
 <8fee69cc8fdd67fd265790c0fa287cb9566c2349.camel@sapience.com>
 <165f7cfd-41bc-4c37-b859-a418a3ccece7@leemhuis.info>
 <c5b3d3ec7701b51dd7b163261c84fb54c778b9bb.camel@sapience.com>
 <8c460997-f8ff-4985-9e8a-09697a647a28@redhat.com>
 <1e38a2b9-ca88-4497-b2b3-2157dd83e479@leemhuis.info>
Organization: Red Hat
In-Reply-To: <1e38a2b9-ca88-4497-b2b3-2157dd83e479@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-05-29 10:12, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 29.05.24 17:09, Adam Williamson wrote:
>> On 2024-05-29 06:35, Genes Lists wrote:
>>> On Wed, 2024-05-29 at 15:01 +0200, Linux regression tracking (Thorsten
>>> Leemhuis) wrote:
>>>>>
>>>>>       cpu i9-12900K  / Raptor Lake-P [Iris Xe Graphics]
>>>
>>>     Sorry, this should be:  13th Gen Intel(R) Core(TM) i7-1360P
>>>>
>>>> Does this happen every boot or only sometimes? Could you maybe upload
>>>> the full dmesg from a boot where things worked and one where only the
>>>
>>> For me it is every boot - the first few key strokes are accepted but no
>>> asterisks are displayed - and it works fine even though fewer asterisks
>>> are displayed than characters typed.
>>
>> That sounds different from my case.
> 
> Hmm, bummer. That might have made things a lot easier...

Well, it turns out I can reproduce this fairly easily in a VM on my 
regular laptop, which helps a bit. I've attached some logs to the 
downstream bug at https://bugzilla.redhat.com/show_bug.cgi?id=2274770 , 
and Ray is taking a look at it ATM. More eyes appreciated.
-- 
Adam Williamson (he/him/his)
Fedora QA
Fedora Chat: @adamwill:fedora.im | Mastodon: @adamw@fosstodon.org
https://www.happyassassin.net


