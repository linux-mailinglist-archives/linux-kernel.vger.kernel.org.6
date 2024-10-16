Return-Path: <linux-kernel+bounces-367971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EC09A08F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7441F261DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196E420896A;
	Wed, 16 Oct 2024 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AO1Pgs59"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7757207A35
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080063; cv=none; b=qTnc1bgcWBLEabDqTAojJkMPS7o42sqxEBCsWG+jXlYiEHmlxyDhHR6nHl9chPHuq51ZJ+pVn7FbzQeuA6OF2Cg39aB8CgklEr2NwHXtHgDgu9X6jZpE5jSdW0tz8A78YUFBlJQwHDpcCaRm8ATuRkGeSGTg2hiJ3tAsSktcy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080063; c=relaxed/simple;
	bh=0Lw+Eq66P7NfS44Lso7KYw34p/OzXMsJYc26nL52TW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASXpz/4NAv6QugKP6oZQvF5ecQA65lgmXGWqbSLTMtm3uqacN17vRcLfzyPhhiTIDvH1cx1Tc7J5FP1sGvkD81UkBixnCjfXdgZGktvHR6e6bwDef2jWT6tAhmPfuevjLDzOV7TseQ2q1np2B1fb7X4EFBerUqfq2pbaVAWf+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AO1Pgs59; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so4221658f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729080059; x=1729684859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lw+Eq66P7NfS44Lso7KYw34p/OzXMsJYc26nL52TW8=;
        b=AO1Pgs59rIKTTpvzLJLwZhhPZngoD4fv1iuB5Ftnwppsm5zNvEmMBkz2lKdzwAUpHm
         OgNqyYS1Mt8UkHWJy5VIxh3i83LKO8KEkVdsPRj93c25epvGG2CPg3liMWVZLcBzYb4T
         uOm/jFq+xS4RRm2dPExTDMAaP/hJbxahuw3EMHmQWv9z0Y7PRVmz4HcO/PaNHMHT7I9g
         XTn1lNd5/h/5FHRdj5H0csYFKgcBlVV2/1sr+L0JDbAFBqGj9t7NPqGZBdiP7xNSChNg
         Q8hpGGkzEJ9zZakz8IUY9Lp20OHAMeVbkX2U/IDac/ocX0Ri+USy5YkuBkZkWBYwS8Jm
         7iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729080059; x=1729684859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Lw+Eq66P7NfS44Lso7KYw34p/OzXMsJYc26nL52TW8=;
        b=ZSl/FtM40/jE7iVO6dmDiv2ewlUNUvA7I8AP5CQ4IVG05jHEd1hLGMg/PEgFp+pIFb
         oIbJFbgQqeq90xpA20dBGZNQjirLUAVvvC0tcqGV1DZKfGTtZpTc1aXKDqIAb+1/fJ3O
         v+a14v3LlB/oODkLXjD0SmWETANe+6wy4Dt2iAgyqZyCwyBDUxnOaSVA+ao7gS8VNeTK
         EyS+JynGULUqE429U42o1VBxGuBsXURp6B2nkQ9bskIYW9izCkyTLiTCE2LgdQyOkS5V
         bhut1EEAjtnNjP12RxReYTFHvmj54xFiLII+DPjJuHI0Q5c0Ni+kMVd7bZf+9qkgKvwc
         0/9g==
X-Forwarded-Encrypted: i=1; AJvYcCWZkCsH1IswzBZOhYA4yD1zdisapyzKKccRfam2NbL5RA46l/7PxZuI9SFpuAvt+XSRNQ5uah6C1BX70sI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72kZIE77YSDrRdYhSwsek8wAUG5Og/o03466dBBniWAnrliAr
	Wztm3DzMVRVjNXZ8eo2A2bdh0BWCvNX1q9fWMQfvIX5bxAx5wE2vvHnF/H4SY2KM8FZ8oN0vOxn
	st8B1UHxIcCeSsDg+uaDS3pwQhEWOirGL6D4l
X-Google-Smtp-Source: AGHT+IG++/cNgr19EfMpH6beYBtK6fUiWPKsTgxPAigPR59gCZR0fTXiXujH2g2pJV49ZkvbJ74JnUmFlRl5KtJgjRk=
X-Received: by 2002:adf:e54e:0:b0:37d:45f0:b33 with SMTP id
 ffacd0b85a97d-37d55184ae1mr12139641f8f.9.1729080058727; Wed, 16 Oct 2024
 05:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-9-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-9-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 14:00:45 +0200
Message-ID: <CAH5fLgiuZf2jzhtnJLVUHjDMLsj+xXcME4Co=hH30u-nXeQDEg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 8/8] net: phy: qt2025: Wait until PHY becomes ready
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:54=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Wait until a PHY becomes ready in the probe callback by
> using readx_poll_timeout function.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

