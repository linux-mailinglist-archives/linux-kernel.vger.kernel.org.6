Return-Path: <linux-kernel+bounces-252666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F8931697
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6661F223BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB79618EA6C;
	Mon, 15 Jul 2024 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kArY6Fbs"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2B1E89C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053368; cv=none; b=ZuFbeaPUiUVbcmTay3sF/DZzzRzTGfcWbpZowA+quxnUa8xFwKwNh/35BHt0FNz0/1VWmuYX5Xq288sYuPSZAGJelVrOGfADquoqXBFTfx6wV8zrnBl/wi3sqohouewF/TBZM+cL4cEfykKC6K4sC9G7PQPnc94E0V6B+sTDTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053368; c=relaxed/simple;
	bh=akLoDmbDPs+NEvbjDftdXeJMTJGD6oHfGcOTzt9l9co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0IXYWpv39BkBjyit2iRB7zlpO7aPm6ZMeiAuvcqCSHACJZdqWULBs0MYOl+s9czkHbK+XO/pYDQtZvreabrcY9zzvBAVtG1+kzJRBoBtxl3woUH8LIBHhdW81FHXMnLZp+0mgoy39oY0M+QurQrQN+bFoSl58QYcVcTC1qzrPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kArY6Fbs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447df43324fso507561cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721053366; x=1721658166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akLoDmbDPs+NEvbjDftdXeJMTJGD6oHfGcOTzt9l9co=;
        b=kArY6FbswdD3bIC/7VmyL5/ynK8w3PmxNwWnv9NuoedUFq9ufOmtzhV/KIfsKdqoVt
         W+8sViUWeTkkcJ2hZNWs5UFKodp6CZoewcBYd2bxRPOsjYSOGclvAV6rP6hHjB37sO9K
         J8VuftPxZcEhCApAbmkRifeUXdxOoK4a/p4M6D3Vtw5dMkUoKZMMVwYF9l3LL6geTG/J
         p8WD0clGNwUGPffh7b4cEz9GCuBn1wQsZkbqnEmCrus1iaOrG4Evx6Yc9eyp9s25W2Yc
         61fESWw7S+VJ/H1zZfObi3muuRF2fOc3BbTL9DB+PYm+WqP58FG8dzx9BT63wFK6aMUQ
         79sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053366; x=1721658166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akLoDmbDPs+NEvbjDftdXeJMTJGD6oHfGcOTzt9l9co=;
        b=vcKtI6LIcMP5pmr1ouqFiE0skYN+FiPtOPplncT1ftoJ9uhqSZutpDV1bYzRL5+UMA
         8UJX7nhuQ+bq87b+g4SjdLAQ4nSGr9OGknSNry0fnfcWz5Oa3up1RJwHOXr/shJKFtpn
         S1HpSnxKkvNg9qHED55jtLlTR75jopKrPqNyntnukgnrhus/QKMGsGzCYLkKP2baQIQj
         CmJ1l+g3CIJsQH+6gp1K4icT5+ON8kXi7XcF4FqJj5ue3EWccse52Ah6Q57TUIrvq5f3
         Z46SC1Jx8lKPjF3nU9DaCi/PQwHY42K+S8qmegcGAW5+IqjjuIGZTwCvUqPYlFx6TIbK
         koQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7BTe1skSXsGjWn0OanPWtEIX9NGFGVls6xIDb4l9l/OuWqkYnvb1BhOYZdzF88HcJRgwCP6BfSz9FPCijyMKb/KYq83BUYspnAFPe
X-Gm-Message-State: AOJu0YzwyM2LMdAw8CvrUMBqh8hRR7frKSPIT/Zxwj3TbT2D4TBTbDyQ
	GmLVEY9IJQnwazXa5eSnufH9KZR6YqbO5NP3TEeAoAe+R0eB1ztIyO0611DsdikqJpGH59Yb/c1
	gBGMXOCIY2ivdlRFu5SvUthbx9rpCPMMDqc4D7oCGwtu6exI1YC8Wz/I=
X-Google-Smtp-Source: AGHT+IHgg91W4475NpHdXcKHyv1HYgpe1WM8KIiuzYplyzBGaDbvdiQnNL6KYb2XilWjHQWvHuedrSmfj2F8s8OAIiE=
X-Received: by 2002:a05:622a:544a:b0:447:dbac:facd with SMTP id
 d75a77b69052e-44f5a31ec96mr5088861cf.24.1721053365546; Mon, 15 Jul 2024
 07:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715073159.25064-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240715073159.25064-2-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240715073159.25064-2-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 15 Jul 2024 07:22:30 -0700
Message-ID: <CAD=FV=VHDksKiZXrauiipa3HjtK4sE5+dbmXmVfhFoM-RKQP6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: HID: i2c-hid: elan: Introduce Elan ekth6a12nay
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, linus.walleij@linaro.org, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 15, 2024 at 12:32=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> The Elan ekth6a12nay touch screen chip same as Elan eKTH6915 controller
> has a reset gpio. The difference is that they have different
> post_power_delay_ms.
>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

FWIW things have changed enough between V1 and V2 that you probably
should have removed Conor's "Acked-by" tag here and waited for him to
re-add it.

I'd also note that when posting a patch your Signed-off-by should
always be at the bottom of any collected tags. For reference [1].

[1] https://lore.kernel.org/tools/20221031165842.vxr4kp6h7qnkc53l@meerkat.l=
ocal/

That being said, the new binding seems OK to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

