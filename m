Return-Path: <linux-kernel+bounces-445048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2D19F105A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3251657E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCCF1E2615;
	Fri, 13 Dec 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dioN9aaw"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC251E22FC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102430; cv=none; b=pgLeO+pHqvFHhh8ajYWhBnXqYO/sHglSPGJsFprrcOQrgZdq3EIImN4P/6SI+XpVcm4JMsZmcfLzqvJK+AQgUFLdCT/A5zR9JeikAvzjw8YZ/gPgLzYSZ7lcALgi/mTA0ezi0glpfuTqW2M3UAKX0M0TUOjkJVg2FiqFdtrDUn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102430; c=relaxed/simple;
	bh=KeUbuHRKIgv/HogaL/+ErSJahryWzkcm/96Y35zfph0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn1J8QFK7IIWuzs4M5evC4WzjJoLUfjyqycmdKpGe+jab5Cc1ZCwVrpMw+3k2yDxLhOwKSIxzGsmw7HRiZh6jHFCnqhuRjRuJLeq52KfYUhq2DyeCxCLfPmKICS336XnDSa5l8xAQlyhOFXGQ3mCWILnKnS8GZl5GNtQ8p2enV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dioN9aaw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21625b4f978so125575ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734102428; x=1734707228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOK+EabcLART//wNWq/2bx90ZPHXhDUCyx5nSPtp/mo=;
        b=dioN9aaw/9KMyHpTwSNpp4K2e23br1VUICzq0u7sx/Z2OEIT08f10GnwlPi1FkVhdT
         A8NKn1q3C91kwEPoLS6wYmjZvS1vxfY+t8cVqAqyMQLHWjwybzu8Bn0UEUAMLteCYJNb
         b7AM5IZt0kn77HIEcfGmrve4zEDEVmbuYHnYhPEbmqsAfNow9Bkost0+4+cPi8OOptcH
         gF+CS4pJLqSjF2abo0DXwFHi3zvNTt4k1HitUlvFLvGJiqYu2/QEAykQ7gjOxg2mAMD2
         kP6f0RWNw9jWPX/3fb/mhOihWVLSog9DX8StQv10FIEAi5bG8vgK2T/IeK0ovRky0BWQ
         YRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102428; x=1734707228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOK+EabcLART//wNWq/2bx90ZPHXhDUCyx5nSPtp/mo=;
        b=PteUjPv3+lhhA8Wmv2FxzpT72XsdJSWGGHxgOa9X7RysyBy6Z5BXEe6H+SieUX6xOs
         u4vxCI7dwwEi/LISZ80oWFR+BHehQnD72CKJIgcFnbjoJzC+6mN/KCfto02WJsaas40n
         Jit57x3P06Q//uQ9SWdGpum0urfGw9uRzHolGMPgKXRIC4XqfqnAspU33ia3oJS3ikx7
         kTu4/poc+VR92Ma0bu9FOPiUQMR5I5mY4s1nLpiwnv1pk7C6S2bg+mk5nCkU1RHk9QoS
         4I2uDM9PU/P7K6bDbYLDWrk/5AHmidDK4cPTHzP7LVb8+sJfYXEgm8rivo6wsP+OEtCM
         7d3A==
X-Forwarded-Encrypted: i=1; AJvYcCVKn2QZ5Td4I0TYq2GHox51BoShgMumgFFrUhNeNoG4BC74v/EbS8yb87g/9BTxzsI2PmfOUg4//EgMt84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBo2iXpH5s7JkxxBswOCsJ+VChz4JiycJ8+8m0W4qjEcbSCdR7
	1QZrCgVSvMj2LjpbneWIbYqGaZWrr+ll9NIaPZncWqIFvRyihZFlzoxc6WhCdwLgoKiDvxoyljJ
	O5UnFGpxNQMFYHODEvJpxKXttaLFjpIYGSABw
