Return-Path: <linux-kernel+bounces-226802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCBC914417
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A67B1F22AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6BC47F5F;
	Mon, 24 Jun 2024 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="P2XuNBF5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C112556F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216029; cv=none; b=QtXA1YiCYKPsFi1WqWj0o/V+f6uxt8bdr1LD9WIzIOYQu478QoQHAwxZkLLi/0u/lPppYTiZJM6jI5g1UgR8f8avo3oMzi+gLqaXGVV7n0Y4N+jmLA8ZQm5r/mLbJ/6q5zIajZw2oH5T8INAd5um9lygSZTqqOGiru9P6eL2B0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216029; c=relaxed/simple;
	bh=H4cV+TL+ga3JG7w5DMWiKl6UEKwDzYRgGTVeNdl7UFk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K/AyYDYMBJwhcnHf+5g6QXSX4Al63woi3RioZa8POJu8y6feRYxUsNKmX5B1T7Y3IomL5bib/4XMPd372gUShCf8iadJi0Vj79241N5vidvHVoCOUpL8N0+NkyDK0rjE2DByFtFjPc+6Ybpaz4JvbOcWTYIljG/tGDR17SV0lmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=P2XuNBF5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f47f07aceaso31153235ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719216027; x=1719820827; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aj79LYCAxF+p3+o6X9hA9GUorzi9x84bMVNK8ifZhGA=;
        b=P2XuNBF5E2LPwub/2wIK4cVec6G2zN15m8pGtrKKsoHDi+PIqS/h0hNyfiCopT+FM0
         M54Ircnsnu/A5nLkp2W56kwB5zTGC/OS7V6REel1GC2eGWVnPWvxFXcPpraLUdBFlYVP
         15UYm8sKRCjdGu7YQ/OOA+Uvv8K/cjs/Wwl0+gGymRqZF+epo2R07LUd2JOYRtVE//vf
         nivCcsc2JLysrsvlyJXY3EGTNV2VdycNFaQZDl9ekiUz8PtyAjFbNI7DV+/eaLxtEMad
         bRb9MIK3PyFVVdLPPqMuGNIJrDQHjBnoHBBMopoor/NhODQ654X+yr24OGuK2FNggBew
         Ai0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216027; x=1719820827;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj79LYCAxF+p3+o6X9hA9GUorzi9x84bMVNK8ifZhGA=;
        b=BLM3b0c/JrzOmX4QPBUl9AIFkT0LP2dY39j73tEt/vqrr/M4HPtn8bF2O36iXzsUJZ
         myDXiBPXidT1Y/8pVVqoKDR9Zr90Epi0hbbCcuyaaGpb4VNe6lcYbsY+FQ1S+qlemhmv
         cUzXXTNmLfVkQByWk4dos49LWUOyfcM/zKC8eKejJl/tfhDUkT7MFQ5QRdhNMVGKKcFK
         ufg5TAnkZtaY1Nz3tO8BHjNU3W/TdhCZmuH6yaACeAwvnCBtj5mzcfNJekNttCi86mv4
         54sVBuX+FFdVG6yJWaYaeUzJjhxTYz6WDcVbIl7hFRrpZo/ktxsgmzatKYlaRfXSoBvz
         PUeA==
X-Forwarded-Encrypted: i=1; AJvYcCWsvKzTrQ9jt0HgSYpASUmedPNRDvXEk78Miql44jqKmbsVlHXdcaMNAGtIjDcd9qrTOXPWE4Q8RiUm0s6I3DU9uFFVWcTaWDDPc4ae
X-Gm-Message-State: AOJu0YwXTLPJwlpSSSgrh5W6lr3dqblSNusXXvNUGwdiYRquwWzkHpkA
	eBH8r6j8R50w08w8p8/H+3VGnlkqLoI5rhlpleXglnqe9H9qW0p3q0TCbk5Lj4g=
X-Google-Smtp-Source: AGHT+IFJ21CMsNzUTPURNgPxp9FYmyQG6EZosDqEMFoDyfvO2m935KC9udY01IUKgMqxBooKWzrcpg==
X-Received: by 2002:a17:90a:3fc6:b0:2c7:da20:524b with SMTP id 98e67ed59e1d1-2c8504c7dbamr3257115a91.10.1719216027213;
        Mon, 24 Jun 2024 01:00:27 -0700 (PDT)
Received: from smtpclient.apple ([2604:3d08:8e80:cf0:98fc:e883:d2e0:acbf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e55dcdf4sm8077639a91.34.2024.06.24.01.00.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2024 01:00:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] kcsan: Use min() to fix Coccinelle warning
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <CANpmjNMHPt7UvcZBDf-rbxP=Jm4+Ews+oYeT4b2D_nxWoN9a+g@mail.gmail.com>
Date: Mon, 24 Jun 2024 01:00:15 -0700
Cc: dvyukov@google.com,
 kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A820FF35-B5A3-410A-BAF3-0446938CD951@toblux.com>
References: <20240623220606.134718-2-thorsten.blum@toblux.com>
 <CANpmjNMHPt7UvcZBDf-rbxP=Jm4+Ews+oYeT4b2D_nxWoN9a+g@mail.gmail.com>
To: Marco Elver <elver@google.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 24. Jun 2024, at 00:02, Marco Elver <elver@google.com> wrote:
> On Mon, 24 Jun 2024 at 00:08, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
>>=20
>> Fixes the following Coccinelle/coccicheck warning reported by
>> minmax.cocci:
>>=20
>>        WARNING opportunity for min()
>>=20
>> Use size_t instead of int for the result of min().
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>=20
> Reviewed-by: Marco Elver <elver@google.com>
>=20
> Thanks for polishing (but see below). Please compile-test with
> CONFIG_KCSAN=3Dy if you haven't.

Yes, I compile-tested it with CONFIG_KCSAN=3Dy, but forgot to mention =
it.

> While we're here polishing things this could be:
>=20
> const size_t read_len =3D min(count, sizeof(kbuf) - 1);
>=20
> ( +const, remove redundant () )

Should I submit a v2 or are you adding this already?

Thanks,
Thorsten=

