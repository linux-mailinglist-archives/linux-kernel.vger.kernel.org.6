Return-Path: <linux-kernel+bounces-527186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9C3A40838
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF3219C65D4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0F220AF98;
	Sat, 22 Feb 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwWxZwtW"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB919D8AC;
	Sat, 22 Feb 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740226261; cv=none; b=jdcRfv2afJwNAjhSPxbTiESQIrpzwEKkLicxHjbOY9S5YyF7bERqpwndiwv8MnfRmS5OYRNe/aRJeZI2/I4lK6UUadYAEutJqJT1vUq2x32ibjae9d7dphXW0zy4cozBt2nptcA/EQOREtiSi3RkeCOctOBtBAyMxGQAfb3Uixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740226261; c=relaxed/simple;
	bh=SZy0xopn3nNoC4+o7RLbVH/J4D8+Z7HpgAFVWjnu+uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=quCWCm5B3GrG7bJ0Ng5bdgZKbWS0Hj8SUU3tvegYniCSP4LD5Pst0COCs1phA4BxVvAXiXPzB8jB7QtFDzBWVRXiLxblWKu+6OCvLapPokfNrvyUX74LJmUFO/340aKkvvASBaz6AZeubfLRcLbnPSvAHeWvyyfNkcWSUuSSCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwWxZwtW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc317ea4b3so769849a91.3;
        Sat, 22 Feb 2025 04:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740226260; x=1740831060; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZy0xopn3nNoC4+o7RLbVH/J4D8+Z7HpgAFVWjnu+uk=;
        b=fwWxZwtWkPz7M9sPzefPWmE8e/CcRY0LY8xizXgtZY+CMLS8SoOrLWTOWm/Att54gZ
         4KZ1Lat9gtjkNCPHmiG1LV2v41DCH00KAay3Zy+Ywmo0ekOv8sGQBILqqa/W2mvQoIQn
         GxUHQSo1pe6+1fyJa7QX6CJEvYRlYegwo8iJPbBvvTwLSS5sS1stbCZgVobBqytaFwEd
         pbdhuNDraqeuRYUbIO3J3VEeH6cjbBMS7xqckyf9K7bfN62HEZ9M6AIkhLli3etET41F
         v4+piMQETOBRbuZPOHA5/bXieZxF1Jf2FWm5Ztu0fcWfkShqzW45aKH3D+NDeVBs+7yE
         FB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740226260; x=1740831060;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZy0xopn3nNoC4+o7RLbVH/J4D8+Z7HpgAFVWjnu+uk=;
        b=T9AFDOk5KJyO3EEFrqMrfjbSh7wSdQWHiKuedFSU1jcW666jnBOcX/45nj/P7X4aO6
         D7s0YCN1xpf3pq0/E4b7m/tSGhYWElAbRGa2rDty4FDLbyUQV0NLLk5qPGeAyyEH08/G
         bYAELMzB5J32Mo97m9phdkf8vRXvV2cTc+meRxB9mIeKzF78PBCHssRDoHlHajFKtLQr
         65qh+eXKQ60RCOV+4i9qq6lcTesK3SfvN6mGgM+IUalb0Pw+y5wW+H7KjKVA5bLeQAhX
         8CdF+p2mg+ouaGs7sxPFBx145KqB/DbImbDnykWLyz4G81R+zI2r2AYIQLWC2x69NG3A
         m4UA==
X-Forwarded-Encrypted: i=1; AJvYcCWQQeGN4hlrZoLKasaGgzZt8yCVcHjJsZsOQJ9Bf9O2/JzLQY6E2IeX1kEMMNs0J6ghai2akVNREUpXOr9XnmA=@vger.kernel.org, AJvYcCX1FrIpEyj8wZHx3Abl7S9X+DFdzChZiu1QSAMx6JPF/O/AXS1Y3TRCB+xucb+u7CBRCEyoSTPrwfEr5VI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6T+q10oqBYU9erZs/c5dWRM4mMTHuO+qHge/waZHwp7bMOcv
	d6fuJMVaksktL43IL6NYuw1vJM1uI0NJy7GyuLYoDgrmiQNCK7kb0x7bRiRah9MvRwxomP3KVRG
	YtRTJcGRmXtTbPVlmV9gAfudwB8E=
X-Gm-Gg: ASbGnctn6GhKPCubO1twKwEEdFQ09No576Xd8HI/o2EHxU/EVQLyPek/JosE3I3yviW
	aepfhR2A6tIUZSSOhk9guicb89c6lUaSS0hOwI0SB5gce9AGkTVMbeNmXwWVJoOIdgULE4TzdQF
	gMF6IBKI0=
X-Google-Smtp-Source: AGHT+IF9fR0qN75T1FT/vAtusAgCeHsxt0QeV7LUuUFzgPjYSOusqdHL4N/moUgnq2JAScG201nrc8w+bXPCElr7+tM=
X-Received: by 2002:a17:90b:3805:b0:2fc:1845:9f68 with SMTP id
 98e67ed59e1d1-2fce7b3a743mr4113663a91.6.1740226259695; Sat, 22 Feb 2025
 04:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <Z7bO1jT2onZFZwgH@infradead.org> <CANiq72mM3tVmT6MQZqpzGEW4hJABVHRiODL0SnP2u+0ES4=pjw@mail.gmail.com>
 <Z7iav4U7k9AJDzay@phenom.ffwll.local>
In-Reply-To: <Z7iav4U7k9AJDzay@phenom.ffwll.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 13:10:47 +0100
X-Gm-Features: AWEUYZmKIXtsS9XyYsnP9W5G6wLA8n8QI4zzDurGyHbuUnb-4n_nqydQW0zhjlY
Message-ID: <CANiq72n5v7wS_YKCegdZ2tU1EapASr10SrR3+Ef3ZypUR8XBQA@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:24=E2=80=AFPM Simona Vetter <simona.vetter@ffwll.=
ch> wrote:
>
> Disregarding the specific discussion here, but this just felt like a good
> place to thank you for your work to bring rust to linux. Your calm and
> understanding approach to figure out what fits best in each case, from "g=
o
> away, don't bother me with rust" through "I like this, but I have no clue=
"
> all the way to "uh so we have four drivers now in progress, this is
> getting messy" has and continues to enormously help in making this all a
> success.
>
> Thank you!
>
> Obviously not diminishing everyone else's work here, just that Miguel's
> effort on the culture and people impact of r4l stands out to me.

Thanks for the kind words Sima, I appreciate them.

Others are definitely the ones doing the bulk of the hard technical
work (i.e. the safe Rust abstractions).

Cheers,
Miguel

