Return-Path: <linux-kernel+bounces-566970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AFAA67F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38257881C17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518C72063D5;
	Tue, 18 Mar 2025 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgONd1RK"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F721EB5CE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335171; cv=none; b=atCgEVm9GCpBE9kCL467TcIWjEhczPRWrGFL/qatBn7sJIl/Um5FHNRg1evjr33t+B55bdQw2t5JLhbAEzJ9/1ohPPN6bVhnaIA7rqNCCu+0oybBJedmWPRYwI/5p0uQeA6Rzd3L3NKNESjV2nr6F9Zu3aOHWt1/kWfhJp3g92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335171; c=relaxed/simple;
	bh=J+RwIn+7rMGpsXhDK1Id/K3rfnEmr8WpGCyfcADIsMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYHu2CjGSTOXnmSexyGVevjc6r1XT0CgikDYOF2bWNtbhxcJB2UtS0kR2rQsSmzm+Ol/HYfJTNqurpbv6PILreXvdrYeKhyd8zbYCdASl2jESKo3YS8MfxiMkDI6CYFAwfh6Ix/sUNSxCYOZaRjm7BuWMcpL9Q1NhXqEaobFmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgONd1RK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39127512371so3724599f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742335168; x=1742939968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfPZ+fHxZvGK/nwG8fpDWe3bPSXaRKE4oj9fvcdS3mY=;
        b=PgONd1RKh1TVykjYMMdjqd94/6QD1une1U8GuKAr0DQZxc2dlz9WIDomsNwxXXkRxH
         t5eIrI4GS2QNxluk7KXbKZa1XZoSBpoZfau2GjtkrWqrgmdjd3o0trcStMgJ/MKY+kY3
         8hGb+jPOOODFVqgujOenTSUbZ5+670KZG9b6abKkkgGfaLQuJd52ppbi3mnRy1kPnXwo
         KoFj2kCik2Ig0/BQpLJJf48P/PRYo/wicck/IDFIoTwAdEn3FLRk2uVZb5IvZMAPJrh/
         TCd1QN4weAHgCwR73OO+FFf2qPbvb+2+aTA708OESndX1VVo3fNazUrJU/Ecr3SH7SVd
         wQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742335168; x=1742939968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfPZ+fHxZvGK/nwG8fpDWe3bPSXaRKE4oj9fvcdS3mY=;
        b=kztdJTkzriduKtvCr+B3blN7uGfPCNMt6Qv7iVn2pW8Nfdsnt9Rsmbm6dSRe3lWrv2
         llFstm5kroY9S7KmNzEQY2kuLCGdgVuqBc3VnLrDHo2kBY2IGHxL8WNwnYEjP8z1A2UR
         Ia/tBp3QKk1zy8ukHsjMqUYt4PjFqZh6SJYZr74EZ93u4AP5dncrLblQUM5k/kZB7lOt
         3waWY5y3UNtSlWf4QLs6u9x2mLhSZ0ejwq5sCc8cQpzCe/XR5XltgLYo1ZkXuE0gOFM+
         UwKFlIwPuZeQN6x7btW0fyI4GJ1rB6ARm3bKL3/tITPwNz5XM0l5RMsqeZwyUnbNGsO/
         CGqA==
X-Forwarded-Encrypted: i=1; AJvYcCX6qvkHU6jhP8wu6DGvWmlz0aXvoB3qobxMrKiDLv6FGdwKppqeTzMpGQk/XgacHO9ypddrJKmM2A6y/lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylLORhAceMBfKlUsU6YddP4Mgo7W21X5M1lkpHgzEMYcXYYsZk
	J4p9aLp6Zrk5mkaJ4ZkpnnumSJwbkQ+Uu9SaCH+FYa1+LqtGtLLC
X-Gm-Gg: ASbGnctCrv4XV2uR7XAWRvj5vX2rZ+2SuivqPXuUs1TQ6vlvhoKzAS/YpBZuJhFjJ9X
	QxPp9j9g/H5fWW08hA7Lom19WWmtdTG/HhsYYAt0QcQiRCOII5wmlJlmS3SmPY6ADKEo/Ck4NGD
	oT5rdMWzgdcJtfzwIk1wjCZbRYpggoaiJyfvvxejQpJvYWf0XnjzCnAJYmdXmP67/5s1SrHLnkG
	3IsiA2LHXl3yrFOTlgS5IIUYFC//PNXmo7Wf+8z4GVTR0jTx2cSo4pZS2FO7rq1sZEuQDfOXKdN
	F+TEu9fIzO3qHs3z8BGjfEfjHOjG6uUEEMWkgm6lBXzShc0991nwg9VCERdFeb5NezG7iiQxJCk
	prqi0Trc=
