Return-Path: <linux-kernel+bounces-197361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611068D69B6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D22289756
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E314280055;
	Fri, 31 May 2024 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhXRkxxd"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488C7F7CA
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183706; cv=none; b=Kyw14BPoryajvymePtdf6ApjD9D2jcPdJ7L0O9cZs7L/VvCn/cDcyi2n8h7MQWERyBOj+tJUlP6v97hSVuJOdo9c3+vq0IUmMj4i/9y7HwrX6P4UahyVEGmWLe4iEW4453wYShRmKfCgK4p3m+/mnpaN2Qo0IVpui+3HIpAeB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183706; c=relaxed/simple;
	bh=DOxuXJDFGiDSGnBM10JSe2/b6FVfDcTLoRRhwBzWYek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4Es5FOGN1s0cHj7fplA0wpp6jxggSfhSYalgMgcnKTbdYQHfPjq/MoNkqWVBqRFZDwXYbR9dyLK+EAvvUpODSZDZ4AaNnmjo8GK1Ca9L+3WdN2IMpi98KCQCKO1Uuy0h4rGd8przq3iF5NlzThLPkcRPqhiXB8Kfxn2GcigrJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhXRkxxd; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b03d66861so2679263e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717183702; x=1717788502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOxuXJDFGiDSGnBM10JSe2/b6FVfDcTLoRRhwBzWYek=;
        b=AhXRkxxd11UknfT/znrBJHI+G7AmBnVjiszmeps6rhujozlbpCEp0FJ73wPOTlgphG
         +ITTs7e9wwxO1PaFUYB7IzlJv8pu43btHUBgp1TyXNkmkxuWt3LVrIPl2OJD0XYA9mh6
         opPU8j+lzWvcBirsDCMUYvFxqj2t8BjZQN/ILXShCcq4YmarG9IyrQQuDOMx1DFY0QsL
         rEyHuPPNLAQSnEiZPx8Vj6UzDhVfv5t9SOPS65xUQNtpYnaRKmO8vkNVlA+06Iugk/w1
         KYJ/qQQxuoXOYvlAIuR+mHZCMebOE9c+5H2FKR2//ZLxpOje+pFR0ey5/kdMQgOPEuyz
         pEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717183702; x=1717788502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOxuXJDFGiDSGnBM10JSe2/b6FVfDcTLoRRhwBzWYek=;
        b=Tz5sCi4HJfyP2AMNKoyL30ZR78k1LirvViVfo593bC5wSg1TXhLD5xGndPvfGBXeOj
         hqvB8aZNrwLhhN2FQvl/7JQhl3Axpaje6fkq61IqkHtZzMoSyqOVVJlTiiP3y0v0aBsz
         p7pb8nYF14VF0M8XTY8ZuFm6z/8QN3JD/Lf8uth6FkwDwwYRr6iwTc/IIpbAY6lk5U0/
         2NLKrEnZVnS9ao2RUs2HNiu4pwcf5mHZo/B+d4a0zN8qfU9D1Lw30fJ/sJckkKdp0lfh
         h4jZJ3t4J0RXgnE0TRBViBsuCB3Lse++NmEX3t9BT6evOI+Ne8/Gveb7sdGYGoNEVzH0
         dnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSfqd/5Qvjgx+Kn9K0+RuCT8dg1s4KgO+LNzc0xcum9mq0tQLVGC6ZYQgZZKJezTj0oeC/m0rei+x7D9MEQWHxFYP0riBaeIn5qmwG
X-Gm-Message-State: AOJu0YwlYjYt/chypm+dxqCGJBkTVOf4v0xTNbgKvMGfHtr7dKbk7K/N
	vuTb0hkY5ulBV7lYcGePyhXXa7I8+nx36D8AvYhB4bu+pbsXQ/s5iCcBpstX5H7HEC5kIZfR96m
	bt97tylEcApZQU3CjqFSlFm6jsteY0lxoZ6c=
X-Google-Smtp-Source: AGHT+IGmtmM7bKwJLhbWGIl9xWVX4YsJxWgHgUrY7ytiW5wLvCFUimIy4f6sEzUxLtP2wA6zbTD36mFZi5Y75BrNIA8=
X-Received: by 2002:a05:6512:368b:b0:51c:15fa:b08 with SMTP id
 2adb3069b0e04-52b89816292mr1570758e87.69.1717183702501; Fri, 31 May 2024
 12:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
 <CAMuHMdXGJxwRDRjKQT5aa6off9nQ5WqreK9K-QhJwhUXngYA=Q@mail.gmail.com>
 <CAHp75Ve3-JkNUuF_LT=E53WfEfxt5yizSvoD22a3OvHiPXSRJQ@mail.gmail.com>
 <CAMuHMdXg1GCAqYPy++4UjFN6QsCnfikZdvsz5=2G4j13E3DUjQ@mail.gmail.com>
 <ZlnT_imCNdts8EOd@smile.fi.intel.com> <CAMuHMdV6NijyDia+YocmbCN1P1A=yuSe1qfeUYxKA5KJ-KbgGQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV6NijyDia+YocmbCN1P1A=yuSe1qfeUYxKA5KJ-KbgGQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 31 May 2024 22:27:46 +0300
Message-ID: <CAHp75VehHDikSSPJhc4c8t7jp81bQ_Z+pkqYnM_F87xdJP4Xew@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot message
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, tzimmermann@suse.de, 
	ojeda@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 10:12=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, May 31, 2024 at 3:43=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > Btw, I will take a long lasting vacations (ten weeks in a row) and most=
 likely
> > won't be able to actively participate for this subsystem. Thinking abou=
t how
> > to proceed if something critical appears... Maybe you want a push acces=
s to the
> > same Git repo and in (rare) cases can handle fixes? We may ask Konstant=
in to
> > configure that on git.kernel.org.
> >
> > P.S. This change doesn't seem to me as critical and there is still a ch=
ance
> > that I will have time to proceed, but the situation just motivated me t=
o discuss
> > the possibilities.
>
> Thanks for the heads up!
>
> Np, I can take over if there is something critical.
> If it is temporary, I can also just create my own linux-auxdisplay.git at
> kernel.org and ask Stephen and Linus to pull from that one?

It's temporary, but based on my experience the shared trees work well.

--=20
With Best Regards,
Andy Shevchenko

