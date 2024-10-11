Return-Path: <linux-kernel+bounces-360626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280CF999D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDAF1C22C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E6209F45;
	Fri, 11 Oct 2024 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztB8wZB8"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA11E9067
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630337; cv=none; b=uJv0Ne7VmOtdt08oKPTlhZMr9u1X8qNvD+9DI2y36rhet31dRenS8J5ZxndqgoaMNWwIvFudG6264r7D/Hofqf5NlvmkE7njdbVYzpV7qojt6/Wq48W1ZFh1bwv8Z2j17YnxbIVcA/qn26A/gkY8ScExP/43hlhYdvokBR0SF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630337; c=relaxed/simple;
	bh=oQVYIhGbEfAnqbdWbSdyP2ZhcG8OZnwQ2cfbNbhQT3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOT4/UvhIa7p2EcMB1r5T8O0xd3FboACwzYYpiS2LNZ8D4hAN3AFJAgGoa0v54CFIJVVjmHlHUSw8l7YzPjLCQvVI3d77aBJIN9Yax9CcYmgl+PKVQfePbmVBfTphs6t6NNF0P7ROuEPF9HKPUhIpLli3pnmZ2xNJamzvadPI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztB8wZB8; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a391fdd53fso138915ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728630335; x=1729235135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opgRegBAM5FAXU4C8qQl6ZNe0vpoXti1f24qgQ1xEts=;
        b=ztB8wZB8UecCP1caU8GfVnMr93xdM+IKU6tCAMPlOXnNxv/9JRhUqx1MW5nxEa9NrN
         lnX+XBC0JPxdulkEItvwOxJte1y9RQ7QWRyBNTBlbSS7v9vjerkTKTnOOOP2H2H9S2mY
         lBs1JozJSETBtevIez4BDpReiaWnbmhy5/X4jKkhV1EmIkuQJ34wYuxYhKTpnuMm30QW
         RROM2LlNlMXlU0vyjbht4ZQWl58LtNQKAzo58XR7fpE1Tq/SLolR/BMgerTkDU8VtQ66
         I8HogpPuhJ+iUcJa0MSw1F1kiPgX9znbq+x1k7wtpLoGHSZf3Gc48ueRIkUr+YE6cmzf
         XXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630335; x=1729235135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opgRegBAM5FAXU4C8qQl6ZNe0vpoXti1f24qgQ1xEts=;
        b=cV+LUWxhk/1F85sfucLsU2uJH9EJmReD3+lrMZXZo8xN/WQWcD3h/lS3r33DxCMplV
         rzpcNnY6n126LK3Kt7MDW9kNvF5dCnI/DqTWJzPWoehISnbG09OxJGHfmhfBy6nGaTA1
         GZ25lHhsPXr4WiYVQcsfb+CBKfNNGn06+a5yI55kme+8IpzuYgeN+RCtECFvMfxOHIYa
         FbKrdECOTYD+S9FxoyIfucg8EEjrOl3wiCIGZPSENFJ+OhVLBcIzAneSk6odLYfX6feU
         +dn7sWtObJdB3H+j2D9DwUdxRzRlSd9HZatwzXvMAFptjQwa9TYLx8TCipvIUqdKdaks
         bd7w==
X-Forwarded-Encrypted: i=1; AJvYcCWducKsw17+Z7HMEv5qLAiTsOGORWEZ9t+oy1Q91aNPLQiWuGYKwpSe3ZDzUUEttI2gBLewcLNfuxsNEAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQDoM9KL1WpvgpjbyKQMHu9KYnYgEdtsXfNoVqxDSYBHMH2Ox
	3jOL30YGvSzozjCj2/XeRS+0sRUI+PVQ/02t99anskjlEUA2lt6VN/x4EWP6GLEMYA0A524b6FN
	TtlPc/DfZn3aYjwCBeV2oFOCs9m1TyUiXeZn0HtzUeEm4GTTft+SkCWY=
X-Google-Smtp-Source: AGHT+IH0cRUN2m4kUOQeDT0edggke9x59b9iQG74/GOevsfrpTMX28HFCbrd+U/nm7/WWJ8m/yyh3EXal3MCFR7T4Ic=
X-Received: by 2002:a05:6e02:1566:b0:3a3:a053:c0ad with SMTP id
 e9e14a558f8ab-3a3b6566f17mr1566875ab.25.1728630334825; Fri, 11 Oct 2024
 00:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011102330.02bece12@canb.auug.org.au> <20241010235743.1356168-1-namhyung@kernel.org>
 <20241011114858.61ff252b@canb.auug.org.au> <ZwjG_ZpqV4h3HifQ@google.com>
In-Reply-To: <ZwjG_ZpqV4h3HifQ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 11 Oct 2024 00:05:21 -0700
Message-ID: <CAP-5=fWm86UcwX+B_XjFSLFJF54QP2trYzJgJF0927h-AzSV_Q@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix build failures on ppc64le
To: Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Oct 11, 2024 at 11:48:58AM +1100, Stephen Rothwell wrote:
> > Hi Namhyung,
> >
> > On Thu, 10 Oct 2024 16:57:43 -0700 Namhyung Kim <namhyung@kernel.org> w=
rote:
> > >
> > > Hi Stephen, can you please test if this patch fixes it?
> >
> > Sorry, I still get the same errors.
>
> Ok, thanks for the test.  I'll drop the series and rebase the branch.

Is this a define issue? I dislike that PPC has a #define
__SANE_USERSPACE_TYPES__, we might be trying to fix something
inherently insane.

The failure at:
```
    138 |         snprintf(path, PATH_MAX, "%s/event-%d-%llu-%d", dir,
        |                                               ~~~^
        |                                                  |
        |                                                  long long
unsigned int
        |                                               %lu
    139 |                  attr->type, attr->config, fd);
        |                              ~~~~~~~~~~~~
        |                                  |
        |                                  __u64 {aka long unsigned int}
  util/evsel.c:147:41: error: format '%llu' expects argument of type
'long long unsigned int',
                       but argument 4 has type '__u64' {aka 'long
unsigned int'} [-Werror=3Dformat=3D]
```
is for code moved from here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/tests/attr.c#n77
```
snprintf(path, PATH_MAX, "%s/event-%d-%llu-%d", dir,
attr->type, attr->config, fd);
```
ie the code is identical, so why does it compile in one file and not in ano=
ther?

Elsewhere for PPC we carry:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/tests/bp_account.c#n3
```
/*
 * Powerpc needs __SANE_USERSPACE_TYPES__ before <linux/types.h> to select
 * 'int-ll64.h' and avoid compile warnings when printing __u64 with %llu.
 */
#define __SANE_USERSPACE_TYPES__
```
Given the comment I suspect we need to do similar to fix this.
Stephen, could you test?

Thanks,
Ian

