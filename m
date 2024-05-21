Return-Path: <linux-kernel+bounces-184321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A318CA563
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3882820C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C53848A;
	Tue, 21 May 2024 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PyC6e4pB"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC493D6A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716251732; cv=none; b=SfJDQK7PIFS9+dHsuIXgZIJgAGr6CxWupssKptvOA6boSqlHwsjFqHOTp1tX2NfumbtH63BYhMGhhRAVJQ7MQQD1MzsFTindB7wF743k0CF/ai/ogwPX9yuv9eEen9nLAB+Z0vUYrZOkZH6CKtSMph/+E873BOX/j63r94uIpJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716251732; c=relaxed/simple;
	bh=JcjQq3Y/hoDek6F5UoJex5CmssRYiAFOnlRMpLISlVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d70NyPrOD7MBsL9fJfrEe0Lr7ZvtG1BdiEVMuxqtgSRjz2iCbGOz009D5wzTmXmbyrEvLfe9QaEyAfxY3nzd5G5elNfah7cbYGwpzDe+gP3GQQlwYhgkIUt6Dx6pqeI6w2oro4xWWCyq0jhd1AKc6zVTyY6JmgvsMjJWeu6Bqlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PyC6e4pB; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e45c0a8360so36207121fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716251728; x=1716856528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcjQq3Y/hoDek6F5UoJex5CmssRYiAFOnlRMpLISlVM=;
        b=PyC6e4pBbdOhfhnZQHCRH9zvnsTyuZUugNIpFDU0dxNR81cFQvGdchwuNzG2z/SJ8X
         8pSW/H4wgOIm5Q5O1BnyKMvK9Usy4CEbAFAo1rpuOZOKgvihkSgCZmXT6y2/etg4aULM
         L1QtoZgK+Pg4S0yoXF1qIUCdDHmQd8BeCKb2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716251728; x=1716856528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcjQq3Y/hoDek6F5UoJex5CmssRYiAFOnlRMpLISlVM=;
        b=Urhp1kOfQz15mygnSvCvG7Ph90ot0XD+K/YqQQ0PfiC+T+M3dpnFXCCqc+GB99XA+I
         Vv6OOYEWnA4KVdj6njfWVE6rxRFCD2vpu/lQr1RfBH/oCs3I8sQlsx2ckbwKmSm3d80F
         683VeYngniHItaNOCbNxkvgxn2EF9qAzolvEPpf9N4IS+ojaFwHhTWkOmRsemUYSiOwL
         cUBbN9iRCXt6MDpy99metMI7qd8Jga6ZkjEm82rtKbGCPOIrdwrB2WG3LSTJUUHNuRZa
         3W+pS+GMQRvC+Pp/8BE6wafF10Iru/zE5nUVL1l7k58H/gJNELin4DeU9izpE8G63Mf3
         4GjA==
X-Forwarded-Encrypted: i=1; AJvYcCW3Rtupn9PJ2wzAsUzqcs3WJo8GH4VKExa+4OUkD/fHWR2XKCI9Y9hDhPrhV7kXJ7RmLm1BGdSixW/RspKivMghwRvLB7UeQPw1u1mr
X-Gm-Message-State: AOJu0YynWs8pBswNaBmgKFrSJ1SKy3ELpuvANWKnxHoaZ8FXctR2Ty2s
	9/J/B+uiLLDiJYKsopoonsigq+7pdeSVYrKsxhJUcPGsaaFAQ6nIn5Z43hviB1e1vANvaGq6tv0
	=
X-Google-Smtp-Source: AGHT+IEmj7b0r5G+5KBYMxLDyOslHNzu6MxHnWtixRacVmbZ6ysz8TXlLYJErVOA+dKKVKO+aj9pAw==
X-Received: by 2002:a2e:2c0c:0:b0:2e7:102f:7aeb with SMTP id 38308e7fff4ca-2e7102f7d5cmr65408781fa.40.1716251727821;
        Mon, 20 May 2024 17:35:27 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e6a91a9999sm24396491fa.116.2024.05.20.17.35.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 17:35:26 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f174e316eso3950898e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:35:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2W/7FohBRIuzqNFfsIse7XlyAf+0nqTRtGhlJoDRp2Pmyp8bFn1uu13XZKcwGZkoRzFDaTjdqiJP73vVtVuzA7cxrvdN4p9GomErT
X-Received: by 2002:a05:6512:3d87:b0:523:a89f:aa64 with SMTP id
 2adb3069b0e04-523a89fab47mr12749993e87.20.1716251726185; Mon, 20 May 2024
 17:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914145812.12851-1-hui.fang@nxp.com> <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
 <353919fd-932e-5d81-6ac5-7b51117366cd@arm.com> <20230926065143.GB5606@lst.de>
 <4d0f3de5-1d34-d998-cb55-7ce7bfaf3f49@arm.com> <20230926094616.GA14877@lst.de>
 <06d476e5-ba85-1504-d69b-a8c1cf617d54@arm.com> <20231228074645.765yytb2a7hvz7ti@chromium.org>
 <DB9PR04MB9284C2494A3A0799FBC187DD87E22@DB9PR04MB9284.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9284C2494A3A0799FBC187DD87E22@DB9PR04MB9284.eurprd04.prod.outlook.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 21 May 2024 09:35:04 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DGdUCmtFPKuQAd83s9Mcy+_MdMhPJd1sqQkbmubH5wDg@mail.gmail.com>
Message-ID: <CAAFQd5DGdUCmtFPKuQAd83s9Mcy+_MdMhPJd1sqQkbmubH5wDg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] MA-21654 Use dma_alloc_pages in vb2_dma_sg_alloc_compacted
To: Hui Fang <hui.fang@nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "mchehab@kernel.org" <mchehab@kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anle Pan <anle.pan@nxp.com>, 
	Xuegang Liu <xuegang.liu@nxp.com>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 6:49=E2=80=AFPM Hui Fang <hui.fang@nxp.com> wrote:
>
> On Dec. 28, 2023, 7:46 a.m. UTC, Tomasz Figa wrote:
> > I have a crude (and untested) series of patches that extend
> > dma_alloc_noncontiguous() with scatter-gather allocations according to =
the
> > new max_dma_segments parameter.
>
> Is the change merged? If merged, in which version, so I can test on my de=
vice. Thanks!

Sadly nothing really came out of it. The code I posted was just a
quick attempt to implement what was suggested in the thread and still
has some open items, which need some follow up. Maybe I should just go
ahead and post it as a proper RFC series instead.

