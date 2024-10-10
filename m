Return-Path: <linux-kernel+bounces-359138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D27619987F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB6D1F21705
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ACC1C9EDE;
	Thu, 10 Oct 2024 13:37:37 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4C1BC9EE;
	Thu, 10 Oct 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567456; cv=none; b=aLt4WniN5Ruhsmal9/hIklZeSvOEm31s+0gGtr7hOL/OZhl0EwGfl6ykELx3TjJVX8HH0Pw9Z8NpawSc85ENDc+tk8hwkKjJxU1+NApUbJMizqyb9i95AJ8xCBMi6F6OhwQ+24dT2VF5iHwGGQqVpex8YgaSd0M6E4+VSPCqDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567456; c=relaxed/simple;
	bh=SIKjiEYlDDDOqLRf8TeBLmmvdWfnUp8Y2f7+7Cs8lGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4DLj5ZDXxGa/ekisfu9PrDZH1cwPb5+ionA4javngn5y8iIOPOwTnVH0E/byx+ab00ZFBLaU6kah1cAAkrONB2CpZhPth/9LeoT0GKXyY2ZsiQ1owqCOMe4/32wu2I4d+aMyUiiHsJH10yIEtEBPeGckxSgZX8GTT8NzWxQqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539885dd4bcso1246077e87.0;
        Thu, 10 Oct 2024 06:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567452; x=1729172252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzwzKkCp6jPszo6ZyDDEvEEJi7wd/je50oKdYYshjiU=;
        b=cnD5/3xkP4d93Uudyvc9IVJodBzVtp/xwEsb73MdELH8T/qWM3ja46Vj6FR2TzgBu2
         vTFDM31MOoebJYydp9u4B1rK+mUhxmi7ucw6A1bw/4TUon60/oDfinWQF2tf7aAv+YzH
         egNaVHd+j7ippJIKVEu7F75orFkhez1x3U4qvVnz6CdLxuhw7OkdVeJ341OIu8Pf336r
         e6/2Z0decytz+UoawLfvAzu5kj6VMPRe3h4I7ObX5zloSEq4cKW7vLeVJoRiEp8O5qPI
         pt89s/5kJbyd5vCDtfShL4YpYqy1ZccMbV+kSRIW7beTaB73LnJ6RAsgq1ef9LffFTi5
         D66g==
X-Forwarded-Encrypted: i=1; AJvYcCVVcjBTI54+mrfHO/BmaCdQ5bXspDad0gcSITHaWgaMQV03cUwE+o0/Vq22QOjZ3NVqM5AFloUnHjLLJzee@vger.kernel.org, AJvYcCXsFaliWiYWecl9n+ZTXP8QEy2Lgvr8IiSoX/OjYAryKpSjqsS+2nvXT6hQgx+4V2r6J1hlNq9iQRpCMmPrtJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Mv/2UCdGKy3w1WeWosH7l4u2Mb5H8N4Vt+p7tBHwfyu7SdOK
	l1JfLy2i9r+eF/2MZUxUaLM/qJN5ffdTtIvNRWN9lXCbKTw94/xtcytNVMgY
X-Google-Smtp-Source: AGHT+IEcoh2RQaSNRbeOOEMIpz6chBIsW5POZgHXcJIevZqUWxi1khYXg/UiWN/+93yD3ZacmtUVfQ==
X-Received: by 2002:a05:6512:3054:b0:539:8ad5:5093 with SMTP id 2adb3069b0e04-539c48e4746mr3735271e87.35.1728567451633;
        Thu, 10 Oct 2024 06:37:31 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb9053c2sm255644e87.282.2024.10.10.06.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:37:30 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fad100dd9eso10028321fa.3;
        Thu, 10 Oct 2024 06:37:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfvcykOVSZeZYzHxNTZtyf4O9hP5sY88sQV/0t8D4yWfkHtIqvj6N8vmFXuFBOAedTRSVG/ljTAmEqMQ1g3Ms=@vger.kernel.org, AJvYcCVkfL2cB8MpP6P5FHGXuCS3kAw3L91sdX1OGX1+po+1fQIDxGnjWW50Pt0PgOD3SGyucNyjmtx8HYANNbcU@vger.kernel.org
X-Received: by 2002:a2e:f19:0:b0:2fa:c57a:3b1c with SMTP id
 38308e7fff4ca-2fb1873eca8mr32339161fa.17.1728567450394; Thu, 10 Oct 2024
 06:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010091355.8271-1-algonell@gmail.com>
In-Reply-To: <20241010091355.8271-1-algonell@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 10 Oct 2024 22:37:16 +0900
X-Gmail-Original-Message-ID: <CAGb2v64=WSCyKVyMtUv1d_WoLLnJjEx4WzC3mmF2uB+6O+0oZQ@mail.gmail.com>
Message-ID: <CAGb2v64=WSCyKVyMtUv1d_WoLLnJjEx4WzC3mmF2uB+6O+0oZQ@mail.gmail.com>
Subject: Re: [PATCH] phy: sun4i-usb: Fix a typo
To: Andrew Kreimer <algonell@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 6:14=E2=80=AFPM Andrew Kreimer <algonell@gmail.com>=
 wrote:
>
> Fix a typo in comments: wether -> whether.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  include/linux/phy/phy-sun4i-usb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/phy/phy-sun4i-usb.h b/include/linux/phy/phy-su=
n4i-usb.h
> index 91eb755ee73b..f3e7b13608e4 100644
> --- a/include/linux/phy/phy-sun4i-usb.h
> +++ b/include/linux/phy/phy-sun4i-usb.h
> @@ -11,7 +11,7 @@
>  /**
>   * sun4i_usb_phy_set_squelch_detect() - Enable/disable squelch detect
>   * @phy: reference to a sun4i usb phy
> - * @enabled: wether to enable or disable squelch detect
> + * @enabled: whether to enable or disable squelch detect
>   */
>  void sun4i_usb_phy_set_squelch_detect(struct phy *phy, bool enabled);
>
> --
> 2.39.5
>

