Return-Path: <linux-kernel+bounces-337571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B499984BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD99F1C22689
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1421369AA;
	Tue, 24 Sep 2024 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3j/t6Q6O"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F7012EBDB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207494; cv=none; b=EbcpoOjjkayJiwKetL5pMYyVp0Me2pZ+Guvb/KN6+8UGZLDi4JewyVzpqqVplLfiIYpThacMz5wxN1BBvnyE6PdFIYJpwg9a+grA3l7xIBuM7k8+xv8hkZCjqlfK6BcJdTal1je3BcSzjDRmXCmNdDRWRFH72RO655Nmn5hull0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207494; c=relaxed/simple;
	bh=gKob+i2saQp48rnX7TTOD2WApJHduJmGU15H4aZagFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INEsTwb1x8mdCYuDAl1TMLNenbVgTn1if98NvX78q9Up1RKdBsOHqWD1CRidNmsN4pM4WFIUGFW5ALlh6yAMYyIEm1TgPqCOn8yHFaaEJ4vgkDfbw8wm55hfHIiWW6Iv1qJXWp0qZT6Q6jp3iT7kG0vg5IViKb/Mzs8Tjwf8V3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3j/t6Q6O; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so38345ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727207492; x=1727812292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTv5Kz1/nHcd+bzdeFJN5jUl+0y6XwDkMUQRA6INFWM=;
        b=3j/t6Q6OrNv/JcDac//TmHFhmBHyJp+s1psxCcz75lnCeIFVa65HXxURjXEwpOcWJf
         PdoCka4lumggFBmON8cKVwXpSBct0WSL5C8o6K/opjpx9Za43IY68uCJTOM2eSfpVJOU
         AUC4XAK7Eiw6IEHthngSGyheY9TgIBA+y3gVwM+Pqu43NFshFHyY5OZga2UacPItcJf8
         BsvIBvbP084Bc3/ZCNjCpReW7VLBIiBqLvfsEcQCHxkOFCmRPydbzxaanVhv5VEf6zdl
         uPyKColJ3I0i3XUxtdWiW/izxQIT1IrxhEPDB3y1HI3hVZNzzne5FvRgrPI/kMmS8iwS
         kYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727207492; x=1727812292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTv5Kz1/nHcd+bzdeFJN5jUl+0y6XwDkMUQRA6INFWM=;
        b=HRroubd9q/LvtweFdSYwn+d6d+1Rz/meMLmxT9731gijO7m98RZbRutYa6NMpukGkI
         Tj7MWHO9iJwTcI/fMChgtq4hS1jsfQBb3Mka7p9aAOo/0yufL3J7cQL3FmxDFr5h2cfo
         ZkNHxM7+rGOnoPKPc4q4nfPxG0iI9TrWmLCIgtUse7lA+q+a7KcAsuEp1JT4zsUWb15r
         5PURp5jrNPtx1jbsOKdKmAI9pAbl3VJd6treJ8mGUlsWIHolYYopa8ut6yMA2cA0JBrd
         rn55KW+LSVOUbsJGd+0AGVTD6E43pqngfxlk1MYayvb0Z/6zMj6E4wwOVgmq44t/s3kO
         /Z9g==
X-Forwarded-Encrypted: i=1; AJvYcCWtPxJld5NFRzqWvBroJYTwkCdWjDhf4Vr/yEdUcOd358xB7BdMPywQLJo4FyshZk7t7kJ4QZXD8F0MqLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrXy/7aISEF0TT5BxrZ9QkjdfMmYyg0Xe0nXkTGgaz1hfGtpzX
	jo7ZXx6x0j7FTo11S8+jfnkYYumyDrF/F0MQdPr+ByYAB+xTwBoWN9RHhVgtzeo29sFm48KX8/q
	fWBvRi7XyPlkwyCWoY4WbZi7qV1hib+rxR79k
X-Google-Smtp-Source: AGHT+IEGNxuRwBmOz4OpvXhgnkkEoLCghzrvyxA3kBY//Y5LIoKIdpd1P33eorPTibTURcjZ8kCIKwSU70w8KnK7sec=
X-Received: by 2002:a05:6e02:164e:b0:3a0:44d1:dca4 with SMTP id
 e9e14a558f8ab-3a26e2c4afemr702355ab.6.1727207491479; Tue, 24 Sep 2024
 12:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924003720.617258-1-irogers@google.com> <20240924003720.617258-2-irogers@google.com>
 <ZvMHHKKZwab2IhlL@google.com>
In-Reply-To: <ZvMHHKKZwab2IhlL@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Sep 2024 12:51:20 -0700
Message-ID: <CAP-5=fUCbzz=bLY75DKfdPRNjW91yz6yAzywVe_QWDwK4d7R8g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf disasm: Fix capstone memory leak
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Sep 23, 2024 at 05:37:18PM -0700, Ian Rogers wrote:
> > The insn argument passed to cs_disasm needs freeing. To support
> > accurately having count, add an additional free_count variable.
> >
> > Fixes: c5d60de1813a ("perf annotate: Add support to use libcapstone in =
powerpc")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/disasm.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index f05ba7739c1e..2c8063660f2e 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -1627,12 +1627,12 @@ static int symbol__disassemble_capstone(char *f=
ilename, struct symbol *sym,
> >       u64 start =3D map__rip_2objdump(map, sym->start);
> >       u64 len;
> >       u64 offset;
> > -     int i, count;
> > +     int i, count, free_count;
> >       bool is_64bit =3D false;
> >       bool needs_cs_close =3D false;
> >       u8 *buf =3D NULL;
> >       csh handle;
> > -     cs_insn *insn;
> > +     cs_insn *insn =3D NULL;
> >       char disasm_buf[512];
> >       struct disasm_line *dl;
> >
> > @@ -1664,7 +1664,7 @@ static int symbol__disassemble_capstone(char *fil=
ename, struct symbol *sym,
> >
> >       needs_cs_close =3D true;
> >
> > -     count =3D cs_disasm(handle, buf, len, start, len, &insn);
> > +     free_count =3D count =3D cs_disasm(handle, buf, len, start, len, =
&insn);
> >       for (i =3D 0, offset =3D 0; i < count; i++) {
> >               int printed;
> >
> > @@ -1702,8 +1702,11 @@ static int symbol__disassemble_capstone(char *fi=
lename, struct symbol *sym,
> >       }
> >
> >  out:
> > -     if (needs_cs_close)
> > +     if (needs_cs_close) {
> >               cs_close(&handle);
> > +             if (free_count > 0)
> > +                     cs_free(insn, free_count);
>
> It seems cs_free() can handle NULL insn and 0 free_count (like regular fr=
ee)
> so we can call it unconditionally.

No, on error from cs_disasm free_count gets assigned -1 and my
experience was things crashing.

Thanks,
Ian

>
> > +     }
> >       free(buf);
> >       return count < 0 ? count : 0;
> >
> > --
> > 2.46.0.792.g87dc391469-goog
> >

