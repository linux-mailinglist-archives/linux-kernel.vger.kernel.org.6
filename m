Return-Path: <linux-kernel+bounces-566804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F8A67CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9237E19C3F40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72412139D4;
	Tue, 18 Mar 2025 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np3LpxQ/"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF09212FBA;
	Tue, 18 Mar 2025 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324788; cv=none; b=c3ecv4Ax6Z+9BQv8Quj7NIfQm8bN1mk2K55CX/WkYwOXNhyLDSC5CvHA9JAKLSg0gPLjdnc6exAeI4C7h+MCGcGxgsG+EYV15WlD4IRy42S0dCj5XO1wEgyfar/8UKCLXGKkmHWcqCFA3pS329N7WusamPcQjRJasSf9SwaYgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324788; c=relaxed/simple;
	bh=bI/yDH187i1TEFtT63Lyj88JVRKqWkgcx4WuVkji76s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmXRU4fyDz5wK6AgT5hH6tv3x1izDhQ7EiLEH8TsUYds4ROcgCPer1OvJluR/TGYm2+AVTldH7yXhY1v4S9a8q2pBkFzr1/VzD/Fn8kzm5Y9CBv7JJw2h0pUGzsyxKcp0huiQNvQSePnQ2A/hi5Sq2SxI/2wJEtPL96N1y5m85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=np3LpxQ/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f8f3bd828so12200575ad.2;
        Tue, 18 Mar 2025 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742324782; x=1742929582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI/yDH187i1TEFtT63Lyj88JVRKqWkgcx4WuVkji76s=;
        b=np3LpxQ/HPFttJBh2Z0/Od63d7qirVQexwyxF2iniLMdxbkhPXfy+CUyFiHWgJwxeF
         AIyjP4KridFyWcXucL6cIkA09hQ5pWW7S+DHqaVKR0sk13pixzWbwBT3VhRbbjig9AYX
         6+ozo4gQh9o5oXfoMWsMvmKwGUyqDIo4RlQ8t5De3h0tJdWNADV2WF1rMzgzDhSd/Yws
         tEjWG+DteqSjtLuwKEU3HgbUCYKyvX5hgf61So7Fnnh6x3FpRkCFDzIyLn9mqkAhsJ0R
         GhuwIiN2Oa+CxREsmR99GCQ8WHy1FU2+mveKAQdnBWMMSHAvXNUQOWVfAiMRR0PDtwTe
         dQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742324782; x=1742929582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI/yDH187i1TEFtT63Lyj88JVRKqWkgcx4WuVkji76s=;
        b=CROPkdgoxVDrDaPnNiCh5JQkpfDizLyxtlrW2gLoGx/DW5PC8IKBP1m4G4KGwFja8a
         8cPfGCKIsqr7C17D9cowyX56Z8CgWhAgwxmuzFPmBLPCC/LmEPYWLPFtL1JCporkGre5
         +PgwNyLsvlzBoV2sIZ8kK73ZV5BXIg4v5lktjZTbSLbkc+W1Irq5caslAPjyva46Ccea
         v8TewSf1JqZcZFBhpeOsACe1oE4Yq2F50QaNDW5rehMlJkUyoG9jSJNaXy0+sdE5vK7h
         pYnll3uIiWN95P/BWVTpOKdqjYVm+HHKdPdm/CM0+xMXb9fggcJ5nQS62I2iw/d5nk19
         xrYg==
X-Forwarded-Encrypted: i=1; AJvYcCVfrkIXgdW2Vxi0QtHrsH0vwDhExAafV/lWwOnr5U+I5xmMovBesKV+PmbdifKTtMx6YoSIjwLGhq5adMM=@vger.kernel.org, AJvYcCXg02ULXCQHBK7GtnQBlIyfVaq2JpJe5EVFBfNt4DQMlSWPWDQu95X1AcXVAsWn1J7fD4VRj6eWVJi256/o3MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJbN7jxTT8rNxUmCBlkMZpZ9+koyWNCXUzdDVW34tf5DGkG8Y
	QOR0du0K+/Fsl9Xal5dwteaObBZ4tjj2FdxNJiIMV6HhIihjGosFT+2S9QBO4fhhovo37zn9U+t
	4RBw/lyKpQUKiA8KrNmPzlEX2LA4=
X-Gm-Gg: ASbGncthOTtm6PlEj9a7R5X3eu8wj+zsgHN1jCon/3lSijk8h0JCz8Zw+b0UH70yuik
	8eWOA1T7jUR//DOjxeK75ruiLfjRN2vdaUiMqXbVWIdHxcH605+zzKE+n25O1qzpyHVhCGoBSQH
	V6Mu6DLrA7gKZ1Vtw9NFGR2XXhZVsNb/G3l0Sh
X-Google-Smtp-Source: AGHT+IEyseFfbEvwp2GqBH7WmkpfutX2mV5HknTlvM0wky98GPTBxhLW+WH/hFNotYCPow7EvEBycv8/VSwxmHUWxkI=
X-Received: by 2002:a17:902:e5c3:b0:224:2717:7974 with SMTP id
 d9443c01a7336-225e0a54ed3mr86815535ad.4.1742324782099; Tue, 18 Mar 2025
 12:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-4-abdiel.janulgue@gmail.com> <87frjajwq2.fsf@kernel.org>
 <03902487-5cd3-45ed-b3cb-cabfd0ac5cb7@gmail.com>
In-Reply-To: <03902487-5cd3-45ed-b3cb-cabfd0ac5cb7@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Mar 2025 20:06:09 +0100
X-Gm-Features: AQ5f1JpKqT0k7rk4CgIyNE57qiW3K9pAOdJs5FPuC9sjlSncOTjWB4gkzDRk9Kc
Message-ID: <CANiq72kjTTAsQTG4S4WuQi0Udnb+2v=gK8mOTWBhprMsGev3jQ@mail.gmail.com>
Subject: Re: [PATCH v14 03/11] samples: rust: add Rust dma test sample driver
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, rust-for-linux@vger.kernel.org, 
	daniel.almeida@collabora.com, dakr@kernel.org, robin.murphy@arm.com, 
	aliceryhl@google.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:42=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Changing `dma_read!`/`dma_write!` to return `Result` is probably not a
> trivial change, would it be okay to have this fixed in a subsequent patch=
?

Yeah, if you feel the need for a v16, I would suggest focusing on
changing whatever is essential only, since I will be applying the
first part of the series soon.

Thanks!

Cheers,
Miguel

