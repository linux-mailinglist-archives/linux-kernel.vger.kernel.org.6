Return-Path: <linux-kernel+bounces-229871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DBC91755E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F531F23F78
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77238F47;
	Wed, 26 Jun 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCCplfjD"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6D15B7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363464; cv=none; b=TRfi3eq4eFGMXxSCnf6QC7vKvdVuXmfkrWjiGanIOjWlGiw5Vw4Sji+D7uWBDDN5dzuTNDR66Mg1MrvXMVr6X8wvuPiQN955NxNGIc81vfO6btd/DtvbCBtfKVZ5sLAbefkwT/fIqJiKecPNlCPM8hTpzFNS9mKjB8k6E3XXKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363464; c=relaxed/simple;
	bh=wiaMCSrHdxBJW9SZ6ycfbW8UjO1TnCLYQfsNKQjEvW4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IeTXybGPV55kwRvhXnFtmc/sV0+AwizUNIGwjxCvHG6jqlAIlIRbzkEbRBoNy85AyWt3d/+hi4V63k0sCIrtfBs/iXzb40As3HYVpaRGzplAJIhYn3IITrYG1TN9G5UcnXBw5cd9RWQSzHsgQ5YcbDu4iaVL3S73fIRW89FkTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCCplfjD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fa0f143b85so27861335ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719363462; x=1719968262; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiaMCSrHdxBJW9SZ6ycfbW8UjO1TnCLYQfsNKQjEvW4=;
        b=JCCplfjD/3cMBt4RZpJ6v7Bd/RbKzp/gGsXdbUHRAwBUco5Kmz3/g/Baajx0aJIVea
         kNp2hCmlBIThP1rmEvR5U2owU0ebUAexj9Ak7YL5Sr2CnU8l9WBxCQj9ijnf1EudGxYy
         vUTOgtUeIx7UVF3ndCjHdbkLvpvopj6WZ0Wxohrvv5b3LTwrPPGPcare/XVcYp4rQd8L
         +eWtlDEFMtluDT8jmMnVF7eNS29GOdpNKcFJRZAsgASWRmhKpeIOhYS9rqjmEQZWf3KK
         /X7OtZ61UINy2miuKAUbLtkFvl/bZE2mHgPWb5ZNx/GAb5xGslWY/S2b5blDw30VvQ7o
         NHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719363462; x=1719968262;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wiaMCSrHdxBJW9SZ6ycfbW8UjO1TnCLYQfsNKQjEvW4=;
        b=C/+BglPf7m+mUoxsATBthCXH2W3+lS2EzQ0WX7xwzEe60rai0V9Zq5qT8SIWHXnSO4
         dHAOvDq3TRFvO7zzzBDHKnkxMPGCnDCCyYlJxXoq9h8YUIqT1Qn1AAMjuIJTcgPZUf2S
         bq0OBXzjaJ/9N//s4U1KSpA6A9Q7xkyr2EnEwAwR4pee17C4qRlSXIWNwRs6fz7D0f+c
         wsArCCxvC9issVyhT1yRSGfsV7PwKKwZWdpwaSQPLZkecye9GV1ocagueJezovGLpUaw
         7JCSZrzs9iLWscoB09WRWrHBbn4F95ELy0M50MlQZ3PK0/RFObEgENEO3Adjs7p3f8nN
         6oxg==
X-Forwarded-Encrypted: i=1; AJvYcCUnAGPrLiAkxZFmKY/Wx/WoX+m1UaKiaSYSh7r1xcj1Cv7NdFf+4YpszV4O9WunJ6ishkfPhwA8brHGsYsvtpRdwU+miSeR44hTmVhl
X-Gm-Message-State: AOJu0YwN42G776u3Sm7Qo4mBmiN9R8ABrFLGIEFNaIr+ecjCVjP0IH2o
	9yBzDnp+UCq1G3snhiqy/KORabookIywDUwb9DGDY0B1WwDklQGW
X-Google-Smtp-Source: AGHT+IHc0u4NsTR0B9PIDm6WQFVKU0PLA5sPYuuqX5YES52pMViGLLTNC9m6hju2KQs+XfeDv0uNgA==
X-Received: by 2002:a17:90b:1a8a:b0:2c8:452d:e634 with SMTP id 98e67ed59e1d1-2c8614355b0mr6359968a91.45.1719363461958;
        Tue, 25 Jun 2024 17:57:41 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d8060fbesm267738a91.26.2024.06.25.17.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 17:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jun 2024 10:57:36 +1000
Message-Id: <D29JH7VL4HH7.3FSD747K8GPF@gmail.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>, "Srikar Dronamraju"
 <srikar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Fix scalability problem in workqueue watchdog touch
 caused by stop_machine
From: "Nicholas Piggin" <npiggin@gmail.com>
To: <paulmck@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240625114249.289014-1-npiggin@gmail.com>
 <9d1d4a41-fcdb-448c-9a0f-bc9909193fa9@paulmck-laptop>
In-Reply-To: <9d1d4a41-fcdb-448c-9a0f-bc9909193fa9@paulmck-laptop>

On Wed Jun 26, 2024 at 12:53 AM AEST, Paul E. McKenney wrote:
> On Tue, Jun 25, 2024 at 09:42:43PM +1000, Nicholas Piggin wrote:
> > Here are a few patches to fix a lockup caused by very slow progress due
> > to a scalability problem in workqueue watchdog touch being hammered by
> > thousands of CPUs in multi_cpu_stop. Patch 2 is the fix.
> >=20
> > I did notice when making a microbenchmark reproducer that the RCU call
> > was actually also causing slowdowns. Not nearly so bad as the workqueue
> > touch, but workqueue queueing of dummy jobs slowed down by a factor of
> > several times when lots of other CPUs were making
> > rcu_momentary_dyntick_idle() calls. So I did the stop_machine patches t=
o
> > reduce that. So those patches 3,4 are independent of the first two and
> > can go in any order.
>
> For the series:
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Oh, it did get a comment :) Thanks Paul. Not sure who owns the
multi_cpu_stop loop, Tejun and Peter I guess but that was 10+
years ago :P

I might ask Andrew if he would take patches 3-4, if there are
no objections.

Thanks,
Nick

