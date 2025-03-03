Return-Path: <linux-kernel+bounces-544486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75356A4E20E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606A28837BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE50264F9B;
	Tue,  4 Mar 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7d7ufUt"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACA3267B16
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099450; cv=pass; b=R0wTdVOfQb8bCqi5tJXYGBdXbZfZMKurojcVeqvRVvimq7fXJIkJQz6TTSuZPM0qrNF0/scXZFdnhJCEy1ZR9RGGcdnljaoFAc2DH/N3KqAL679cd793iDIz5vNkutqYMtMREAaA61y3cRfmdGhNH+/fC2wAjHwZrkXjvwkvi9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099450; c=relaxed/simple;
	bh=QQfQeOchMFjMIbBZd9BGjFJG6WdiEeD+IaXEtKwcvFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7furB5mCgtGZox/ewnCczfX7MK+FGdj0vBrbME1GW/BjPqRn2HVmNjdGopzjl4a7j9LYH3J20W3rFP3dB4CQkQp8pEDe4vNPwJRMO2/eIWflLNq/s8B5/jzFJ6ojy4enEOpxzmf4FqwrSgRS3Dt1Y56mh1w7Y8u5k9SQM2DKJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7d7ufUt; arc=none smtp.client-ip=209.85.128.47; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 51FEF40D5700
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:44:07 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dgf2gpMzFxP4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:42:22 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8DE7142723; Tue,  4 Mar 2025 17:42:11 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7d7ufUt
X-Envelope-From: <linux-kernel+bounces-541279-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7d7ufUt
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 2B14B4355D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:34:25 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 02BD93064C08
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:34:24 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E835188B0B7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777191F1317;
	Mon,  3 Mar 2025 09:34:09 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3F17082D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994446; cv=none; b=o7D0n1Jj/tPa77nlB8SLr5aymG6B0cbc1p23dBDTrseSwvwyZYCbEzA74k9kSzLUXsP3wrTZdrzj7Vo07axlYLPNDJXsq46atwLlaldItjlYY1c8AhhzlipRIMmRZlLZte6DT6LIHYZGsyJdw2CtIDX17B8obHpu8Q0Nt8e627g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994446; c=relaxed/simple;
	bh=QQfQeOchMFjMIbBZd9BGjFJG6WdiEeD+IaXEtKwcvFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6amLbtwMWetN33O4RDY2exdgrIsSggH5KY1cCOph6YiDpU9L2rZqTb9MFWb5bFokWkuyjIBoOUPX28u+37Xa4qkO1pyXh/2QZ0uv8g1uL7VzShcNwLwI7pHWksmVeYR83rUj0ckraoEYSHeLXxfTlI9OIezlh89I5gDshDTk08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7d7ufUt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-438a39e659cso28231925e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740994442; x=1741599242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXnZ3E5/TKOVFTli8c7ZgXogoCXoZZU7O3qVHvhvQxo=;
        b=u7d7ufUtjKfmtL9ThHTDuErw2V/XCxyJcYvhw7Hr/ehv4m0IcBDTI1MAtaQ2CMfyJ3
         Sg+w/2czFI3XCRx+g7V08+beVnA5QOc6xMPicRga51Yfw/TcatDHp06aHb3crbsEJ9lI
         U75QXzx3Xhxf3GnzrSJ42Ohlh8JdE2878iObTiafNFzdd7wQW3N6aAPOmNAVRrIjyP5w
         OQfjMEX+Adkrreql3OFNI6BcfFP4Lxqlagr99anFGZGnIEWdAyWJ2ttwmYt2qNvJ2xE7
         YVIj4QuliFGMiYz/KL8jQOybDLcO6gYCQ8P/4vqZiQlMgWoeKa5ZY3LebnFJp4iHvQiP
         7BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740994442; x=1741599242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXnZ3E5/TKOVFTli8c7ZgXogoCXoZZU7O3qVHvhvQxo=;
        b=as8WLMdtQfOSPv5Fn19lEPPhDclLqYZ6NGXYMI+hrJzEYbkQUDIys84/s0VFesD9qb
         cdmKQQNdbbK0/2CsTHEwD72ZAV+7HuHVrBeZG2ty2+N7lwBHNknDS6e75jQIp2bkanY3
         0rJGi7oYoY+6GwP0yqVZ7KVykGFL+rHZPi9gfsdhNkA18s1RMQw3NKGtkeoOvA1YOCoH
         21X+OvAK8O/DiKxPtZR+R5okap6O9IWAJ0JtO64c/3XuDInwGV8gsBFxu7IST/7c+19H
         f2FBs1aUYdMfN1xSAUpZgCoaMaU75h8f++cz8zhcifTeacG5KhMAixnUfPnEdQV/oUew
         Kcrg==
X-Forwarded-Encrypted: i=1; AJvYcCXVU0+XIT0G48W4mBrKE3jfio5euvibfD6kQxJx3yEMEmS5Vnlge+OW3tcBE+WQ/JhPjZCSOeVhXFwOS3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/uoux04CSt3YCQNbdTdLl0XvtsEGJV0xP8Afdsx9IZiDOCdS
	4XzMDOm7oi/XKFIU8Zjk9tfLXsUNTpAU7YozR6bvfnaXbAuh7H13cQw80DFeIxpNytcUrnbea94
	Q4NueAd835erHkAjEuxMptCwnOWkHkUXyJLvp
X-Gm-Gg: ASbGnct3MoXfmMMofL6Fm8wJxpTWWV98xCeeEg0yA0hlAUrK5Eh/UY7GFE7rYdd5UTU
	4jjWleGq3+Eg879VmPwHRQnmt+XIrsXdkltmjvayc2wOR18HsFpI5H+hoQb4q8Uip8lkznGKnoU
	7crw2rxjNiCebiQ82IJAkRHaLE2Ztwcl1tCRlHFZbiCWAfoXs04OWBEWG1
X-Google-Smtp-Source: AGHT+IF7tkX24sQKlhC4282EiZxY+hctHT5EHwLzLcZo0eYUQP0MVXGgfz4uJEhk1VzgcXR0gnLyV/lIaiDtAcofzqo=
X-Received: by 2002:a05:600c:5106:b0:439:9496:181c with SMTP id
 5b1f17b1804b1-43ba67745d4mr107426315e9.29.1740994442374; Mon, 03 Mar 2025
 01:34:02 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303093242.1011790-1-ojeda@kernel.org>
In-Reply-To: <20250303093242.1011790-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 10:33:50 +0100
X-Gm-Features: AQ5f1JpToETt_xPFbUXkjE6L7wUMFuPji7pUB4N-gMgIpy2I89dr701AOdtWuTc
Message-ID: <CAH5fLgg_Ax3x8qLvJCE=0xay7gosaq0w_=xc4zu2dQ7tFV=B5w@mail.gmail.com>
Subject: Re: [PATCH] drm/panic: clean Clippy warning
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Gaynor <alex.gaynor@gmail.com>, dri-devel@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dgf2gpMzFxP4
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-SpamScore: ss
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704155.90347@CYQhzLTNVTwJcz+emxFrqg
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 3, 2025 at 10:33=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Clippy warns:
>
>     error: manual implementation of an assign operation
>        --> drivers/gpu/drm/drm_panic_qr.rs:418:25
>         |
>     418 |                         self.carry =3D self.carry % pow;
>         |                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: rep=
lace it with: `self.carry %=3D pow`
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#assign_op_pattern
>
> Thus clean it up.
>
> Fixes: dbed4a797e00 ("drm/panic: Better binary encoding in QR code")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