X-Google-Smtp-Source: AGHT+IHM9TfewnEfF4zAaJeMDyRFIqMfUIUwW2g53/zJYvJWvFPkONBpFCs6bmCxjma8zAKe2siMzQ==
X-Received: by 2002:a05:6000:186b:b0:391:2a9f:2fcb with SMTP id ffacd0b85a97d-39973b028a9mr237501f8f.36.1742335168027;
        Tue, 18 Mar 2025 14:59:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a5fsm19557008f8f.79.2025.03.18.14.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 14:59:27 -0700 (PDT)
Date: Tue, 18 Mar 2025 21:59:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Herton Krzesinski <hkrzesin@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, x86@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, olichtne@redhat.com, atomasov@redhat.com,
 aokuliar@redhat.com
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8
 bytes in copy_user_generic()
Message-ID: <20250318215926.0a7fd34e@pumpkin>
In-Reply-To: <Z9axe9Ac5biyJjCC@gmail.com>
References: <20250314175309.2263997-1-herton@redhat.com>
	<20250314175309.2263997-2-herton@redhat.com>
	<CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
	<CAJmZWFFVL++yU1XJLkXSck=GRQXiim16xVSvdxjq1k=c=Aaiqg@mail.gmail.com>
	<Z9au20vtMSXCbdXu@gmail.com>
	<Z9axe9Ac5biyJjCC@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 12:09:47 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > > It does look good in my testing here, I built same kernel I was 
> > > using for testing the original patch (based on 6.14-rc6), this is 
> > > one of the results I got in one of the runs testing on the same 
> > > machine:
> > > 
> > >              CPU      RATE          SYS          TIME     sender-receiver
> > > Server bind   19: 20.8Gbits/sec 14.832313000 20.863476111 75.4%-89.2%
> > > Server bind   21: 18.0Gbits/sec 18.705221000 23.996913032 80.8%-89.7%
> > > Server bind   23: 20.1Gbits/sec 15.331761000 21.536657212 75.0%-89.7%
> > > Server bind none: 24.1Gbits/sec 14.164226000 18.043132731 82.3%-87.1%
> > > 
> > > There are still some variations between runs, which is expected as 
> > > was the same when I tested my patch or in the not aligned case, but 
> > > it's consistently better/higher than the no align case. Looks 
> > > really it's sufficient to align for the higher than or equal 64 
> > > bytes copy case.  
> > 
> > Mind sending a v2 patch with a changelog and these benchmark numbers 
> > added in, and perhaps a Co-developed-by tag with Linus or so?  
> 
> BTW., if you have a test system available, it would be nice to test a 
> server CPU in the Intel spectrum as well. (For completeness mostly, I'd 
> not expect there to be as much alignment sensitivity.)
> 
> The CPU you tested, AMD Epyc 7742 was launched ~6 years ago so it's 
> still within the window of microarchitectures we care about. An Intel 
> test would be nice from a similar timeframe as well. Older is probably 
> better in this case, but not too old. :-)

Is that loop doing aligned 'rep movsq' ?

Pretty much all the Intel (non-atom) cpu have some variant of FRSM.
For FRSM you get double the throughput if the destination is 32byte aligned.
No other alignment makes any difference.
The cycle cost is per 16/32 byte block and different families have
different costs for the first few blocks, after than you get 1 block/clock.
That goes all the way back to Sandy Bridge and Ivy Bridge.
I don't think anyone has tried doing that alignment.

I'm sure I've measured misaligned 64bit writes and got no significant cost.
It might be one extra clock for writes than cross cache line boundaries.
Misaligned reads are pretty much 'cost free' - just about measurable
on the ip-checksum code loop (and IIRC even running a three reads every
two clocks algorithm).

I don't have access to a similar range of amd chips.

	David

> 
> ( Note that the Intel test is not required to apply the fix IMO - we 
>   did change alignment patterns ~2 years ago in a5624566431d which 
>   regressed. )
> 
> Thanks,
> 
> 	Ingo
> 


