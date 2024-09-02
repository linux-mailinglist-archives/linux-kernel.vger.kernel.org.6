Return-Path: <linux-kernel+bounces-310815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58296818C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBF41F21427
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70F185944;
	Mon,  2 Sep 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+K5vF/K"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADC178CCA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265201; cv=none; b=o+++dVssVIFnYe4RoLxQJ7EGRa7so+XZWMBBJLAuMot1Y1gHx9Vllq99yybpOrypTGZ7WLp5T3PZ0uaMcdtrphMXu29XjLpHeecel7kKb4ijWo95Z+s9e/67GtggTufNFnA6JPx++kg3xTgzkT9aZ6Ysd4tlHmpfcg9fqdzmwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265201; c=relaxed/simple;
	bh=QVKncY/ogl1m+ykrJZq3BDQZG6MFT2UUuA6XtfpVFlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj4Sdd3i3QUuOD134M063uYViHu/S3KO32JabBNCequYgpnkaZaR27Y0zcRpd8yaidaq61s1WJazaQnEp7iWXmG+Fznu2iRKLoWXxNGx9fjK3cTH6eEOIzr7kcI3oTJqguCxD2a7jT85TRbFzTeTK2OS+D6xuSOY9FUnTLLN7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+K5vF/K; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5334c4d6829so4915404e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725265198; x=1725869998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVKncY/ogl1m+ykrJZq3BDQZG6MFT2UUuA6XtfpVFlU=;
        b=A+K5vF/K5fyXTk4dKZJ+/1V6Jox5mwLDZuSmIixI+bwgU3zlHh33PaqB9YvvKdoqYj
         m78r0PTw9eyN8Eovlvg1wM4ZEQbOEU7ZICFKXfkfGxOi/RaQjRrCzewRVcs121Y+W0MO
         4qpca8EwdFn26FfrqwbOVnZIOBrNQVpSV0fEZWreecUF6hIGm3fzVmhqZMd+RxdqWUZ9
         vCZJ++K8pbbp3zRdduNq6aMHAruxP0BpUUQ3JhvAkcFLDTQH7DvSUqmOxp8P7Ai10v0K
         j4NM4cMPs73e8lqSdaq1wss27/gFcZKk1cDjN+rjGMlwM5pcH/gJPYkD+gsWbMmsNpkS
         9YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265198; x=1725869998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVKncY/ogl1m+ykrJZq3BDQZG6MFT2UUuA6XtfpVFlU=;
        b=xJOa5kmGLjNkuA/r+JVFPUCzEs7IT1HFeb7KnASTuX5PWnxgkbOvusAO3y67EV3SnW
         YmTFreal66mecFZb4uOPDcVhEjF2HrDU+FM2910SCV+GsiSRHQES6Qh0mKr1ywUzwYzb
         atQ+P9TsN7Y1bhfrXWPjKwcAriKZikl4Q0hNsN6HWOC/B44V0BZf5x4BmXgpmWUffmRZ
         Ox+KAn/q46oAwr3hM828HQz8T+diyXfiozUyiCxyyIRJBnztKwoJcPBJpUrmvMOk5l2T
         Qsv9gw0fhJFxmjcboqyNqBXaXcfMHLVgtnKbSEHax6ZFC5yn5XCavCb8++0P/qre42qK
         6dJg==
X-Forwarded-Encrypted: i=1; AJvYcCVoT7W4qvimgYd5A6quEEdJBfrKo4yFtHrXpMiOorFBAwrmpJzDYiRhm2wZPxb0ENknGQPUFfY4Fc96tA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBOw9ku07Oi1nfJ636rpTStMFyGA4ol7Fow9dlZIh5al8cmtFh
	7FCa5yPcIipvEY9/hZtPqzDoy+IBincLLWHLnF+9pll8nPpwDByzpepi4HwrvVhCvbDfMUxZgu+
	fXRKthtynpZOQfItY61juogZn8fqI4rodfqzIgBF1CxCMUmnl
X-Google-Smtp-Source: AGHT+IGu7j/e4CQQ6unTTOGw9xTTI//61KXbUwQdsDPTcTZpM9ziVvFGdiltnuSugjIl5e16Q3k+G8R4pRiqKU4Zihs=
X-Received: by 2002:a05:6512:3e26:b0:533:43bf:565d with SMTP id
 2adb3069b0e04-53546b45292mr6741964e87.27.1725265197247; Mon, 02 Sep 2024
 01:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 10:19:45 +0200
Message-ID: <CACRpkdbC-Qdq63T-izes26kycsqrevQU9qwi_tzzLU3ywoD15w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: versatile: fix OF node leak in CPUs prepare
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 7:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Machine code is leaking OF node reference from of_find_matching_node()
> in realview_smp_prepare_cpus().
>
> Fixes: 5420b4b15617 ("ARM: realview: add an DT SMP boot method")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Collected these two on a branch, I'll try to get a pull request out
ASAP!

Yours,
Linus Walleij

