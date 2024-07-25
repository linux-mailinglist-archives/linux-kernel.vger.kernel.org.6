Return-Path: <linux-kernel+bounces-262426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44EA93C6F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DED72813CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DDB19D890;
	Thu, 25 Jul 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTgRSOFA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053519B584
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923677; cv=none; b=KOtt9Xtr/mhsse3sduRjFHdy11vQMUlAr/kGyl57sNelTqi61VK2AbRWIIO6Bc/SOvs/T81VvWADlI9cxFcAoWKLX8NrgdNkf3CQmbI7JWOxJNFXwnNIZC/cRKmP9M7hCi8wxfPj3fcY5UBb3l5i8CRbD2YtyDOoo/UJP/EoQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923677; c=relaxed/simple;
	bh=HX1DqGzOhxp/qoGBFu0letQeiiqLQQ3PtazzR6jqRqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OoksvzNIoqpS9WVb0XntscKPTrlj21frS1dKPw5wcki4i/ZrPwLTCIuiae3Q8+0lfGQf8IiP3RGWe0gMfdEcVQl4maB9GjW0S7h5+ydWw6487F7CZ76o8tQNdanvQOXBj3GRNqBHOXIQw/Y+m2I/yWUIUW+m/1zdQeh5ypBSvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTgRSOFA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721923674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HX1DqGzOhxp/qoGBFu0letQeiiqLQQ3PtazzR6jqRqQ=;
	b=hTgRSOFAbV6VoTsGA1ei47yBia5wh/GsBfwHPRKK9/ohBy7letBi3hq2vFJjoNIU2JWEwH
	/vGHqeqBbFOvaRhixUuPHS/cjIlls0D4yJVqifgWsbelWdKOPUVgmxPIuI/eqcirft0hUh
	zpsBb0EEiWp4CtQ64hj+MrMk92OMftU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-sTHX4Z6WOWKRzpV7Wk8vow-1; Thu, 25 Jul 2024 12:07:52 -0400
X-MC-Unique: sTHX4Z6WOWKRzpV7Wk8vow-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3686d709f6dso704340f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721923671; x=1722528471;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX1DqGzOhxp/qoGBFu0letQeiiqLQQ3PtazzR6jqRqQ=;
        b=PgkQcg51xLH3VyIwn8NAI6+CT2ZDyiAHolgDuj14pGE72xA1l2b1GwC+bVFcisTqjc
         MM0YZqbB4Y5VzFU3R0reLN3crpelNZb6gukvr8ps41eT6sy3MjvaY8QfsuSEWsCIVISz
         GwmyLjt4eKUZCFerFI/ImIClxkzUs3eTkTX9ejRbq6BrudQL4/ngNf8+4gJeQidKFix8
         ep4CTTqAmC+a+PNjOmQ+1i8/rJu/0yG9a40LSbv6BpJr9kxgGE7XDz3biFTqFiMfoGzG
         rYB72o2t6PdX8WGZOWQPAgkpUTvSQ/BRejTKEZCG7LBWSS5dw9Ta8X9Npuy0kfiLwi+f
         sf3A==
X-Forwarded-Encrypted: i=1; AJvYcCX5herw1U3oCrMApm5uzr6NfwD1R8179IM7AU2TXe2zYOIYyCS5mdqcKvUY1in2liTkP/w4RJCYBkt0yAStoDI/TxzDUaal7fMELMjQ
X-Gm-Message-State: AOJu0YykVSdsL89C+yJeSoFvxScmTboxZG/9L0Rlq8ttw/R0TAPpaaL9
	nfO/Rc1aSRAifPCwEh7hujIyx7X4ipZxmLEgz+7iCJflp3GvXO4txnymW24aVDXSbs10pnb7kaQ
	sIvQjwU4LLDbIMz2hRVLmilE0rwuzIhYHvluu5DL1XJaeC+NmGlwILRONkuukxQ==
X-Received: by 2002:adf:e94a:0:b0:368:6633:c547 with SMTP id ffacd0b85a97d-36b31a12d14mr2146389f8f.37.1721923671361;
        Thu, 25 Jul 2024 09:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYK6ivvJkWkwIY3PX9kuYwoZq84Qv2MFI+lcEayNc1zjKj7tcG2Wz14ZdpaX1W8iVAY7kxUA==
X-Received: by 2002:adf:e94a:0:b0:368:6633:c547 with SMTP id ffacd0b85a97d-36b31a12d14mr2146368f8f.37.1721923671007;
        Thu, 25 Jul 2024 09:07:51 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d95c7sm2622945f8f.37.2024.07.25.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 09:07:50 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Neeraj Upadhyay
 <quic_neeraju@quicinc.com>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 00/25] context_tracking, rcu: Spring cleaning of
 dynticks references
In-Reply-To: <20240725152212.GA927726@neeraj.linux>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240725152212.GA927726@neeraj.linux>
Date: Thu, 25 Jul 2024 18:07:49 +0200
Message-ID: <xhsmh7cd9zc8a.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25/07/24 20:52, Neeraj Upadhyay wrote:
> On Wed, Jul 24, 2024 at 04:43:00PM +0200, Valentin Schneider wrote:
>> Git info
>> ========
>>
>> The series is based on rcu/next at:
>> f395ae346be5 ("Merge branches 'doc.2024.06.06a', 'fixes.2024.06.06a', 'mb.2024.06.03a', 'nocb.2024.06.03a', 'rcu-tasks.2024.06.06a' and 'rcutorture.2024.06.06a' into HEAD")
>>
>
> Hi Valentin,
>
> I see that this series is based on paulmck/linux-rcu.git next branch,
> whereas the RCU tree has moved to shared tree now [1] and the next
> branch there is pulled for v6.11 (tag: rcu.2024.07.12a). I get merge
> conflicts while applying it. Can you please rebase?
>

My bad, thanks for pointing this out!


