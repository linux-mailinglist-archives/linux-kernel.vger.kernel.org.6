Return-Path: <linux-kernel+bounces-283398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB294F1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116FB1F21AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133F418454C;
	Mon, 12 Aug 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K1JJVjGn"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28A8121B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477565; cv=none; b=fANJG7PKNGPTIXP+b41xDkByVl1R20MHqr9LN/IuVZn42jhzz24syJWGVWdy7VHTDG70TAuPZlzinDBDlWMBYEDG1LDcLQMhiCTxyQjQSBo2uPOOiL9r68esHx5Ixl6tgCCVwmJs3DB9J9x4BbI8p9LZ6v1o8IXAWDwSVQNVw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477565; c=relaxed/simple;
	bh=PWTnM/TlBV50vGuoHmIWpJag7IVGU1x6R8fvFCPQCsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRpuloh/yfmmE/GTQsL3odNzRHv6GCiKrFNQD5TmTczP/Z5NLBihs3ghXbjAfaE0TwcaplRf2KVjBNech6dcd9JCmi8232YLW7GAbKmqkWOwdFd/Xno4P3rEBWTTea9F6ibGtktoJkug3zyQzS4CBPgLVp9blUH44pSoZ6GdN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K1JJVjGn; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-690af536546so45649097b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723477560; x=1724082360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWTnM/TlBV50vGuoHmIWpJag7IVGU1x6R8fvFCPQCsE=;
        b=K1JJVjGnvKU8FNNCauOWX1Rk+ztm+yfquSpbc12/9U6bPaM+xFwnVwxOJdyAvEdkwb
         pUCM3ciE9YQ5eCd+qUNPsnsqZyNtUBdoxVMkkYFKjxPkFI/QIPGgZQpk807NgfDkQskZ
         dFtK78LM698fVMN+KvcJckCQTD/KHjDj1m/18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477560; x=1724082360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWTnM/TlBV50vGuoHmIWpJag7IVGU1x6R8fvFCPQCsE=;
        b=luBumtbDQVeHtVUV9DGBacTphnjQg88P4zj+1RYP1FyRaeHP90MEiF4qAEAOgtNXVx
         v8cMTXPHLsY1pu/NxVx8ljSs0CJY1G34HMcAixmfh4qeFtVqhoHXgg+llzAEVYl8KgjY
         ZSNPZ+JE294Maow8Gnm4XXXQc0Vu/cEc7bnk2jJbUqgMmnAEBS4rQleY4MwRB6zqBriR
         CpeuO6pVjUiNTkm65f/K0pHQ3i7vpgXQQqSMLcnI1UU/TEkd2NRAA266AyrEWEggVCdT
         jws1rOSyIiJtW3qEblN+aUhFZaCyqCZcNzeTG6260gqvq+uP8KSoPbwoZs7J423DCCZu
         U08w==
X-Forwarded-Encrypted: i=1; AJvYcCVHnGfouYDu2M2pHXVUdT5bmvZxLmCUpIsGnMdOIQnxsZkVsHOoQKKP07WrEhEMXVA+2bSCp5VzCpoRtSYlHOChYYqXbMQsNvXb9Oeu
X-Gm-Message-State: AOJu0YxPlanT6+W3p8FedRRoV8MaFNV298csmIVR9TTjDEv6SunkG3ip
	N5JcQHSLfelWWj/eJ/GDZpekWYgIivB3/eu1BdEuMBnShqnzN6zeGg20UYPEsJyPnO6sJ9LV28E
	BdQ==
X-Google-Smtp-Source: AGHT+IEWeIUSLMIfl84yy6hK/QTPq+vF/NYi2ItTvLgB8OfLeZC8we+xYq9XGHPEnXmsu6DiUeWcNw==
X-Received: by 2002:a05:690c:6e05:b0:650:a1cb:b122 with SMTP id 00721157ae682-6a9730143d4mr8420097b3.27.1723477559834;
        Mon, 12 Aug 2024 08:45:59 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a068cec6sm9291467b3.46.2024.08.12.08.45.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 08:45:58 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso4538359276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:45:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyaHqoK8L1vnMN1aCQvPj7Xc+bhzcVYLBVzAiZNlDwJTj9LX4CKpURuZ2iHIDpBkHSvnLoxNRp8VZomR5PRfWrcIPcr87tRWuHWFFl
