Return-Path: <linux-kernel+bounces-274436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF194780D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5713B280C9D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57414EC7E;
	Mon,  5 Aug 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEnZUhH0"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87087145327
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849188; cv=none; b=LW5m4JQRgcRQ5aKHuVKy27OOPARx5faIEkDmEXRIN6yknJgdkP3be0wPviss0L0F09yFHjShQXiZ3szmlkriNp9yjtIrcFROHsohmij6tom/JOpb8+skfHTDkZs10fxDNFOpC9XFlBOhj2MO70sGYlB0UKOAVzUnGQmgWGqdppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849188; c=relaxed/simple;
	bh=b6PtRxqw9Cj7kNSDE179d9U4xRbrLqjwN7s7lGTPBh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkdLg1XGZMF8i8W++5cILj1nX4/jE+dG/jH4pR0v+RVxpFHHQFl7jIgjjZdr05sI9+lIeurYzS5TtVZtrQu+fEsAc/Gcv5Ps15+OxFUKq24lWxt4I0oxvyUTZZz62rZLfXBu5yzjr8GadndLcSudJBgMKAbWXrgWNjM2ruMHGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEnZUhH0; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f024f468bso14042634e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722849184; x=1723453984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y8FdFc+qsM3naUQ0bWiJHr9+LVojpJOgQ3oksPbyK08=;
        b=eEnZUhH03rl4Uy/vdlyQDYLdiPnZhf1wOiTWGMS1xjCHDBR6PNwb7TMWQfhGCk0Qey
         JAWoh9fh5rXiIQpTDvliD2PzKl/GGiWFBfRHfYmu9QEXxzRIT0JmuxgTw2VOnEsWZwEo
         Op38IASp0mAaj9E6m/+Qib3YqZi0KkYquWJzgWaJ1yN/v77CIbRrfShn0TAh3fwtqA9c
         +N3uim4OdCnSX4U3WRNQH+zQPX5dK/91ySzjLQU5t+8wSLKMtBb+hzsn28bqKd+ncSQ4
         qCimFYLqDm9EU+GYRcKVFIIGPwUALbmUMlljYzPFENgPIiZmLqvzSkBFjwGHKaomsIgu
         baQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849184; x=1723453984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8FdFc+qsM3naUQ0bWiJHr9+LVojpJOgQ3oksPbyK08=;
        b=lWJBejuKH0U4vLnbH1n4pgmxthBmEiQBqqoGNju6mb28d0B2BDcbMbc0d94rO+Im35
         w6Rs/ui1BQaI++IT8aMClgw9Fcd6OXFlZbjVY5R011azlR/2aArRIWmDq218IJzQWWmN
         VlH+NMVlkzdFHl3oEU/aqArvVj4lqUcf7lf+f+HVlV/9rm0QpVY9uL6XNsj8GTeIiWc1
         F3SMeqTfeRPl9F3AH0d+GX8Qw/mnJwt2QgDXQJf61Kz3SA07aOVOnjGnj+q8HewQMlxK
         v0u4lAGOBl8BPmbhSOfOdeGLdOpDluWBx7Lgz+RDPBSs+kETmkRuZ2W4KvSy2DteaCNK
         wIXA==
X-Gm-Message-State: AOJu0Yy3FOM8lJniCgaY6U7jYXI8v7kVQFd497WGVy4jMclipFDYwHp1
	lBpoOSdBtgWzHXC5MfpTaWYJ2NTx92kwUunQHvTe46B+g2MUf3infrhpL5+rHYlAXXRIsdUxN3f
	RaLl5WtSKpAMoXq5X1wwYdVoAfpxj8CQO1gTjiaGARqvrijQuDw==
X-Google-Smtp-Source: AGHT+IF2IzJVJAFgRlWDpNIWsidM5Fj2wPpC7cv6pEyFKP95u6M9uTFbOnXNAYb4CIiAzqTh63625eOVXY2CgIRpRGg=
X-Received: by 2002:a05:6512:104f:b0:52e:9b92:49ad with SMTP id
 2adb3069b0e04-530bb354fe8mr7070890e87.0.1722849183977; Mon, 05 Aug 2024
 02:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805090901.53986-1-gprocida@google.com>
In-Reply-To: <20240805090901.53986-1-gprocida@google.com>
From: Giuliano Procida <gprocida@google.com>
Date: Mon, 5 Aug 2024 10:12:26 +0100
Message-ID: <CAGvU0Hnm5V1EpY+TfWqq5XHVJUSSxa=wHCZ+yVNb9+Ln=7mbkw@mail.gmail.com>
Subject: Re: [PATCH REPOST] lib/build_OID_registry: do not embed full $0
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, kernel-team@android.com, elsk@google.com
Content-Type: text/plain; charset="UTF-8"

Please ignore this. I see other people have already posted different
fixes achieving much the same goal.

Though my change was much simpler!

On Mon, 5 Aug 2024 at 10:09, Giuliano Procida <gprocida@google.com> wrote:
>
> Using $0 makes the output of this file sensitive to the Linux build
> directory path. This is problematic for reproducible builds as it can
> affect vmlinux's .debug_lines' section and vmlinux's build ID.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  lib/build_OID_registry | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/build_OID_registry b/lib/build_OID_registry
> index d7fc32ea8ac2..06f242202036 100755
> --- a/lib/build_OID_registry
> +++ b/lib/build_OID_registry
> @@ -35,7 +35,7 @@ close IN_FILE || die;
>  #
>  open C_FILE, ">$ARGV[1]" or die;
>  print C_FILE "/*\n";
> -print C_FILE " * Automatically generated by ", $0, ".  Do not edit\n";
> +print C_FILE " * Automatically generated by build_OID_registry.  Do not edit\n";
>  print C_FILE " */\n";
>
>  #
> --
> 2.45.2.741.gdbec12cfda-goog
>

