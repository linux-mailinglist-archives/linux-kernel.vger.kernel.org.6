Return-Path: <linux-kernel+bounces-365311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120EF99E04A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A781C21016
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398FE1BF804;
	Tue, 15 Oct 2024 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhVzr2A9"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1904D1AC450
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979523; cv=none; b=fqKlb5d3ZwMxRb8OS4NR4BkSayxNa6/bvBh4xahi24FT6yU5P7E3ntcaCzd+zpFP+VhP3Yq8fxzJnTtnycbXIgflimXECmXDb1as4rwDuzQL+NfdxKS7LIBGEIELJLMLMxCJiApKkTeeUcCNJelMBn9waKHuKz26BEGZUjajucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979523; c=relaxed/simple;
	bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsJpEzvLNeQLk6KMnJ99Ng0qUe9o94McnpNce7CMXi5lcn14i/Bvx1Vqypzh0CDGiCl9PuWdiXboGqBLmY+Zk5gOmj2C+FOO+umhzkylaCO4+eum5PQS9NR9pQmAYIp3ujbsQG57unB6H8Fh+sUG4valcwGfI2e+gMXeJ2/nEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhVzr2A9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so3497209a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979520; x=1729584320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
        b=LhVzr2A9It71YnFnO/lZTidFk5WmLGfHKa4KH/Ckgl3F++ctFCTb04TTOyBQooxVsL
         yEwCPtDz0BtWiOfKPce9a7rP38owkGvBKdmgu5uQ+/qDMGHHA9PIB1K1/X2a57xdv55B
         F3RiCmCfh6Sw79XVNWcr7hm1WE7KouHTQFEG3hWHBldemauacOtwefwkOc/lvK5C5JRz
         F/jmHWBVifdgVP1gqVSUBGDV55c6WkdvuMP6exX5fVNtUyjjL/pRz5xLpRKsQ5HO7BnI
         wvwy0CzhApmAGpc9Y4YRo/r+CvWp1FcdT2fMV2yFu04QyoD9tcfzK7FBB1WRZ3S7+6Zi
         DjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979520; x=1729584320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
        b=SZIyANrNXIH/vjNgKjPhVl3ORO1960WC2dMAHxOSy3DwbYpjBTKvY0l79YnDGtgq4l
         luYkqjt/Sogl5O2OJf4TbXgcwg/BLLMIVF8fjmPjEBbxGAySpXdRBlzFQFATZTpc7vc/
         ADiWO5o2Z+FZonU7c2GTVrzQW/IVTMvpERTjvu2tyudbNo7b2obz/BMdBXbby2Msi9mc
         UugfZnvxiTS6pYIdyxF22JXKYAPDUS7Odo5WZTKfj5/g0IkeSRQ870ZiIovaj8ce1+HD
         lHV5sDmH8PVBFYDGTAOUo8pWV7m1PRRRzpJTNc4a3CVAJSO7U5f/Ya7Hx6mZG13nncis
         /tTg==
X-Forwarded-Encrypted: i=1; AJvYcCXq1uzoIGG/KTNF9+0ui7t+EvxBm9dD57f3EV7CCfyYd3tCOvCm8lXnFWqasE78BvUAf/hwq62/PoykZXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCNLTi1LvVAnfqz19dpyrTHUCBCSBIbMkfOOUQL+/D/7hOP9l
	wbMxdl508al1uqL66FTkhK/v7jDykIO3alRmc9fRP64GM2Kx/O+QK3h9g4e3loCLFbVhFfRpBdH
	HveGG3QVQlXwBgRIlYnQ95WpX3+dc+17xQ15/
X-Google-Smtp-Source: AGHT+IGhXaZt34jHqjOXUdH0Zm4cm5o6e/qM4AoXLZ89WM8Mb4hUFPFZtihXBdV2SHb1Q6OTW0ryALy+WWGkbtzvcNY=
X-Received: by 2002:a05:6402:1e93:b0:5c9:845f:25fd with SMTP id
 4fb4d7f45d1cf-5c9845f2752mr3195903a12.23.1728979520189; Tue, 15 Oct 2024
 01:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-6-ignat@cloudflare.com> <20241014213503.99078-1-kuniyu@amazon.com>
In-Reply-To: <20241014213503.99078-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:05:09 +0200
Message-ID: <CANn89iJ49HQGuZikfz_56jUpdUDHfO_1QPGSrnN_OA6PxZdK4g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/9] net: ieee802154: do not leave a dangling
 sk pointer in ieee802154_create()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alex.aring@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dsahern@kernel.org, johan.hedberg@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	miquel.raynal@bootlin.com, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, stefan@datenfreihafen.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:35=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:04 +0100
> > sock_init_data() attaches the allocated sk object to the provided sock
> > object. If ieee802154_create() fails later, the allocated sk object is
> > freed, but the dangling pointer remains in the provided sock object, wh=
ich
> > may allow use-after-free.
> >
> > Clear the sk pointer in the sock object on error.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

