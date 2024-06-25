Return-Path: <linux-kernel+bounces-229565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6499170F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A25B2289F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE2617C7D4;
	Tue, 25 Jun 2024 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHcLls8M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3BD17A906
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342707; cv=none; b=reKySmv5pnfaCM2naxET0GtxB1WS/jKBXRs1TvJG0nEWX3bS0bdBRtGQFmkgFxOfFnu/+lqZTfjS3PIvrt6rmpf9opePGb0uAccFZrAt75uukJfaUi+NA8+wGWTOM7QqxzHGY6RaQUzmkakCm9vGeElk00wAKE1PelQSZFaaLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342707; c=relaxed/simple;
	bh=qO9c0qpXrq+3fK0LEUzQ+gLt3HHAfu6AUWFZ9WrvQWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I8V30robMUVXGFpi1diMLDkg8/TxiLscD6uKhxhFn5+Xfv1tf07hsbKsGzGkkhS/R9t08TcGbAeo68pmUEtgbrL/1NJx1noUfFSitqPjo/EsDOUxL7C5pLq8lfoSMIJuxUHk4M25gNrYI9OMGF+kSHFtcPNQuUhnEXmCnxNTgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHcLls8M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719342705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e13YfLxrx9QBTn7/Lh+rajM0bGrTVztbpsgKXAwM4ag=;
	b=OHcLls8MwyKB4QxVZUDmKX5EBCjx6UdXW/SA/2qslGd2V27Y5qN5lgTcxxbrX8Jx+MmHVa
	qFcHwGpMwVNX9MVFTy3/kJCBXZPAJYdLNW6lDp2j9Izmemi3O/Awr4VU71wKNQk+23UnC4
	uL0MpFuxG0YSASAe3lEpNZs2j1rKguI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-2NRzjX5tNFK_ixy5RoFFIw-1; Tue, 25 Jun 2024 15:11:43 -0400
X-MC-Unique: 2NRzjX5tNFK_ixy5RoFFIw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79c126e615dso9185885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719342703; x=1719947503;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e13YfLxrx9QBTn7/Lh+rajM0bGrTVztbpsgKXAwM4ag=;
        b=B5nfWwpxYspGo4ErlqjBpQJoRR3DNXdu0ObGXL7cDxY7AHl/Ica7p/LYnoBWmZ4xzL
         eMNq/wKfY8TnXxf1gUXZCp+2i9PIZP7e5vm1u+cUPbUCTWmq/hTps2ej6RPEcx1zFtVE
         vi9uL0YTyqli1Vks2HrAVMbKoXwr1z3PDj/XnLw3YQj6uLSirkgn8yGh8nlrQZgDm2CO
         OXOboCLOGsChkZEy3Q3q5gvXbGueaUVz29zK14Ft5KARCmHYXcbzzSGh02uAByq94lk3
         U2K1QnxCU9ICOoj0mBhD4AqwJqok+ZGCct2OfI1Gj+e0UdJMP2dXv67YHkwMC9oK0EzV
         6ddQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Lw5cgAPg25Q+2P1mAHSC1OFqmkWb/czT76IkpOQUYNBasu0CdhLar/E+2oh9ULq4vpzx0w67ULi/ONA7iIkmFUj14MdJubozLhj0
X-Gm-Message-State: AOJu0YzAIWYQw8D4+o8N7EjbGQTJgd3Fk7Mk4xQY5MOHE4qVwh0ox4vr
	MZ28xUPg8q7A9I1s+TUR3A4ff37c5iRvuHvN2b6kNqLCB7rUaeTDKrK49JVBa+QlUczg1/CaSZs
	u3REokoP+mItQuXyn52QlnNds+amOoxd5oxbfwDTlEvhZgTj+oYyBOLpseBNCvwz1MI8IQQ==
X-Received: by 2002:a05:620a:4002:b0:794:8de6:505f with SMTP id af79cd13be357-79be701fe22mr779119885a.65.1719342702850;
        Tue, 25 Jun 2024 12:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhdICv2itjqoD37ZGNl0mT+EALkdSduHpGzBvI0THMGz2Iv/iOD7HGal7FR551LXjasudQPQ==
X-Received: by 2002:a05:620a:4002:b0:794:8de6:505f with SMTP id af79cd13be357-79be701fe22mr779118085a.65.1719342702478;
        Tue, 25 Jun 2024 12:11:42 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b1917sm433317085a.38.2024.06.25.12.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:11:42 -0700 (PDT)
Message-ID: <30a2ae4b3ac161012168a6d03cd28c616829eb22.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/dispnv04: fix null pointer dereference in
 nv17_tv_get_hd_modes
From: Lyude Paul <lyude@redhat.com>
To: Ma Ke <make24@iscas.ac.cn>, kherbst@redhat.com, dakr@redhat.com, 
	airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 25 Jun 2024 15:11:41 -0400
In-Reply-To: <20240625081029.2619437-1-make24@iscas.ac.cn>
References: <20240625081029.2619437-1-make24@iscas.ac.cn>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

I will push this and the other patch that you sent upstream in just a
moment, thanks!

On Tue, 2024-06-25 at 16:10 +0800, Ma Ke wrote:
> In nv17_tv_get_hd_modes(), the return value of drm_mode_duplicate()
> is
> assigned to mode, which will lead to a possible NULL pointer
> dereference
> on failure of drm_mode_duplicate(). The same applies to
> drm_cvt_mode().
> Add a check to avoid null pointer dereference.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> index 670c9739e5e1..9c3dc9a5bb46 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> @@ -258,6 +258,8 @@ static int nv17_tv_get_hd_modes(struct
> drm_encoder *encoder,
> =C2=A0		if (modes[i].hdisplay =3D=3D output_mode->hdisplay &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 modes[i].vdisplay =3D=3D output_mode->vdisplay=
) {
> =C2=A0			mode =3D drm_mode_duplicate(encoder->dev,
> output_mode);
> +			if (!mode)
> +				continue;
> =C2=A0			mode->type |=3D DRM_MODE_TYPE_PREFERRED;
> =C2=A0
> =C2=A0		} else {
> @@ -265,6 +267,8 @@ static int nv17_tv_get_hd_modes(struct
> drm_encoder *encoder,
> =C2=A0					=C2=A0=C2=A0=C2=A0 modes[i].vdisplay, 60,
> false,
> =C2=A0					=C2=A0=C2=A0=C2=A0 (output_mode->flags &
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0
> DRM_MODE_FLAG_INTERLACE), false);
> +			if (!mode)
> +				continue;
> =C2=A0		}
> =C2=A0
> =C2=A0		/* CVT modes are sometimes unsuitable... */

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


