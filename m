Return-Path: <linux-kernel+bounces-563025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2936BA635D6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 14:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E25188EB27
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D813A1A5BB6;
	Sun, 16 Mar 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcxzCidN"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5325771
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133036; cv=none; b=Am/+5GTauAkagQpie1G6ogC+x2vfsecy9Ihhrx0wAVMMv5KwzK5YD63LEQ8ggb+chU9bWB6bjhK398lZHCRdp1YXhcFt/imRuCkFITiwQhJTol3Gg6pnuYQWO7IA3Ydx4CBSgFCCe5PvfODFtNBq7kR1hMU5PGy6xoBvMkHvCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133036; c=relaxed/simple;
	bh=xnm/g0kDJXZa0YWRhEqZO5acaSkBZTj0wjOMf/+E7i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=B1h8drPKUER8aYrE92wJEUhoF7lTEbI7NymCpdjodiKobXv/JaNnjfDCE43JcrlPJlQQB+4zKtBr8V1nqlxvLVsaRxmsOXnb5gRSlwP2fSuDUMtlg7EiLUYIoT+R4rgqnTQVlCopaSmcKsKWrS/OmqIIb9QVmymwVOLGdo6fs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcxzCidN; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f6ca9a3425so37369157b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742133033; x=1742737833; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLX3l2pfBMyB+u0niGdIBmArIeV1vUvKJ+QVc4dPLqk=;
        b=jcxzCidNDI0Dh9E3htabvt81IcikfoBAIlZyZi19LbBgfxvE9Szrz07QNRw2AAXiCh
         S7H+i7J5iH6eI8JaHBLnHQ9iFtzMeIsZ1odR4AxfXX3LIItixiymWa4H3h/llgcqVN7j
         bJ06Kx5rKFNRqwoAKvtISabeY5BtSbM8CyL7HSIykQsrhIITFTE5YnukeVpFW2oaMxQe
         ibaj2NO5o7aoeWCSO3M+Ph5WKS3hNKFZ8Xc6Iz2GknrDNbotX010/BOrmjwsFr/6T81o
         OwfGav7oy7TkD4t93/jD/jqFdL7UGoLYRdyU/QWh3XS2b9aPWSGBskuQoRcoP0p4WZ2u
         uXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742133033; x=1742737833;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLX3l2pfBMyB+u0niGdIBmArIeV1vUvKJ+QVc4dPLqk=;
        b=WqaR0Ak40ynqbxFzhPV9710uh14siEpKa9IGGQFbRmYDC2EYkXFdzX6NqvRn81rWtu
         DsRImdGMhYi4+jqGaWysVRU9lPM2CGTxloLsBkwhyl+wF27h1NCEYWBeZaUN5+K+ZHmZ
         5K+KmWZp/iy9rLbhVkGTJ2zvukJ4hNBWdmFurthQEXchi9GbgfXTHFPGK408NGzGi59/
         P8P4JLAkRFQ8l38yd9T4Ik//XMdZ68wLalXVFMrEgQihKQIK8dsGmX+IUwwGXM8CB/3j
         /u8Pb0ZLyNfoHmi/ro3mwTNnPRYicWXoKOTR4XCnrB7Tn9mWZbDAJnHYfW3WnRkY59XZ
         C5IA==
X-Forwarded-Encrypted: i=1; AJvYcCV5zNwIIekL2xtd+kRJmEO31396kYmivdj0EN+xWu4Lzqt4WNBlikiHtWPBIo3Svmsm8c4L/Lwl/EH/C7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUnW0vk8ad7AzozHexK1aNcArGZVlmbb6TFczmj+T/8brW8Xf
	j+mw1kH3QBgOXOrVTzWglLAg9qHN80BUt6vLJ/d2sDzD7rwvLCBbA1Rh5aa+tB2BsZZ7XuUNRcU
	ZZZGa7hLyP/Hu7hW7FL4uCLQaANU=
X-Gm-Gg: ASbGnctO5Mai2K+ZfYBN3DiiSpgPdCzMlmn5Q5FjDTf/tk/sX1E7FL3TKzXKkpJYrA2
	0x3WyrjgOq6iehsCscQJmQxOrwpzwdtdUwA3NHrwztOZs6ltj31SKw6EM1l26PFv1br6dtjx26E
	YDnU/JAJPmZWW+w0+f2CyNzljm
X-Google-Smtp-Source: AGHT+IFevfJ3v8Hv9LgKFZg+7cLf2qLswo+1gbITmoMoW03EnfIEs3SDlro7IWMIN2Oshbrp414T5CBo4CIGtbatwig=
X-Received: by 2002:a05:690c:4b12:b0:6f9:b12b:8953 with SMTP id
 00721157ae682-6ff45fa5378mr119774397b3.20.1742133033646; Sun, 16 Mar 2025
 06:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125064619.8305-1-jim.cromie@gmail.com> <20250125064619.8305-2-jim.cromie@gmail.com>
 <3f5d7e90-0feb-48ef-8279-1644ce5f3d5b@bootlin.com>
In-Reply-To: <3f5d7e90-0feb-48ef-8279-1644ce5f3d5b@bootlin.com>
From: jim.cromie@gmail.com
Date: Sun, 16 Mar 2025 07:50:06 -0600
X-Gm-Features: AQ5f1Jq36108HgQS4XUlPlVF14KcwsKwPglARvXoSnSsnAYbHuikctesWZqFJ2k
Message-ID: <CAJfuBxwu6TVM-uLU0Tpp4MN-wx8M2D0CJeRT0U3rNtVMMQyi=w@mail.gmail.com>
Subject: Re: [PATCH 01/63] docs/dyndbg: update examples \012 to \n
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, jbaron@akamai.com, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, 
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:30=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 25/01/2025 =C3=A0 07:45, Jim Cromie a =C3=A9crit :
> > commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")
> >
> > changed the control-file to display format strings with "\n" rather
> > than "\012".  Update the docs to match the new reality.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> Hi Jim,
>
> I think this patch is incomplete, I just tested and the \012 in [1]
> needs to be replaced too.
>

fixed here, thanks.

