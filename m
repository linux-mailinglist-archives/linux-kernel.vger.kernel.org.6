Return-Path: <linux-kernel+bounces-407711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5068B9C7168
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2A61F26AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9A9201107;
	Wed, 13 Nov 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RARLImvf"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B2200BAB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505840; cv=none; b=UmqIBXycIPDZqB1ddvvzkp8G3Vh3gT+bk4kL1ldAZKjWzXVSAL4hsx4AR2Od7j1RAJMeZkzh7ITq/1wc2YWFlX3HsZlh12YnX7V3ZQdSRFBvkfvIDPqz7J2VAYeonC1kIvZZuD6lI+DqxoDxFKQiFQ4jd/ug2JLJXCR8Vnc/odk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505840; c=relaxed/simple;
	bh=DovP543G0WP5P09ssxwzdHhOQSUkbPAXjwWBKmViImk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tD9NIXqRviSV7+QYE7U4CXI3rSoeVjv8o27CZ3ld+KXCRNrTG+ycX8TUKL6TtI/YfPwQSN2dDauJi8HCLDePXyWlHHNZFHI2EmVngrT6yiiI75qJn3MR8beePZoHJYE0Dnaiwhl9BFJZNMjuStMdzjqg1T59MNoH9PytJrj+DUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RARLImvf; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so72485181fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731505836; x=1732110636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mB6kK0HnbxT/cDVUJ6DGWuXSiGrOTmeBP1vjLqTd4dg=;
        b=RARLImvfHH/UMUc4CX1gFOGXC7EQITWnu3Tm7C91pmHqALInM4z7tX/C2heGtJWhXz
         Qjl4To1czkiCecglLYJk6DAVyIAXPdmKjL1A2HYkUQNAaPeAMD8Fo6wic9/tMG8r/Z7Y
         Vlabxt5C9f/JN7EwwD9BDG9EmVWbEzYEtWAij6nsKmqxygIUOr62BkbRdcoh4iwryFB8
         VnCioiXpLkrG1XaxfJi0vIFux9nvIDAxHcwYkQLDPIY/tUy8Q20gfxiI9ZmS/+ZW8UF6
         LHbJkHstrwh2zZThmKrwLWq060Ox5xWbVvplF3LwRkq/gEALaabv/UIiEJkSc1IDyXz1
         CfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731505836; x=1732110636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mB6kK0HnbxT/cDVUJ6DGWuXSiGrOTmeBP1vjLqTd4dg=;
        b=BPNj6E3ONYJCoMQTXvXHWx/MflztXXebNz4yjug7JDanw/ORHS5vjTyis6wvfbKkYb
         0Htng3gAq/dOLSP2+RKR5Ywx4H2Uj3nGBDLnai4i4W5ZWIj5AoBOLBsinK0VoRBg3K9l
         9UQFlZ/VjhZgsYM2JRT0Ksk9mGK22VOpc9AVZKbuprwitLjCmlA2cJoIqwb7/momE5iB
         jhWTyI7ozB1zYM+lyHrzdNDlPGqGoITtow1y6T7oDXyNPY5WEDSj5KFd8XKEnyuL5LLX
         /KqzeDvOdmXDC4XJ3wCQC5S9FZDJZwygG7BZ0O+Ge+GdKbbSfVsth60hqBpHJYTdw+Fn
         rSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5i0okfQKD0eMpP55YzPFqAkUZbQwkQNf8DizQzg2RzNK2vz+C5FBdFiNt3QFrTVORLVCh5ATL8opSDr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw12HrHpxbivLSAsSsvcMVmmGXK6r58aVfYHRm7UbFahjQB1j5
	raoln/cl5ZBFB/O31TXjC9DYGej8c72b7km7RweC4tDJv3SgNj6avCDI02MXyj1nUHt3TkC4Mx6
	CX4ZAQlYfZAXV39Tuq3xo9gsCEs9KVufBkx2hzQ==
X-Google-Smtp-Source: AGHT+IF3fxMriqZkL2dwZ6bUCBGFi70IhICagwvE8GVuSQnG1S9aIJ9vmfvGgGgFwEmNEtuXcE5NkXX2LiQYWaZU56Y=
X-Received: by 2002:a05:651c:1551:b0:2f7:5f6e:d894 with SMTP id
 38308e7fff4ca-2ff2028a857mr111098371fa.25.1731505835850; Wed, 13 Nov 2024
 05:50:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022092302.123253-1-luoyifan@cmss.chinamobile.com> <20241112100817.287702-1-luoyifan@cmss.chinamobile.com>
In-Reply-To: <20241112100817.287702-1-luoyifan@cmss.chinamobile.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Nov 2024 14:50:24 +0100
Message-ID: <CACRpkdb6T5dqgmcVi5m_52uQ4F_wESv4K95Fk1hsZcSaUsY8xA@mail.gmail.com>
Subject: Re: [PATCH] ARM: vfp: Fix the cacography in vfpmodule.c
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: ardb@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 11:08=E2=80=AFAM Luo Yifan
<luoyifan@cmss.chinamobile.com> wrote:

> The word 'swtich' is wrong, so fix it.

That's not all that is wrong with this string...

> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
(...)
> - *  THREAD_NOFTIFY_SWTICH:
> + *  THREAD_NOFTIFY_SWITCH:

THREAD_NOTIFY_SWITCH

Yours,
Linus Walleij

