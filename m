Return-Path: <linux-kernel+bounces-215419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EDD909277
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A441F21A38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0647019EED1;
	Fri, 14 Jun 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lu+ZzzM"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD71474B1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390555; cv=none; b=ZnwmlNFYrSsrUwYhdKJxN9d1PNLqCS7FxVQkH/WJ/lKqu6Iy+D59hHbd3/sM2KAlwaXTsHtiLN65hFs/3eJ7Tgq8+AgRoxoLCP3LKINWUOqaVK1SJEqmmh+cvSK7C8bLZ8J86KyIf2H362J2eCfxafn+dfsbrvM+hDkU4sTcHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390555; c=relaxed/simple;
	bh=a/UxaEVcroxG1QVJdfP5cPNh0XmseYFuN6DDvYS1rDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KusamyBJ3LzPeNwdcHqt80wGa2Gf/8HleM60e18wwmNLogPiaOg5D25N5L+4LGxlowOzgEJTQB8BAz7Qr5A1iABKbEBvh5dDxqfjV1G65Eu3stbwO2L6bqsg3VVSBDgryIphTdpod7dkQ9TRgrpFmmg8xjRLHdI1ki7fEp7d/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lu+ZzzM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a63359aaaa6so378079566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718390552; x=1718995352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/UxaEVcroxG1QVJdfP5cPNh0XmseYFuN6DDvYS1rDU=;
        b=4lu+ZzzMD/JPufdS7iXYX/k9KyOOZHGERk7jZSNvF6z/RLM/o2JMtRSWYxxp0KA5WO
         eHNacCw9UsOMeE7/8YMTD4S+2coGuSJA7Zn2JXv2jOv0Kfx+xzys8cE8r9ufFJopZTzZ
         wir5tgtYOJ0dyuFY1QR+ZgAEZUjJUKbq1ShlOA8YLzaEH8n+15vVhBUT3lMxmeDnjndb
         vapyAIRJ1lE4znLERuj+RxHe8nXeZMxZBPp9BDkRe8vjmuaaNGfgDOHYgGQxt360B2Qk
         KAnFqe5Ial0lTLx8SMBZybiG8CUTVsfPAG/3SnFljZeSmZzaXQkBIPkQATmRMOUmtF4J
         nDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718390552; x=1718995352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/UxaEVcroxG1QVJdfP5cPNh0XmseYFuN6DDvYS1rDU=;
        b=BC1eIuD1qY9g26EvmAPUN0df+/Ia4/MYrpCbWDpy3qDbtjhM9wzsqc7dvpSEnRW2mN
         pW1wQBKKYRBZJcJhage/I9rpoim83avwpwhK0Icb8PrYJEvWILzycyCaGvKEll+Ver3m
         G5LXxjc9P6Q8yAp18qfo8MlFBJ2caRy+Q+e1oTPWSCfAH60OZVfphT0tr1CglReeA7Tb
         eGEc2zWvarD5scK9Kf+GLPsZ9f25bjCyFNSViKCfxthGw22JNp2RxFw0CQT5y7KeWCD+
         QNzJkfG2wfyduK/lqUcONr1y49A5qPzf4fdcmg/5FZbdYWQ/xi2g7G/qZunKottIZ6F2
         PMNw==
X-Forwarded-Encrypted: i=1; AJvYcCXhky9FyNKzayplBVg3CiK4ER5ysreauvIYMwwCnWSA7JrVB8UumfigJRXPqP9fBOaL+y1yPxoXqElm097ns7Sd7iBbVIKw12EbGQCZ
X-Gm-Message-State: AOJu0YxhTM8Z3IJCUHUkCBpk1r/qLpI2usi1XRuoOQk3t5OOux8WVkX9
	ajIWz31p4/IqfDvN+2H2wLP+gHeE5bmVtNm1QWvsoL/PG0UwcJkG5HYYweE5FHidZQR5MKBzwhH
	Un5hvcBVS/2Iy1VmIhuiyR1MAJo9ljTAl1dp5
X-Google-Smtp-Source: AGHT+IHOOpeJcqd3IfM1VEgoZAwXJPZxS0HdO/1gl5N7qt3GYy/MwHrpmX/VBM37nSpV9/ehuJ8LRxZvIoDZy3Xugbc=
X-Received: by 2002:a17:906:cb99:b0:a6e:fd41:6315 with SMTP id
 a640c23a62f3a-a6f60de6421mr220583466b.69.1718390551624; Fri, 14 Jun 2024
 11:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100902.3469724-1-usamaarif642@gmail.com> <20240614100902.3469724-3-usamaarif642@gmail.com>
In-Reply-To: <20240614100902.3469724-3-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 14 Jun 2024 11:41:55 -0700
Message-ID: <CAJD7tkbZjqybeg4sjQ5S9fqgUmLRM2fT8PoUz82AR0nvyNTpmw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm: remove code to handle same filled pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:09=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> With an earlier commit to handle zero-filled pages in swap directly,
> and with only 1% of the same-filled pages being non-zero, zswap no
> longer needs to handle same-filled pages and can just work on compressed
> pages.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

