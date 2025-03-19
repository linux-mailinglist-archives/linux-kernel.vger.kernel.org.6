Return-Path: <linux-kernel+bounces-568809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C440A69AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DD6423AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F222165E4;
	Wed, 19 Mar 2025 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyKfAYiH"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241421481D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418720; cv=none; b=r/MmbVoTP8iTASpthiCWyvp+EU0CI8h4CfVxuE3Q4qPFrC1QNXjaL3AT7Uak/IN21WpkeExelUYswM6PlbQhoz+Gw4mQWydqtc9vAg8VjhyhjWM2t854F4pN+3WXIBRB97xO0uBOFfo6xSn910Oago0KN6+wXOQI0CN1ujCJL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418720; c=relaxed/simple;
	bh=mHzkeamJAVirED9+PA9L2O3y8025Yf73WTQxHmfofNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd2njQjuEoGKotcNTW49u3NW3uvvV6+cRAkEu/0u/YslFBL80O7dmYjwcVjDGnZtDtaYlsF8hZCciD6NI3QWa6qeMNDBxONf6kO0WFCG+PvZOgFqypJJIU8VWKqKrB1bSBHxldrsk4EVSQLdoxNDNbY49pHFcwxm5G8N70/2LN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyKfAYiH; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e41e17645dso686216d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742418718; x=1743023518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzQ6ZEr1gpJCZD9/ARUm6ZtLa29Cm83+ahOdT49JFZM=;
        b=vyKfAYiHIJi3E/xeVEJKI0LrDu6O5be38jHBcKB0O/1LeRKLJmXdwV2rft/7cc0W2i
         GLtR+igTetV/DY50WXqbdLikHgrrKfrujNhXj+Aj7XPAjbYE6JZpE+npn29a1CY4/DMH
         GgzHwFOwnbo0GlgdLdkPVo73AGdFGBRzf5VxC64C3/bdYzl0E4RRBNBPBN4py1MsdUnk
         Q2W3eDcwYtnKIVHspinsw4qrmCc3E/v8dW8WpApqbq3kkDhplGee4ea9FMWNoWBDsDkB
         V966MRSlkR4qMWWRDprA6pvFOlFs1BNkYTdLvjjnfhPXMUDh1UaAZrRH2xA31bpKoozD
         Xdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418718; x=1743023518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzQ6ZEr1gpJCZD9/ARUm6ZtLa29Cm83+ahOdT49JFZM=;
        b=TJFjP2dd0hzGOI96E/FFHSdXxrXl2Qe/J0fYnJ5P+wHi2KYyEu4/qftFEJs8k5DmZG
         LfaIJKpnShZb7Br1N6ZBUWK64gkE2XhN/Z5USlLaFjbReO8XlfUgNlzCnG6MmI0/GSyz
         5a/tRinVCe7TcUqXjd6ejMTww4/LfbGtZLmeDhdEd1mcfVhNJMAfXMkjGhdwLfVmkVlP
         FMTx0ikkJtDlx8NfEBqtGKJYFZlyovyoRtZZ/91VrvBT1XbjPPEXZgpGy9W9CMj3p5g9
         D8XW2B+MtdFSvshnSgx09fyVP1ursSn1gc6ZhAuHXjA3r6QBst2V3dbJirucLjSuUZoG
         FB/w==
X-Forwarded-Encrypted: i=1; AJvYcCUtPq4UoQR+IF9aNTcNQTXA0IMC1sBJKoz40n30+QPd0TqLuw58JW0XyLi1u2RYQt/cpN7t0OlchGTZ3fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpaxCCarIpFufM93vmw8IzCLvm766S6cEwicFr61uDANKqjAvW
	sqPNPcy0Uj9JKNjbob+l5xw5WMiWB+ymKJELrm8PwFJnOzfOyHR8LgXWxjcW9hTI5LW6Pxc8/0q
	PuKAouJMU6e5ugjSkbMHZHlU9IVPPGjJMItsd
X-Gm-Gg: ASbGnctSteRKCvVkInK79rTpmMC8taCrOabhXwL62wyseJIgJL18unu+t9QCHJa2xfm
	wLvr8BWCIS1/mvXwLMK3VeTgna5u+DhnQsC1jIqNmC/44qtYtVLx2Js9I3TCPdS61hsdB4NqgO/
	hV5yRCj/U2nxt6YEtDqgmu/vzUKcRf2VMic8RYrDgKyy0d/5WC2izE1YH1SW1h
X-Google-Smtp-Source: AGHT+IGI0WFUFXKVZef1WwByRwZlBRHuGM1DviOdU10DZnONCKX8AFIG66ZYTPFgUbjuSNp1mcIIaop8R9piDbAczZ4=
X-Received: by 2002:ad4:5747:0:b0:6e8:86d3:be73 with SMTP id
 6a1803df08f44-6eb3538c672mr10615636d6.37.1742418717612; Wed, 19 Mar 2025
 14:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313192714.1380005-1-rmoar@google.com> <CABVgOS=Pfp2_ZvCtxy6X_xoM6pGVgT6bD_4VxGVZ_SNWVgesGQ@mail.gmail.com>
 <CA+i-1C3ZORa0hFHz=d6F3ThVWUEFv8Qnyq-i6EFsrn843fSOtw@mail.gmail.com>
In-Reply-To: <CA+i-1C3ZORa0hFHz=d6F3ThVWUEFv8Qnyq-i6EFsrn843fSOtw@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 19 Mar 2025 17:11:46 -0400
X-Gm-Features: AQ5f1JrFEqZICWggvDN9nQM3ZFvRMwPJ7oPNjINKbR3le5BHzjL9pyv2-L4Meq0
Message-ID: <CA+GJov4CDitQ0w2CU46rk_zwNxU_Mn1wwGNgn-xx3uA3MwDoRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: tool: Fix bug in parsing test plan
To: Brendan Jackman <jackmanb@google.com>
Cc: David Gow <davidgow@google.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 12:13=E2=80=AFPM Brendan Jackman <jackmanb@google.c=
om> wrote:
>
> On Fri, 14 Mar 2025 at 06:37, David Gow <davidgow@google.com> wrote:
> >
> > On Fri, 14 Mar 2025 at 03:27, Rae Moar <rmoar@google.com> wrote:
> > >
> > > A bug was identified where the KTAP below caused an infinite loop:
> > >
> > >  TAP version 13
> > >  ok 4 test_case
> > >  1..4
> > >
> > > The infinite loop was caused by the parser not parsing a test plan
> > > if following a test result line.
> > >
> > > Fix this bug by parsing test plan line to avoid the infinite loop.
>
> Hi Rae,
>
> With this change and this input:
>
> https://gist.githubusercontent.com/bjackman/220265699f346e16161c6534b1150=
19b/raw/a2e0e1aa75c0d8ab9814708b028ec78810a0471b/run_vmtests.sh.tap
>
> The infinite loop is gone, but it's still hallucinating a [CRASHED] resul=
t:
>
> [16:07:15] # SUMMARY: PASS=3D17 SKIP=3D0 FAIL=3D1
> [16:07:15] [CRASHED]
> ...
> [16:07:15] Testing complete. Ran 19 tests: passed: 17, failed: 1, crashed=
: 1

Hi! Thanks for the response. This is an interesting problem. Should a
test plan at the bottom cause a crash because no tests were found
after? Again with KTAP, a crash would make sense. I feel this example
demonstrates why there is a need for a general parser that can parse
kselftest output as well as KUnit.  I'll see how difficult it would be
to change the parser to accommodate removing the crash in a new
version. Thanks!

-Rae

