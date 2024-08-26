Return-Path: <linux-kernel+bounces-302132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB80B95FA52
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965AF2846A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30FD199EA3;
	Mon, 26 Aug 2024 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHacH0Pi"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271D14AD0C;
	Mon, 26 Aug 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702632; cv=none; b=nBzb5T4ok6n0jSKX83J9vaS6IxX+vaJ3ZCyNMa8GGcqvHIWMQh05ul1vQgcCbZAniSjF2gqdHiKNlbLkLRFuVzNCGECJAoMdtjD5blc+cz/S/BsgqM4K8JR5CgLaSHW+D3aSGktmIOnOROKHIOgTZdC+59qSYg2p0EbCHagx0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702632; c=relaxed/simple;
	bh=SJ74gEwTuALUMMJ4yxY4RwKZXzLKiT2GaQEX/jOvqNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYwgD8n+CLJSLeBd3W4g6TTFTYAqbA4u2jlOKIYKhDB8/LlKEX5lVktjUBrZc41gaFOLHVKhksaSNNQip4WfQT134mXEA5NSeezIi3netDvVxza+WIVQEXOcXedeqQm/kUAtbGXA1TDmfO3sg29hpProApgErdTAY+pCWEfRK9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHacH0Pi; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3ba497224so497809a91.0;
        Mon, 26 Aug 2024 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724702630; x=1725307430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ObXozr3BJ6v7ZqhdBN9DFf0iC+TTqCIr3HMlLGbcJk=;
        b=ZHacH0PihmMIll6qVLlS490wf8hvxRI/Y+5gQDBa8zCnZsnaW5Xdo3aTNk1Qq66n85
         JBGnUQgsSjGJQG19Nsjd7KOhjPZr0mdG2FlJjVS5Zr51deyUCLtDDb06Tn96fD1HPYMW
         CZsnNwJP+2lsgD2SSR7JaWBhTjbALyG2cKIcaLZ3FTxql8+H7wdrS0NmnGvOSnc6U5Bf
         bqQfkC+5NHuQ2sTqAENwZUE6sjtk3GlgYeMjYRGytPW61CqEsxwCC/NG34TUUaz9Yzhd
         lubmd9Y+o4M0r1gLTq9Shz8qNz2oJmnlPr09FPaZS91SKjJp3gVWiZgAJEKTzgHegsUy
         qFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724702630; x=1725307430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ObXozr3BJ6v7ZqhdBN9DFf0iC+TTqCIr3HMlLGbcJk=;
        b=h9pfxTa45e3u9BJBb0l3+hM2KIsA3ttpWRVOvK23nwL4UNpIeqTW3cOW5WT40KxZUb
         OLvB2i5n3zx2yD+W89T4IYoLXlLRoaWWdXlq5H9kTWver0tJu9o60e8dmvbDtaLyJeWs
         ZcfHkbc4AZ+QBqlFdJAs93YQ/WddCev3q1v0xrEf4Q3aT1UTByT1wm/ih/3bzlkcwqQO
         hR08X6zfWmuHSH3hd/rQR0hi6fLLBzEGoJqaszWk85inE1jK/A1+Ofb7GDqrnA8KqtR8
         S7sdHeEoF0+WsPit94WJz94sSQckNYbXhSOiYNuFoni9oY9Ye/A1eQtTohvu1o/4Stom
         NGAg==
X-Forwarded-Encrypted: i=1; AJvYcCXzgxsfnSd7z8J5md/j9y2zzvAVjbc+/mq7UFuvftKOWrxB9BddYLa9eNuy2MF9KnG0NuS8nGKVxXSkVJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSf+cflGG3b6rwIjvl2JfGlLsEdzq5SfIRrqNVxT7He4m4mady
	gbwQkCmK74W5LFeunDET2V0Apoiqjqvc+rx1/LfHe6GcqtlMh53N3hFMYVSOQwnCdtaDYDlYfzJ
	2R0Dn/ZyujY2iFFrQ/CtnWWN6nIaS5D/Qa5Y=
X-Google-Smtp-Source: AGHT+IF06Qa5kKCgDuixFMP84Oud7TdmALiwNRboY94oox6pPnz2S6FVPKSATudfOFNYzfDRJrY+uZXQgkOB1Cm46Gw=
X-Received: by 2002:a17:90b:188b:b0:2d3:c488:fa6b with SMTP id
 98e67ed59e1d1-2d646d8b377mr7653756a91.5.1724702630001; Mon, 26 Aug 2024
 13:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825221806.253575-1-simeddon@gmail.com>
In-Reply-To: <20240825221806.253575-1-simeddon@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Aug 2024 22:03:37 +0200
Message-ID: <CANiq72ns_Awo3HD+P-hHrAOHQemRirtp3Zvei9OYgfLf8eWncw@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: check for non-permalinks to Zulip
To: Siddharth Menon <simeddon@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com, 
	joe@perches.com, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 12:18=E2=80=AFAM Siddharth Menon <simeddon@gmail.co=
m> wrote:
>
> Zulip links to https://rust-for-linux.zulipchat.com can break in
> case of renaming the topic or channel if they are not a message
> links (which are permalinks).

a message -> message

> If a non-permanent zulip link is referenced emit a warning and
> directs to the zulip documentation.

emit -> , then emit
directs -> direct the user
zulip -> Zulip

> permanent links are of the format:
> https://.../#narrow/stream/x/topic/x/near/<numerical_id>

permanent -> Permanent

> Reported-by: ojeda@kernel.org
> Closes: https://github.com/Rust-for-Linux/linux/issues/110

Sorry, I copy-pasted a template we use for "good first issues" and I
should have not mentioned these two tags, because it is not a bug.
They should be `Suggested-by` and `Link` instead. Also, please use the
standard format "Full Name <email>".

In addition, the link should be to #1104, not #110, i.e.
https://github.com/Rust-for-Linux/linux/issues/1104

> +                            "Use permanent Zulip links when possible - s=
ee https://chat.zulip.org/api/construct-narrow#narrows-that-use-ids\n" . $h=
erecurr);

Hmm... That link seems a bit too technical.

Perhaps it would be easiest to give an example here (like in the
commit message) if there are no better docs about this.

Thanks!

Cheers,
Miguel

