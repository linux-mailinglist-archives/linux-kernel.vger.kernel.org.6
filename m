Return-Path: <linux-kernel+bounces-288884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA01954000
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A372285F96
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8066A1877;
	Fri, 16 Aug 2024 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2SFQMqCU"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371B1AC8BE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723778164; cv=none; b=Reoh/Aw4v2ronIcKwJn4tthHGcj+rMYg31E4e2mVqWmN93lSuakToOIfNYXKiAWNBTK1j5u7dFthmuNFAN7kHah7m4Wqmb7zUACw49L9m+SuXfCS2L1GmHGOLrWev0MbRuNpDfW+/yxEC3y6Iw8zD77Y40fFyRjqI9C5ZBVYbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723778164; c=relaxed/simple;
	bh=QvgCRCVIJQlf3c9D/c6CQexGv/AVEDoPki6TZ6C+lgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXICLlT5dpQIU/qX8J6ba/4SGjsGHS+9JloL7v+TVW5vwS4Q0GdnZu3J6KNRsVzR+3ZA8VTD978yNQP5YkaW1voM5Hy/FaTWsQAiFJx23oD6j2U8qF6+t1euMoiIQXKNnmYH2Mry6bmEXOYkyBNTdf2ErYJyteYaCkm5T0emPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2SFQMqCU; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39c3bf0584cso33905ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 20:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723778162; x=1724382962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBDLm5A+RDH4WkOIu6haLqh5HgWheaTx6ZttayiUTD8=;
        b=2SFQMqCUIpkJUZxtgzkCIqfZ97iypt9gOlvR5s0M9Cvu5BZ9+9pCTp151Fgwju2Qsr
         GBIK4zCxXRBk0q/phrcpYwJ9Glm1GWm548wFw7sn5WIQ/RX36tQNlCDWnzwXa/ZtIzZW
         TJKubAKN1e8wQidEd1H/X+R8unfofl/eb1I0APcO/KTcw8g3he9coVhf1rncCdK/q5J9
         YQNZomjSXDxDr9ahVKeKZaGj4Knuj2eSSpUcSyeHlA+6dD/sytegWuBn8IfGntopML7w
         +MQLYf5BSlTIfWZ4yrG/BtravblKaVcCud1GaWL1/P1AcOwWUSZTmfNMilXycQoyHgGA
         X7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723778162; x=1724382962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBDLm5A+RDH4WkOIu6haLqh5HgWheaTx6ZttayiUTD8=;
        b=LPi8gLYLCoPhzQNytSHHqYqPOuT+kDbVSKOTaABag6qp5rNe509khxDfUqz3Pr/im1
         oAKsiw3WQuP4G8aIVsAMXjChngWbl/sGWj7wZzM8oJ99kzJjZ7rTZNMTrhtCqrd2Watf
         5OhDqKZeNGxmOa8IjZsUwzTWjghZQMxRZDhfuaiTDSFFR7UsVsRqybDYhBPOhLuX+3k9
         i50g41aN0tv1fxu2M8x9xawLQL30mrKNaft1PJpOJBgr/L8u6KGmVcn4YFY7YgHs+sve
         fHpXAEEockXTdwQZ+0PPde28gvT66UyExtnxzXj3fJnWBMVwbCSYSSOPikouC9PB5ArG
         Rnzw==
X-Forwarded-Encrypted: i=1; AJvYcCUbEBHF/49c7OKnrN2CEDNCgKJYBGXz41bOHhul68ibflPQg4Uvt8Lky3jIepCsCh/v9LxGDD45tWjqsf5Q2/5QXqREOqQy+sRMBp+K
X-Gm-Message-State: AOJu0YwBSB4ty7Z9QqniMhTWg7yg9Xbb90nhrMLp3E+s/onF6fb9W4Ts
	U+de0bVWNgwbz3D6DYDNZ58Cxd8xa2iF1lt03HkaXx+zSK2OrORIR1i/3BezuICGyvBghD1lIVI
	65uiw5gQyFlAmMV3aH/nJtCmQfimgoL/FYDV9
X-Google-Smtp-Source: AGHT+IFG54skZod88kVSUZv1syt2i20zv5Fvy6Kdg2iPfl7E7+fCdF6DLOt5umNOo0pJ6e7zslmiGSByBIx+/w+nThY=
X-Received: by 2002:a05:6e02:16cf:b0:39a:14f7:1bfd with SMTP id
 e9e14a558f8ab-39d28eecf1cmr543285ab.5.1723778162148; Thu, 15 Aug 2024
 20:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815013626.935097-1-howardchu95@gmail.com> <20240815013626.935097-11-howardchu95@gmail.com>
In-Reply-To: <20240815013626.935097-11-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Aug 2024 20:15:51 -0700
Message-ID: <CAP-5=fUqU0sKKNaQmA=ra0en3Mky_PvRu=-48E5Q-6Wov7_UNQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] perf trace: Add general tests for augmented syscalls
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:37=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> In this test, augmentation for:
>
> * string
> * buffer
> * struct
>
> Is tested.
>
> Please use this command to test it out:
>
> perf test "perf trace general tests"
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/tests/shell/trace_btf_general.sh | 59 +++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
>
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tes=
ts/shell/trace_btf_general.sh
> new file mode 100755
> index 000000000000..9c5e9d321b42
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -0,0 +1,59 @@
> +#!/bin/sh
> +# perf trace general tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +err=3D0
> +set -e
> +
> +. "$(dirname $0)"/lib/probe.sh
> +skip_if_no_perf_trace || exit 2
> +
> +file1=3D$(mktemp /tmp/file1_XXXXX)
> +file2=3D$(echo $file1 | sed 's/file1/file2/g')
> +
> +buffer=3D"this is a buffer for testing"
> +
> +trace_test_string() {
> +  echo "Testing perf trace's string augmentation"
> +  if ! perf trace -e renameat* --max-events=3D1 -- mv ${file1} ${file2} =
2>&1 | grep -q -E "renameat[2]*.*oldname: \"${file1}\".*newname: \"${file2}=
\".*"
> +  then
> +    echo "String augmentation failed"
> +    err=3D1
> +  fi
> +}
> +
> +trace_test_buffer() {
> +  echo "Testing perf trace's buffer augmentation"
> +  if ! perf trace -e write --max-events=3D1 -- echo "${buffer}" 2>&1 | g=
rep -q -E ".*write.*buf: \"${buffer}.*\".*"
> +  then
> +    echo "Buffer augmentation failed"
> +    err=3D1
> +  fi
> +}
> +
> +trace_test_struct() {
> +  echo "Testing perf trace's struct augmentation"
> +  if ! perf trace -e clock_nanosleep --max-events=3D1 -- sleep 1 2>&1 | =
grep -q -E ".*clock_nanosleep\(rqtp: \{1,\}, rmtp: \{1,\}\).* =3D 0"
> +  then
> +    echo "Struct augmentation failed"
> +    err=3D1
> +  fi
> +}
> +
> +cleanup() {
> +       rm -rf ${file2}
> +}

It can be nice to have a trap handler clean things up, as well as to
say a trap happened (as will happen with any non-zero exit with "set
-e" above). There's an example here where the function of the trap is
printed:
https://lore.kernel.org/lkml/20240813043439.933329-2-irogers@google.com/

Thanks,
Ian

> +
> +trace_test_string
> +
> +if [ $err =3D 0 ]; then
> +  trace_test_buffer
> +fi
> +
> +if [ $err =3D 0 ]; then
> +  trace_test_struct
> +fi
> +
> +cleanup
> +
> +exit $err
> --
> 2.45.2
>

