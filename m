Return-Path: <linux-kernel+bounces-333094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A394E97C369
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566A61F22C42
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674871B28A;
	Thu, 19 Sep 2024 04:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="of5QYUtF"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2B17545
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726721164; cv=none; b=EFWDDVpTL3hIzQFk1gWc4XPkwOnAb5I+iibYUK8jhOwbhOze3KVKwgERjv/lw8on7qMQzVKD2TQkRvIjTpZyunC+iyFYFvHC0homdCVSKtbDYS7aQAu6Fx+AcrtNfHRJf6CdP9YqruOKmQx9EQux7/QDO5l51QiflpbJ13LM0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726721164; c=relaxed/simple;
	bh=TwEXiCTK2Uz40eVQrDkdsVUjwIkQsAUUrPZQ/wf6MFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFQEGYZ+bCZAW4/ztLF/7kPvIrd0+iclYEu2oloJOTN9kDZjYAb4iB7BrsGItJilXBT/snnLYWxAQ2QaT4Osz2lB9gYJuxULjHhDeUW1JGrAHJqx6tJlrz0O95INetdCrY/R4dVQVcncM1P8nVXeEN5eKkOchnahPPYkpjelq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=of5QYUtF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20546b8e754so292925ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726721162; x=1727325962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwEXiCTK2Uz40eVQrDkdsVUjwIkQsAUUrPZQ/wf6MFk=;
        b=of5QYUtFsAYyKnLygVqKX6qgKShDHA/Z6rcl+hBx6f/bmZKcmLrW7sBNWhajjIYcRO
         bMk2na1vXP/pCsy98wwuRHLDKtADpMZ3eLBhmdKW1y+vqciXmxO5zY2a/R0VqsWA1NUa
         aDt02EJICoOfYYoy/txrm2on+Dmwo6+zlkehckXLm4oHQFGzh+t5ZSbw13uoRDYs/phn
         HjiiDRuV1Pjp53s6sIMh/9AL/LXuKJlOBk0n8/BI8QUY/yCTKfUzU7NUpu3leCeCQMlk
         HZdcKK1+xf3O1SmXWj4Kri7BhiUK0glWz2jz+U1/EMRVvQZPL/6lOKY9XgJrnWhcd/QU
         E+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726721163; x=1727325963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwEXiCTK2Uz40eVQrDkdsVUjwIkQsAUUrPZQ/wf6MFk=;
        b=FlU/pMPm3tmSZ0CzhL4FS4TmSWz/9+VedFvgBAva+kWvAPVZs+zT8Vd6f4hejVdbVF
         Qjmu9uz0Tm4myFmAUBWMmb28szO5pbp9m+uWP9acbHMYksi/hLI4BXNBFwnqeHbYIHBB
         gnEQxJhRFmSAXNsmLAmjpKerzpzEh4OUxuZN22GYkFP0TJQHyMgwkNm+ZsNj7RT0haON
         K3/HtXd87+p0uLViP/u5SfoJjfzt5MmYgrxyo6dwAgMrcOYiyjB+ixuaIqxctSRsKIuQ
         2UaVDlGYo0vSLDoYRhz7K5pgeyvp47UW1RJUVUEJ/7MmYIUWqc63cwQ3XjviWOUDUQf2
         Jsaw==
X-Forwarded-Encrypted: i=1; AJvYcCU4xVHJp8545GD9Fik2iuKfaF7unANaTAAk6ycBrjutlGsp05U6y8/D4bkVG75DhqywEUNzTIEg8wU8q/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/w6OWisDrEdkvUyNrs3gZ+HixFfeF2W+SUdLpoas8puhwLFEt
	HcVUCvceLzSPoggfW2GOHpfyVIvkX2FrrRLjo4hieeizaOZJlDFiRiO1/tBChPbxI1OBpIpiaEX
	VyyTQGcDRb8lbOK0xjWXY85G+s9YKp9b9J94B
X-Google-Smtp-Source: AGHT+IG4ekfuJ3oQqUYYsIQztac82JCGUipLZRm5ycjs+VUpfL68rilPuCMGoK7fBKNpUNNv1tmTe96YnK9xIB9zYtU=
X-Received: by 2002:a17:903:1ca:b0:206:a913:96b9 with SMTP id
 d9443c01a7336-208cd599c9amr1009335ad.10.1726721162266; Wed, 18 Sep 2024
 21:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918225418.166717-1-irogers@google.com> <20240918225418.166717-2-irogers@google.com>
 <Zut-iM3v9rJHehxJ@tassilo>
In-Reply-To: <Zut-iM3v9rJHehxJ@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Thu, 19 Sep 2024 06:45:23 +0200
Message-ID: <CAP-5=fWS-xOPurApZpMA=Zzukt5PQDYjF_7otCPTAL33PYmXAQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf python: Remove python 2 scripting support
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Zixian Cai <fzczx123@gmail.com>, Paran Lee <p4ranlee@gmail.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 3:29=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Thu, Sep 19, 2024 at 12:54:17AM +0200, Ian Rogers wrote:
> > Python2 was deprecated 4 years ago, remove support and workarounds.
>
> Nacked-by: Andi Kleen
>
> I don't see any advantages of breaking perfectly fine existing setups
> for no benefits.

The reason is that since moving to linking libraries rather than
building code we now have the ability to call functions like
parse_events - previously parse_events was stubbed out because there
was no way to build lex/yacc code. Calling parse_events is more
sensible than existing logic that does things like open a legacy
cycles event only on 1 PMU type. That is, the existing code doesn't
support hybrid. Practically there is no way to test python2 support
builds and works without having python2. We shouldn't be in the
business of installing python2 in 2024, my organization has removed
all support for over 3 years.

Thanks,
Ian

