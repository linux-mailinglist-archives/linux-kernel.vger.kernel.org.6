Return-Path: <linux-kernel+bounces-577677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F4CA72032
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4843BA899
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE3025DCFA;
	Wed, 26 Mar 2025 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="PWRDo26F"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985091F4736
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022086; cv=none; b=RSBgt3GJHfiWK9PO9NNUAl0U0NWypkofnqiDpy+rTYY7rnF2iv0bDo6f4YYzjH1FM59dO1UCrgiqaxfmMWWBzb/G2vyObyKis+FQnFvgsQK3rp9DOvIO/3WKLgJ9ErkvSNnfBt+dmeIOu3L4WljLaqfD1qG+sXgCvSiCPBAovT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022086; c=relaxed/simple;
	bh=iZDR7add7eN1zVk+r1bE50CmpFWFlq1fYzIJFP+7qwI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ezWnId7+sMuzMzvZC8bMo7EhFb5N1xu3rLNlii2g51OGzQ7ygAGJhnS2QdiRBUE6Qi6JWmzxLQYQA6bHJq6WU1JGYt9Orj/b72a+B8s3J/Wpd6k3jRpy9VDuDtFLtZevnEUKuesjHFHmfORF2xWkxk++wPGKLLNUcqzyMXzMLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=PWRDo26F; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c3bf231660so38624285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1743022083; x=1743626883; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xizmRrUy/BwEbc5ygOnCziYgTJp+/wXS4T9DQi0oG8o=;
        b=PWRDo26F90VnQShJ1aIpUvOPL6W/X5doYQrJKdvXFPypop9wBqzVSBkCJdyShSKUct
         j3/n5Z7CYOg+bw4GHXap/NScI9d7KFlu+F86HtMXoiW1Cuq6Ob/L3FhSqyjzgpp49m0z
         fMBTcwu7v/qBLdkyBxwm7CKhDQXEmAglnFbT0HkIp3Dn+4Ex1sOQtQOuBhNomZMl0+lD
         B8QwcaEAagQnlc5UCrH2fh8elFGnT96Kfg260cAQDKydlP0OAhBYFACHNhqBpxd+pFx8
         niDcYdiG+CtLYHPBA2J17TJ2jr7X/KdMIRCezgFrIimEJ746f/ZTO5lGcZJ7MiIlW8ax
         /fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743022083; x=1743626883;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xizmRrUy/BwEbc5ygOnCziYgTJp+/wXS4T9DQi0oG8o=;
        b=gjgcE2bue/iV7qLCMWeOKp9tGQhT32qn6lIoyb5ysv+ds3fFTLrknUerDXQMt4Oah9
         7wiFhM4gBgVtQlpuXclk+rSLqnWq5JfEQ6b/N4/XJZt0P6mTrrHQUs4Xq4WbmUsLdKiz
         EYt8cQMZtEnVceFDGnoydtS0uNUTLZTV1bY3ZpmxiFFtozvtrE6fM8mtqV2rCAP2Ax7o
         1WIGnXMhCWIucBlIlxr3eriRDq56pQ0GIyJNSpGCKTHQdqI3qLoG5HEyMYy1auUd7In1
         3goT18gQvPkM5hd7HwLigb1DkoclkiogvtrGrm9KLufsWFY7trQQW5NWcHj1pWFd0Lho
         Zt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA7hMWZxfwaK7ZH+6VwmK3vhEZAqaSCfU3LXWqOOFaJdezjR1gZLjcmx70EvjRpZzxZXKluM6MuIawSy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGt/43LlZRJ0rHJ0SmBksD+Sfjs0IfebcUTgFy+bq+a3wQcGwa
	zfwi/lsufa9UIHWwREcKsQ/DaczaW6MogqeehfnDfG/OwYd2LvmGNOAYrc5hu9Q=
X-Gm-Gg: ASbGncv8oij54knvzGNyXOXdWbdv5PIoIw1WqTKGXX9GP5xCA4L1DR4KjJ72EXAVzrJ
	LsLRc0Hqjs9xBZWTm3zyTxkryVLV5iPce1lOKfXT7yHiueccuQ/dBhmAa2mQkgpqC7uWtO+fM6a
	kS+jq2XtY+ly3kmmWE+YYkD8GTVxzhSxRf0z5jBVUOsflk1z1EUgtWYVy6OyvDfcsN0DgWPwatj
	mNkCaLcYxuhzt4mqoN2dE6sp9Bwbzr8eOMwaJWJoLpBaU7dEMoslOBlVz9xY1eQnXbtHhJVgKBa
	rLPp4VJtZbwe6znhYnvKFbQplfTN0xzfrZ7vN5or6PaBl2k9dw==
