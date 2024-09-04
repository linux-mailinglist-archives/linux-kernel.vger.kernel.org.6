Return-Path: <linux-kernel+bounces-316011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E082D96C9D1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4EAB247EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E21714B2;
	Wed,  4 Sep 2024 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eJrN+aHU"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089817A599
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486703; cv=none; b=n95he/V178wGuThm5lF183UFWG3X4ggsOWMXqcKPKzHCdjfNb2rTrkesbXDa9JXfcd7u1Mewq7BegNaiqKU18K+MOc4gWCa4V17k6LOcvpLsBcKiCwlj5AXDmeP2JbNVL2UWYHj3pOUPMwJELPpj1cVR7SeY0de9JSIBSeS7KnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486703; c=relaxed/simple;
	bh=5z6CC3oEk1DrfjT6IKhNHe/dwtdCYWt9qCgTKqR1DtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgwD4PuclR8tHvOxVszL4X03BRlMqODjr2UaRNh1puwO5TNdHycEVVxdSHeF/Cw4bQYJBZ0sMmb4+B17Ncogt/+m5aM6OY5gkA7UKdXAWbN64HkbEFAo+pbORwRFwx8z3syTLanzZWS290SRk7YQq1QfSj71mi/7688OIb3r4og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eJrN+aHU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4567cdf32d8so616731cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486699; x=1726091499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z6CC3oEk1DrfjT6IKhNHe/dwtdCYWt9qCgTKqR1DtM=;
        b=eJrN+aHUB7FJqfbxr57sfOyaXekzlsROVCKWBKDMWzSr65qFqF2j3sfmmIu1wfsP77
         sWsVfhpiT8gCPAgvc+cEYus7B/jjj1kd1LvGxEpTQgEkRn+q2Dnp05uxO+GDnoy2KPlf
         wiMzbujTgzaIhxJ6zxo62ic8fjyXVwrTkOZ5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486699; x=1726091499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z6CC3oEk1DrfjT6IKhNHe/dwtdCYWt9qCgTKqR1DtM=;
        b=FpOvf3v8nI1P3DDFO3F7YZOoO9QLtmWYg4mYrA5mQ2P2M1eFhUjKKmwYDsl63KBpgM
         FwKnohU4LU0mDZwV1KTe3sM2iPg0B27vFCZGfFSNvBvVlW3SVay0ZkiHdtpa9rSUL3FX
         Kd8PG/yxT+H3AMONqAd8RiNel2dRENfXZ4WPi9BtDbrPbT2T6rJAMtZITNNz1fr//R3E
         IZSD+l248sbFr9yKuYzhQmSfoeiwwJgKTdUVsB5/qpMpTtjPveIPQV2MgH20M+YLE2zd
         RJEHjIcQ+1O8g3iRwgxqA4oHMuEsFPfKP1F1uhQn8QxoS17d8RjzZZhEZmMEozl6ixm5
         HXJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhLxmlX9hRHpaTqoLhTgrls2BHIrkXRGRHFpKL4OQNODgkTdZj6PJnyzEc189utN+G+gSiTaWus/Pruo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRBoIK4wz7TdAquefcglT6NTA3pExjc50Xs71v7kzfPa6oxwY
	iIUusZmC7GBaMTgNMF7hITroe4l7vtkYWZjdmWhPdLOXmAMl1pYv9RQ0oyJPqLZgWOB6+iA72uw
	=
X-Google-Smtp-Source: AGHT+IGtR9CiZe01eOVokjFoM56GawZDI4FYr05Clfd6TmXdb5a6+ZRp4nYu3V3L6MbB/U/u/qviQA==
X-Received: by 2002:a05:622a:59c9:b0:451:d859:202d with SMTP id d75a77b69052e-456966924dcmr206434191cf.54.1725486698801;
        Wed, 04 Sep 2024 14:51:38 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801cbc1easm2069941cf.68.2024.09.04.14.51.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:37 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c355155f8eso533696d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:51:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfW1iVEPfW3PWT3OyVFMlpoJx1zaXgy4uCYkaHgKOLl4rZyAQ0brUQSDHFg47/rLMjRy1TjcKZfYDkoZ4=@vger.kernel.org
X-Received: by 2002:a05:6214:5f0c:b0:6c3:6ab0:9dab with SMTP id
 6a1803df08f44-6c36ab09febmr118827336d6.48.1725486697181; Wed, 04 Sep 2024
 14:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-8-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-8-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:51:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UX_knVfrei4UPiR3DT=H81ybSjGeDGAsWc3n6q=PiFJg@mail.gmail.com>
Message-ID: <CAD=FV=UX_knVfrei4UPiR3DT=H81ybSjGeDGAsWc3n6q=PiFJg@mail.gmail.com>
Subject: Re: [PATCH 7/8] serial: qcom-geni: disable interrupts during console writes
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Disable the GENI interrupts during console writes to reduce the risk of
> having interrupt handlers spinning on the port lock on other cores for
> extended periods of time.
>
> This can, for example, reduce the total amount of time spent in the
> interrupt handler during boot of the x1e80100 CRD by up to a factor nine
> (e.g. from 274 ms to 30 ms) while the worst case processing time drops
> from 19 ms to 8 ms.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Douglas Anderson <dianders@chromium.org>

