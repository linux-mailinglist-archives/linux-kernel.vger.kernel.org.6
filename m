Return-Path: <linux-kernel+bounces-557115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2378A5D3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A93E3B7D00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37A213635C;
	Wed, 12 Mar 2025 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=one-eyed-alien.net header.i=@one-eyed-alien.net header.b="o6io00gU"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0980034
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741741759; cv=none; b=p+fB9GgYG5w/s+jX/y/X7g+Lu91V/W9KIhPsAU/w873LBQOZUCv3mA92CcPVQWXcUho19R67vM+8435qfgQ3tiMdd9K6I383spGCRRhBZQ/tsc0niuNZiBLpU7wKUtZ1Q3KBBdoZ6S8yp3JIA2SXmT0uirQOSJN2rPLWiQ6wAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741741759; c=relaxed/simple;
	bh=8v10IauO9+ZYWShfiIg8lWU0cAyNhQMaXPvPDC9VdPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4GACNokIgh1ZB+DrMF2JmMERS/e1WzH9F+T1vRn1x8NSFL4FN5lmhPUMKEZnwmt6VOc8wJTIs4580ry+WpysxSWufp1UVobsopCcOwGVD/TnrSMXAQE8htOOKgtVgUQw8juXUs1EWIXbbzbpFfnNdkqBCC012D247Alz74rdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=one-eyed-alien.net; spf=pass smtp.mailfrom=one-eyed-alien.net; dkim=pass (1024-bit key) header.d=one-eyed-alien.net header.i=@one-eyed-alien.net header.b=o6io00gU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=one-eyed-alien.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=one-eyed-alien.net
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso18371805e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=one-eyed-alien.net; s=google; t=1741741753; x=1742346553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA1s+CFJcoptHGHTr4whY7uZy+Mb8KOq82ve4XvNd6U=;
        b=o6io00gUxRHmtE7NO/pMvwq/rJ2XppfTXupRns3Fs2A9g5ug/HR5bIXfrKiErix2T3
         Upnx1WWjESXB1wuQ6YXs3jeqeJzyWL1f7ZPp8zncwxzo0b3r8ysoxskiqOfaiOzHHw7e
         RNXkS2V4bwurkLqUUE4n0wJYtyknxiB4xWQSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741741753; x=1742346553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA1s+CFJcoptHGHTr4whY7uZy+Mb8KOq82ve4XvNd6U=;
        b=eHLBsdH6gAxR2LYjs8Lp3DDm3d1zeIwQrPbARHaWk5Ol9hziY9dnLObA/YzC+/UXZk
         uxGVyHpcsIBLu1qm0x2Ah/LQ+86WqpKFN3mXng11y52tG0GIe0OzTclKfqn2jZ1CBUwD
         pU6M+zR9lfL+i3kuPhlPdrSZgtEsW3Zl1INhHoK14mlvv87ArxgYRme36gL/KLEhDU49
         +SgcJ0mP6eoXUQQGfkQua/s7x4V9GeAF06gQAn7s8O4mTXK8di24XI3nz2gUM7bLqdV4
         NoyDhrU4EcVTD2VGMnIXTp/1rFCeIAuNzS926E2QqBOOv14vMv2gDVeoh+/f+8IURCpT
         aE+w==
X-Forwarded-Encrypted: i=1; AJvYcCUuqzXRnO+oxIaSQOXaTzbtMaoFMCY6o7+0A2xIwkUR+Cyxg6yHyYoQKSJwckmTGQc3E0L2Wvv2IbKBh9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMjkXlbHVdDkRazFcaZY9r7ZME/NmoLsxglZ2a5LPnljCN4D0
	tQDtTjUHlfkgWGBIbRZJ5XNKmXj8vfb5cE5jBbXbHFRIaz/5/UAZqYoHeSIlpJI5iJtdxGKIdcK
	HvVQs1gk218z19tA+Y26MdMb9YcbgO46kRkuLmQ==
X-Gm-Gg: ASbGnctq++e3xwE88U77vEQ7YqNT7eDXy7/hludF1TvP+IN+3BG5MvJTCaV3nWuU3eQ
	uiVerU+tOYNiiZyoP8qFzFUC6nm8ga7gb5+8Y3JOQkGdDI1c0OjUdJpfLl55gOqsEG7u9/tPwTa
	XuMWDsAbt0H7Grdh658lsLjU4=
X-Google-Smtp-Source: AGHT+IEzF0ireum6/FPbkjs402SHBM0UMUqmkV5EVVKUF1OpBtqyx/4FZi728uAGKSmhUDjUErnfEpjvsDzmXXOOq/s=
X-Received: by 2002:a05:600c:198e:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-43d01b85209mr71117685e9.0.1741741753407; Tue, 11 Mar 2025
 18:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311084111.322351-1-daixin_tkzc@163.com> <6a266eb7-0150-43e9-a712-b9e6fe8c71ea@rowland.harvard.edu>
In-Reply-To: <6a266eb7-0150-43e9-a712-b9e6fe8c71ea@rowland.harvard.edu>
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Date: Tue, 11 Mar 2025 18:09:02 -0700
X-Gm-Features: AQ5f1JrKnODlP4cRLeJ-QLQyz0b3tuL4cGZxHXaD9UPY5m6VAbrBbZF7y7QAN1A
Message-ID: <CAA6KcBDjRPjrfQpYYHtqc6tnpFoLz9QAESqkaOLK5Hi1HbpQHw@mail.gmail.com>
Subject: Re: [usb-storage] Re: [PATCH] usb: storage: Fix `us->iobuf` size for
 BOT transmission to prevent memory overflow
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Xin Dai <daixin_tkzc@163.com>, linux-usb@vger.kernel.org, 
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:12=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Tue, Mar 11, 2025 at 04:41:11PM +0800, Xin Dai wrote:
> > When the DWC2 controller detects a packet Babble Error, where a device
> > transmits more data over USB than the host controller anticipates for a
> > transaction. It follows this process:
> >
> There is no risk of memory overflow.  The length of the transfer for the
> CSW is limited to US_BULK_CS_WRAP_LEN, which is 13.  And the length of a
> CBW transfer is limited to US_BULK_CB_WRAP_LEN, which is 31 (or to 32
> if the US_FL_BULK32 quirk flag is set).  Therefore a 64-byte buffer is
> more than enough.

There is no risk of memory overflow *unless* the DWC controller
doesn't respect the buffer length as given in the URB.  If there is an
overflow issue here, it is an issue with the controller level.
Matt


--=20
Matthew Dharm
Former Maintainer, USB Mass Storage driver for Linux

