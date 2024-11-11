Return-Path: <linux-kernel+bounces-404254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A21D9C417B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBD6283481
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AE1A08C2;
	Mon, 11 Nov 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="PV4pGUhd"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497421E481
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337633; cv=none; b=PwMySUlQvvB6y87iD59z7hXB37H31hkkb6uhHIhPkQNgVIfIJoCgoIzsukFr1WhhMWfp8AlTSBMbQZa1SD/c77MZlgxB/ns0Ncvt6GFAIYpLfJQTtyan86mBOwZ6eMgw1k9Nd+z4jz2LWKiAp6DrzGSiS69Aozb2MC625F21Nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337633; c=relaxed/simple;
	bh=urF7+ZrvJb01w3jQbw0zJapXP5NGYyamAOImQFBwpt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyiCpnNQBLquHxmiA0z8o5uUrVwrZQmrVatRvsw+6bbur3H84QiD8FNzOBgJ3MR/wNlv4VUK8OwmtrBnfyA7tgg4b+SbISRN7RWJKwBNCR2m2wwXQwC+WeR9Kpm1c+sPho5sJ88wkGimJcSq+aiGK2c0rj2nQSDP0NUWBYsGRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=PV4pGUhd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-211a4682fcaso5071755ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1731337630; x=1731942430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pv2dsGLy5hlCQCQMw0mRaxqTomq041o04AFI/16zT3I=;
        b=PV4pGUhddsHcFzJ+vyyAQ6giPL2F6lEud7GBrzsakFXnILW/NKNMVNZGnV55iihicZ
         SosT9KiLWr2TgAlfC/J6o+ttbeZTjGLHg6YhsgGolVjZj1jyIwe5+PBe4Y61IaN3pnjq
         QkwRsWvB0j/wa+lx5S35TYk+IFBtCzNX78qmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731337630; x=1731942430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pv2dsGLy5hlCQCQMw0mRaxqTomq041o04AFI/16zT3I=;
        b=lRwlH+ZwCsIfPY5XuANa0DzNNBb1eoKJxn5U8jA+lrMHwfmNj6AEgJDIJ1Eia/kv9d
         DAbQ3rb/nRmk0FyUeNwP65rRBBsUCEPgMChMUhMlV21T44GZzafP0J7M7sdbX/An4FnF
         n6ytQ7WiqUtOenrbbMhRuZnBkPUroZvQ4+4e/RcwC8gyq9SwgExWs+5aJeV/eM41uEju
         PgQcrlBx3M0Q5gkmgaV5nacTosl4DBhm5WDNjWaTEXELdO1RDqvQMGQkgk+b2+P2AVyV
         u56mv7cVjznSdepl1noS4XS84QhnqX6hQC5fAg+G0RGbwlmV7yp6xUybEzDnKDQyX6+P
         XvwA==
X-Forwarded-Encrypted: i=1; AJvYcCXRYt2YiryLRoT7Lbu+Xgw9pF/RX6Bs6iMhIcl/LGoDnkELMPGWGS0mh9bVU6SHBdrMp2jNNYr9bWcVTzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdK3oA1A4Injyw52mVrX52MeKZLJmTR+f4OPAZs0dcCTzm9U/f
	tvPYhr4zZCKZYbfrQ7TLGsr8ozP4n/PHWlPDVRwa9kuTgNOHmvZNCkYtTLEIDp0=
X-Google-Smtp-Source: AGHT+IE/3RHLj44jfPFU+OP+sItz5ZLYB/FRD/A5nKaMuQaTLI3Nu/IGfIXNjgRWqWRSQGrK7OssHg==
X-Received: by 2002:a17:903:110c:b0:211:6b31:2f30 with SMTP id d9443c01a7336-211835ccb20mr180272005ad.50.1731337630325;
        Mon, 11 Nov 2024 07:07:10 -0800 (PST)
