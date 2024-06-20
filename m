Return-Path: <linux-kernel+bounces-223586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200D911523
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F4BB22BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AF07E107;
	Thu, 20 Jun 2024 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nh6stBS6"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97EB2E859
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718920319; cv=none; b=JeIqgpykQUBcK3+19Xo9nwqT4I/tBVcaJxYx7aKJu2Gu13AJ/eINhklaivto5G+/JpxY1VLcWq1bKVQab1UpMK8cGyViA3DLFvKtryDtQCs5KtffxHiw3HxrIeuu6h8zu8u+JdXL0neKkt89cqmaBF3fr0z6uX6sqfqsCTvM7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718920319; c=relaxed/simple;
	bh=eohaQg2wy+qFRl/Bx6buNH8vUBbAThN7OyYl0y+jxeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmF5+BklZ71V9fxsLg0Aljjs3LTVPvu/NDQAc+6Bi2hEwMkUD1LZtjH0tZD88ckeKr7/0jogybHT9Sf1rOT5EJS2+3//WlyEjNqDFkDnT5x4ZEha2B5dCmH5ENX4w6vr8dxXM6A2TptrNPyEw6Q8bMhmjSf0mJwmxC11nn5hbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nh6stBS6; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7955dc86cacso84426585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718920314; x=1719525114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZzH//nXAtElviGoUe90rmWXbPaKRBBQ6SrYSrvwBbs=;
        b=Nh6stBS6W8JzJ6NGKRgY8IEC9FjohNdbuq6cm3kEHEnHnEXLGWmAx6CsHgkCSfwcjY
         KjS7SSpuSQro7IDr5LlZ1PImICWZ+ptIF5n7GqZYIRxJLeofvR6gFMvlU/se/Cdl2fmW
         ZF9ghSZw6D4WMuB8zhIOUG5cS72KZYuD0jDsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718920314; x=1719525114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZzH//nXAtElviGoUe90rmWXbPaKRBBQ6SrYSrvwBbs=;
        b=e8ofRp7yctm0IZSsc83G8rf7qn2+fIlMbZGluZ4jyspF4KefTbLB5rppbmFSmVIxtC
         5rdDa/hbpjDo0Gp9G3Ksikqt+7wZ1wV6YHQ3VaUQDxulAuqVKAwyI5Ohg1X+QO7oTs97
         XyHi3Se/wMh2w8BRUv8+1g6we8E8liTSG7d94xh5Ch1rbOa/+KsHZTNhEy24vsg2SZgd
         IaNnZwhaOMC7cZ8mizH8Z3PW4bchHp9BgaHF18lCv0OKvl4nrZ/jwularstWaDDynMs9
         cYmuIGRn9+oSwuAYXbjVG9fEbufjMimw/paL2DG6Ky6FG//07ASy4UwxGGksOgIibYwt
         zSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHrc/Pw92qUyLuSHycsDsIxNtqjIgtrdowafMJDVtA0PM1BhkFIgbYBedSBcu8nhpaso1M6aT4q4f1jkn1NtCfVlPy/tPqOT6JlP0w
X-Gm-Message-State: AOJu0YzXcmAH+9zn+asCB+ttV24PyYJV2BfHghXVvu3aLRWqB8o7Y+N6
	pZO5IoWcWlyFOHDOjVXSRYtxfNkdz+hfcd0Ik3gYjIQ9aiwotjevaC9dj6z7EA/IiVFhtyQBY+o
	=
X-Google-Smtp-Source: AGHT+IEK87oz9AhOuIIJyt63xYLTNnesVAk4ZNT2BunlGew4b6dCo3hZeW0YEWmF5jKg6DbNFo5wfw==
X-Received: by 2002:a05:620a:2a07:b0:795:48dd:f1a with SMTP id af79cd13be357-79bb3e1ba29mr669066885a.15.1718920314553;
        Thu, 20 Jun 2024 14:51:54 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce92e6b4sm14719985a.100.2024.06.20.14.51.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 14:51:54 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44056f72257so122211cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:51:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqYRq8J6Jx8595DCbo1KV96ZpyfBiEJAmpH12oPze5b++T/bUUA2M8kyi8GCU6Olw1rP+DBAmp7jNfSi9vgsaRo+2knVPilgQRYaRp
X-Received: by 2002:a05:622a:134b:b0:440:1fbb:9b0c with SMTP id
 d75a77b69052e-444c3613a46mr257681cf.29.1718920313033; Thu, 20 Jun 2024
 14:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620-jag-fix_gdb_py_symlinks-v1-1-36a0f0217fbf@samsung.com>
In-Reply-To: <20240620-jag-fix_gdb_py_symlinks-v1-1-36a0f0217fbf@samsung.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Jun 2024 14:51:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U3=d91J+Jw50=xKexhyKYjUQQ_WXQ_UdOTZeou4_=n3A@mail.gmail.com>
Message-ID: <CAD=FV=U3=d91J+Jw50=xKexhyKYjUQQ_WXQ_UdOTZeou4_=n3A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: scripts/gdb: bring the "abspath" back
To: j.granados@samsung.com
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 20, 2024 at 12:48=E2=80=AFPM Joel Granados via B4 Relay
<devnull+j.granados.samsung.com@kernel.org> wrote:
>
> From: Joel Granados <j.granados@samsung.com>
>
> Use the "abspath" call when symlinking the gdb python scripts in
> scripts/gdb/linux. This call is needed to avoid broken links when
> running the scripts_gdb target on a different build directory
> (O=3Dbuilddir).
>
> Fixes: 659bbf7e1b08 ("kbuild: scripts/gdb: Replace missed $(srctree)/$(sr=
c) w/ $(src)")
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  scripts/gdb/linux/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ah, good call. Yeah, this makes sense to me and also seems to produce
reasonable symlinks. Sorry for not coming up with this originally.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

