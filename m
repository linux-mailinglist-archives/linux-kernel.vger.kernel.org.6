Return-Path: <linux-kernel+bounces-254740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AF693370C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E542835D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC114A96;
	Wed, 17 Jul 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqhcP/Kr"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E3E134A8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197736; cv=none; b=CxmwNhyVMMDwgNF2TUhpOeaLUuvDfuiVo0CLYmgtaK/UkUhK2KGN+yQbuxQjFe3/reCZrdvJkOeAyCiIgqb3WJTPRqdX3KiO7wCcHjUR3vWQIIXoZwuE7n54u7JN6znjhIe4hq1T9ss9+b8LSJ8KEiXGyjT6oAaHZV/mcfxwIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197736; c=relaxed/simple;
	bh=RSkPTIXm0vgM5ibd/3x5KTHf6taTWqqsaoDXuJQEbag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb7x124jhvbsKjmJ9gfKx9U0hUznARNgA/8QvGqIfocqeluuURGth5cigGSsm9pks3sTk3hNa44BViDaAE54hTGTW0eOEBJb7XFFeo4o/niW34nGlp1MHX3AmmnJvooMlopsAYywILbbLRKXzi8ySlyaX5QULUQHgmMaetREEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqhcP/Kr; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-81019fe58a5so14712241.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721197734; x=1721802534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSkPTIXm0vgM5ibd/3x5KTHf6taTWqqsaoDXuJQEbag=;
        b=WqhcP/KrySfbJUIDzAYkz/8BgM/ZjcNRJ2bjln12yBjc+kkKwTmlg7awl6lenoVmYg
         r6lKJlhFCf++ktX9jotSprK5BOxbOKacIgjCH8k6Zc/9B1ZOnJHuI5GDpEClfJJlq59e
         5Wtzk/sTBtQRgKwxdUeDbV0XDPLTQm2Qg8kubRFsbkuoLFeTXymYMSm10ZlD+z7i4RLD
         BbNmq545/EkXqEeLmkehVDuTe759GSlkxfeMVmtwhKHP8pFCPuMC8z9ob+Kcatxi5UDe
         dewppmk8dnqenSlCtlOc/Y6Dj+++MnsfYzNKtVz3/eyx9GMGTLkXIk1P4WUrH2fccV1h
         8C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197734; x=1721802534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSkPTIXm0vgM5ibd/3x5KTHf6taTWqqsaoDXuJQEbag=;
        b=rlSoC46Jvn+dtzZupnBL8TShvI3U+MHGvfsikk8STIJoXp01mTnzO72z1yiaJL+w7x
         LRnWfJL8yEp/yua+ZTX0EKLNgi6bFr/NjcVmXU2KKl6QDC20rLRgH7UBzC3J77i6ZvWk
         45/DWwZPCLjcdNnVE9Y/C4E51QMrUXb3StKsW0A3b+xpKGoeCwwMb3/cVTbAF9j41QC/
         X0ykSgWST7/XpaylRyE+n6ey4QmrK7BMD8tPH7chrpO/796QNsSpaNdGihhKaomuVUtv
         0+AuRpg3wJFZCXdbaTcjdW0cN+jZCyVFd6jUVq+f9nnbueLA2IZElfSvcyps+sFo1FBE
         qvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkxc1TYBqRwSkF6HXayQ4hF1L/9oKqOj+yVcV/PCDBPR7uZypk7HOhFAS5WUvCbaOL83QUxWBjg9VtMgyjw/XO90P8okxbq6dFiKio
X-Gm-Message-State: AOJu0Yzvdqd+qJAUx2UVoTxil3RBrkMUs503rs6MzXuZ2b5xgeoGIjdr
	zxA1rWGRT26oiymaKWCxFLmHUZ4J/tD6d1wtKvM2PvfiMETyaU377nG3En0VfqzF91FD4VJyzZq
	2rCt9KQ75WRsiNcdl1KM/XjK3ZSs=
X-Google-Smtp-Source: AGHT+IH6emIdV2LByUbcOkl0hcCesewSNdqY3NUKroEri1dufWVwjzjuOcqKzkDUbKwvEDD+8AKPj3GMeNqMto1COhk=
X-Received: by 2002:a05:6102:c05:b0:48f:8cd0:831c with SMTP id
 ada2fe7eead31-4915970e4eemr532812137.1.1721197734211; Tue, 16 Jul 2024
 23:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
 <CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com>
 <CABXGCsNN9LwHc2x2AAEH=5UNwpvkWkBqRYz3OP8MZ6Woy+HDXA@mail.gmail.com>
 <b6c440ca-e63e-429b-af41-5f27d4b8b2a2@leemhuis.info> <CABXGCsNoFfMn7LaqqFgEPg-ECyUPN=f=SXVrFi=GZk6c69-Gqw@mail.gmail.com>
 <CADnq5_PDSkr4hOHJmb1J30UC0a7sXsm5-TPkEmjzffMK_A+7ug@mail.gmail.com>
 <ea465a40-f673-42b1-8b1c-a2efb20cd562@amd.com> <CABXGCsPyrUEqDq2gbr4VLw5ncd9cKoCZ9nOr2SRfg8Lh=9H5Kg@mail.gmail.com>
 <2915a8c4-ebac-4dae-8f09-32a5b4d9aeda@amd.com> <CABXGCsPuRViSd_WeOciLKcQ4hjYxJ7e3i7LomwsUMzd0a+zvBw@mail.gmail.com>
 <CABXGCsOsfP2SToiDhRAS51nPJ+Qr2v7B3Kjr+yVeP4G7zFZpMA@mail.gmail.com> <CADnq5_Mjxna+aqhWT49YLmXGH+piittc4FUSyCDEJ8s7G-Rb3Q@mail.gmail.com>
In-Reply-To: <CADnq5_Mjxna+aqhWT49YLmXGH+piittc4FUSyCDEJ8s7G-Rb3Q@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 17 Jul 2024 11:28:43 +0500
Message-ID: <CABXGCsNS0a2tybuONAJuGoC1+01=RFhwSzfU6HW_ZLau+jAhHA@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 10:10=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> Does the attached partial revert fix it?
>
> Alex
>

Yes, thanks.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.

