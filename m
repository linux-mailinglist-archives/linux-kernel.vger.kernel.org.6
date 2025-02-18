Return-Path: <linux-kernel+bounces-519263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DFAA39A64
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA403B6283
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC1E23FC66;
	Tue, 18 Feb 2025 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccei7RZO"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D723FC42
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877295; cv=none; b=SM2TVHDE2Akk9qjMD00reWYg2aqjYzzRbITC2XkW/S8PblEzgP7GvPTN7BVfSjKC6Nb+3LCXe3rdqUy++yEcZIu6ylf9m+GHm1iMUXl0iOl6zHPgbbiCG3/mVAKQt9xeWr7QVzX24MOIaygtRCw2WV4Gl0AsOyecgMjCQX13BuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877295; c=relaxed/simple;
	bh=e4ePEsIFIVWnVVp7x965KwnUxkPN33NpLp6ekCRE8KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/R79nSBPNo0IB+7s9j+89trb2RM/GcPKSSQ+1bN0jKo1k0U+TWJlPRA3UmsoxvyyIOq8TfYKlxP+MexF5qy9byTcHVSRnZ8/D82OAM3AAyOuVUpAf4RbyN6GGIjUjdSkgof4sLaVwWXW5KyIpsO2mKT4kCd+bfTZ4fIpXgSE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccei7RZO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dd01781b56so65026686d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 03:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739877291; x=1740482091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4ePEsIFIVWnVVp7x965KwnUxkPN33NpLp6ekCRE8KY=;
        b=ccei7RZOvzdELbqvSRnLZF4fVgF6+dwA+xypjXJt1yU9g9Udq/idaQ6avxElueFjlo
         oUDaK+m9JUxzjAZf2t9HNLZ+l0h6FDcMtGJaB+bNusfx2UxBzhcMSvwiwvWesBC8I8Vl
         +jGqBFWl7tM1jj4MJfiu0tArq2+KazzzjF0SdeGBdJIoBurOt7xnkF4QyyzCUIkCHogX
         FGGoW3j8rQeNJoJaSZ84ZGhtvpHfH0Maq8YfhxA0xEwR566Y7uSLk0XXpmxb3vajnamI
         0JE2kPbY7SiMpGblN/1wamD6dfkbSo7bIo2sKviNMaWB+JHz8YOKtrlfanQTfIseHiDq
         kzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739877291; x=1740482091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4ePEsIFIVWnVVp7x965KwnUxkPN33NpLp6ekCRE8KY=;
        b=HdMQrH55u3HJCyIAxFuwaSJAReTW3E90P8Psd1R4Im/VZy53da+MqC64PO1PGr2Kkw
         H2+0+ko+KhCs0eVRPnOaIBcQSjO1kbA9LdqZCREhAVBExdYmkeH5ICDfFrJAdD8no+zk
         e3+H8mZHSEiSwV32RtnhC1ubkmo0GhG2Hh5Rr3sWOtIP44EU98S8pRWDcvRNxwUG0qzp
         whIOKQY1e7YED8eeAfFGJ1aRDBylkLn1FJiL5b1pU2w3SXgOZDDp/nxuq9WkSAXmoaBP
         i999QzVGeA/fHmU3FQZZUQzCZWdNqP03+DIRLRcbluEYaIY4d+Mc+hxHc/FYuThSVw9P
         s04g==
X-Forwarded-Encrypted: i=1; AJvYcCXY781IsXjhhvE7UDRfYJdGDYJePQLCVSUoCSghaPrisxzYE5BKF2R9kOmUQv3wPwSztMGAmTE5IxDIDYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAuD5TL8qk7eTF3vAjWG5dkmpFrL8EcNowNz7aqUivb+ntZpM
	evJx1iA5KUqCWC3Pt9Ej2LTqux7nw8/yDue/ctHzPo44PPhKJVMpUf/YM3K5bPQcb94t7saIWt4
	660psB0SVouJ5jF5T6v7tQCl85N0tDErNQW1b
X-Gm-Gg: ASbGncuTK0K80PmzcLMVjXsbrkJZ1k3eqUXPwH/jdEYebA5TU6Jig1wkY/scq5x0RUY
	HQGhOWd8J/pcWLNphtaNOzCyCwkA1ix1ilMs1eyacKHZ6hEt015M53a3CWlyXUT1zd/C3Gy4W1c
	nhMN0sWkOvt3BPyiu19SiDgCQUz8k=
X-Google-Smtp-Source: AGHT+IF4V0cacABaV3DRhzrTYfPUh4lhH6DNQ3GhjP7RKVEodS0vVCqDlAESE8r3X5h1S9bFpKdk0ERPYFpqO2C0aao=
X-Received: by 2002:a05:6214:29cb:b0:6df:9771:978e with SMTP id
 6a1803df08f44-6e66cd063b0mr215315016d6.34.1739877291222; Tue, 18 Feb 2025
 03:14:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202502150634.qjxwSeJR-lkp@intel.com> <20250218091411.MMS3wBN9@linutronix.de>
In-Reply-To: <20250218091411.MMS3wBN9@linutronix.de>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Feb 2025 12:14:14 +0100
X-Gm-Features: AWEUYZkW-ELgmmWvEUCGBMqnFptxrYx8irjbyp0U6Ob-IrK0R7M-ystRnmQpahU
Message-ID: <CAG_fn=WzE5d4W1YheYN3SPYmVR5=r74zhV-Zhao5xu-Fqi461g@mail.gmail.com>
Subject: Re: [PATCH] dma: kmsan: Export kmsan_handle_dma() for modules.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 10:14=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> kmsan_handle_dma() is used by virtio_ring() which can be built as a
> module. kmsan_handle_dma() needs to be exported otherwise building the
> virtio_ring fails.
>
> Export kmsan_handle_dma for modules.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502150634.qjxwSeJR-lkp@i=
ntel.com/
> Fixes: 7ade4f10779cb ("dma: kmsan: unpoison DMA mappings")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Alexander Potapenko <glider@google.com>

