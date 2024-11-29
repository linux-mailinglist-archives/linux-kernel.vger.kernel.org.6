Return-Path: <linux-kernel+bounces-425869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209319DEC07
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B4EB21AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411E219F430;
	Fri, 29 Nov 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iA4qlLUr"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C8273451
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904351; cv=none; b=fPpyCg+SNqZg5abYy1zwMSPwM6o1Wkt3009ST1fNTZpfw1li/TovtZfmE6KZpkZyLbRC5YvEVNWCG28oqa0WHYz0k3t5rcn6VSKnCAMx+lbX0CyQnJm3U7BM4RtnNs9r24DKzIYFkKVQZxPxao+P+LAVHuDB9RgHfUjs5hTXqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904351; c=relaxed/simple;
	bh=9oNuwtDLWeDAIgUyuRKygrEyiqT9jynskTsaYOCbcNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czRFfTfLn0yMatU7mjfCkvJD+TlNsi8IhuRA46e2nSN3MSObYwbN7a78RsrfcM581OZnQeZScHYbebYA6o9+KlbA899RaAVt2HXBg8oEo/BbBT1Uph/XfV+RgX7lHFQ40qccgF2COeo6kyuRGKqQ4+sPkdDhmfLi2PloZ+vhSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iA4qlLUr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720c286bcd6so1862564b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732904349; x=1733509149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PN3EfWs6vxHfOQvNcqaTj9BKkofXEf67LNsJGDX/OqE=;
        b=iA4qlLUrtrGn3ncJAq6T1aJe1iG+nuwuGXnqMVIf7c7NxxnE7vJ/soWycz2bdTreOb
         IppfOZGGf9/ISE70WYx7gNPghHAETfAcyWPqCKKbfP3/d1QAfH/I1yYl/e4SJIy3YLor
         y84EcujeKdRu5H6oHt2ZEtMAjYR/p78nIByok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732904349; x=1733509149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PN3EfWs6vxHfOQvNcqaTj9BKkofXEf67LNsJGDX/OqE=;
        b=eawnxqEwuLUpjVmCIkNDkDgzUbZFdJtqLaJu8XIJv/bZG9pQt3aMeCahzavLUAkzIU
         ExbBd8h9ZrIgHNAD37ezR6IHIAR9ODaUN/tHAEpDW405OullPLpM845K9HHxPuOKJzQB
         QjtEWGoEMUb//pM1CbzGOZo1DMEjUnS3CyxMVPd6VusOOVCVQ+pJIAKRM+3EXXdjqpSv
         A4tz3Ln72mbS+HZr8WM0KR/XVkW75o2dJKrpUXzG87Z3iSMF57e5hfJOdQhxnW0HwwIj
         Q3aW+2qUDGGZzinqH5ycrgBQ8kt3wboBZdJ8YvAIcPQb9SDSAsyNzt6qoUw6IT98yHHS
         sNiw==
X-Forwarded-Encrypted: i=1; AJvYcCUIHUGlMqEsT7merrts1m2p6ZGliGqlp5lKCmXwnwsF0bSmBiKPz+HAUnxVpmkrZc98fTB9e/mcUIvOgEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqoaPMx5ulNatFtcXYalWgl92SDMtFuS4g6sJ2iqM0mAYOEwqA
	6uIsmYvzWqH8VbJfhu7GaIOjH/6D6iD2KpqoNfD+BQstvbFPdzpJkPSr9sBzmB61v8kHg+Wq7NI
	=
X-Gm-Gg: ASbGnctR4dMOzShY0eGKhltwS/ZrMdVnAzalFKHyjShoHLjkk/FchUD1cQEEq01ShIn
	MZrzrs5xMDW7i3WqVb0nLmGoF8QraLy6StAMI795xdaCSdlIEVmX5ofskI+00JHc8vsss0MhSDO
	6F4SP/bR6TgLTrB6UqtMpV58k+M2/o/Fi48mwdeSOKQqM4NsmOPmJrM9lJYxS0JgfoaTzEGQMSs
	qxnX98cVFNJEnmxC9nlA2I/dyjG/bOVhd6NQfRElcBAeVptZv81eAo1fm11PibESkZAEqXK/Ipc
	rYVgUHFVnYvQ
X-Google-Smtp-Source: AGHT+IFyn+lNcogOT7BmuiIX1wcpXMCdwPFeqWb74/OhjpZDs1ojPae2eUeK4CmBYmHusb5P5qqnqw==
X-Received: by 2002:a05:6a00:14d5:b0:724:6f2d:eb0c with SMTP id d2e1a72fcca58-72530013a1fmr15992274b3a.7.1732904349052;
        Fri, 29 Nov 2024 10:19:09 -0800 (PST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com. [209.85.216.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb36asm3751738b3a.116.2024.11.29.10.19.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 10:19:08 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2eade1cad26so1530722a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:19:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsJNHdLvy7iR+vg6iYfMLMt/Fl+xBPN9UhVvmA/nQIWyv15VmjfCQbu1TPM4rWIA5PREQTbkNSbsC8mg4=@vger.kernel.org
X-Received: by 2002:a17:90b:184f:b0:2ea:6d3b:1985 with SMTP id
 98e67ed59e1d1-2ee08eb2205mr16640538a91.15.1732904347777; Fri, 29 Nov 2024
 10:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129151723.48275-1-xndchn@gmail.com>
In-Reply-To: <20241129151723.48275-1-xndchn@gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 19:18:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCsFriCyQuF3aQ+mEeHERcaUPt45ZgVX2Wyfo2T6N3vS3g@mail.gmail.com>
Message-ID: <CANiDSCsFriCyQuF3aQ+mEeHERcaUPt45ZgVX2Wyfo2T6N3vS3g@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Use uvc_query_name in uvc_get_video_ctrl
To: Xiong Nandi <xndchn@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 16:18, Xiong Nandi <xndchn@gmail.com> wrote:
>
> uvc_query_name was introduced to print query name in uvc_query_ctrl.
> So we can also use it in uvc_get_video_ctrl.
>
> Signed-off-by: Xiong Nandi <xndchn@gmail.com>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index e00f38dd07d9..93cacd2c8721 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -297,8 +297,8 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
>                 goto out;
>         } else if (ret != size) {
>                 dev_err(&stream->intf->dev,
> -                       "Failed to query (%u) UVC %s control : %d (exp. %u).\n",
> -                       query, probe ? "probe" : "commit", ret, size);
> +                       "Failed to query (%s) UVC %s control : %d (exp. %u).\n",
> +                       uvc_query_name(query), probe ? "probe" : "commit", ret, size);
nit: This is above 80 characters. Please move size to the next line,
aligned to uvc_query_name

With that change:

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

>                 ret = (ret == -EPROTO) ? -EPROTO : -EIO;
>                 goto out;
>         }
> --
> 2.25.1
>
>


-- 
Ricardo Ribalda

