Return-Path: <linux-kernel+bounces-444004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E29EFF32
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09244283CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0B1DDC23;
	Thu, 12 Dec 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ZwuLRPK"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA781DC19A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042045; cv=none; b=R0GBqIpP21rlmnHqUGDg+EppJLHw1ib02xENXBrm/KG7IKk9f3uHMtN8xBLp6MnRi+71/q0TWSnKOk9i9C3/O8elZgY/qan0lQyc+ywgwf3GAUKHOSyzerzN66p2Y4IEDNPOiBU2kyttoQCvEw9POO49lbEfvdZGlFZ3VvqWevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042045; c=relaxed/simple;
	bh=u1tWBAA4sulsIS2xftYo9r3ka5pE3Xc2cJTyRjh02LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ+S4R2AyKebstNq870rbxYsDRDVYLJj5gBML880jIG50Ek/8J5ZJlV763xPoiD8wTiQU5w9bE9RjnPU0fE4b9HL2fPgF/IAbl2nc4xy0kUEJEOkU667mNtqLg8FphaT4dFpgJ1yaLrHHp/4HO+ukcrZeX6O+DFnnRJ0XwqdyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ZwuLRPK; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a814c54742so18515ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734042043; x=1734646843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElZuDMxXTYOA5Hu16Xt2PEgtD4uBy7jHyc/pzjZ/7Yw=;
        b=1ZwuLRPKdc1lUs5LQdMHfHAsfaQwBSUzD5HSRtNNTfeF3Mixb0DEdoZ57+TtB2hbQP
         9Jht+czzteh2OcHlHkHNwWTIgOO4aamP+qG9YGNvFKyQZeo7QhO9mwvC10+OYQZQ7Qyj
         TzNYBUVb1qROgB+LCKECGo03boUeRrfwAjzTYQnoPik9dhQy0+dEOi5DHixf4f/rAd4U
         7UNfd9hA5EUvknUoANIpjG/2UbDhfkhkJopwJVVvYt3E+iah43qe5mgNIuOXJZe9ihy/
         txHdS5ngdRKDoFloz3vNGKWaYYa4TW4TAVRqw8DEG+Jv3QJE2hTu+7pQvZlJTErZltQU
         J1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042043; x=1734646843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElZuDMxXTYOA5Hu16Xt2PEgtD4uBy7jHyc/pzjZ/7Yw=;
        b=FTlndCSXA+z74zY+yCR0J0SqJNP5w4/LeCOZ69wruPOO5rb766OKI5LwxK5V1nsMU2
         9dqtDEPoPUNZt+tvsse+26e7ZMqy0YXRQB4PUac8bMrPtDLidFTd0JHZwPyYpMstfdy9
         2U/K7fFh+eUMEQY8/oTnH2D3OnW/2+zVS1RQD1UbE28rxBrPoKTltVk0VTjYihHhIR/a
         /SV09eK1ZOZR30OWt738mqpzBNLrtLej9Z77xYOLo4BSR51NXCwdNA9fvuts68TxvFnn
         RZjKdmZj+mvEz4ZEF/NgD7ipdWi8XMldndzoy1PqnDpemXbiyvhGOI7T/M9xJmJNbulH
         3bjw==
X-Forwarded-Encrypted: i=1; AJvYcCUK7fjiieQ4z3K0TDXvvgrbP2KbvQJpmHpYomBYbDVBR+PQvcRHoQQ7kE0Mtie2oni1rOf8tCDBtIHjfWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/Quibn/vcf1yNBEQ8ydvgDYHrExYuh7b8flWbcD9kWt4uUtu
	mZZui2k9qxvjKyyfCKJ5jKUODB7uc8XGDzyDfzGCdpTXOEsqoaxsc3GmpqvZFH9ffw5ZHp7yrUl
	eFGZQchSa/JFZidEkzTSgDYVJUwfQN7tdLpmU
