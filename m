Return-Path: <linux-kernel+bounces-532678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D7CA450D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C93616B0CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDE2356D7;
	Tue, 25 Feb 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=personaltelco-net.20230601.gappssmtp.com header.i=@personaltelco-net.20230601.gappssmtp.com header.b="hqplqFEV"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842E2356CD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740524911; cv=none; b=tsxqNEm+mTjDxdjIq3B6jWT4BSGLxn+E6o8t8wxfDLmeZvYOtS8BF9hQOPSvi3sYGklEKLxhyFsDVD1TSaTf/6zKvXH0pFSGepOuPvaaCCXYwlSKeiZcMQj+cH48QCGyrFDYsmhGb8/wvS4HyS/XEHH39B8JqtpapqknW0/ZXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740524911; c=relaxed/simple;
	bh=VNs+uNKbsgOog+ykksQ+V6UNOoc4YAhlJC8TKboxdKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+YFzV04IO4biONlKcuN2B0AlJasmJISQxZ4OF/3enxIZtwwJ2rZWHt6G/6fsMwwwTB+UlxDiXiE52s+yHkiqJDlqU3Ouy91EuZ8WdUeMPkfka7Lx0ohrDAc58ey/ssoiwI6KQmgjcjJmAezkFlJK2U/0Df6sOdl5+FZZcdQn2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=personaltelco.net; spf=pass smtp.mailfrom=personaltelco.net; dkim=pass (2048-bit key) header.d=personaltelco-net.20230601.gappssmtp.com header.i=@personaltelco-net.20230601.gappssmtp.com header.b=hqplqFEV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=personaltelco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=personaltelco.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c07cd527e4so576101085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=personaltelco-net.20230601.gappssmtp.com; s=20230601; t=1740524908; x=1741129708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWly2J8lVB0HlIyvQqVH+YkHOO56M9iLE6aUYkDuMV4=;
        b=hqplqFEVWNfPlc2c+gsv2/DzXYT9vAhV337cwXgfXnfgZh269+OpXYwy94j3D3DlYp
         9u6qEnDGa4vLCRxyR9e4/yCUZUSf5Jj7fIw4PlTzdDAMRD3YX6QpSHWwqhdO/gRbnBYW
         m1yD+p3/CrXKcJaZtKrgVzGF/w+Wf7Z9kQK3PENzePmlzZri44iuxzv3T1+r4dlRWv+W
         9hEV50H9tCOYY7R9adQ7W6q/+C26pGC4b/xlcKLgnu864JCwv1/GADG1EipLO1jEHO0W
         BrneN2DL1Xv722c4xUe/TUVTfe6YkoAML2S/U/Wlykqwe9eUYEbwfIOOIKRzQgQkJ/EU
         uBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740524908; x=1741129708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWly2J8lVB0HlIyvQqVH+YkHOO56M9iLE6aUYkDuMV4=;
        b=rjoWnb6jDqV2e5aXNI/yAMR0h1M934i10BBQd0X/B10T4Zqmex3cow5SlmZG970sgW
         nGidFRHczzmoSL8z52x1Bs46pwJYBJFLx54uKn/gX8PSJiWfBU8im8tRnSEGs+fgMXHS
         82v4vDnQpM0xEQpHmkI9nnSs4AeUq6R4X8xN6dvpcjwbh5qXHs/cB8Dp+rHbSGAGHAZe
         it1zfV/kZJcH2XZREViHXemEzYM+c56Nb4269IWBVA5ggHxUuTMlkeBF4rPQxiXjbCEw
         XIjiGlpJixTlwJiK/JSodzpEkUbTKv3h3Ba9DJTDRzxsPyIpXtF+0HfU70xO8xSZgKd4
         zgXg==
