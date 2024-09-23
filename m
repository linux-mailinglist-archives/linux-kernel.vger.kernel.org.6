Return-Path: <linux-kernel+bounces-335525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD6597E6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AC01F21198
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8194EB5E;
	Mon, 23 Sep 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+8qrgSl"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2034D18C36
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078094; cv=none; b=kNK0J69/fvgAmHqY4KPcq1eJ/q9/KwRmtkCXUVWoHPplC8WKfgB0sLi5ODKevrJ1aDRGMf4QKvb08vSEpvdI4sclKao2rOnwD7Fk7cIUTf6PclgZ0XzWE9+2GG7aaD+ZvcRMMkVhhD12K18vw/XvnKkqT670ulwVlmqMwGv8Mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078094; c=relaxed/simple;
	bh=kQLqvXxfar13/dE2X992gYRg93pcxmdGvjFLCvO3qSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaZ0v1n9N69+rQnXCavz4M/LJ+QzM8RoKLWQF10G+4f8O0h33QY6AmAez0SOVNmlnb9NDPSQDKw4TvAzsXM3K5SdaQUMrA1JOpc7efSfBt1JBRbSfi+wkJeSHQi64vti2OJVCdCK3j4t+PivgvVFz6uXBwRm8LxKgYEf4Qn0rEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+8qrgSl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso30718215e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727078091; x=1727682891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQLqvXxfar13/dE2X992gYRg93pcxmdGvjFLCvO3qSA=;
        b=J+8qrgSlCdnZ4ON6b/M+pDJ+Z2Km7lltvqYuZrlSyvlHh85zG2ysh42zwXadhBNQZP
         wJ1W8JSzDOrx2BSqJq2o4WBXM61uy7xLqUSmTztl4phkrBw/MIG2/wnifPIuibClvu8+
         /NBOx65FoWAbvyS4bbrGpvgb27s9lP7yAXnhhimv+y0Khr2q7isJlyhn58cDZv1sQFx+
         6fgQ+lSU8m5q9mOfK1PWaGY/i9sWVzMdXyHmyv3YZ4P/TheWvorUUDoDCpqAkdHbJ1Rp
         6LCPjehFaaeeWtcPZFTmWHj/nRAUzEA7KI4xi4IqDaZ94bMta/sg2QAjffjMoHD86rLf
         fRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727078091; x=1727682891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQLqvXxfar13/dE2X992gYRg93pcxmdGvjFLCvO3qSA=;
        b=tEnkVkvrcramE8Hl6nYCkZm84HBrM5sf5GgLxKGlBDHaE7paDzuGz7SHx8YzvET3bm
         T7MbXn8Z7juQjyToCTRwfhBiW6yV+bmhUZCXx8Jjzx2Jt55OSZrs8uVF0ukYvZt58Q4S
         VpkhB0Z+69VlH7DrcPc8vd59gMv1cs7mIPX0WvUgeR9DBcJDz8ysg1kOXWb9vbTVSlFR
         VNza7oEqHtuEvaVdU0HxLB3ohjPNRfyV545oXJKz8TwbzSV25ep4IWL4NY0qrpJXLuGM
         JpHQhKT1x4gML10u0fMGT5seaAtMjzbMUzTH01yU4zEZY0gOEHQSlEY/Z8IvAMfCMWUa
         xlzw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3Zd87Gn6zjTjkoT+QySsfyjjv3Uj7bZ5Y003QxltBbrV9v1qLFlv/b6Pts4ILjh0Ls4opm0MkyxFc34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCyCfc5tYFaKsWzyQkgnQ59I2FK1sMWV/jWSyZtQUQuaxZ38xv
	/+UykuVW9R82Sp4+0HCHHNjJaTreuHgRf+E51xUaTRX63knJrPYzIsRRQSTGwe54jeHUiJg+7RS
	EYOzZy+6MGT7kAjNnrFp7YOqjMbZnJpC9LagL
X-Google-Smtp-Source: AGHT+IGcu1iI3RhvLnQNs/RGwGpVv2dlXLHZmLTZXX5UKuX8D+yStN7YFyEeRfi9inoJZgWZ2+Vu6eGAVRkYgMRGeTE=
X-Received: by 2002:a5d:4f05:0:b0:374:d006:ffae with SMTP id
 ffacd0b85a97d-37a41497226mr6751368f8f.6.1727078091332; Mon, 23 Sep 2024
 00:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202409231044.4f064459-oliver.sang@intel.com>
In-Reply-To: <202409231044.4f064459-oliver.sang@intel.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Sep 2024 09:54:38 +0200
Message-ID: <CAH5fLghbP3KZjkBbQe_MMJrnRpk4M0Hn0nu=uRtKWKqmKz6OeQ@mail.gmail.com>
Subject: Re: [linux-next:master] [cfi] ce4a262098: CFI_failure_at_do_basic_setup
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 4:35=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
> Hello,
>
> kernel test robot noticed "CFI_failure_at_do_basic_setup" on:
>
> commit: ce4a2620985cdf06c200ec0b6dce80374237697c ("cfi: add CONFIG_CFI_IC=
ALL_NORMALIZE_INTEGERS")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 62f92d634458a1e308bb699986b9147a6d67045=
7]

This failure is due to an LLVM bug that causes
CFI_ICALL_NORMALIZE_INTEGERS to be incompatible with KASAN and GCOV.
It has already been fixed upstream:
https://github.com/llvm/llvm-project/pull/104826 (thanks Sami!)

However, we may want to look into having Kconfig detect this case.

Alice

