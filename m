Return-Path: <linux-kernel+bounces-571934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CDDA6C46F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE0D481FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207B1D7E57;
	Fri, 21 Mar 2025 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Df7G/70S"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38F230277
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589872; cv=none; b=jJ7gr6yZTttRHVVer7+GDDUTxgz9+RrAZ6m5GOVX/sT4RZ8F5jwn3NmdQP/RCMPI4b1uJgon9snKMTo8oN7sEp9NOuzk0DFA/Hx82d/TubFFknDOiaA1opdP2+AzsUY8hwpkK8aDhU49WtmRx1q8iS1mZthd68wHy29G/VVH6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589872; c=relaxed/simple;
	bh=IzHqaB1xXtn1biQiH6+BombSZ4qjcO3Cqq4ZsPGl3l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dO63oSxTt03ozNzwuNcRkYSuTJXx/emSebCx7cN6Wy5xKHM+gorBdAnx/SlEXgp2j3XqyPOwwRUM2y+OCHIZ2GiWjLV8rEIfbkVg+kdyOMbEXPauVAP8RPnIeETHh0tsyCwbLvu0SepAlOhLOzRsCcmWZzVtyPgRWPzPgLXSG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Df7G/70S; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff67f44fcaso607614a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742589870; x=1743194670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzHqaB1xXtn1biQiH6+BombSZ4qjcO3Cqq4ZsPGl3l8=;
        b=Df7G/70S6OrIfrYMdFD/IF050RU2QpVYEdF+ukbmw/l6vBikGlCg5wr6/q1u+QApgT
         pu8o1mIOZK0jpPAYA2Dj5sqHe7cILgWH4Xo/XGcylI95zlOfdmELN7RcQnfnUv/ESBde
         2y3tzLf4QayuyOfptORABC+0vvyjh+aGT91++ZxWgCKnw6C4tm91pn1/0ML1BJsD48f7
         x8j74+zdHeKZnqtANBVpkOFF8NSCgfmML2Gn3FqCTpQmZUGpWtguGUj9YNRcAlPFJt8E
         z4C40Ie+oBR9dyhWlLB/ytYh2MrWyd3pSopUnwXbIt5IABJadIju+aRBtR4VGoeJz3KR
         krKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589870; x=1743194670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzHqaB1xXtn1biQiH6+BombSZ4qjcO3Cqq4ZsPGl3l8=;
        b=KVQN4ervOXlH1xZy/+U7bhQ9Pw+3C4SeSn7rKcxFhm7hRynXCoijlj/hqBtGRvx/M0
         6PS1HH4nw7sSVfEbwrOND4drMQKkqm8R6iP6H2hXdFL6c2xT7ouAOB9WgBc8dtFQCEwf
         J4kdQrQo24CFhwjeI/f3wp+9aUbVeaR4eIleVfHH8C3Oo+JKcU9T4O3RhlZPXSurmCJa
         9pLYdCPXwsw7ylmz76Je9y6MGqJFFUK03tmmyRRwyTT7fv3nSjxvJtguzfPvL2DPla9+
         kr0sBCi4GrvlRRVgcPdfFRGxhqFx25ZdsiEvZb81faSj5PDHriL11Zg6eRwLS/TG/lxc
         GWrg==
X-Forwarded-Encrypted: i=1; AJvYcCUPaDOFlHGhD7lqgNYMtZ9QiDXtnHLtLlWmSXFzeflqM0gXMCYwdS/l96umBgz51GHBfd3P8l4z/4sKpVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJuVnmjiLkBU85WkTxnNomrAO7bkYaalAJewJGesnk/ioOkPFq
	HzojzGzgsBCh7It2v/PciKVofSTArdDPSyDPkzLFmzQMnr/I6ZdaJ9u9YTLTo5DmjJ6ldnYI4vv
	P0sVyZV521R38Z7EK+u8vntP6ACNZZvMd4ux6Ag==
X-Gm-Gg: ASbGnct95aApqZLnKyoZzR0QI76nYcdSqvrfxPRib/NnrmxW2n9hTQAKP9aOaOAoLlq
	tv5BlE6kEIEGUWLTx7ZZrgWHwOWicWE/ZMZclM7HgEN+pdVP5/U2cfIopD3Pm+42TfFUOBPE35E
	ank7roCk50s9mXwuFUTBlgeh3D
X-Google-Smtp-Source: AGHT+IHb7qNZVc4dbo1EN1WvdXjQ6zVnZ8qtjLzzTA7S1AqgBNosamOSmdEMbw5hYcAX2F+qzbprqzxMQiDGSU0T5QI=
X-Received: by 2002:a17:90b:1c08:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-3030fef77bfmr2814564a91.5.1742589869879; Fri, 21 Mar 2025
 13:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321184819.3847386-1-csander@purestorage.com>
 <20250321184819.3847386-2-csander@purestorage.com> <ee6c175c-d5b7-4a1f-97b3-4ff6166c5c73@gmail.com>
In-Reply-To: <ee6c175c-d5b7-4a1f-97b3-4ff6166c5c73@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 21 Mar 2025 13:44:17 -0700
X-Gm-Features: AQ5f1JqsMWeWHDB8wb1B7Zchq6sPKT-24dX-m8MSW4wk0vEJnpusemPKRi6lxhQ
Message-ID: <CADUfDZq=UMw+tm8YdnttVSL=wvF_fnBSvixbfj=KZ1inOLZHug@mail.gmail.com>
Subject: Re: [PATCH 1/3] io_uring/net: only import send_zc buffer once
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Xinyu Zhang <xizhang@purestorage.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 1:37=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 3/21/25 18:48, Caleb Sander Mateos wrote:
> > io_send_zc() guards its call to io_send_zc_import() with if (!done_io)
> > in an attempt to avoid calling it redundantly on the same req. However,
> > if the initial non-blocking issue returns -EAGAIN, done_io will stay 0.
> > This causes the subsequent issue to unnecessarily re-import the buffer.
> >
> > Add an explicit flag "imported" to io_sr_msg to track if its buffer has
> > already been imported. Clear the flag in io_send_zc_prep(). Call
> > io_send_zc_import() and set the flag in io_send_zc() if it is unset.
>
> lgtm. Maybe there is a way to put it into req->flags and combine
> with REQ_F_IMPORT_BUFFER, but likely just an idea for the future.

Yes, I considered making it a bitflag. But since there was an existing
hole in io_sr_msg, I figured it wasn't worth optimizing. Certainly if
we want to shrink io_sr_msg in the future, this is low-hanging fruit.
I'm a bit hesitant to reserve a bit in the generic req->flags that's
only used for one opcode.

Best,
Caleb

