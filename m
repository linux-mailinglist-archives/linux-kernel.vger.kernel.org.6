Return-Path: <linux-kernel+bounces-350403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E302A9904AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5971D1F228BE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9006212EE3;
	Fri,  4 Oct 2024 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4eQntAa"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C161D5ACD
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049326; cv=none; b=IGJFM7pkXRxPpDW/gdEB8/XfdlkDhXw5SpGNAfd/dtW8qvRWXfytXJzrkZpARnlqkitTPWjnwuSjM4VH1utUiU3ww8WvCHIpEvquTqqqtQmJIsQXdbWIjHKJZJBgh2ELg6XOh99kW0B5yazd+Q1wHFXEUCPEt8nK6enrxO1ey4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049326; c=relaxed/simple;
	bh=9GiGpatiD/2J2i2OxbJ2wKJ5F9YwjrgCv1XSXGIZuTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5Zhm7WHc3UQo+Q/V2HK1PQ9MPHmPA6Xx0u10Uw4OxzmqDSprWZTGLeUr5+pijEl7VH807hJs3cBuq8fYcjOBZR9JLviX4zNkp3DG2zcAg2Mt+oo8zmU1o8jsEZ9aWNMJ/zUTi8Yk++i37RW6v6B6TXMu165ZSEPxBZZInOKGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4eQntAa; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb2ad51162so17250746d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728049324; x=1728654124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lk06JKbodbBSWD6/FEKtSxepIWAjJ5ljqYQ6uKk3a5U=;
        b=V4eQntAaa8vpf2IYx/Pz5uALaCtAW9LB9iztGwNFe5JBdvuIQdU4QTec83gK04x9BO
         Ugnocyt4HihOZdX5TPJ04jzYk4/duek/vjCGVSk0WfzAgoCv6WVpjxz2Y+qdeWAwq/O5
         scwyxR4sKYemUq+96318Ho2WqQV0b3L6NxYJ00QV7MhCzSOFNqiBGVSg13+9qPVRXgp5
         m3jyGR1XUOHpaiUXdANZBGrTSfyBhV7oDCGdFQUtEjJwf4dNrwRz9fKy+ovELLcBgapo
         7capSUS9fLmJ20FPdSkzizQiYlRPncnOGPHm2t+nrLuP3JYDJ2sXrWr3O/SbHI/+49+j
         QqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049324; x=1728654124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lk06JKbodbBSWD6/FEKtSxepIWAjJ5ljqYQ6uKk3a5U=;
        b=Zve0FIYJjuRkgDWqlGb8d+vaooka/AjArsbq5+7qZrTPwByfR73xlsK2RcdTfomRM7
         6RvgQ2w70WqLMUnle1jldnnrzkWveRI5d3d0YZn0kK1oh1HJhp1HmWBW3IOhVyTXQTQT
         y04ZD769hC8pZ91XFAFJ0HUnFn+AibTN2jAuc6dHl2ESpUcyXnAellHuYppjyhgPLOJ4
         Zq7eK/R78t77Ilhg0WWY/RG3zt43V+ZOQtZKZOMcrTmHTxO2p8jYSnmZVs/QK4LLYtcN
         teMU92zMXOiXyy2l9oD3y4Fi99fErHVoUgIZny7hHhQM/F3EG5GYT9H3aL6Zt1rH4NcG
         Yj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyTlK66ZuZLvTQhODyS9xJsKvp4qhxXKQWMBrCcSXu6d0dW9sKbLNZyslmcRuucLKgNQ19z7h28nVooOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYjwL+wgLSLkfH1hCqOYMJGmlSTp1JLgvLe2TuesbpEc7y44E7
	oXs6la4rSevBWnojhGvES+HmfrZrdUI0eMOiYu7fNMnRvFahENN4U4Ptr3ddnn34daUDg8kDWsa
	tGxj7dog0AjK4c9OVj2nVxHojMoNdMabPZrnA
X-Google-Smtp-Source: AGHT+IHmiV3n3dyhLctI0mmJ4D7qtRle/kabcXXlFIKXT5PRpvnCxqseb5Dyge4IECtKP92T51WpbiYm7DbViiawKD8=
X-Received: by 2002:a05:6214:2d4a:b0:6cb:540a:c66d with SMTP id
 6a1803df08f44-6cb9a307ec5mr36037616d6.24.1728049323651; Fri, 04 Oct 2024
 06:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004123313.2463701-1-bemenboshra2001@gmail.com> <2024100452-echo-chokehold-f6fa@gregkh>
In-Reply-To: <2024100452-echo-chokehold-f6fa@gregkh>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 4 Oct 2024 15:41:22 +0200
Message-ID: <CAG_fn=Vmn1UotDhpHr48_ENd+d12y0G-qR5Q4m5aTODN+tH8uw@mail.gmail.com>
Subject: Re: [PATCH] usb: usbtmc: initialize memory written to device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bemenboshra2001@gmail.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, nogikh@google.com, 
	dvyukov@google.com, elver@google.com, pimyn@google.com, 
	syzbot+8f282cce71948071c335@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:57=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Oct 04, 2024 at 12:33:13PM +0000, Pimyn@web.codeaurora.org wrote:

Just curious, what's up with this @web.codeaurora.org address? It
wasn't in the original patch, where did it come from? :)

> > Avoid kernel-usb-infoleak by initializing all memory written to device.
> > The buffer length uses 32bit alignment which might cause some buffer
> > data to be read without any initialization.
> >
> > Reported-by: syzbot+8f282cce71948071c335@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/0000000000006f6622061eb52dba@google=
.com/T/
> > Signed-off-by: Pimyn Girgis <bemenboshra2001@gmail.com> (Google)
> > ---
> >  drivers/usb/class/usbtmc.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> The "From:" line of this commit is obviously not correct and does not
> match this signed-off-by line.

Sorry, does it mean the "(Google)" part should be present in the From:
line as well?

> Also, as you are from google, just use your google.com email address
> please.

Unfortunately Pimyn cannot send emails outside the @google.com domain.

