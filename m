Return-Path: <linux-kernel+bounces-256451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576AF934EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14D4283861
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68D140E30;
	Thu, 18 Jul 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="b/x5RGLM"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0692E13B286
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311348; cv=none; b=MBWdwiTh7kY+rWPfBLpGCK4CFxbaUu+6usCd+UNQIeQx57UvEL+vXW0PCU6NJ9lLLyziY5GGR408b2xMGp0Ar+fmUlKg9E04AmrcpY/7D7ICxNLbBRH/C5Od6fDa2gfbGBNKDQHOsoDpA+g9DJ/+AQJQHHNdsHH6tzow+OY2zjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311348; c=relaxed/simple;
	bh=uUBxsP5OwqRySuis+qvxmdP/RnC8PnPtj0vuQbpcC9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eujf1UEsSzt+f5B/lqMBa4ad4n1HYtsY0ZDrJzTnzGJUjB+FNfoSvu6YRenOD+bCFZYpVK6KZXbXHcF5nwiS91w1Kl+mPafxHVQy0qOjGl0/2mSiiRU0QJjQaPrOwvpVYce24ziSKU+bCjRepkENeVjDe4kN6UUxO2A05biOEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=b/x5RGLM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79f08b01ba6so27245485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1721311345; x=1721916145; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VvKvPRO5NYjHhe01Oz3SoCj7a9pXNENI5vwSAmXcMLA=;
        b=b/x5RGLM1xAK3l+KeLI4Moh9AICJCgmBy9PGlX3bzp7t/iQE1OMD6dHqobVBVizr7v
         Tk45wuU2NP8nbR35xJL9GIflr1BBISAnvT8Fztz7NwK04UVMiIhYDOtWYzEIWbeagScw
         jp78HRoTHkf5IctfimyfxglXOxUdwvNGuvdHSoShutfuAPbZgICPTlxCScwaakD0Fecd
         2iJCCPGB7sP5ODgu9FEoubfrz4f2eEjiUxOVDhVLpvrunPu3ePjeMaAzqY4orSfPcOKD
         D0fV7ZSfHSRiStCEB+H2qFKGPnlnhYApnMP8qxOJt0/4PeNPC/Un6QrpaEBYpsMjUQ3O
         afBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721311345; x=1721916145;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvKvPRO5NYjHhe01Oz3SoCj7a9pXNENI5vwSAmXcMLA=;
        b=JudV1wReK9FWMIwcVjY8KFB5X2tAIOkYlhBZBjuiR20kP700xcYhmMw4GJsO070Vw8
         ug9g32hT6QJQx4x2ByGGjSiaSkn2yqZmoRKGcpeyb4id0D5kgdamS0jUNsr17lDfDbG/
         bGy/z2BRtFnicLSQEGRXoD/teb5/6ogmpqNMx4AXZXV3LadwH9FMXwP9KnhaQzby5mTb
         CWxY69h8QCEOgfOcI6ZzPTvZ7XCu0NBDcmTnDvwFw5fkmth/hXpLwzsnl0Pa+mFks2v1
         9TCDY1lc0ymy+sADqQbi97QUb6VM+Gk8S+c06EEa64Kin7SAWzgjVs+VNMhAo19RmtHB
         FlzA==
X-Forwarded-Encrypted: i=1; AJvYcCW2OCdRVRIrfkYQ6Z2+gzC/wYi+TmylGTPc4z9Kto7epnCq6s76kIMHJDI8D7/pe875vFBJoYx9zKSrYkwW68fLIah029+gieoDMgpv
X-Gm-Message-State: AOJu0Yx2yj0tFLwGBcnlqElO3jxepuBCsbfk+50pfQ9KLI9KcWJ0aCuN
	705sRxWzrN2CEZRGCztU58Xo/vQaDZujx1a/kVTUxHfWIxe9yTkM0Lb1C3TT9Cw=
X-Google-Smtp-Source: AGHT+IF+MaGz30me8lQjxfHV5NL4PJcnPokd1cpxOn+VZpZUYaTF6SRxFRuCJ5GTPVt1tJdV24Cb+Q==
X-Received: by 2002:a05:620a:2403:b0:79f:4c8:d873 with SMTP id af79cd13be357-7a193b42df6mr137027985a.28.1721311344709;
        Thu, 18 Jul 2024 07:02:24 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:15:6720::7a9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1938f73ddsm27753485a.63.2024.07.18.07.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:02:24 -0700 (PDT)
Message-ID: <b454d93d607047c63663b3f003b3d3c23f07bac7.camel@ndufresne.ca>
Subject: Re: [PATCH v4 1/2] media: videodev2: Add flags to unconditionnaly
 enumerate pixels formats
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, Jacopo Mondi
	 <jacopo.mondi@ideasonboard.com>
Cc: mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
 hverkuil-cisco@xs4all.nl,  linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-rockchip@lists.infradead.org,
 kernel@collabora.com
Date: Thu, 18 Jul 2024 10:02:23 -0400
In-Reply-To: <7113029e2e192d43523a1ea5dae041fb53ae5948.camel@ndufresne.ca>
References: <20240717131430.159727-1-benjamin.gaignard@collabora.com>
	 <20240717131430.159727-2-benjamin.gaignard@collabora.com>
	 <2kbxr3hkjbcnaqescxmlcerziixg72icqpug6wa25eeggy2pnj@vqmxe4ojcwml>
	 <dfc292f8-0014-4bf4-9429-31f729a176cd@collabora.com>
	 <ok2a4ubzka6rhzyj2c5op73ij7pw35g6e75whc2jjget62fatx@zka2ewyt3kfv>
	 <c8358d79bd51a9bfa5116b33ae5e7766b95d344d.camel@ndufresne.ca>
	 <1faa7098-b108-480e-ae4b-ed25e0020e51@collabora.com>
	 <7113029e2e192d43523a1ea5dae041fb53ae5948.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 18 juillet 2024 =C3=A0 09:56 -0400, Nicolas Dufresne a =C3=A9crit=