X-Forwarded-Encrypted: i=1; AJvYcCWCv1qBOxz704Lq7pPQjBnwbWdX7OUkZFi3oOh21RpUiSPVFAySbcgsEi/2buaeXqFi+qD7euD2E28h+H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwukZn4XPV8ejK2arSFCfPUErADFiLYCl1q/964gKa5942xouSz
	UP506BhhY66Uk/E5RK4319RuI4csSxryAeNX9vsZKzF0lSzHYT0BpUzQGFKVDgplSMRXc/ZKMW/
	81JHFyr9hUksdwjAw3vQVAzjeFR/34GNzhTme
X-Gm-Gg: ASbGncsza3idJ6U1k1mf4JXZvxqAhUMqmWLQssXp6DQivjSoCGjDqm2laE2JjBdZZlG
	P83HGD3qYqNtW8U22PB887VjnzXafWTTwdpqCA8goJeptKaAJiuA4BdY5VhQvwntkt+Fa6X8kko
	A9KUuF4FU6JbVZFNBD8TjTFyP3HVbwhkL85T/rJg==
X-Google-Smtp-Source: AGHT+IFAgVwhH4HdLzQV8uBFYFR6SFQGxRRzGSQlemolq5sd/0Q2ovmx5MYigtWBuD3S1eHnRv0E3uyefDA4Fdngr5g=
X-Received: by 2002:a05:620a:192a:b0:7c0:b018:5933 with SMTP id
 af79cd13be357-7c0cef0f10amr2291690085a.31.1740524908641; Tue, 25 Feb 2025
 15:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHP3WfMgm_rYWBL9DAeWUn0ERsdFjb+ySSFxsRLNkj2us6UNQg@mail.gmail.com>
 <CAHP3WfOgs3Ms4Z+L9i0-iBOE21sdMk5erAiJurPjnrL9LSsgRA@mail.gmail.com> <Z745J8VCJ7YNbUiX@gmail.com>
In-Reply-To: <Z745J8VCJ7YNbUiX@gmail.com>
From: Russell Senior <russell@personaltelco.net>
Date: Tue, 25 Feb 2025 15:08:17 -0800
X-Gm-Features: AWEUYZmApdTCESCebWKANwQQwcQDNwAYpndMsaA_qBYxp0CPU-IRG19oqiQEhmQ
Message-ID: <CAHP3WfPqcxcBjQoKHbO3=0-hpJ6oNOeT-C8WP9hYFJqTDPjotw@mail.gmail.com>
Subject: Re: [PATCH] x86/CPU: Fix warm boot hang regression on AMD SC1100 SoC systems
To: Ingo Molnar <mingo@kernel.org>
Cc: Matthew Whitehead <tedheadster@gmail.com>, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	luto@kernel.org, Jonas Gorski <jonas.gorski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 1:42=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Russell Senior <russell@personaltelco.net> wrote:
>
> > More poking/prodding and coaching from Jonas Gorski (cc'd), it looks
> > like this test patch fixes the problem on my board: Tested against
> > v6.6.67 and v4.14.113:
> >
> > --- a/arch/x86/kernel/cpu/cyrix.c
> > +++ b/arch/x86/kernel/cpu/cyrix.c
> > @@ -153,8 +153,8 @@ static void geode_configure(void)
> >         u8 ccr3;
> >         local_irq_save(flags);
> >
> > -       /* Suspend on halt power saving and enable #SUSP pin */
> > -       setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
> > +       /* Suspend on halt power saving */
> > +       setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x08);
> >
> >         ccr3 =3D getCx86(CX86_CCR3);
> >         setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);       /* enable MAPEN=
 */
>
> That's really useful - thank you!
>
> I've constructed a fix patch from your mails, attached below. I added
> your Signed-off-by to the fix, let me know if that's OK with you.

That's OK with me.

>
> I have applied your fix to the x86 tree, if everything goes fine it
> ought to go upstream during the next merge window in ~4 weeks, with
> v6.15.
>
> Thanks,
>
>         Ingo
>

Thank you!

--=20
Russell Senior
russell@personaltelco.net

