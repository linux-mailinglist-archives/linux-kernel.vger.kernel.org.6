Return-Path: <linux-kernel+bounces-309536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D2966C73
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512731F22DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD70136337;
	Fri, 30 Aug 2024 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EB10kt/Q"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7F171066
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057076; cv=none; b=NCnD7nKS6PuwaYFade3N0RSpFb7NL2piXjOLdOH4c4+AKBTohOQqCEtQYMGYmhtPPRjJbac+INEkvuHzrLVTLd/MugOizAA+EKbXeQETAHkalq3r6XpiowSHZi/YoOavjKGXbkndJlZ1MzlxeUxPWxOFnyJBUYuKst3VPLy5rx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057076; c=relaxed/simple;
	bh=pwFroKASBqejNUfm5CVZeNPQqT8/UnHI/5J0Bw9Puuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8npesv3uuyag+5AUuYlS2jgGYFkMFs01qYk3yCkBM9/JsV7K6N2b1UasGV9HBtLwzDTBoUmJVjuCxSiFxQ/rUDIuX4PyHxMF70wTeZnF53MHqvn+sZeysZJ9t6eOe3QPbgeXwTCHxTnutKllisx52tZYbEwsonnA43VPkgBoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EB10kt/Q; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6b747f2e2b7so22261357b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725057074; x=1725661874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUblgEFG+0OPCJUw0oaveizC+h3CWD0I+O0FLcExw4c=;
        b=EB10kt/Qexca1eBLewo5vZ8htZE2zuoivSRpH+Xaetwf+PMbysj/dcNkXHUgFiNhpJ
         bYoCCyNIC44F0pww1Oq334u3wgcJaWUKzpLNSwp3mBopsS79I9My+u4fFFF+zz+VyIOM
         iI3+CYej/1yrxyIWtb6ToSBIFTYCT6A/+EeM24Nh6fnfMA+U/g8AUuSnVp96D+PT+ApP
         9RF0IGTrXcpj3NdAG6x+wjyfh8+GZAQetS7IYhl66nkJpjq6tQIwVt787bf3eRzvx2b3
         jMSXa8EbNkh1ckt8W39hMlIa96cVDy+TBCVIvijwAPKC+1vM0TyygS9fz5IziJWMIx7T
         F2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725057074; x=1725661874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUblgEFG+0OPCJUw0oaveizC+h3CWD0I+O0FLcExw4c=;
        b=WlqgPji0AupzYUwyPLesF3Sc4H9oLn/+jL/RQkw7BjYbL67CIH5V/VbvY5+0UbUl2W
         OiW7LCmEu+3eYWZTRXElJLS8cXslF6zbZhCR9F8Vy+J1Hme9GegWVHYEXYljmB6+rSWN
         +qozIVGBdH1ROroMnMFFd+bQD5cDytlOMHYcpt8pepBLa4GnxVZc2WUsjfxz6v7OFFwc
         pL3XRMo9upodOSjRvgfSEckWLVIybgcLnwZet8G/pMQAFAxwfLAGM4pzdZ55GTL7Ay62
         FC7BLvHdqySG6zon7Da/mCCJ1SAVbmRmCMqsscvek4nZ2v2My0ZfmGqzChG9OCj57GKa
         +U2A==
X-Forwarded-Encrypted: i=1; AJvYcCWbGjMZ0MJLVGFykMAigNIpsW0PVdEIeLuLhb34UPLOfNKnCE+doUg8uWg/rkPV0Rmh7zUzohvOwDhyPXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwloTz97FoMNAhIhkosF84hHdAjpuFRNYuPtcAM3a8iwMqXNpd4
	iobmgTjV/5Rqy1DvW4mtKBokGKSYQC7VumaNLEg/s0n7CR4NDzVUb6v802VI60uvITffsXxS7CE
	KuB+3RE8e67ev0yeYSEIIXYdiN4JRUfRrPV358g==
X-Google-Smtp-Source: AGHT+IGyK2LRKMFmPldiXpQts0hWvnKTRelfsOu/wi3UPmzSoWa0k2vOUkkkzaMv12N7NZDZi0YIQcRKHgMku4EEaXs=
X-Received: by 2002:a05:690c:d89:b0:6b3:a6ff:7676 with SMTP id
 00721157ae682-6d40eb66aadmr39432397b3.3.1725057073718; Fri, 30 Aug 2024
 15:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-dt-bindings-gpio-hog-v1-0-63b83e47d804@linaro.org> <20240828-dt-bindings-gpio-hog-v1-3-63b83e47d804@linaro.org>
In-Reply-To: <20240828-dt-bindings-gpio-hog-v1-3-63b83e47d804@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:31:01 +0200
Message-ID: <CACRpkdaaxCgMuC4YzEm8NjKqnL_9MwqawYigBkp25GntWc40vw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: gpio: simplify GPIO hog nodes schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Bjorn Andersson <andersson@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:36=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The core schema in dtschema already strictly defines contents of nodes
> with "gpio-hog" property (with additionalProperties: false), thus the
> only thing device schema should do is: define "type: object" and
> required "gpio-hog".  Make the code a bit simpler by removing redundant
> parts.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

