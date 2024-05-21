Return-Path: <linux-kernel+bounces-184466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391368CA715
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D4A282722
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3AA182DB;
	Tue, 21 May 2024 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql5mPIxh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18196208D0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716262368; cv=none; b=KB4LwhaIvlOcQR1sh5J+94e2YojIpT4IY7zj4rC99bSziQ+dAFi0MLRGLUNFOxbrgZKRPGra7PuaRwJjc8xsQPsuLYkds3NFUt5EqymJCCit6vmaWKThcIwdcib5vbL6QfJ8AWzp2TEVmKFA2RJtSYSi4bzzrwneSkpNbvOlTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716262368; c=relaxed/simple;
	bh=eMSVtgi9C9gLItzinhaQSD/fl36TWMl6+L1NAXPu1Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1Vz8W13KrDgR1sLscJ//3istRb1Bg3borB1ZR9pFsdXuhZmhpr3g4wQynrk9KOdFs7XshE67Vljzzvq+s3KFWXHGwITOfby+dTGOg9ki860LLUpu8s1rT1u2lzHK7mWRX48poPprkulOp+CXha/ufrS0LL+4Pk/sIQ3XxcxOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql5mPIxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6F1C4AF0A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716262367;
	bh=eMSVtgi9C9gLItzinhaQSD/fl36TWMl6+L1NAXPu1Q0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ql5mPIxhueDgqBZJrS8U7EvqDroK62TtI7DKKNzfL+QV0+tDWUQ2YKIkZ0/3fg+rH
	 SgTY+E/ylB789jTCpkzxqGLnw0X4ugPYNONZX2+qzLHD0kzXSZ3G739u47ZjrCQpZC
	 DKEpmIUgN2aBrvxb0+fhndrJ2yCtuCWruHdBE7ATiI3EwY8kdIME6xi7dCdNZPVIBX
	 J9FQ6fF5aO1QwA9zz89cx0BeTSIoLtv2PP1jMdKyS0NAeJ0XvE3EvuLbgxJQ2ltmOf
	 JGhcRiXdQNfhVNjrF2H0heQzr5ooqNMCWcj2qQgiVk7nP36bqzjpzmB0x5lhQs8Piy
	 C4gKuzRiOY7tA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5210684cee6so4640513e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:32:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXp4POpqS/EAKVAm9OVZyFAVPp68J6qX6/lHApwFWJSsW1qlYyVSh/6jQaKCii7c+PGCtcnMftcBItGlQ6TFXmQR2ngN0bSTxXbpD3H
X-Gm-Message-State: AOJu0Yy8OhvDLg03Yo9oXJ/0gWCwbKpTl9EdthOZkNObiSgeDs6esiir
	h4/nMWjyb7vDuURUCrAGCkVSOE3XPFqBLcTVUQx9BfrCWrPg1rXlO1tK5VjsYfF9gbAGfmdXftx
	aAd5xdTh46MSTAFmn5Ut2daxvEyA=
X-Google-Smtp-Source: AGHT+IG7xC3UMfAYgD9M0jQ3EAGJ8R3c15WfFBNipSToHgjC9Emw4uZWL8msnLtGaPYUJl0teWGW2o/LkAiY38TobUg=
X-Received: by 2002:a05:6512:a8a:b0:516:d219:3779 with SMTP id
 2adb3069b0e04-5220ff73861mr22075637e87.58.1716262366083; Mon, 20 May 2024
 20:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520125648.1.If6cc3e73812d5f66aee58d335bfc9439c0ad9285@changeid>
In-Reply-To: <20240520125648.1.If6cc3e73812d5f66aee58d335bfc9439c0ad9285@changeid>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 21 May 2024 12:32:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+FD4BnO_unTExMFayxn6W5ZbYutAwmTZ6+MTq=w2fHA@mail.gmail.com>
Message-ID: <CAK7LNAQ+FD4BnO_unTExMFayxn6W5ZbYutAwmTZ6+MTq=w2fHA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: scripts/gdb: Replace missed $(srctree)/$(src) w/ $(src)
To: Douglas Anderson <dianders@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>, Kieran Bingham <kbingham@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 4:57=E2=80=AFAM Douglas Anderson <dianders@chromium=
org> wrote:
>
> Recently we went through the source tree and replaced
> $(srctree)/$(src) w/ $(src). However, the gdb scripts Makefile had a
> hidden $(srctree)/$(src) that looked like this:
>
>   $(abspath $(srctree))/$(src)
>
> Because we missed that then my installed kernel had symlinks that
> looked like this:
>
>   __init__.py ->
>     ${INSTALL_DIR}/$(INSTALL_DIR}/scripts/gdb/linux/__init__.py
>
> Let's also replace the midden $(abspath $(srctree))/$(src) with
> $(src). Now:
>
>   __init__.py ->
>     $(INSTALL_DIR}/scripts/gdb/linux/__init__.py
>
> Fixes: b1992c3772e6 ("kbuild: use $(src) instead of $(srctree)/$(src) for=
 source directory")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Applied.
Thanks.





--=20
Best Regards
Masahiro Yamada

