Return-Path: <linux-kernel+bounces-260358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A60193A7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2156E1C22513
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6401142625;
	Tue, 23 Jul 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WBPNkrWy"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B213C8F9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764146; cv=none; b=hreEfCv2rkuu/k2D8Md9zLUnZ66FV/rvdQZLzZc4IIqUOXJXzTWRzok/6cISBSQCha9zJhQ7I2+Ey2XoDOOs2cFcRARefdH64av0e8U2W0hq0xAR5QkFyEnKS5xuNZ1CjSiaqM5lqMs74bI8A4U+Sf5uK/hKcHDGX1wzKC4oK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764146; c=relaxed/simple;
	bh=9LSZjJF3h4qefKbL6x/jqytdib88aMMiWFAR3e/4+VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYrpSpu483nz+36keobp41kBBzFJJh0PFln35sTwgU4v7Iphbda9sqnX+m7Mkc+/3qKTBQ/Okgj+tPbWzMqDa6cNzV8vLMvb9Bfa6vyp21eXArWI6dosRt4S/1NUszjGZkrPuUNGGscdb/56mx/TlVccU3e1Ay67ZROYeAlInpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WBPNkrWy; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-821b8d887b8so1790375241.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721764141; x=1722368941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rk9EMEI4L6lDxsIEgVeMjCp1kcxiTQupiuAAcvpqnrQ=;
        b=WBPNkrWyS10iT0cQFozsSKsS43MkvkyG19QzFgOwtS5m8VmtH+rtcuKLaou8WBjfGp
         xX0qPYIuuDCIexUBGGzRmJG03fH2r6gPeB94obMLxRXbP1Y0WEwWBox83jEmAQW2MVRT
         ZEYlzR1pUwSL8M126w14qqM3b90Kba+WaF6dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721764141; x=1722368941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rk9EMEI4L6lDxsIEgVeMjCp1kcxiTQupiuAAcvpqnrQ=;
        b=bInxG3JHrc2h0c0+uqbjSfoW+DsfEp2xXRbl7YQBXeQRPCBHCha4wpe15MvdV68xNl
         YnGzgULo1S7wH+FfbRqqm+hEguJRip87cgiQjpVaeH6RIPEK4PgWbfkqAZ0+TrCrZ6Wf
         TbZzgYga0uRN/SRHfzrzDPAkUziHosHyRxntrR3wqgrCzlLygIP8+1K0ETnMWPTTFOdy
         IedR1/jUNfHFubOn0HRv0hmIitdT7PnVTroxei3eZ0xI/lg4HnFppDZGeLcs+QLk9AM0
         2gsI+QGszGLYJBiv0VAwkB++FjbgocdcanizvL+sgHaVxtv/eCQN8LTplT6Yz4H4sBeI
         ZVZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVksplDVCJI12pSoGHlKOlbkDn4w5Z/81D60QlNKFZru+L0UcB36eAONx47vleFDvemzAK1pLTe9W14ID/O2U9oQdrhotdvTmBn20nn
X-Gm-Message-State: AOJu0YxW4pknvFBwOKjviKFYt8xJ8FD5ntCyYb9Xf+P+Y19CLADXWUEh
	0zXC/Avrw8xQybHpf75uG5ajTsAM029VM7rDRohIthlollhqrPTMvAE1+E0cuIcsE3N4Gs1N3/Y
	=
X-Google-Smtp-Source: AGHT+IGs5qw1RPnYAPLdXGQJrNoxlSm5rrvNkat4jguU7WqYEd9LlickMj8lvsp+VkCVgtMAanUT/g==
X-Received: by 2002:a05:6102:f86:b0:48f:e759:94bc with SMTP id ada2fe7eead31-493b0705f62mr5462409137.16.1721764141297;
        Tue, 23 Jul 2024 12:49:01 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fbd47esm509470485a.32.2024.07.23.12.48.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 12:48:59 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-447df43324fso10811cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtpOiphbpC/RPkoI5m+Db6SiuQKtiESof2wtXtCiCBRMtTObs0+28b3nahgqHmUH5EJOe26hetYQ1l7uRehW103A1mxCv9QnFZHCXP
X-Received: by 2002:ac8:7f49:0:b0:447:e423:a463 with SMTP id
 d75a77b69052e-44fd4a74d29mr921661cf.3.1721764139089; Tue, 23 Jul 2024
 12:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723062615.14796-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240723062615.14796-3-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240723062615.14796-3-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 23 Jul 2024 12:48:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VD+7hLSLv+F0Egh9=ab1nRCpiB4g+54fqeWg__z7T1-g@mail.gmail.com>
Message-ID: <CAD=FV=VD+7hLSLv+F0Egh9=ab1nRCpiB4g+54fqeWg__z7T1-g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/panel: boe-th101mb31ig002 : using drm_connector_helper_get_modes_fixed()
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	hsinyi@google.com, awarnecke002@hotmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 22, 2024 at 11:26=E2=80=AFPM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> Use public functions( drm_connector_helper_get_modes_fixed()) to
> get porch parameters.
>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> Changes between V4 and V3:
> -  1.Modify the return value, return drm_connector_helper_get_modes_fixed=
(connector, desc_mode).
> v3: https://lore.kernel.org/all/20240722092428.24499-3-lvzhaoxiong@huaqin=
.corp-partner.google.com/
>
> Changes between V3 and V2:
> -  1. Keep bpc settings and drm_connector_set_panel_orientation() functio=
n..
> v2: https://lore.kernel.org/all/20240716121112.14435-3-lvzhaoxiong@huaqin=
.corp-partner.google.com/
> ---
>  .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'd assume that Neil or Jessica will apply these two patches assuming
they agree it looks OK. If this is stagnant for a while then I'll
apply it.

-Doug

