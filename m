Return-Path: <linux-kernel+bounces-265800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EA593F61F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F181F22FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287914EC47;
	Mon, 29 Jul 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hOXkNMSv"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5751465B4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258314; cv=none; b=JWAcuaacy24T9QO0VBNeB4UGTiNNTbTHCHp0Ff/6c6bBoFyH4KzFsK4Davlk20/p+8YnzLUm901Y5J/EzwV6wiaiAtrftVtE6X7iegkcH+IhuNk2H+rM1ThwWNbpyP4MVA+f2Z7z+pJ5yiXK6KsyLP1/jGlXzGCriZqqfbr5eDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258314; c=relaxed/simple;
	bh=Nwdk1Zb376HFbM1m2aApZjKPiZ11wbxbpIpoPekhWTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLQE/G46dMfL16cS2s7kkZUsk6bEerQ2r8SAnVIjFIdCQ/SOSoWmlL9tJMWpGnv85KPOBwf0FKIgrCPzv7/3YByMcnmwwKMByKPIvwVC2ELBq3WT6BsiKCwwsAs1UO/YNvrsgpsYj9MLJSK+q4L/w+5pT2vYWDx8FqbeIvZu+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hOXkNMSv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a8caef11fso379808766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722258311; x=1722863111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwdk1Zb376HFbM1m2aApZjKPiZ11wbxbpIpoPekhWTs=;
        b=hOXkNMSvLOzz3irBecp3MxDUVaNByZNfDwzrGas0ykxItE7BSuBSS8gm9HQrYV/7+Z
         rKeld+8m9mlDyxsovQm8uqfD/UIC/Xq6Ti+4ipfCQFgDg2QPDewb2HnkccGa0NnZpD2+
         Ps8LhgmDNJEZCit5ygCCarR5bH8Gmxa7wIyOFxQ/ULcVGuxDVvB2wypBX50cXE5P+94L
         Lw7k6X04AFrr384CTs8cYCDe9IMUxI8pLWFYbIR3vM1dKEOGjoUQG3NH4dTQ9msGfXKp
         kWGqqd5hS3ywAa35v63/yd0uwBktaibM3eCqme8WPyJ7DV/4qSzqzUeZfIAY1zBoCl2l
         t3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722258311; x=1722863111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwdk1Zb376HFbM1m2aApZjKPiZ11wbxbpIpoPekhWTs=;
        b=lfRK9Tq2EhHh6RoSiHtjaczN2ET7z3le+gPi8Z/xUxsmOzPUjhCHwveBbuEjiURGCr
         iUh456byCzTnTPKjqhyBKr7Mg4La2rICqDHUJABfs7qUTvIVSdMve/0Ki6idrZfFDX7S
         z1g0Vb1hUIvPGuwgMBANZ+T5EqCuBolvyvVoW0cGpMjfZdOFEpfIr1aAG4vsv4nMreIZ
         AD5ya0PiBWFXBGtXxkSt6u3kNPBq6IrEuge2XvDx0UsBFmMHrSVOcH0+9oYinxfutdsq
         iXWXx5Ako8RitrbH8GFTqaIiqVgG87qippMpb/431d57HxGmIezg8/zNcDnxDR5xvBIq
         kKkg==
X-Forwarded-Encrypted: i=1; AJvYcCVoLtlHTF8weidej0200+/NZQDYAOwGn1mqtkplRFvXtwNP7beBHcI3vLdfUxMr3wtcqnLABH7CfXyfIwxq6iVILaPrcQ5uy2RIPt8l
X-Gm-Message-State: AOJu0YwVHcfYF4KQ1aueQnmFZHr8S1hxgJN701UnJwqbwEv6gr8zU1dd
	M/ZK/ttCVCPQ/V2aBSHPKb8iQaUSOwBqhHiM2COurpBl++X/MvUfb8OhJNk4va9KimN00ptWOR7
	iwC9+XKuMtMxU5X8QER7sFXdI9FFpGoAgBVASnQ==
X-Google-Smtp-Source: AGHT+IF3q5HRQsp30wvL513VaLZ8ou7ZSERFd1RF1FMGbO2FLdRRU63BXpRqD92PQM6mpbVkAMHS0DgJYlggtS8sCLo=
X-Received: by 2002:a17:906:d54f:b0:a77:de2a:aef7 with SMTP id
 a640c23a62f3a-a7d40150ad2mr553058766b.44.1722258310918; Mon, 29 Jul 2024
 06:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com> <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
In-Reply-To: <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 29 Jul 2024 15:04:59 +0200
Message-ID: <CAKPOu+_3hfsEMPYTk30x2x2BoJSb054oV-gy1xtxqGycvyXLMQ@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, willy@infradead.org, linux-cachefs@redhat.com, 
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, xiubli@redhat.com, 
	Ilya Dryomov <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> Nice work! I'd prefer this patch over the first one. It looks like the
> Fixes: commit went into v6.10. Did it go into earlier kernels too?

No, it's 6.10 only.

