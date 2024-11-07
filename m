Return-Path: <linux-kernel+bounces-400050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918599C0846
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFBAB2147B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FDE21265B;
	Thu,  7 Nov 2024 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wr7GaOMa"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5DD212621
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987981; cv=none; b=IcuTao1jB4sNUVjPuUrpKA0xW2fmt+1kZo0IwxeXwNRXjRWokUIjVUnF+LKImoQpei3PSEzABnKQsRIz/TSP76s+RV8MYTn8S8xcIcbEpOdKHA1r09xgiX6K0yBoFlloQCb9/6iSMLD33jrfPDJn0EJo6kIVf+WgnWDcCqA39aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987981; c=relaxed/simple;
	bh=OQLnOEmBaDmsBPtFGs6fvs1NVt7tHuk9MBrY4dFLnhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBcQGXQpn3CKsb4bazw6AyKJTPGdb+aJ+lqq4Zmm63BQitlK1dBTwIVukG6p+/+B2pNfIxH1LQfp5jcb9dFwtSxKH1V3yV8+pI5WzXM3IyFU0Xufbq/mie4mzzueEcLX8D9cq9M2qU37McvznJWLSv9R2cTsn6PjGdSmL+zRm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wr7GaOMa; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb58980711so9513991fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730987976; x=1731592776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjPqhF+YlcQn0yIhmNKRs/DhEwJmEmeP8iLWLpMI6mA=;
        b=Wr7GaOMaAYAJ1NumEbw4IY7fXVLdY6k3FRbDryNGPudP+GFe6PH574ZUEP3F1J3ET5
         qvdNxZKWV1vPjWDEjCW2qBHJNzZY2volY6RpZ7bMlGDyYFeZPp24OyzEy+O/MxdGhLBQ
         OT51vFSysuK8aSYMnClXWh7Hs/5OASk4VQW8TMgP9hwuGhwocAoxV8Pn+VY8JvqOa9l8
         kjyCK/CuoDd5sRu+qE2hGqC0LXFYfnF9feBH22Khq3cuuw57OlawB4wKzyYMtIsN5NlB
         TFXjKGQV4e8pErGMrdAuqCjzlID5ZyQDJg5NeJ80/ZzFmEt50p620pPNUpjuzOOvceen
         8xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987976; x=1731592776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjPqhF+YlcQn0yIhmNKRs/DhEwJmEmeP8iLWLpMI6mA=;
        b=aNRWgHPblN5bqiWAzVOoZNlu58attHNEwHlak3khyGh1g0ntglaX+YEI559GiUY7hH
         PZiaTf83D26rbVP/2tfbdpE+msw4bV0PSQLT9+Es7UgUcQPnySvPI/1bpL5GVX5x0n5b
         ofBQVcu6MZa3GJlUJrd4jKz9VwClecxP7BbZsMzZT6y8XvGPtcLk5qqLuHep+OzvzUVS
         1TDetMUH4eLk/dcoiwiRSHQ8os1kZ4EuJgQ+WOmpqUaYBdNKx2oPLJtA4Z214qzRUE6l
         Ll/ELhjGTptRnoIAybjAiFFm26dzDEwroYVOJpylq95fdn/OmIDKzOqJ0at4doPp5m+X
         yU2g==
X-Forwarded-Encrypted: i=1; AJvYcCWwxAcByPNUYrN/rD3x4DEYmdHt02Ym5laLx4UL/dRN2Wj8HJwbw6KBPOTy2lC7A7GyQje/Rp4KJnaZ9Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuO+yb0vSXpcom2qfx5VgebarLdOu7+mQDYVxX/2XU1tsYN+aW
	ppUrm8j+J11rFQN6OmAUTeYCKD75NZx87FUQNRvhdvopm+mO3IQlg84IEh7vy44A3VcWH++w3jb
	1/ttHOUnvvi35SUVA0/0Qvu7GHTQoKYE0q/u/XA+ogxXoPYgy
X-Google-Smtp-Source: AGHT+IEOhHmLmRUqDNgrDsObWsI4Bps1lbW63qufnLX/1tK5ugJfjlWHaCi62d8USJPOFp5KNIZcOECyI4iQH4ffxXg=
X-Received: by 2002:a05:651c:507:b0:2fc:a347:6d90 with SMTP id
 38308e7fff4ca-2fcbdfe2dcbmr202626861fa.27.1730987976405; Thu, 07 Nov 2024
 05:59:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107214351.59b251f1@canb.auug.org.au>
In-Reply-To: <20241107214351.59b251f1@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Nov 2024 14:59:25 +0100
Message-ID: <CACRpkdaxB1APxK_rRFEhcwBw0JZc20YN0z_881_iYVxeKs95LQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl tree with the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Drew Fustini <dfustini@tenstorrent.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:43=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:

> Today's linux-next merge of the pinctrl tree got a conflict in:
>
>   MAINTAINERS

Thanks Stephen, looks trivial enough but will try to remember to mention
this to Torvalds.

Yours,
Linus Walleij

