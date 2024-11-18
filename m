Return-Path: <linux-kernel+bounces-413262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE59D168E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC00B28F26
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5393B1C07C4;
	Mon, 18 Nov 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gi4e7kLa"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5941BD9F0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949087; cv=none; b=dlPJBelTHep/g+lk7Dqt5AhgwimFDUTzH32HSWe+k0/8UBFQpQu3lteV2Qw4qispenewaG3NrL+87IhUjKjNWz3yLDOKKlB8GVMTvzEIpwHEY4sL3ImrSog9+aB7XYewChqcYNtGZRMfzCLFeo17ckSopgIIdos6BWcXvW5y4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949087; c=relaxed/simple;
	bh=b+qjRPJJgFh/DH2mn8cdZ+TY0xPgQ1QeLHwseux++Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyGdHWoIwqrhSm6cLLPjXfHRKOxeomNsTqL8CTTUXzXuI1FQ84WGMbgb0pIByApa4YzjZIzcvaJfGlmCTOxGD91WpEz/zFfCzPwmTsdvjq3rg/ZHCW9iRayr0soYCClacA7dHgKssb6okv+RndhgPxzR2nDtF0+hYocgg1IfuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gi4e7kLa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21207f0d949so17846795ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731949085; x=1732553885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M67tOapBFVJdyFLK/dKrm6uvvMAbWzWdqgLPM/DLv6o=;
        b=gi4e7kLaucGzLNNAjqxFpxvtpV97N4rkAi415MnYbVkHbfSQZPx0BOO9wtohlQYxFK
         ZRLE45soaabRl0xmp/sFnycB4qPxSk6j9Hlu0hY2e93drRClY+CUgGfjeLaD6Jumek9+
         d5NqfzzY2A2/7VKvpVO6gD3hn2VtFxnUNyiqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949085; x=1732553885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M67tOapBFVJdyFLK/dKrm6uvvMAbWzWdqgLPM/DLv6o=;
        b=YxJdngYEj2Ze9Zf+kg88Psot0Yi+6rEVbg/E9Bb6yV50ZUU1LTpKlVvqaIHZFyAFqV
         X0hODknriL7lt3jcbeVVi1Hf6/zrOCpChtIKXxub2WkFLtGf65cBZF0Sa9sNjvxGZ3jU
         Zp+RVFdbbG7fTT4CSFV9bb2XlHP+FrF94H/sZdeDSfj4yYthkqFmZCMwO99CAtJ6nOm9
         weZv7KNKA6lLGufc4WwUS9AQL+yePa32UAGtMcomjIvv52nwz5f0PGmWOY1YjZpfRNsK
         oJkQF1L63gbWzzQCzFoOWAoUzPDZP6x3lZNHZA+qWRPzQkVQqoDKeh625IoCK5jvhcl8
         Dccw==
X-Forwarded-Encrypted: i=1; AJvYcCUHXb25xh9NGY5EVnTsfZYTEGRo2tBl444VhAbEyIwOmL/7XWbpz1v5+WN2jtNipn0LnLbvcPE05MKRJdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TV7TQdhRlW/VTt54uY2IUSUG0AEvupPKDhfsH4QswoV2wynp
	dk+uk1BEDnoKpNbcUTzQ14HR6McIKTlmhJbkUafeLCMO5nVw94pUiDSmWctI+uKlp5hIjhC3lPo
	=
