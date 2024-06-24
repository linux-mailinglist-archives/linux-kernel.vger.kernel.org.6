Return-Path: <linux-kernel+bounces-227582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA108915382
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742EC1F2476A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3F19DF6F;
	Mon, 24 Jun 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RISyTkSf"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113B19F479
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246148; cv=none; b=l3JlCF7/97DM0XFZ7sc0/9rA/2Qfjey96GxPd52GmjhHND0wI4HD0WuuGOHbxrmYJ5LmnPsHmvLfRzJ1tTY/vVvhKFx+HQLEWyuIEQcut6MJ1L+U0s7emzCKjGZbfxgQKJHn5usrKZeeTsxTDNZfG7cSj43zsglR5hpH23PYBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246148; c=relaxed/simple;
	bh=1G4NyShq+e1j3oZW4Aedr46z9Uol0XpIJcD6idplbVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKo86yiFp8mWqxuf41dRQ6orKRYoK4eacDisNL8n+1RpH9F2twXx+i4bCXV7hsp+t5IaA4/pbiqBIXp/sDJV9oXe8z1gXa2RphZZ6QOMBzCwBepUQSGLKA48xgCpxXUZbNNW+zb2pzhy8uWav/MkWtYdZhVmqOEBS+TrnkfR3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RISyTkSf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-424997177bbso15075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719246144; x=1719850944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4u6SiEhFuSy6jcmUYrf41+JClfPB+b5LepiIbjPkSA0=;
        b=RISyTkSfsQyvAJQVRNopMxGhou5bkRf9xXPGqztMKSYXkiVTXaanhDVh+iS180faUy
         zbmQNYvJOJXRASBogWI6ICqjvXE/Bqu9c6j5OlDJXuQd+jaHgJghXXXbPWc+q65TqS6S
         LYS54EiDEcX4o36TGi8n7+0FKoR4PSl/P0RUmG+BljS4fdf1AZBu0bNbWUjcJrjsIjtw
         Nl955VEHnkzuTu+0tEgyYR0WLWN5ZOsetJlM8kzFv7gadV6V/D6wzAAxUhmrPmnwISNf
         BEiWIC16h8vz9qTDzhPARcy58IUaefqNhLY0d/1Pe0Rx7wXaLPxQT2mZSzP5OemvLQwp
         UsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719246144; x=1719850944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4u6SiEhFuSy6jcmUYrf41+JClfPB+b5LepiIbjPkSA0=;
        b=tinQu28t/hKOo7cU/xeyD4qZUm81svFL9Jarg6HGd/2Nal8Dtmm8FOIsNA7WP0flJC
         6M4u34446nRBZCUtccMfE5aeQsrIN1/vletX/EajJEho89WqOzRjFDr6v7KgJb7gxSej
         WMEb8MEJgNDb3C6wp3bsaq57DuteOVOpJP8zJuAySJK/ufYmI7FUfjR3gal+JeZUjjIR
         F2580jMYwZ8dHWtGa2UdWqx1lQxauDDqh+TnzylEom7tDYHUNspWYO1Z2LPyDS9TK587
         pjA4+7XZTttsdb1Bcie5MJQbh7WCWKVDzhmMIoEvCfZIcokm4pQl1yR+YDzboChFJgwD
         C7zA==
X-Forwarded-Encrypted: i=1; AJvYcCXDPPVe+ZMKzytGe5BUJaQ/JttmezeHIslzG4u4JCC8EBclYoPtneSFbxz4CQNvvtxAaUMOquqIuNv+eXFTTgIa830l5VPaqrsg2phs
X-Gm-Message-State: AOJu0YyOb3GKHNp5UKMN/uHBH3NBKOpjLR/y7FPQJtdGxYiOLIGNnsK+
	QAK3xz+TWrqLvdvUBZxDY363tHG7jUDmISnjbZTWE+eC+OCskDzWxw4JKOGFZTFpeBXYAAb2T8I
	P3NjKJebfKN9Y+wdK82+pKm4oIW3n4ixlAGCQ
X-Google-Smtp-Source: AGHT+IHogQz4eUKMZsSsvl1Vf44Jf33vWLaEI/UK8wH094SAzpa/D/EwJD+G+KtjuutUQ7ZhDA/Mhudd0ZIzzaCL3Ks=
X-Received: by 2002:a05:600c:384f:b0:424:9638:8453 with SMTP id
 5b1f17b1804b1-42496388483mr1337045e9.0.1719246142805; Mon, 24 Jun 2024
 09:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com> <20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 24 Jun 2024 09:22:05 -0700
Message-ID: <CAD=FV=UXXRH3PR31Rmyx-OFomQe2Q9ZF4FwmrSdyNMma8XQP2g@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] drm/panel: jd9365da: Modify the method of sending commands
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, hsinyi@google.com, jagan@edgeble.ai, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 7:20=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> Currently, the init_code of the jd9365da driver is placed
> in the enable() function and sent, but this seems to take
> a long time. It takes 17ms to send each instruction (an init
> code consists of about 200 instructions), so it takes
> about 3.5s to send the init_code. So we moved the sending
> of the inti_code to the prepare() function, and each
> instruction seemed to take only 25=CE=BCs.
>
> We checked the DSI host and found that the difference in
> command sending time is caused by the different modes of
> the DSI host in prepare() and enable() functions.
> Our DSI Host only supports sending cmd in LP mode, The
> prepare() function can directly send init_code (LP->cmd)
> in LP mode, but the enable() function is in HS mode and
> needs to switch to LP mode before sending init code
> (HS->LP->cmd->HS). Therefore, it takes longer to send
> the command.
>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> Changes between V5 and V4:
> - 1. No changes.
>
> V4:https://lore.kernel.org/all/20240620080509.18504-2-lvzhaoxiong@huaqin.=
corp-partner.google.com/
>
> Changes between V4 and V3:
> - 1. Only move mipi_dsi_dcs_write_buffer from enable() function to prepar=
e() function,
> -    and no longer use mipi_dsi_dcs_write_seq_multi.
>
> V3:https://lore.kernel.org/all/20240614145510.22965-2-lvzhaoxiong@huaqin.=
corp-partner.google.com/
>
> ---
>  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 24 +++++++++----------
>  1 file changed, 11 insertions(+), 13 deletions(-)

As mentioned in v4, it would be good if someone with more MIPI history
confirmed that this looks like a reasonable thing to do. However, the
code looks fine so I'll give:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

