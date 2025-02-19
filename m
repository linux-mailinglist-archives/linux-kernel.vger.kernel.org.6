Return-Path: <linux-kernel+bounces-521461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B316A3BDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B58E3AD4F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4067F1DF97F;
	Wed, 19 Feb 2025 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shkspr.mobi header.i=@shkspr.mobi header.b="LxoQp0vD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F91DF754
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966365; cv=none; b=eej4FFcJxhXcjfz9UKJLQrpxk3mrOZa7STQqwKzmOnmPXtNQdJqY50A4H37FeSqcoUzBBkEo9VJNUU3gCjH+0eyw0Cb+rAnBRy7tGT9f4bZ8B/i1rfQVdWOjoWZRIzjwwF4WWodl8HALDu6482gdmBjcnUPGxfepl1eZJ1l1aF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966365; c=relaxed/simple;
	bh=8WDPqZ+vL4cb0MFyEh1qTh8Uajpx0NdNJLRNV7FocAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wbrxh6EQQOjZlI0Er4cioUuXJA3kEg2E2lx6VB8++1Lv4rNNFtpBTta7IMM5ow2wNTlsRpuFRsdk7NebMFGdKdUVZnB+Q11CUtbq7t3fzxNLovSom3wwdAbKLks8uJm67IPVzdsvdvi3YK0vMwZdnIVX1MR6nv58QbwzFo9JnSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shkspr.mobi; spf=pass smtp.mailfrom=shkspr.mobi; dkim=pass (1024-bit key) header.d=shkspr.mobi header.i=@shkspr.mobi header.b=LxoQp0vD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shkspr.mobi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shkspr.mobi
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220dc3831e3so12502885ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shkspr.mobi; s=google; t=1739966361; x=1740571161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhjIlFQZmJgDNMy72o/YIBnf+53/O0sOR13h4ZV5JHQ=;
        b=LxoQp0vD56X5dpbiNhKyoPrpgZQH7VopR3VWauAcLP/FAKH3V1fSWLLyvEwgrM1WiR
         7fvfqtMJ4gSOjwkf2YGi4PdMXVkhjW3YCkNpw1tA4y8Dd7FHtY3inU24RdjIwdgw2EC0
         /h28NQv8nN26lnPR7QrtOjZLRCU7yS+Sf9itg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739966361; x=1740571161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhjIlFQZmJgDNMy72o/YIBnf+53/O0sOR13h4ZV5JHQ=;
        b=DCtoYDGgN9p4+TP7zcCk1tQkUlnsXb6MsckpGIm5fLAsKNh7vTtjafJUlx8Zq2iqsd
         QjvVfi5nvV/J2rsrhDesNRk3fShtcPX0z3IQv8JPTsmWlaJa5C4gStIxfqdSXd94jR1j
         2J+T0Eurz2lMTY+BDNONTXWV9ylqko9Db8oVbVGeCdjU0XZkH9QkS19wB/w0M90ZJnlR
         FRI5mj67oioq4mgBnfKORCnTChZprTy2BAHKlq+p/aDdUHyEK3EATUpNnzqZMuZFva4z
         OFFZzCbxNQ7gQn2GSOKI5McwJ0uVb/Is6ZwzQVpAAkIaaBMKRN/HylcwMG62fGSdmzEG
         8u+w==
X-Forwarded-Encrypted: i=1; AJvYcCV2PErY6E8zYrUfrEhQRnFyU5ySo8wFkMkK0QvLgZ7c+yu/e3S0oFP+Bj4JIITbFhajEHdr9f/c/a8WQDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1d+0APFrlsxZfJKaDZBp9f4UM0jhNfzAIkM401tSDUna9cX5
	sWyPXNWnELQpf8XfdeQ++thVXrZEC2bz4WcjUvOXP6Oyjg8xTnMHz/0GkfFVY1JJzpjaYut3hPc
	0fa2LxbDIyRlfujcUUF1oazVMOURq9FI0vvUnjg==
X-Gm-Gg: ASbGncvzH+PAfUemkB0ovTWnNYlgQHEYZHArz/PELrR0afyXhn2Q55huG7lCfSTFduC
	6z2hYIswQf1X20T2BHWtliEdA0Rstsm+QMB4/YMzZ44DWq9a6bgYrFr4I0al01GQvJVWx0fQ=
X-Google-Smtp-Source: AGHT+IEIDu7cQIabhELINhbbJ/JqmVLW5wmtW8XAT57/BRdqzv+jjODmqF66BtG0qpi54DE2iwfZ9nia7HowDeQ3geQ=
X-Received: by 2002:a05:6a00:1886:b0:732:6a48:22f6 with SMTP id
 d2e1a72fcca58-7329cf56ec1mr5772209b3a.9.1739966361436; Wed, 19 Feb 2025
 03:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPFVDHokn+kfyk9AxTHuBJjRKMNJjZy8w=e-qzvXaA8Vfcq6Dg@mail.gmail.com>
 <87o6yzs6c8.fsf@bootlin.com>
In-Reply-To: <87o6yzs6c8.fsf@bootlin.com>
From: Terence Eden <terence.eden@shkspr.mobi>
Date: Wed, 19 Feb 2025 11:59:10 +0000
X-Gm-Features: AWEUYZkug6csWP395XWtuoa1wgcZpXRIcIAStp6hrxOrgrqmtvoIFzgVEbubXvQ
Message-ID: <CAPFVDHob_mna4DRc91cNVAF85px91NV7gjJr-kbY63EYCnJ=EA@mail.gmail.com>
Subject: mtd: rawnand: r852: [PATCH] Fixed a spelling error in the comments
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: maximlevitsky@gmail.com, richard@nod.at, vigneshr@ti.com, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Continuing the work of Commit #8ab1b51 /
https://lore.kernel.org/linux-mtd/20240923065649.11966-1-shenlichuan@vivo.c=
om/

This fixes a spelling error in the comments and removes an errant newline.

Signed-off-by: Terence Eden <terence.eden@shkspr.mobi>
---
 drivers/mtd/nand/raw/r852.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index b07c2f8b4035..136589f9a0e9 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -242,13 +242,12 @@ static void r852_write_buf(struct nand_chip
*chip, const uint8_t *buf, int len)
                return;
        }

-       /* write DWORD chinks - faster */
+       /* write DWORD chunks - faster */
        while (len >=3D 4) {
                reg =3D buf[0] | buf[1] << 8 | buf[2] << 16 | buf[3] << 24;
                r852_write_reg_dword(dev, R852_DATALINE, reg);
                buf +=3D 4;
                len -=3D 4;
-
        }

        /* write rest */
--=20
2.34.1

On Tue, 18 Feb 2025 at 13:58, Miquel Raynal <miquel.raynal@bootlin.com> wro=
te:
>
> Hello,
>
> On 18/02/2025 at 13:21:42 GMT, Terence Eden <terence.eden@shkspr.mobi> wr=
ote:
>
> > Continuing the work of Commit #8ab1b51 /
> > https://lore.kernel.org/linux-mtd/20240923065649.11966-1-shenlichuan@vi=
vo.com/
>
> While the diff is obviously fine, I'd prefer if you could write a proper
> commit log.
>
> Also the title should be prefixed "mtd: rawnand: r852: "
>
> Thanks,
> Miqu=C3=A8l

