Return-Path: <linux-kernel+bounces-385188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE3A9B33B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1672282E09
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251141DDC37;
	Mon, 28 Oct 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5q3c3mi"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C01DDA14
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126213; cv=none; b=AWacv/mEEB/aDKRhskkjAQKGGNAFUeByHAGriJ0Z8eiqbxaufzhqxRRWqQfXiE4o9W3TdVwDCXF4dSjjXnXIKZrGE6PAtzlHKcealkwySt3YpDn+QVEe8ZtSx101PPsShgxgZGervQqjAS2yqdGSJtDjhar40D2hJQQiYx+6lRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126213; c=relaxed/simple;
	bh=AuCV83JNF5xt/o7+RdWbgGzw1E9aI+J1rqqbiHJI0pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFN+pKD6BBYTalzghTcSiC9LkUcesMLDgfOhhp7DoDCxvXKI5GH/AYPZQHY3rV1gNY+eq6Z4bT1JBfRKB1B7xhjBVxl6vVPm9XGrKZ7za9YcfH1dkkGyDSEFDn2yefFRRSuN7CPTyE/mnpY92gwK8PdNZr32t9U9cMA+nVGpDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t5q3c3mi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53a007743e7so5008456e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730126208; x=1730731008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuCV83JNF5xt/o7+RdWbgGzw1E9aI+J1rqqbiHJI0pk=;
        b=t5q3c3miHHsf2cHayjpY3BNsjRedncYDv+bWgPkRbvUN3MYpMQZETPwOdlZcbD+KxF
         j7EwZGarJJ4ZXh42PXWggkjNtZSigROn6ClvfHrGIuRKjKZVJnYnURqCzG3tjSnwDbDW
         1vOmX3JgyP05iCsajz3sx5ezPugtj1C5SwjzlpT7wXhLIRPsPHFqU+HQ99DTyB8Fg/At
         CePCn5zPkpVj0ADk0t4SAVnfJFOrInuz8Z6VBTuAgCpQUbZcNCK764Y2mmJ5Yn6wlkx+
         4xVejicw0Xdw0hiFEpLKsXoGGr5o3alINb6Es+yjGq02Fz2qZCEJoCLjDHN32QiIfrcj
         7Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126208; x=1730731008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuCV83JNF5xt/o7+RdWbgGzw1E9aI+J1rqqbiHJI0pk=;
        b=cdYNCeTEp7A3s8NMQvaI/WQPlT4BIouYwQ1bnLJ30UNMY6VXKA8AFAWrzX0+wq0iL4
         Y6xpEpCoCoMdQVNuxnBTAjhSfxR4UpcyYVEiHgJixZnvRF4bDiZmix/GND/K7GbDnkqr
         UHN8VZfPF9Shzz3Cx6SbPlSOg5uL3iSc6Pbb9BR9RtBZNhqrDbAXsWW0q65xIBU/6XzR
         mH3lZynN33whNyvoJN/7Q8iOnx5I/sLoO0T5MR9FFqWQbLNFVptKJ9hMpuFf2/E9Ns3O
         6PBOPiXXMz7dbjUXuinewD8+wk2LM6nX5CM8rUo3PY4oQM7vgSQyyjVrCi3rc7gT6thB
         MAXw==
X-Forwarded-Encrypted: i=1; AJvYcCX9sNib688Oykkyyc/8fjFvdDk8MiOqV3bxT3vlHOx1P4s1rxUGA+RjU8w+Zl6A5r7sKzhp//PtvsG3BPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwnrw4jS6C9/gy6E0BOvwKnFw7zCwYM501slUGjBdHFrU6i6Te
	iGgA63PYq9SEe6QNqT/AA18kD/rRGieZm22U3GsP9Jogk0wLl3i5VpCPAiueYfmlbr5eS+M6D8x
	WcwPFaV5ob2Ii2SGjnagavdxPZEAAeryF1xru8Q==
X-Google-Smtp-Source: AGHT+IFMXRyPb+X0jTeOQPVKekZJqG3FwwMxDwb4pHs5ttD6aPRHRy5s8zoMSwymv42X/0WESdQov/Yws8ZdNY7ZJJI=
X-Received: by 2002:a05:6512:3c8f:b0:539:8fcd:524 with SMTP id
 2adb3069b0e04-53b348e576amr3463522e87.30.1730126208152; Mon, 28 Oct 2024
 07:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-kselftest-gpio-set-get-config-v2-0-040d748840bb@collabora.com>
 <20241025-kselftest-gpio-set-get-config-v2-4-040d748840bb@collabora.com>
In-Reply-To: <20241025-kselftest-gpio-set-get-config-v2-4-040d748840bb@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 15:36:37 +0100
Message-ID: <CACRpkdbBAa5piO8BJoxx04spOc22CBJ-zbi82BT9sG54c=csNw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/5] selftest: gpio: Add wait flag to gpio-mockup-cdev
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Shuah Khan <shuah@kernel.org>, kernel@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:46=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:


> Add a -w flag to the gpio-mockup-cdev utility that causes the program to
> wait until a signal is received before exiting, even when its behavior
> is to retrieve the GPIO value of the line. This allows using this
> utility to keep a GPIO line configured even when in input mode, which
> will be relied on in other tests.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Bartosz has to look at this patch!

But overall the idea looks sound to me.

Yours,
Linus Walleij

