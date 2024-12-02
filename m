Return-Path: <linux-kernel+bounces-426889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85F9DF9D1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF07B21562
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15101D619E;
	Mon,  2 Dec 2024 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8QpXA+W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25810F1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113318; cv=none; b=lICyPD1+XnN8OOso75tuaKu3OYa3SYVmPE+H5Ymc/uqlSnXFWCHHLqaB/R7IVdkuR4g02TAwm5HGgtLldeVpEHq3DZpNLnW9BgpWB+6hRbyfsrtcAqNxXbbUZkCuIqEoV59whP8y2PKHrdTBx8gxQLGggHKOu++YOsOnDqN9FPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113318; c=relaxed/simple;
	bh=abYFohQCFkGNYOjf7erMN7SS30xJoxiDqV6SJpsyDes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ3OxfkdLB9GtLsPnCvxLz7L2UZjCSMfEQDNUXGtnYbc0thmUz2elPdg9K5QOai2qvDJqlf/hD1prOyJsqUMrMm4PuhypQcARthYCKScNzho2TpQhFozVR3groPOd9zj5Hk7Gjy4+LbKAi3RQFQi+YwDupYc7IK2hy0PPJQZX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8QpXA+W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733113315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abYFohQCFkGNYOjf7erMN7SS30xJoxiDqV6SJpsyDes=;
	b=R8QpXA+WQKS5vf71gh2NVKKE4M6+8KWeRxbEQDQF5UlccK+W+uh7m92qgbJ2+3KaTNnvuK
	RbNq9x/LndquDjghulf3a1va0xnEnCWw2U/s5b8TSIK6ZmRqzCgdDK3f9YW6cmguz0ezrv
	S6/d/o4vTp3safajhq6sL5rs06ptze8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-jWP_9QuDNpWI1SH2q2aNiw-1; Sun, 01 Dec 2024 23:21:54 -0500
X-MC-Unique: jWP_9QuDNpWI1SH2q2aNiw-1
X-Mimecast-MFC-AGG-ID: jWP_9QuDNpWI1SH2q2aNiw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee6ea04326so2788078a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113313; x=1733718113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abYFohQCFkGNYOjf7erMN7SS30xJoxiDqV6SJpsyDes=;
        b=S4uRXhe8HO8svkKGhGi2LA0m2rY7dVkQXGknOjUJCnwTXb3V81lIOMeW9Y9yBRngPt
         KbISNV0rWFp+8f+w1YMy3hPm9wXJthWRb7P2UoyTsz7g3K25CyZm6FpYPEuYZzP48OMh
         Y2bRrgQ4XDSSQTkaxJCvcubiTYxG5d6Z/RtIuOR9//06BXP+i8j5ZoQx0pMdkpdykc29
         q5JfAx553MLGMoShbldFHY78MhrpDFldaJmZAYt6yFfbgdW2VxL3C7acpwU8U3t0AV+I
         p6tuQcs10lrOOlmyg62fNjC4xWWbSZcXzTEcZBJlmnrmmaSNAG57acxG4CZAA/950Ipj
         p4gw==
X-Forwarded-Encrypted: i=1; AJvYcCXHFcK60fAvbwBy73f3CMDibCXPpbBo2J7Pt+fc8DElGPDZAPeNJsdcm0NCEfWJT7gSQvCKJqScR1Um5xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17HHtRyIArEdLbsa8vfdp1EIB/7MhRCXrJyaPUC7/iNEy0ZrK
	85/Osixr/UVu5BpuxlHx5ZWgdISijZwHpIhdHWsKdBu+04DMxPhhnSbesbXbQ7xQ+FZg126k+wG
	hVkoI+8Q6zo/VTMKKWIuu6nzJt+gLke0fRRVb2XkAR49TWnrnqnk5eMGDj+V00+6C42wBR/fMP+
	FsbFHjYtHesvhi349BswwU8LxcuKI7GwXdW/5h
X-Gm-Gg: ASbGncuWVwQSWPePnQJTtrMleBocrOHiXiJiHJwwqQQ5zfGBHuP1TV6hZb+/t8lBd11
	OWw4aLW+vlh11v4S+1+QDr2jorPIZUziu
X-Received: by 2002:a17:90b:4d8f:b0:2ea:b0f9:ff73 with SMTP id 98e67ed59e1d1-2ee093d5f46mr25606407a91.25.1733113313159;
        Sun, 01 Dec 2024 20:21:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKXyYMGmxaU8kARMMowKLrTa9w7H4WpfRpBSe/paz4rHEQfwNjNrrRCMqScBY4D67rx1jdhBOk1f5dA0leBqU=
X-Received: by 2002:a17:90b:4d8f:b0:2ea:b0f9:ff73 with SMTP id
 98e67ed59e1d1-2ee093d5f46mr25606387a91.25.1733113312765; Sun, 01 Dec 2024
 20:21:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202033611.1374-1-yuxue.liu@jaguarmicro.com>
In-Reply-To: <20241202033611.1374-1-yuxue.liu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 2 Dec 2024 12:21:41 +0800
Message-ID: <CACGkMEvf9TS6c9PTiwWn3POr33m7m1shNfHOkviZpk-Pkbf79Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa/vp_vdpa: implement kick_vq_with_data callback
To: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:36=E2=80=AFAM Yuxue Liu yuxue.liu@jaguarmicro.com
<yuxue.liu@jaguarmicro.com> wrote:
>
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
>
> Implement the kick_vq_with_data vDPA callback.
> On kick, we pass the next available data to the hardware by writing it in
> the kick offset.
>
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


