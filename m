Return-Path: <linux-kernel+bounces-524535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D5A3E43F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C927AA7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02BE262D3F;
	Thu, 20 Feb 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1mRL6Abh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDBF2135D0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077490; cv=none; b=CBZIRrGFb3YKsUzetoUbgkG1KjEpb6TdjMbNOjUWcxu4nTKkD+ZT98jWvn5pObOKmc78WAoYFKk97UWu4jn4gbt+PdFpifYA+Ocn/4efH7tvr8mCaoHM4GpfWDkxY9wBC7mpnJ5iYA4QBpunu2Dgm8tGNr+1m5YdwYB//r4481o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077490; c=relaxed/simple;
	bh=AslO4hlSXLLAR6ZVW0kXbJX1cco53316K46hLXXdMCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkEVb4rEUZHc6vcPfpUQmbVwbkCT1HRtXMC7OeW6b7xAPT0TCmWOQ2JnQDF0YLsDC8JA82YmDip2NfVGDwjLqwMlsYARIHq6hGC3jwp6f6WJ2zr5pWOzBJUVh4lhAKG+7iI/gsBKUXHywrLs6zeym3j46jh8sMrG5JgEG6OQrhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1mRL6Abh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22117c396baso16715ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740077488; x=1740682288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhJ69vRwG4/Ip9gplTFM8NFvquX+cS64MkbgZEIwj+E=;
        b=1mRL6AbhCxIQpdEgv2WzfQysad2qAnzvQyBQl/jrb/jytIB+bv6Se1aRr2YpCzxWzG
         be7MyRR248MLsJyCrAoiO/wkFD6Wmfqvgj9Qjduwo4OHRXaO3tTP3SfHKcjW9+FdRSMI
         68Z3j+DCJCohIjCHrd3VVH2N/P3jvVB7LEs1td3oERlhYUhaRzGx9gTrYjwkurXKfCSO
         RtwGV2AzAlFDt4xMCGXkulh/mJYMTkVw7svN+z0ZaKFJCEBAo8v1Uqv204vdYZwjbQ2Q
         +AKHdoQ/j3jiEGr6SSvhndsFPlzjXLsKUx6tfBNG9T9JCotjuMW6rFaCPKB3H6UED0k9
         Ol9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077488; x=1740682288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhJ69vRwG4/Ip9gplTFM8NFvquX+cS64MkbgZEIwj+E=;
        b=e6i/TGHQsMQVs9VyS8HGdOzGxEFdd3XRCv6Aq5Sr1FjqGlKtn85bERfHaFWL0qvbL6
         UrcXy+CV+43hGpvBqb+F7yQDfRPVccCl4GUe6RQf6IdGNS62gv9iIRS0CIqvcSOZP4Be
         SJRKnGUSPbrlCo9iW2nzWSKwL6DoiQzp+Rrcg63DsCn77qhe5lvxEvhFBG+38yJTy5KA
         H5rCZBzjd+1QZFuXtST5v65xFxUR6Yqgw1hWkpF+4Dok+KasTU5++2lUE0HW2WUb3hxv
         joiYAI3zAVX+YAOgKCbKW6me6LXjkvRwKvB1fbWU2DNVNF2yi9AR1HhgTbsc5Li94ojr
         n7lg==
X-Gm-Message-State: AOJu0YzlZYz0LMoUu8w+dfs2orwfOuf96fE7BxV+Il7trCMLsDQ6vHCK
	uj1XeDpbfzW5MD510HEqD9T9Pp4pRWJYzoe8BiSxTuQ6RRrYeA1HeQZNBSvUfeJXkjzaITmjKm/
	XuwpHweRsKoJZrUWr9N2HgwNWrqWMIoku0jGV
X-Gm-Gg: ASbGncs+/2m672hvv5VbIIPl+LkBP8I5Q5Y8IzBoEyBWhGeCAUyygzCn+aTAN6zDsK8
	/Y5YlbgWtojCk13ixsNr1y4Q102Aec2JGt6ol67lOIVblHt6/iNJ0ul5K0cRnoE/4A0rrsDUpBt
	bX1z1giZB8XC0upD3ULrETVL2I
