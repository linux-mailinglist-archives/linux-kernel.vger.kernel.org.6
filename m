Return-Path: <linux-kernel+bounces-549788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E681DA55743
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9671736FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A292702CF;
	Thu,  6 Mar 2025 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAi2c4wc"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EEB213247;
	Thu,  6 Mar 2025 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291499; cv=none; b=Cmbv8y+5HGo11/C0S56GXqJXLZs3MUki1hfIiaWTENuvKJADCHA/9TtJa50h1f58CD3NC0uEqJJsSEAt041BK+p/7DTuOREPPlamLHFKYzyA6ZnXK+Pnlgl4ToMtIzoV6A2LhAYAagsOxGk59QkuAETHfoROF/BaEJ4jCrhdaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291499; c=relaxed/simple;
	bh=KF/LPtdDSezzoBKwGXXxtooKNC++TTfJBGHa6wz4neE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXzaCyKPznF3PDEyx15VN+ODkW0qE2LBPsIN/OLun7bNevYJ6o3f6yjj2VWlgrQcREJX9sTTrcs13bSvTrbIvA233mhwSeLnvCsPbSFESiGG6ll5WmpSh67wR3HPj46azIShq7CSiqtRmPW+L3C2bo8QN4KZNJ4xM31A7UnXy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAi2c4wc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso272894a91.2;
        Thu, 06 Mar 2025 12:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741291496; x=1741896296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF/LPtdDSezzoBKwGXXxtooKNC++TTfJBGHa6wz4neE=;
        b=iAi2c4wcMn9gZV1OF6nQJjYuFvB/MUbDI3h6T5Hn+MWtkVas0xRFVQUmJgy7qUAfoe
         7OTbxlU9t30TKvfnHjyc1PvnGHwS+S+J0gWMQtvjMqqlzuPiQGD0KEF8bAAg0RkvBYQm
         QRmI900YOosGay4ytBWEwpvufuHF1CoNCFPwCxSxx2UGeIcrASrH8uAqf991X7GeY6Uy
         RDJa8BW90RGY2VRFTNsXBh/Nn2BRvt4T/XlAosTagyhCFcTXRsDtT6W8P9Q9IQus92IE
         QzspiMvKjU97EZweknU57fj7s59zGIjrB8waNeKtsH+ZcHbSSW9uQGeGjWrU0x6eKJWN
         /LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741291496; x=1741896296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KF/LPtdDSezzoBKwGXXxtooKNC++TTfJBGHa6wz4neE=;
        b=nufNdH76wG5mN1GcmLGKWUfwmXJNdv3nLX9g27hjmo7dMr/eZIdB455J+MQEnTopyL
         /A0CYXHWdVe2XWVZ+87jjSB0xFUS+5E18A0R4hnIVokM+JS0viexAlQrYmqC54ofl2PX
         p9TwhYerZb6uYlaZDSdKw+KX6znmuXnwhdEZSLhr9+l7lgg9aat1hQjcU4si6TgU9o15
         rAmbv/yTOIAWiviz88EmYj037h990GmypTBakRqIKG1W7A88ChLpPYhsGced5swo2twV
         pdwWaawBTGFkEWN2ryKr/APdPf71qTlYaEHnH6uNV4iSGmIY2wuDQyxZ1qWGBP30eJ8A
         fnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLdvZRGnzGopLdUlTyv7hJ4rXDFWBhlDEyeVso/4RMC5sEYXDZVhFCYgZ8u2ArsZ5ZAmxuSEhDDX2NjR0=@vger.kernel.org, AJvYcCVMknxMhCjtFJfrBnTOKCYtNuDHqSDm62zos4gsE/GJF35WSRUrT7bYXBa9x2ovQ4uJuOOLHsGc5hWQOgfj2XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bhFNY9mBi5VuOHAikkzUi0CUxMj/SRReGd0qEubcltrZdTOA
	HQAfmEt7tNZPRlVPn8aHLSb3WAdFrkQKxesGqSGihz00zYeh2VqBiV/t2Qe0+nXFJSHrXxam0Dx
	1r6D2/YFhY8cVcS772hAZxRlpsu8=
X-Gm-Gg: ASbGncvhk7ihc1nET/fz2H5pVJDBKGp66zmpUhIDX31ksUCHGFbFFEweBKXuHQ1E1Zg
	3bNpDcI5zk1FFtUkdlVl01DlvO18yGHpr5Ytngi2X1EysX3jueXesQoTZgoGehUaM3NFlE8xHOD
	vsLm/xJoFGItPoEx6eEVZnwBcGxw==
X-Google-Smtp-Source: AGHT+IEm4OX85bA8+CpoWUY8LEDaEKLu7MxGI5PS+e+zjPZeIHnTwgw8j13zNWtRryhrkqUgK5EVjJlcY8sunmurPNI=
X-Received: by 2002:a17:90b:3e86:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-2ff7cf5618amr309159a91.8.1741291496625; Thu, 06 Mar 2025
 12:04:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130-task-pid-pub-v1-1-508808bcfcdc@google.com>
In-Reply-To: <20250130-task-pid-pub-v1-1-508808bcfcdc@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 21:04:42 +0100
X-Gm-Features: AQ5f1Jrf9WWPthRFdvVU-MrqG3HBmUORg8rSNsaW8IEdyGbk2uJZvtc_AsO6TTQ
Message-ID: <CANiq72mDo8QWB_wE4o3qk6xxLKOvPKQ-7rTf=8+09UXdmmhcyA@mail.gmail.com>
Subject: Re: [PATCH] rust: task: make Pid type alias public
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 12:22=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> The Pid type alias represents the integer type used for pids in the
> kernel. It's the Rust equivalent to pid_t, and there are various methods
> on Task that use Pid as the return type.
>
> Binder needs to use Pid as the type for function arguments and struct
> fields in many places. Thus, make the type public so that Binder can
> access it.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