=C2=A0:
> Hi,
>=20
> Le jeudi 18 juillet 2024 =C3=A0 09:04 +0200, Benjamin Gaignard a =C3=A9cr=
it=C2=A0:
> > Le 17/07/2024 =C3=A0 19:50, Nicolas Dufresne a =C3=A9crit=C2=A0:
> > >=20
>=20
> [...]
>=20
> > > > > > > @@ -1569,6 +1569,7 @@ static int v4l_enum_fmt(const struct v4=
l2_ioctl_ops *ops,
> > > > > > >    	int ret =3D check_fmt(file, p->type);
> > > > > > >    	u32 mbus_code;
> > > > > > >    	u32 cap_mask;
> > > > > > > +	u32 flags;
> > > > > > >=20
> > > > > > >    	if (ret)
> > > > > > >    		return ret;
> > > > > > > @@ -1578,8 +1579,10 @@ static int v4l_enum_fmt(const struct v=
4l2_ioctl_ops *ops,
> > > > > > >    		p->mbus_code =3D 0;
> > > > > > >=20
> > > > > > >    	mbus_code =3D p->mbus_code;
> > > > > > > +	flags =3D p->flags & V4L2_FMT_FLAG_ENUM_ALL_FORMATS;
> > > > > > >    	memset_after(p, 0, type);
> > > > > > >    	p->mbus_code =3D mbus_code;
> > > > > > > +	p->flags =3D flags;
> > > > > > Won't this set V4L2_FMT_FLAG_ENUM_ALL_FORMATS (if present) in t=
he
> > > > > > flags returned to userspace ? Shouldn't be drivers to set
> > > > > > V4L2_FMT_FLAG_ALL_FORMATS instead ?
> > > > > memset_after zeroed flags field so we need this to send V4L2_FMT_=
FLAG_ENUM_ALL_FORMATS
> > > > > flag to drivers. Return it to userspace is a side effect but I do=
n't that is problem
> > > > > since it set it anyway.
> > > > >=20
> > > > Ok, if the expectation is that the flag is preserved through the io=
ctl
> > > > call, this is fine with me
> > > I might be missing something other similar features are explicitly ad=
vertised by
> > > drivers. This way, the generic layer can keep or clear the flag based=
 of if its
> > > supported. The fact the flag persist the ioctl() or not endup having =
a useful
> > > semantic.
> > >=20
> > > Could we do the same?
> >=20
> > It is the only flag set by userspace when calling the ioctl(), all othe=
rs
> > are set by the drivers.
> > I can clean it from the ioctl() structure after driver call but that wo=
n't change anything.
>=20
> This does not answer my question. In other similar feature, we have an
> **internal** flag set by drivers to tell the framework that such feature =
is
> abled. Using that, the framework can keep or remove that flag based on if=
 its
> supported or not. This way, userspace have a clue if the driver do have t=
his
> support or if the returned result (in that case) is just a subset matchin=
g the
> configuration. We don't seem to have done the same level of effort here.

For the reference, you actually use that semantic in GStreamer implementati=
on,
but the kernel code seems broken.

https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7078/di=
ffs#eb90d5495df2f085f163996014c748a36f143f76_516_527

>=20
> Nicolas
>=20
> >=20
> > >=20
> > > > Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > > >=20
> > > > > > >    	switch (p->type) {
> > > > > > >    	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> > > > > > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/li=
nux/videodev2.h
> > > > > > > index fe6b67e83751..b6a5da79ba21 100644
> > > > > > > --- a/include/uapi/linux/videodev2.h
> > > > > > > +++ b/include/uapi/linux/videodev2.h
> > > > > > > @@ -886,6 +886,8 @@ struct v4l2_fmtdesc {
> > > > > > >    #define V4L2_FMT_FLAG_CSC_HSV_ENC		V4L2_FMT_FLAG_CSC_YCBCR=
_ENC
> > > > > > >    #define V4L2_FMT_FLAG_CSC_QUANTIZATION		0x0100
> > > > > > >    #define V4L2_FMT_FLAG_META_LINE_BASED		0x0200
> > > > > > > +#define V4L2_FMT_FLAG_ENUM_ALL_FORMATS		0x0400
> > > > > > > +#define V4L2_FMT_FLAG_ALL_FORMATS		0x0800
> > > > > > >=20
> > > > > > >    	/* Frame Size and frame rate enumeration */
> > > > > > >    /*
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >=20
> > > > > > >=20
> > > > > > _______________________________________________
> > > > > > Kernel mailing list -- kernel@mailman.collabora.com
> > > > > > To unsubscribe send an email to kernel-leave@mailman.collabora.=
com
> > > > > > This list is managed by https://mailman.collabora.com
> > >=20
> > _______________________________________________
> > Kernel mailing list -- kernel@mailman.collabora.com
> > To unsubscribe send an email to kernel-leave@mailman.collabora.com
> > This list is managed by https://mailman.collabora.com
>=20
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com