X-Gm-Gg: ASbGncspSpl1h+WjzUMnvvYFFLvXCTjI4CupblsvtXLev3Djb2j6Lkt78RIphmEOI4E
	nrxHsNE/CzFOoyahXMH+xV71Uk7cw6ZfLYneHQQw=
X-Google-Smtp-Source: AGHT+IFgK8t076g3O1emjXp9rpsaxku8xjTGZi9+od1dZ4IXBGfeYBSzX4yh04z93ZbpCcNYwL8cIYlHr7gje7A1LrM=
X-Received: by 2002:a05:6e02:1a0a:b0:3a7:a468:69e0 with SMTP id
 e9e14a558f8ab-3b0267481e3mr241805ab.1.1734042042577; Thu, 12 Dec 2024
 14:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212655.922196-1-namhyung@kernel.org> <CAP-5=fXtL-MFW5YW=5WsYNftCAj7MaXVwN8R3veuiODiC85bdg@mail.gmail.com>
 <Z1suPi7XLncFKtG4@x1> <Z1tPCfRTkC5BjZq0@google.com>
In-Reply-To: <Z1tPCfRTkC5BjZq0@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Dec 2024 14:20:31 -0800
Message-ID: <CAP-5=fWBX=H=JfL5R61UyBiB77mnCQ_tAQ-SO0T+jAr4x8gFdA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Avoid unaligned pointer operations
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 1:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Dec 12, 2024 at 03:41:02PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Nov 27, 2024 at 04:51:15PM -0800, Ian Rogers wrote:
> > > On Wed, Nov 27, 2024 at 1:26=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > > The sample data is 64-bit aligned basically but raw data starts wit=
h
> > > > 32-bit length field and data follows.  In perf_event__synthesize_sa=
mple
> > > > it treats the sample data as a 64-bit array.  And it needs some tri=
ck
> > > > to update the raw data properly.
> >
> > > > But it seems some compilers are not happy with this and the program=
 dies
> > > > siliently.  I found the sample parsing test failed without any mess=
ages
> > > > on affected systems.
> >
> > > > Let's update the code to use a 32-bit pointer directly and make sur=
e the
> > > > result is 64-bit aligned again.  No functional changes intended.
> >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Looks good, applied to perf-tools-next since this is something that is
> > not new nor looks urgent.
> >
> > I think that since we have multiple maintainers, one for not urgent
> > stuff/development and the other for the current window/urgent stuff,
> > that we should express the expectation about where a patch should be
> > processed, by having on the subject the tree the submitter thinks shoul=
d
> > take the patch, i.e. for this one:
> >
> > [PATCH next] perf tools: Avoid unaligned pointer operations
> >
> > While for urgent stuff we could do:
> >
> > [PATCH urgent] perf tools: Avoid unaligned pointer operations
> >
> > wdyt?
>
> Looks good.  It'd be really great if contributors can do this.
>
> But I also think 'next' should be the default so only 'urgent' would be
> specified if needed.

Fwiw, I needed this fix, forgot about this change, and wrote my own by
just sinking the unaligned array computation (that causes undefined
behavior) into where it was used:
```
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1690,10 +1690,9 @@ int perf_event__synthesize_sample(union
perf_event *event, u64 type, u64 read_fo
        if (type & PERF_SAMPLE_RAW) {
                u.val32[0] =3D sample->raw_size;
                *array =3D u.val64;
-               array =3D (void *)array + sizeof(u32);

-               memcpy(array, sample->raw_data, sample->raw_size);
-               array =3D (void *)array + sample->raw_size;
+               memcpy((void *)array + sizeof(u32), sample->raw_data,
sample->raw_size);
+               array =3D (void *)array + sizeof(u32) + sample->raw_size;
        }

        if (type & PERF_SAMPLE_BRANCH_STACK) {
````
Namhyung's change is better because of the BUG_ON. Perhaps that BUG_ON
should appear after all the void* math that can create unaligned u64
pointers in this function.

Thanks,
Ian

