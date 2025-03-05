Return-Path: <linux-kernel+bounces-546241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B8A4F842
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF211891886
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F41F4194;
	Wed,  5 Mar 2025 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZX1h+g50"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB6C2E338C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160953; cv=none; b=uF5BJpS8kTwKZo+WaMFOeQvdUKjq2u9fxVN79raQm4kroyu1kt2xQE1l51+GHlSuAkAWIaFbIMcHrX9Q1NXIUempD5Zi16qGEtWoF3M+QNdXEcnSwQ+gEoFGW6flurmL+h3hGummbbZWcW3a/6uVWNm8pxJ4amMYXrKJc/wCRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160953; c=relaxed/simple;
	bh=YgJ7FqNNfYxDm0I1ccxKkOvd8zuPiF2Sp2+E3IVga3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7jfn1PAKyXKeamyjPHidvyA+St6CNGovpJBBE++b56lGejIxgqQx0p2EQ6PfMNNhUMD9v1qyQ+dBmCprFWLgAsacWmgNZoEF6wG3m6a+rgwJVioy/yuqBH4zt80sbChwZClyRWvRjJBD2uLZhKOp/QZH87qC6NeQpBVCMpZnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZX1h+g50; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30613802a59so73060641fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741160948; x=1741765748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgJ7FqNNfYxDm0I1ccxKkOvd8zuPiF2Sp2+E3IVga3Q=;
        b=ZX1h+g50gyZtfi8GVOhSL9P+Iywhb4BguZ5BkK4J+i7aUKCJ7peyBnj8JxqUlLq8DH
         dh2srg5vm7xD/fsSnD62YnYp3+kEYAYpkp2ZGr7QA8v8KXRUKMptKpANFJG3Vss+Q3u0
         5ocWX9jKTBQPNBIxi8kNv3RIZGzalIjcb3Rcd4hslJI9g5WA9FFUuETTh6XMt1CCswQ9
         q5p2bqLzpbsNIq2plsBWrIHwpuO0U4VNqCo3uYPvuuMr3bOo/OCBsbRGVEzCecV9mlbz
         JfuM37HEzANrzJFlRAenR7j9RJe8eZhHcZJwdvqpJ9qgJdp+o4bne+NaCEwFLUhP7HQ8
         rOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741160948; x=1741765748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgJ7FqNNfYxDm0I1ccxKkOvd8zuPiF2Sp2+E3IVga3Q=;
        b=c6QIL+N5XEBiv5Patv0Iw5dFJv/iLoHmrTf5hX3frO/yyHj6LV/R1SKsuBoGo/G0bJ
         Qot7tmGW6xLarJvb8Y/sMth7Ak57CNzaRmNwf4OO+9lVIrcP8qIim1nKld/Xnm++AbxN
         MPXMJVXosii2kbECvtBGsUVtDQL82cARuXyd7CJt8ZuHS8iDhSitHaGRtvez8KsCSP6x
         eTkFn0XcS1ZMAsXJnpUPwWzaUAW8pVE15UHYaNRU+ACP9tZtG+EzzXOHqpssM/wWYl/F
         OBjVWGXicqIo6sybpupwKaHk/y8KufeTmX24pLV+LDOsLn+4YOmPoS24q1oCLpuOHmSf
         ry4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwJXue6UXgy3QqJQBgS01r3hs2YIp64TioOaqHvpyofCmwL4xV4v1ieDZ8HibsaPjUjGBova2HzonMjLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4GJmEMaiE/dAxvRS0xto0uP4ayR9HQK4CIvhqR9rNxFpnyfsJ
	eN4wooBspQc7oQEk9s2/9/7akdHZ05S9hvV1IQg1eRwQAXZMZ3w0isbs5qElOmgzy+dZBv7f0ku
	6jr3OA7nVNuGvk4+YurKJY1gLpszSWu6p8+0tYA==
X-Gm-Gg: ASbGncuLR2myO0WBawJYRFUWvhPV3iaqUXOMEAWMOxxy9DAy/CppTDaST7/kiKix5sA
	jjFoiFkLAT4p4Fuubaly20kJkLbgwK7NuJ+u6/BupFkb/EoTXQCljK7gvRN/Wgn+Wlp3shpr5ko
	MZAYotBxVHDyZbXImqaQCSi9OoYQ==
X-Google-Smtp-Source: AGHT+IFHtDRRBP8bp5gdkXIA/EIpFpVmPLRt714LmAp0yuV8fT6QJ4wXCx6DXthE/zk4hC6vZIUQxWhAmu28h9aTZAU=
X-Received: by 2002:a05:651c:1a0c:b0:30b:b908:cddb with SMTP id
 38308e7fff4ca-30bd7a41efemr6683181fa.16.1741160947020; Tue, 04 Mar 2025
 23:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304232051.2936557-1-pratap.nirujogi@amd.com>
In-Reply-To: <20250304232051.2936557-1-pratap.nirujogi@amd.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Mar 2025 08:48:55 +0100
X-Gm-Features: AQ5f1JpcS2hDMJY0zmeOcS9nhyjweLA5ITBHgv88yn7QrJ2qKvgEdvrG7E06mzo
Message-ID: <CACRpkdYxZ=7RRvjKpQW9_mZG_KDXuAt6kdDZDKWJxx-f1BRvCA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: amd: isp411: Add amdisp GPIO pinctrl
To: Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: krzk@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com, 
	gjorgji.rosikopulos@amd.com, dominic.antony@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 12:21=E2=80=AFAM Pratap Nirujogi <pratap.nirujogi@am=
d.com> wrote:

> Add pinctrl driver support for AMD SoC with isp41 hw ip block.
>
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

OK, driver looks really good after the fixes, it's also simple, elegant
and self-contained.
Patch applied!

Yours,
Linus Walleij

