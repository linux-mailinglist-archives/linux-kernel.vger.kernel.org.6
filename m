Return-Path: <linux-kernel+bounces-416670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE49D4885
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30E8282CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0B1CB305;
	Thu, 21 Nov 2024 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LtFs0KfB"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E3A146A6B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176624; cv=none; b=ghEYRBjbcaIxQpB4o+P6Oq76OhfcMexO2omQhWaDHEjH+F4aARVDqN3Dgey6i/r+hzDFuJXdP1CAVlmfK9LYsZkcBKbEA9XSpx+YIDPsN8QRpPdaqJuyf2U/V5FJdkaSkvOgMz66/v32w/Pk3kkZT63q1Dtu/LXBqJOsbjkhgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176624; c=relaxed/simple;
	bh=J1CNHD/ipIg/L0Nh/y/WM5Z08MZpn6PYb6fY+01z9XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dz9lSTlE2yIdm7uXnzLjJ/ePAiCiYGMBtETX3KKdYvMdqnlyDbkWb0YeODxYmgp5Opzdu/IXmMb/pf/dxAyxkxchWLglSeauK1mlyC6XAkU9o6gsvEiSEtUycil4r+Ut7aCA+b8+0CW7ZXNIFtfzA78XCekgMiTUgiDN/o9GLAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LtFs0KfB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfc0209eadso74790a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732176618; x=1732781418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1CNHD/ipIg/L0Nh/y/WM5Z08MZpn6PYb6fY+01z9XQ=;
        b=LtFs0KfBVjtiXWCIpbHI5W3LOrfWt0PiTMKu7TXcHIiskylcF0AHaqWTpMsSXwZYpt
         MOBfwNdds1WolKK38NFIxVJlcDumpWTviCzN5Tlw9eLpx6QMsb1ArArY4MK27CXAUXNi
         MHtJINV/3DQqHq+AQPSMRCWTdXLZfTj2ktZ9S5lX+JW4qKalLC+TkeHuaCLNkc4l3Sv1
         EZSz/9B08uOyZk8JpU88TrsquTA0E9LgmmiWSsbH4f+Q1To01YT1k4f4jc6b1sTyEpGg
         lEv55vP+ALInOO2yEQCVWn+SxD4HZvxIy4QkV76eHMJ1SeeTBMTzu7vfSHWgu23fwGVR
         bdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176618; x=1732781418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1CNHD/ipIg/L0Nh/y/WM5Z08MZpn6PYb6fY+01z9XQ=;
        b=nWwCoFNroMBKS9pMyVmQw2FAVvnWWOWXt8NJ9YAjK5IFYpjEEp1WTXyo7J2xlaq4/5
         8xe0TJ3Mr8I+xZw4X4Gtu8fTdpHoNaP3io3nf6H7Zm4nvFYdeBzmrh8Btwi0HjscTYSU
         HGCavjaD85mDzNpOECcF7x3Fw1XcH8em1cBsY3N+iULBv5djZmEi7oW+7IZrqRE0jlx6
         9YpLcIIfUaS3/GNXi8Ef+FDXbsBn+mT5AtDRcsmvE6RsC+X7cDyzqgKea+QRYhl2H6ZM
         vKU6JJypGQiqOcd5+saDyFXyWHGfY9zTZoYHVARlgQJEQZvUMFfZqveKcyEs8DhE36XU
         DkJg==
X-Gm-Message-State: AOJu0YyhDMmrlKaCEUc4hgTFn6iAkiZ2vThVseVwxsRQIkIna+c0DpI8
	CrPhajU+bbTA1V/1zEPYfQyQ0fcDU0DCO3C7ay///nPIrAWiKJzrMijWLG4GdCC2yhJ+zPjop+S
	8yHATjxiLo/pZ5gulrEcboa3EAbaynKSnB9adJQ==
X-Gm-Gg: ASbGncupoNQ4/R2+wEMn+XP3rip5Y2rXmyocV0gUU0I7uAcB5qrmNpZKlP4TKMwVnIS
	0WynJX/GStgHEbRUGT7QcJv7NlkDe250=
X-Google-Smtp-Source: AGHT+IEMvl1hbMySB0BrKqNmTgujNgYhCn5cHtxvHqbfm5g+a6bdtUVeU22KGhY3n+Q/ksiLTGSywShZMRKkUP051/E=
X-Received: by 2002:a05:6402:2695:b0:5cf:b99c:3afb with SMTP id
 4fb4d7f45d1cf-5cff4ccff67mr1591425a12.6.1732176618599; Thu, 21 Nov 2024
 00:10:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adf796b9-2443-d29a-f4ac-fb9b8a657f93@huaweicloud.com> <20241119152939.158819-1-jinpu.wang@ionos.com>
In-Reply-To: <20241119152939.158819-1-jinpu.wang@ionos.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 21 Nov 2024 09:10:08 +0100
Message-ID: <CAMGffEkODwo19u0EjKojQ0WaWVkvOOB8aRR8R3NXn+oC6TFQWQ@mail.gmail.com>
Subject: Re: [PATCH md-6.13 4/5] md/raid5: implement pers->bitmap_sector()
To: yukuai1@huaweicloud.com, Haris Iqbal <haris.iqbal@ionos.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, 
	xni@redhat.com, yangerkun@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com, 
	=?UTF-8?Q?Florian=2DEwald_M=C3=BCller?= <florian-ewald.mueller@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:29=E2=80=AFPM Jack Wang <jinpu.wang@ionos.com> wr=
ote:
>
> Hi Kuai,
>
> We will test on our side and report back.
Hi Kuai,

Haris tested the new patchset, and it works fine.
Thanks for the work.
>
> Yes, I meant patch5.
>
> Regards!
> Jinpu Wang @ IONOS
>

