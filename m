Return-Path: <linux-kernel+bounces-214075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7591907F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D8C1C225DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A114D290;
	Thu, 13 Jun 2024 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baDCd2/v"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB1137923
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319357; cv=none; b=VbqJ43k3zdrbxcSCaMfxQnLgKHqhy/39kKlIoPkS8cIQXodWFimwQs2TWsaPefBdbBR8nG9jP/lrkw9JvRaNJltSTt+9rH2ZEj20nZQld+C58/5L/Jjn3mWRRUEfPigexGncRO23oIlXtaOKE5l1eaD1rLfWeCcP60mXHn+bNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319357; c=relaxed/simple;
	bh=jZwWD9hTBXXY8XuDiTQhHwcWzY5DbAwz+fcQ1NxiNBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQsM7M71DTXvQsdycI0Omt2Z9RJGNNPbEMafIY/J2rlB/88dSErQqBiJXAnGfToPev/8m9g+e+8pjUczkFykopACLGD8+gaufLf6XQ0P8zJ+waCHIIp2rSDg/qcGlkSS+IkrOiJYU9/hjzBymPYtQJTvzELsCCb7ximO7E2WbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baDCd2/v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35f225ac23bso1535672f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718319354; x=1718924154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfE7+PigJxb9HRCwGTqmJnzBdkKSmY93antEV/8sJMc=;
        b=baDCd2/vbDSQmFu4gHXsA33MBc6V5sc+9PRh9MTGxBId2gGQnlMtrmNWh0rr0ftfHZ
         L+qjj/eVsnDfxW4kMvnmI8+fWShdDrzGA2i/6xe1LVT6APg8HcUwyeMGLU3EwR6AVtqI
         tdfqNNG7vCsSi+T2qDdJElip0npkzO0WzL3OQ7chb3aGsHbJJtLFx8xP+2UI82GFLRWO
         SKcn4OUJdp+0K5wN+O7owwxKHzKZvOxaM8SKEkij79022JzXFfW2g+r+ryeyd2/yHmeu
         BmQoxG4jzjh76yoj8OobctGoZ+xY9NrjbXqZq8mM2gLgaejeAFvt7dcMKo4Llt4xZYVA
         Gh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718319354; x=1718924154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfE7+PigJxb9HRCwGTqmJnzBdkKSmY93antEV/8sJMc=;
        b=QQvb/AZonFSHzj0Xa3cYNHRp9sZJJH8MKxhZ+fC4pu8/3MVZf9gXHfCfMQJsspKraF
         IP4LIGPriWwJ0FOW6FiI9aWlYt/vAlE8ZRSZK0Z0jItg6VzG9Vx2IRWtHk368dhSdpjP
         EunZBUGXKPkdwTetwof3sqrHacFYOmt1grtqyk3vLzGy20q9n3GsmWO9mzo8QTBquQjW
         cABHiHI5G4SU0Gfq/aJHvXn2bOpWU47DYCCdfW7mfz8cd5CTNtKEsEGSeBnw1/bhiLOu
         k2lFikzAOSLhluzvhVAv+BXdnBx/GHoruSElX/Erkxorh4Jq6lapbsC9lT2KEpQr1kH3
         1ptg==
X-Forwarded-Encrypted: i=1; AJvYcCV//6fGl149yePfV89yVSO6i6lN7Nh4RqXgQvjvXrfo/Kawmya8fsiCSiQ74l/zIF+wq6DOKiLwfovw2cuI+2nHrvTsmuDxoSEve3ZP
X-Gm-Message-State: AOJu0YxlTD3fN1JZjlIAGvJBGNXszkVJpy0GSVdyBDDOJNuy8Jjfy6aD
	apJSYF2M8BBZQtjZhe/fmLhA3QPrDCnaqyGY4AsmuXbeCvhR62+6h2jGi95U08Pijt4LwkpRTgy
	ySnL3vO80wm390/kG1wc2ceWKz7w=
X-Google-Smtp-Source: AGHT+IFUwny7bT7HT+b6LNQ15tgwCxXmtRYtMyqergXnAfcISODz1LcIRAX3tFLrKiWJeBb3JYaDii3k7UcSkIVdeQ4=
X-Received: by 2002:adf:e784:0:b0:354:f218:9661 with SMTP id
 ffacd0b85a97d-3607a7435c1mr854867f8f.14.1718319354123; Thu, 13 Jun 2024
 15:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com> <bc0cf790b4839c5e38e2fafc64271f620568a39e.1718092070.git.dvyukov@google.com>
In-Reply-To: <bc0cf790b4839c5e38e2fafc64271f620568a39e.1718092070.git.dvyukov@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 14 Jun 2024 00:55:43 +0200
Message-ID: <CA+fCnZetcRzWW81TrWkDjFanUUa1YN6b8__5be=8cssGa1BahA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] module: Fix KCOV-ignored file name
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, glider@google.com, 
	nogikh@google.com, tarasmadan@google.com, Aaron Tomlin <atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 9:50=E2=80=AFAM 'Dmitry Vyukov' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> Module.c was renamed to main.c, but the Makefile directive
> was copy-pasted verbatim with the old file name.
> Fix up the file name.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Fixes: cfc1d277891e ("module: Move all into module/")
> Cc: Aaron Tomlin <atomlin@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com
> ---
>  kernel/module/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> index a10b2b9a6fdf..50ffcc413b54 100644
> --- a/kernel/module/Makefile
> +++ b/kernel/module/Makefile
> @@ -5,7 +5,7 @@
>
>  # These are called from save_stack_trace() on slub debug path,
>  # and produce insane amounts of uninteresting coverage.
> -KCOV_INSTRUMENT_module.o :=3D n
> +KCOV_INSTRUMENT_main.o :=3D n
>
>  obj-y +=3D main.o
>  obj-y +=3D strict_rwx.o
> --
> 2.45.2.505.gda0bf45e8d-goog

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

