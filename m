Return-Path: <linux-kernel+bounces-198258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F38D75B1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B449B1F21552
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EAE3D0D1;
	Sun,  2 Jun 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAZJ1R3W"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768B3C0D;
	Sun,  2 Jun 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717334639; cv=none; b=KyKbJUe5jvD7rvfyId/MeK7wkmQOMhztMMMjUBcCddPMQlSP0FNm91v7pqSX89NrWTnTT4PN7l/hrrCWdZcBNc33SP1xTJBp8H/CGxRPS1NVmls5IWHCZYrgiTQR+VusSAH3pLmT0blgubpN9REpY+7a59PVUsDFyti1c+ekkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717334639; c=relaxed/simple;
	bh=ph9RRZ9fJodzXeGXNZy1+uDuFKkDxa+ngjNPyvjGTPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cc+M8bom8wZHcEdwTFPqApELG0Xs1HKEAlYXNibRQV19wPrHuybGWlg+6vB04UcPwCe0VAw0RqW/CatX7GqOE4QP9j+YS8n4Dhg1oEAIj6F/mMRCmyU3ZgqkUoM8nCn7xDRQ+b9lWZDEE1ZxnVsY7UBBTWuP5kFMT58rBdsOp44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAZJ1R3W; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4e93a260becso1405685e0c.1;
        Sun, 02 Jun 2024 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717334636; x=1717939436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLqzVjLrq6hxp+JDJpVf8tQoG9jZMYyGVDIn8oS4rLg=;
        b=eAZJ1R3WrOGewNqSWAbtVCnTWkWn/hvqYvYbHKQnaSHJP/KrUWJ2UfPErMJyg68T/l
         hekM05M5JAGwa2V7ictHoXsmoCJq9WdUntnGU2peX9nE5x9R/e62W5tk6uXGuY032CVg
         g8wbOBSfq5uYPMJAO7u1UbbHoZw/o+5hk+9zoEjpzxBwxDOBHOTWdYz6lHwfL/hAOjTK
         AEQjMzq1wfeYUftL1t+RrmA2+35ZBwt/JOlRko++0K9sad5cbI8QRBH/IiP0vQG8qcNC
         2yc/Df4ltGBI0LtTYjWyRWtPIx4efMZJxaTkkLkcNMuOVHOZudklslSU4hL+4UT/MB/4
         sF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717334636; x=1717939436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLqzVjLrq6hxp+JDJpVf8tQoG9jZMYyGVDIn8oS4rLg=;
        b=YQHdRcQ17fm1h/5NiUugH/+13357BQFy1oFTkxrL/ytnnayaaB8lYRgHnaVisbbSlh
         ZU2jjR6Dzhwq1YOGt43M0xCswrLf4eWd6cWdv41IvV1aUDR0dj7vzG48xnOJVHVkDWbi
         ttlqqjD3sTnBhz2WEUxPzb6mxStnwZ6wfWYZOZhiUfSoozzB2gMFbOyAh1v8/wP4xWRE
         fRG4IuAk/84T6mkGgb5EBp+vnc6NxsulKnkBPHB3kfQBTh91iS7zpZwxWUWhXGbwCIzh
         OrGgB20Fd120qCLSOu6KewFLm2wM6vA0Tqzvwiv/aQYrUvJio5kDu9lWwEFFPPjMZTH4
         ouiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxuSoaTxCAiq+inwxG9T3v12XS/8fsI5JKow6gBGt1KR7X4VRv6wu6sXJEWKhItg5E31O+dnhK9JosofBJJl/YMX8QxLqpRk6hn4BeEWNxlW8ktuS2TEzCtKFxh/xNSD0s+YRqO8VQ
X-Gm-Message-State: AOJu0YzCNcxzwlQfywEI5dBDe43hkaCUdWqTFtBNvV5PWZJzvztPmTEk
	9cfEEyFz7de2bDczhj9HjxgzGIk4m2oSJ8WgZ51m+wxFCW55ERXTYbQRBXZWxxKp/8R7ZEuNxBo
	FOGv+qxHilWc+BaV47xN2bEjgwMA=
X-Google-Smtp-Source: AGHT+IEl8GwNRu2NdrOvC9nHu/oHZJ70LfiidpzJbSMtzQQIKSvSiI7agY/ZviZHjTBl7KAjij2DpBPXMnMlNEjF13g=
X-Received: by 2002:a05:6122:380c:b0:4df:281d:905 with SMTP id
 71dfb90a1353d-4eb02f37194mr6556291e0c.16.1717334636547; Sun, 02 Jun 2024
 06:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602071058.6405-1-harry.yu185@gmail.com> <86o78jlms2.wl-maz@kernel.org>
In-Reply-To: <86o78jlms2.wl-maz@kernel.org>
From: yu harry <harry.yu185@gmail.com>
Date: Sun, 2 Jun 2024 21:23:43 +0800
Message-ID: <CAAmx-DzLh7TYub-PDSX+A7h6KuPYAr9WeBFmhknPjxAr2dPBnA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: Add Allwinner sunxi001 erratum workaround
To: Marc Zyngier <maz@kernel.org>
Cc: corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, 
	tglx@linutronix.de, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 5:25=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 02 Jun 2024 08:10:58 +0100,
> "harry.yu185" <harry.yu185@gmail.com> wrote:
> >
> > Allwinner A523 GIC600 integration does not support the
> > sharability feature. So assigned Erratum ID #sunxi001 for this
> > issue.
> >
> > That the 0x0201643b ID is not Allwinner specific and thus
> > there is an extra of_machine_is_compatible() check.
> >
> > Note, because more than one soc may have this problem, the 'sunxi'
> > name is used instead of a fixed soc name like A523.
> >
> > Signed-off-by: harry.yu185 <harry.yu185@gmail.com>
>
> No, this is all already handled by the driver already (since 6.6).
>
> Please fix your DT to include the "dma-noncoherent" property in the
> GIC and ITS nodes, which should paper over the integration bug.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thank you for your reply,
the method you said may not be suitable, because this SOC
also needs RDIST_FLAGS_FORCE_NON_SHAREABLE,
just like RK3588, but it is different from the RK3588 version.