X-Google-Smtp-Source: AGHT+IGMCWLDibsmVi5EcOxTULZGbG+WtX8/19nsRNAN+Bh0W6Son3SwU9gdOK6uViYv86bCBZjgzw==
X-Received: by 2002:a05:620a:4247:b0:7c5:6396:f161 with SMTP id af79cd13be357-7c5eda82f01mr176278785a.49.1743022083288;
        Wed, 26 Mar 2025 13:48:03 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:e976::5ac? ([2606:6d00:11:e976::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b9348e23sm806915085a.78.2025.03.26.13.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:48:02 -0700 (PDT)
Message-ID: <c61a522d82bd9375e73d6f9c57f8ca4b0de258e0.camel@ndufresne.ca>
Subject: Re: [PATCH v3 1/2] media: amphion: Reduce decoding latency for HEVC
 decoder
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: ming.qian@oss.nxp.com, mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc: sebastian.fricke@collabora.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, 	kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, xiahong.bao@nxp.com, 	eagle.zhou@nxp.com,
 imx@lists.linux.dev, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Wed, 26 Mar 2025 16:48:01 -0400
In-Reply-To: <20250305062630.2329032-1-ming.qian@oss.nxp.com>
References: <20250305062630.2329032-1-ming.qian@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mercredi 05 mars 2025 =C3=A0 14:26 +0800, ming.qian@oss.nxp.com a =C3=A9=
crit=C2=A0:
> From: Ming Qian <ming.qian@oss.nxp.com>
>=20
> The amphion decoder firmware supports a low latency flush mode for the
> HEVC format since v1.9.0. This feature, which is enabled when the
> display delay is set to 0, can help to reduce the decoding latency by
> appending some padding data to every frame.

Just curiosity, does it stay spec compliant or not ? Perhaps share some
compliance (fluster) results ?

>=20
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> ---
> v3
> - Improve commit message as recommended
> v2
> - Improve commit message
> - Add firmware version check
>=20
> =C2=A0drivers/media/platform/amphion/vpu_malone.c | 22 ++++++++++++++++++=
---
> =C2=A01 file changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/=
platform/amphion/vpu_malone.c
> index 5c6b2a841b6f..1d9e10d9bec1 100644
> --- a/drivers/media/platform/amphion/vpu_malone.c
> +++ b/drivers/media/platform/amphion/vpu_malone.c
> @@ -68,6 +68,9 @@
> =C2=A0
> =C2=A0#define MALONE_DEC_FMT_RV_MASK			BIT(21)
> =C2=A0
> +#define MALONE_VERSION_MASK			0xFFFFF
> +#define MALONE_MIN_VERSION_HEVC_BUFFLUSH	(((1 << 16) | (9 << 8) | 0) & M=
ALONE_VERSION_MASK)

Just a suggestion, could also use an inline function.

#define MALONE_VERSION(maj, min, inc)   (((maj) << 16) | ((min) << 16) | (i=
nc)) & MALONE_VERSION_MASK)
#define CHECK_VERSION(iface, maj, min)	((iface->fw_version & MALONE_VERSION=
_MASK) >=3D MALONE_VERSION(maj, min, 0))

> +
> =C2=A0enum vpu_malone_stream_input_mode {
> =C2=A0	INVALID_MODE =3D 0,
> =C2=A0	FRAME_LVL,
> @@ -332,6 +335,8 @@ struct vpu_dec_ctrl {
> =C2=A0	u32 buf_addr[VID_API_NUM_STREAMS];
> =C2=A0};
> =C2=A0
> +static const struct malone_padding_scode *get_padding_scode(u32 type, u3=
2 fmt);
> +
> =C2=A0u32 vpu_malone_get_data_size(void)
> =C2=A0{
> =C2=A0	return sizeof(struct vpu_dec_ctrl);
> @@ -654,9 +659,16 @@ static int vpu_malone_set_params(struct vpu_shared_a=
ddr *shared,
> =C2=A0		hc->jpg[instance].jpg_mjpeg_interlaced =3D 0;
> =C2=A0	}
> =C2=A0
> -	hc->codec_param[instance].disp_imm =3D params->display_delay_enable ? 1=
 : 0;
> -	if (malone_format !=3D MALONE_FMT_AVC)
> +	if (params->display_delay_enable &&
> +	=C2=A0=C2=A0=C2=A0 get_padding_scode(SCODE_PADDING_BUFFLUSH, params->co=
dec_format))
> +		hc->codec_param[instance].disp_imm =3D 1;
> +	else
> =C2=A0		hc->codec_param[instance].disp_imm =3D 0;
> +
> +	if (params->codec_format =3D=3D V4L2_PIX_FMT_HEVC &&
> +	=C2=A0=C2=A0=C2=A0 (iface->fw_version & MALONE_VERSION_MASK) < MALONE_M=
IN_VERSION_HEVC_BUFFLUSH)

So if could be:
	    !CHECK_VERSION(iface, 1, 9)

There might be even better ways, this is not a hard request from me
though.

> +		hc->codec_param[instance].disp_imm =3D 0;
> +
> =C2=A0	hc->codec_param[instance].dbglog_enable =3D 0;
> =C2=A0	iface->dbglog_desc.level =3D 0;
> =C2=A0
> @@ -1024,6 +1036,7 @@ static const struct malone_padding_scode padding_sc=
odes[] =3D {
> =C2=A0	{SCODE_PADDING_EOS,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 V4L2_PIX_FMT_JPE=
G,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0x0, 0x0}},
> =C2=A0	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_H264,=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 {0x15010000, 0x0}},
> =C2=A0	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_H264_MVC,=C2=A0=C2=A0=C2=A0 =
{0x15010000, 0x0}},
> +	{SCODE_PADDING_BUFFLUSH, V4L2_PIX_FMT_HEVC,=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 {0x3e010000, 0x20}},
> =C2=A0};
> =C2=A0
> =C2=A0static const struct malone_padding_scode padding_scode_dft =3D {0x0=
, 0x0};
> @@ -1058,8 +1071,11 @@ static int vpu_malone_add_padding_scode(struct vpu=
_buffer *stream_buffer,
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	ps =3D get_padding_scode(scode_type, pixelformat);
> -	if (!ps)
> +	if (!ps) {
> +		if (scode_type =3D=3D SCODE_PADDING_BUFFLUSH)
> +			return 0;
> =C2=A0		return -EINVAL;
> +	}
> =C2=A0
> =C2=A0	wptr =3D readl(&str_buf->wptr);
> =C2=A0	if (wptr < stream_buffer->phys || wptr > stream_buffer->phys + str=
eam_buffer->length)

With or without the adjustments.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com


