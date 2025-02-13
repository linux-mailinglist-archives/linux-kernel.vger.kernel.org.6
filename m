Return-Path: <linux-kernel+bounces-512839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51769A33E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AB7169315
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC5F20CCC8;
	Thu, 13 Feb 2025 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4UojPQA"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1E2063E1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446936; cv=none; b=hNIjNLAA3zmxOlbs6tYprbVFNHuJVGQgA35fj5E9UVs0gf7SG3ji4B8V1Tt6Gp+g1o7nL1rcfDQWIJfHjzpxZ5sAruwV4AxpNtsg2mfttJxu91LVZUMX+hOIG/wiW8JL4Hhs7pqNy6f35MGYU31EH3NC+IbhH/j+kTmde8my8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446936; c=relaxed/simple;
	bh=qXGik90zFEErIbXZ4EVYn0O5awc5+cnFs54/iIUj2Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrdP4a91WpavHW/ByQpEa/1/bHV1oNOiWBsxh1DTWMFdDRp+NWAXR3ucQ7sj36OlxQtRGQJ8UMfv7JfV/rWyZVNTOYQBdXDVzI6sBUADJdBW7qo2Z5wki4maj6JJGR0Jf9kIj/SvqkJicDO6vSxVJnQ8vwzfDma/7kI9bsw/NKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4UojPQA; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30761be8fa8so8577971fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739446933; x=1740051733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXGik90zFEErIbXZ4EVYn0O5awc5+cnFs54/iIUj2Oc=;
        b=v4UojPQAMD2fWxiPP8mzpzQHfDscFWzdBQ3r1lj7WRb7CBo7hPB2beE0NmjP2llnvy
         6UC6zwgC/UqOO6V8UVQ+xRZXurNfn75l/b67DTR+lQZkcSj8TXf27Hd4XRAsJdrenQzT
         7MMq5OTjEDRzNMid6IewJ/siDJ4dJP94MLZ1DOqqNJ/zOyf6gNDQIGdwKsV0M9pv/JaH
         oVb7S3ia97p+9AXyP6nJ1pzJjz312qC7d5WLJf4S5p9y3q29IpGTycNRmRfdebRoAqwW
         CS4mOb+7izxfRUrJG8BEvphqqRgOi3ycJLx53e2ylyHaLEaCTFfS7s50ojE1TzE6TId1
         4YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446933; x=1740051733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXGik90zFEErIbXZ4EVYn0O5awc5+cnFs54/iIUj2Oc=;
        b=cKQxCz0qlPChrklkM9rEyR31vzFS4CB4d0dNlNfp6tvTFilMVA5l1MTVXz4tA9pT64
         LTWRWnEYyrg7pkGi6BhcitYSz9JdBjWb0RUpnpL63uT4+Nv3XMZDT2Z/s+6vA0WUG6P4
         LWTXNeJgvxVOya7X1VQZlDwR7jisSnrfqwzcwLm8wkXbYx6zTwZLWlKfo/91qVCvRfci
         1/j3WrlIrA+VvLLA+A4ICb2dn6haSZ/qhIYVY55uynT4BSjgC9vZoQpocm2eSTJ4hG7O
         g3AL0SViW9g+wEFX8QgVkwkfb0Zl7v4t+w4HaPwzC4984SqAbU2TF3voj5XQB5p7G1X8
         HqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLmrdz7ZeOeqQ0RXBFW3m2+X8ls6lXsjlEiRQUFPpjEeudpnl5++F4SmQZi3CWp963jaFMyLu8qcnHBXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7dwB5dECWnvQevMgi0v6zoGMIvkePWeH5Q/vhPCKnKzyeqwje
	X4c7f3XOjsq5MkH4JAoW9fZHb5Wq3W8j+vCjPnLWK1KGpYGOYQ03OfRBlmJN3z5uJLdyj4RY7XA
	A+ZJjQsjZ9OFh4RfqBIKkbJmMh/s2BB86US4kfA==
X-Gm-Gg: ASbGncvwMPYuz/ec/WmXG7zM/sCIKt6RZTVjc3tbXGSLdlht/Wbup7eeAdR+kv2TA1Q
	Jf0rSa3QpHMy6Xa3g47kUvej2VzVG/IkL02CG2refghyZ63EP9GMi7RkCVrrHwhrDTVMPEgYW
X-Google-Smtp-Source: AGHT+IFVHA1GVeEKScMhYxf6Sfu4AeJhCGGmNc0XDmJ4H8gjxLKVfGQw8pEnoDX3laoXTfatQUM407vchatoIxg0pdQ=
X-Received: by 2002:a2e:8a8a:0:b0:308:e956:67d with SMTP id
 38308e7fff4ca-30914801652mr2362081fa.4.1739446932739; Thu, 13 Feb 2025
 03:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927135306.857617-1-hugo@hugovil.com> <f9b0cc53-00ae-4390-9ff9-1dac0c0804ba@linaro.org>
 <20240930110537.dbbd51824c2bb68506e2f678@hugovil.com> <16bd6bc2-8f10-4b99-9903-6e9f0f8778d8@linaro.org>
 <20250204124615.4d7a308633a15fc17b2215cb@hugovil.com>
In-Reply-To: <20250204124615.4d7a308633a15fc17b2215cb@hugovil.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Feb 2025 12:42:00 +0100
X-Gm-Features: AWEUYZneNXsSWxPyTfgj14jjDig6RDBsUd0vsFJ1m0e682t0ZDeQHJQZeQ9X-9I
Message-ID: <CACRpkda+jac_7KKQDs3UcfODP6kK3W03Q3KtVOCjRV+wo=M8=g@mail.gmail.com>
Subject: Re: [PATCH] drm: panel: jd9365da-h3: fix reset signal polarity
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: neil.armstrong@linaro.org, Jagan Teki <jagan@edgeble.ai>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 6:46=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> On Mon, 30 Sep 2024 18:24:44 +0200
> neil.armstrong@linaro.org wrote:

> > OK then:
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> Hi Neil,
> it seems this patch was never applied/picked-up?

We have some soft rule that the reviewer and committer should be
two different people. So if I do this:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think Neil will apply it.

Yours,
Linus Walleij

