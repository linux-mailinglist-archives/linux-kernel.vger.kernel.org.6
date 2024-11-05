Return-Path: <linux-kernel+bounces-396244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D46B9BC9E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAAD1F230F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D011D1745;
	Tue,  5 Nov 2024 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJasH6dn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2AF1CCB46
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801043; cv=none; b=ol6ut77OPinslHHL7VFjuf/i9N7VTgJnvlU3rOwZmu+K035uvM6UflyiWvp4rmafQujPujVTXd0yNxSQSSMrj/QajxQZ2WzHTNglbYN5HsjD0TnbkCxafDUdSlpIEClnnqksXtYBpP2TTnGCke+cT+XRWi0ua5vI0CILBzI3Iys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801043; c=relaxed/simple;
	bh=h+lVlv4v4kFhN60Y7uN6+mlTtYtzZfrbtQ0cnBBKEdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7LTuE2q3/PNOs1uDJZ6DghgRfpjNHFvQyN+tJRin6h04UTkVNBPDUQLzoHl66yqqIoIpS3uqExdGm3Y+Wo66ZJXYDEn+8H6uy87yj6Mr8z2aA2xVSKI3Ue1nJjGR9DVaHfAl3NidIIypYtqkdKheOjmfyp6d691OqkrSg/6fVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJasH6dn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730801040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fTSKKdEnBx5rNtqdwW2TR8ocPd2sPuXo5XqxbGsjrE=;
	b=PJasH6dnqKkmzS+5XzMT/y3hqSWNdqnMeX33NYfhTUVx8+5zEIClUQtY3kjOppJpYQ/Wno
	yE7gSN8aKqQ9f6liiK6TgCb3BgK2WfU2voUR9JL4v4lkaYElK+MpIKtptHGGOnQJXBDNH0
	dj4nbiUZcHCmtTAx6t+pbuT+NN/sgRk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-SJqywM_OPuySwnK64pmafA-1; Tue, 05 Nov 2024 05:03:59 -0500
X-MC-Unique: SJqywM_OPuySwnK64pmafA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-381d0582ad3so2178092f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730801038; x=1731405838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fTSKKdEnBx5rNtqdwW2TR8ocPd2sPuXo5XqxbGsjrE=;
        b=fnA2mq9cyxrjkUEAkTtVMYra8LsJLnDrCgpNWndDlg+R2dHlLjxrg6/61fWT0T7mIy
         jg7570s+cnFmeXoZedGDtkRnXsE+h/XpaXvQl+IyC85nh+a2iVGOTArjmi8V4gEnIQYV
         mZzJ4gPH6GnXCvy9JSJW1bvLyqYcLHxzBcpYbvMYk72FtYMNS7v3JMgsGmIgalJkoDB4
         qbfswTIwOhmx9udyY8YYCUQFG6CgDlS45M29MxlAHXYiSBN8EUFjHnobMr8liWguSVj4
         jyYi5dPYnuPrfmuzxHtMehsjuN5Qof/OGyVNzJHbhwpfqvn7tA3zeMzUvpz6KLP6fKmL
         mrbA==
X-Forwarded-Encrypted: i=1; AJvYcCUBfT6wRabm3+QLXPYfxAnPNjPya8Wu2ke4Vucb+Hq2A+kB0QL28m6mgG4xadqkHQY3ZL2RqvSkqznNdeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDKADbCZAGwvyj3UwtIvXcmyUPhDpsXAup1rqam5O3EhF4c1G
	RGqCvo/smtwj5H6i0HW7wnfNM8Km1fd5H/d1PpbFeSNg/H3ROCQn0w7PYMU9yHbH0qkIhVavRPu
	0Z3Ophn6DtzdhZv8DhlwnwK6ETZRCtuUctXbP59iNL7APGHkN6L0scKlmR7oOfw==
X-Received: by 2002:a5d:6d0e:0:b0:37d:612c:5e43 with SMTP id ffacd0b85a97d-381c79737c7mr17614318f8f.0.1730801038382;
        Tue, 05 Nov 2024 02:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5+ZA7Cgp9oNVpemsCU9kPyu7wz//Ai6PjAUKnrwmGHPvQU4tJd+dwYLWosUIaPd5NLGFBIQ==
X-Received: by 2002:a5d:6d0e:0:b0:37d:612c:5e43 with SMTP id ffacd0b85a97d-381c79737c7mr17614283f8f.0.1730801037971;
        Tue, 05 Nov 2024 02:03:57 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b80sm15833061f8f.10.2024.11.05.02.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:03:57 -0800 (PST)
Message-ID: <3664acbd-6468-4ec0-946b-f6d8494e4a75@redhat.com>
Date: Tue, 5 Nov 2024 11:03:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
To: David Ahern <dsahern@gmail.com>,
 Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
 netdev@vger.kernel.org
Cc: adrian.oliver@menlosecurity.com, Adrian Oliver <kernel@aoliver.ca>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Ido Schimmel <idosch@idosch.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025073003.2079945-1-omid.ehtemamhaghighi@menlosecurity.com>
 <0dc8c829-23f0-4904-8017-fc98c079f0ab@redhat.com>
 <7ae73a73-fba4-4692-97df-1a88ccc5f576@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7ae73a73-fba4-4692-97df-1a88ccc5f576@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 15:10, David Ahern wrote:
> On 10/31/24 4:13 AM, Paolo Abeni wrote:
>> Given the issue is long-standing, and the fix is somewhat invasive, I
>> suggest steering this patch on net-next.
> 
> FWIW, I think net-next is best.

Should I count the above as a formal ack? :-P

FWIW, I went through the patch as thoroughly as I could and LGTM, but it
does not apply (anymore?) to net-next.

@Omid: could you please rebase it on top of net-next and resend (with a
proper net-next tag)?

Thanks!

Paolo


