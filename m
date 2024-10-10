Return-Path: <linux-kernel+bounces-358957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7529985BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790962830E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72651C3F34;
	Thu, 10 Oct 2024 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5bayww4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06401C3F1B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562669; cv=none; b=uPsndx0NSUb40ezZGgPhKx56zPxgS97oRIsY+rMbAnDB2cQ2OwulTFi4O3Bo13LQdp2UfBYvfOgZmYmns6OPcYrftc4F60C5auvpt0nnJQ9gmM3eS+SfOUYMTqoTHbKM5hwn37fHU+8fTDe8l5xMd6IjSdY5sLSM5YzOAchd9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562669; c=relaxed/simple;
	bh=H9JaAro8seubwTztcgeEs18CcSuyFWdBlUaF2TD1klI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6XdEo1/+7p0gkeJR9PXzambBSk4+9Qx4xd2948dq72YaKjN2IrIzVO7UDj2XwohAhIpuYO2PO88HlWiPDymHYChTtq/HQi0Ie0Y5OSp/ixM0oPKdej7nvqMffA9FsjR2IFlwjdwgcJO1ODhr4HfsajQ6+uyPI4Ss6H2codzOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5bayww4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728562666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvflPd5gKQrGEgjFqXi5n/SBqJrFGg+Ya3MysYEqqj0=;
	b=Z5bayww42hGvedtijq3X7zCMcFkTbeAgTU1jlB6eJM9agrtlERSVAnWXjLPEZ22GeNixA1
	Xkni24Q0q9RvRdo4r3CkHPOpADoS/5SCAfHUR7bt1dLIoO0J3U0QA3dvy/N24PbcJpyerT
	TAIDV0Wmu2Wqfg5hwBheIDfT2CboGzg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-MuZZsmWyO1CSHwWWla1ykw-1; Thu, 10 Oct 2024 08:17:45 -0400
X-MC-Unique: MuZZsmWyO1CSHwWWla1ykw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d37f8159aso523372f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728562664; x=1729167464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvflPd5gKQrGEgjFqXi5n/SBqJrFGg+Ya3MysYEqqj0=;
        b=vEcPkz4dl+Z8GVPoDvs51kOa/PaefN61Iis60CSdp5dZRcTr2l6uJ1fe48l6YNY1Jk
         /cUaaZyhdmQVFngtyqsNBHSV/pDSl9HwiX1knPwWXdO+tXL4b1oqiKHJdjcaNOOApw84
         G/DSxAw/oLMCTCOz6cHTu9uLQcusD+f5RLavHFGtDxB3k8oqWf27DXjfi621dEzE4Mtx
         S5UdIfCKHH+9k6ZtS0y4d0zckF2wZXI5cobpzpMurvWshU34M1xhUHGn4trv1sjYsTuz
         j5x61eAbwzokvIQcFKB9kMi3e77nQ5u/FEGgm3wlxqnxpWD73WiVqMTB8MrcIRSJcT43
         2bJg==
X-Forwarded-Encrypted: i=1; AJvYcCUs5P8Dral3tUydrLYXCeopodS4hcHPPZW+HnjlGr4hyv2cn/hMNuzng98YVXW55XB4toUBS4LbG664GTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRVrYLAr86QJqwwRCaF5wDmDtRhlL1CgN0WwtGQd4433DnHDV
	kK+SxDJmKt8bNd13ux+LqayFf+zAP0HllPZanq9etH7u2ygO/CJj+BBMbWsNDqUW6/txX+KcFbH
	xToaWni96BUx2EUK/fkZIQRrUWCi+Emv8OLoQ290wLhjco7AShi6OVQjPsdJp6UzyRz7DnMw306
	Kr+aA+K1lOoDwuAqv4S47m0/2QJaTTGP507J7x
X-Received: by 2002:a05:6000:180f:b0:37c:fbf8:fc4 with SMTP id ffacd0b85a97d-37d3ab44826mr5009155f8f.59.1728562664053;
        Thu, 10 Oct 2024 05:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBsPvpcLWaCbyaJMuqsA/5wnAlx8SPVzPF+E5uBgFKKaQkqn66KqpMb1Cp9R5xxS9r7cV9xXbYD2SU+tSEMx4=
X-Received: by 2002:a05:6000:180f:b0:37c:fbf8:fc4 with SMTP id
 ffacd0b85a97d-37d3ab44826mr5009123f8f.59.1728562663682; Thu, 10 Oct 2024
 05:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
In-Reply-To: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 10 Oct 2024 14:17:32 +0200
Message-ID: <CAP4=nvQT2-f98Sd6paMWqfGYv4pc39p2rfZfyCoxL6KrN-2Jdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/rtla: drop __NR_sched_getattr
To: Jan Stancek <jstancek@redhat.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jforbes@redhat.com, ezulian@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 10. 10. 2024 v 11:33 odes=C3=ADlatel Jan Stancek <jstancek@redhat.c=
om> napsal:
>
> It's not used since commit 084ce16df0f0 ("tools/rtla:
> Remove unused sched_getattr() function").
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tools/tracing/rtla/src/utils.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/util=
s.c
> index 9ac71a66840c..05b2b3fc005e 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -211,24 +211,20 @@ long parse_ns_duration(char *val)
>  /*
>   * This is a set of helper functions to use SCHED_DEADLINE.
>   */
> -#ifdef __x86_64__
> -# define __NR_sched_setattr    314
> -# define __NR_sched_getattr    315
> -#elif __i386__
> -# define __NR_sched_setattr    351
> -# define __NR_sched_getattr    352
> -#elif __arm__
> -# define __NR_sched_setattr    380
> -# define __NR_sched_getattr    381
> -#elif __aarch64__ || __riscv
> -# define __NR_sched_setattr    274
> -# define __NR_sched_getattr    275
> -#elif __powerpc__
> -# define __NR_sched_setattr    355
> -# define __NR_sched_getattr    356
> -#elif __s390x__
> -# define __NR_sched_setattr    345
> -# define __NR_sched_getattr    346
> +#ifndef __NR_sched_setattr
> +# ifdef __x86_64__
> +#  define __NR_sched_setattr   314
> +# elif __i386__
> +#  define __NR_sched_setattr   351
> +# elif __arm__
> +#  define __NR_sched_setattr   380
> +# elif __aarch64__ || __riscv
> +#  define __NR_sched_setattr   274
> +# elif __powerpc__
> +#  define __NR_sched_setattr   355
> +# elif __s390x__
> +#  define __NR_sched_setattr   345
> +# endif
>  #endif
>
>  #define SCHED_DEADLINE         6
> --
> 2.43.0
>

Right, the definition is now redundant.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


