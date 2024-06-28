Return-Path: <linux-kernel+bounces-233707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19AD91BBDB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715F1B215E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547D5153812;
	Fri, 28 Jun 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="roGrKEXk"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0AB4D58A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568099; cv=none; b=Xb9L18H2efmKOwcxyghoswWtF8zMX1F3ZThTcC3of8J92yDXLuyhTTrmTxbbaYYqVCB2OZ2WSei/7+PWrBJtKvgmSiYde7NekZ6PWJfAYluP/rlP09NZu1fOcQ2B9GugRgseI1Fvs6sTZm94UkYSP8nzcn7WDSoUD5qfKV/WcTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568099; c=relaxed/simple;
	bh=N9ul7sciE4TWD5ZCzRMXkQo/BW8Bk2N6jU2ho5gBxDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWuBtkwMGBTpvslnzUT0jvlIMGYLvizShK5vARVSvOkObrw0Zi3d4Xh1djsIqOaQJmhHI7jvnLz7btJKYgxnKR6bIl/enAMCXAfpwvmYjJuE2n9v3ADkyprB1yUzXOvby4Qb/Q5BHYxVs0is0sEn0z/lweoy50SZnDM+pn6npkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=roGrKEXk; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b4fced5999so1922206d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719568096; x=1720172896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9ul7sciE4TWD5ZCzRMXkQo/BW8Bk2N6jU2ho5gBxDc=;
        b=roGrKEXkgOuPWGP4cWrlmSIWtFKzZUMt/15MXOuALr8KGNJE1YO3wVAWVZu3iSZxRw
         wuqPWO5hyH+sD8X9dnOugrOuGfQqeIUlQQfSoO53sr7dhsL9gAYvgaTwlDoOjK3TrsKz
         pW3SITw6ZzfyLIxP7VYnRJbGxpaqmUCcOsoZ99tCa5vMBHTz9Nz59b3J5rW4VhXDlv44
         o68Fdybl/gAnIDW9Lj5XGd37qlosTD9ZY/aDs71rZ5XJJnMPYmEQ3lAvzt2p3unTcFGS
         XxEKLSphs55AZl+kAHqoZeAIeXUPrkVBWEHp+p9q/x0ZAXwzmdBSZZvgYXDSSe6soziH
         HhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719568096; x=1720172896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9ul7sciE4TWD5ZCzRMXkQo/BW8Bk2N6jU2ho5gBxDc=;
        b=ijfRTU16BfXJ7cq+nsZ/PY9PJdCBTf68UZT85CG2vXc3qJ1kfNPVu5gyp6QCZTdDk3
         z2MR9dHHXnz/IdWnZiOXvL6eZWhhidm/ElGL0ibThlbNlSxC3c5smTXkQgfuC8td5M46
         5tQwvvsStXp4bJwCryp4YK02uYsTeiy2LYm/+xtQdgAceCFmhdaPD6vCpJ6so++cc3uQ
         tfXRYTLp6p2/5PIoYd0ejz9+MHkIWV0TOdQRZZiL4ae5/VODDlkNACycDPQU2OrYh7tH
         YrC63A9RX8PXsz+xtbTqJ31MmwtmkljDWu2QwYCs0YA1EL0PEvaV1uMkInAWFyRGiKGY
         qpCw==
X-Forwarded-Encrypted: i=1; AJvYcCUUA4w4ZWINy/sLTY7vl+9XWPzOAbqqMfWIvK3TT33wK9XP9z0cKYy5DOBSfNfIq6K8w4NSX3Wo43Ycrg7Wiv2Fgmfx3OLWrwEXoYNh
X-Gm-Message-State: AOJu0YzsaB7Z/s5GNA9HwGNiJ7iAarw7kuNT0iL0P2G/xSNWWvK7nlkI
	5Coao7UvmE6jmbqW94CWDe6fGNn+SQW3tQ7FnJ3qgzKFjzz94K9qOuAeSXX3oYp+22rx9A31eFK
	bYap4iQWhKhRMkkjufentHolMdKo2TFUb7Ln5Ww==
X-Google-Smtp-Source: AGHT+IGKbXGa8tFRoUBtX9jPFSaA/HXwNQUkn5EBHWhOJnFoUnmXEc3piUEvQv5r8Xh65vaIT9hG5Yzp9EElL8Q42qY=
X-Received: by 2002:a05:6214:230d:b0:6b5:468e:d413 with SMTP id
 6a1803df08f44-6b5468ed608mr190751986d6.40.1719568096583; Fri, 28 Jun 2024
 02:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
 <20240620175657.358273-9-piotr.wojtaszczyk@timesys.com> <20240621103019.783271f4@xps-13>
 <CAG+cZ06GSxPsTzRLXSk23qWXMkp-qxYq7Z9av5-2cPHSJmVAHg@mail.gmail.com> <20240624083900.14e38d82@xps-13>
In-Reply-To: <20240624083900.14e38d82@xps-13>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Fri, 28 Jun 2024 11:48:05 +0200
Message-ID: <CAG+cZ06j4XACKtgwkTyjK0jhFTt+-EYTN+qFKO20ow3sjK84BA@mail.gmail.com>
Subject: Re: [Patch v4 08/10] mtd: rawnand: lpx32xx: Request DMA channels
 using DT entries
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "J.M.B. Downing" <jonathan.downing@nautel.com>, Vladimir Zapolskiy <vz@mleia.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:39=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
> > > I don't see any change regarding the NAND controller node in the devi=
ce
> > > tree, is there any dependency with other patches from the same patchs=
et
> > > or may I apply this directly to nand/next?
> > >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > Yes, this patch depends on "[v4,04/10] ARM: dts: lpc32xx: Add missing
> > dma and i2s properties"
> > which will be splitted into two or more separate patches per request
> > in the comments.
> > I'd like to keep driver changes and corresponding changes in DTS in
> > the same patch
> > but I've made a separate patch for DTS per request from v2 of the patch=
 set.
>
> These changes won't be applied to the same tries so they must be split.
>
> So I will not take this patch for the next merge window and instead
> will take it for the one after, if the DT patches have been applied.
> Please ping me at -rc1 again if the DT patches have gone through.
>
> Thanks,
> Miqu=C3=A8l

Hi Miqu=C3=A8l, please check v5 of the patch, I've added fallback if a DMA =
can't be
requested using DT, this is backward compatible with platform data and no
longer depends on the DT changes.
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20240627150046.2587=
95-11-piotr.wojtaszczyk@timesys.com/

--
Piotr Wojtaszczyk
Timesys

