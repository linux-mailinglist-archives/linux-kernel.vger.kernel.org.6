Return-Path: <linux-kernel+bounces-265418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1693C93F0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC4B1F22051
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6EF13DBBB;
	Mon, 29 Jul 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="C4r9PlUd"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378213CF82
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244736; cv=none; b=V8yvw5P6wl1EE+Uo5/zv+z9noaFTESHa9EwQQFIDUlsRznF3fwARvY/Erx2pxCLDRjDRCB0fjDGZMti9pvlIKyMCkKwVAzVkKGudUTsVTFfVIJ3vibHw5jqK3vWze7tI4fWFO14iJ+Tao900jBUZsk7JPrMegcd5nk3QISP4qqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244736; c=relaxed/simple;
	bh=zP4Oo8VlfPL1y5ooMCv+q6dYa7B/A/lNVPXp7kK15YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evc5ouVE/7QlpHjMk8Knbf5f2c69TAPZqUFiSkZQXeRVpBOPNq78CyJFHpxpIPzT7W+6QkEhgqFkT3Wv3krPUDOR4vFbzMRwpd9wGJOEqsnjABD2V4JZ0DUKxF3a3ujOhg8DES8+dq4L3c1h0WDGCPLQgSndfN3yNfExJUCIV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=C4r9PlUd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a728f74c23dso454480566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722244733; x=1722849533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP4Oo8VlfPL1y5ooMCv+q6dYa7B/A/lNVPXp7kK15YA=;
        b=C4r9PlUdhu4HMa0IKtW2rDSbWHDBx46lhHY/8KfX0wAC57bCOYPgP8GLjW83lw/WdP
         J+v6Jv2HI1dW25OeYaksCtJifWAEe/HilzQFARYLQVE648lhtJ7xaaGnujNG5f8By6uS
         ul4uOwJoqWbRskUwY8DW1JElMfaHXT4TxHDaBL0qDbPpw00u4A/iVLv6uTLPvkzzWZLS
         t8kDuFAkVo+tR0iG9nZlrn9PJ6oZuZx8G+PJRSQoTaj+StGe2mLD4GA55aVf3cKJ9+Hh
         mEHgrveuUzKId92nnAM8Y4sYPKTXA7Ol6pT2taxhY10vdlIX1kxGZEECkY1C8MWEIJ6l
         XKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722244733; x=1722849533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP4Oo8VlfPL1y5ooMCv+q6dYa7B/A/lNVPXp7kK15YA=;
        b=Lr9KO1U91gh4+d8qrbSWSkDpGD4Kd0zmFiJw8mw9pPdDKDV5ufiSYghA8rkWlntjMw
         FAK9XepebpVPzWYACjtMoam1AH3qbeLr94ntu2rzUJovgK49DOYFBTag57zKFE4XhqKx
         9C+tziTCr4uajn5uXr2LUWPywt3655fbylLXgUhsBoKH9+M20WZzx4P8C3T0H26QbDn1
         7GN+/wS8213622rphmUpYIx9/pN3/y0aTTwbnOUtstDN1rgMC/ZuociL+43r6d9u+8ZA
         6+v1rs8RXG1Aft6kVGkH3D8xSZTZZzribXUC1xMk0E3DKBLOeiC08kzOv1fQ5NBXaF97
         2pCA==
X-Forwarded-Encrypted: i=1; AJvYcCWGDNeFmKTpNm1xBIWiKgSknckLfC7kCtMrIL+NIU3iBWpUwxm4+Kf40l9utX02cke221DjTEsogV/lBUmGj/Jz3W92JbJosPoIC99f
X-Gm-Message-State: AOJu0Yyy54WVdtq7ypMEaT4ZpleDv7I0Pf3A7ZwxZaO2fauTqtxSX+YU
	kfXPftHNdNdXgXOOiVwx3iiDSqzBiutuj9V6iGhtJBj7iJPIE1+evyriMFwfLOyozS+2xvggb22
	vdLDBXwAVt4ghCwyCZXtyzy1T3ICIVgNa/SbtCQ==
X-Google-Smtp-Source: AGHT+IEMMA8egk2Qrs/8YwOO8v1/PGB/RaFQ9lcTBCtxwZZFTvrycQmzBYT2gE5tB6GWwAAQvzXd5f7JMOHEksDWTYk=
X-Received: by 2002:a17:907:3e1a:b0:a77:b5c2:399 with SMTP id
 a640c23a62f3a-a7d400af792mr514406966b.31.1722244733283; Mon, 29 Jul 2024
 02:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=zCy9Y87R1qw@mail.gmail.com>
In-Reply-To: <CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWknw8Hdt1=zCy9Y87R1qw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 29 Jul 2024 11:18:42 +0200
Message-ID: <CAKPOu+8s3f8WdhyEPqfXMBrbE+j4OqzGXCUv=rTTmWzbWvr-Tg@mail.gmail.com>
Subject: Re: RCU stalls and GPFs in ceph/netfs
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 12:49=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
> in the last few days, I have been chasing a 6.10 regression. After
> updating one of our servers from 6.9.10 to 6.10.1, I found various
> problems that may or may not be caused by the same code change
> (abbreviated):

Today, I gave this another try and it turned out to be a simple
leftover folio_end_private_2() call. It was really caused by commit
ae678317b95e ("netfs: Remove deprecated use of PG_private_2 as a
second writeback flag"), after all.

I posted two candidate patches which both fix this bug;

Minimal fix: https://lore.kernel.org/lkml/20240729090639.852732-1-max.kelle=
rmann@ionos.com/
Fix which removes a bunch of obsolete code:
https://lore.kernel.org/lkml/20240729091532.855688-1-max.kellermann@ionos.c=
om/

You decide which one you prefer.

Max

