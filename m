Return-Path: <linux-kernel+bounces-309751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC5D966FFD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC727284331
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB02416A94A;
	Sat, 31 Aug 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpiOx21x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0033981
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725088738; cv=none; b=QU+gBrMVLg8+MXIOQtDp50GSOCBxxZfd5Csi1BKCprp6iUEQhQPRQj0+/bCMxf8nTSYrXFWJuJHbUdttosu373z2aNdBbHcSqF1FLtcbcrAsBgv0FYefBsUME1JYaX34yAKbWxPSqJ3xiefiaZ64Q7P6UO/hfIXATo/BHdyboQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725088738; c=relaxed/simple;
	bh=+Li4JYHmlc0m2Jpsk4OmpL6Gm5XCVPtAY5DKJ4HWX0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYfmvB55dbQ1PdTyH9YBkv1KP4JjGiHxXWn1MSr1614vTxHbNZKMa0nTUJThAd9GOEZosslz9p3N8ZmP7LzxtYga+qBf6srh4U8NUNqRLSvyHHlex1UqE2Jl9Y4s2LofEEWBg67zu8e2sSxs7rwWZj9Bnwk3qn/D+tzLsDgkHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpiOx21x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A077CC4CEC7
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725088737;
	bh=+Li4JYHmlc0m2Jpsk4OmpL6Gm5XCVPtAY5DKJ4HWX0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lpiOx21xxgiomI5A2jGRK3190FGd7rgUHc/qQ3cJXH+gaItG/IvNdFszi9jfexZTw
	 jtzAhN4asksCQJfpEzeCm2EQ/YklvI9GokGDcsvW0fxHL8Wvgkb8zsvK+/wNdfCcj+
	 idsMZ3i1opg/vjjAVB5fizi2WpTjZAgg8IRHkOenaReNeOsBVa2tLsmUTTw3B9ykEN
	 utPOVAAL84QqH0t6RMTm/85hBHuxq4InVGLq16r5rczBTiUodEuCATsnsLUGnrVL0m
	 xazk4tUFPstpfoOjNzra+cE5czUm+tSkqnfavPe16z4ZHdiWdN4Rpi8uuG0NHoLvmU
	 a9/CFwgIMY/rg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f4f505118fso29405781fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:18:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCcdlFQ23XKx76PByfrd4R1b1LkRSVPJyxjjUzpQKHW7cZhE8XaoER2V31IDKFfr8ik70HmqHl7iMNCcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdBasRamveuwzChMjlvF+ArU/qG+FktyTEvWs4mJ4HdY0NmBV
	8A1IdrAoa8lYLqKrCgIQH8csS3WTiT/vXBw0MXMcWNG3u761b74fn7SbTyFyuf3+iFSoKT0FoUW
	cfEzNcuMMbFCuYdNBLB26jO+D3Mo=
X-Google-Smtp-Source: AGHT+IE3Va6gLap4UlxPvqg9ICLyHHD8IlhWZu1pPlzygqJuherO9PBYOHB2LrTvALJromzeS2DCgA7ZQCxsoBTo+Qk=
X-Received: by 2002:a2e:b8c2:0:b0:2f4:f1d2:c6b with SMTP id
 38308e7fff4ca-2f626567525mr9603571fa.12.1725088735986; Sat, 31 Aug 2024
 00:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831052157.13532-1-guanwentao@uniontech.com>
In-Reply-To: <20240831052157.13532-1-guanwentao@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 31 Aug 2024 15:18:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7GptUdpKScV1AuZZm7w-F5oUXHRmaT9BFCZV4HuQExJg@mail.gmail.com>
Message-ID: <CAAhV-H7GptUdpKScV1AuZZm7w-F5oUXHRmaT9BFCZV4HuQExJg@mail.gmail.com>
Subject: Re: [PATCH] Loongarch64: pci: fix memleak in pci_acpi_scan_root
To: Wentao Guan <guanwentao@uniontech.com>
Cc: henhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Wangyuli <wangyuli@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Wentao,

On Sat, Aug 31, 2024 at 1:24=E2=80=AFPM Wentao Guan <guanwentao@uniontech.c=
om> wrote:
>
> Add kfree(root_ops) in this case to avoid memleak root_ops,
> leaks when pci_find_bus() !=3D 0.
> Also delay assign root_ops when used for making code read clean.
> Found by code review
>
> Signed-off-by: Wangyuli <wangyuli@uniontech.com>
This should be Yuli Wang <wangyuli@uniontech.com>

> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  arch/loongarch/pci/acpi.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
> index 3eb61b8cd5e3..7f3539f5fa23 100644
> --- a/arch/loongarch/pci/acpi.c
> +++ b/arch/loongarch/pci/acpi.c
> @@ -219,17 +219,18 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_=
root *root)
>                 return NULL;
>         }
>
> -       root_ops->release_info =3D acpi_release_root_info;
> -       root_ops->prepare_resources =3D acpi_prepare_root_resources;
> -       root_ops->pci_ops =3D (struct pci_ops *)&info->cfg->ops->pci_ops;
> -
>         bus =3D pci_find_bus(domain, busnum);
>         if (bus) {
>                 memcpy(bus->sysdata, info->cfg, sizeof(struct pci_config_=
window));
>                 kfree(info);
> +               kfree(root_ops);
Add kfree() is fine, but move root_ops assignment is unnecessary.

Huacai

>         } else {
>                 struct pci_bus *child;
>
> +               root_ops->release_info =3D acpi_release_root_info;
> +               root_ops->prepare_resources =3D acpi_prepare_root_resourc=
es;
> +               root_ops->pci_ops =3D (struct pci_ops *)&info->cfg->ops->=
pci_ops;
> +
>                 bus =3D acpi_pci_root_create(root, root_ops,
>                                            &info->common, info->cfg);
>                 if (!bus) {
> --
> 2.20.1
>
>

