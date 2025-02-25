Return-Path: <linux-kernel+bounces-531218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C860A43DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31AC47A32BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201CB267AFA;
	Tue, 25 Feb 2025 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdwwyCcL"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA626657B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483222; cv=none; b=lVEvCcuUvTw6OKwQPx8hv44yyXdu5RSJLUayC9ajHo0zku7//yVa3ofBm5SPvNKUnINNJRSpeldfCeneWMV5PkKU/Y7L63q/PRF8WqwnOtcUzXvLoYdeaigmNy7YZSv59rz5MbQGBV2r5g+XazVHLjdxTfsC1NsPUArNec61tNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483222; c=relaxed/simple;
	bh=Ta4BgpxfxjKDJ20mL6RIarb8PIWbJrvt0mlVBqL08Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fmn8/mMangv0ZwS1OLmaA2fbbYDScXijHvhpQijA1EAH9Y5Q0KrM0iB2U3WpJw+Pk8x7RKduV8dJNcljXlt7CPCqP1z8evFjzW0yvVjb+xOwty+8rTgkbPcMtcEm0+zCIxBQeu8krs1Iocx5mUk/PN6PQqIZIWtLBzglidqm6l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdwwyCcL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-472098e6e75so246691cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740483219; x=1741088019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta4BgpxfxjKDJ20mL6RIarb8PIWbJrvt0mlVBqL08Js=;
        b=QdwwyCcLk3wx6X3YCkSpS835qrM0/Da7OtLvFtCG5/+1KP8PzLM6vRl6HJH0ICD/f5
         n4rd9rSVs+ygnw0caP/mSur4uBpPq/9HkHJxXxwLt5cFQlk7znLTGy+KxOdJ01dbT1Ey
         VmkbPZV/tmmWOTEEYUqBFlCUy4yv10xtrEZyq/WqyYmvcPcD2EBKphoQuBEY2MC2SBPf
         Ua2LM0ObRs7X7cpPaLh4p8qbcDGY0uzLzIl6ckjAiUjo3O6AYJpIOUoUc4XKcSPYGJoC
         /NE0zrDtbMDNcNDVS2kZfWCDgWS98AwE4bj8oEx0vRcY1MJAuq5TXdssCyaYG2qvReJD
         FoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483219; x=1741088019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ta4BgpxfxjKDJ20mL6RIarb8PIWbJrvt0mlVBqL08Js=;
        b=S2AizxcSnp6zYmaOyWLFfvHBV7tEfpZITl311on9h1YV1VxGYnqAHL1NVOiEbLcqYC
         RT8LaRvujCMXxbKCCV90ufhWqipXwowRRQ+1s5Jz2ROmtnwqP5sgWZRKCl0xjFIfS5IH
         BwTdRvqikuB/d79dJjbQCGiZNIeDEhC1tzeqPDJV63/YjUXm/sMURICdmYTV3B58E82F
         DM/qiPZLiEAkCET4lgId4/+60LoUNC9kdc63/nw/t/Z020EoYzl24mFPSqWd4si0tgIp
         KjptkyeD5kIm3e/OebWfj7vLbRyrvYL8HhzVxat+vhDygCzPJY6TIBAcf5K0OVB1xgGX
         S2Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWopRys6J9y292nATZcHkuw/tp7XHnnU3U5AiJ80yrMgttisIpRkmIjyeDK0WdLuKUzu5B2cgce2vOQxpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGZqZ2YCKSgbJeXIjlQNKrHW2LADv/u4e8cExQtOwW0E+fEvu
	RZRiaeZItI1+pqUxVNjXlQdXf7Lj48lJTuOFsSy7A3rviclXmARQekI4aYxzQC/A2aE680v6eRV
	s1Y565Q2NpEscEeC3N+YnJlz7Vltm1ZZERykh55M81Xh67AegRdwqa2Q=
