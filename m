Return-Path: <linux-kernel+bounces-400414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22339C0D34
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A9D2835D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC36212D19;
	Thu,  7 Nov 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aQ1F7MCo"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F311192B84
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001662; cv=none; b=AnH3wAS8DTl9lyQTonnEuAK42kYCAkPKfTnTcZsH2i/gVrnn+uK5RPrDtS4v3Jp51ivcG9QEd85D/VnC1hVsqhvchMTrODC7OWdvoV6yzWJd5YAY0hkSddKZ/nSuXef9wIdLiu4I2W6DqNPgL8YSCXgF4f+SZZRN5hvsHC4JqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001662; c=relaxed/simple;
	bh=qLEBJeoUCUv1TtQyj2KsBn/SCIJ6QM4Rj98KkUhMcHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxhMh1aDYnQ3qycBycGoKB79bunP4CL+7PcHnor6AcGS/f+8fvpmvRQ2mfe3w/VVM7oXy7TzC+p5nxLB68Er1ZS1zdTRMvCC+jHwg5wTynbCI5uaTI9EoRh60uzQU6hEiOW6Efx5UwYInHgPGPW2+47pzjz2mDfFREPBVBgsZmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aQ1F7MCo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cb615671acso794590a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731001658; x=1731606458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8MPxAabwidNiX0fCHQmhnKhWU8mjz15R3eOlunHUkuo=;
        b=aQ1F7MCoWjdMe4P9oCts+11hkBC0MCy/TfUHYCkBF2tdmOC9hXCEAJwYXnorwJeqmD
         YBWaJV9aI9tAjJzvkblXlKHxXxvYB7HnaqbkWzcOJzIIW5XE5Y9YzwEjw0+g2ONWXzIp
         3JXmnkkZLzbW9L88xV3cs2R8LeeS8YJUStqco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001658; x=1731606458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MPxAabwidNiX0fCHQmhnKhWU8mjz15R3eOlunHUkuo=;
        b=vQuLQpHBsPmyYahNa/U7gieVSDsGQreHY91RTG20+02lRjpl/G8/b9KtJ4/dI5ebCl
         B2dxdnBSmchw+NO1WK9OS8rJvYyhB7S1CWiaLZAv6guQJn5ivd/ARmaLGqYKq5Ngierr
         7JWbY4RTdpOnuWWbMp/dUYuIq8ZlXFP1wp1L7bBCdQpPPg+aEsURncWt6H50CKemXKN+
         F+tR9sBXjttVBOsAePZZRUVneuRWaIYfRbYlRFp3Zlh60IsAr27Pc4RSHBwRg5W5oC3+
         rVzD2Y8T7ckyyZrrXeWQ9MYNAeHe0Sfua0g6HueiNkevucVyhB1XIBz5aHuW0iQoJn0v
         KVGA==
X-Gm-Message-State: AOJu0YxTLXOTIjV7nvqcXU4LMF1QRnbUo/p2TX2bTaMGqrex687U32yG
	j0jybDvA1e17aJ2gzoUT5lMubh57WYhrluMaOSyNEaK1FWRpgMoMp8uuf+SM9DwYkcf3wJ9yiV6
	Mejdw5A==
X-Google-Smtp-Source: AGHT+IFnwCoIOw4CwlKZfzbW8MoDeeW4qcOBdR6xpKoLgSXa09dw1ring43jKciytBBYqm4op3nuHw==
X-Received: by 2002:a05:6402:d06:b0:5ce:de19:472a with SMTP id 4fb4d7f45d1cf-5cf0987a48bmr288111a12.16.1731001658122;
        Thu, 07 Nov 2024 09:47:38 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb760fsm1058720a12.47.2024.11.07.09.47.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 09:47:37 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d495d217bso1032218f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 09:47:36 -0800 (PST)
X-Received: by 2002:a05:6000:188c:b0:37d:7e71:67a0 with SMTP id
 ffacd0b85a97d-381f160cf01mr72426f8f.9.1731001656514; Thu, 07 Nov 2024
 09:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106021228.4345-1-00107082@163.com>
In-Reply-To: <20241106021228.4345-1-00107082@163.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Nov 2024 07:47:19 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjAC2+dCD6-DqyZOv_ew_WGqKGuXnb-7aaK4bb5Q6fFgw@mail.gmail.com>
Message-ID: <CAHk-=wjAC2+dCD6-DqyZOv_ew_WGqKGuXnb-7aaK4bb5Q6fFgw@mail.gmail.com>
Subject: Re: [PATCH] proc/softirqs: replace seq_printf with seq_put_decimal_ull_width
To: David Wang <00107082@163.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 16:13, David Wang <00107082@163.com> wrote:
>
> seq_printf is costy, on a system with n CPUs, reading /proc/softirqs
> would yield 10*n decimal values, and the extra cost parsing format string
> grows linearly with number of cpus. Replace seq_printf with
> seq_put_decimal_ull_width have significant performance improvement.

Applied.

               Linus

