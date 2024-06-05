Return-Path: <linux-kernel+bounces-202779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F081E8FD0F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768131F26538
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C908E2032A;
	Wed,  5 Jun 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf88l8XI"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54810979
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598168; cv=none; b=M8IjPecL3fRJyP16MIAG7ofXwxBZBqIj1omMFMVh3UxQUtDxdVP4uaKDYsI5gZiCQgFv0c9hYUK2mOvJJFCZf0/F+o8thOXaIrzYAHfMfBk+BhqyvAN0AROb3nEHOxhqx3fBoq5gmbPLr2FkcAs1YUFfISoScCS5hGE6oHkwaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598168; c=relaxed/simple;
	bh=90sQLbIUZo5FsAYSdsfJFZRSqmqR/Gsc7mPGaTjeK74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGi76gp8PQVUdPtWYC+MOSCrCaMNqSLm1ebIMhKz97jz1ebPJzJyLFeW5THiz17iTAKYhEDaJnXAj9rDUx0sJN6q8xMv9LU/eXWTx7YLhkQUTl+nR/AzzTBWc/hXc1I775pKc+St11MmN29AR+JgzhoLlidme6UamEOtYPy30ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf88l8XI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-701b0b0be38so51671b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717598166; x=1718202966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq1yy0Su5P7QN87mXYg9WXuNVfybQpz6GBQGEruYcrI=;
        b=Cf88l8XIDJpqHxCNYby7xa1J3jQdgtF1hKzBIqKF9S7kNPlwtjn/foI133ztGIAjlu
         /uHCsblOfJYZrB9mqCbYCHKfwOvWlB74r7wUeitL0UFsA7o8bpsW27pkYHPauQQ/w62V
         4S3GAPyOEU2cmSNxZdWmyARnJ1+Vp/MUd1hDNIR2oapr+QG/ADR5tVQQMEyLQ08wwHJi
         Mm1T+NYwK8/Uk1k24i00TZrnqb6nb6Boyw5d6xKNgPKDnpN7byfnx/M7dKapZfKOtScF
         rLnKf9C+JjOJ/blzZBgIVQ+M9d+Xx6FwXrAlhkJ/5O65PyYmoA2sQ6MzIK5zUShIUHvO
         at9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717598166; x=1718202966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yq1yy0Su5P7QN87mXYg9WXuNVfybQpz6GBQGEruYcrI=;
        b=T3dAExonkseqpTMDctZVkrB14WV25fnv97QLY7iEnBYqgYHBgZjHISZIh5gvULVbco
         cIKDTSh2INNlMbN3+NYfUkInwNLcwEujj6PJUiswmlghf0KNP/7WWHYO4KxtIT2qBUGP
         h5PUFTPjIGK/WpX8NT3nIPEkqdcji4TRdYMKH9/6bXGT92moEMsQytFziIKR9BilEW46
         bQc+CenBDy4HWB7NLXjVKt11gJw6d3pE4F/YBz9LjWxEaEn+qmC1EkzbJbUq/Odempz1
         oR9pVHhHJY+2fDZ+v3ke3YNEH8obp/zvB0TFX4FppJoc93dpG9ETw0shwjpmm5H10cLh
         OtqA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Jijl+iVq5t0bCAbnHefB0PbM9ooVS+Wxt1KA2i3RqFM+dRe/+LLs4QjOtS5GHN+eACOV/q9XqYqnWFXavN6d1gdusXlgrvdGx6AH
X-Gm-Message-State: AOJu0YwZrgiFIwks7E+rUq1mPAhCZGCL2xQSP6RloHhgFi7sYwDreYAC
	DgHq2mzBl2xFr/j5ZGKX4ymdOmuqjWJLZ/H3PxllFX4zEh3JH8O4uYgddTpEN4ajVg0n1iFdRKb
	48iDgai8VneZeUc1UqP4xH2LGy6o=