X-Received: by 2002:a05:6902:1542:b0:e0b:e550:4e5c with SMTP id
 3f1490d57ef6-e113ced41a7mr1044286276.26.1723477557390; Mon, 12 Aug 2024
 08:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807100429.13260-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240807100429.13260-2-lvzhaoxiong@huaqin.corp-partner.google.com> <1518bded-72d8-4ed0-a63f-3dd21473b23b@quicinc.com>
In-Reply-To: <1518bded-72d8-4ed0-a63f-3dd21473b23b@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 12 Aug 2024 08:45:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UfE99Q1aQfPk61WzqK+kbMd-htWstjWUqgCvK1fqfWPw@mail.gmail.com>
Message-ID: <CAD=FV=UfE99Q1aQfPk61WzqK+kbMd-htWstjWUqgCvK1fqfWPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/panel: jd9365da: Move "exit sleep mode" and
 "set display on" cmds
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>, neil.armstrong@linaro.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	hsinyi@google.com, airlied@gmail.com, daniel@ffwll.ch, jagan@edgeble.ai, 
	dmitry.baryshkov@linaro.org, jani.nikula@linux.intel.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jessica,

On Thu, Aug 8, 2024 at 3:56=E2=80=AFPM Jessica Zhang <quic_jesszhan@quicinc=
.com> wrote:
>
>
>
> On 8/7/2024 3:04 AM, Zhaoxiong Lv wrote:
> > Move the "exit sleep mode" and "set display on" command from
> > enable() to init() function.
> >
> > As mentioned in the patch:
> > https://lore.kernel.org/all/20240624141926.5250-2-lvzhaoxiong@huaqin.co=
rp-partner.google.com/
> >
> > The Mediatek Soc DSI host has different modes in prepare() and
> > enable() functions, prepare() is in LP mode and enable() is in
> > HS mode. Since the "exit sleep mode" and "set display on"
> > command must also be sent in LP mode, so we also move "exit
> > sleep mode" and "set display on" command to the init() function.
> >
> > We have no other actions in the enable() function after moves
> > "exit sleep mode" and "set display on", and we checked the call
> > of the enable() function during the "startup" process. It seems
> > that only one judgment was made in drm_panel_enabel(). If the
> > panel does not define enable(), the judgment will skip the
> > enable() and continue execution. This does not seem to have
> > any other effect, and we found that some drivers also seem
> > to have no enable() function added, for example:
> > panel-asus-z00t-tm5p5-n35596 / panel-boe-himax8279d...
> > In addition, we briefly tested the kingdisplay_kd101ne3 panel and
> > melfas_lmfbx101117480 panel, and it seems that there is no garbage
> > on the panel, so we delete enable() function.
> >
> > After moving the "exit sleep mode" and "set display on" command
> > to the init() function, we no longer need additional delay
> > judgment, so we delete variables "exit_sleep_to_display_on_delay_ms"
> > and "display_on_delay_ms".
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com=
>
>
> Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Does this Ack mean you're confident enough about this patch that we
should go ahead and merge it, or do you think we should wait on
anything else (like Neil getting a chance to look at it)? As I
mentioned in my reply to the cover letter [1] the patches look OK to
me but I still don't consider myself to have a wonderful understanding
of the intricacies of MIPI DSI. If you think this is OK from a MIPI
DSI point of view then we can land it...

[1] https://lore.kernel.org/r/CAD=3DFV=3DWCw6pAump-PUFCW0cgbRY+5_2tPNLe=3Dh=
N3-dnXD=3DB6MA@mail.gmail.com

Thanks!

-Doug