X-Gm-Gg: ASbGncviNDXcpiMuu6L8xtwRv8F8xdHbrZIuNIVh697FCNC7HR5lk1m6il41/c0OduA
	Z+wGtUvW8TJL/yXQ5bu5+nkJOXMXYaCSP9LlLSA==
X-Google-Smtp-Source: AGHT+IEFkkLrbUVuE/cQvOQQfUpzDKI51xwKn+aUa2wuLKN/e2/s4qkcLn7DHuV9QVymd56Ir4cx8C6BN8kJhz8qssU=
X-Received: by 2002:a17:902:da82:b0:215:44af:313b with SMTP id
 d9443c01a7336-21891d3ead6mr2786695ad.0.1734102427757; Fri, 13 Dec 2024
 07:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
 <hmuzfspqjzb36xlj2x44keihacrrhzj5madqrfbcnhqouzredv@wo75achgkuh5>
 <1818e2ea-f170-4a9c-8d93-2a24f2755a41@lucifer.local> <20241212173609.afd41d1dffbefe0d731ed4ed@linux-foundation.org>
 <695eabb8-ba28-4031-bc4d-66dc4f1d096f@lucifer.local>
In-Reply-To: <695eabb8-ba28-4031-bc4d-66dc4f1d096f@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 13 Dec 2024 10:06:55 -0500
Message-ID: <CAC_TJvcdz854DmBoVRkb_B5j+u-t=4zHkLtHVeB5RJ=bXcBJag@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 00/16] mm: Introduce arch_mmap_hint()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, vbabka@suse.cz, 
	yang@os.amperecomputing.com, riel@surriel.com, david@redhat.com, 
	minchan@kernel.org, jyescas@google.com, linux@armlinux.org.uk, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 4:00=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Dec 12, 2024 at 05:36:09PM -0800, Andrew Morton wrote:
> > On Thu, 12 Dec 2024 22:51:34 +0000 Lorenzo Stoakes <lorenzo.stoakes@ora=
cle.com> wrote:
> >
> > > You've fundamentally violated kernel process and etiquette. I'd be mo=
re
> > > forgiving, but this is at v2 and you've not cc'd KEY people. Twice. T=
his is
> > > totally unacceptable. See [0] if you are unsure of how to do so.
> >
> > This feels excessive to me.  linux-mm averages a mere 140 mesages/day
> > and it seems reasonable to assume that key people are spending their 5
> > minutes to scroll through the email subjects.
>
> In practice we did all miss it, and I don't think it's unreasonable to as=
k
> people to run get_maintainers.pl to avoid this.
>
> In any case, I truly do think this series works better as RFC, I mean Lia=
m
> has already voiced the kind of disagreements I share with it, and we need
> to rethink how to approach it in general.
>
> So if this is simply sent as RFC with the correct cc's (and ideally with
> some review feedback applied - a better cover letter, etc.) then it makes
> everything easier.
>
> As mentioned the timing is unfortunate here, this is a series we really
> want to make sure is properly reviewed before any chance of merge so agai=
n
> this points to RFC being the way forward.

Hi everyone,

Sorry for the delayed response -- I was traveling and didn=E2=80=99t have
access to email.

Thank you for the feedback. I realize I missed some key reviewers in
the CC list for this patch.
When I ran get_maintainer.pl, it returned a large list of recipients.
To avoid over-CC=E2=80=99ing people (which has been an issue for me in the
past), I tried to trim it down to maintainers and a few others I
thought would be interested. Clearly, I got it wrong and missed some
key folks. That was not my intention, and I=E2=80=99ll make sure to fix it
when I resend the patch as an RFC.

On the technical side, Liam is right that the copy-pasted arch code
has inconsistencies (missing checks, order of checks, ...). I agree
there=E2=80=99s room for further consolidation. I=E2=80=99ll take another s=
tab at it
and resend it as an RFC with an updated cover letter, as Lorenzo and
others suggested.

Thanks,
Kalesh

