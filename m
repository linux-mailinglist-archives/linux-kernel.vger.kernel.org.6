Return-Path: <linux-kernel+bounces-210922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE1B904A39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AE21C20BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73492D03B;
	Wed, 12 Jun 2024 04:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVgDQ4Rl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E32C697
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167739; cv=none; b=qd3vRtwTpUb0gMQui4cTSaExwN9PDl2g98hsn8dGjyWKU9Y9K1e14hr2bjVniqnXjIdhMRUDmVuDF8I5irmf/x7lPUj5VFQ5ThN4eyxXdq4rLL7PT4QeHF6PSRc/hiDPOtwwyCssMlHewBCYHAhhjqsaeDw4tvcwep7n1Iow7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167739; c=relaxed/simple;
	bh=ISMnwrquxySMbyVMhPFFl0H8z4wNRhpo5+rQG4T1ewk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glOROH2EB5Q4j84Vc+P16kd2zXaWYzlEnnp744xS3iMGCevLdzlSdrFGZ0LjBGZfxp9GmuJnIartDceLG+18Mc1ftxVRALQeUwHbbE6gZNPF+Ra3xi5Q7MYstDaChuMTNoKCLg9dB3WHrEvjlaVsCq/pkUBbrzB+yX4KTybOmRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVgDQ4Rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B445EC32786
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718167738;
	bh=ISMnwrquxySMbyVMhPFFl0H8z4wNRhpo5+rQG4T1ewk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EVgDQ4RlMftf8ik37TUsZpw8QisXq2Ev7dBsmH1T4lRVMW8znQ9rpY2fxXMesfTlN
	 Nc32k5ZSNNjQRLxt1FwcwwmBchcs1zxhbqxC9ODiELFVNmN85pCyQbW6NMS4HGvpKA
	 /QLQBSur545I6IIuPCusaqVDu27YmSdhxLT9mow4yM8KfhIDfP099mpXhRLSOxKteW
	 ATFLZLD85IVG1tns3O5SVnRv2q+hPZoO/woBdcD8wX5Csu0njJXt6xFRgGDgL2ikCK
	 42dWrqu7VEMYanGigP+6o8maOMYyNs+a22exjLtSV3HcPFHJ5Nxnwps9wuhfMLNpfy
	 vZnk+6MhVi1HA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so4181610a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:48:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwcWwOuFdKPWY4H9wohRc1niBEHkqqk0Bn3rbl932cESTF2vMLAgHZPLjP4c2dRYPQhDHRiTTiK5R9VB/VfmphpVmZHf206wMBbTot
X-Gm-Message-State: AOJu0Yy5E4UNxDW1LZq6d0vTc2oqJTffohTwVazHFL9w7Lh75Xhz6sxE
	PTmYKs/q5rYikxd732vF9HE1l15+9vvANJ/vkjMiTTirp2v6eNrElLbCTr5rgfmZCN6DoPBf2v0
	ClMmKMbZkub1i1RokqxJbauAbBlg=
X-Google-Smtp-Source: AGHT+IGokLit6B1TfTMlhCGJ96z/aAp3CSacNHaYepCeJlsU4xVV19Ebk+8XGSuGkjzJJtWpNoBNtqm3a1iX80YTJSE=
X-Received: by 2002:a50:8ad3:0:b0:57c:7541:c6a9 with SMTP id
 4fb4d7f45d1cf-57ca976a8c9mr389118a12.24.1718167737292; Tue, 11 Jun 2024
 21:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529064053.2741996-1-chenhuacai@loongson.cn>
In-Reply-To: <20240529064053.2741996-1-chenhuacai@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 12 Jun 2024 12:48:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4N6NGKJBy19zs6ciGFYHWTUTKA6X=bA_ENXTP2fr7XHA@mail.gmail.com>
Message-ID: <CAAhV-H4N6NGKJBy19zs6ciGFYHWTUTKA6X=bA_ENXTP2fr7XHA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs/ntfs3: Fix bugs and typos
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Konstantin,

Could you please take some time to review this series? Thank you.

Huacai

On Wed, May 29, 2024 at 2:41=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> When we enable NTFS3 on Loongson platforms we found some bugs and
> typos. So fix them.
>
> Huacai Chen(2):
>  fs/ntfs3: Update log->page_{mask,bits} if log->page_size changed.
>  fs/ntfs3: Rename the label end_reply to end_replay.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> 2.27.0
>

