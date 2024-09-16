Return-Path: <linux-kernel+bounces-331061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E401797A7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122B1B22CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD715DBB2;
	Mon, 16 Sep 2024 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qg958p/w"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524115B10C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515736; cv=none; b=sp1lbXZFkIg2wO8CSr9/IouKYQcqfMqMLk5ucMkMlHmFMMD3tu7VkpjT55jpF5rLWbMT9+M8t1YryTHfhcIqpVgp9vMLy1Bq8rFJHGK5kwgneUaxJzgKohmlKNyA7t0jMTGRooMzUvE3reMXE6mu2mahdhn5bBNYKeR1PKbTGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515736; c=relaxed/simple;
	bh=lcyglchujBFBYarX+9+nRRvNPewZg/te6keYre7+4yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yx7uV/GaDth5Qw20QeAQeDSiPiM2p55Bx0sfh18JBuBiIGNVHih65U9p53ckDqyWAZRsAvrWe60XOQKScVBP9h3aW8RdSnUwKqyz7lBD0QqCRM6pawM0oRYudMHt/Va7izvhpOIbpfDtEg2GeS1ySuPf6kCojzuHSHgQHybd2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qg958p/w; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e04a6feef3so2423379b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726515734; x=1727120534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Vae9vaF6ym0VDAA7RUapTpBvo3oRMpI6vM8EcaxDOw=;
        b=qg958p/w8pJztKTRswHxgHWg83toM/Dv9zqSi/r5EQwxtgj9MCpjfDOCHO8vXeIfI5
         X0mm7V0RCPYcY1hUWsxbiXmM7xzUeu5geoaXJUh6gY7NVTfyDy7PlaIfh/FM3hD0jYay
         bg7yneAwiu/0eMwIBthH+6ewVoHE3J68EPfKLB5dM9bIFBdmWzjGbsJuzeSla1UKsqr8
         YB2SdoFUnfZNyqMlM4pfAsWzTyqGAKVGHPiCwHmQog476c8G41/AMNoy9UgWTPeH8ypC
         tnzTo4Fh5X4TrZpEmaJ9JggTuXOKidsgZGrlyWGU7QYz0pUAS3G4uDRnsqV1jDaKZGIr
         bc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726515734; x=1727120534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Vae9vaF6ym0VDAA7RUapTpBvo3oRMpI6vM8EcaxDOw=;
        b=hzfhF45wI0ssIRemyb1yPRY6Wi7wCnXGs30CP8ep9eV8660swBb8L7Tfrld93oBQQc
         FmBW+kGGkVhrY5cLaF6M7fAKjv+giPkjHIf8hwT2xV26vcCvft+oROilzbCo3KmN1PGt
         LojgimdcrdoaCdR5Gm38YvSCEj6PcaJu1IdcEq3ReHh6k46/e0M35snhNaraZzfjt3G+
         L7HG1rFAvlyladl55ieO5DcbwXkqyhJFVOhxZnbYuMD9qVaz7Xab921MTVU9V64VQBkY
         70uvsjiPnoKSEBAaJ5ZvElLyh1iLrx30NJcKnunY7qGuwWijwu4Mqqpzf+7pEBIj7wQ9
         Vj5A==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2nqo7WPCoNr+0mhYEVYGvi8RUBtQzJYJcB0AT+3XMUM+9f4jvQPXKy5XedcO6IdxTsYbJxZDdBtJ99g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcORL70oHHrEUPjexsEgZfO1v73FAD3m+GCmkYmRKbmR8sHY/
	/EOTYlCxxDtf6sO38RL2LZBokt+JFVXW63b0MQXDvn2RxNp8CBrXyGvhM1siyQzXjTSUhqCoO9e
	gAdijZ40Txc4ktHXxOmdQu3tVR5fBCWpw1h54fA==
X-Google-Smtp-Source: AGHT+IEHRJqyTEP7TNGkPq0m/qtvbDXGv+SBsWnxLIdk1XL9NbvM1jaSDfshFTukNMQc8kU5usEIX11Xxvcs27pmdok=
X-Received: by 2002:a05:6808:1a1f:b0:3e0:456a:9f66 with SMTP id
 5614622812f47-3e071a8512emr10131270b6e.3.1726515734157; Mon, 16 Sep 2024
 12:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916-max20339-dts-v1-0-2f7ed7c24e83@linaro.org> <20240916-max20339-dts-v1-3-2f7ed7c24e83@linaro.org>
In-Reply-To: <20240916-max20339-dts-v1-3-2f7ed7c24e83@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 16 Sep 2024 20:42:03 +0100
Message-ID: <CADrjBPoOZu_79OaXaq=5KzUT=eEhRdESwK7Np74Nsjx7cTRm8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: add myself for Google Tensor SoC
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Mon, 16 Sept 2024 at 17:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org=
> wrote:
>
> Add myself as maintainer for the Google Tensor SoC alongside Peter.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2cdd7cacec86..b6edb21b4f2d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9669,6 +9669,7 @@ T:        git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/chrome-platform/linux.git
>  F:     drivers/firmware/google/
>
>  GOOGLE TENSOR SoC SUPPORT
> +M:     Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Please update this to: -

+R:     Andr=C3=A9 Draszik <andre.draszik@linaro.org>

The definition of which is

R: Designated *Reviewer*: FullName <address@domain>
These reviewers should be CCed on patches.

regards,

Peter

