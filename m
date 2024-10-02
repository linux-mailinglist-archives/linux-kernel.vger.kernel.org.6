Return-Path: <linux-kernel+bounces-347380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4601798D1E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA1DB268A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397391E765A;
	Wed,  2 Oct 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOb0wXOb"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3791E7666
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866833; cv=none; b=ASMdHOXyACbmx6WWT8g4mV5FaZDpsdAeeJK0kB26ZRP3hGm3ejLUIEUyWj5AcaVlmFR7mjGMPdyBGry9WPNi9IPGuRkk1kgiM84/tfDX96nT4UqRoqbridqKMrpTEtnSThUQq4E/GyG+CnX23Ue4/8oztq8pI9fwlVfKlRgo3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866833; c=relaxed/simple;
	bh=xLLdgescBmTN3DuUCZqvW/nsMk9thoZPWyFqVcH9v/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkiX3yrvr7yi07O/kZvf06IPDvc9e1Fw9FyeblQgdK5HBvJMqM8fI6mblQViwvNh1mLYS7OS0O/2wMoMfSDrJjwPvTQQfW7IbXdOKdJ7HUsonZW0cJNV936rHX+BfTPHV4pZdLD/OO7BwZme5rXfsPpM0t+deLQvMO3fd8cwFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EOb0wXOb; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e25cc9e94eeso5670725276.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727866831; x=1728471631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmcYZA7/wJjtWP/h4dJKihF0bgwj9/ex9+L3+MEoObU=;
        b=EOb0wXObty2F63xGmDJ+74Ss3AjVGz4KeHgGzCHwI+2LTOWewaii+haMAspZcipXDP
         0AKXjoz4bhZ3x789QhMZ1bu+nFg47UvLfKYQwKcWoJ59CQku4YJb9tkT1cpBiG7sl7ik
         xYbTR4vulrzglPn25f23PhYyuSGSNIMNFE5Q0f8/kfMEWHlbG1tOD896IjXDiWZCn7Uu
         wSQ95WSc1CWc6J3fqT9POnsy/v5QIHRGDO/wOsQZMBtM1FW7wYFuj3mQ5taP3W0ygnUP
         3nRkfL1KH7zeyI0ZMFGwDB/stAbaCq+ymk32+QDdLPvgkydj5zMTuFUk3xK4/F3LBQal
         Xxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727866831; x=1728471631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmcYZA7/wJjtWP/h4dJKihF0bgwj9/ex9+L3+MEoObU=;
        b=ROOA+RHwFQjwQxLS2c2MKebiLn4m7rn6VyDtcAHAZiDwNK0yRzscaphTOe5Lu2G9VN
         B7dhhbyUXgcgAUr8nv3H40CVgNQ/H8moP1/EmYQ54iAKlP/xaKkzCvGRIGLuIxeEprbT
         XVmrg8kk57v/83jXlltx/1fFSkZtE9RMwfC16HSkvC4Os6yq7e/dj+0U58iaj09UX82H
         K21J6liq/oyScwmtNW9ldqVcsH30mex6xt0kkQKm+Okg9NwsjpYTPoS3OusOKHFlP9lp
         b7XwCgndVsgHYG2rE7wFdbO1GrGMrONSgManMkjAuixJ8lNmTIWGEQxUzj4TLlk1L+VK
         woag==
X-Forwarded-Encrypted: i=1; AJvYcCU0O9x1x4oOfX/pKXnmx3NbCuQV/RhqEW46Q4jD0F+vp8+XWNDBptwVrnwJBi0RJHFfce1UNifWXIwoYFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJm04L0fk5oLyfwiUimGrf3TCpx3/Ni/N92DvOjknOUG0K0bK
	Y20J6J16noQbUqkflutRNtysvHc6o6G6o7VG8xTpz4Oo1CWiFzxilzkh17JrlDgOY9buJarsVM1
	iMwpFHuk+Tt3U3T8GBOP6npT7tjWr3A5/YOeeiQ==
X-Google-Smtp-Source: AGHT+IH1/OYH7PyqLLC06P011jS8wjK1A2ttW2EVTz1YfQDhiNruQopqyDimOPKCVrbB2cqpzD/2bH9uqx4KuH6NPos=
X-Received: by 2002:a05:6902:2182:b0:e26:5b7:9f95 with SMTP id
 3f1490d57ef6-e263840f47bmr2076616276.35.1727866830962; Wed, 02 Oct 2024
 04:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919091834.83572-1-sebastian.reichel@collabora.com>
In-Reply-To: <20240919091834.83572-1-sebastian.reichel@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Oct 2024 12:59:55 +0200
Message-ID: <CAPDyKFpWYnqLGdxXc4Wvt_3MNsYkCpRfTJMeUddZzpKTwnY4Rw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fix RK3588 GPU domain
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Sept 2024 at 11:18, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> I got a report, that the Linux kernel crashes on Rock 5B when the panthor
> driver is loaded late after booting. The crash starts with the following
> shortened error print:
>
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to =
set domain 'gpu', val=3D0
> rockchip-pm-domain fd8d8000.power-management:power-controller: failed to =
get ack on domain 'gpu', val=3D0xa9fff
> SError Interrupt on CPU4, code 0x00000000be000411 -- SError
>
> This series first does some cleanups in the Rockchip power domain
> driver and changes the driver, so that it no longer tries to continue
> when it fails to enable a domain. This gets rid of the SError interrupt
> and long backtraces. But the kernel still hangs when it fails to enable
> a power domain. I have not done further analysis to check if that can
> be avoided.
>
> Last but not least this provides a fix for the GPU power domain failing
> to get enabled - after some testing from my side it seems to require the
> GPU voltage supply to be enabled.
>
> I'm not really happy about the hack to get a regulator for a sub-node,
> which I took over from the Mediatek driver. I discussed this with
> Chen-Yu Tsai and Heiko St=C3=BCbner at OSS EU and the plan is:
>
> 1. Merge Rockchip PM domain driver with this hack for now, since DRM CI
>    people need it
> 2. Chen-Yu will work on a series, which fixes the hack in Mediatek by
>    introducing a new devm_regulator_get function taking an DT node as
>    additional argument
> 3. Rockchip PM domain later will switch to that once it has landed

I have just queued up 2) on my next branch.

My suggestion is to skip the intermediate step in 1) and go directly
for 3) instead, unless you think there is a problem with that, of
course?

[...]

Kind regards
Uffe

