Return-Path: <linux-kernel+bounces-218412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0844690BF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCADB21C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E06A199386;
	Mon, 17 Jun 2024 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="I49rtoJZ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6C176AB9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665254; cv=none; b=RQGsVCGi2scm+NO/pvhMuC9mcHxlAR6TtShr63NuciqN7ZcFzjT9rdE6/ENPa7+AxcixiFRc4qmsvMCH+5ZuD32d9LvGUubUBGqbcSI5U41R34iRflaiYHADa5dSJwog1VnHX9L9ayaijfyXAwQdw337hHsYrBO7TuR2E/DtTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665254; c=relaxed/simple;
	bh=gTKVHkW1xZtVYY3eOX2P1pRamfg/sbP4BfSVBkumSOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jo5UVTsc2SON2BIN4HIkIB485pzdFnuZ9eh111iZLVqdUeIlx1J9IHclzkDKS7KPx5jWlsMsKNhCsj2+6WhCVe4uv+2ZeFKvnYmv94LUeZbMuy3J0JnLqUK6G6rH5bU/J3hrc1B/NbNmjw6KOCVVY2Mzu55Z6T77eP+n5MCp8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=I49rtoJZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso5497601a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1718665251; x=1719270051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgqsUK44ZQpqmoRMnmn8FFdT1lwDfmmk05VzO+/mADE=;
        b=I49rtoJZ833sx+f1S61bqgnMGtJnXvluKB26CH85LKQNfTQ+vOqlCZX5wE29kCV7Di
         vUDrbS/GeWdG5QwAF747ERrtu0J5Qqmk8+I7YElFqZI7+FRsC8DZjqO8pRfmiBRnIJWX
         GZXepyMkLHnOT8AGltZIe8ZN1YWlqR2UakKsDYP1g0TXEF2DjIy7bfedJ4K5r/ANw4jW
         SNr8u1sjIazMag3/akHPAtV99RdHChBjC9Qqagms9wShB4L2nlbT+MyNqhNtcGV61qrJ
         AmbVkURfXj/n05xBO5uS0rmyEolsBZwxF6HpTEfHeWwzpV0n5Bi6/wlf80vehI/uKY+b
         AN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665251; x=1719270051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgqsUK44ZQpqmoRMnmn8FFdT1lwDfmmk05VzO+/mADE=;
        b=BJ3TZKwdq+4DFBCIZfiDJZXrwomI2Tcn0Rcz5XIqD7zIMg/Zg4xZFAdBoxDTmuUtHW
         jgHsTfu7MB2sMlK/5laF/jOCLN/a4J8VW0oTK8DucSSwtZuU4ZYlOcgM6ZL37ZvaZMEa
         b6MEgtFtJ7vRQQalBLnyiPw7iZHZkUoTDwT8Jn+0Pjdzy1izrH1zBguw1/PnBQ8gduS0
         0enU8O06zsGxuggk2z66//t06ETj5gLlxA7vyJSn0Pjx6Q7frAdiBJcFYHK4p3chWBM3
         4Ld6zk5gQFkjtUAn/IAt+5HPp439tDW2zab9nqHVHT9/EdiCfX2GUlSprzlKaQQIq3jN
         afdw==
X-Forwarded-Encrypted: i=1; AJvYcCWBdHuhM7hcf/sLn/yo8ZCHrY0b8GjFek+e3GyRyz3ok8C09/sch1ObkLjJzPxEgv6vd4fOnrmy8py82KDOSf/qbeRhaXYsaGbzTD1Y
X-Gm-Message-State: AOJu0Yy+l7Mc+1ZCgXu6Z0ayNcq+f77J3M9lZBHY/VFCmJD/yUiD054L
	LSiNTwA31ViWDMH1gBHYhcbEHiH1aPEVUmVMKTz4AC00VEHu6x7tWzRtRZYV5qjSiiOJ3giYeOF
	ubv/5MbxtFZnXZMw84zEf2y+dcLvw+84lkpUX7w==
X-Google-Smtp-Source: AGHT+IHR0xGGPPqIxEcMBglBzedI2u10zJP6TfAwAastiEFg8OFQ/2Qr4OdE8MHvNaKjebLavkS/eRoOocFkLCKgFno=
X-Received: by 2002:a17:906:4816:b0:a6f:2001:aa53 with SMTP id
 a640c23a62f3a-a6f60d460admr669589566b.42.1718665250629; Mon, 17 Jun 2024
 16:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513162200.2658571-1-tharvey@gateworks.com>
In-Reply-To: <20240513162200.2658571-1-tharvey@gateworks.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 17 Jun 2024 16:00:38 -0700
Message-ID: <CAJ+vNU0F4n4Hfu=ZL5Mu3Nsk3vh4Y3iuH5funvshrkhQZD+b0Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btsdio: Do not bind to non-removable CYW4373
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Scott Ehlert <ehlert@battelle.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 9:22=E2=80=AFAM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> From: Scott Ehlert <ehlert@battelle.org>
>
> CYW4373 devices soldered onto the PCB (non-removable),
> use a UART connection for Bluetooth and the advertised btsdio
> support as an SDIO function should be ignored.
>
> Signed-off-by: Scott Ehlert <ehlert@battelle.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/bluetooth/btsdio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
> index f19d31ee37ea..bc9631bddc40 100644
> --- a/drivers/bluetooth/btsdio.c
> +++ b/drivers/bluetooth/btsdio.c
> @@ -298,6 +298,7 @@ static int btsdio_probe(struct sdio_func *func,
>                 case SDIO_DEVICE_ID_BROADCOM_4345:
>                 case SDIO_DEVICE_ID_BROADCOM_43455:
>                 case SDIO_DEVICE_ID_BROADCOM_4356:
> +               case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
>                         return -ENODEV;
>                 }
>         }
> --
> 2.25.1
>

Greetings,

It seems that this patch got archived due to failure of an automated
test. The failure doesn't appear to me to have anything to do with the
code change or perhaps I'm just not understanding the error:
https://patchwork.kernel.org/project/bluetooth/patch/20240513162200.2658571=
-1-tharvey@gateworks.com/

Is there something I need to do here?

Best Regards,

Tim

