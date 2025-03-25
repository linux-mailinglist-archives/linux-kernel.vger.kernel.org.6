Return-Path: <linux-kernel+bounces-576299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9831A70D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112703A83CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB064269D1D;
	Tue, 25 Mar 2025 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnP5NOkZ"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A625FA1C;
	Tue, 25 Mar 2025 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945079; cv=none; b=MMtJU44ZYC0DRQlBFRfTIW9+uqP5rlb+zy+Mfby+R8iBz8dOhp3sJUUpRWz6MmDeopbH8o9aso5Jep8gD3ZY/pb7/k3LQrOC+KH7yW/NPwDUiJyqKpHK48wMot17azKoBy5vzFh/Nu4I8M6Tl27G5PACzjBHgduVJN7VS0L2i10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945079; c=relaxed/simple;
	bh=mXs6H3oUDdJrT8iiX5WZDDmaBw4vJekRy6YT2nK6t/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOE71L6wyc/NPoH7uew/vPPABF3lNkNp7FFy5U+jrrJ/VwcJgPxEx+hJbVLJE5stkRsLKJ0wo71HSXX5QOSfxEBxMraQySxbSRX8DZz/jYBlCGdTjgtYcXL2zUIieFOBf1+I1fNhL8JnkTDI5xgvZpBY8Pq1KJuSTzd8GxScr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnP5NOkZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3032a9c7cfeso1279552a91.1;
        Tue, 25 Mar 2025 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945077; x=1743549877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reNdsD3iYuO2qUkRkB3QZH4YVcnvK0Jr4eMsQnbWgOg=;
        b=WnP5NOkZZq4WpgPcm4Bh/qCoSG0lX6lWuvhXaNBT6QhVcZ8fLI8XS/Qfw9EzlMcIFa
         tdVq/5WBe6goQn6Ww3ekzEJZHzl/FBub2pYGAMjQd4ubkmhoPhM/r9G3mu7iXDhdzu+S
         fsVqzWekiIlqSAvKy95ZbFqFmC2J5W5rf+bbAl4v2oP3U61HNmahUifTdkGh9uYYKVby
         3f6uu9SZh2VpHhuGaHWUafly7LPFI7WNaPzzhDTb9uBcpYARu3vqfxyzCwhw82CjiSoH
         Dq9nt//v2XSmgGxHw/rsovZSZxEn3s5J+enZBsFnQYPUgsKy/XazXoF4Z7PU0lEsLWWD
         SYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945077; x=1743549877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reNdsD3iYuO2qUkRkB3QZH4YVcnvK0Jr4eMsQnbWgOg=;
        b=DRN65Vl+sdfWZvsuQLH3R+yNobVKsKOCs2dUsxcKWbMtAAdMVNvRe5gZD9pMInfiCy
         Ja8ZGhRFKDx/yDK+Z7NmqnuEh156k7J8JftrliQ+Pr9w8maVlOYxHpARTt1M/yurl6xJ
         7iO30epmR4ADaZiwYMDyFvH3xvTsZ6Yaj8AQ3mI7juuLO16V01UlVyvNd6Po6B1FPL86
         x9F/nXODE6J37uUYc0kr5byiYh987GE7mlkbtDnAagGpo5s3/quIWExpAx4pxbxVoqO8
         FauHZVhMFJFNyepCxhRLBxFkcLmlIIHySnIdsKNwWMSmYZIgF1CfF7+NXspXFRh/dL9l
         84zA==
X-Forwarded-Encrypted: i=1; AJvYcCUKKiq3YX42F6TwAvIssabSIuMDt3Bge9orZZwF55+ajiQ96F3V0ryA2xImRb1MTehvVpOPqBASb0orghw=@vger.kernel.org, AJvYcCVOKJAvDP1oK4YziM+LyA/UivhMj+6yPvin16W7q5dR/VndLC46IfcNmd2/ebzMlejo0Zk6+wLSXTt8qiLmKnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfFrmTKRzioM89D9HGbCEnUXsKyh2LNBOp8ECied76yIThbf+
	ESUAJBCM0a+AJSmaDx7dSl74ot1YrpzGv1DLuxUFf4FCq1fjyXWg9vDPDmbYdjLXs67WRP32+vt
	mRVuoa90BUGhizaRCpQqtXi3LlzA=
X-Gm-Gg: ASbGncuA0twvIHhPONPwQyQQp1CWxgdLRSyIzC4OMmt0gGRde9Z790YnGpi5vD1SAC9
	Z8f1yL2BS+3HSF+cCyYSX1ToSp+U9jPicuC+H79l2x6GwvgB4bLOvgo9JElXkmNre2daGNnk24K
	iayU8GgNB69bQTqY/wjKdrQA3dVg==
X-Google-Smtp-Source: AGHT+IG/b4WcatCGkVzxwi7SGzWpFJnbsb49yP+SUqQGqgu0Dx7YfD5IjzHfsC/xCneQV0PI8FZ26LIsT/lKkHvMLVU=
X-Received: by 2002:a17:90b:4acc:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-3036b3c5905mr2953150a91.1.1742945077076; Tue, 25 Mar 2025
 16:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87pliljcvy.fsf@kernel.org> <87tt7md1s6.fsf@kernel.org> <87r02pb9jq.fsf@kernel.org>
In-Reply-To: <87r02pb9jq.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Mar 2025 00:24:23 +0100
X-Gm-Features: AQ5f1JqvZFzEMqVnNXLtSTWV1jxoKKe9mo-MCjsPt76Pbv7UlAFukcmXGWhZnLU
Message-ID: <CANiq72kV=9YA+jMEJYv-Aqb1pzB528OZcN4wU3_-jJGP8HjBkg@mail.gmail.com>
Subject: Re: [GIT PULL] Rust `hrtimer` support for v6.15
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 12:16=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
>   https://github.com/rust-for-linux/linux.git tags/rust-hrtimer-for-v6.15=
-v3

Merged into `rust-next` -- thank you!

Cheers,
Miguel

