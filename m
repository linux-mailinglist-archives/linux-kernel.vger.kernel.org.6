Return-Path: <linux-kernel+bounces-326023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358F597616B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50642813F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C86C18A6C7;
	Thu, 12 Sep 2024 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="br3BBNDd"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67912D20D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122113; cv=none; b=mQGZgaA5An9PU5am5Rmz688JSWbcXXnfDa3EySC4I9t5cvKhlxIKzSyhXfVag+k886lLzpJRVRQGlp521YZzHiXnIbsFgqomkLVIYCMXmi3sFza/YuVVuwrlfCcevSTk4gMoTTSOmtspgPHzBUd+lTkphKF3LybGuYHghXlb3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122113; c=relaxed/simple;
	bh=CrwR//yFSz/4I6cU+3/T4abhqdFCLi0bEC2I1F0DoHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWZrZfYi5mA+k/1tdhYEFJ/zoeJ9w7nxNRzOiINvo8lLL0J1eQngIBduCYxO6/5KwL3AmMMlRjqyBFaAvMNkoVb/ssYC6pHkxJQKg9n8eSAb4PTI3lUQ6nGBc9BrNioihz88nvB1fdhmv9YwpuQYdgXhAsH/A+iKkz6qmnAkTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=br3BBNDd; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6dbb24ee2ebso5596817b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726122111; x=1726726911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=usfX/wz/mLaRXfuAcPGHUFxV9u21Gw4K+EicoC3EILw=;
        b=br3BBNDdH0qw1s7QU8k5VjwEi5KdXRgAr6IS3N2DWs8hCqLKA8FbVQ2JBVqxTLGHB3
         nz6NiFet6eULUB7uZHQ0lilzc0mAbGeAGiTgB9vc8c57AyBrUhd53qqSSfMKXLjnY0Qv
         hMLSOgoVqBIEQ9F19Xdfjk0CQtm/F0PDJCeKiUfyVPY3ufWnDSRp/z8K4yg+m/xoYa9d
         n2EGlDTboc0G9zabDZ4Q3gFd0DaTPR5iCBT5LNFbbrLTU5Lypq5hf7Agr9mhtco2o6dD
         WoH11hbqBpKeUW3wT42nc7m/or7I5g/l2mAqjJrJTqJbcwYUF6/BjtQksOwx4AwlSun+
         FMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726122111; x=1726726911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usfX/wz/mLaRXfuAcPGHUFxV9u21Gw4K+EicoC3EILw=;
        b=YugMK+5+TRCpZJe8PkwVeD632MsJcfK/MTSmi34cEfRqtSBK6ZRRkp24wa/10z09hd
         F9MbBe6h/JkFp5Fjf/3XjOwi4hbjH4oLiy1z+nDtYZp2eqbARd6ZaehdySUhRm1F8war
         i+8WSRFFJPF+IXxBEyeiKSEQuIVcNuTLmL1THORv/PGXhY89mgDfG1ztdSy0x2/v69aS
         bVwS2rMqLtTrhuOtf9WuJYi7Oc85yBLzlGI84G6T4WyOGbQK6KO4uCMUSfylhXTI4hP4
         OlgBhAqjeQnQbSyOyVMqPCYN12EVI19AUIlTX1YgFHRIFjyqX4YBvUmWoP6PRruJmvz2
         b8hg==
X-Forwarded-Encrypted: i=1; AJvYcCUdQrhfx4GTvS4+C/2dRVOvRyDTPwCY/00YX245iwQyuN8zFh40DBc2raoPilby5n5NCIVMd8oonOZG1XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgXiUbW5naaRctdpIbVtIdPdGbt4gJX71aGB3phULYKHCsdL9
	xeb4rsnpJJ0RGygHMMdvHscn8JC+p3hzvc3GjT+biRZ/Z1CMYvJnxc2mx+z2vpRugN7I/kniG0l
	+vRLW0SQ2s65pT7SNB4t92nIx9LpkeolWWAjRJw==
X-Google-Smtp-Source: AGHT+IF3Z3qQ5UqavDaqrpr39FgpUHru2lLyO42gp51F97e/+37wgcOz5KTxTAPvnN2H1oLc18hy+rXT1fuivPSmYZA=
X-Received: by 2002:a05:690c:30f:b0:6d5:6719:4d80 with SMTP id
 00721157ae682-6dbb6b8f7e0mr17367037b3.31.1726122110797; Wed, 11 Sep 2024
 23:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906065853.637205-1-lk@c--e.de> <2024091156-astronomy-licorice-5569@gregkh>
 <ZuKFetxhrQY1L5fQ@cae.in-ulm.de>
In-Reply-To: <ZuKFetxhrQY1L5fQ@cae.in-ulm.de>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 12 Sep 2024 09:21:39 +0300
Message-ID: <CAA8EJpp3KMkZc3pArrgLcue-GbqLQjeOZ+9XWQDL0NeJxnfR+g@mail.gmail.com>
Subject: Re: [PATCH v4] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Anurag Bijea <icaliberdev@gmail.com>, 
	Christian Heusel <christian@heusel.eu>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Jameson Thies <jthies@google.com>, Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 09:08, Christian A. Ehrhardt <lk@c--e.de> wrote:
>
>
> Hi,
>
> On Wed, Sep 11, 2024 at 03:37:25PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Sep 06, 2024 at 08:58:53AM +0200, Christian A. Ehrhardt wrote:
> > > If the busy indicator is set, all other fields in CCI should be
> > > clear according to the spec. However, some UCSI implementations do
> > > not follow this rule and report bogus data in CCI along with the
> > > busy indicator. Ignore the contents of CCI if the busy indicator is
> > > set.
> > >
> > > If a command timeout is hit it is possible that the EVENT_PENDING
> > > bit is cleared while connector work is still scheduled which can
> > > cause the EVENT_PENDING bit to go out of sync with scheduled connector
> > > work. Check and set the EVENT_PENDING bit on entry to
> > > ucsi_handle_connector_change() to fix this.
> > >
> > > Finally, check UCSI_CCI_BUSY before the return code of ->sync_control.
> > > This ensures that the command is cancelled even if ->sync_control
> > > returns an error (most likely -ETIMEDOUT).
> > >
> > > Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> > > Bisected-by: Christian Heusel <christian@heusel.eu>
> > > Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> > > Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > > ---
> > >  drivers/usb/typec/ucsi/ucsi.c | 18 ++++++++++++------
> > >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > Does not apply to my usb-next branch :(
> >
> > Can you rebase and resend this?  Or wait until -rc1 is out and rebase
> > and resend then?
>
> I sent a v5 rebased onto usb-next.

Note, it wasn't marked as v5, it didn't contain a changelog, etc.
Please consider using the `b4` tool to send patches. It automates
versioning, changelog generation, etc.

>
> Best regards,
> Christian



-- 
With best wishes
Dmitry

