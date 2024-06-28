Return-Path: <linux-kernel+bounces-234364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A110991C5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EB31F22CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596441CD5BE;
	Fri, 28 Jun 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhbSAKqy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B31CCCD7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599311; cv=none; b=uhg2u4t3wgY4q5PJUj4Reep4GascAY/Q5ZCZn64Fqpeua+FIQlH3DSlMFdIg+cg3SS4/1v8Xol8nh8Zq5anHUR4JM570INnVfyuHbpGqm6B5R1mOCdJwQsF76kXzUBg3ccUAaAxBZOWJw6K3SIPHwEuYGg25B9w9iP5cowzIilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599311; c=relaxed/simple;
	bh=0/bcKF9yNwfrpBcaWqzxl2cNtLLSxiplYVtthlumbnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEqZhoA0ySrVbCaBBDC+izjfGsLfftr8Sv6TvLofroKdQvOsMvOZIuNXoaZ78gDhHnihEx4X6YMZY75qvoPrGXd+S0RrtWIosyj2TfonGrTdM1FF7S7dedbL9mkDkGTv0Bu5szgDBzH++TpyU0EUZV8nK7muFBnR+s8rvO+bcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhbSAKqy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fad076cd9cso19625ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719599310; x=1720204110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn/pRXgSi6IDLKLvgPYyyG0DNITGu/ajABHfGH5hZAM=;
        b=PhbSAKqy0k60uxTtbytGIRNtUcX+zkjuzi9B3bhchLMyttjmE2kGO9YyHbei6VfjJu
         zoy5SHpX1ZieN86IRKfhzRWF2NERQF0U16Ti28sLUmPaw6RGEd5/0pjx6S7s78UQp+bv
         PXc7jKCUI8wif/CHt9dXPFudG1YiAzAsv7SRyvvTslUqyE5W47Hpw9r/rd7zCTpx5iae
         s0bom6g9FDBrKmG5i9xCSJtPmEvo6vGiPSmF9X2I/CVbekJV4VOi7s9gBDWCP2GeAJRB
         ReBtU5r5UEDUcQY8ubkho42+cvn8vHzWNpuIOO+OgHSlR1xFmP7ORfO2Iko9svYHCH6P
         R4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719599310; x=1720204110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn/pRXgSi6IDLKLvgPYyyG0DNITGu/ajABHfGH5hZAM=;
        b=PxY2RvQrvqVj9rADTncJsWH4Tf+QGLl7UUQAR86nAT2KRGFWsFwFPKDNPGXOUrNHx0
         YY4aOsII0Q0Tlhv/2vN/AfZ9sLMtAgIBBVugrb8hSq9EVhSUu369fYDwuQAJ8UJN3fnI
         J/IU/pu62lDR6Wvezcp9Z3WqJcqtmnJuaSzVkmZZPCkXGIi/xTNNepL45KIi6lHSior/
         9f4LF8Q3lkyRY1EQs08WsY/4kFCPZvne/2xXsv9+4yZoz76Q3rEZUDfK85lzOeybTh3K
         wZI9BAVK6ZQ9uelIclFv2F7X0lbJpCI6zpgg7m42dwByW0zSgP4M/K1Tvl0A/+Xzr4qk
         I3pw==
X-Forwarded-Encrypted: i=1; AJvYcCUETJWEteArAiBZGh04UUGRIayxz5CYJd/4W98FfC1r+qzCTilOToA5joBLFfadaZvznbO6o5roHbfBZYv1oO6p4f15150gY5S3EPrR
X-Gm-Message-State: AOJu0YwH1qwwN4lQ3OPyodDpvRP0M6kabF9i+HphP3631eP0rA2shIra
	WLo9izUkzeymig0kShb+hFrTaFa0rkVqR3bztcFpD33BV/B/sfCSHgzR5rYNIMp451Q+UsqE8mw
	ZAQAI4hVXCY7gVcAwRQ9Z/SsTnhybg50L+uVS
X-Google-Smtp-Source: AGHT+IGU3wvTawYw9ntraj8PCsXlOmTXouULiPhu9QOzt/Ei3RLpE5rVuu+G1M6oo9apNtNxArt+uBCaH7CKFlkDwoE=
X-Received: by 2002:a17:903:3103:b0:1f7:3764:1e19 with SMTP id
 d9443c01a7336-1fad81f2d2fmr214315ad.20.1719599309187; Fri, 28 Jun 2024
 11:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614213908.352840-1-dapeng1.mi@linux.intel.com>
 <df56c6e1-5d99-4cbe-abd4-772e7ff948af@linux.intel.com> <4f5dbf6f-3805-43b6-867c-2503ccec7c1a@linux.intel.com>
In-Reply-To: <4f5dbf6f-3805-43b6-867c-2503ccec7c1a@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Jun 2024 11:28:17 -0700
Message-ID: <CAP-5=fVYmUvYawOBtUc_-PVzsTQhpOuMx4wxA7bHjwaZejii8Q@mail.gmail.com>
Subject: Re: [PATCH] perf topdown: Correct leader selection with sample_read enabled
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:17=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
> On 6/27/2024 11:11 PM, Liang, Kan wrote:
> > On 2024-06-14 5:39 p.m., Dapeng Mi wrote:
> >
> > Besides, we need a test for the sampling read as well.
> > Ian has provided a very good base. Please add a topdown sampling read
> > case on top of it as well.
> > https://lore.kernel.org/lkml/CAP-5=3DfUkg-cAXTb+3wbFOQCfdXgpQeZw40XHjfr=
NFbnBD=3DNMXg@mail.gmail.com/
>
> Sure. I would look at it and add a test case.

Thanks Dapeng and thanks Kan too! I wonder if we can do a regular
counter and a leader sample counter then compare the counts are
reasonably consistent. Something like this:

```
$ perf stat -e instructions perf test -w noploop

Performance counter stats for '/tmp/perf/perf test -w noploop':

   25,779,785,496      instructions

      1.008047696 seconds time elapsed

      1.003754000 seconds user
      0.003999000 seconds sys
```

```
cat << "_end_of_file_" > a.py
last_count =3D None

def process_event(param_dict):
   if ("ev_name" in param_dict and "sample" in param_dict and
       param_dict["ev_name"] =3D=3D "instructions"):
       sample =3D param_dict["sample"]
       if "values" in sample:
           global last_count
           last_count =3D sample["values"][1][1]

def trace_end():
   global last_count
   print(last_count)
_end_of_file_
$ sudo perf record -o -  -e "{cycles,instructions}:S" perf test -w
noploop|perf script -i - -s ./a.py
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.459 MB - ]
22195356100
```

I didn't see a simpler way to get count and I don't think it is right.
There's some similar perf script checking of data in
tools/perf/tests/shell/test_intel_pt.sh.

Thanks,
Ian

