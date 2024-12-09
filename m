Return-Path: <linux-kernel+bounces-437928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A829E9AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58AD161C08
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BE31BEF8E;
	Mon,  9 Dec 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYA/LOEZ"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D41C35954
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758395; cv=none; b=ovs0hC6wTQXCk/elTdnylGe9JG3JioUuJ0O/FoiIDP1iLKTGJ6aW3EpL48nH5cbDx4uViaiGMW3Hgfn0NV8jgKj7V6EPr817qxmoKDbj7UYV8oGGzDpncP8ZODdnFn2jrH6yzyRDB0m0YpiNMEJQrxh+ZsX2bJGtlSc7mon0iq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758395; c=relaxed/simple;
	bh=6QJYPOXB0LpXbrapQqS2t8EexZLyhSk/IuT5n71H2Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cy+TKffBgzQyEdS5FCzBVnfXlhT/sEHPLVyy8Ux2kqiLGOezIGWywZN4u9bCbSFfQYsEMW6LxJf7sMb+i9vlF/XD8qVAxYItR+lWZ+m8j1rxos7+MhB3rYdAaHbNX0gD00GgSeoSezNHqZ3MZFJ0MTWUD3F3+WK9p3AtBdaYdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JYA/LOEZ; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8418ecda128so196319239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733758393; x=1734363193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QJYPOXB0LpXbrapQqS2t8EexZLyhSk/IuT5n71H2Qc=;
        b=JYA/LOEZmv/ltbM+Djbfm+rnfhb3fj2Y54Abl0COsEVG5xPlQcvGQcgGdxsd44Eblc
         aFAM9qbnh/dNh5bkI2pW8KDwTwVnpcPSUccMPJ/rmAXT15x+ZgIjMgKL655mbngMreLb
         CearF6TqMZ+aJMwHF9IXddFWlEC8HTvH3EHGB34Ce68q/0r9MXDARfVYAJpTWx1sfW/y
         grHfT8vnhZN5xMl3FFDoLtLmWhUvwZidgjqgAGjBRC1GTo1/WXfcauQEZ3bQHP6K8zrW
         4fTicDvkBdty0p+rP5u2oIgyhcEjHzeDmOwQ6xvBWjoMd78vQ+TUL0FPXCdbTWNxjgtv
         DSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733758393; x=1734363193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QJYPOXB0LpXbrapQqS2t8EexZLyhSk/IuT5n71H2Qc=;
        b=GRnIYK3mObbSnvY2srJEKeXK2AW5dCUUDIsqLzA1nvl/4p37MkOmDl/reifJ2nAMnw
         gaMZP9w+8Gt42vNHGovE/x2FEJ/b7pICE9IJRlYECi484mLebKJWj1OuphD0cnExXkYB
         P/HKGe2GpihK/36S7KXV4RU/+Se0CRQlHaVKZJ+hh8ghGjEhipkpPXHVQdjzcKSVqI6a
         riUM++x/OKeMJx+TY8JM5/zUpqYhXQCY8KWI8lsOhMEj/itY+dyRfotsr4vOxiN/5X5O
         vFoTexzYLtz0xAklcIMAN+Ycqpq/YAAgHWr9rdWIRkPB4/oJAMbxvgtpERWRfC+Va6UL
         9LOg==
X-Forwarded-Encrypted: i=1; AJvYcCUmvLWP/Z7qA3bLUQEj8Kxhbs7vzMwOoS16t0iXvjQwk4xxWVLHin79r7SNyktDOP1Kedpz2GOriQYvEsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlD/9o0l4WuqhBQR6YGptMlOOg9sAx+6k0GEg8DNxsrurCNQ/C
	++irVFy+ICDMY4yyZ1uI2BG1DrCumWoClbt5RBEuPF+fiTWBSiFarq1kFWm94jEw+yDhcJJAx4Q
	0160vWyQhy+ep8bMAh6n4e2Q4/TyrXbUtiHCK2rOby96Xswmis+xf
X-Gm-Gg: ASbGnctALIa4d6LDxK5/aLt5UJKFK/TEa8/3fvsCOSFYo0opfJDx/tCVyoupB0Jfl/K
	g+v59LESRBEqup5itSk0d1hpsl7qM/fcR
X-Google-Smtp-Source: AGHT+IE1vUeXksBGYj/fVfeZqb61vi0AIrQrVPcz604WD1GcglXwYuTO7YT3c1pWPT0x4nTEFbw+Exdcyf5ny4QNm5U=
X-Received: by 2002:a05:6602:6b88:b0:83b:a47c:dbfd with SMTP id
 ca18e2360f4ac-8447e21c305mr1740812339f.6.1733758393175; Mon, 09 Dec 2024
 07:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com> <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
 <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
 <1932b818328.ad02576784895.6204301822664878956@collabora.com>
 <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com> <193ab67e768.1047ccb051074383.2860231262134590879@collabora.com>
In-Reply-To: <193ab67e768.1047ccb051074383.2860231262134590879@collabora.com>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Mon, 9 Dec 2024 16:33:01 +0100
Message-ID: <CAM5zL5pvxrpWEdskp=8xNuUM+1npJkVLCUTZh3hCYTeHrCR5ZA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
To: Robert Beckett <bob.beckett@collabora.com>
Cc: Keith Busch <kbusch@kernel.org>, axboe <axboe@kernel.dk>, hch <hch@lst.de>, 
	kernel <kernel@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, sagi <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:33=E2=80=AFPM Robert Beckett <bob.beckett@collabor=
a.com> wrote:
> [...]
> I have no further updates on this. I have received no further info from t=
he vendor.
> I think we can go ahead and use the alignment patch as is. The only outst=
anding question was whether it is an
> implicit last entry per page chain vs simple alisngment requirement. Eith=
er way, using the dmapool
> alignment fixes both of these potential causes, so we should just take it=
 as is.
> If we ever get any better info and can do a more specific patch in future=
, we can rework it then.

I think the 512 byte alignment fix is good. I tried coming up with
something more specific, but everything I could think of was either
too complicated or artificial.

Regarding the question of whether this is an alignment requirement or
the last PRP entry issue, I strongly believe it's the latter. I have a
piece of code that clearly demonstrates the hardware bug when run on a
device with the nvme bridge. I would really appreciate it if this was
verified and my explanation was included in the patch.

