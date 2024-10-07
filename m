Return-Path: <linux-kernel+bounces-354029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915B99368A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCA8282892
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE11DDC16;
	Mon,  7 Oct 2024 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaXeyJBT"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA09320F;
	Mon,  7 Oct 2024 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326856; cv=none; b=dxIDz2NxFQnq7lAtWWym3+NiZtQOKab3pxfcqU5YFVps8kfEtIjkgzm9odieJSmshu4VMf1MwQ1IDvKRrUZSsnNhoY33ir17UB3Z6We/lVeMxKpxRIay8qG2xl1YODv/wy82QYtdr5PMIdx0hXsqLZ/bMeZsNX3oF2FGsDH+z+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326856; c=relaxed/simple;
	bh=hCJnofJB3LcxCFfN7d28LKDXgXDjXmGss7WgO3ABDjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQfl6dXSeThpG5wdNBeE7kHMZJcZI4QR+baaK7q3DO7zivyJ05Vcc8z+TKxW1IuBS0+tViWiMXYtvwy0Qjutgk+cB8h+rX/ZWXOTRWj1Nt53vYQ7QU2FyFHUsmp5SByz3yJEcsPUp75zfYZ/vAKRwWDMG+UBTtHDRz97KOImVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaXeyJBT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71de91427d5so437227b3a.2;
        Mon, 07 Oct 2024 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326854; x=1728931654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCJnofJB3LcxCFfN7d28LKDXgXDjXmGss7WgO3ABDjw=;
        b=RaXeyJBTEs0LpUTeMeI/J/nucYisWS3S7Sa3wAUqYNdyjarroDhlw1fkmEtQNr7XBC
         44Kq8khUC7/m909+ORM4XUekwW7kDsONT69nssWf8NVvh9Fv9PqxnhiAbthbBJIS9aja
         TGc38F0yoOh45s3HtcOJ7a/PP1XnqxJEXpRmRjkwmAs0acQpsOcdQgx1lRx1GruwVDJn
         Qy1INqti5AVY96VYUJOzFYxBDuZ3l1RQG8Auk3mr2y9XQHvTa/IndueIGtKpB59QAu4V
         W7I6y71nObWiZwnSBoAQExzrqU8OsXTDiB2h4Eh59nLMGsobGV9SAwprC7b5pdeGbidr
         xPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326854; x=1728931654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCJnofJB3LcxCFfN7d28LKDXgXDjXmGss7WgO3ABDjw=;
        b=kTLI2z02A5RzXVCQX+r3NHFdOkZCYysBR1HT9qVOGbsr0wfsOLiV1TMDAzL3WT7qpn
         pYbtz1sgfAXSNt0kBgg6NyxFSaNowRWk+1iKayA/4FdnCj9zcEe/xY6dTtCziOCT0eXj
         eafrE8bxh7eEfgmkjalnE0aHTeUTQ0yEYx1bSX2ROJq8p5WZPvi/s14bRx/opZFnNtwi
         EvvvX1sfwkTrjGC4zjC7cjB7rIK2w2+ySW4T5whF87EXEdo4vs0qWGH0PbVD2xA4iwcR
         ZDmkz1RCMYKnVyMws18DfBCUQLPdt2Va9Nt/tnDFEku2NMQQn/R+jOB3lSJA7Og6kkFQ
         jbgw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Y8NABukVwIkRow0LzEJf9XoUrtEkTd0fZS+6LSeWcVjseGfnPJiX4i9InMBFHgL/8cLf9cxcGY9GqWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkvjfRZvtOkwXRAWKak78pw/GJ4YqkPaghvsjP/9KIMlaw0s5x
	w+kgPobonrUORRoER1X5zoWuFrNLhm+OEiDjJhcGfSh0HLJNMoTULJrawFOdqa0bSwktjqWCulY
	hFKOi9CUehoHGVBybCyWQ4w46QNpA50Is
X-Google-Smtp-Source: AGHT+IE10XwilAV6cWkuLMytP+iuw4yAKbXCeHiFSoxYbpbkw/BeudbpPj9BNRViZ/gdleA8Qyo7JWS10F7D/TvfQu0=
X-Received: by 2002:a05:6a20:841a:b0:1d4:f5e4:6a9a with SMTP id
 adf61e73a8af0-1d6dfae2ec7mr8231727637.12.1728326853854; Mon, 07 Oct 2024
 11:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72n25iBCJtDV=XD2q5AEg4Awh9hyeKM0YwbeE0pv0H2hLA@mail.gmail.com>
 <20241007155315.1145503-1-timo.grautstueck@web.de>
In-Reply-To: <20241007155315.1145503-1-timo.grautstueck@web.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Oct 2024 20:47:21 +0200
Message-ID: <CANiq72=WxRPzqVb8W=TRcU54Dr_9A1Fmm8ZVx-NMVbD38YrCFg@mail.gmail.com>
Subject: Re: [PATCH] rust: types: 'real-life' example for Either
To: Timo Grautstueck <timo.grautstueck@web.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 5:54=E2=80=AFPM Timo Grautstueck <timo.grautstueck@w=
eb.de> wrote:
>
> Added a 'real-life' example for the type `Either`. This example
> uses a work queue and extends the first example in `workqueue.rs`
> (commit ID: 15b286d) to demonstrate how to hold and distinguish
> between two different data types.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1122
> Signed-off-by: Timo Grautstueck <timo.grautstueck@web.de>

This is a nice, self-contained example, thanks!

In the linked issue, I was aiming more to have a case where `Either`
was used in an interface (or similar) carrying two existing different
types, i.e. like in the talk I mentioned in the issue. I feel a custom
`enum` may work better anyway for something like the example in this
patch, i.e. when one does not have already types on each side that
make it obvious what each side is about.

So perhaps we can modify this example with two "message" or "action"
types (that may be hidden) or something similar that `Either` can
carry, so that it is a bit more concrete.

It wouldn't hurt either to showcase in addition the interface the talk
showed, perhaps in an `ignore` example so that we don't have to "mock"
everything.

Cheers,
Miguel

