Return-Path: <linux-kernel+bounces-297834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C0495BE45
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3478C1C21F78
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61791CFEDD;
	Thu, 22 Aug 2024 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY9aJ+u8"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2D1CCB57
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351655; cv=none; b=nOkEOOt/gAmsUc5WNEwU3hFMReEvKgYTaE3TiW80KpT5YFwJcLXx6sny1twFVig7KSGTlSKvMPjSSbPKCgeDvKSo5Qr3ssOC/MAUXurNSd+cj9aO/Qaq6xYmd+s0QUVAvDAI5bzNiT12uObh2Jy74uPVaONs/c/SSdpSWufxWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351655; c=relaxed/simple;
	bh=WMvTUa7qKk39u9nzqSvoy80bpq9bG/THrg+yziDWPLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBqNP/j07BnylGHeKtz4g3sq8oZHoifgxK2RddQVENsemgpiNoy6U7y69Dqm+o+YFP4zzPC8bDJU10bZX051lUrWonQ8KM/AVTG4eLNbmtfNhc8YAIUzzsvr9KQ939KcTC9IOZklynXhooJMXSiDD6VUdFs6B1DXDN24ritqy+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY9aJ+u8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c2595f5c35so117576a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351653; x=1724956453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMxxaOtK8U0yo4hnUE3Sr+BVfCfehARBQJOIM+1YP0Q=;
        b=SY9aJ+u8GR/5REDhk+rlGeo2PWHM8EAfTE5IqRzDI9+bvau+x+lUTmYGE2MX0BWWQX
         UUsM3B8QL+rlNTGw7U5t2T6rVEznTOHmwyffWtqtGEZF9oi6EOzoIFHyL1zlA1CfuTM5
         Wf9ra0P4PsNXhtegJFBk8i47YBXqtN0wn5XIYlzQRa8/boXSHzeG3tQus0mz55f0dZ1x
         ATjzno8W7QlDl54dDPwDwOBQ2BwLdgSw7ei5bR1ichgVWqYDE1iLKAB/uRhn1cACe6P9
         XYKoZmIj9EYV50ImEzDRtz1hbHrE/FxvBMtYo8oVmbyPXsCVi2Y9O4b3BSfr1xutg4Pq
         fG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351653; x=1724956453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMxxaOtK8U0yo4hnUE3Sr+BVfCfehARBQJOIM+1YP0Q=;
        b=MrdyF4JjI+mLqqA+H1iX2d6bw0qUWAxFijc0NwuJh0oV+HvPtVKVsb8MEB+VfYe4k1
         jiIC7OUKUdhjVuYcUl8gMZUZBGJQgpDbHHLw6TMbg6kr9rqt5v6VBT7qunE+V4UY5sBc
         yjHAJQqy3XqYAyZt6eQohhbEz4BSry4iIvm39F9lPFC/95veoZ4k4BdC773URpiN9RGI
         qWRLnWAtp7n0trVH/yclId3K0GoTF1YyFZenH2iVno04GzwYssPXM8ciGj2+EoEh/ooQ
         MrP66lF9s3reuG2l2Vo8KRY41FvT6O/ORK+UtfKJNWqV3b9DS51BlhMEJ9Z1RI7fWxS2
         wzXA==
X-Forwarded-Encrypted: i=1; AJvYcCVbh5hMJ+3GSATqWs5KpEFGo3yNByJW9O8SAjcx4hTd56xhG2mNlCNxs1Xy4Ckh65xP0QuKul1qChAJMA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fYImhmxjDyKenxWBe+xhpNXvzpeRBOjsGQk1l2rMHieD6ZCC
	VJpmLvIFb1AJkkhs5o9atmFJuKc/Iky9cSMgn+UzU744Ap8Eeit0E6rTx4Y6Lq3p9e06GgqhvUy
	aUBc60BQPCdSpxia8AXl9wMwGdbo=
X-Google-Smtp-Source: AGHT+IGPF1XUUudFvjGPHATL7UDa9u1dQKv5EqeuytdBdTms5BymTb5tqh+mLj1j4yketuXtjUee6wZ3btV4aNuNyKo=
X-Received: by 2002:a05:6a20:7348:b0:1c4:f30e:97ff with SMTP id
 adf61e73a8af0-1cada1f1452mr4450575637.9.1724351652819; Thu, 22 Aug 2024
 11:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822065723.1336181-1-yujiaoliang@vivo.com>
In-Reply-To: <20240822065723.1336181-1-yujiaoliang@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Aug 2024 14:34:00 -0400
Message-ID: <CADnq5_Pm0Vg-RNtnRoj1Dkc2Ke3paz1D6PeDkaKacGstBn7uVg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] drm/amd/display: Use max/min macro
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Dillon Varone <dillon.varone@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 2:57=E2=80=AFAM Yu Jiaoliang <yujiaoliang@vivo.com>=
 wrote:
>
> *** BLURB HERE ***
>
> Yu Jiaoliang (6):
>   drm/amd/display: Use max/min macro
>   drm/amd/display: Use max/min macro
>   drm/amd/display: Use max/min macro
>   drm/amd/display: Use max/min macro
>   drm/amd/display: Use max/min macro
>   drm/amd/display: Use max/min macro

Is this the preferred kernel coding style for these type of
comparisons?  Otherwise this just seems like a lot of churn for not
much gain.

Alex

>
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c            | 4 ++--
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 4 +++-
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c            | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                 | 2 +-
>  drivers/gpu/drm/amd/display/dc/spl/dc_spl.c                  | 4 ++--
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c      | 4 ++--
>  6 files changed, 12 insertions(+), 10 deletions(-)
>
> --
> 2.34.1
>

