Return-Path: <linux-kernel+bounces-277095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1C7949C50
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6C41F24182
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972D717622D;
	Tue,  6 Aug 2024 23:29:34 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B35175D48
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986974; cv=none; b=EUc1ZghmR7qCDaHvpQCtdMmKeCNG+fVtmij29ZG5sB6lReTuTklvzvlJ98W+epw+wxDDE3tDb0eojA9vfyDTgZ3VI+PZkFJLkN628BXPZxG3Q8LLSMu/KngPxrWArJOFssQsK+4G0HK4Z4T0acgIKvSQ5OvRN4Gl08p9uoo0ydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986974; c=relaxed/simple;
	bh=5J8mCxaP774nuf70zzYRWJjGaD0Vi0xoe5+Dl2vqEmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ynjvw51sC0tqKDo3vc+ni7p6nqtdjh1Ii2Tu5eZQFkq4Fk4Ko/Irln1BlBxv0otRREw1fcbippc4FeU87pHq6Nbvml2uLV2yHBOz8iT+PQNQWCuUOYBT0DoN3gAkdLWT7oDgW/tu60o7NLh4CJEpnyEtwfIeU/kwzT1G9hv4Vsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d28023accso1027707b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 16:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722986972; x=1723591772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN7W/EvK++SUS8iThBqel76iZ1gSKPUdbdaGo/i2n1Y=;
        b=rQk0Oot11TN3CgRDyvYAEM3Lc/FB+nxZOejAxIaaYMnUG0FTcxh4CDaaBZmbcBUjcw
         nx1smGqicOSxeHATog3G1Fy8AdUlmyrkbyfQEWTssxjAx5tJ8gUXfKzzm6+DMoFsZwW7
         XJzjlNYtK8IgeXuDjXlv5PLicyMZbeyNqpwDzT1xx2+FH6zMMB0B0zK7h+W+21hAVgSC
         zjZNMa3preCds9iGJTdEYrfqEOQXu0LV4SSA0QrZTy80k7BlImpZZWBH/37eCLUBGsUK
         YVWrKTq/ec95MXVbwMz1h4kbkkvtWR2erLVENKTjQX0X1RHJlC5KI7X4iJk4nRfH8Z7G
         6XhA==
X-Forwarded-Encrypted: i=1; AJvYcCUFmhka4kPje0bgdA+8d1m/A7VsFWEoHzyHyUqNAoKmr0m0A3UblnGd8g2hctFnKKFTsGfABLXxHlJQbBsc3ztxWne6N+yEMLnOuZf1
X-Gm-Message-State: AOJu0Yykjl0giy/aVDgadfqjJVrpO4rwybehiAw04esJVU7UU/N8GGUc
	G90gDaa8UPEg6GxF/sPLZK/YpJu786WtxlshrITrj9G8NWwKkM7+spoDubaDPVyKAPtJ/es5Upo
	uRzG56P0AVHUxc25cnDZVuovPiOw=
X-Google-Smtp-Source: AGHT+IGDr6+npSuDFeNMfnCJpGTyEm86mlELM+98xfYgvw7nw0N5C+/7ZeNz9UXZjuhS8r/ouZOGcdTglTYEG88zihU=
X-Received: by 2002:a05:6a21:32a0:b0:1c2:9643:2921 with SMTP id
 adf61e73a8af0-1c6995504d0mr19633808637.10.1722986971565; Tue, 06 Aug 2024
 16:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <20240703200356.852727-7-kan.liang@linux.intel.com> <CAM9d7cgQWLdec063U+c1su_O9jchv5HSTQ0S0tQJ_q96hjgjXw@mail.gmail.com>
 <9b7c5c61-ef8c-43a8-bf1c-7ff32b4c8bee@linux.intel.com>
In-Reply-To: <9b7c5c61-ef8c-43a8-bf1c-7ff32b4c8bee@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Aug 2024 16:29:19 -0700
Message-ID: <CAM9d7cgE=cDyeOyXrRZt53vKD=FRSqQRMz8=f=bGT-gzm2jjkg@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf report: Display the branch counter histogram
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org, adrian.hunter@intel.com, 
	ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:40=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-08-02 8:18 p.m., Namhyung Kim wrote:
> > On Wed, Jul 3, 2024 at 1:03=E2=80=AFPM <kan.liang@linux.intel.com> wrot=
e:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Reusing the existing --total-cycles option to display the branch
> >> counters. Add a new PERF_HPP_REPORT__BLOCK_BRANCH_COUNTER to display
> >> the logged branch counter events. They are shown right after all the
> >> cycle-related annotations.
> >> Extend the struct block_info to store and pass the branch counter
> >> related information.
> >>
> >> The annotation_br_cntr_entry() is to print the histogram of each branc=
h
> >> counter event.
> >> The annotation_br_cntr_abbr_list() prints the branch counter's
> >> abbreviation list. Press 'B' to display the list in the TUI mode.
> >>
> >> $perf record -e "{branch-instructions:ppp,branch-misses}:S" -j any,cou=
nter
> >> $perf report  --total-cycles --stdio
> >>
> >>  # To display the perf.data header info, please use --header/--header-=
only options.
> >>  #
> >>  #
> >>  # Total Lost Samples: 0
> >>  #
> >>  # Samples: 1M of events 'anon group { branch-instructions:ppp, branch=
-misses }'
> >>  # Event count (approx.): 1610046
> >>  #
> >>  # Branch counter abbr list:
> >>  # branch-instructions:ppp =3D A
> >>  # branch-misses =3D B
> >>  # '-' No event occurs
> >>  # '+' Event occurrences may be lost due to branch counter saturated
> >>  #
> >>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles          B=
ranch Counter [Program Block Range]
> >>  # ...............  ..............  ...........  ..........  .........=
.............  ..................
> >>  #
> >>            57.55%            2.5M        0.00%           3            =
 |A   |-   |                 ...
> >>            25.27%            1.1M        0.00%           2            =
 |AA  |-   |                 ...
> >>            15.61%          667.2K        0.00%           1            =
 |A   |-   |                 ...
> >>             0.16%            6.9K        0.81%         575            =
 |A   |-   |                 ...
> >>             0.16%            6.8K        1.38%         977            =
 |AA  |-   |                 ...
> >>             0.16%            6.8K        0.04%          28            =
 |AA  |B   |                 ...
> >>             0.15%            6.6K        1.33%         946            =
 |A   |-   |                 ...
> >>             0.11%            4.5K        0.06%          46            =
 |AAA+|-   |                 ...
> >>             0.10%            4.4K        0.88%         624            =
 |A   |-   |                 ...
> >>             0.09%            3.7K        0.74%         524            =
 |AAA+|B   |                 ...
> >
> > I think this format assumes short width and might not work
> > well when it has more events with bigger width.  Maybe
> > A=3D<n>, B=3D<n> ?
>
> The purpose of "AAA" is to print a histogram here which can give the end
> user a straightforward image of the distribution. The A=3D<n> may not be
> that obvious.

I understand your point.  But I think we need to provide an easily
parse-able format at least for CSV output.

>
> I don't think there is a plan to increase the saturation of the counter.
> So 4 bits of width should last for a long time. Other ARCHs don't have
> such a feature either. I think I can the change the code to force the 4
> bits of width now. For more that 3 events, the perf tool can convert it
> to a "+". We may update the perf tool for a more specific histogram
> later, if the saturation is changed. What do you think?

Ok, 4 bits width is probably fine.  How many events can a LBR entry
support?  Maybe that's limited by the number of HW counters but
theoretically 64 / 4 =3D 16, right?

Thanks,
Namhyung

