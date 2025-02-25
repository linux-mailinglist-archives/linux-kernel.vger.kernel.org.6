Return-Path: <linux-kernel+bounces-531855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301BA445E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D5A16D0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119E18DB18;
	Tue, 25 Feb 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7MP4qPq"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA718DB03
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500382; cv=none; b=JqkpOPAbeqo9Rl3LeOxrHatOadYbe0eK0GaNWzH8S+5T3Hti/cK3xvXVr7xramZH3q1xhsVQmgoV874Inm2KSVVJr3Zbuf7jNISKVy+mhcLQJbb/T5Rgak78xlR7Rd/+cd+qhSB21h50J/vVA0dkhGpO/MwcuIEptTMcmH7zOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500382; c=relaxed/simple;
	bh=Tyh+RhXcKnxQU4MXzN9oE4S19Yl573Q7D+3G4DQFujQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkO2liEJgAbZA8LJbiHS+roDlKe7cJwf7PArJRpimX/3aL/8YQsiGHzGlFdsRvjcW5DsRd1RAUVmNlSFEAv1ro32cCDnqQQFylLYzGrmgnvqQxWjSjv12f4VF6HaIgrXQkoxBFh3E92VgfNu2W72AV/B5xEdyDYg+Av+9OB+oWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k7MP4qPq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54529e15643so6212715e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740500377; x=1741105177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tyh+RhXcKnxQU4MXzN9oE4S19Yl573Q7D+3G4DQFujQ=;
        b=k7MP4qPqpYeHRONUsUaB3AQiPzI+tT17PAiYqwe2IlNhl31Dvapsrxra/EJ0H9j72L
         B+dt+i9rDsNtc8ts/OlZ7DAQ7m4MHo3AccVCLDYM//BX6La1heOfZbhuvV92Xyzw2hjt
         gExQYfX7ghdb2zt3rw5D2GRSN66mG98ky/dnzNfUX+MEOtR5NdFXoRz+IP7o4CoxydCf
         uLOCBMeHeUE45a+B22Ag5IaWbTrotJLkx5IS5XNoLTZM3i6xcfLik7HBKw2QyNZVFsR5
         BzUhG0VxQPnHg00vjvHJKWvekPRTyGai9J07q0K/tsm7kqvgJUUqZhqa5kayoFh5FJre
         VM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740500377; x=1741105177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tyh+RhXcKnxQU4MXzN9oE4S19Yl573Q7D+3G4DQFujQ=;
        b=ID3SRqSDoO1isxZ/W/bzxd6kWVh06Ha+ErmCklVrBQa68HlATvweladji62q69tD8D
         D/jZ6jfWYmymoyFELCSAQPnaC04TEPhlxONTCVsVwe0kF4veURE/zFoenscpc5VT5SZX
         ixvuAhkoYnIOsx+Sb4diRUl5jX3GVd7QiGIZB9kRNxrsOr86ekUZSl28wChrrdJMAHru
         AM+DBvMiKbooVW3dmUtkowsQZ/dYMwrf5BfS9lcRtTmp0iDkUXmw1Xp++RdNVh/PHj95
         KoyetMWHB8q+wqN0LS6jIBKp4Qi/bG6zGmY27ILoYxP79vd3k1DsuoUKxq09QO1+NDGd
         2yJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkCb2Q7bkMPEIR9dJMh5lTA761bOCqNxweMJnyuzZWDoTW/664TtYHUFsZW8zbdTC2k9g/FWx+Ratlp5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuGeZD5eidFjSP072vGtAS+33bsKUIRl53LTfzFjborv2tOYM
	KxrLFo+VS5VBFWfIgEYZHJL+H663w1fFUTFvmG1QWs5zR1XxFEvhg+/3NVkbPZgvCDU0xq9R7CT
	sewoRyhz54KT869BUVaYoc/c3gdQ8e4gACR/3vA==
X-Gm-Gg: ASbGncvtEyrCUgtxAJ+lv0hDEFku65OxQx7szvmzvBal1yEJxAoVMblf/S8t85eiH0w
	B4007mWKHPa6+T3MZwvfpUOPkaCwMH4mz/CEzWxekXrkHE7NdwLXvFgrwr015/wcwMpLUTIXnkF
	+iIYG/jls=
X-Google-Smtp-Source: AGHT+IFPKsmkV/8GrQlu1UecaEKHzDdnmY+GOqvsye/6W95YDRH8BC1ZvlN9fdjoiYBCyRDAZX7jrfC7MDoNbdARl/s=
X-Received: by 2002:a05:6512:2353:b0:545:240:55ba with SMTP id
 2adb3069b0e04-54838cd2edcmr5801739e87.26.1740500377437; Tue, 25 Feb 2025
 08:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223-03-k1-gpio-v6-0-db2e4adeef1c@gentoo.org> <20250223-03-k1-gpio-v6-2-db2e4adeef1c@gentoo.org>
In-Reply-To: <20250223-03-k1-gpio-v6-2-db2e4adeef1c@gentoo.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 17:19:26 +0100
X-Gm-Features: AWEUYZlYJub0FzdxL7Mpr1knr2_W3_lmRrr6Vhou8bb5JqpMdWieVnvejFVMY8M
Message-ID: <CACRpkda5=nSnYZ5XJsC_A5MhfdPHwcTndjNr4vGfSb4YJ4Bi6w@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] gpio: spacemit: add support for K1 SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>, 
	Jisheng Zhang <jszhang@kernel.org>, Jesse Taube <mr.bossman075@gmail.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 12:50=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:

> Implement GPIO functionality which capable of setting pin as
> input, output. Also, each pin can be used as interrupt which
> support rising, falling, or both edge type trigger.
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

I really like how this turned out! :)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

