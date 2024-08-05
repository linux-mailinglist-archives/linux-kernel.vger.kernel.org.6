Return-Path: <linux-kernel+bounces-275272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8539948299
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DA61F210B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6AF16B396;
	Mon,  5 Aug 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuudZ2iy"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4229315F3FE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887367; cv=none; b=CdhVRoNQC/29v/7n1bXN/wiGPsZkXNOAZDqavMCDscbEsEVePiMtV17jXhBZzJl+30AzwMGrmlUmYdspVYkSW3pTHgB1vcOqCpYCa2UrN2VTKGefij4xx1B9ITQQBVqCzJNO0plcKcJjMrB2ZtmPiQtYtpcGQL0eXEnRz4Ab+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887367; c=relaxed/simple;
	bh=xS+MCZY02wPXOez+ODZmtOzMq+XafaJXJZwsCdN7OWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWxZA0IAN2rMZuoUoQy1fxcFhKBZ3x7e3h0/HBMN18B5QppB3sbqQ/51xsZ2LUZ++ti3xGKJCVv6jBkcU6W3rKjB4DIQXLsqEBYVbL7j1L6a6mSnYDioFHEhpZzlBi9DVWhWZFXWR1PL81IWXVeO1kw9DH6OkxceS0nu8YksNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuudZ2iy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d316f0060so3935161b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722887364; x=1723492164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE2bwtyEjXybcXwF8rQD5aS3KMAUj8eFnmuCDhVGIGk=;
        b=RuudZ2iy59hYxARd71mnOULudon+DPVhvtCD9q3AaaW44ErXRs4pVBXyeucTv7tL8d
         sZQ1aiFlSV22Si8KN9XhxbVTpX4BKHCX4n2ObM7FZgJiOzRXqn+SxroeWeVFZb/pPq5Z
         NDD3xBh/5waCwLbcDBKjaEmN92LgraAMK1B/nOGjq+y9LfsrEkaqhBcVQkxZAekQm5sv
         u2WcEECGP5y1Cccc6t50AXw0SHhJT8V79V965urVA7s1qbpDTF+UnoZr45ijpc1Z3WZQ
         Vw546yo40638gt4PydFolnFuXYfow+Ua82QR8Oo3i132iWxFlG8rHZA2xQjfvX5Pouie
         UnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887364; x=1723492164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE2bwtyEjXybcXwF8rQD5aS3KMAUj8eFnmuCDhVGIGk=;
        b=GUXi4DqJ4JL5OV+w+U42Uakxhpy6VVgWn8dJCZ+IbsMwvpd5ZsHFpYucdRZK+peQxB
         7MThGD/hUSSYbR3ol8eyzGXxgNtHXh1qZiPu43ph4jAHnB6mMAFAjgTdnkJLG8tmp3Rs
         M+1QFWkjuxmDLm5+rby1UF/3+4se2EvtZYXfXjAYcN4YO55fl7ddMlLjZAf+m3/551gi
         csgeeGePmTqalUwJLTKpDLXPLOWRQiJacX4Cs87JRtMcHyI9MfisxfowumX2TX29XHAB
         T8pYBjI/y2vjfRotYyTGPn4NVIXdpJ2tyux3GGpq1tA6BEODxl1mmAPu68Erf3zEnz5l
         FzWw==
X-Forwarded-Encrypted: i=1; AJvYcCUR/QwYc+AuFwqjVxmS7wzD7R6a5a+6hdeo7xQKQSSLA7uS9+nehZqfiPBlNeh1B89KqOr20OIxqKOV3wRRIUDKDDq77G11QZWTJq0o
X-Gm-Message-State: AOJu0YxqvVldIdD4dxYqWTO83Vs7l9mWb3o5wiiOE0AQ0x4vgmFgC6b+
	rVafyFqBqEyU4pAEqz4fEiZJ+Q3VzNNOcLk4WOt+hfWimxTU+iDi9PENVtxpJ9yiqhH/UHKoxpy
	X8lPp93fLhw/P1DnpxtCQbwEb5Nk=
X-Google-Smtp-Source: AGHT+IFYHMkxo2L55S9sDjZLk5hMOxIhiqax4iPzcIPQzELIWlKHEMxXECKWbfLjM3gtzZEs3dyEShRFa2jO7ph4tnU=
X-Received: by 2002:a05:6a21:460c:b0:1c2:a29b:efb4 with SMTP id
 adf61e73a8af0-1c69a6db8bcmr18695039637.24.1722887364448; Mon, 05 Aug 2024
 12:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3BC6F04B763EF430+20240731041040.43863-1-wangyuli@uniontech.com>
In-Reply-To: <3BC6F04B763EF430+20240731041040.43863-1-wangyuli@uniontech.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Aug 2024 15:49:12 -0400
Message-ID: <CADnq5_O3RtXU9pYb3ZJkzhNn1GoVUU9J=APkbxEMk07b7s9mCQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/amdgpu: Properly tune the size of struct
To: WangYuli <wangyuli@uniontech.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, Jingwen.Chen2@amd.com, suhui@nfschina.com, 
	dan.carpenter@linaro.org, bokun.zhang@amd.com, chongli2@amd.com, 
	Luqmaan.Irshad@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	guanwentao@uniontech.com, shaoyang@uniontech.com, hongao@uniontech.com, 
	wenlunpeng <wenlunpeng@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Jul 31, 2024 at 6:25=E2=80=AFAM WangYuli <wangyuli@uniontech.com> w=
rote:
>
> The struct assertion is failed because sparse cannot parse
> `#pragma pack(push, 1)` and `#pragma pack(pop)` correctly.
> GCC's output is still 1-byte-aligned. No harm to memory layout.
>
> The error can be filtered out by sparse-diff, but sometimes
> multiple lines queezed into one, making the sparse-diff thinks
> its a new error. I'm trying to aviod this by fixing errors.
>
> Link: https://lore.kernel.org/all/20230620045919.492128-1-suhui@nfschina.=
com/
> Link: https://lore.kernel.org/all/93d10611-9fbb-4242-87b8-5860b2606042@su=
swa.mountain/
> Fixes: 1721bc1b2afa ("drm/amdgpu: Update VF2PF interface")
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: wenlunpeng <wenlunpeng@uniontech.com>
> Reported-by: Su Hui <suhui@nfschina.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgv_sriovmsg.h
> index fb2b394bb9c5..6e9eeaeb3de1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -213,7 +213,7 @@ struct amd_sriov_msg_pf2vf_info {
>         uint32_t gpu_capacity;
>         /* reserved */
>         uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
> -};
> +} __packed;
>
>  struct amd_sriov_msg_vf2pf_info_header {
>         /* the total structure size in byte */
> @@ -273,7 +273,7 @@ struct amd_sriov_msg_vf2pf_info {
>         uint32_t mes_info_size;
>         /* reserved */
>         uint32_t reserved[256 - AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE];
> -};
> +} __packed;
>
>  /* mailbox message send from guest to host  */
>  enum amd_sriov_mailbox_request_message {
> --
> 2.43.4
>

