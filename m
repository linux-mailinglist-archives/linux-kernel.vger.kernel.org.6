Return-Path: <linux-kernel+bounces-178471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC78C4E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58291F210FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DB53219F;
	Tue, 14 May 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRROseLO"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455120DC8
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676691; cv=none; b=XdMvUgxNQWc4m3VBOLtVgFYXVDep6u+jf0Fs7N0aJ/r5xq5Vk7fmBeAz/Km1pCILdcv9Zc96qAHBw+fUwaFcdNgbuzIX6wb4U4WTTb7VLN/SeIfXEYmrSckynnxe3dv0u2gknlfu4Yjg2GlTM341R0BiuF0GCHrz/zAWwTBC7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676691; c=relaxed/simple;
	bh=YpuRcNL1d/RZc0lAH4iyWYQzjYTZObelGFbgjEqMZa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=si36xau98UVNIN+k8tYEh86xQqcT7TTlwt1ymOm1kUZo0NSKttrXiiydTSbqwDYu2VUxNqWS3iOIi630DdwYrroDIbxfuF6dzhO4TjSzju5Dl6UKCV+heZTzBsvMPGFPYG7EoEezE3LgBww6inkv3xG9LNXaT/wgeglVkolhvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aRROseLO; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61be4b986aaso60028697b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715676689; x=1716281489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpuRcNL1d/RZc0lAH4iyWYQzjYTZObelGFbgjEqMZa0=;
        b=aRROseLOaMavXA0W5FbArPt54GVcGw2KyvkFMM3HFHdY6mACaXTJhq8t8zbq+vn6w2
         BfpffEqbZPfUrVabsn+zmw8bM+6BlU0E1V2z5ecE0yA8wsk9m/9w/dUVz548CwFaQ6rd
         k4lgsEV8Wu3VpoWWCvfKfRsDHiB5gfIbRNulki3sFNRHLnZB4fFt7AG9v7QbJhA5Rbr6
         A9Jz50a0f244tlx/aMQx9q/M9QfYQGvMRITJ2syn1mDd/IdftNvx3wipW1adTdUfzAPe
         v757RLhfmoY1/rybimu+7VmI7AAuGosrBymG/oroajTu4Ty3iZJ0jIISwkdlr9RD6q3y
         YNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715676689; x=1716281489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpuRcNL1d/RZc0lAH4iyWYQzjYTZObelGFbgjEqMZa0=;
        b=eK2KArTMfrUJpXKc29kqGPQr7s1LGhMLZ873K09V+FVsLWIr5SfFHrD6qDyujdbPDv
         ktI9x1S0pkqUF7c9fHQ4C7l811M5Pd7fp9ul/qE3jGBOWf6dJZ0PPJ7jzHiEtImTqXW5
         +VMIEBNMJGCqZAg9m2sr54NAGVRooKDwNaFoyQS7WrS7mErLMs75swBYu6bawP6DfrBC
         xA6iT5tMfNjkIQ27xlNS/Unna8UgMX1e7zfUwfPuSV9/fTeFutpvzMwbruJFJj2joA4s
         AWPyVmQERjmQh/GYZb6q6gx7+B9JkOfKLhJFiaLuKVkmeM3RDzMmqbsBRIyT786tAw3o
         5uSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ5dxUlhbJBOiYAdFtMRy3q8j82bRnWA7Y9FjVxWN1j3QtL034Ta6ovH9X9GHXN1Mh6dQKt9QumF/c+6kngxIUJT+bAMF35yM+raxQ
X-Gm-Message-State: AOJu0Yya1D2YKzukEDq07Yj3U5TEdtIBupKsa0MlXqGXFsm05VEvy/4V
	WElHAaIpqBO5+RElmUluUIQWJwnQsefTlyKAMHNmmAja4JBy10Z9dVt0wuIpMdf1CFPsu1mxEq1
	ijxREK912X0qAjG4eOhn+AXDS/LdGbekrsUyW3A==
X-Google-Smtp-Source: AGHT+IEEXncSLeYlRp50wZguJ1swNJ7Rn/eiIzeOU7YbZYMQO/MhNJglXYcod5TE7cTXRGpqohgHa7iMGT7HvYhCpa4=
X-Received: by 2002:a81:7255:0:b0:61b:748:55a1 with SMTP id
 00721157ae682-622b7fc3cc6mr111470377b3.13.1715676689254; Tue, 14 May 2024
 01:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219125350.4031370-1-patrick.rudolph@9elements.com>
 <ZkL2Sdf0NcqaZRZ4@surfacebook.localdomain> <CACRpkdbUye6RhbRNGn6sapARwVUyi5hKS-5VEVBr6ZR6W_KdQw@mail.gmail.com>
 <CALNFmy33wMHBcoU9ei0vVsn0gUM7-0jdkDDq_Loa3=mMWXiWcw@mail.gmail.com>
In-Reply-To: <CALNFmy33wMHBcoU9ei0vVsn0gUM7-0jdkDDq_Loa3=mMWXiWcw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 May 2024 10:51:17 +0200
Message-ID: <CACRpkdZhY_Yz2jHGXWO5_t8Qdey8me0Gytds7V64GYOFoEC2Dg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cy8c95x0: Cache muxed registers
To: Patrick Rudolph <patrick.rudolph@9elements.com>, Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, naresh.solanki@9elements.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:39=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:

> Do you have an example where muxed registers are used in a regmap?
> Is there some documentation available explaining the existing
> mechanism? I'm not aware of anything.

The regmap is sadly undocumented I have had it on my list for a long
time to document this gem, but I never find the time.

You have to mark registers that cannot be cached as volatile, then
enable caching in the regmap with e.g. .cache_type =3D REGCACHE_FLAT
in the regmap config, then it pretty much caches itself.
<linux/regmap.h> has some cache maintenance functions if you
run into corner cases.

(Mark will correct me if I say something wrong...)

Yours,
Linus Walleij

