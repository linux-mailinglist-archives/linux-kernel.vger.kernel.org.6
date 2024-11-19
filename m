Return-Path: <linux-kernel+bounces-414816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD669D2DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B588C28448E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A240BE0;
	Tue, 19 Nov 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWP/MaX7"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F321D2796
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040197; cv=none; b=byGWxdnpTV/KVJsjYuZ2IVvNaZq1YmoA6mKIJ6IAJyupzpVZstS+sXwDjlTkAmIt0oB34qWI+ePCRh0grjZWtJAOe2IWofL5lwM3uDET9mzeqH66iO2nySoaLBmp0bsGY2siz9dgCFBIZBieHP7kSLX/dEe6TPbKHebgom1tUbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040197; c=relaxed/simple;
	bh=ORKmO8vLWafA6MHqOIqUH1zIk53OGnSylIzR+48B7+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA5xsKtHV5QlIGEFCOV3MRMdZPvXf6V6c08bk2uZNprQ+lePGOxd0nOPkzW+/m7IDSY1wvlGxOZ37syO4XvB29hnqMX8gLIic940SIqu09qN+V0SqNvreD+pjhbSkwrmZhIUhMAsnmYKPxSMh32FPmexoZFMMKCGdHamQe2ITl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWP/MaX7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72483f6e2f3so53043b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732040195; x=1732644995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORKmO8vLWafA6MHqOIqUH1zIk53OGnSylIzR+48B7+o=;
        b=eWP/MaX7TFAwwpF8nR/lY91Sg1QiiLo+pY3xfm43p9huNd+dUcONaVXPRawyYErEQ8
         g872iRrzWOm8T/erRi7PXt5L5bQhcUxgRSYNVQS6yu9VZmPqkV/ZJshXp3VSsouFL84H
         SoJKFzfVr2XuDoOYlN4NVf3poOBl7zpziDID7gtJHCItws7a04CrZXk5F8z6L7S/7dy/
         XmGWiB1MlpHngZ9BPbokoKhT17NpkvotD0OxLsrPWY4q7G2EUDhrzx47B8IXPOI+Kaht
         C2z8A7jFSyRQYl2oZbV+4mKDOyXQtfYheQ4Nb0vxSUATUfyhIfzi8so5IIaBo0fgfqVw
         sGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732040195; x=1732644995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORKmO8vLWafA6MHqOIqUH1zIk53OGnSylIzR+48B7+o=;
        b=gAQMaDB4wVBCKBV2q71wV8XH8VfGRkS0ynIC3yIF0gBi4dFkR7dnajglzia79U8SQo
         yEMcl/Xwf54BIsH4S8li0lMwtrlB0WQiIuTBG4uDCpg4/cjp2hDUrm/rUgAUrt3xJIkW
         /naisKgOPvBqSH8rIyNnUpG7rLPTdkMxr+GZQOOlbpGUTh2ZKSYTMYQZNIAxTDMoJnID
         to43fMkKzvGh2Vam/SJFzn4HefuToBDYjJeHbfaHC0HxsZHp7V/gQBGmKQj03T7TIB5a
         WUnlfndhf5lOhxNKosWr6gDEaf/w1fLE1yyoJ+58OOXSQDjhEOgwA080yUmMgXeHCAVA
         iI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKc/L6MU4T0Y6fBvvqBvVC49fR4IXc/gaKUA/fCSY2z57ijb/NcE2K+KtB2XM1nsGcuDkQ/m0HftgATHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwlT9/sRXprAzyTJ0pcdrIN3R73dltTnsLG5FwjLau0jKRqEr
	plhvJDXWVDEZzAvzb//u8eX5prsZeCpo3lctoPCcI/oVlWhc3eC0OUqKCNAWpClOK67J0yHZp5x
	cjQeTMNla3BPv6tr0I5Rg6wg884k=
X-Google-Smtp-Source: AGHT+IHzQmfZ7POzhbjR3U4Wf4moBg0CD9FwBYxfJ1WRdF4fmqXdupgSOES9ubngbNpift2tkO3SziU0izGEWDpMhzQ=
X-Received: by 2002:aa7:8e06:0:b0:724:6702:faa4 with SMTP id
 d2e1a72fcca58-724af94dd23mr5151169b3a.10.1732040195516; Tue, 19 Nov 2024
 10:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-fix-dereference-null-x86-sev-v1-1-82d59085e264@gmail.com>
 <9dd3d046-6949-4e42-ab5a-af505f9b3981@web.de> <CAE8VWiJ62xT9shaEmUTOPF1OAztaWsr57m-wY9jyMJt5WFke5g@mail.gmail.com>
 <ea06c201-5a99-4875-b2d1-3bc4a35e2d5a@web.de>
In-Reply-To: <ea06c201-5a99-4875-b2d1-3bc4a35e2d5a@web.de>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Tue, 19 Nov 2024 23:46:24 +0530
Message-ID: <CAE8VWiJqTB+PB1cFv2Sj8YbRWxgcrua3ZjyeWGF-7uqrsE95iw@mail.gmail.com>
Subject: Re: x86/sev: Fix dereference NULL return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 11:03=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> > For the Fixes tag, I'm not sure which commit hash I should put. Should =
I use
> > the commit where the function was introduced?
>
> How far can the overlooked function return value be traced back?

Using git blame I see that snp_kexec_finish() was first introduced in
3074152e56c9b
and has stayed that way since. Should I just use that hash?

Best Regards,
Shresth

