Return-Path: <linux-kernel+bounces-232270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D761991A605
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1407D1C2476B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDB014F133;
	Thu, 27 Jun 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIEa7gHc"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D01304A3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489680; cv=none; b=MNebkQ3CMQDv5c7jsCRRLRu0JMuYLoVYp5BQZpQGgva7lycx/gHLp/8p3UcjVVj8kQBpLCZxKzA2vWPMCpBme/O+EaYcqEVjLxQvahfdPFKBsiIeAtAEGFh5/v37aOY7BapPPxuVTdTlZw1jn7i8xRTE/rYaVeZYy5p56MCCNqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489680; c=relaxed/simple;
	bh=k9j+/cSs2PAYgdkbCUNnS381bOcAZnMsEBwA3t2khoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQEdVXaG6sYERdtde9iOa1TlDeW2xQ0ChbG1apNZqma25ybj0OH011lwyjVDtVXwEn9ou5S5raR70KOpqad4yHtmNyYJtnbpWCWP9iP++htO85l1GsprQsIG/BZHHGXjn75dSOqBa8cR5QXPo65BEAED1WihqrnKn3rL3lLGQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UIEa7gHc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a72517e6225so616656066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719489677; x=1720094477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9j+/cSs2PAYgdkbCUNnS381bOcAZnMsEBwA3t2khoI=;
        b=UIEa7gHcrwugAMEYzSzJCjbW0OiXjDs7N5LdtsJ57bZLSOaVei+elRSK+wXrgy35ct
         hDd1ng86EDZPFuZCK+BqWFSqMPOi+A+Vo9lv0YUvK2BerZjJvQp6CYn7eApra+yJ/qUe
         FvVfcbeOKhF5cT5gnoqpzVhy3EOqRoM6LzMMv/usZ2sV4kONKssnBlcRGE18sNWaru3L
         EBNotLGqy5NLmUgoCo8OCHZWFXsREtMMwU1vHsWJM1SYow+AnOdnUM7osuUFZTlfMdMC
         uWAQGZ5n061aAMH2u1ig+5IOzq4Yw0hOKLlce8NBzDIKkugOYwpLPWgZGLbRJZF2m7dJ
         q2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489677; x=1720094477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9j+/cSs2PAYgdkbCUNnS381bOcAZnMsEBwA3t2khoI=;
        b=gMEyy58CnJV1bQLHYSz2EhkHlvItqgxSkxvqQs5LH8a6Chn3lBijh1ejy9FBirG/UC
         CaufI0LkDdH66D0wjA+YFT6h6ZOvpb90/xdWQRjYr2KYOdWIXfjhvtgJ6WTMOS2nW1qW
         MzLISMcQl4tNeFIr2ITKs5N5BrxwAWjJHvX9qFrWclWEdBUvpHRK+Z0kJXWm5Qm7nw9Q
         DCOsYjTtzKOTP/dvq+aD7WbrTTRZJRQtFzKTYhR0n9vn6F4wFwGcwBsOmLmkg31JE6k9
         691vwyxGp0rX0aVo/3S8rP5LpMiOuXTiqp8tstIByBLFiX3urO9THH420jZ+ZTLwSw9U
         wvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwSAc5r2bVyNPOwsz2jg0E6uNGW2cN8SA9NUo/2UclXBp412+M667h38d4UkbFOMN2HK4WfaP/bBJDLgzbj7/UKJTrNjfdA/Szz2RR
X-Gm-Message-State: AOJu0YzTWDMULX2bOjwAo7LLF/WoMb8MB1g97UOPNoVvvRJMS1hYHjd4
	HFG9A4rcojn/0wydrKVpwGupBTSILlNL/+eLzjfo4yfQOSD75S3xvl3f9lNWHRBqu+djp0Bb9BT
	gTIhhNxfILfjcB8lS7d2FVwhGB1UTWIsLuWxkh/ccFr88GEAl3esL
X-Google-Smtp-Source: AGHT+IFF8Hiiq5pYK9NbSKbcRGMGJtjP5zoG6SUD3CzR5idX+/EYVlkwu3pidiz4GSLWh9u4DpKft3r0SyrDpQHzrFs=
X-Received: by 2002:a17:907:c78d:b0:a72:5f9a:159a with SMTP id
 a640c23a62f3a-a727f680828mr594305966b.2.1719489676985; Thu, 27 Jun 2024
 05:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka> <CAJD7tkZfkE6EyDAXetjSAKb7Zx2Mw-2naUNHRK=ihegZyZ2mHA@mail.gmail.com>
 <Zn1Tg6_9NyxJE7Tk@tiehlicka>
In-Reply-To: <Zn1Tg6_9NyxJE7Tk@tiehlicka>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 27 Jun 2024 05:00:18 -0700
Message-ID: <CAJD7tkb9-qzYGOMHu1DfCSsWmRfCuK5Vi3NBmTz6d-dvaeAAtw@mail.gmail.com>
Subject: Re: [PATCH -next] mm: memcg: remove redundant seq_buf_has_overflowed()
To: Michal Hocko <mhocko@suse.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 4:56=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 27-06-24 04:33:50, Yosry Ahmed wrote:
> > On Thu, Jun 27, 2024 at 12:13=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > > On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
> > > > Both the end of memory_stat_format() and memcg_stat_format() will c=
all
> > > > WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format=
()
> > > > is the only caller of memcg_stat_format(), when memcg is on the def=
ault
> > > > hierarchy, seq_buf_has_overflowed() will be executed twice, so remo=
ve
> > > > the reduntant one.
> > >
> > > Shouldn't we rather remove both? Are they giving us anything useful
> > > actually? Would a simpl pr_warn be sufficient? Afterall all we care
> > > about is to learn that we need to grow the buffer size because our st=
ats
> > > do not fit anymore. It is not really important whether that is an OOM=
 or
> > > cgroupfs interface path.
> >
> > Is it possible for userspace readers to break if the stats are
> > incomplete?
>
> They will certainly get an imprecise picture. Sufficient to break I
> dunno.

If some stats go completely missing and a parser expects them to
always be there, I think they may break.

>
> > If yes, I think WARN_ON_ONCE() may be prompted to make it
> > easier to catch and fix before deployment.
>
> The only advantage of WARN_ON_ONCE is that the splat is so verbose that
> it gets noticed.

Right, that's exactly what I meant.

> And also it panics the system if panic_on_warn is
> enabled. I do not particularly care about the latter but to me it seems
> like the warning is just an over reaction and a simple pr_warn should
> just achieve the similar effect - see my other reply

If pr_warn()'s usually get noticed in a timely manner (by testers or
bots), then I think pr_warn() would be sufficient. If they can go
unnoticed for a while, I think WARN_ON_ONCE() may be warranted to
avoid the possibility of breaking a userspace parser.

