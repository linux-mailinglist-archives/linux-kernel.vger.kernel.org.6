Return-Path: <linux-kernel+bounces-309893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08732967195
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DB21C21765
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707BB18132A;
	Sat, 31 Aug 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA//wwn+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16E17C7B3
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725107842; cv=none; b=qT/1Hahsf8Gl6ZmTTTcYloLAdrCv80X+NSWLRpOpGebLjxCJKiuCtAjsktBPX2g+W1AxpQVbh9AVeovt1AMugZ6gXCE61DTBLSNtm7u0EJ62mRuifCWpfb35/PjB7b4H8y+5gULi9o3bqYo8DIF07vFBRai3WbZxEjw0PNhYKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725107842; c=relaxed/simple;
	bh=Noby7El9z0c63e41wu6AhQcfLUuk4A1lf0hrYdgifns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJL7gfZZwxSPCfCOi/gUajvz1FdFwjDjCkKVc67x/FAaBumjRO1KzoT57unI2ACkgCxC5taP5sg72pu3pSm2q3j7rg9Nx+4pMOMRr8KB1nF/ug6oYsU3CUBpQ5WwqpF+By6gdNjj8Yj0Kwpiy0Cc2JyEEW7I5WHJUIG9iNJyZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA//wwn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620FEC4CEC4
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725107842;
	bh=Noby7El9z0c63e41wu6AhQcfLUuk4A1lf0hrYdgifns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fA//wwn+sB7SCym7eddwh3+Fv1gfwYSRnlrrR2y5soCmAKWVYIdYjNhCmTQlMPJPn
	 TkhucRSJDINL3UFw4wZq3bdJYB/Ae4Sgv37SivAJ/oYI90IhMTDATck/I4/P3I5NVN
	 mFv61uUKD2Vxe8/2PwxM6cDrrKhwnfsV1VQSM1WvRp+U/WGhn+MkWlQ5pC3KViQbJu
	 v9OWTruS+OmHWm45/GYq8QjHU8u7xvndTzepaQxjrfR1iEZGBaVcWKDxwPsR3wAV+y
	 OJppyv5xBU4sEquspqngzJW6XwQRIFkb9hUx2p9sv7/r1Tz9fZH1kM6j23vESffzfz
	 eHKwqrBfXSY8g==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so2771489a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 05:37:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlXoC7BWm2c2YdiSMk7D3NDcdwkitlrPMTTPSGEXzC8p3AhysJEW/u3cbVYXk1X1E7gK0DOnAldQkV3Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylXxOIMVFg4dFTr0PUAw4ualCtvTfs72+sYQXJIMmQAAonROEX
	7PlfUkG3uzzk0YhFw2a+DRoF5r9+BkvSJGKsh17fSo0ROaLRngS+6KzZtSEnyEcsRlQE1tpmJFz
	WPDds5TUWE62CuyA7YAo6nxZC5yk=
X-Google-Smtp-Source: AGHT+IFzorRshPsuDJ8XEzT9wq3sbRSknfWJS/lfjEMrPElt1JbMx7hESBdAu8CIv3grlpOZ228FUCX0BNuT7BOAG1I=
X-Received: by 2002:a05:6402:40c1:b0:5c2:17b7:5a7e with SMTP id
 4fb4d7f45d1cf-5c21ed9fcbcmr6622190a12.36.1725107841040; Sat, 31 Aug 2024
 05:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831052157.13532-1-guanwentao@uniontech.com>
 <CAAhV-H7GptUdpKScV1AuZZm7w-F5oUXHRmaT9BFCZV4HuQExJg@mail.gmail.com>
 <tencent_3F6931DF7E765EB870FD970A@qq.com> <tencent_3A814C6056AE06E21CE86A92@qq.com>
In-Reply-To: <tencent_3A814C6056AE06E21CE86A92@qq.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 31 Aug 2024 20:37:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4wNc+747nZPzT714KzGRSnbye==WXdxckVG1nTxEfLjQ@mail.gmail.com>
Message-ID: <CAAhV-H4wNc+747nZPzT714KzGRSnbye==WXdxckVG1nTxEfLjQ@mail.gmail.com>
Subject: Re: [PATCH] Loongarch64: pci: fix memleak in pci_acpi_scan_root
To: Wentao Guan <guanwentao@uniontech.com>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch <loongarch@lists.linux.dev>, 
	linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?546L5pix5Yqb?= <wangyuli@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 4:36=E2=80=AFPM Wentao Guan <guanwentao@uniontech.c=
om> wrote:
>
> Hello Huacai:
>
> I found a mistake that my PATCH commit msg need change to "Loongarch: pci=
: fix memleak in pci_acpi_scan_root"
> Need to send patch v2?
No need.

Huacai

