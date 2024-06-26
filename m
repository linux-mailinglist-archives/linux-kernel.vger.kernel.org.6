Return-Path: <linux-kernel+bounces-231396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F7791983E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D941C20D79
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B5191494;
	Wed, 26 Jun 2024 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck/rUH25"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD718E77D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429753; cv=none; b=GxtXDN4T/EUIa8ZnSCNc7NNQ+pRBbACZDziuWzvZfWubrYuMeI3ZDYSuis6MFExEAA+ZTpjNT8rca5SWl0F2N0QgK8fRjFCUCC3I45qZ5zoSnrU+9QpoPh4NKHEshNQQ8Gq64ZdOqRd6T/qJCYyCf85zaupmBqNCKBeRTCxQuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429753; c=relaxed/simple;
	bh=Z2jSNwXMsXsza5lgoW0HTLoYcJ530iTeV3b06xT55E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qk3smrCbKhY9WBpFGOsPcG+sI6ix7GbaobDiiLXqOX69ZVslPRZ4pVVGBiBWviHx19bRUK3MUAtnVphlYyCOgLVP1wW+7VuJMvunTWKGHIcN85S25zEukkgDjVlmUfGZn/Ftg5lSwNZTPPkUPRGBZWRbWYOS7TDWEcsOirESEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck/rUH25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87178C32786
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719429752;
	bh=Z2jSNwXMsXsza5lgoW0HTLoYcJ530iTeV3b06xT55E4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ck/rUH25P3oIAjAnDB3AlY14uPhvcoVPfAoHTMvYE/havZwMeI1lJwz9o17rtt7Et
	 h7YILMe/ZQIhcNXEIPTzBM+b8uN+6CbnPTA0KzsY42kYgvKVCOMbPNAn/KK4jJPwh3
	 Dc+Y0ot//4EBwXanmwqu/qHVw30fveDWWBm+JQz3zsX7+WHRF8CvLkIaiEXY/Rh3Mg
	 w9eBefcuLBEOpt1fL813iP+dNW6njI1fsZaLZxmKF8Da3ixNLe/oEqQWfeZYuQLVXA
	 gwDX8XRs3jm3TB5Cx4I0irY96aRIp9dQnjMJLeHymTEOWmXpkUyUFXMTplhRyvMS8R
	 /TKlvNIQSJgbg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so55493591fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:22:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUrmfyD10ObAIJcHHJkrZhEhNFHMzXwq/nXz1VbsDARGL1aQtjt0daT99Vq5Z/Ee3PYvGm6HTN0I4LsSU9w06Kad18cI5T71eQaKxe
X-Gm-Message-State: AOJu0YxXRm4H0HxfSpE78Gv8QJC/ERf22bFVUBSlsBDpQX9FqOTH7WES
	yi3V53vq+rNvMpWivmo90FSI4/V652uS7Xrb3DHNsY2n+Qw2psslMvik1kFR3/rvh0eMvYvKMSi
	LtcutU3AaEo32jeelcoNYueIjie8=
X-Google-Smtp-Source: AGHT+IH2xWuEOn5fJgokzRP7yjOQuHkbOzDZ6p3qXzukCUDjhg/Kk6x6/+ZKbLOnXxaar3tv4kTgOX+NwjSVlwonvos=
X-Received: by 2002:a2e:9213:0:b0:2ec:4de9:7334 with SMTP id
 38308e7fff4ca-2ec5b2fd2bdmr84066391fa.11.1719429751252; Wed, 26 Jun 2024
 12:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-jag-fix_gdb_py_symlinks-v2-1-1a05406c8063@samsung.com>
In-Reply-To: <20240626-jag-fix_gdb_py_symlinks-v2-1-1a05406c8063@samsung.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 27 Jun 2024 04:21:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQu0Av5gYh2HoDkgLpWkEUX5aymT7KNivBV_v7ZO7y7pA@mail.gmail.com>
Message-ID: <CAK7LNAQu0Av5gYh2HoDkgLpWkEUX5aymT7KNivBV_v7ZO7y7pA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: scripts/gdb: bring the "abspath" back
To: j.granados@samsung.com
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 9:06=E2=80=AFPM Joel Granados via B4 Relay
<devnull+j.granados.samsung.com@kernel.org> wrote:
>
> From: Joel Granados <j.granados@samsung.com>
>
> Use the "abspath" call when symlinking the gdb python scripts in
> scripts/gdb/linux. This call is needed to avoid broken links when
> running the scripts_gdb target on a build directory located directly
> under the source tree (e.g., O=3Dbuilddir).
>
> Fixes: 659bbf7e1b08 ("kbuild: scripts/gdb: Replace missed $(srctree)/$(sr=
c) w/ $(src)")
> Signed-off-by: Joel Granados <j.granados@samsung.com>



Applied to linux-kbuild/fixes.
Thanks!



> ---
> Changes in v2:
> - Rephrased the commit message to clarify what is happening
> - Link to v1: https://lore.kernel.org/r/20240620-jag-fix_gdb_py_symlinks-=
v1-1-36a0f0217fbf@samsung.com
> ---
>  scripts/gdb/linux/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
> index fd1402c0a1a1..fcd32fcf3ae0 100644
> --- a/scripts/gdb/linux/Makefile
> +++ b/scripts/gdb/linux/Makefile
> @@ -5,7 +5,7 @@ ifdef building_out_of_srctree
>  symlinks :=3D $(patsubst $(src)/%,%,$(wildcard $(src)/*.py))
>
>  quiet_cmd_symlink =3D SYMLINK $@
> -      cmd_symlink =3D ln -fsn $(patsubst $(obj)/%,$(src)/%,$@) $@
> +      cmd_symlink =3D ln -fsn $(patsubst $(obj)/%,$(abspath $(src))/%,$@=
) $@
>
>  always-y +=3D $(symlinks)
>  $(addprefix $(obj)/, $(symlinks)): FORCE
>
> ---
> base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
> change-id: 20240620-jag-fix_gdb_py_symlinks-21d9d0de75a2
>
> Best regards,
> --
> Joel Granados <j.granados@samsung.com>
>
>


--=20
Best Regards
Masahiro Yamada