X-Google-Smtp-Source: AGHT+IHzMIhmIExlPP2dOJMwUeHRzAG3Zqtu8CJwxbDQujyXLFtz5Pdob5xgc4REV0gHk7os55wc3YNBoweEki0mI8g=
X-Received: by 2002:a05:6a20:918d:b0:1b0:111f:2b7f with SMTP id
 adf61e73a8af0-1b2b75a2cc8mr3145079637.39.1717598165835; Wed, 05 Jun 2024
 07:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604103736.3068-1-thorsten.blum@toblux.com>
In-Reply-To: <20240604103736.3068-1-thorsten.blum@toblux.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Jun 2024 10:35:51 -0400
Message-ID: <CADnq5_OtyaYJAcMpd6hmo4jShFq+1NjDHW5_TEcQB+Hf3yxaqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Simplify if conditions
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	daniel@ffwll.ch, Qingqing.Zhuo@amd.com, roman.li@amd.com, hersenxs.wu@amd.com, 
	chaitanya.dhere@amd.com, wenjing.liu@amd.com, alex.hung@amd.com, 
	sungkim@amd.com, syed.hassan@amd.com, syedsaaem.rizvi@amd.com, 
	dillon.varone@amd.com, charlene.liu@amd.com, hamza.mahfooz@amd.com, 
	nicholas.kazlauskas@amd.com, jerry.zuo@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Tue, Jun 4, 2024 at 9:07=E2=80=AFAM Thorsten Blum <thorsten.blum@toblux.=
com> wrote:
>
> The if conditions !A || A && B can be simplified to !A || B.
>
> Fixes the following Coccinelle/coccicheck warnings reported by
> excluded_middle.cocci:
>
>         WARNING !A || A && B is equivalent to !A || B
>         WARNING !A || A && B is equivalent to !A || B
>         WARNING !A || A && B is equivalent to !A || B
>
> Compile-tested only.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 6 +++---
>  .../gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c   | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c =
b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
> index ad2a6b4769fe..940081df6dc0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
> @@ -68,7 +68,7 @@ static bool get_plane_id(struct dml2_context *dml2, con=
st struct dc_state *state
>                 if (state->streams[i]->stream_id =3D=3D stream_id) {
>                         for (j =3D 0; j < state->stream_status[i].plane_c=
ount; j++) {
>                                 if (state->stream_status[i].plane_states[=
j] =3D=3D plane &&
> -                                       (!is_plane_duplicate || (is_plane=
_duplicate && (j =3D=3D plane_index)))) {
> +                                       (!is_plane_duplicate || (j =3D=3D=
 plane_index))) {
>                                         *plane_id =3D (i << 16) | j;
>                                         return true;
>                                 }
> @@ -707,8 +707,8 @@ static void free_unused_pipes_for_plane(struct dml2_c=
ontext *ctx, struct dc_stat
>         for (i =3D 0; i < ctx->config.dcn_pipe_count; i++) {
>                 if (state->res_ctx.pipe_ctx[i].plane_state =3D=3D plane &=
&
>                         state->res_ctx.pipe_ctx[i].stream->stream_id =3D=
=3D stream_id &&
> -                       (!is_plane_duplicate || (is_plane_duplicate &&
> -                       ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_=
idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx] =3D=3D plane_index)=
) &&
> +                       (!is_plane_duplicate ||
> +                       ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_=
idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx] =3D=3D plane_index)=
 &&
>                         !is_pipe_used(pool, state->res_ctx.pipe_ctx[i].pi=
pe_idx)) {
>                         free_pipe(&state->res_ctx.pipe_ctx[i]);
>                 }
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.=
c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
> index a41812598ce8..b2bbf7988f92 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
> @@ -979,7 +979,7 @@ static bool get_plane_id(struct dml2_context *dml2, c=
onst struct dc_state *conte
>                 if (context->streams[i]->stream_id =3D=3D stream_id) {
>                         for (j =3D 0; j < context->stream_status[i].plane=
_count; j++) {
>                                 if (context->stream_status[i].plane_state=
s[j] =3D=3D plane &&
> -                                       (!is_plane_duplicate || (is_plane=
_duplicate && (j =3D=3D plane_index)))) {
> +                                       (!is_plane_duplicate || (j =3D=3D=
 plane_index))) {
>                                         *plane_id =3D (i << 16) | j;
>                                         return true;
>                                 }
> --
> 2.39.2
>

