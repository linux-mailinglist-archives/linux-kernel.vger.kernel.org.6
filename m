Return-Path: <linux-kernel+bounces-561276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A771A60F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6A6188B1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EF21FC7CD;
	Fri, 14 Mar 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdvc4SYc"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460216F271
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950250; cv=none; b=REefsknSWzMWyHntM1XdRdrNE7Thljlu2YNEuAHIk2i9r0Q+PNB1ymvLrZ19WchbZTPnpXIyJYwBotdBUcjtM9dm9PijErhUpCS2062JRXoc3n7dnI2rRenXMDGPRyL/C2A6UPSCUVS8lgpv3NpVK8YyDjTABRCkzybHXBAfXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950250; c=relaxed/simple;
	bh=T1mrmvRDse09XjyEGMyC8lC24g3f6nvYSCJy1Xo3NzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnxIVJ1/LzD/Ht6cuvDteadoJ+NJsSw5NrtYVZ10znCllQ/SSbvfXgRVugV1I4Nk3Xjv0WOx/6y5fZA+k58bb4/x4up5ia81Ha0NW8NKhpOqR0V3DFT6h3jtuwkl6UsaTYFDGhHz3n001dPsrgw8LaGZy1zsiYvKKLpZFp/MAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fdvc4SYc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54298ec925bso3080369e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741950247; x=1742555047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NiyiUpsfaIqtRcFq6JeHy3gqHpHk2qfaQ/0t696+60=;
        b=fdvc4SYc5OmYdtJapvhgDboASTi+sr2TzS2BO//ij3yRJDCk7XPJ9xRyAhmZ7AYuUb
         SgdeXjIlmAJhQjcdGlbcn1okNTJtLvr7W825iPP/7X/66UgiTBymdJAuvMxJoEbwbkoz
         5qJnKLJJTmG9QmDbrjpQsfgxkMRA+k9BGeA90kS25WBG0OPmfqPBbSmR3Sp7gwa5YjBB
         R2hljBvN06JD8NpMTCJ8wNVNFvJ7hgR2UTY0JQDgyl3TWyNu3w/bjChWUbYsv/LU1aVV
         mET0UkP59rWWVHIbGL15ZZ1lt5dys3P+LGL/AaFok1n/OJKfAKB/s5xdy1Fhe7i5pBEo
         cuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741950247; x=1742555047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NiyiUpsfaIqtRcFq6JeHy3gqHpHk2qfaQ/0t696+60=;
        b=d1z1GaCDhDihv9iDt8KjXEPM5q3L+NjJw0QhUJDxZAyFZqCMGxp3wmFRD9ylzpgcz0
         DKy83BntIgR5gjAI3MFN+KeQdotVTJinE+OdHNnk0U3em9oc7FKPTGVIyBClVYgiYaTr
         5QLcJRtzOEhZMyw6t2wT50BYaLvSMMUs17cdb2oIdnL36LDGF2lrfeF7NRsjMSb7cs78
         gBIIfuatKRy7YDZPf24J6luQJ+fAovK9gNmIwzewX5CkHMAnuj5cVm8sddpyc0S2y0d4
         gZVRQznVBMOqjDWOFNz2BUDRW4Uv3Vpz3aCXQiClb/rHyKBJfI5RQvTy4xACZcvRdhGJ
         si0Q==
X-Gm-Message-State: AOJu0Yz3MWBNEPnYwYRlfYAAes+pFTZXUNAUprUOiX45/jr48YDFLuxR
	VO8qOzSAl8vKswB4FG+gpywhZLbcJXQOA0FpzDDViRkvDhL4QA3aM5gSmQnGRfWUZ/rUGVgmFCy
	giOAw6j+oxQMRoM3dkLjdval6Td5sizoUYrO7f+SEdha7a8yx
X-Gm-Gg: ASbGncvjyCgI27JgjbcylkNfVYiLLwuJJQPPRfDcUS4WEonLWLUSu5AML0xClHV6PTo
	EvdjmHgI7IkqiZdTktEppUlr0U5GV/lL8+29RVf7pUMprb+cKgCOs843VQ9R1SLIhlFjIMZ4yt4
	lzZM7CMX6BqHVL+M7YLub2SO4=
X-Google-Smtp-Source: AGHT+IEJEtlyxcViYWHtnHw8neApXqEn5T325rTS+M99TZiJoZFmmpxpAbqICae/vYhTB2NPQTDkXA7rbl3KdneDamw=
X-Received: by 2002:a05:6512:3f22:b0:549:b0f3:439b with SMTP id
 2adb3069b0e04-549c39002f4mr765760e87.16.1741950247028; Fri, 14 Mar 2025
 04:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314162452.2657f42b@canb.auug.org.au>
In-Reply-To: <20250314162452.2657f42b@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 12:03:54 +0100
X-Gm-Features: AQ5f1JqUCQoJNe3J9-UZ6faP1JtsfNzeXDsEj5Br4ty4YwmTnRYOXfJpS2yaT9U
Message-ID: <CACRpkdYe4P0xtrNyvwxcd9OsKPbGOnFQXMfuM4RPnJsX1o=5Vw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 6:24=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:

>   a40b63c773c2 ("Merge branch 'devel' into for-next")
>
> Each of the parents of that commit has only one definition, so something
> went wrong with the merge :-(

Yeah it's a tricky one. I dread I have to send this to Torvalds like this..=
.
I hope I fixed it now.

Yours,
Linus Walleij