X-Gm-Gg: ASbGncsDpIb17nfreLCS1nP4oBxIgWIrIPOb27pESU9rjIUVTHE1GDrdh2uO505bphz
	G2eaG3O8+CPPN+lJuqQmP87XueTlOyngi/Ob15mtcdEghnYPxy1DuDwn51rIpA3KSYvBp25kpCF
	2WkgguC/JbPthikCBA9NTNl8t+BTQKp2GvpTCrgw==
X-Google-Smtp-Source: AGHT+IET/v27MCIkeaaMC3Gh/ajvYpr8Wix2qBvkNFg05Vp2NIsgPAEPOcq4Gkpw/hgEpYSU4WtOvrGwdF70tW94tpc=
X-Received: by 2002:a05:622a:1a95:b0:471:f34d:1d83 with SMTP id
 d75a77b69052e-47376e6f153mr3752441cf.7.1740483218972; Tue, 25 Feb 2025
 03:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115-checkpatch-ignore-v2-0-8467750bf713@google.com> <763bd905-6f1a-42a9-9f81-acecd98131a4@oss.qualcomm.com>
In-Reply-To: <763bd905-6f1a-42a9-9f81-acecd98131a4@oss.qualcomm.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Tue, 25 Feb 2025 12:33:27 +0100
X-Gm-Features: AQ5f1Jr1-wymxOiYtkrlZ1UkFRedAs2kEf4aoYC-u6d7-yufgGTqA5eKvVIMl6g
Message-ID: <CA+i-1C30dTL4H2ELNzvYV_yOc+WT=bVKW7R3KQe6=XjRX_jzfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] checkpatch: Add support for checkpatch-ignore note
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 20:09, Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 1/15/2025 7:33 AM, Brendan Jackman wrote:
> > Checkpatch sometimes has false positives. This makes it less useful for
> > automatic usage: tools like b4 [0] can run checkpatch on all of your
> > patches and give you a quick overview. When iterating on a branch, it's
> > tiresome to manually re-check that any errors are known false positives.
> >
> > This patch adds a feature to record in the patch "graveyard" (after the
> > "---" that a patch might produce a certain checkpatch error, and that
> > this is an expected false positive.
> >
> > Note, for Git users this will require some configuration changes to
> > adopt (see documentation patch), and not all tools that wrap Checkpatch
> > will automatically be able to take advantage. Changes are required for
> > `b4 prep --check` to work [0], I'll send that separately if this patch
> > is accepted.
> >
> > [0] https://github.com/bjackman/b4/tree/checkpatch-ignore
>
> While this addresses one issue with checkpatch, it doesn't solve what I
> consider to be a bigger issue, namely to have a way for checkpatch to ignore
> false positives (or deliberate use of non-compliant code) when run with the -f
> flag.
>
> I don't know how many times I've seen new kernel contributors try to "fix"
> checkpatch issues as their first commit, and contribute broken code in the
> process. This is especially true when trying to "fix" macros.
>
> So IMO what would be more useful is to have some way to document these
> overrides in the tree so that they could be honored both when processing
> patches as well as when processing files.
>
> Note that thanks to Kalle's work, the wireless/ath drivers have their own way
> of doing this, but of course that only works if you run the scripts.
> checkpatch run normally would still flag the issues.
>
> more surgical:
> <https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath12k/ath12k-check>
>
> less surgical:
> <https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath11k/ath11k-check>
> <https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath10k/ath10k-check>

Yeah I think the best solution for that would be something like a
.checkpatch-ignore file in the spirit of .gitignore.

Maybe other tools have solutions for that that checkpatch could copy.
The only one I know of is pylint which solves it with code comments.
That makes a real visual mess of the code in my experience. And based
on Konstantin's comments on v1 of this patch, comments _definitely_
wouldn't fly with the kernel community! So I think it would have to be
an out-of-band config, and if that comes at the expense of granularity
then so be it.

(I would support the inline-config approach for a very high-precision
linter, like Rust and Go have, but Checkpatch Dot P.L. is never gonna
be one of those).

Anyway, solving the -f case shouldn't be required for merging this feature IMO.

