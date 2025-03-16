Return-Path: <linux-kernel+bounces-562953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6149CA63515
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEFC37A1437
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFE31A08B8;
	Sun, 16 Mar 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCA9021K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6175187FFA;
	Sun, 16 Mar 2025 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742121453; cv=none; b=dV6LV/S3HiY1u7An6eo+NmePxqPfPWRqzAMpXUR7f0qE9JyJYHFnAM/NIV0fRh9u2PmFZXGsvzmYPEPcfn4jnWCDBP9PFhuexN3Rw/AJbBA5icpnvwvYLESsSpQMahArKStbmJh92esnKbZBD6Z/ihL42Tr3JsY9xZKneH2tPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742121453; c=relaxed/simple;
	bh=hi7v1c0uMrgIy3PMKs6rqd5o61raV4K0vP3IeZk+ed8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6wWXWnbJLhEl6GVjOYiG5v1uFikUVPEZchCTp/RFNHr0gQkoCeqQapQ2aWlBcyrH5fHVxWDh621CbrhNMD7OYgG2cUC9MaSWzSRSlv3oe/QXG5INAQ2NAEbG1iKbfE6VCWh/EZJmRqR/1VwfH4TN0p1iHBW5kvAQYQlsyaIWuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCA9021K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDCCC4CEEE;
	Sun, 16 Mar 2025 10:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742121453;
	bh=hi7v1c0uMrgIy3PMKs6rqd5o61raV4K0vP3IeZk+ed8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KCA9021K31M3YZRHWNSPzEobrkf/XCK9ktqo9iijbcFUO9zCLqDzPuX/z+MsStrFM
	 ql0X6l3FkD7NHKLI9ast/58Bc6eeQ+HviSSh6bZ07qypoqlqL+Cy9GaP99jNzJ+5rd
	 B4KWL3g1SggEFLUXUu8/lrUs4p9YqJUC7pXFyLg5t84VDmIGovdQLIC6SfLuHzJCvG
	 KwY7H/BlDlyfphEI0WwIxA86gOTINyzqMNxL+rPtSvgiGqhXyVzaH4kAqx1NcChlFw
	 SnyyvwvCgELw6KxpOBYqFrF6/0hzCtm2IL7hOb2W9/O4dVZEWbUn0owLnoiXpWJSH6
	 fAlN8PEqEl0Wg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549963b5551so3403738e87.2;
        Sun, 16 Mar 2025 03:37:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUx8FDnqTiaK9/Jm6VttFYJ30h2xWrGwan/GrRkqL+R1yNNCjq7fR1Q8kJGR21IE7POTn0vYzaR7AXb@vger.kernel.org
X-Gm-Message-State: AOJu0YwTSVtBbJWLcI2dQApQiMKq2sOdk3/12yiAOyWU6bqQHzXec/uJ
	8bzZVlib0MNSNw1hoGErnoCi9ESHWQYuPthQTzlP9uD8RYZXa+6rf7mWlJxzW6plxGYSR/WodNs
	qJoHlgI3SuuNGJswri1NcKJc6foU=
X-Google-Smtp-Source: AGHT+IHh75vDUS0a9gvdQXKI88w3hBXUxJjdOTfYm//MkDBNaFp3us4W9AMrUC1N9/aoQmRzMnOohwwOUu0I7R3c638=
X-Received: by 2002:a05:6512:3a8e:b0:549:4d78:2418 with SMTP id
 2adb3069b0e04-549c38f7d9cmr3287346e87.27.1742121451784; Sun, 16 Mar 2025
 03:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222002957.2582212-1-masahiroy@kernel.org>
In-Reply-To: <20241222002957.2582212-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 16 Mar 2025 19:36:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVrJLPQSCVTxKARm_4wk=Piem1ZHMA-8c8CfaZPs0H7Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jpd_6Uzt1zw_daVm75-F9kKdWblABDGcauM3-BnZ1zbCDLuSQqn5C8Pyqo
Message-ID: <CAK7LNATVrJLPQSCVTxKARm_4wk=Piem1ZHMA-8c8CfaZPs0H7Q@mail.gmail.com>
Subject: Re: [PATCH] xtensa: migrate to the generic rule for built-in DTB
To: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 9:30=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Commit 654102df2ac2 ("kbuild: add generic support for built-in boot
> DTBs") introduced generic support for built-in DTBs.
>
> Select GENERIC_BUILTIN_DTB to use the generic rule.
>
> To keep consistency across architectures, this commit also renames
> CONFIG_BUILTIN_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Ping?


--=20
Best Regards
Masahiro Yamada

