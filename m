Return-Path: <linux-kernel+bounces-398461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6709BF19B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186101C21CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86B82038C5;
	Wed,  6 Nov 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivuSJJvV"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE01DDC39
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906854; cv=none; b=ByJr8QYCOsJ7C4FDuSp7tmBPo6EuWrygjHsdqVrcNA3wdu8a44aisk6rIOj7GKuW54/m4emmkjtc5r7rbdn3rScRnkD77IAw8jz/jVcCem+XEybZ0TTaCk/XWayzZ3t0qKOHr5hVAOE60Vj214h/Ixg0Gv/m/gDTffkSe+Wcz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906854; c=relaxed/simple;
	bh=khnHTW39HSn3JTHlNYmL0W1k6sfytYlfFpjPyoIeOsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYT4xjm39mw0Bj8H73m+JKVv1+YPC+15GKbhrTll/0rt70paxVm2Fp/ftyWnxBa4jkL4VCdpTMOYtNPAnDPJiGaeMkqBCLlZMcxdjnA1OUZgQyrQaS41JWdYmiJkt03fhPxomeJzauF/3vdZVptMDMGYrfGaRkJwTdO13GcnJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivuSJJvV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea85fa4f45so1118276a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730906852; x=1731511652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N89Fo9DcmQh+49s/r11V+5uI0yB2KQxSET80sqWYF/M=;
        b=ivuSJJvVJuEe7erPjoqrHhaoaFOvcMGIgIhd0wockajADeTWTCsDBd61uH9MSetwdk
         Pj/rFmMkmrz0FFWT2rKlDA2Y/ftmmKHReMOgXD19PLvdnUtInyfJKMHEq1As7oCQOmt7
         ZQTlGOn+ZSzoJhdgwqvw+CgAyqO9+gJGATlvakoRB4qHEAzCFnQRrmsJOGED0uWeukaU
         5m9Dr9kYor6G17J2jJ/CPkPJH5Lq8Hkb4wn7nD4DdTM7gC/DOc7Sogr5ckEsXDWTsqVP
         SRS8Nn1MUtvgF5mTAhFitSeOBy49vhuM/BmcjNsCMCIhIOXfBy90mOaSMCeTH/eJPCg/
         tUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906852; x=1731511652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N89Fo9DcmQh+49s/r11V+5uI0yB2KQxSET80sqWYF/M=;
        b=psJpf6IdNmwWlyp2Jtsctyd11w1bSJtYREdAJfY2k58f2ek75z6WY11/tNL5H79Juc
         TxXFGSaPobSrZvO86NfIp0pBMy+JBBglPt3lXZVBRf5+wsecCLhDaf/Fn6MYb5OU2IDn
         2YdpjVdEGcUj358qxOmUF4DNx81G4xYLCsw6q/swNPcNDbE/JBDlBtlN/lkW2IZsfOCi
         dTVrGpoorW4RGI6hUPnDgBw3biMx/CQy0uA6vn3IAPIANgzMT8X/S0RVgBPCw8MZvgX6
         XzCGudlkCD5bnS5W5Ajfr72dICpbRDDjXIXGh80M+tkr4fRD66yLlu13NDBFMnUnIBfv
         ejwg==
X-Forwarded-Encrypted: i=1; AJvYcCUu9lsynGwvn6py0/4qnFIUFBCiyC4G3w+i80c6+ITRLLh3jGmUolfcXtWvhXt8WbsheO1iWbDAqEO+gnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG4fgcJC0z4nM0/WPfy3/TGXdtpblDxlosLDBlXKvG+/7GzDef
	lL/cxHQmkjFn59C+ngF1zoc8aZxqInir0vBu/TKwZURIsijMiDEQZ5c8htsurV16f62P71yRoNF
	GIpTlQd7A1H1Stmyoj0iBecUgzDQ=
X-Google-Smtp-Source: AGHT+IGahZV2s0jrrFME50JPfqWlFbkg+b2gaupSacy0btnmiwh794Y0JPIA7PhyejD8rRMMkv2YE2ATPbPZgf2PcdU=
X-Received: by 2002:a17:90a:5205:b0:2e2:da69:e3fa with SMTP id
 98e67ed59e1d1-2e8f104fc1emr19006356a91.2.1730906851873; Wed, 06 Nov 2024
 07:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105140256.2465614-1-quzicheng@huawei.com> <20241105140256.2465614-2-quzicheng@huawei.com>
In-Reply-To: <20241105140256.2465614-2-quzicheng@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Nov 2024 10:27:19 -0500
Message-ID: <CADnq5_OaH9e=4xX=ZJ1yH__EMo6x2Kzh1ZdD2rU+KG5x=4b_4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Fix incorrect power gating
 configuration for DOMAIN10
To: Zicheng Qu <quzicheng@huawei.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, Alvin.Lee2@amd.com, 
	chiahsuan.chung@amd.com, alex.hung@amd.com, wenjing.liu@amd.com, 
	Dillon.Varone@amd.com, george.shen@amd.com, mwen@igalia.com, yi-lchen@amd.com, 
	martin.leung@amd.com, yongqiang.sun@amd.com, tony.cheng@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, tanghui20@huawei.com, zhangqiao22@huawei.com, 
	judy.chenhui@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:18=E2=80=AFAM Zicheng Qu <quzicheng@huawei.com> wr=
ote:
>
> The current implementation incorrectly updates DOMAIN10_PG_CONFIG with
> DOMAIN8_POWER_FORCEON, which is not the intended behavior. This patch
> corrects the power gating configuration by updating DOMAIN10_PG_CONFIG
> with DOMAIN10_POWER_FORCEON, preventing potential issues related to
> power management.

The bitfield is the same for both so there is no functional change.
This is just a cosmetic change to use the right bitfield macro.

Alex

>
> Fixes: 46825fcfbe16 ("drm/amd/display: avoid power gate domains that does=
n't exist")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> index a80c08582932..67a77274d813 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> @@ -317,7 +317,7 @@ void dcn20_enable_power_gating_plane(
>         if (REG(DOMAIN8_PG_CONFIG))
>                 REG_UPDATE(DOMAIN8_PG_CONFIG, DOMAIN8_POWER_FORCEON, forc=
e_on);
>         if (REG(DOMAIN10_PG_CONFIG))
> -               REG_UPDATE(DOMAIN10_PG_CONFIG, DOMAIN8_POWER_FORCEON, for=
ce_on);
> +               REG_UPDATE(DOMAIN10_PG_CONFIG, DOMAIN10_POWER_FORCEON, fo=
rce_on);
>
>         /* DPP0/1/2/3/4/5 */
>         REG_UPDATE(DOMAIN1_PG_CONFIG, DOMAIN1_POWER_FORCEON, force_on);
> --
> 2.34.1
>

