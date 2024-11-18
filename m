Return-Path: <linux-kernel+bounces-413282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797719D16D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBD3284BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50FD1C07C9;
	Mon, 18 Nov 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gup7+rVA"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C4198A17
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949977; cv=none; b=JIWO/qS/k85/Go1zdrKLkmJpf+fdrzKDruuhKJFe+lzEqCWa9SwAGv0gAKZIYn3/oRYj1YhszChA6E5BSLU3JasBVmb0qHoSOAPlGfDqTQNtpMe5zZfu4SLVbLSXfGsgFI4b3FiE/VY4o+DHyptmIur2ciJH9Y/ZrbtkDv+pgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949977; c=relaxed/simple;
	bh=Jtyf/t+L9/EbKuUF0YGN4iftxomyWz0OrrEuxEVjUfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mgi+N86ecLdBIa53J1KP152Ug53K4yebcvE2XGxCVUdDFftp733CFdUecOcfNZ9mSdwReIJ4wQ3JWMqJKRZTEIxONZq9PbWLuS/AEydypDaworq5ssVj1VmVhUg88jZJMpy37N5zFvHLuULaVkqr3VeR/zB4YJ9+76kmFwquMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gup7+rVA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea6f99e6eeso386726a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731949975; x=1732554775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk5H560rK5BsovvCCaxfw+KXgoD6fruFx09my3hn7vM=;
        b=Gup7+rVAOYeATzgJ4y9l9isYWZgzvzuMOUbuSgGQvgG2ZJ/+JyfDP/ttFxtrsUXb0O
         BHVy35z3FlZKqqI/XuqX5UXF7458N+Kv0Ia5awTh321bIuejK284w7UI3I0ptWpfE/Ac
         bl1SiyLhhmJf+QKwmvVOx+YUUGSKsaWQb1ISt3Zzvp0He3vHidkzruDZpfL4TUejZ4rr
         /STeRbHJ1VlmEzVq6fjbQbTyAVvCVKc0Ubp82EJthgFj8zGK0ZoyA0MgskzxVeXbM5sY
         bIFlLiQOJIlCYaVEWncg7JlT7a8i84tg7b9mBay9HcFfYYyCE/qk1T3K4Ykh8g1V541n
         Yq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949975; x=1732554775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk5H560rK5BsovvCCaxfw+KXgoD6fruFx09my3hn7vM=;
        b=eiYBGnT8lBRqiMdr+9rQlE2ZCSvKWzyJSAIovvGY0C+EO4OxR92UvTMxFtMAcQsovA
         f/irqAnI0PBOmoH1xJ4YipyJhSPwi7vWtDLAux7LHir9bZzZZxdCLUmYH7TGIk2+1bYN
         EcZK/lzWqARZi9+S9CndaUoHfHLJm5lGX7XxMpvtWWqvPaMJPWIn+d4EYkxE/DgUGdKl
         ePJrQCsfmTNQs/rl+DdxqfgLX8Mnm4lc15RyhD2rbUqEEb6Snl7DgvxcTMFVUqMZv2nW
         yTKwzhRRWl9x2Kmv4XX70yiPb4lyVBNVVjdVWcjepqSaecGJdO7rFhil+QneYbgVrgQy
         Qeqg==
X-Forwarded-Encrypted: i=1; AJvYcCUI/XMUnxXz29CjFVMVlRRe2iJeHl8I4T9dmQa7pupHJIfWIXFL4KqCeA6A06RD8DSAVMLm0ky0kdwcLco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjXyaYTEr4MXUZWhgsqyIE2dKuyuz9cKNvMSgNflLGf8+CQSEn
	ZXKCPCv9V9TN9FnPIYFPV0CnUW34TJPVl5ZQ/xIomb1Z1YtihoFY8KHqkfi9MVTZwEmvC2zWrDS
	JlQNlvtxL5/nyuY1kEyGRoos+6ko=
X-Google-Smtp-Source: AGHT+IE6ngmFy7UPofNmRPhlwfyCxeZpvlmctz0UEvXL1nDdiPQr/jXLKOSqhpC+kaiXPnpU5HFHzkX9E93hubbTWBo=
X-Received: by 2002:a17:90b:2701:b0:2ea:2906:a6f6 with SMTP id
 98e67ed59e1d1-2ea2906a9bcmr5125705a91.1.1731949975016; Mon, 18 Nov 2024
 09:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105140137.2465572-1-quzicheng@huawei.com>
 <20241105140137.2465572-3-quzicheng@huawei.com> <93788edc-541e-4f7e-afe1-02a2526be684@amd.com>
In-Reply-To: <93788edc-541e-4f7e-afe1-02a2526be684@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Nov 2024 12:12:42 -0500
Message-ID: <CADnq5_OC=m2A6RrsoFAKDF5Ntonsq9cXHie9vQF3TttQzrG80w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Fix null check for
 pipe_ctx->plane_state in hwss_setup_dpp
To: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
Cc: Zicheng Qu <quzicheng@huawei.com>, harry.wentland@amd.com, sunpeng.li@amd.com, 
	Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
	Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch, Dillon.Varone@amd.com, 
	Alvin.Lee2@amd.com, nicholas.kazlauskas@amd.com, alex.hung@amd.com, 
	aurabindo.pillai@amd.com, relja.vojvodic@amd.com, wenjing.liu@amd.com, 
	george.shen@amd.com, mwen@igalia.com, yi-lchen@amd.com, martin.leung@amd.com, 
	srinivasan.shanmugam@amd.com, stylon.wang@amd.com, jun.lei@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, tanghui20@huawei.com, zhangqiao22@huawei.com, 
	judy.chenhui@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied both.

Thanks!

Alex

On Thu, Nov 14, 2024 at 3:29=E2=80=AFAM Chung, ChiaHsuan (Tom)
<chiahsuan.chung@amd.com> wrote:
>
> Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
>
> On 11/5/2024 10:01 PM, Zicheng Qu wrote:
> > This commit addresses a null pointer dereference issue in
> > hwss_setup_dpp(). The issue could occur when pipe_ctx->plane_state is
> > null. The fix adds a check to ensure `pipe_ctx->plane_state` is not nul=
l
> > before accessing. This prevents a null pointer dereference.
> >
> > Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new =
HWSS build sequence")
> > Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/dr=
ivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> > index 7ee2be8f82c4..bb766c2a7417 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> > @@ -881,6 +881,9 @@ void hwss_setup_dpp(union block_sequence_params *pa=
rams)
> >       struct dpp *dpp =3D pipe_ctx->plane_res.dpp;
> >       struct dc_plane_state *plane_state =3D pipe_ctx->plane_state;
> >
> > +     if (!plane_state)
> > +             return;
> > +
> >       if (dpp && dpp->funcs->dpp_setup) {
> >               // program the input csc
> >               dpp->funcs->dpp_setup(dpp,

