Return-Path: <linux-kernel+bounces-528900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6BA41D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E9D16D37A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097BE25B678;
	Mon, 24 Feb 2025 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FQKczr3f"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F4257AC8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396242; cv=none; b=o4odwKW0vu/KwLpW/puq+pKR4fKIRagqsSJ5TrQ63IV3oxbF3dSuhgnrrFSZEOAfAkjCLRqRgncmwFXKDkq3gNUBijUcpORKabgig/P+9XbsfxzQR88ezIKSCSAeFNbCokqrRPpQrFiPAcsncp1/NzcDI2Azw84mPEOZsO5tJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396242; c=relaxed/simple;
	bh=iPeqiTBwt5d9EN3jklisbDhamrFjyRdrOW5GFe4pCTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEWRVUj8vDjIok03/THwphHXG7gY5SwOIdtjuw5lhYaD0vdd0aN3OqBxgrucIPCDm4Q1unRBAUq1byiYojEgtumUFn4bzArob+1IthINOC/cAurTccS1lm215cnFty+5GK/n6vIZBzZObdyuT6Cxh92Dw08jZ+aQonyhCMabaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FQKczr3f; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-309311e7b39so38757151fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740396239; x=1741001039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NJDplnyqFeqBd6tbUWmOpX1A3hfk7rDRzMgSUWQoyGo=;
        b=FQKczr3fr4iXc1iJ/k8ATpHaqSz4NgTr31zGSOXVwiQwWPd9/hHhOKsDKtgyk1Bvmf
         mXfJXjBVygb0GeFJTEXU/QNXmRRPFQw186+TV3C91TfPhvjVvw8+FaiPfp9xTHFOzDsa
         fX0bLS1Y0fiedFhhx6XMcPIbgcxsYPrTALGks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740396239; x=1741001039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJDplnyqFeqBd6tbUWmOpX1A3hfk7rDRzMgSUWQoyGo=;
        b=EX2yt453b0DIzVzuH2EFhsH8GISfj+MtO17uiSNySkdEJwvFCXq5LBcRDQQPPpoxmV
         7QCXhVqJgM55EDPwHtcNVEq70OO1iLLYpqA+GCCKpd+3Z6vfzpk8lLli4hHvWwbB9+eb
         TZNW4pYej8aQJyAIUiC7Q2wftH7oRvw5s+Z764TzqSN+haFeobWLHRJ8CVXxzJfQNavV
         d51q+DcEMW0qxGlMLGMfUXBcvauxoWCrtkA7yEjmPuQZ5ocx2BIwpTC22Lt+BgUIKlF9
         BtLjLbF5HTYT7maYc82q6OsoGLVofWuqHrCWz9akBA5F+1nCv2QqH4DBh/QAcMdVfiKE
         NV2g==
X-Forwarded-Encrypted: i=1; AJvYcCWFABwthxQQ19N0kb5kDD0s0BEJfXagZ1mu89AapTdI4YocS03JJU17LNfvAWMx0TxG0DlfHTjdqaWOX9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Yj09fa+Zm2JJtKyXoZkdHRgXKOMGg3AUWhZtSvuJeFpgamkS
	JtL0iZPiC3JsMCJ1I6IHPHt2lhXEGhwmpDgGdOVFudfLkaeVBHeg9EYgrCiCbfVCxnLpbUr11Ew
	zIg==
X-Gm-Gg: ASbGncuyZ7wTBbb9HHvoe0Oyok4pYEzDhcwkg5RnvdMmpx2PR4RC80w+nWI0OOuG8m3
	RYNZbadqLdRI+nhHOLIK8+ZlZOgaJ+53bHs8ElE+d0KGYv0kODKCYCcV9bMpMXn+ctQWag9QAxO
	SlCoa4wdGBFlACbAjMJefYXx0+vYrECNF/1y8x1ZFkEjr+4/5tAIZYcdPnSYK+60irDiB3EaBVs
	XEKvYZoLjwTNgJxSFlVMCNsUS3Pjrh+nwQ8RXnS1NRSlXNeBTDo786wQvaMjHYk7X0WhMApvDA1
	61c8xQ4oEP7wsfrtJJsrswfClmzwdRJ3j6oFfFCdk9sFhqA0j94c5rUNSInKNmD/
