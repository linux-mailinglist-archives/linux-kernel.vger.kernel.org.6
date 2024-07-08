Return-Path: <linux-kernel+bounces-244882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51492AACE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA891C215F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B1614D6F9;
	Mon,  8 Jul 2024 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/k3570U"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934201EA74
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472242; cv=none; b=YuQp5BHkmFQzsk9hp0ltTfV/FUtYBSsZt/TwLXM7j/NCaNU4EtsdYewcEJRPAc8x5ZOzqlBtj9vwDFPRedHR7f2UGlXMDZk7f58lWJCGt0jYtHy//Aktv6Nzb2aaRFthfjHVjX+K804Ef4izTbeQWd2xiXmIVptfPvdPNlMKDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472242; c=relaxed/simple;
	bh=NH2r/X8iV4qDEMmn+x38kpLhuWVZfY0ai+grUTUcP2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QV8wo6pswz2Laucv/Vkd83OvnUds7OFoZMVH2uM0Fw2Nz1TlyzlfVvrN7WYwB4o0sMfDJ3Z2cfMkI2YK9jvFGH9qARewC5VDvkyYdUGGA9CzpDhBV/creRJG0bmAgeIMKQHZrei+V2NhIwJBuunSvE3tJJHEv5OOZqJlz1wSh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E/k3570U; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79f014a53b7so235785685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720472238; x=1721077038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3bRIc+iREACl7d76GifVlBEhZSKcdfkiZIocigdrSs=;
        b=E/k3570UybUu2K1h+c3FtPbtkX1yHuU2sS6nL5j2GWZtE+sv+WxW21H/1nyFSMkpWw
         l3EiD3GV4XxY3EZlWUIfUcbf8YzZ+6I4/I/X2263K99VyyPcbEKrYnuPMGT3mpCg9Rhu
         q/waNjhHJkDx/V1Pp1eaZOCDQgpy6vJe8SyVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472238; x=1721077038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3bRIc+iREACl7d76GifVlBEhZSKcdfkiZIocigdrSs=;
        b=tPfLxaWjEdaLmrCOoujIfDREhhkmX3/pH97j3HtICRUQe+HXef3DEcK0bXBRFfAuzN
         g9t1b+gPnUxfKqWIN9DnRZT5y0iVIjxSI3k5gRRipjA0ZQlDWRk0QND3wXQR9FJGeBvO
         Akd0ttZugbWMjBocKcdTCvszdqc7avePvHMiK13feNtPkV+C3fYzbUGA1RNx6uDhsmE4
         J4+Ilv72EJbc4LkPXe501ExTOzBtZ/WdcpxPYk/ZYBLGM/8yTmr8a/V+VzBSRANmrijb
         dmH7h81omyEJXazIK6Y3ZPbR5FfDXe8KM0sC4bC5A6E8FdcIlo0oIpoRM4sZ++zannU9
         SSQA==
X-Forwarded-Encrypted: i=1; AJvYcCW5tEdCuZDuPUOFW+UvM2SV6RMV+g2SqvFv5b7Hn6pEPAu6TcTsgsokdBjFJR/4AqtqVj2W50ABc6t2MqjkHX1AtWQFVPkdgAXdiE2r
X-Gm-Message-State: AOJu0Yy7+w0Xeqj0gRqDu+4/jSv0skEBh5iWSjOrwLh+4V8Q3j/CKhbR
	mQQEIeCsT1vu8w9n/BDwYeoNJOL9JZq9vaNOo9pWgj8mPaOySiK/lkdP2gf4WNpvwUgHZAztf20
	=
X-Google-Smtp-Source: AGHT+IFyzSvIUPcDcpx9IutbZywD4R+UWDQ2toSM21sSdpplECOH0hN9f+SUTaohgSh4IZcfelWwiw==
X-Received: by 2002:a37:de0a:0:b0:79f:18b8:5de6 with SMTP id af79cd13be357-79f199e5d22mr67601785a.7.1720472237863;
        Mon, 08 Jul 2024 13:57:17 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1908ae97sm27079885a.98.2024.07.08.13.57.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 13:57:17 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-447dabd9562so96101cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:57:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU1gDu87WpiPxjkKuE/tGxxrPRb/S1XRANmpQQl3Bmh30+y/ojxhksBQK+aohuSm6/mF5F4G0sONgqxZAQ1SqPLTNFGGyl7ihZsdrI
X-Received: by 2002:ac8:7f4e:0:b0:447:e76a:c04b with SMTP id
 d75a77b69052e-447fb2f9b6dmr1122301cf.10.1720472236373; Mon, 08 Jul 2024
 13:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612222435.3188234-1-dianders@chromium.org>
 <20240612152336.v2.3.Ifb4450979b62976fd5a98847dade2e5b377d47c8@changeid> <D2ALRV4G5SZF.229WKTA9B95QN@gmail.com>
In-Reply-To: <D2ALRV4G5SZF.229WKTA9B95QN@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jul 2024 13:57:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xs16yXRDURfW_7QA_t4nZhOmpPXiibsLs2BBzJr_h+4Q@mail.gmail.com>
Message-ID: <CAD=FV=Xs16yXRDURfW_7QA_t4nZhOmpPXiibsLs2BBzJr_h+4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] drm/tegra: Call drm_atomic_helper_shutdown() at
 shutdown time
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 26, 2024 at 11:58=E2=80=AFPM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Thu Jun 13, 2024 at 12:23 AM CEST, Douglas Anderson wrote:
> > Based on grepping through the source code this driver appears to be
> > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > time. Among other things, this means that if a panel is in use that it
> > won't be cleanly powered off at system shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case
> > of OS shutdown/restart comes straight out of the kernel doc "driver
> > instance overview" in drm_drv.c.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This commit is only compile-time tested.
> >
> > (no changes since v1)
> >
> >  drivers/gpu/drm/tegra/drm.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> Acked-by: Thierry Reding <treding@nvidia.com>

Pushed this one to drm-misc-next:

[3/8] drm/tegra: Call drm_atomic_helper_shutdown() at shutdown time
      commit: bc5846d3d3dff9f057e2897a736b51584785da30

