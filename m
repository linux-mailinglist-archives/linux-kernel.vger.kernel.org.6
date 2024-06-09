Return-Path: <linux-kernel+bounces-207513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF49901843
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 23:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A8A1F212F4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 21:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462E4DA0C;
	Sun,  9 Jun 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkfMUDop"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A918C22
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717967964; cv=none; b=hr8wftEirTOoChaELTyJhwIkckXzIP2qMZVsrT+0xXkCSXOcrOFR3tg4SHAR/YE0Hx9bLu/GAZrJKrkhNfC7twpnBj+wAIuGpKvr+jAbJteaFdeTcAcRGRnPNG5wyk436+WGARKYYEFZ9jOF3ClDGOQkwprjq7L4oFzKwuZDUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717967964; c=relaxed/simple;
	bh=HX2XAmEvsaxz+2HYHmqHKz1Fr8D6ko3MZPqGdH9cGJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgyYlRJ6PVL57LiZ/TT+uy6FxO3XqeTtZc5E1lz+fox2yqIcyfEvNHBFTD5DP5naxREIIGGFtszwp9xQTITxVVvFvd5qH424y59dSiNloP4huxYckf4deaTyFp2N770TId7fnte8/5H9ZwpsDQmIoJptdjFBmnFRRCoObBGOkDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkfMUDop; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6aed0c26108so3815816d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 14:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717967962; x=1718572762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFOvTdjQjjhoh4wsKRpCaTJdsFlZLtgchfZ+i+kPTAg=;
        b=kkfMUDopA664Qtggy8Ut1cu05BwwNez8BDnrcykd2qwwFrH8n8bBC7nHUb0z1Wx6Js
         cYhC+EEKlTpO1Iy9jfBempBG0H+Us1usU7NNeQhridK1z8XDXNZIqJEsqiPqRe8nVNiu
         lcQUJvpB8FMIp5Qp+FT0mXMXCskhzM2XUQUUH7U7MqgnEyW9Y0/CjlPpm0C/30vn9WwV
         uIAJXrN786Bw/Q6EXsvW3OLu7yzy7hB6FJGndb67FiVM/kbokZylMP7WoKxgLa93boku
         6aIJFlgKw8pRKKoYvBPEdyL3nVaQn8b+XLHs/5cdj1zYd92Hc8EGWGHoRm8vXfQWy4Zu
         SnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717967962; x=1718572762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFOvTdjQjjhoh4wsKRpCaTJdsFlZLtgchfZ+i+kPTAg=;
        b=vUIvq5zTtfU6V7ZDKB0gBVW0CXoJjZkOUe5nmTjCOlYTMYBP6oERvnUmwA5j5hdHXP
         hcpj8WRE5mjTrWXcu14Nhol7MUoFrRDUmhV19PLIDrVZ4aEm1GAs2bBAdlahrSUAlvYA
         CicQR9sWXPSXrJK4LZlliuP7dQxkPys7LcEA58wRMNUzq5vRcr9xPzgjR78j6233B+6D
         rqgzq7YgzYmVxxy6p6NZnQXRC+zet5MeIbvx0C/+YOf2DAU42puhEMY8sEOTFUitYets
         1VxbSDezeYcHkIerlvvKYwu1Z/nLF/49/wAagQqgAGdNw+00f8tBVurOoSMW3QtEslxi
         snUw==
X-Forwarded-Encrypted: i=1; AJvYcCU7m54aXT5Lf/78kImVeRU75dBDoBvAdiv+uipxb55DiX2BIy71BYFb0LwfP0nKGhGrQltV/djJ+ZZDhx2htANcEnU44LWOXHu9r4x6
X-Gm-Message-State: AOJu0YzFtrengSfEIA1/ZObbyebuN+0a32EutXUTLmLvfoXeqt3VCHrE
	P1RWmWRNjeIZ10EcAcQWJEoBFQwFaoN4eghnRSZ+6FkS6aZPh43n6SSRg1IgUiVAuk8mSboxR9o
	VMHV5AeSz55UcZviFvcMEvgOo+CUA/3l18Oi3nFl0Nj0=
X-Google-Smtp-Source: AGHT+IHVRz+3tbYJAWHmxuulkifl8hVs+5TI6OkCO7MdTRYn7FXiijjkzZmf4d5Z+6MXekrvUQQFP9LP3HkDuvHn8H4=
X-Received: by 2002:a05:6214:27c9:b0:6b0:7369:e747 with SMTP id
 6a1803df08f44-6b07369e7e8mr33592676d6.2.1717967961699; Sun, 09 Jun 2024
 14:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
 <CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com>
In-Reply-To: <CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 10 Jun 2024 02:19:10 +0500
Message-ID: <CABXGCsNN9LwHc2x2AAEH=5UNwpvkWkBqRYz3OP8MZ6Woy+HDXA@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, Rodrigo.Siqueira@amd.com, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 6:39=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
> @@ -944,7 +944,7 @@ void optc1_set_drr(
>                                 OTG_V_TOTAL_MAX_SEL, 1,
>                                 OTG_FORCE_LOCK_ON_EVENT, 0,
>                                 OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
> -                               OTG_SET_V_TOTAL_MIN_MASK, 0);
> +                               OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* T=
RIGA */
>
>                 // Setup manual flow control for EOF via TRIG_A
>                 optc->funcs->setup_manual_trigger(optc);

Thanks, Alex.
I applied this patch on top of 771ed66105de and unfortunately the
issue is not fixed.
I saw a green flashing bar on top of the screen again.

--=20
Best Regards,
Mike Gavrilov.

