Return-Path: <linux-kernel+bounces-303583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3382960F33
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAFB282E14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD471CC170;
	Tue, 27 Aug 2024 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+ZftaPJ"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502781C5783
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770538; cv=none; b=dYSZOuLK5G4VMYZqcm6fI2sJVSB10KzucrcI3tWpeq+NxsAdN5db+9pE7AeyyBxpG36ph7myjg3w69AzWxItkHCF/ibdLo5j0L2vNhig492SIoHePH5d1que+tTPLhACL3DVLrgxNtInHLexnmOLXdZw0mtuH9ZyDtvgWpZVd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770538; c=relaxed/simple;
	bh=uc9QBu/RgpptTCan+mn+ezxYGNJHONA/8aOr7nu41oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adopiFEOTEdOrkJ2fu8bJz7/sD9gH9QrSrCSbislHqFd/lm4ev18Eun621hKsNO5Gi1DOBN+Q4WalBNoWAFLBQrbtFmy5pQiJiJ8QezutthDK1S0el5XiDB0nov6ZJVA6xuJoEyGQ70trHGpwmyx8JkQYBxhSoM1VjCLqARiQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+ZftaPJ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf7ba05f75so47206486d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724770536; x=1725375336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc9QBu/RgpptTCan+mn+ezxYGNJHONA/8aOr7nu41oE=;
        b=M+ZftaPJhkRxiQ7oJu3BTD2RQJ899ONi5J5kXi67wNaEKPmJu8cuHAdYQE7/MCzljx
         le9UCaXsJ79/hMTz0/LJMq5FV4fR1hfU3FRmQFns3gAX2Q2vQHtOdux019+Lx/czjo6v
         om3w+dpX0HfaySjgX88dFZIJPmIWm5ry07i7evRvL2T+sRN+f93j4DLNWhORuWilkMZ1
         wu5GBVC8vqA1LO1jwOTeDSLgK8Bswa90pV1vKgh40WnM3k5BTdM7mKpNGvLXqNM+XpeS
         HGAaonA+FBiw9m9ouit+q48CIIng9IX1HqqiMCnKzMMNOmXCKjbJr5q6nWiQclr03m5A
         /TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770536; x=1725375336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uc9QBu/RgpptTCan+mn+ezxYGNJHONA/8aOr7nu41oE=;
        b=KUtNwVayPM4grQ5TA4YtpvKk7l1erDhR1g+fyUCRXrparxayaKxTu/MgJOMeJyaCen
         M0LlYGD2BIPVij97c6OGGvdSWoq2iFWuBqPWkOfK/xwqZKtQm3epWfCLFqzBuGLwey5b
         eFPodw7BMukDl7Wu60XHtSVlZxJ1sQqM/qxrH7hdmK4fICXAgy8gF3YaG4mVc4UlAYaF
         NqfeuGNq4q11xdWmyW8zJxL0wo/wboCdnKxG9aZ56SPfSMHyVeWUQZDVYfLa6nPVlEPW
         /Yydmmne6MqSTDhqkGtZfiA0Y6f/0I9J8OmdMYhTbCd3OPbJ2GHVDHysp8fHi7wgLpdl
         Voqw==
X-Gm-Message-State: AOJu0YxE8gTBGMn95uF8ts9IO0rmL5AMUno/pE68zrCqTvtmfhBaa6u0
	wDwZFyxBoiwJ63mFVXs3jb0Lfq40D0B7x2d3PdQEoBhhCqkRrNt9NjW8d3fRtyHnTbPdj74h0t8
	1Wi5lEc7c40VNCWFHOQCHaYcp/woKlQ==
X-Google-Smtp-Source: AGHT+IEhTFBEoiQbXcVwZVgrKHQB0MClfuVl4vjNSwpN7UbWREqIOx9oA0rwouWDb5hB5J0ZKkQip+KnCDOecqJu0Ac=
X-Received: by 2002:a05:6214:224d:b0:6b5:1584:62bf with SMTP id
 6a1803df08f44-6c32ae9c191mr60838606d6.6.1724770536125; Tue, 27 Aug 2024
 07:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 27 Aug 2024 07:55:25 -0700
Message-ID: <CAKEwX=Nw3bbm7_J3feiUbk-3n3jj9_FbKHLiBJtQc6ZTfqq2Rg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 7:16=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi All,
>
> base-commit: 8c0b4f7b65fd1ca7af01267f491e815a40d77444
> --
> 2.27.0
>

BTW, where does this commit come from? I assume this is post-mTHP
swapout - does it have mTHP swapin? Chris Li's patch series to improve
swap slot allocation?

Can't seem to find it when I fetch mm-unstable for some reason hmmmmm.

