Return-Path: <linux-kernel+bounces-227388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD3991506D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B12DB231A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D36019AD8D;
	Mon, 24 Jun 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8/qjH6G"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B13131BDD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240336; cv=none; b=Ix4ZLkY/E29yJikK1Q5TSwrGTqb+EaHq1ls4ahZH0VKTTX2R+2M06/KsRdtlGPPkjLXKagUH/URdps0Fp7l3LCuxLI1BXMjW0INJK0q7DrSBzFQYUN6sGhKEN45COc3Yh1kbsiu/XHxaNrmypqjdz9ysGewhKaLl/o6mJt6S8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240336; c=relaxed/simple;
	bh=+1UNFUYPOjdpoUsKYW+sFGo41wX1gq0AEnfQE0aY6Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWMPQxLKOsDg6gUz+jzld02z1r9676TehL31RahM4K5EazUiDYMwO4HRPfS67QQrOGEhkLjmu/pZno4euPy8GhkeSVEu0AfMF9cmmEhKkn/wIwLsSDYCpTcOqMVjLz5mNFmr+JbbtyfnDExYf8hQ576AYeFCBImJR1Qv0fR4yOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8/qjH6G; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso3052421a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719240334; x=1719845134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mDsOwzKtQuTbrnZkosOYMHtSypsAJlM4HZ6rzIl0Ik=;
        b=J8/qjH6Godgku0YeByzZIC6vmEcMXa3l01GuQB+u0gmoQGLVY0rvXwqtJhwaQnpc6g
         L9Al8zccGpAJAHXcT6JZiay/zCHW1Yw01Awng/DCbhKlIh2122Yq+WMwYHdyzKMmPgim
         HiING5W/NxvRJ+pc7VBEJtlNWxcYKM7ZJS3XqbXyvBU6Y5x/cEAEPmyj6p4YS2Hk4qJd
         Xywuxk7t9Ofy01lGnYbSweAT7p0OAG2jA7VMCsksDvxbhXH7vESwUqS/p7zcy5IVRe9C
         OLOFiYS2BbFUBQ0oXYuxqaSyq2p5dzibTo35RcB6rqCBITJ4g+SwzDdIMIPwoTphJLjq
         q2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240334; x=1719845134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mDsOwzKtQuTbrnZkosOYMHtSypsAJlM4HZ6rzIl0Ik=;
        b=FsInNaSB1uC6cg6SvTLHLV3MKvd9N/e05LUsw+O9QsCczXKzDMD2dtcKbGFo8XzKaj
         xRe0vKICNo8Rc5fS967t66jcUPHoGI1Z0J8m7mIeAWmnaOUvlHKpGXDcY6mySo5wI7c0
         aBIEqqdqnsW3qEncbXwgKWvQ6epluDRuTldRpFpmB4kW8wkUGwnf0Pttl7nrvzJ/Bc0F
         9IqqUu4KLbk9Deuyp1qJiCj349UyuFOGiMOpe2W2mJlJrPoovgFI1VRPCxEV4esgGTZ5
         3jCCxQ2YE0UJbjNo834x22Ve+tc+IOjXoJlqENIA3XejfCpdZOXy+mVEVZNv3GRKNXy7
         0XVw==
X-Forwarded-Encrypted: i=1; AJvYcCVMqhtRuHAWNWf5NtA/Q6qb5trOR5gfnnE+r028amu2xY4dRXSoH/BLtHOHFnAWXLs96/jLaWQ2gHq+PVFammJwUSemiGnTgoMdjzeK
X-Gm-Message-State: AOJu0YxMSg/XDu81z0IoNdPLGGMLykwJ/JaACdnJEUZ0SoaQvPIq7PeE
	5TO/Kk/Wfoyt9Lt9wajjNmbtpmyUB38/rJhXS6evXP0myBuZvzh2Rf1+BsUJo8FHSjdmjcHyXeq
	yb1Adww5ik4C0QdO8QGs/f9qugio=
X-Google-Smtp-Source: AGHT+IH3bebP0lY82vBlI8fNjwjTmbTeUHhU1OC4AzvNPEhJLF7y9pOSUVbKPACUzSAvVhS9/A0KI7pXKbrOwgq+IQA=
X-Received: by 2002:a17:90b:1c0c:b0:2c2:e45b:ecd with SMTP id
 98e67ed59e1d1-2c86124b3eemr3530884a91.12.1719240334393; Mon, 24 Jun 2024
 07:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624031158.98502-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240624031158.98502-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jun 2024 10:45:22 -0400
Message-ID: <CADnq5_O5eQ5oU7+oX+Hg8jsWY-9DLiRYJA6SOfotDQupnALgYA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use ARRAY_SIZE for array length
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Sun, Jun 23, 2024 at 11:37=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
>
> ./drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c:164:45-46: WARNING:=
 Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c:183:47-48: WARNING:=
 Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c:237:45-46: WARNING:=
 Use ARRAY_SIZE.
> ./drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c:257:47-48: WARNING:=
 Use ARRAY_SIZE.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9405
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/driver=
s/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
> index 1b2df97226a3..7ecf76aea950 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
> @@ -161,8 +161,7 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdc=
p,
>                 return MOD_HDCP_STATUS_DDC_FAILURE;
>
>         if (is_dp_hdcp(hdcp)) {
> -               int num_dpcd_addrs =3D sizeof(hdcp_dpcd_addrs) /
> -                       sizeof(hdcp_dpcd_addrs[0]);
> +               int num_dpcd_addrs =3D ARRAY_SIZE(hdcp_dpcd_addrs);
>                 if (msg_id >=3D num_dpcd_addrs)
>                         return MOD_HDCP_STATUS_DDC_FAILURE;
>
> @@ -180,8 +179,7 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdc=
p,
>                         data_offset +=3D cur_size;
>                 }
>         } else {
> -               int num_i2c_offsets =3D sizeof(hdcp_i2c_offsets) /
> -                       sizeof(hdcp_i2c_offsets[0]);
> +               int num_i2c_offsets =3D ARRAY_SIZE(hdcp_i2c_offsets);
>                 if (msg_id >=3D num_i2c_offsets)
>                         return MOD_HDCP_STATUS_DDC_FAILURE;
>
> @@ -234,8 +232,7 @@ static enum mod_hdcp_status write(struct mod_hdcp *hd=
cp,
>                 return MOD_HDCP_STATUS_DDC_FAILURE;
>
>         if (is_dp_hdcp(hdcp)) {
> -               int num_dpcd_addrs =3D sizeof(hdcp_dpcd_addrs) /
> -                       sizeof(hdcp_dpcd_addrs[0]);
> +               int num_dpcd_addrs =3D ARRAY_SIZE(hdcp_dpcd_addrs);
>                 if (msg_id >=3D num_dpcd_addrs)
>                         return MOD_HDCP_STATUS_DDC_FAILURE;
>
> @@ -254,8 +251,7 @@ static enum mod_hdcp_status write(struct mod_hdcp *hd=
cp,
>                         data_offset +=3D cur_size;
>                 }
>         } else {
> -               int num_i2c_offsets =3D sizeof(hdcp_i2c_offsets) /
> -                       sizeof(hdcp_i2c_offsets[0]);
> +               int num_i2c_offsets =3D ARRAY_SIZE(hdcp_i2c_offsets);
>                 if (msg_id >=3D num_i2c_offsets)
>                         return MOD_HDCP_STATUS_DDC_FAILURE;
>
> --
> 2.20.1.7.g153144c
>

