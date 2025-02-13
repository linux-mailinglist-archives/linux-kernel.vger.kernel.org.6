Return-Path: <linux-kernel+bounces-513901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37835A35001
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7F216B0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4802661AC;
	Thu, 13 Feb 2025 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVjmOMo1"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44628A2C0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480298; cv=none; b=eGLPThctDOqkWvgTl8kAwuW77g+YdbALJKvRNP/BN3MpI3DA2YBMDVKT2ckghXjb+syaAID4a1vvE4aJ59JHqbHIrn46ywMd5IEMWGrsdOAO2n3/YkD2Sou84+fYsdzBbU9vTDlmAPyyWS35O+5gAkDOdnc69NRmjlP9pPrRi7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480298; c=relaxed/simple;
	bh=sNgbWg2Ln1zDDwJYcz+1qDOrOpQOEskIYlvgvaBqBSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skmZT+xJm9ywcPRCgxf3p5hJlhNNxyjX3RIzfBKld9Z/S5CdhyG2i5yJU3/s2BCDCeUVsTmO7Z6EDfxKkrvon8Cxcd8ibFMkysD6gLvjw7Lza34mwYFmb3ZiD1f7KhOgmSbV2JJToW0K4VL23EvffXsI6KT+RwKOaNTdh7Xe76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVjmOMo1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5debc731ed5so528a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739480295; x=1740085095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=258vGRRbOwVy6OENYBfSHjWpHpZAItbU5wJLR85AZzA=;
        b=RVjmOMo1i7qgbnOJDxHQSnLQHp42VoNu46hK0581WpscrKP2PHgMdAecokR/F5L8Og
         DdzS8Exc775mmVuSg/468jV5fKZjFMnvwt5qtn1QkEXJk9dm+U1iA+F56K/pLeTZvk57
         yWko4XfnbsewCyNblSNMI9AgHj5ODW/P+fskQ2wkevIgynqxSgCBrZTxBIaQrVWZi+1q
         NnTZ1nMoA0ROQb1qhaEW3vNMJ0APRvgP3uhWx1e0ZRgQXUijB6mZeEIGun+g7bw1NCkg
         vbiBQBnMcHVAYHYKJdeR6Sls0EFprZp77DY2cD4Nj7Zz/VkHtJ5fWkEbDt/7Ag9/SLVq
         hL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480295; x=1740085095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=258vGRRbOwVy6OENYBfSHjWpHpZAItbU5wJLR85AZzA=;
        b=IEeR1+vE7s/C+BbzxFWreJF/slMiDCPQwNf6Mz/Z4ApciZRGWBajJPtg9oz3Yjd//j
         ZXXNSRQA6Fgb5j9ETSC0iMFCJ3qq8euovXx/nzsA9Y7Fr/1c1irvPyC12REv1NJBz6kS
         WIGojUTZuSXnK80RhYU+takRsekeK7loaz4Y1dHAyImMNvBNvbW7f0uaU6ZZ+I3zbYnJ
         3zsHkQT7N7IPsuBgQgiOcZ8BH1qbkJ7Ky9hID2NSI7PGZwB9/EwFy+vtAdUSOOpR5GNg
         +4a+kEqPh5E8TOFK/5OzF3RAl5dIGkqg0PJnVqo9c2hFlZNfL3MWcsjQ5HpCf1SfnRQO
         OzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFXa0oUqjHGhx+VmrvjBFYGMc6lrbjhqthJhuVLq14fSor30KyvWPc7zw5I7AFLDfRnzpgcNo37oKX5Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoM59YUdAVJnE1gbvegXEaza2Qh4A+hajWxXx+HRrSCBHP5ubd
	CSjnDngJH/BttGM8MjlPjqjeYAFx3TDNafVyREXEMxHY8sd6Xi0a8DRV8ZZcDiBXv0RGFqRFsZF
	EgxVe2EZBDRktpk0Aw28t0Q23pkkx1tDs0nlW
X-Gm-Gg: ASbGncuspke30oUxnZPc8qlJYQiSMiJb5rcwbbN4qklXP2Ct4hRu3/da0XZKTfdMp7u
	CQfK3oP944Mdf6Qz7G2WtP1jMMO/euVV+2cnc1/8VWivoOr77G117NOxxn6+TJk+IaswzfIe32s
	2ghMfKlMHqWo5cofmUYJhyljhV
