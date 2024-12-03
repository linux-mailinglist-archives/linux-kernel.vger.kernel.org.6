Return-Path: <linux-kernel+bounces-429544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D759E1E22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85DBCB2A1F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387871EC019;
	Tue,  3 Dec 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AdYh+9Ni"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4571E531
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232642; cv=none; b=lmTRvxdYzsR1CMKgSoRWRkUb0VzEBaXCeX6oEblNY53V4svwSEqs8enRkNePZZMbhMkm79rJwaj20NU+66ZMLFDF2s9TaB+2ciEknEEyunmBnb8R+kzHVkJpQ4suQ3x/ufvD+GkoCQ461a4y57OOdprJihR9PFeIxZvM48GKCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232642; c=relaxed/simple;
	bh=SoD83N5vsPrQJ5mpXPuIPGHfj4z6qq1j0ga6s1cMERQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkqiHmSF9B9YsZpYY1MXkVl0++ww8wiU2J7BIu1aoJrap/6elGKBWkXc/h2QncXGZtD6LFXuHDvoWu0uK2+g2zBqDqJl1sSGTVAVztPZU2HYFzIxvdJ/OFAuil6VJHPRFPJ+xbK5ecP++PSziSPZvcSvYRtio8Up56zSX6mraIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AdYh+9Ni; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53df67d6659so8647723e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733232638; x=1733837438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoD83N5vsPrQJ5mpXPuIPGHfj4z6qq1j0ga6s1cMERQ=;
        b=AdYh+9NiDI8cfmm130jb20dVzfG3AsS0mcGPy/AEZRypwmBID9FtPe/AXdhZzl+UyT
         0Vx1KxUvnc4RfmzdkgwoRxXKJng/+DLs8bEM1cf6fFrWgl/UZZVtrg4nyvYrEgdsJCKZ
         zeMnkTau0vGvF0ziMBBfAvGKQfeZ4msipzqAWwfjHsPd+wOpuFen+pEcH4U0upDeWgDZ
         Wr+5jyKbjjQSHRu+7HbMF0uYuA1D5MhBMLen60pfju6pzRDHvt2LbWEvQsEamAy0QGii
         IQQ9by8bFx8Jlpl3+pjxbjHYVCY2Rir7CNAbUaFzjfoKqO8g6EuENl3fQ5jIGBfqs7Hh
         u6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733232638; x=1733837438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoD83N5vsPrQJ5mpXPuIPGHfj4z6qq1j0ga6s1cMERQ=;
        b=j2Xj0RaIB0x0sk5ZXkDCy6SLu3vAsim3Yaj2tu+6DfSQ1s0smYoctfpFaIzOzE7OB+
         NmtbeWyhWqvIj+GsDvjY5gH0aFLrAbt9MCGJTKitPu3sSsYzwiB8JokbE/CPAmmudd26
         VO1g1Uw78dGJwaKHS+V/vYpskLhB2blVW7Iw/5zhwNipxqF4f22Iv4dPqd+tZbW+FPTW
         G4P/Qf3fWINSEO5dvAqZQC3PBMGUw/59cZeo+9SB+X6KHAh3lP3Wqn8n/GXEQJ74TOvv
         rrG1b+CyFtJ1o0xiCuL3eDo1ZFTctaUWiP/nj/9xyKI7BjK7kRQnmLNYNVj0pndrkdve
         pvKA==
X-Forwarded-Encrypted: i=1; AJvYcCVYt3xmGnB9F/OaG3rvfGxmvKu4K5SVLzKzQMremMsGxrGaLKVcXVm2Lhq9VMIE5EQVVMrQbCChMYuj6VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl6i4HJIaoM+CQ2z62g/WZjFBD6aVWwqf+CVyF1E7Ey6cs0lc4
	OIRpskHTH1311XeMxynfXPDcPntTn+ri6ssjp7eHJeedEJtNfsw6KXvX4d4At8Y8Or3p9AJmbfW
	YrVrWxqfTHJbYJ2n5JqicpZobdOdvMg6ZzUhbtWF5ZQhbhGXYbvA=
X-Gm-Gg: ASbGncvh0In6PmEaOJnorSCH9rONOaf3VYhtDrZya+u3UWleFiCgIB8T3CXaoMU3r4w
	8ZtJk/12mOPeVUkZxcoohy8zto2FDe8TBw6iCkErbD5KQSA8Qzb07OY7X/UJG
X-Google-Smtp-Source: AGHT+IHzwV0F7K3HmoKIVDx1sWgIm6ncPAPpcRzITTdImU1h90E9EN7eYmf68pN5DyC5EBDpfb0WlM0hv99UTrwJveE=
X-Received: by 2002:a05:6512:108c:b0:53d:e83e:a23d with SMTP id
 2adb3069b0e04-53e12a06988mr2179465e87.27.1733232637809; Tue, 03 Dec 2024
 05:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
 <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com> <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
 <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
In-Reply-To: <0584d334-4e75-4d35-be33-03d6ff7a0aba@linux.alibaba.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 3 Dec 2024 14:30:27 +0100
Message-ID: <CAKPOu+_4z4NDG1CmqsBatJVF1rQXHvqHV6fUiHEcnBswa_u8BQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 9:15=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
> But I guess you could record more frame addresses to get the caller
> of readahead_expand()? e.g. __builtin_return_address(1)?

This turned out to be a big disaster. __builtin_return_address(1)
instantly crashes the kernel, causing the whole (production) cluster
to go down.

