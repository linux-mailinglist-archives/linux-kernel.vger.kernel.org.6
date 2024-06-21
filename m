Return-Path: <linux-kernel+bounces-225236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A362912DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B26283B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C52F17B4EB;
	Fri, 21 Jun 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xtnmt/hZ"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231717C20E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998444; cv=none; b=Q+s9Lum6ofDt+c9dpYFvZZSoVybyUTpj9a68VYboDGB/OhFQARXnhQ2qPX0YeVrYLGzh/PEHhfCUk9vhaZyxYIzZAvOTwK42qgAEZ/DurXKZ3RBBVCmygMdiHHsO03ZReQplifuvSyPcKw3wX/dwaV/zX9MCNgFsxVRorMefGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998444; c=relaxed/simple;
	bh=22bAKJA6pR5A3fau1FPfbtJIxdk2LdaJWM67dwRA6io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7OvBloUlVvqcicxaroKmY1pI6T3pXKquERn+B/gJJahsyAUYgjSMX0W4GZyE0ANdo14pAX9K7+D1+paGKNe2TxM7iUJmrF072Rj2dbxryg0/F3Ax2oIuOtHn778Qd6ziVLDXiFg6O31mTTRVplaAajyq+t/Ee21/kAi+k9pHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xtnmt/hZ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-443586c2091so589621cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718998442; x=1719603242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcjyGl0poFmJvaQIN/Tb4xXEEBm1p2om5dg/4ZRBoHA=;
        b=Xtnmt/hZ7U0H84Hzk79GfR9fobS3HNJNKTVGF+df/NGNALBk/RL9uustBv9NfRNa6t
         AaNZX3i+2eakj7OFcG5Qd3HggWbdl4b6DGHrf50pal5ZLrWZYQVsIZafak0+OfFqsJwp
         j3T46x6LBnY4TFWtcThshUqCYFo0Qobx8j1ZB+MY559qT5O2X/T3YVv9ovRweFEIkm42
         jxRLuhez8THw/AC5cW2NRsoVQ4ZYFl5qVgBF+OL7oQAM6NNRYOjm9NWEsuU9lKN1NmH6
         C5/3PMOObMoLudk+TSmg+MjkOc+7vglScWrnD3l4GmQJ3MoCjiDKD3teiKDD7ZRC1pPW
         dvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718998442; x=1719603242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcjyGl0poFmJvaQIN/Tb4xXEEBm1p2om5dg/4ZRBoHA=;
        b=iZOlkJ/DKbbUgNU8rwD5pXWbhsCdUxjOMiG273CM8IWyGJmLWiIWECqrIv8GEo5DvK
         4Vtd5YMgi/r4Hc76X+5NndzSJ/klX1v1eQtB8wJTpbiovtFs3SIScOKdu8kOG/tD1M8T
         7UpF0YYrKMiZNyTGj9em6VWccfb+vdVBu23PvEMBMi4dTMND8eLdOQtE4sO8A2rPn9IC
         6PHSZV0ornNQiBqioT1j9h68QshAX+DhQJQx89S+GNkIPTk1t9BUbriWETs4bcMjT3Xn
         JZmChaWVoc0d8LFG3MokyAMPK3NuwTt2Pa2fe8Aa5vkISVegZK+uW43rTrNbBDX0AmoB
         Jv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBgvRBexWrVg2tIG92dB/NiSIK9fbzsQ2K8UgLHlSR6VDf4/cf5ZZ5wAtdU/4wMe7nNkdGm4gA38XY4hUh7u+wqEvzPLOyLd4wvHMy
X-Gm-Message-State: AOJu0Yw5hql3srjh57xsUjhu9gNYJxQdCj5aqiAeYbFdsG+ay0dZQQqQ
	eCRJPHGk1Q4HO1CcuXREMdHzMTyf4ZRJqIGVz8+lSxQBb8B92J3hlgYkvL/kgKdG5XFOxqx0C2m
	VLHQnLRQa5+SaBm651d3Z/viDLAbJFpiNoOX4
X-Google-Smtp-Source: AGHT+IHOnCXVNj6jxV8LpXQHq3BlC9ork7/0wY+nUji69T+kI2ZaEuQxzQC3D1JRanjzh53xix7c9zbM8luwO4E45L8=
X-Received: by 2002:ac8:5748:0:b0:444:cdc4:fef5 with SMTP id
 d75a77b69052e-444ce38fbebmr159621cf.27.1718998441772; Fri, 21 Jun 2024
 12:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240620080509.18504-5-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240620080509.18504-5-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Fri, 21 Jun 2024 12:33:49 -0700
Message-ID: <CAD=FV=UjFvi53W2gkfhJTz10ALSsR=E+9ZLCH_8KCr9h5bHSaQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] drm/panel: jd9365da: Add the function of adjusting orientation
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 20, 2024 at 1:05=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> @@ -893,6 +901,12 @@ static int jadard_dsi_probe(struct mipi_dsi_device *=
dsi)
>         drm_panel_init(&jadard->panel, dev, &jadard_funcs,
>                        DRM_MODE_CONNECTOR_DSI);
>
> +       ret =3D of_drm_get_panel_orientation(dev->of_node, &jadard->orien=
tation);
> +       if (ret < 0) {
> +               dev_err(dev, "%pOF: failed to get orientation %d\n", dev-=
>of_node, ret);
> +               return ret;
> +       }

nit: use dev_err_probe(). Also no need to include a %pOF, AKA:

if (ret < 0)
  return dev_err_probe(dev, ret, "Failed to get orientation\n");

