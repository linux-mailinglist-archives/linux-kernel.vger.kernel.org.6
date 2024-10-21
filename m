Return-Path: <linux-kernel+bounces-374555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84749A6BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F81281AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705181F9419;
	Mon, 21 Oct 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2AVE7x3E"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98811F427B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520288; cv=none; b=vGuhY+hujXZdX1PNXGsZPf914o7E787uf2R2CsvfCvnV6w/bYPy18OCupnnhSAko6L+3+uOnSCf9+rx/6Hm9S5FcRxgXzXAtRfK1fPlekc220KPY9wq2mszbeDMUWAd/hrrIGANxRAbNty9eWhxR9gEgpu9J5mg/6LZ0cFI9wFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520288; c=relaxed/simple;
	bh=WvthH4I73+wIKSdt8grbcNUj+S7QHVBvdB0AaMMt1YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXb2AfkMgWTSukg+0iTLfsqknBoZJXecBn79Jr1c7/0aJ5hwhoGC3MiinPz6TqPAajwPOPrl8h2uMT7Wvg+vaQAgkYRc33Nl7FgsQd4xMsdl3C4BkvlNcs56bmUtBmqtOUGLSCGrkc4ckocabXVWtx9RrwfGBhSjl/lkDN9CiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2AVE7x3E; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so186755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729520285; x=1730125085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvthH4I73+wIKSdt8grbcNUj+S7QHVBvdB0AaMMt1YY=;
        b=2AVE7x3EzD/4fJXlhV53XQXWnv/11ett4aPGOMwE1crAk0kl59mYi0JinvILE1QDp9
         fjQNM5s2Ldm4XvDG/21gCDQYBetfqh4c75jZoxmn0sjFvOyE4oMiUQcC8PPOjbc2wMyF
         yBR11+t6iPF3K2HPgQSS25LWbGFD8V+xOxEWqKFJXUlJMNo/m66CNFnv/J9nDxrDIxxm
         JlzlpcnLGAoc4581b9NBGpLjdkLBFe32wtbaYfHY7tUrpFKKHelOmnXsiJidLE+REbIf
         8RXVhxAxk8cUCUHHVnEAVJc+vdoiA/MByXtV8Zqepkitb7SOPXtZUMDMjtdsy2dLPrpv
         O4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729520285; x=1730125085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvthH4I73+wIKSdt8grbcNUj+S7QHVBvdB0AaMMt1YY=;
        b=PiCHnuOWXiA+Arjqqkssce8/qtqWkHTyNfrtoSgNCyHPCt6qC36tJxKMGIjjb8RGuW
         1wr0YQ4q/1kSpSkGNRvZsCgDHdOBbo2GKc3kXz54amTIJjndQF4qtfo2wGVtuxEI8ZXp
         tW5LsLAZkKs3lrCoLbLr94nOH14nwbQEKC8YELOgXwGUzkCocAT4V3BEeLqTDq05uZbC
         wC6wQ+o2ZDC/pvbTXQ2TLhjMILI0ox9bv6y0kzUGWKmdGWTBAVk2TTR3g9WjaOrFwbBD
         d+5zBWLkoX6nM6XCeN3/Ym+OEC7v7Kn1zHAxZORZxVjRSNN6rbuft4XP93debOBGvHns
         yhrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZUqy+kS+PU5e4k30TJ5x789Y6fUQSgutjcB8t82XHKQDQATmy7dEUXVjoVz60tXYUjpCeQldAadYT8q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx336A+dCpArKMJqANf65WUXyH17TksXt30zsbrM2r/MonosXsd
	ygY4PldI4yEZE8W0grHpDMmsOpWo2spGqp2qkuZAGDUnqf1SX5aVb+WDCUaYoUvFxbUBJn4+n+5
	ho97FgfCIEwJ/BksVX4spbKClTGR9dXtPFrsj
X-Google-Smtp-Source: AGHT+IFgruKJHbzOj8bavpoyjtoJLRB2itu4iY2MB8zphTynxvbFJGxBHXgBw+gN2sPVXofXeLTRW9U93NiGjxCHVSc=
X-Received: by 2002:a05:600c:a08d:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-43168ddcbedmr3664875e9.7.1729520284634; Mon, 21 Oct 2024
 07:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ade4f305fc36868f@google.com> <671547f4.050a0220.1e4b4d.0049.GAE@google.com>
 <CAHk-=wj0HM6Cj24+2mQBU-LmhR2-GBmtA=y80DhKwETsKxnrAQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj0HM6Cj24+2mQBU-LmhR2-GBmtA=y80DhKwETsKxnrAQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 21 Oct 2024 16:17:25 +0200
Message-ID: <CAG48ez0SVmoofg5J9E1=4kd0VRHxov1jMTsqG7uZubjr4TP3hw@mail.gmail.com>
Subject: Re: [syzbot] [usb] kernel BUG in __page_table_check_zero
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: syzbot <syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-usb@vger.kernel.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 10:32=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Because even if I wasn't aware of the syzbot report, it does look like
> a match for what the commit was meant to fix (and may have been the
> source of Jann's report).

Huh, I had no idea syzkaller had already found this one... neat.