Received: from fedora ([103.3.204.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8287sm77078295ad.48.2024.11.11.07.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:07:09 -0800 (PST)
Date: Mon, 11 Nov 2024 20:36:58 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Jeongjun Park <aha310510@gmail.com>
Cc: devnull+manas18244.iiitd.ac.in@kernel.org, alibuda@linux.alibaba.com, 
	anupnewsmail@gmail.com, davem@davemloft.net, edumazet@google.com, 
	guwen@linux.alibaba.com, horms@kernel.org, jaka@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Subject: Re: [PATCH] Remove unused function parameter in __smc_diag_dump
Message-ID: <p2b37jlmexphoab2fohx6npcwfxx3cgajbn67taxbpqhh2qn42@m4fmmkihgm53>
References: <20241109-fix-oops-__smc_diag_dump-v1-1-1c55a3e54ad4@iiitd.ac.in>
 <20241111130439.7536-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20241111130439.7536-1-aha310510@gmail.com>

On 11.11.2024 22:04, Jeongjun Park wrote:
>Manas <devnull+manas18244.iiitd.ac.in@kernel.org> wrote:
>> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
>> There is only one instance of this function being called and its passed
>> with a NULL value in place of bc.
>>
>> Signed-off-by: Manas <manas18244@iiitd.ac.in>
>> ---
>> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
>> There is only one instance of this function being called and its passed
>> with a NULL value in place of bc.
>>
>> Though, the compiler (gcc) optimizes it. Looking at the object dump of
>> vmlinux (via `objdump -D vmlinux`), a new function clone
>> (__smc_diag_dump.constprop.0) is added which removes this parameter from
>> calling convention altogether.
>>
>> ffffffff8a701770 <__smc_diag_dump.constprop.0>:
>> ffffffff8a701770:       41 57                   push   %r15
>> ffffffff8a701772:       41 56                   push   %r14
>> ffffffff8a701774:       41 55                   push   %r13
>> ffffffff8a701776:       41 54                   push   %r12
>>
>> There are 5 parameters in original function, but in the cloned function
>> only 4.
>>
>> I believe this patch also fixes this oops bug[1], which arises in the
>> same function __smc_diag_dump. But I couldn't verify it further. Can
>> someone please test this?
>>
>> [1] https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
>
>Unfortunately, I tested it myself and this bug is still triggering. Basically,
>this bug is not triggered in normal situations, but triggered when a race
>condition occurs, so I think the root cause is somewhere else.
>
Thank you Jeongjun for reviewing this.

>> ---
>>  net/smc/smc_diag.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
>> index 6fdb2d96777ad704c394709ec845f9ddef5e599a..8f7bd40f475945171a0afa5a2cce12d9aa2b1eb4 100644
>> --- a/net/smc/smc_diag.c
>> +++ b/net/smc/smc_diag.c
>> @@ -71,8 +71,7 @@ static int smc_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
>>
>>  static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>>  			   struct netlink_callback *cb,
>> -			   const struct smc_diag_req *req,
>> -			   struct nlattr *bc)
>> +			   const struct smc_diag_req *req)
>>  {
>>  	struct smc_sock *smc = smc_sk(sk);
>>  	struct smc_diag_fallback fallback;
>> @@ -199,7 +198,6 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
>>  	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
>>  	struct net *net = sock_net(skb->sk);
>>  	int snum = cb_ctx->pos[p_type];
>> -	struct nlattr *bc = NULL;
>>  	struct hlist_head *head;
>>  	int rc = 0, num = 0;
>>  	struct sock *sk;
>> @@ -214,7 +212,7 @@ static int smc_diag_dump_proto(struct proto *prot, struct sk_buff *skb,
>>  			continue;
>>  		if (num < snum)
>>  			goto next;
>> -		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh), bc);
>> +		rc = __smc_diag_dump(sk, skb, cb, nlmsg_data(cb->nlh));
>>  		if (rc < 0)
>>  			goto out;
>>  next:
>>
>> ---
>> base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
>> change-id: 20241109-fix-oops-__smc_diag_dump-06ab3e9d39f4
>>
>> Best regards,
>> --
>> Manas <manas18244@iiitd.ac.in>

-- 
Manas

