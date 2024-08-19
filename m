Return-Path: <linux-kernel+bounces-292490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC8095701C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B44B234E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC76171E73;
	Mon, 19 Aug 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U4vK2JAy"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117F172BCE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084560; cv=none; b=WYmDf37+p8RnJM+q3/6taO5OM+o4PiWGayKlqdAW5WwVAzMQnXAcC1+bfBGns8aZLYSmF4ciXop3X45Wku0177BWbC/TeniQDsi3TCESknnZgP1admHuj2VXA7ljpIo8QCG6P9AqXc5FHCBmhPSs3UVVP4IF+s28JTE03B0c8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084560; c=relaxed/simple;
	bh=fPUGvy9sYpFXYH/NEYowiXU6SmyW3hBHRsncd/kzZtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZC52Zis3XrqRRs2O6KJH4fPRAZeAW/4I3Ls1lCy/PsGQbar89tY/rb8lZIHcpojhjcJL9dU90Jn9y7qVHSGxKoO89Wr2euxsDYUCiS8nCetTJWqwcPss64i4IsJR3A9MjdH8QW+NDv4xHgMWk+62KXUSZmXpySJHdw0Ck1Z3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U4vK2JAy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52fc4388a64so5829879e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724084557; x=1724689357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq6CqCexN7qwRZZu9MMa8QuaMBEJlO3dqJ9z90a/SMY=;
        b=U4vK2JAyXnurlkCTMXV9lO3N998Gqt8XjwKmvPstUcj44zRgwdJx5ZndzQ/oEtHysH
         m1+xuiL+4+NhwyDNEthMXlhDkO/Nrh3/blfLeUbKlFs/EcBlfcxRrjgmEhRfwLuB79yy
         A+yYxcw86vszZbnFSQb8YSIxOWy2TAqlvkQFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084557; x=1724689357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq6CqCexN7qwRZZu9MMa8QuaMBEJlO3dqJ9z90a/SMY=;
        b=QCE4aEFW56Kvl+E18+7Myjh0KVq4UC2vGuGlkYFF309w/Ly2yY46z5xzS93szuRjBk
         ds4sxttdmNGmbzLXmRBwwwvIi5bmefQmMq57SWI/UdgSDRux2K+6O/lf0prf5Zmjo+Jk
         KXEnkul2TC7dPWJV5bqTjOgCslp7MKYneEXKNbBN7J0NW/3nTYM3xAGb5kfikVWuYQCZ
         /BPRVgjlswZGYIMud8LDtm+C9A4WnJ1q2itZ/83QF2Dw2Q3aD6YjmdL/5i4gBqIJaRIw
         riPLOjlGenQVkPDvf5atyhgm7kthjZXc/lG6x4obKMMBJoqy/MKHp1o6Hz8HGpy5f7vi
         0Hog==
X-Forwarded-Encrypted: i=1; AJvYcCWZSNIBNvZL95R0EMT10mRrWbok5/kAawyxb8E641OxNZLmeC8m7pNXpxF8zCl0sAfBQuqEpOh4Ic9R50E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPaJK9egBxm6KKvJhctpn++aswYQ7+STAvUozXvmI4SMbLtUEo
	YTVlRGwwR2okAEv8tSxnFCTzHEP790ugGsYpdvZR0S8eeUR0A9nj5Nwtd6pwuVMbArGOXwQOdIG
	krA==
X-Google-Smtp-Source: AGHT+IEdjO3pqsYK9UI3Jmg9WuCVzlMDCp80Xjl/FYTh6wcUa/iiLb+45EhPKx0rjxjwHG5DS5BAsA==
X-Received: by 2002:a05:6512:1598:b0:52f:c13f:23d2 with SMTP id 2adb3069b0e04-5331c6b232emr8262381e87.25.1724084556561;
        Mon, 19 Aug 2024 09:22:36 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3b8f82sm1523917e87.85.2024.08.19.09.22.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:22:35 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-429c4a4c6a8so37019195e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:22:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5ILmZeMZeLKuAdejMw6sjdFsk5a5ssmj2RITRxftCU7VYg8FaeI84c3YIa9KYn0oGLvKh7OiPwFtUJQg=@vger.kernel.org
X-Received: by 2002:a5d:5e0c:0:b0:371:a844:d332 with SMTP id
 ffacd0b85a97d-371a844d589mr4254441f8f.46.1724084554233; Mon, 19 Aug 2024
 09:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818060816.848784-1-tejasvipin76@gmail.com>
In-Reply-To: <20240818060816.848784-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 19 Aug 2024 09:22:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WaSyEC=Tu6CoUUGR9YDWpfOUTx84NmVPe1kbjL=O4ZSg@mail.gmail.com>
Message-ID: <CAD=FV=WaSyEC=Tu6CoUUGR9YDWpfOUTx84NmVPe1kbjL=O4ZSg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] extend "multi" functions and use them in jdi-fhd-r63452
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 17, 2024 at 11:08=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> This patch adds mipi_dsi_dcs_set_tear_scanline_multi to the list of multi
> functions and uses it with other multi functions in the jdi-fhd-r63452
> panel.
>
> This patch uses functions introduced in [1] and must be applied after
> it.
>
> [1] https://lore.kernel.org/all/20240806135949.468636-1-tejasvipin76@gmai=
l.com/
> ---
> Changes in v3:
>     - use mipi_dsi_usleep_range

Oh! Thanks for updating this. I had been debating whether we should
add mipi_dsi_usleep_range() but hadn't noticed that someone already
had. Nice! :-) I think this series is pretty much ready to apply, but
I'll give it one more day (or Neil can apply them if he's good w/
them).

-Doug

