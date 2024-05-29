Return-Path: <linux-kernel+bounces-193899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E18D33CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1B81C21F16
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB24F16EC02;
	Wed, 29 May 2024 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSoCy/90"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F416D9D9;
	Wed, 29 May 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976672; cv=none; b=bClnMjLGpo74y6YUVcCV5z9ucwo67mqD3bxXe+taJMKg+jHbR3FxP7a7xeyvvdkYPrHYjoK0vpXMyFHZcqn/2BrKfcXW3lpkYBEX4BwTXqoAC/VlQ0jucWTJ/jtErPSlRm7plEhw48z8fNti1kjtL02jcD1794iiydL2hOBcIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976672; c=relaxed/simple;
	bh=iaCGJaINHa9zEehzbalTOlcgppostrNzh1B+dJnNFSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwDTHuyMFkQaVfeOkjZO0tayY7lNj/vXMDJN5lCQDeuMfM8bYHpNYJw2O6stwHJ9Il1uvEYGuBoY7XRLaMpDQt7c0tfMLPqJqEb4s6PkD+XgonfvzSgOtd9xZxu31khXAJc/ZSKht197Gyi1dmhH/PUq78YjXlejG6oNwuTpNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSoCy/90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A866FC4AF08;
	Wed, 29 May 2024 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976671;
	bh=iaCGJaINHa9zEehzbalTOlcgppostrNzh1B+dJnNFSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lSoCy/90LFLRqYdbMOcXVCaF+LKST3QRDHgr5A/2iTjevruyK+yCmlDa0U+a3ggj2
	 h5A9I4sa+cCYq7dozVIAhSpq8sQFsc1SzS4OaLoShPb2Fl4Ui+V+yCvAt/tt7odsH/
	 S7EHwiheerR6iDSillcvYZpth8K5t2g9IRVEx+KEGWztMm0BVEx/zVtLT4XW7YdXDW
	 ToUXjdWb4qlU0voK+VSb2YaLAOI+A+qjGu2d9Bpsm8qOq4lmSQcUE0+Gar/z6g9b6E
	 2jg/blk80+UpIG5v9Dr6R5R5lat2gOghB53K10ktg6POw7xv8kTJ/lzCkMYXSii93z
	 zfRkTDrtYiW1A==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e964acff1aso18582881fa.0;
        Wed, 29 May 2024 02:57:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHXM3/SNglWi1CZE71q18VxP1hxyVw/N/VykWZPjjOVhK4sNcgF/H2aIIdOYwoWcbA/Oqk57lqK3CvxMOhD+Dl3oV1ue76nmyP1JbDMkxvPhBkKU1Eb/9+n/7m8G9bDfnTdJUPuR47MA==
X-Gm-Message-State: AOJu0YxXJ35ecSqy7TRUELYSP31onNuNpF/rsEdUom4dcK4bJcytr59k
	pWNrftLfwrpUJyJc95gTFqm6SL4OwdKsInQgffifPclTNOJ0L+pCD/nBWY8/LESCusEdOCXsYlA
	VUxn2oD/qB7F6DEWNp7EIqodEuM8=
X-Google-Smtp-Source: AGHT+IEFxX21+ii93lHAmnFMh4GvRSBnEthgLzBQShOVljveuWlSe0A2gLvKBfq69VYRJHG/hZCnYa7az9LimwE/rvM=
X-Received: by 2002:a05:651c:1992:b0:2e5:61f8:db58 with SMTP id
 38308e7fff4ca-2e95b0bce5emr113360491fa.11.1716976670269; Wed, 29 May 2024
 02:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528200231.1548800-2-robh@kernel.org>
In-Reply-To: <20240528200231.1548800-2-robh@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 29 May 2024 18:57:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNARtqQrMb3U6x=ppkrh6vNJn9tSgTQMCEtoU4DK0rHqFSQ@mail.gmail.com>
Message-ID: <CAK7LNARtqQrMb3U6x=ppkrh6vNJn9tSgTQMCEtoU4DK0rHqFSQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: kbuild: Fix dt_binding_check on unconfigured build
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 5:03=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> The 'dt_binding_check' target shouldn't depend on the kernel
> configuration, but it has since commit 604a57ba9781 ("dt-bindings:
> kbuild: Add separate target/dependency for processed-schema.json").
> That is because CHECK_DT_BINDING make variable was dropped, but
> scripts/dtc/Makefile was missed. The CHECK_DTBS variable can be used
> instead.
>
> Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Fixes: 604a57ba9781 ("dt-bindings: kbuild: Add separate target/dependency=
 for processed-schema.json")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>


Applied to linux-kbuild.
Thanks!


--=20
Best Regards
Masahiro Yamada

