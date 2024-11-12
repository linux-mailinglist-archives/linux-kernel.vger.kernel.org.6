Return-Path: <linux-kernel+bounces-406649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D99C61CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE8C285AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99CC219E20;
	Tue, 12 Nov 2024 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSBrVZ5t"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7CB2194BD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440890; cv=none; b=tc+VNiHtJaj8M+T7xJhvIizVVPBuVaiQJPgf1RlUzKBWH7PXtk5/PpUYLQF480EZT2Ehi8SnFWzCiPv6JiPjkaUJroEft9BeG2CBuivdYwJns0TeEJ9Do/n8tH/30fM7zL+9+4Sx/evCRAFlXXxo+N9OMe9F1ltlOpuinfMZB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440890; c=relaxed/simple;
	bh=o8eOdtHtMHFg2vs8SZ/DKu2qO40wUv2AUpZc54PgLH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eP6C/LvKVEZ6KursypLFdv9TZRNR/FDhb1zPoLkdXkgSmiw+IwLTswS2am5hxLAiQpDWIwaMsc8ijofc3410suPkMG1KiSFkJqPJKTMTgQDRcPOB5ZLGmT7nyLf6we0gc3GJvAnfkP61tPCSnrTq3BGaY4UmISSrm+DMX/76YdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSBrVZ5t; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99eb8b607aso874879866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440887; x=1732045687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8eOdtHtMHFg2vs8SZ/DKu2qO40wUv2AUpZc54PgLH0=;
        b=sSBrVZ5tXJ9/IA5CI4u+zs5VRaB9pnFRMuqszy8vMXy9gS5MTyL47Ye94QGCTRSDSD
         V7/p4Vea8bWk+HnI2lUXWZSqOnLeeSG1aACB1xWQ8BKftUxYlHc4ChDETfjc+fxPSh8C
         YnkwORc/eVxRtPPQwtf+UvQwNzlOq4BI56trNeEdUisIVC4HrufbDb6h8LyCGDyDRg3B
         4zizb5rmlJgU6DhHhaBGCejiD1XOFPU7cAJykmcXVv7bSs66iUbNxLwfNtT02fLSGTa9
         iFVBKpZ/QMIgrArM2GeOklPSqEFLeilMr1smTSV+dxwiWzpN97jBeNHvCJTJ1fBpCYhQ
         vhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440887; x=1732045687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8eOdtHtMHFg2vs8SZ/DKu2qO40wUv2AUpZc54PgLH0=;
        b=NnRo557BAixZSh+QIeMLZN1ntoA5udsCzGTAtSZ+C0KP9cB8FFp7ekXVmhNpgohCUD
         V5ph/HuHnl6KkxZejZ0uY7hddKCfd/bwHmn/PTkPwwNg1I9SUCBOG095m4WGBGat5I8q
         poWL/yYTl/FfFjdA5FnXAVTxOoTJ8v1tn9pSk8QZb58SCQVID1NnopU6h+DXFIA1jpVc
         ktgnTCGj3TbKPbN9mXxuLXGP2bFrCr7JP6/UdsTPKFq9Di0PlGOMW0oZqwthpjCEuJUL
         z2CbygV6KJ3CuERpxJWuzk26PgnHMF0EgJQ7u9lFRAPslxr0jjqDWBQXkmwrq9d0UsKn
         6pHQ==
X-Gm-Message-State: AOJu0Yw7dqiT4tgkr7sxRIiFL2Ujh95DinydytFXTyRUm3bNij3/LzQm
	Ksd3GTs5lrFfFW4EioT3ayXtonSLXHM50uz6Sg9gMebFnXrHW1HX/guYSq1YKbm77rBdjCGyq5N
	asPCG1rUWekiNDfuOE9Iz8GF3pDR4udpvif21
X-Google-Smtp-Source: AGHT+IEFgQusI2LRG8yS8c+lKwjb4SOnATX6OL+zJ6TrY0kBJRmVDcTAeTIKs1eTWUeRMWkbTKPLqC6ZZa3hgOujSU0=
X-Received: by 2002:a17:907:318e:b0:a9a:cf6:b629 with SMTP id
 a640c23a62f3a-a9eeff4458amr1685921066b.29.1731440886519; Tue, 12 Nov 2024
 11:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
 <20241107232457.4059785-8-dionnaglaze@google.com> <4ec6b73f-4707-c93a-f046-213ac4d4549d@amd.com>
In-Reply-To: <4ec6b73f-4707-c93a-f046-213ac4d4549d@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 12 Nov 2024 11:47:51 -0800
Message-ID: <CAAH4kHaAqh1R6CGBKXNsO+uQnscwGo0Y06MTny8CebSWK9QMaw@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] crypto: ccp: Add preferred access checking method
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-coco@lists.linux.dev, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michael Roth <michael.roth@amd.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tianfei zhang <tianfei.zhang@intel.com>, Alexey Kardashevskiy <aik@amd.com>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:46=E2=80=AFPM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 11/7/24 17:24, Dionna Glaze wrote:
> > sev_issue_cmd_external_user is the only function that checks permission=
s
> > before performing its task. With the new GCTX API, it's important to
> > establish permission once and have that determination dominate later AP=
I
> > uses. This is implicitly how ccp has been used by dominating uses of
> > sev_do_cmd by a successful sev_issue_cmd_external_user call.
> >
> > Consider sev_issue_cmd_external_user deprecated by
> > checking if a held file descriptor passes file_is_sev, similar to the
> > file_is_kvm function.
> >
> > This also fixes the header comment that the bad file error code is
> > -%EINVAL when in fact it is -%EBADF.
>
> Same comment as before. This commit merely creates a helper function, so
> this commit message is not appropriate.
>

Is this a meta-comment about how the commit presupposes being in a
series with a goal, but should have a self-contained commit message? I
don't know what "same comment as before" you're referring to.
How about this:

crypto: ccp: Add file_is_sev to identify access

Access to the ccp driver only needs to be determined once, so
sev_issue_cmd_external_user called in a loop (e.g. for
SNP_LAUNCH_UPDATE) does more than it needs to.

The file_is_sev function allows the caller to determine access before using
sev_do_cmd or other API methods multiple times without extra access
checking.

This also fixes the header comment that the bad file error code is
-%EINVAL when in fact it is -%EBADF.




--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

