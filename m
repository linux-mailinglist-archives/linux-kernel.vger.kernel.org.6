Return-Path: <linux-kernel+bounces-422838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009B09D9EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CB51631F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B951DF978;
	Tue, 26 Nov 2024 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SOwXoET+"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE701DF257
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656370; cv=none; b=bLutVKM2XcXZS7N34Q878Pz95lcOxNo0czjkbXHzl5/Q4o7FRPuR+1jL6ma6srdiISPFaa8dRItk/S3IwqqN+iga1frh/EzjMKWcOsm03fn8DFEx+/oapLcnyX7bbyR6MGwZL3rsoNH/0yE21jdRT0UcEjfB6Dp05uJLkwRjSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656370; c=relaxed/simple;
	bh=Kx/0QWPX+OdEqSNki0YPTvmPzEcNouqLCCl/QMYchKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmV29LXoPvZqPp0trTKz+9xdhcLWFCKMUhMZRrHjT1GTgosi3gNJUUD5v8b/sXLJDdQJGT888JlfRbEy4i3FXdTxj66xaL0EqZZSJd3RHPqSPHZbD4l+WRAcgaF5q7jgMPutphUup1bFVIIUXEnzWGmUKarTuD5eyBxY8a602vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SOwXoET+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfbeed072dso7717098a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732656366; x=1733261166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2eytn+wn7/zH3xbZzSo5Ejwd3Xq1yRr1L52T1xIuRQ=;
        b=SOwXoET+GfCNL+cYEDh6oBOGKneOoXLxVX0zkKZF16iKSWFn9fpHYboArQT2TXpmZU
         U3hV+p8rHt6xCD9cvHvGrNDMyoFT75CsqAdRv+sj2qruYABCLZd0b0DNbr4NkAdnmW3n
         IY/RgSTszixxnpyioJme5CRbvSaZEetKTeo1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656366; x=1733261166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2eytn+wn7/zH3xbZzSo5Ejwd3Xq1yRr1L52T1xIuRQ=;
        b=k58UsEW9/iyOTEtj9LXCXOITzIZPHNczR1ta0etzy83/QcrpJdJ+yQy+6q3BSSvLt4
         Zadl/FKlqMjUS7znFNnuCUKv4+mcdR/9DEvWjyNZFaju/YQNnu0u3zS6v4uYcMa8Mkw4
         HvtO09JHkSJyIU6JkIW+PELu1afJjNI8Kxva8u63nHgl0w6yj617ywxUZHa0ynSqCcO2
         6aUkBy6RkUYnwJaiGJgq2SJBk0e7y+t8/LfLOgfgeJ2tTjYJ2bQlmaMIU8Q4+rIfH6F0
         lB6RhGzOEh+lGIvcjO23EDwayx12CKpQfBepXY3CaGyfgdz37yvPTJESaYo1J9UORK0y
         615g==
X-Forwarded-Encrypted: i=1; AJvYcCW6EQc+GkGmv+ChSngVutb4JPtS4lqW3f4Ka+RindL+aJ2b8hLC4FpboBM8uXgKpsFkHm2fDlPYGJoO+HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIeusPvyzxmXmcshvRYrp3MXpn5gonacN+HQvNGoJ8gH2YuvB
	a6srCMBoZVV70ZZOhYMBdsvi0I2sXuwhmkq00xzk41EJgQ8H2BQNFCFAj0MCSyCLABrKR6xcOyl
	KpKC3Sw==
X-Gm-Gg: ASbGnct83IPgalb/iz+yw12uVvS4/fPmSRGS8d5NcyjXH7FhlJHqLOrC3u93emwWmQT
	mR1Z8fEFlfE6sHfQk5zWZcYVBmgvFf3TQgp2K06YkqdDNi2EE8GCF7nuR4Bz4tgIQMbDMp5nd8D
	XpvEYLoYkSb7aOcFcTKA1prHDoi/nQtvzonuwe8/PWAl+sSTkiwbb77aIWVJUVMHgyJ54btJFMX
	ta5gJ9j3hhlxy6t1Wzw0BBdlMujOLF8GTlUcubrBkx599kys1LGuACKMUXmz5Huxiv3sai7NvjW
	VQGf3ODw951XdGO441MVJ2ja
X-Google-Smtp-Source: AGHT+IFqtr+ZcXZikhRhFrbzqbEgHeaZqm/ivIwXpWemXwv5iouaiEzPwChOQtIaK9oFevNJdIUYnA==
X-Received: by 2002:aa7:d9d0:0:b0:5d0:8111:e94a with SMTP id 4fb4d7f45d1cf-5d08111efa7mr447380a12.8.1732656366312;
        Tue, 26 Nov 2024 13:26:06 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3a2d15sm5718282a12.11.2024.11.26.13.26.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 13:26:05 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so990149366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:26:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXC1/UL7HKLWQOaIUOmDpDMdBXfl4ZR8ey92SDFkGaqbAMwXqKXYVnOoG5gAKhEL6hq72r1M4LhRFWC7Hg=@vger.kernel.org
X-Received: by 2002:a17:906:4ca:b0:aa5:b32:6966 with SMTP id
 a640c23a62f3a-aa581076b11mr40826366b.50.1732656364133; Tue, 26 Nov 2024
 13:26:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-vfs-rust-3af24a3dd7c0@brauner>
In-Reply-To: <20241126-vfs-rust-3af24a3dd7c0@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 13:25:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh81Obo3jzHuB6eg_a8x2ObjRG1Oa7g_B5qWK-uds=thg@mail.gmail.com>
Message-ID: <CAHk-=wh81Obo3jzHuB6eg_a8x2ObjRG1Oa7g_B5qWK-uds=thg@mail.gmail.com>
Subject: Re: [GIT PULL] Rust bindings for pid namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 03:08, Christian Brauner <brauner@kernel.org> wrote:
>
> There'll be a merge conflict that should be resolved as below. The diff
> looks huge but the resolution hopefully shouldn't be complicated. I also
> pushed the following branch:
>
> gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs rust-v6.13.pid_namespace
>
> Where you can just steal the rust/kernel/task.rs file from.

Well, my merge resolution looks a bit different, since I ended up also
fixing up your self.0.get() to use the new self.as_ptr() model.

And I ended up putting that as_ptr() definition in a different
location (just before the first use, like it used to be).

But I think the end result is equivalent.

          Linus

