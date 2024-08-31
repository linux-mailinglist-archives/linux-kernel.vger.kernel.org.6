Return-Path: <linux-kernel+bounces-309823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1469670BC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A3A2843B6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D76F17B4FE;
	Sat, 31 Aug 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB8Iy569"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7513A27E
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099272; cv=none; b=CZCkWOUW4tYePvTCgb3S7b7Da08gSp2QPOFld8P/ZMTnbOSF1dnHje+DLKswBLwU+ei0jIG5ZryqOASQrS74NDI8k1LwT/foYeyTefK1VEXFluFr/gltqcWsvBQRIul2yNRJaIbe8oxbF/moO8P+UBYnf9jRd+oG8SQb7z1Xa0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099272; c=relaxed/simple;
	bh=yj38hRBpjkYukw9Ls4kNpywcL2S3VVmPB0OsAP1YOvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGc9MWAEcm+csPfbp3Lf8YiZQsaRtE2M19nCqloBQVk4qwluzeZrBnM0aFC8WrJwRU9WBIcavR138Ql775L9+wiyqKEgGhXYfKv5UFcnKEBdMDZGZwyo/AfNqDRW0uoKq4c7pGgSGcEQSa1inZC/S6sfMogMinFAtAWddvijj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB8Iy569; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01616C4AF09
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725099270;
	bh=yj38hRBpjkYukw9Ls4kNpywcL2S3VVmPB0OsAP1YOvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CB8Iy569E0WF8foH21kMyeaIxGfu5WeOENrdTNXAyKKdpVcpbWgXhWSH4nQK+0WTJ
	 MU4QZmdMic+BPZxnat7apdTN7bYTMu752636mWfAnA2Z6pJ4lOSGb/wQ54JcjOvmaO
	 hxgsRcCCcoGIRC7hD6Umb9TlvWSeah2vXCVKSuBAaGkX2+eNFJkDdsWpsdzbySuBbK
	 mWcLI/YtUOfte7flJRh/IMncb51fMckC+mJwVd8fSR3lQYeoenxLHCUdAAJy65yGTJ
	 QrvAhMx+fTS9YRD0uWvD3ylBPFwU9WuASPd1Me879LYbxidSk0nC5gCvPPTTXhDCVk
	 0tOrWkkD0dqqA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f01b8738dso1907692e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:14:29 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywu9UuvMym3iP31wrKvuSecnfz3bjei8WH0ccx99tBtJcQsadfi
	Ku+Y1E4wa1Pn4JaIRHFufcIEbSZwhyCRACV/7VuOGJPZGFoayatek4vMiK/+7SlkrD+EA/3Qvfm
	rvHeqbeJC18Y1gJiyXyU4VRavWQU=
X-Google-Smtp-Source: AGHT+IGJqUs8p1NGO3fICcAO4WPlEKDkIXDQ0GM8sqsZT/kWKVLCi9wH3j8eFXId92Z1hO6A+ReMAxL2r6Ovfk5SVI4=
X-Received: by 2002:a05:6512:12c7:b0:533:4689:973c with SMTP id
 2adb3069b0e04-53546b28914mr3103561e87.23.1725099268477; Sat, 31 Aug 2024
 03:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831101045.1381258-1-masahiroy@kernel.org>
In-Reply-To: <20240831101045.1381258-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 31 Aug 2024 19:13:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNATtOzj175_Y0qQz338FRG1GYCrsorA=jWG+Go1Wjn9rnw@mail.gmail.com>
Message-ID: <CAK7LNATtOzj175_Y0qQz338FRG1GYCrsorA=jWG+Go1Wjn9rnw@mail.gmail.com>
Subject: Re: [PATCH] ARC: update the help message for CONFIG_ARC_BUILTIN_DTB_NAME
To: Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 7:10=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Commit abe11ddea1d7 ("ARC: [plat-arcfpga]: Enabling DeviceTree for
> Angel4 board") changed the default built-in DTB from "skeleton" to
> "angel4".
>
> Commit fd1557923b2e ("ARC: [plat_arcfpga]->[plat_sim]") changed it
> from "angel4" to "nsim_70".


A typo.

 ... to "nsim_700".


>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/arc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index fd0b0a0d4686..d01e69a29b69 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -553,7 +553,7 @@ config ARC_BUILTIN_DTB_NAME
>         string "Built in DTB"
>         help
>           Set the name of the DTB to embed in the vmlinux binary
> -         Leaving it blank selects the minimal "skeleton" dtb
> +         Leaving it blank selects the "nsim_700" dtb.
>
>  endmenu         # "ARC Architecture Configuration"
>
> --
> 2.43.0
>


--=20
Best Regards
Masahiro Yamada

