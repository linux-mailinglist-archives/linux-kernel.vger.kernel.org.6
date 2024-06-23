Return-Path: <linux-kernel+bounces-226237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A211A913BF1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D9AB21D17
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E21E181CFB;
	Sun, 23 Jun 2024 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jb8cFQcK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5F20E6
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155168; cv=none; b=NMkvwPEPJE3V6jGorbuYJESR1SfIDH1WFa1QQKg/Bb5bK9gEuQ0SGSg2Fym1/sBL+VXzbcjo5MteOY/ormozBx8+qKVWzqw0UU+VMtycYfhfD+YovY+BCVuqJ4++byAVkc0X/KFXtLHPmLaKPesvSc8Fm8UrmJA/qUyVQuU2GLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155168; c=relaxed/simple;
	bh=AcukNjBMQ8sYI0piHVK0jaJow1Tro2bkO7uODOypLOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDtRMs26FBAPuYEczekJa9x8eBD3RFsdB+MvearJnCTiFTVfkb8RhLiR9tVCMVnRrkUCagfUSncMA5dSp5wpnMT+ypvz4PgJ/033mmz7jILtxzkx0ZT/brb0MBbQ3mgeYfzt9WczNd7lT0nz39zf3MIgU2sbHdUI1ueUI4+Ik9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jb8cFQcK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a724b3a32d2so43685566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719155163; x=1719759963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NFE0BNL2HJ1hECpEi2pNqya/PSGrZUX20RQ/1dd8MiY=;
        b=Jb8cFQcK/Sm6J51O5hDIloo1F04orYwZnPIlcGcJvqx2QQ3kITwHvyMt04D5l1Wttq
         tE2A6STiNN3OnGexj2jT6ONOa3iqi4iLBSqtNeV57YsGT620t7auFgfSsph8o6XR6I2l
         iOdTz3CsrLb0q0IHEKRChEElkWbTEd6E1cOJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719155163; x=1719759963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFE0BNL2HJ1hECpEi2pNqya/PSGrZUX20RQ/1dd8MiY=;
        b=qw800iOwiTvcJFYhDRPJEE/M6oAKmgw5sDdx12jM87e3UyoVHgW8A1G6pDoEnxoUPO
         1UO4n7XvvJFOQnkzvoS7rnmFI+KFYsxsMFbjzedVUiOt+5pl8HQY7JEgOoK5lcy58aFm
         11Uaa/0uRJlNdw3DoboZRu9/3fj8XZwQ0d2QZzrcDrswHSNu4FVkbMOlzPDVVONScSL9
         cjBqfRS6Itb64sDo6HVRS1KvZhjoZQVeHTOSQ8jrIWnQPY0VijLbsEHenRSSus3PZb5w
         y/eJa/OWoDCT6smJzymYaPXbDJe8wpxRnEzyS0+FVqtiD7VLdiOgbi/wM7Oh7wBjyoIk
         D3wQ==
X-Gm-Message-State: AOJu0YyjPKNNr3zFryItR4HvOsIgsWYXIlM6gELzVkORalnphC5tWPFN
	HdliV1qeK0g09YCcdKUA7S3eGPq+rC0/0V5w9GX9qqcyxZkQMtnkN6OuH86i2sRyG6+Mx8YZ1++
	TweRQTg==
X-Google-Smtp-Source: AGHT+IGc4D/nnEVpDm7cLrMAlLCmnHPOdll2PN2aOwwp+wmFW364Czt688h1/NiOzoZfHOsOU27tFg==
X-Received: by 2002:a17:907:c819:b0:a6f:7861:b947 with SMTP id a640c23a62f3a-a7245c40fd5mr146509166b.61.1719155162906;
        Sun, 23 Jun 2024 08:06:02 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf5602c5sm317360166b.144.2024.06.23.08.06.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 08:06:01 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so3791426a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:06:01 -0700 (PDT)
X-Received: by 2002:a50:bac8:0:b0:57a:2a46:701 with SMTP id
 4fb4d7f45d1cf-57d4bd80e1dmr1524437a12.19.1719155161338; Sun, 23 Jun 2024
 08:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5muEks4khtNFc_rE=ywU15-6FfACkohXfxNGNvkdZ=0ovQ@mail.gmail.com>
In-Reply-To: <CAH2r5muEks4khtNFc_rE=ywU15-6FfACkohXfxNGNvkdZ=0ovQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 11:05:44 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjdSe1GkAA2tKEXyjtTZkXALjHjiJ=AptLf1Qmu17OktA@mail.gmail.com>
Message-ID: <CAHk-=wjdSe1GkAA2tKEXyjtTZkXALjHjiJ=AptLf1Qmu17OktA@mail.gmail.com>
Subject: Re: [GIT PULL] smb3 client fixes
To: Steve French <smfrench@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Jun 2024 at 02:45, Steve French <smfrench@gmail.com> wrote:
>
>   git://git.samba.org/smfrench/cifs-2.6.git 6.10-rc4-smb3-client-fixes

No such thing.

Your gmail may be "smfrench", but on samba.org you go by "sfrench".

Git request-pull _should_ have warned you about how you pointed to
something that didn't exist..

I fixed it up and made it work.

                 Linus

