Return-Path: <linux-kernel+bounces-342790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A32198930A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A881C229C3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C82770B;
	Sun, 29 Sep 2024 04:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="caL3mMxU"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F1225D7
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727584874; cv=none; b=ATPl3m2AakcD791UgwYIfaRTat/VeHzU90NC7NerEIyhCLjxVMhB52K9fxD3HU6zr5nOu8/0IVo9gjzjv3wzjc8FGtkBpStQzN14lgeD7yKOTmO+9OQ+mPrL21+XpGj6XE4mHVz2VdStz1n6FHUw2E6UNsTJls4jLWuqSaQ6uDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727584874; c=relaxed/simple;
	bh=SMUGHU1tlAHroUFUxOTLiqDZd4Tf7fOdjUDfe7xlMgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcQOdhYiZT+D4kaxP94mxyhAKlrcPQfXxtqKQo3a0r/YE+6+MaSe4ApWKMHEy7LZ5a4oH2mAKIUq8E8BxtkIQiYKIWD3CBTf2KhvZxst1eTFwZ3Y7+h5s/d91bwYghyRvE6rCMDGMQSCzsPG2cLhooJ9GxZb8QlON67NaA6Pp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=caL3mMxU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6d6891012d5so28698817b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727584871; x=1728189671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMUGHU1tlAHroUFUxOTLiqDZd4Tf7fOdjUDfe7xlMgs=;
        b=caL3mMxUwBYIaSCJAvDW5sMooFKThCuGPaYzOuNj4S/GfpfJ5hqwuFTQ9MnwYcWuBB
         El8XGyT0vfkAGduZ27qC+12F/J+Zkqf/C+zWiamasOA1WvbB9o9BBy8EurkdY4PZvxrZ
         RkDNmsqAO6lbLcp5na4Mlx5lKtiOVR9k6whMpAQCuLjYZLomjwtrO0zsNGFijNH1hPa3
         x+yoTFwOuETTAMU67flY4d1bdYutxb5NK3DesAUgNy9+qI3DV/qyhoSTmdQcPU8Yj9GB
         LFXZTNPCsw7JTR12kpnBU4qrhmmVOgihUjeATZdwbJ86KETATnA/Ca6VefXmx5hTr4ZQ
         mRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727584871; x=1728189671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMUGHU1tlAHroUFUxOTLiqDZd4Tf7fOdjUDfe7xlMgs=;
        b=JIZlggQAGlYlWMW+H4wM9jyjIGiS2A7hVXCvtYN+/F/m4uyMtNwhzWun26Yihvsgda
         3gorTlGh5CEpBpQ75B1u1FSryLkPXLz/2/OYzjVGk9mXBj8WlyQHCa+9+bf3f9LwUc6B
         fwg0B+YMJng98Y9YGFM8YzDV0guMXFoI3SoB/+UTPQwh3q23/a4fdqs5WhdGd+rwtBB1
         UlI4Qktbajk46UByod/qJdcGR9BVwo+HzzKPTTtQFHlDyjarJKEpmEBI19vmugtTlMuz
         KNfoRxnn51IuHi8O4G2ADBVjQLbJNPTXA9zzg4KN/rVEv3jGPwxS78pYEMaowHlVrw2Q
         UiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS2D/ID4rejg2moVGHumk+HtuDBpihngrqUFB8OLfbDQwYrVM+P1RME+FSM3l0u7uME885R5WKCo9RdqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQiyfMSgzMhJYFNma9aFp2xpHeuav1aU0hpwNKtbI0t3SKcoS
	W+7cpdkAojwxaW5TZ2Xx44QYUN/fcPYVLgHQ49xm8K8CGFRl26usBPkEvl1jKCjkmicXHIGrwxj
	gztLn4wVEB9qaG1UT7bOxUBHLvHlIw9BJ3yuRow==
X-Google-Smtp-Source: AGHT+IG8c/QIBgXtt/wcc0S3Qo6phz3DG44MEpR9Z8fgUtflC0qMPw0T/Tm/a2T5GSPU1vgnITgG5tJX/MgDJSwzvC4=
X-Received: by 2002:a05:690c:60c7:b0:6e2:1570:2d3d with SMTP id
 00721157ae682-6e2473b69d0mr63444167b3.0.1727584871504; Sat, 28 Sep 2024
 21:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-10-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-10-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:41:00 -0400
Message-ID: <CALNs47sVrMT8n0zmpOsxymkDvE+==s2MXAv+P3oGYmY81cib2w@mail.gmail.com>
Subject: Re: [PATCH 09/19] rust: init: remove unneeded `#[allow(clippy::disallowed_names)]`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> These few cases, unlike others in the same file, did not need the `allow`=
.
>
> Thus clean them up.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

