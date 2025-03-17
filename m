Return-Path: <linux-kernel+bounces-564580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1782EA657B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14A21624E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6E192D8A;
	Mon, 17 Mar 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="244yvZmO"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48E1EA73
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228005; cv=none; b=JTbNRjOrcXY9HMpwdYR/5lALizAQKxZ5IotrUNjA22Qfdwoege4JSDpAsA7/NLIjsSq2QfhS24JbyN9WgOm8zsyKlBWPXVLwBsTcfrZY/lB6TPYKbghbdMehCay567QFYJgyh6tbbmo6AK1met4xxgrHbvEKgh5bFTGA5/METt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228005; c=relaxed/simple;
	bh=Qtz7p+qAYY/3PwQbatf+dww5SC/v5fIM77DIa/Z35C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5nKIZF3GpL6wiC5ay7KHdwPhSQbblRrnWcmOQf8VwKn9oN1dAb/GZ8SN41UeJklFrv4LKDDWgV2qPW7mK+Uv5SUYdcUoPm3jVBvIt/lPwf+vkDWQKHrxzeX2Hia33U9gWw49FNr4zfqcSrYcuLX2p178OphJbUuKrCHOMfv8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=244yvZmO; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47681dba807so38981cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742228003; x=1742832803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DUp3Sy0r3ex2clGVuTENijtSpkjkLtkEQ986ciUiGnE=;
        b=244yvZmO1UdZ9IzqLTD2r3OKzynuX8pHzPZDOjyQJcuHKkNKpPovBwGieqaEOyNcel
         SF8fG0djMEDPHe0o+ClynVvdghs2KFFNiQwTZyL+yOqOlFG3FtJh3BqMIF5xpT4ff6KF
         bDex6XBMXnhPrbeV+pxljLJcwtF2V6/nEhZC6NVv+9IhOyySFzCXMIe6NYmXA6vM4lVU
         ziI39lvP4X5KGNZSwPSiaDKVZa3ab8wFeMTjxaDZxcGVAA4ZM4khSCNcpWF5oRG7Gj1W
         AF9UZ92i7Y5NmcsiDzB+PBla33szzHM826BwAD6AQIKYnuSmzKvV7Mk1/vOFBKtvY/3K
         pO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742228003; x=1742832803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUp3Sy0r3ex2clGVuTENijtSpkjkLtkEQ986ciUiGnE=;
        b=uI7xazg+Fd/gvrQxgo+XU/xGzP8kPRSwQuMU0P7jyM86PnP9FX7+GwSqUrgfTLsZBX
         ylM41CtK0mhccbfC1AwakvsJCvXfnNAz4vHVniMGyfslJdY+K12AfEh4oMy2pPaeeo9M
         Hl1nQ/xhqcI95+zE1HNu21HkOiwFUcuD4f68Y16+GTYhIfgypoQwDj5EJDjX4ive5aba
         O1ekF2mCvttf2wTrEj25a69esl2stP3rvo0GaCpl2voC8c27cEtp8JxcDpQZi3RlfmtM
         l2LnOfhWXzsPdKhl2aNr/njMQLvPpuDRQXN6nKzin9+tevY8fPGygX0vvu1clLbuaICv
         rFJw==
X-Forwarded-Encrypted: i=1; AJvYcCWC+p8OLqKuPNvA955cbZTeLeJ4YmY2XTaaCuQu9sUrFb/Jrs07VN/5LxFhUYblyTX7U/4Y/9fISesSZf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0GUlzL48Kh9o4bqWGJZzX1NXQew5F/stcaPxp2e2Sc4n9Xv1f
	2tI3B7+kGiuVX3O56kZPhAWYViA90QQ+Swb5Aliep4XxqcPp4+mUNwEF73BO2hCaAUiPB22UI61
	VVh494zALd3F9gkWcHAH7G2KvSa1ue01IsJ5S
X-Gm-Gg: ASbGncuIWaKtXr8DkmAKAxsZselR9AOUNEEcgTwfaaNokBQscjGImt4hgrySVqMAOuG
	dB46ESidgo4TAbfSxvZizOF7BoswGNz7AsuQhjCzi1PY14naAM8X6DHXPbPpaLOf05oxWC2WUha
	B7fHIx31S05RSCDEIvdXMSZtngMGvOnb5Aut4L8Pmn/3qrahF2plen+qH/vA5mL6In0/A=
X-Google-Smtp-Source: AGHT+IGp5T+nbwvj2pnhzXY0OLK0W4OOqrMBHMsVJ2shuSCrVzln5u4AgmKzFlSy+b1LEmAE3f37cTri0Z6r5gpSokw=
X-Received: by 2002:a05:622a:2303:b0:475:1410:2ca3 with SMTP id
 d75a77b69052e-476d6455973mr7438041cf.15.1742228003130; Mon, 17 Mar 2025
 09:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313192714.1380005-1-rmoar@google.com> <CABVgOS=Pfp2_ZvCtxy6X_xoM6pGVgT6bD_4VxGVZ_SNWVgesGQ@mail.gmail.com>
In-Reply-To: <CABVgOS=Pfp2_ZvCtxy6X_xoM6pGVgT6bD_4VxGVZ_SNWVgesGQ@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 17 Mar 2025 17:13:11 +0100
X-Gm-Features: AQ5f1Jop9b3Sam9E4Aqkea8e1CkU7NpyiiWCx4vud9QYvcgrDCB3PeJx7vj9eNc
Message-ID: <CA+i-1C3ZORa0hFHz=d6F3ThVWUEFv8Qnyq-i6EFsrn843fSOtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: tool: Fix bug in parsing test plan
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 06:37, David Gow <davidgow@google.com> wrote:
>
> On Fri, 14 Mar 2025 at 03:27, Rae Moar <rmoar@google.com> wrote:
> >
> > A bug was identified where the KTAP below caused an infinite loop:
> >
> >  TAP version 13
> >  ok 4 test_case
> >  1..4
> >
> > The infinite loop was caused by the parser not parsing a test plan
> > if following a test result line.
> >
> > Fix this bug by parsing test plan line to avoid the infinite loop.

Hi Rae,

With this change and this input:

https://gist.githubusercontent.com/bjackman/220265699f346e16161c6534b115019b/raw/a2e0e1aa75c0d8ab9814708b028ec78810a0471b/run_vmtests.sh.tap

The infinite loop is gone, but it's still hallucinating a [CRASHED] result:

[16:07:15] # SUMMARY: PASS=17 SKIP=0 FAIL=1
[16:07:15] [CRASHED]
...
[16:07:15] Testing complete. Ran 19 tests: passed: 17, failed: 1, crashed: 1