X-Google-Smtp-Source: AGHT+IECDW8S7YlQj87u+f2jRjQ5P9mRH/NzvGozxEWj9dWUJDrgvBXpzR2jzfN1lFZ0KlbMW6x/Z8AGWqTHbzkEko8=
X-Received: by 2002:a17:902:d483:b0:216:6dab:8042 with SMTP id
 d9443c01a7336-221a04180f4mr119475ad.12.1740077487831; Thu, 20 Feb 2025
 10:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116230955.867152-1-rkanwal@rivosinc.com> <20250116230955.867152-2-rkanwal@rivosinc.com>
In-Reply-To: <20250116230955.867152-2-rkanwal@rivosinc.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 20 Feb 2025 10:51:16 -0800
X-Gm-Features: AWEUYZmHbSjeW8HzHoyYmG869PxyzHFXRgpXexLbuZp2OsvcdU8Dmp28AKsYjrs
Message-ID: <CAP-5=fU9ovvb-JopPqQfNaj6xtL=u_WZO-b56RdhBmUw4mY0ZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] perf: Increase the maximum number of samples to 256.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ajones@ventanamicro.com, 
	anup@brainfault.org, acme@kernel.org, atishp@rivosinc.com, 
	beeman@rivosinc.com, brauner@kernel.org, conor@kernel.org, heiko@sntech.de, 
	mingo@redhat.com, james.clark@arm.com, renyu.zj@linux.alibaba.com, 
	jolsa@kernel.org, jisheng.teoh@starfivetech.com, palmer@dabbelt.com, 
	will@kernel.org, kaiwenxue1@gmail.com, vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 3:10=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.co=
m> wrote:
>
> RISCV CTR extension support a maximum depth of 256 last branch records.
> The 127 entries limit results in corrupting CTR entries for RISC-V if
> configured to be 256 entries. This will not impact any other architecture=
s
> as it is just increasing maximum limit of possible entries.

I wonder if rather than a constant this code should just use the auto
resizing hashmap code?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/hashmap.h

I assume the value of 127 comes from perf_event.h's PERF_MAX_STACK_DEPTH:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/uapi/linux/perf_event.h#n1252

Perhaps these constants shouldn't exist. The perf-record man page mentions:
sysctl.kernel.perf_event_max_stack
which I believe gets a value from
/proc/sys/kernel/perf_event_max_stack, so maybe these should be
runtime determined constants rather than compile time.

Thanks,
Ian

> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  tools/perf/util/machine.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 27d5345d2b30..f2eb3c20274e 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2174,25 +2174,32 @@ static void save_iterations(struct iterations *it=
er,
>                 iter->cycles +=3D be[i].flags.cycles;
>  }
>
> -#define CHASHSZ 127
> -#define CHASHBITS 7
> -#define NO_ENTRY 0xff
> +#define CHASHBITS 8
> +#define NO_ENTRY 0xffU
>
> -#define PERF_MAX_BRANCH_DEPTH 127
> +#define PERF_MAX_BRANCH_DEPTH 256
>
>  /* Remove loops. */
> +/* Note: Last entry (i=3D=3Dff) will never be checked against NO_ENTRY
> + * so it's safe to have an unsigned char array to process 256 entries
> + * without causing clash between last entry and NO_ENTRY value.
> + */
>  static int remove_loops(struct branch_entry *l, int nr,
>                         struct iterations *iter)
>  {
>         int i, j, off;
> -       unsigned char chash[CHASHSZ];
> +       unsigned char chash[PERF_MAX_BRANCH_DEPTH];
>
>         memset(chash, NO_ENTRY, sizeof(chash));
>
> -       BUG_ON(PERF_MAX_BRANCH_DEPTH > 255);
> +       BUG_ON(PERF_MAX_BRANCH_DEPTH > 256);
>
>         for (i =3D 0; i < nr; i++) {
> -               int h =3D hash_64(l[i].from, CHASHBITS) % CHASHSZ;
> +               /* Remainder division by PERF_MAX_BRANCH_DEPTH is not
> +                * needed as hash_64 will anyway limit the hash
> +                * to CHASHBITS
> +                */
> +               int h =3D hash_64(l[i].from, CHASHBITS);
>
>                 /* no collision handling for now */
>                 if (chash[h] =3D=3D NO_ENTRY) {
> --
> 2.34.1
>