X-Google-Smtp-Source: AGHT+IFJySMtvRK2dUKilYdfebUlvS4l3r38u+g48H98pnvtcKTbzAzTXr8zs5fVWL8COx7sN3C6FZjMu9CLVztZzUw=
X-Received: by 2002:a50:8d19:0:b0:5dc:d350:7561 with SMTP id
 4fb4d7f45d1cf-5dedd2bdfc9mr16263a12.5.1739480294362; Thu, 13 Feb 2025
 12:58:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com> <202502131224.D6F5A235@keescook>
 <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com> <202502131248.B6CC333@keescook>
In-Reply-To: <202502131248.B6CC333@keescook>
From: Jann Horn <jannh@google.com>
Date: Thu, 13 Feb 2025 21:57:37 +0100
X-Gm-Features: AWEUYZng01chR2T4yjPtPB0tf00nANnMY_Bo5WHTIIALgUjTghjkYyl7FSvrrOs
Message-ID: <CAG48ez3ALBtj82PXn7XZ_cJ2ikOgXq3yFi+__DFn1pk0CAGzFQ@mail.gmail.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Kees Cook <kees@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, jmill@asu.edu, joao@overdrivepizza.com, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luto@kernel.org, samitolvanen@google.com, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 9:53=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Thu, Feb 13, 2025 at 08:41:16PM +0000, Andrew Cooper wrote:
> > On 13/02/2025 8:28 pm, Kees Cook wrote:
> > > On Thu, Feb 13, 2025 at 01:31:30AM +0000, Andrew Cooper wrote:
> > >>>> Assuming this is an issue you all feel is worth addressing, I will
> > >>>> continue working on providing a patch. I'm concerned though that t=
he
> > >>>> overhead from adding a wrmsr on both syscall entry and exit to
> > >>>> overwrite and restore the KERNEL_GS_BASE MSR may be quite high, so
> > >>>> any feedback in regards to the approach or suggestions of alternat=
e
> > >>>> approaches to patching are welcome :)
> > >>> Since the kernel, as far as I understand, uses FineIBT without
> > >>> backwards control flow protection (in other words, I think we assum=
e
> > >>> that the kernel stack is trusted?),
> > >> This is fun indeed.  Linux cannot use supervisor shadow stacks becau=
se
> > >> the mess around NMI re-entrancy (and IST more generally) requires RO=
P
> > >> gadgets in order to function safely.  Implementing this with shadow
> > >> stacks active, while not impossible, is deemed to be prohibitively
> > >> complicated.
> > > And just validate my understanding here, this attack is fundamentally
> > > about FineIBT, not regular CFI (IBT or not), as the validation of tar=
get
> > > addresses is done at indirect call time, yes?
> >
> > I'm not sure I'd classify it like that.  As a pivot primitive, it works
> > very widely.
> >
> > FineIBT (more specifically any hybrid CFI scheme which includes CET-IBT=
)
> > relies on hardware to do the course grain violation detection, and some
> > software hash for fine grain violation detection.
> >
> > In this case, the requirement for the SYSCALL entrypoint to have an
> > ENDBR64 instruction means it passes the CET-IBT check (does not yield
> > #CP), and then lacks the software hash check as well.
> >
> > i.e. this renders FineIBT (and other hybrid CFI schemes) rather moot,
> > because one hole is all the attacker needs to win, if they can control =
a
> > function pointer / return address.  At which point it's a large overhea=
d
> > for no security benefit over simple CET-IBT.
>
> Right, the "if they can control a function pointer" is the part I'm
> focusing on. This attack depends on making an indirect call with a
> controlled pointer. Non-FineIBT CFI will protect against that step,
> so I think this is only an issue for IBT-only and FineIBT, but not CFI
> nor CFI+IBT.

To me, "CFI" is really just a fairly abstract concept; are you talking
specifically about the Clang scheme from
<https://clang.llvm.org/docs/ControlFlowIntegrityDesign.html>, or
something else?

