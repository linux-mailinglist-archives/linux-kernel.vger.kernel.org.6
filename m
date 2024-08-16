Return-Path: <linux-kernel+bounces-289435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8406D95462B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382961F214DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DFB17084C;
	Fri, 16 Aug 2024 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="H1yE1vXE"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900B16F0D2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801811; cv=none; b=a3lDo009JGF7FGNj3gIQujqW4IXXAcftbWXcOQsxRWkeHewiQl0IPPav61A2sXYsH57GKAEjFZWSVFpxRN0vhy2lZJ6SjQtlGdeUlTAyFr5hXqTB7U9vvcPeE3zJLtmLxM1COIGfiF6QmyEEfn5cipwvcsDvD28IJKqpsH1fK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801811; c=relaxed/simple;
	bh=CHQ+NPmQVZFS37omHyDmVEDa/txR3YEvhn3ONo2BXDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inOt1ixrB0KDvaimjZf/V1NGnrt3DoQ5ZmXPqRRDthgGWyuLEL5c97+nAKIZE/E8hV8+PLd5NXnc4iZCd/HhKlRuj6hn/ILt38ywUKgUA0Ol+eBgNwl9TdzFlu/JKS+CyCli9rONke+/bUrLvf9QIwL3ElDcqRnoCXmQ7jguF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=H1yE1vXE; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so19839451fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723801808; x=1724406608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHQ+NPmQVZFS37omHyDmVEDa/txR3YEvhn3ONo2BXDc=;
        b=H1yE1vXEE/mpxgeq2WIZdtPfiv0PvfNyc5hB1d8he2C4te0OOkgRcd+hCgj31HfWSz
         oYg5fPaT+h/tL33eteuOTQz+QTos9/NaQPVI2rCaAjYks+9U597boWTwWvRkz3/3xwz6
         a+efmoPUPF5yAXf/6nNOft8dVQ0eXXuee8h2/uH7Vh10WKSpnfACCKOnxZ6uXddlkTwJ
         Bf4VlBdoh6uRQ+ceqcEclNbGTxqXWgLzJ5YFBYZAHSVftOkj6EHJMWP1XkF/2OJKsP5N
         2hexUeNr1UXvA80ZJGAhw4j5BokJDKLFhMk+aY0CyzooJzZt7dIRXF5s78xMeQKvK9E9
         bKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801808; x=1724406608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHQ+NPmQVZFS37omHyDmVEDa/txR3YEvhn3ONo2BXDc=;
        b=NTPKxIIFuiLs6zNdWlsizj7G8RmJvgpDyzJrGyFM8MqnfUrVKpLoRqtlCRW3ttBSM3
         VBTTLR6ISVeYPqow9a6qhn7wSZL4AHNeATQxiCScylF7SeMz+/hclM86x3USRsgAzWop
         Eauc0nTGKQsA1PVkzNJ9RgdY/xOWbrSY/ZliKVPJT5LJYyjW2pk2vOPeL8fcdgMkvSn5
         3W6oZPiN71U+W392+r4YoXcnKklAagvpAHpsGIeXkP4OVRvdKOojSypEBKloKqYD7eiy
         BDcYPqyfjAPbmGAecgEMC7LV9bzzlYuDI5OcE53ajDlZw8BjgXyP9WtIaR/YII0UJDF+
         kMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqrhkuhgh7Zcsn6lI0KXiRd+SsKHHTZqt9xJRL5l0XcWOV2TV8hSFnLOpyiB1IFvAccTci56VLnfH1nOzUWR+KfQZemEz3hOatwcB2
X-Gm-Message-State: AOJu0YyX1tplFfTuWoYifuu+brQfeQ+vDROX+n4VAITvtzhaOIXnj2dc
	dbU2WwQNXZQKdoB03InzHwsA1tnC2WwBkmGVcO6/JRl712zAOFBfo3XztqV3d0VCNu4et1aZLMg
	+q3m2JxYNQCY1c76hb7rbFWMAGgHoDo0a3dS+9g==
X-Google-Smtp-Source: AGHT+IFNH5mDJnOyEqPzpQTAY1AoSCSs72K9GQZ9BwCbH2cPCtVdHDWdIpfPEJBIGm2rXuUmgdKzj52MPIsWb6Io7f8=
X-Received: by 2002:a05:6512:1150:b0:52f:cd03:a850 with SMTP id
 2adb3069b0e04-5331c6b0a4dmr1426019e87.32.1723801807810; Fri, 16 Aug 2024
 02:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815071651.3645949-1-ye.zhang@rock-chips.com> <20240815071651.3645949-3-ye.zhang@rock-chips.com>
In-Reply-To: <20240815071651.3645949-3-ye.zhang@rock-chips.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Aug 2024 11:49:57 +0200
Message-ID: <CAMRc=Me8OB6auZa0xrs3gBmGQb=UAeCDgczz_t2GLECW7xGQAQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] gpio: rockchip: support GPIO_TYPE_V2_2
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: linus.walleij@linaro.org, heiko@sntech.de, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:17=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> =
wrote:
>
> Support GPIO_TYPE_V2_2
>

I don't know what GPIO_TYPE_V2_2 is. Please explain in detail what
you're doing here.

Bart

