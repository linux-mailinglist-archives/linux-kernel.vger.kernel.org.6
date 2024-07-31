Return-Path: <linux-kernel+bounces-268939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09F1942B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B41C20F58
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC24E1AC446;
	Wed, 31 Jul 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5fOdaPT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984571AB517
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419965; cv=none; b=upHJlEG5qHzzE0mHZTSB3AhVv1KH0cyi0K4Fzg/F5TbSeHRaD1FxC6d+qweSCdAwLyJz+qVQDGPtmVtgll7vT4/5fWE2MnaUevWXT/+5GeG0yice0ZqnEFrNbVMDAGPiuGTdsArwDd1JHz0Ei8ircJNjM4nNh1Lj8WLCtEKpTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419965; c=relaxed/simple;
	bh=4R4xX4AJXVbL/lVltFFMgiURfppUNJpanFd+OFoaQnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GJbObJMr3UXd6kQU4Dzkdt4BADscH3ezdyI7FCXxB0lOBp7q7Qj1jWdbUJxjGULAcUAjsuGDYuOKRvo8KR2tb3bwfRVQIijBx9kAZ/HiTTDrJLYLzXf0VcG1Zk0g9Da5DtccoArLyRvGiudf3/ry96NhTbMxDcjcnohj9MWz4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5fOdaPT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722419962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fK1g098iq4JAFSZ1OwoLqHTRasnFeG8nDHsMGLN1u3s=;
	b=F5fOdaPTeRERIKvAhmEcXQqPtk4OKBLCgJQVu6wR4IB9tPP2nHk49Oq1uGyjTmHm9+d+1m
	1XOr3QUYPPe4xCcVEhsmpqAPeJQHHof2rGhl7ycFbT8+8RPj/YRHR4jP9Wz/8Or5t57sJy
	2Vqaf8ech4Vsh5qiM+r5+YkKAoqm0LA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-QAy9DOmRMQ-W6OJjP6VEZQ-1; Wed, 31 Jul 2024 05:59:17 -0400
X-MC-Unique: QAy9DOmRMQ-W6OJjP6VEZQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee88b1c3e9so3699041fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419956; x=1723024756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK1g098iq4JAFSZ1OwoLqHTRasnFeG8nDHsMGLN1u3s=;
        b=v4c2Ik/cIIu52/N/ijvnGY4nPw7/THIlAinLs9x7vIPn0ZyBQwVUaBs1Zizf1ZcDJY
         +kknIme/d0Z5XONSaaXLKPoDAsNBzxcuwCe7Ax8JffuNdgadZ8aIX7wiUQYcBSfLcfJb
         vNeIthIpVT1hJDi/b1RV/K0M7DisMcW0etriyJV1EE3LP+fNxeiWzrVwKXLsgxWqt5bt
         nF8kAbCcVWvyEBKTPlArPDIoLy0siFGwFx3TiSK+V5JBjen6WjMPWQG8aT2eFfvKSMhD
         Nj0nObEoirkI8hz+CRU9YsvoqcQr2Ou0t67g68MUp76RH0/Plwx4tJyGgrn3klQn5QGK
         g9eA==
X-Forwarded-Encrypted: i=1; AJvYcCXjOL7dpFSkoPIb/l3ygC8sntbQc0jMhcvlNAcpwbhoLm4VakxfZ5lhaLLm2cy1P4R8qTOSHyh3S90JAm3EUYr7k0BE7Y6y2WwRtkcx
X-Gm-Message-State: AOJu0Yx3KBngXSXOYhKYFZxTyN+ZLlt9t14A4jiDOuHcCc040P008Eeb
	efpIxPfnX/A86OT7LQIcOn6zXDezq5HdI/1SHgqTd/rZwhTZ21mn2uJzTe0KLP/Fs58tb1G3Txn
	nsVLQuWlOKGnAz30pIuWGXPMWaKZWTeIsJY5sTkI9d268cDWGx3RouCDsHyJGHg==
X-Received: by 2002:a2e:7d0c:0:b0:2ef:80:a68c with SMTP id 38308e7fff4ca-2f03c7dc6b7mr69798381fa.8.1722419956323;
        Wed, 31 Jul 2024 02:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF17aCAzJBAn3plIADOp9HDwljSF8JNrYjS9kMfR+jYggbEfORU+MY3qApdGsfOXL1i/8ZbFw==
X-Received: by 2002:a2e:7d0c:0:b0:2ef:80:a68c with SMTP id 38308e7fff4ca-2f03c7dc6b7mr69798301fa.8.1722419955717;
        Wed, 31 Jul 2024 02:59:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e49bdsm16719478f8f.44.2024.07.31.02.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 02:59:15 -0700 (PDT)
Message-ID: <b1c0717f-2eff-4e97-a84f-3f25a697e48d@redhat.com>
Date: Wed, 31 Jul 2024 11:59:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una
To: syzbot <syzbot+5b3e7c7a0b77f0c03b0d@syzkaller.appspotmail.com>,
 cpaasch@apple.com, davem@davemloft.net, edumazet@google.com,
 geliang.tang@linux.dev, geliang@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000dce735061e8173dc@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <000000000000dce735061e8173dc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 04:00, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit fb7a0d334894206ae35f023a82cad5a290fd7386
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Mon Apr 29 18:00:31 2024 +0000
> 
>      mptcp: ensure snd_nxt is properly initialized on connect
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c8bdbd980000
> start commit:   4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=5b3e7c7a0b77f0c03b0d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fc9c8a180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d0cc1c180000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: mptcp: ensure snd_nxt is properly initialized on connect
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: mptcp: ensure snd_nxt is properly initialized on connect

oops, I forgot to do the required communication/accounting here, sorry!

Paolo


