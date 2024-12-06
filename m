Return-Path: <linux-kernel+bounces-435158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF76E9E72AC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C368169B70
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D7B20B218;
	Fri,  6 Dec 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="b605QM/F"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3312207E13
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497872; cv=none; b=oo7z7/qP6dlcBjcBIVseEdTr9yfGYhfEks/ypGy+0ulSxxnCK7r0Iz0Xo19F50Hgo/H1ra4a6VDma/TSR5/vBh5OGLIDYe4WzocCH3TLe0LAzTReCgEY5tafZe3DwUsVyZljFIZ9zN4wfCp6asaKu143lYiDcg1JlcoqtoRuYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497872; c=relaxed/simple;
	bh=wCQuI8phZ1+TrN40J2JVMieza73zr1k2Fifr0E4NL/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=s0ZlX/2rofokKs4RZ1T45hB97woDs1ZTQsm0Wq/2tP32hnNtB0PrXUZjrrxRetqzk2r0vm+J/aDGdB0lzHUogw5EGLsHhN2uzcSEMwZkZwEa590SYr6Uy5wncJY00Sw3r7FFaAohc3+x1+XVpKNn91IcqbEvlnRVJHUeo3AXbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=b605QM/F; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffbf4580cbso24031201fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733497869; x=1734102669; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCQuI8phZ1+TrN40J2JVMieza73zr1k2Fifr0E4NL/A=;
        b=b605QM/Flasv91RWv1zl6VI/nAG1/ypSIILlPn+6CXmPMXl80NfeCUgKEaBn23QxGV
         +oWj00BOZiN0FC35GMdD8/fqBWYwHo1/QyUzQ4gZOsnBY932aXBlNf+AqpCmMIffayQu
         QGzNsS60kIltDud7Y7Cvk0kkExzDjQRFneOExWy9kvIbPqoWXhwQIAF4KAUKpmfFCClA
         QTlKSmC+53qhAkE/yFDSTSRPqKVSXHtTn6pSPsuvewHLhG6BsMNNHjuBmkPH0nk1epnt
         AOjAH58M17I4w5wbbz15fnALaVSMWgJa/QRJCkpGC2Fx/XCTJq4Md1b035T5kcIdV0z+
         E/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733497869; x=1734102669;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCQuI8phZ1+TrN40J2JVMieza73zr1k2Fifr0E4NL/A=;
        b=lICWt8eiEar36mgP5zGm7e5gCZGf/uI5bmwzUL+yjclBAuc3Q25weLTywQfMJ90EKe
         X7mfhwlDRdtzpfpCa3apsz7imbixird9ClDcxx9efEhkQQk6XenPGe18wdpM3BY7fodR
         Ap/WurJONe1h+MSlRcfP9mOv9F/ayfXkp0/sOmNDrZVuv/uqkNwqAlhGdtpnRyzO1rfc
         /Su8mRDXZM9dR0lHbLUEgv97uZTHiqwTSoSWgggoXn5Qp2T4aHHtIXuUaGRwDQOQpADe
         yiDB25VCzHgc8BA9tgKH6b25WF2Axs+HV8CRvlTSeHx4DdBnpgVu+iUcyMw4y84l9NqJ
         IlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6PBVTFydXQHy+R6/OQithpAcYj8rro2gQLNOkK/pRJ2NKMY3DsJeK6ZVVeCNSF9ov+ifPE1W4IzKDo0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/virds8QrVLjk/ecvzXdph3V71PsMCsMpnPWOjpiyGUW9ffN
	a3NHvHZomOaFwfqpJVNxVXdRQC+IEKLiOES7aG8Cc+69tWDrMfLj80axefCbMhI/cE5vPCgsdub
	3nBIlpgMJwnhi7iDqBwAAiDrV3Qin5UkzrsMtmBczTGOEY1wrPDA=
X-Gm-Gg: ASbGncuiKFE+5Jw5tdwlbCnBdRKveDQZzKFJvK9YPYRKkYeROnzPoYQQ3TUWmr5MY3R
	GQ5ciwngw/MYx+tpJ+DuX2g4jvc5HjdWMxyloIw1A0xje6RjVvI6XI7hUB1YI
X-Google-Smtp-Source: AGHT+IHZh7+eSZRrew9jvjXLeL7+e+dVGeI+ATK6u5Qf2A9dzVb3ztmytV9rXvATxrVvHBhLv+Y0gapnch4CBZ6EiOc=
X-Received: by 2002:a2e:bc23:0:b0:2fb:45cf:5eef with SMTP id
 38308e7fff4ca-3002f933d39mr19247661fa.30.1733497867875; Fri, 06 Dec 2024
 07:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com>
 <CAKPOu+_XVhgg7Gq=izU9QDFyaVpZTSyNWOWLi5N8S6wSYdbf3A@mail.gmail.com> <CAKPOu+8iNpKkduNqOg4kfbnOBren58xx5hQ78DAs5FjD+FysHA@mail.gmail.com>
In-Reply-To: <CAKPOu+8iNpKkduNqOg4kfbnOBren58xx5hQ78DAs5FjD+FysHA@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 6 Dec 2024 16:10:57 +0100
Message-ID: <CAKPOu+9v=4qSuESQ5bc94qM=U6OEv3FXZ2gdr3z0MyD5YTRtEA@mail.gmail.com>
Subject: Re: Oops in netfs_rreq_unlock_folios_pgpriv2
To: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:39=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> It has been two weeks since my crash bug report. Our servers are still
> crashing all the time, and instead of going back to 6.6, I have
> enabled `panic_on_oops` so the servers reboot automatically, hoping
> that you would come up with a fix for the netfs regression soon, but I
> cannot hold this up for much longer. Please help!

Nearly 6 weeks now. Currently on 6.11.10, and still many kernel
crashes every day with NFS.

