Return-Path: <linux-kernel+bounces-186062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C4F8CBF59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF02BB21D52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A16982482;
	Wed, 22 May 2024 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRfEQIQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F4C81AD0
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374357; cv=none; b=QYZ8aH1SHu4ap4Sib4UM3lmqUtK28K5ptVpAZrIwPgPxEkvudaGccjBuYuJ9ggqYHPtf650NPIoGEc/uCMfq9O+0vZnwfH22+9CnEb4LpLRSmcwfLkKTUrESyDApDsRrLY1LUOpoug7L4W0Ob2+yHfg0TWVo2MsfMx7nYFLn9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374357; c=relaxed/simple;
	bh=w+JBP+YjCE/qMG21vPjkWKzaQsU894rn3eFPFGdZ+4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYc7edpweS+kMZ6wBbkv9JUjII1fQ1Ou+a6tiv4/yhkeaahjgxkBuzlJL1YgFQOBMoGBrftX5N7a/xAqe84dpqrqmlTskdWR4CSFniF5uCi8IKN8WRUGxzBN7vK8xoWedMzcpkgqNe368OsEMFDwfTkZC8hZzl2oKUIGeSBxMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRfEQIQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F73DC32781
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716374357;
	bh=w+JBP+YjCE/qMG21vPjkWKzaQsU894rn3eFPFGdZ+4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bRfEQIQm/6YXO0bEnt1/NP1kauvyQ4UQF6QSfXbfcn4fOQciBqqCarLC4F8YkvAhW
	 k7uOI5qAW8CBFLidrR+E60Rzlqq7sQPNSbCQwAzMS2lQZW7OTrinPX3++auXFEQi4f
	 H/6OIBcy8ws7UQAWnR6fqWBo86kXfS85araqZZPdNEYXgeMkTLMn1ZiBXr3S7+aagR
	 d6jEuGiGGFvy0/L7NeWfwARSoEFso0hQ1Iw0YN0jz/9qWAxXYos9vSFJRGUsdyR3Uq
	 5GKOM9SM31QQoA9Gr1Mvmcbv9XyfmjcP7GAKJHesADNW9IUWXCxR/H721P5+KHsdis
	 pvPUe8JEt6yFw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f57713684so7833716e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:39:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YzE0l4BPfs8SuW/liwQPr/ehTIZVxL69veT5UWb5QEqX79uaUJy
	sqLP0fbh+/HBnaZlwInK/QJgLK6Mfs9EOVwOveGiRGorOKOQPVQ6FtR0jFSJ4bR3A6yFkDV1oUx
	ozsuS0fYjORXyKXOXfJfJf6L7FaE=
X-Google-Smtp-Source: AGHT+IG15YWoyGMSrCLJPu6j2RhwjiHgK4lLnT3gBvwEAWUesPPDKffzeoOkQGCvGPH7XczTejCUAAnKdVUwN+T/slQ=
X-Received: by 2002:ac2:5506:0:b0:51b:6f06:92f2 with SMTP id
 2adb3069b0e04-526bf35cd13mr819793e87.33.1716374355823; Wed, 22 May 2024
 03:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522040754.2972825-1-bo.wu@vivo.com>
In-Reply-To: <20240522040754.2972825-1-bo.wu@vivo.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 22 May 2024 19:38:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT8h-VQe-NLJXksRkskEZwCWCESNMfdUWpfbwFebSyoMw@mail.gmail.com>
Message-ID: <CAK7LNAT8h-VQe-NLJXksRkskEZwCWCESNMfdUWpfbwFebSyoMw@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: fix symbol link when run make cmd out of tree
To: Wu Bo <bo.wu@vivo.com>
Cc: linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Wu Bo <wubo.oduw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 12:55=E2=80=AFPM Wu Bo <bo.wu@vivo.com> wrote:
>
> When running 'make scripts_gdb' command out of kernel source tree, the
> symbol links gennerated under build-dir/scripts/gdb/linux is invalid.
>
> $(srctree)/$(src) need to be replaced with $(src) since
> commit b1992c3772e6 ("kbuild: use $(src) instead of $(srctree)/$(src)
> for source directory")
>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---


This was fixed in today's linux-next.

commit ab32efe0e2b6ab01ba079995071da8d587c976cc
Author: Douglas Anderson <dianders@chromium.org>
Date:   Mon May 20 12:56:52 2024 -0700

    kbuild: scripts/gdb: Replace missed $(srctree)/$(src) w/ $(src)





--
Best Regards
Masahiro Yamada