X-Google-Smtp-Source: AGHT+IEcGeKQ3+xDA8GVdRBz/DBUzB7aChbSFp2PhmiUpxBBbvvRGv25GPdX9qLTDXoO118svrfSHg==
X-Received: by 2002:a2e:9843:0:b0:307:2aea:5594 with SMTP id 38308e7fff4ca-30a598e5bf3mr42669191fa.18.1740396238687;
        Mon, 24 Feb 2025 03:23:58 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309284a50a0sm30644211fa.72.2025.02.24.03.23.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 03:23:58 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5484fa1401cso128311e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:23:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWv0fszN1G62q89qp1YLgAg87DHzo66Oo+rtp0ctPSoP0jSTfEcvutQ5h8OZvo2E7Y0iui8I8Nd4rBiPb8=@vger.kernel.org
X-Received: by 2002:a05:6512:ba6:b0:545:f70:8aa0 with SMTP id
 2adb3069b0e04-54838f4ed99mr6014303e87.33.1740396237256; Mon, 24 Feb 2025
 03:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-uvc-data-backup-v1-0-77141e439cc3@chromium.org>
 <20241210-uvc-data-backup-v1-2-77141e439cc3@chromium.org> <20250223171005.GC2821@pendragon.ideasonboard.com>
In-Reply-To: <20250223171005.GC2821@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 12:23:44 +0100
X-Gmail-Original-Message-ID: <CANiDSCtRis02keF2GzVFiHk7Pw_RQNqiNG8UzY+zhD=zi8Rmiw@mail.gmail.com>
X-Gm-Features: AWEUYZnyhXAR9z1e-ywMy6jpo_WLcO79wSmtaWlareRW6cezHfwM_iMGslgQe7A
Message-ID: <CANiDSCtRis02keF2GzVFiHk7Pw_RQNqiNG8UzY+zhD=zi8Rmiw@mail.gmail.com>
Subject: Re: [PATCH 2/3] media: uvcvideo: Do not send events for not changed controls
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 18:10, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Tue, Dec 10, 2024 at 10:22:23PM +0000, Ricardo Ribalda wrote:
> > Only send events for controls that have actually changed.
> > E.g.: We are changing entities A, B and C. If we get an error while
> > we change B we do not continue setting C. But the current code sends an
> > event also for C.
>
> Does it ? If uvc_ctrl_commit_entity() fails the 'goto done' statement
> skips over uvc_ctrl_send_events().

I have no idea how that commit message ended up there :).
I mean, the code is correct (I believe), but it does not do what the
commit message says. I guess I was trying something different and
forgot to modify the commit message.

Please check v2. Sorry about that



>
> > Due to the fact that the controls are grouped by entities, and the user
> > might group them in different orders, we cannot send the events at the
> > end, but when we change an entity.
> >
> > Cc: stable@kernel.org
> > Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 7e2fc97c9f43..9496ac970267 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1669,7 +1669,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
> >  }
> >
> >  static void uvc_ctrl_send_events(struct uvc_fh *handle,
> > -     const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
> > +                              struct uvc_entity *entity,
> > +                              const struct v4l2_ext_control *xctrls,
> > +                              unsigned int xctrls_count)
> >  {
> >       struct uvc_control_mapping *mapping;
> >       struct uvc_control *ctrl;
> > @@ -1680,6 +1682,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
> >       for (i = 0; i < xctrls_count; ++i) {
> >               ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
> >
> > +             if (ctrl->entity != entity)
> > +                     continue;
> > +
> >               if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> >                       /* Notification will be sent from an Interrupt event. */
> >                       continue;
> > @@ -1911,11 +1916,12 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
> >                                       uvc_ctrl_find_ctrl_idx(entity, ctrls,
> >                                                              err_ctrl);
> >                       goto done;
> > +             } else if (ret > 0 && !rollback) {
> > +                     uvc_ctrl_send_events(handle, entity,
> > +                                          ctrls->controls, ctrls->count);
> >               }
> >       }
> >
> > -     if (!rollback)
> > -             uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
> >  done:
> >       mutex_unlock(&chain->ctrl_mutex);
> >       return ret < 0 ? ret : 0;
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