X-Google-Smtp-Source: AGHT+IGjeuc308HXW8Rym7WcEoOGrX6ERwztTwGD0WpaZFHjLvo8j/pSaxoeYJ28XFntZckEINkvzg==
X-Received: by 2002:a17:902:c406:b0:20c:8cc4:cf2c with SMTP id d9443c01a7336-211d0d6f55emr185961625ad.10.1731949084683;
        Mon, 18 Nov 2024 08:58:04 -0800 (PST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211f8abb052sm40010165ad.255.2024.11.18.08.58.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 08:58:03 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7246c8c9b1cso1609668b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:58:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXG9MDjjFe0CswFAIlvQjGTpfZ0wn+l6Tw5Ezq73UpH6iG1BKEdrBk4xao33ERnsl2XmMQdtMrWGDGzUeA=@vger.kernel.org
X-Received: by 2002:a05:6a00:1902:b0:724:6bac:1003 with SMTP id
 d2e1a72fcca58-7247709df42mr18330165b3a.24.1731949082889; Mon, 18 Nov 2024
 08:58:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org>
 <20241008-uvc-readless-v2-1-04d9d51aee56@chromium.org> <5a5de76c-31a4-47af-bd31-b3a09b411663@redhat.com>
In-Reply-To: <5a5de76c-31a4-47af-bd31-b3a09b411663@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Nov 2024 17:57:49 +0100
X-Gmail-Original-Message-ID: <CANiDSCtXfdCT=-56m9crxW6hmVjuqBKvRE3NRQBf7nftW=OpNg@mail.gmail.com>
Message-ID: <CANiDSCtXfdCT=-56m9crxW6hmVjuqBKvRE3NRQBf7nftW=OpNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: uvcvideo: Support partial control reads
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 17:41, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ricardo,
>
> Thank you for your patch.
>
> On 8-Oct-24 5:00 PM, Ricardo Ribalda wrote:
> > Some cameras, like the ELMO MX-P3, do not return all the bytes
> > requested from a control if it can fit in less bytes.
> > Eg: Returning 0xab instead of 0x00ab.
> > usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
> >
> > Extend the returned value from the camera and return it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index cd9c29532fb0..f125b3ba50f2 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -76,14 +76,29 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> >
> >       ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
> >                               UVC_CTRL_CONTROL_TIMEOUT);
> > -     if (likely(ret == size))
> > +     if (ret > 0) {
> > +             if (size == ret)
> > +                     return 0;
> > +
> > +             /*
> > +              * In UVC the data is represented in little-endian by default.
> > +              * Some devices return shorter control packages that expected
> > +              * for GET_DEF/MAX/MIN if the return value can fit in less
> > +              * bytes.
>
> What about GET_CUR/GET_RES ? are those not affected?
>
> And if it is not affected should we limit this special handling to
> GET_DEF/MAX/MIN ?

I have only seen it with GET_DEF, but I would not be surprised if it
happens for all of them.

before:
a763b9fb58be ("media: uvcvideo: Do not return positive errors in
uvc_query_ctrl()")
We were applying the quirk to all the call types, so I'd rather keep
the old behaviour.

The extra logging will help us find bugs (if any).

Let me fix the doc.

>
>
> > +              * Zero all the bytes that the device have not written.
> > +              */
> > +             memset(data + ret, 0, size - ret);
>
> So your new work around automatically applies to all UVC devices which
> gives us a short return. I think that is both good and bad at the same
> time. Good because it avoids the need to add quirks. Bad because what
> if we get a short return for another reason.
>
> You do warn on the short return. So if we get bugs due to hitting the short
> return for another reason the warning will be i the logs.
>
> So all in all think the good outways the bad.
>
> So yes this seems like a good solution.
>
> > +             dev_warn(&dev->udev->dev,
> > +                      "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> > +                      uvc_query_name(query), cs, unit, ret, size);
>
> I do wonder if we need to use dev_warn_ratelimited()
> or dev_warn_once() here though.
>
> If this only impacts GET_DEF/MAX/MIN we will only hit this
> once per ctrl, after which the cache will be populated.
>
> But if GET_CUR is also affected then userspace can trigger
> this warning. So in that case I think we really should use
> dev_warn_once() or have a flag per ctrl to track this
> and only warn once per ctrl if we want to know which
> ctrls exactly are buggy.

Let me use dev_warn_once()

>
> What we really do not want is userspace repeatedly calling
> VIDIOC_G_CTRL / VIDIOC_G_EXT_CTRLS resulting in a message
> in dmesg every call.
>
> >               return 0;
> > +     }
> >
> >       if (ret != -EPIPE) {
> >               dev_err(&dev->udev->dev,
> >                       "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
> >                       uvc_query_name(query), cs, unit, ret, size);
> > -             return ret < 0 ? ret : -EPIPE;
> > +             return ret ? ret : -EPIPE;
>
> It took me a minute to wrap my brain around this and even
> though I now understand this change I do not like it.
>
> There is no need to optimize an error-handling path like this
> and IMHO the original code is much easier to read:
>
>                 return ret < 0 ? ret : -ESOMETHING;
>
> is a well known pattern to check results from functions which
> return a negative errno, or the amount of bytes read, combined
> with an earlier success check for ret == amount-expected .
>
> By changing this to:
>
>                 return ret ? ret : -EPIPE;
>
> You are breaking the pattern recognition people familiar with
> this kinda code have and IMHO this is not necessary.
>
> Also not changing this reduces the patch-size / avoids code-churn
> which also is a good thing.
>
> Please drop this part of the patch.
ack
>
> Regards,
>
> Hans
>
>


-- 
Ricardo Ribalda

