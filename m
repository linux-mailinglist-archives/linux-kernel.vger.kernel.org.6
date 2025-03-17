Return-Path: <linux-kernel+bounces-564508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FEEA65681
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A23ABF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB48171092;
	Mon, 17 Mar 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmvQmwst"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E5155322;
	Mon, 17 Mar 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226372; cv=none; b=GLghyQ7ZEoqyR2P1QrRgY5qhkpPDDo5dxDNjnpKRYTXVy8O9i7+M89xVvWF9spSih8EzXSKbQKlfmB0nBriciA8c9rPzrU+kAjWi/Ou4EX1x22m9mtxh0NkXVkaXycNEO+MpPOBLenG1vbIuLY9g+Fy4rOoR6YYtu9LEKKfLBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226372; c=relaxed/simple;
	bh=N0XXHSoerCz+fkW0gAlHMYillsKvgy/L8Pvju8fyza0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA3jvLhby/jcbKLY7DYDQyd9OPEIeMXD+vTMlAlAPQAmps4e0btIUR4fEGTvF9isvlrPyKOruVNTutQaEYdV+B+yTKXeB3MIfz8AwxyKIvwIET1GoAgm82vb2J2bStOPiXBDzWXbFOdSmDZ6aSnrRpW0Z1V+lGwaD5McJ6Xfh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmvQmwst; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so615864a91.0;
        Mon, 17 Mar 2025 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226371; x=1742831171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0XXHSoerCz+fkW0gAlHMYillsKvgy/L8Pvju8fyza0=;
        b=bmvQmwstYYy3u0cj7D34fJ4uxtp8I3Jp7yHRO1WdoDkjqXbduyxW++v/Ry7EyP0h56
         NF3nqSM+GgFE4YfjYaFiVBckIjMNiFMEbpGh8rsixilm/M8UiK4egdl/4ArYju+zJ6GU
         01PvlHcvds7AcoM/xwE+ianEFMjzWvduBgXyE9eahDonBL2VkdOVURRMJwdT6wG/5Uqz
         PF0NtT1feRa41ptXFati0P2SsdNBm6llaRy/6NReCIhdIGMsTeQrPDbGs4XWydc/IwlG
         Eh3H2RQ3+lk8ln8M6f/NvS5G0LQsRZDn+mJd/1Qe+4y31OkkFAzWZ+GhfW7PIw2ihal6
         qjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226371; x=1742831171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0XXHSoerCz+fkW0gAlHMYillsKvgy/L8Pvju8fyza0=;
        b=qgYS2RiKD9EG4SBV7gJckvfSneaDSLSchgDqhwSzYnwctWGvE/J4Hb7WZL6Lp42miQ
         rbRpMfokg2YTav338iJzOR55gqeLHG7DnOn2TwXgj+VL2r0xcLUWNzkVE65/SipxV624
         p9u0997RsbeVEtCUt7Bn3BUeW5QlbCFCpb54+Ndya+LDXXb+FNC1NhfMKAZ5gfPmwRPi
         a2l/2fsBmaEsORCn2yGF0TbwgE++jfToNclZDImtx8Nu7sLj0vc/OG9T+aP3wEF3luT3
         GHoaBIUblUxwbdHSGg3rrRtmTvgv2vC1s/PhLJO2kXucGHr+UIi2ZDn3MOM3K4UpSzIZ
         vSUw==
X-Forwarded-Encrypted: i=1; AJvYcCV7lEYHT+ry6cKN/0ZEoFlmRkU5hLeiZSAUgisRsdH9bqC7nlXaSrZ+shw0UL9eltDqg47oHNg3G2mwTbxOVp8=@vger.kernel.org, AJvYcCWejVatFYlrrMfHnOR2CaFZ3c3FdRdmEBiWBITt21vRbJDHJbYVqz+e+BaWi8MUTEYI4nOd38Nxj8shuIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmlHPey1CAlt8CzNUiRKKp2qP2B/E4ksC58tNet0xcVdFtstI
	NZZCetKzkhKD7zfDqgRhICN2j5Azz88IJotDRMqUWwmeu8Kncal/erHflYtVSnhVDPZUMLBT0U1
	pYEwWdKQ4Y4TxRXoeJa3UV5WSp4I=
X-Gm-Gg: ASbGncvzyUGsy+MeJUsfKqXTHQ1D2HLl+a40ph3tHlvQK9DS2WBT84mHy658oigymQQ
	r+/nDUD+FPBIhOZvwpd//hd7QQlA+iKXYhdem7eC3KxVF0suLk/yZ1lfYbjR4QN039z4QKJ2DDC
	6aV2sYF4pRvQ3RjsD438vkwoZ1JIErPI//G89Z
X-Google-Smtp-Source: AGHT+IGsWrTravBcGZquqTChLJG6sZsrdkGgwDZjO6DsTAiQ2OaxrCp+Yf91E1I1j0SrEDrf6Qq5rvoM9jANoIT8Hk0=
X-Received: by 2002:a17:90b:38ce:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-30151d68999mr5992647a91.3.1742226370592; Mon, 17 Mar 2025
 08:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D8HVNR3Q3UL8.1007IZIZTQ0XB@proton.me> <20250316185439.913013-1-contact@antoniohickey.com>
 <D8IMV6MH4EVX.3BWHLLY5UGLC0@proton.me>
In-Reply-To: <D8IMV6MH4EVX.3BWHLLY5UGLC0@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Mar 2025 16:45:56 +0100
X-Gm-Features: AQ5f1Jp_2ofObKoGGIUEWuo2lRMEHek0QXhzl1jwrCncDSj8dSCFentnj4Z5HAo
Message-ID: <CANiq72kgNJGqe+3yNHj96UPcA8i7ozbQGf5FWBQcOytZqZ6ZMw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: uaccess: mark UserSliceWriter method inline
To: Benno Lossin <benno.lossin@proton.me>
Cc: Antonio Hickey <contact@antoniohickey.com>, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, gary@garyguo.net, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, morbo@google.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 4:07=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> I don't 100% know what to do here, maybe Miguel can help. Personally,
> I'd think that another v1 is confusing, but I have seen people in the
> past add patches to their already existing series (while incrementing
> the version number). I think it's a good idea to merge the patches into
> a single one that handles the entire file though.

I would say that what is most important is to mention what was done,
i.e. linking to the previous thread(s) and saying it was merged or not
so that it is clear what is being done.

If this is just `UserSliceWriter` and `UserSliceReader`, then yeah, a
single patch seems good enough. It is not a fix, which could require
different `Fixes:` tags or things like that.

Thanks!

Cheers,
Miguel

