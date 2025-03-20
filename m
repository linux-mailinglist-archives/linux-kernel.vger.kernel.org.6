Return-Path: <linux-kernel+bounces-569287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E87DA6A0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B34A8A3ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E9620DD72;
	Thu, 20 Mar 2025 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kev/cw27"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63518C011
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458528; cv=none; b=bSHyw7iXpEE62WpVkUClB08iHEv90NggDHacLAX44y1zxIalDYuZwJ6FqY65S8HsjtThP9f1xeUBbmVTnNuBrRdWyTqHVQDU3Xf6AbsHuj6pa5TT8v/G7TMZ+5G59ubVyhwL0rEzeDN7z+t5/n20Bh1zxQRRuwTjj7HVUjOF3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458528; c=relaxed/simple;
	bh=5ApO/4Mq6/c/yyrAg2ZeBEOh7YyHDdK7eqqrHOKWL5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SG9AdRtTx+jW3fLoWV/p/1rWm9deHHg8Lh2FgOtlpegzppvyTPEjyF+byU3wLBCrW7kCYGo0eMxjKbM3IP8DQF6Goe/gRdHEZw2RWztmEpVE/N4tXVlxrpqy+fLCJN+BDgcFJtPyZDwDhBmlTA4UQ7jJ3zLkMwhWoJCwNMia8yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kev/cw27; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5499614d3d2so606752e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742458525; x=1743063325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ApO/4Mq6/c/yyrAg2ZeBEOh7YyHDdK7eqqrHOKWL5U=;
        b=Kev/cw27AYXer69vbXq6N0+uRvtggh6UmLSuZGy+6EROHfMDGACgV2g7KF6Yf7YFly
         5nE26pzOvH0gdB7hrKqHTjBZYNC6r+HQ/inLXRyw+d71R8KZqZzHcgmzlSxAz9moLflM
         0pheaWFVy7IDyjbDQmAc1cFfN5JRUovDRwjlTLOYTA9XHZgLh7QYH162HaW7oO3JD7nm
         pLop8X9PevpF6cVlZMkiXMsgnv9PTxTm6M8ph5b0qLsnP7pudypwPidaF/QRXirJV+OZ
         Ob24i700guTuJ+waTHCQQ/Bj4IzYnxe9qqZsWtXhGeXm2ZnLhuDlVjsKJ56tL2fdKcp1
         pgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458525; x=1743063325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ApO/4Mq6/c/yyrAg2ZeBEOh7YyHDdK7eqqrHOKWL5U=;
        b=CzGjnx284a7jaiyXJqu59c7nbVVl1En4yp3JdRb99hrhzCCINrrd2tQ79fgYhxfsx1
         idzCgVxRU2+Fd5hWs3rq3Hm8FKHXXGMoISorIWq1ekI09iQwZXt+s+PW3DPYuDVwiWtk
         b+WgjQ6oinCY99UftboNjxlVKHav0qMaNDb514M+8KYpkYVoxsdRF6ZY0E5EggKwoNtn
         NqNxY8tn0qEBckcD2FtehFFcwsXXHo9Aa2VZ+p6z5tnQeItkPp0iQPGHOaVnC3dDBJVq
         L2/IAT9kNmQEnIOw0iW2E3BDy01clPsR7ax5uaHygwuGAesW2gBFndXrFnWrMppDWRpo
         azJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2WeiAE9GN6RD6+eBQpszz0oZ6HIdr5vLYRDoMmIMlEwjeU5gdSCptBlMv1Hv7lHaWW7Zgd+eihjTOL2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGEJgz6JywKB44xBOiuS9sNUi1Hcv4WyEHm6Vtxnw9b/OvkAp
	aI5oUzqX50wZcxjeOgJIdx4NVZJkbqR/uun8Qe53fVt/sTRriYkNCm2vShgmCrh35B7dnyQloSj
	f/hm2EKVEHMFEhTQE9JFoPKQJoX6FF9wHcX5q/XDsr3EQSePJcvn0cQ==
X-Gm-Gg: ASbGncuOrKE2f8DISKhc/1WxUfzHzJ59v124o7ZNgs2KxzvImGKSEFUMCvTKOCMN9KF
	AT6hCA+eEvGRiMMwXxYUrPg/KyW/uX1nFVC8p+AzY09r9s327NiMfBZGd5NFecoPzrJq3tt5/zM
	YSNYoxdXYv1LG8h5v/XIqE2DtljJkHzfFuAQ==
X-Google-Smtp-Source: AGHT+IFt36qrZTs3jVigV6s3o6UseGY3Us8oFZFiBf9nDZO8WAVJKTGbrIYvbTde8JRkHb4C+HxFUH8jfnNdOZIUwPY=
X-Received: by 2002:a05:6512:39c7:b0:549:b13a:5d7f with SMTP id
 2adb3069b0e04-54ad067f248mr760711e87.41.1742458524964; Thu, 20 Mar 2025
 01:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318105932.2090926-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250318105932.2090926-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Mar 2025 09:15:34 +0100
X-Gm-Features: AQ5f1Jq4MkD-TA_HtM3sgjv-P_RV51WIW1wiOeKXspOTGRepAHST2Ro8gvkc5rQ
Message-ID: <CACRpkdbTKytFgdqyDajpcfENagSXPZhG5hbpQiGF23VHqLd9_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pinctrl: nuvoton: A few cleanups and a fix
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, Shan-Chun Hung <schung@nuvoton.com>, 
	Avi Fishman <avifishman70@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 11:59=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Convert Nuvoton drivers to use pin control provided data types
> and more of device property APIs.
>
> While doing that, fix one non-critical issue that sparse complains about.
>
> Compile tested only.

Patches LGTM and we are close to the merge window so I have
just applied them.

If there are any issues we can surely fix it up in -next.

Thanks Andy!

Yours,
Linus Walleij

