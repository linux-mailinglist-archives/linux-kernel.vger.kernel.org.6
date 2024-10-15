Return-Path: <linux-kernel+bounces-365256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0E999DF99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8667128304A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AFF1A0B15;
	Tue, 15 Oct 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="calJfOMX"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B018BBAB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978449; cv=none; b=R2op95R73hN1C9Zcvfab4aaq6X7R052yn1tjKgsX2qFv+0Ss647i+ZVs17FrtOZzgaWB60tXmw5YFizheNr3mAs4BtE/i3vq3ZmfGjBegQRv7WrbXBbT0kaJVxHZH4dJzIa4bXM+DSgSx38l4XHAjU9awi2GfDKsTTxAW4qLrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978449; c=relaxed/simple;
	bh=GoYun2YYoTvYmiRDG/kn1RcNsjKDNfpXI7EBbEdeECY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmlov+xQvzSZUUVeTQGa7ClGv+eNW6k3HW/0dA8m0QxgKNo+vE0BvpO1gjAbcPUjwlTkde9AIbJcY3q+iqKT/jQ88VKS3Q4630LmgxFVbk42SjF36aGTtZ91jnt2axm3Ev8WY/EpoIWT9fK8Z9YpivDZHK4ZCSiOndD4BBDp0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=calJfOMX; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2923d5b87aso3058104276.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728978446; x=1729583246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny3mMnaV1bWHFaghg1EFFxrb9SGa0BxTVXFYRJ+SBQk=;
        b=calJfOMXY/NNvUJpEgJgC4SwCsVX8+YtjSEZF2kigMpO1tRQrVp2Kt+KHOMbN6jLiK
         7t8zbo9KheD25j/UddkVXl7GmWyTNwIYggXhJHZ4Q5HLwB94SwLPFCw2Zet/CWxJH0wE
         b6se9wLXlje/O2v6BfmAaI5O5cF3ulqqJDBbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978446; x=1729583246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny3mMnaV1bWHFaghg1EFFxrb9SGa0BxTVXFYRJ+SBQk=;
        b=rqdst7WxpPx16xG3oED1F7olFXN1LiQ8om4o9Dp6MZzmdwC+KVGXiNSyplwcZqJLez
         O/acplGFSHzCHmoptFdcRPH5UFOyCSfL3TiwSug7DUeimDlfedTKIo0atHqCdqkq4S86
         OZq1bh2V5xB0Z51r3YONA9UsR6JszSf12n21tVHQzrjB8Owc8cPFXsznYM5ZBl3+RlR3
         8K7AxITW0F6gVq67WwrcY/u6LbvsfHlAcTWQqeSO+4azIB08B3FMjV47cL/Eez1njskP
         97JXpA37ZqNE5U15jIf2AgXK7NMdsihktMTYgOmdwchspGVO4NWimGxJP4KNCBJbttdR
         zLUQ==
X-Gm-Message-State: AOJu0YyzdqIo4NVK5svLf6jBTA+/Vd4Fq87mxArikLScWDRAXruj1YiD
	iSrddtKWVSLVMQ9PkjBUQK0CUK8aVAvg5BQ0BaVmtnScr8qaMGTs8+pNqHG+UReBk0BOuP5JGdL
	OMsqx/yeZeKEw2yciXtSFIvgU+n0P1+GBztHJiw==
X-Google-Smtp-Source: AGHT+IFgcEDMyom21Dz2iBKuv7QRbE23W0I2PN9yM0SwHrPflX6W8Qg+QqYjwWyekpXsOIPP654YogteFiOVKx2vr08=
X-Received: by 2002:a25:d013:0:b0:e28:fee0:e971 with SMTP id
 3f1490d57ef6-e2919d8417dmr8779781276.22.1728978446526; Tue, 15 Oct 2024
 00:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
 <20241014152431.2045377-4-dario.binacchi@amarulasolutions.com> <20241014-active-versatile-armadillo-717c4f-mkl@pengutronix.de>
In-Reply-To: <20241014-active-versatile-armadillo-717c4f-mkl@pengutronix.de>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 15 Oct 2024 09:47:15 +0200
Message-ID: <CABGWkvohy1vQ4nbUpWcJ0jJTX6EPHhQSBmdmiGxT=uhf7hf3CA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] can: dev: add helper macros to setup an error frame
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	michael@amarulasolutions.com, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Marc,

On Mon, Oct 14, 2024 at 10:00=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix=
.de> wrote:
>
> On 14.10.2024 17:24:18, Dario Binacchi wrote:
> > These helpers can prevent errors and code duplication when setting up a
> > CAN error frame.
>
> I personally don't like the ideas of using macros here. Is there a
> reason not to use static inline functions?

I thought that the use of macros would certainly not introduce
additional overhead
compared to the previous version. In version 2, I will replace the
macros with inline
functions.

I noticed that the ACK error is handled differently by the drivers.

bxcan, flexcan, slcan, rcar_can.c, and xilinx_can, for example:
cf->can_id |=3D CAN_ERR_ACK;
cf->data[3] =3D CAN_ERR_PROT_LOC_ACK;

at91_can, mcp251xfd-core:
cf->can_id |=3D CAN_ERR_ACK;
cf->data[2] |=3D CAN_ERR_PROT_TX;

cc770, kvaser_pciefd and es58x_core only
cf->can_id |=3D CAN_ERR_ACK;

So, what is the correct/best way to notify a CAN frame error from an ACK?

Thanks and regards,
Dario

>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

