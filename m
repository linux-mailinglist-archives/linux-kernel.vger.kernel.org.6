Return-Path: <linux-kernel+bounces-424661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC789DB7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E83BB2126F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B419DFA5;
	Thu, 28 Nov 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="V5smVwJr"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122219D8A7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797104; cv=none; b=tsNw+tFwRwdUbsFGx+rgOaZLmfNcHzNsp/kdtb8Ssm19JfPkjTBkbOSCd2+o4t7yXsEZGguezcS0lr6j9xe2O1gZI0+LF5qoXU22oKVPaHOAypKz7vuZqCMzsXZ8sfHqcVxDurfjX8l1SnODgDzeKnBbIE0VqG+qpp+EnLccpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797104; c=relaxed/simple;
	bh=iYQoZNHZYvu4ako70Ag18jWmbu6070AIJp0pvQOIGuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gib4q/WG6LbjkwNiLwTbZ5EW4nrMFn5s4ga01mCNP9797+N9x+4B7gl4phHkNpT7nzXjf52JCNQRi1THpOhaO4VV07aBJyjPNlzWgOWgWxqzPgZyKBTsnIXZvNmcvVr0upAdTrBCA4W2U1vzSG6uUxXHcZnBJCHHw2hllumBNIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=V5smVwJr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa560a65fd6so144134366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732797101; x=1733401901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpoemVatfaaeXNkbkmZa/3Of/FndPg8UClILORZPzNY=;
        b=V5smVwJriKUnfQiJkXCkwWlqW6VruFh1QWXa1hBjhcuWy4KSxMx0+FHYGToGF+0ZNY
         PK25dnLsfll70gUrAPUNUSkg8h04T/giICSTBmm2KKmkpyPhKql+6m9KVnLftKuR2Ou7
         kwBBYE9S3I0CEuVd032fCBbsEszt/YPJCtgojcbx4NDjwckx2POZWRIZ7XkV491vE3qK
         +x8dDYuiCU2sTf4p0AzR9jix/nZUzFwlgRxvBFqyzmc72zhuOczKrs9Gtk4YFEvre03E
         Kf+viVYmb39oLFx+x/2K+/CEPLzPQURKCAER0uMIB0071mhpHh0VvBdqYJUZjFRmWBEn
         YKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732797101; x=1733401901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpoemVatfaaeXNkbkmZa/3Of/FndPg8UClILORZPzNY=;
        b=G35XtIMKcqkwMJnFgCTsYcbTIy6a6odevbehwOrQtk4nD6T8xwQLt7rMOOKvipqeQD
         nUc1ZSzvLQnHYemEbs12zAXrJsvFD6EuIU9m1HvN318V/NWNiZ7/DEbLKSOkuViaDXt6
         Xya+nr4zq0PEAz195cw65a4Io+PaeWfON/Q99B3iMUUbMzZXvWhSJZh/gI2Ll4PjU485
         LonBlTBwbpgDERBVZp4pv74vX2yXSydu6IFJxTFpkBxiq+Ou21dSNVEORZgUtlhq96J/
         24KxzjzMziy1eL2lCr8clR724Ryr/DrOsNBU8JpU/7M9Dlt6ClObm6eR9ZBipPpwI0KP
         3atQ==
X-Forwarded-Encrypted: i=1; AJvYcCVij6/6jkerwPVvigEg3HjDOT1aNhKOs1ix8K/vDChlfG/bnl+J07AJU6aOmRmbjV2MEI+dIxray8IpQ60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc5itcGjrIXq0600WJscH6rcw/YsbThnRCH2UiKl1GLvXPPZVH
	XKOKBnyfrnptPH4YBrOkkBDNafj0ItjVo6HCftFn3qjkcGSkES/k/FuUU+sSI57kYBytRcBiynX
	YdamwOclIR6mH36b7KQga9H26d3VOD3cuYnMSbA==
X-Gm-Gg: ASbGnct+exttTMQ/2HXtbfEnPEFx+eT1ATZe3uyZsgVuTvnKa5CRW80i/GaFGhjGTgc
	cNnpuQ7pR2/97/2c7OneEG7OMUGztk1Ua2TLNBBAxF2ypw03cFR0w1//U9+zd
X-Google-Smtp-Source: AGHT+IG/PJy6jtkMD93q3vrdJc5oVLajZQBh1b3v2P+6oDKVmYlQzPR4JSl6ULCxWrxgGCHo6jToM+TuxfktaXdeQ6s=
X-Received: by 2002:a17:907:7615:b0:aa5:358c:73af with SMTP id
 a640c23a62f3a-aa5945075fdmr348570766b.6.1732797095349; Thu, 28 Nov 2024
 04:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com> <CAKPOu+-Xa37qO1oQQtmLbZ34-KHckMmOumpf9n4ewnHr6YyZoQ@mail.gmail.com>
In-Reply-To: <CAKPOu+-Xa37qO1oQQtmLbZ34-KHckMmOumpf9n4ewnHr6YyZoQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Nov 2024 13:31:24 +0100
Message-ID: <CAKPOu+9H+NGa44_p4DDw3H=kWfi-zANN_wb3OtsQScjDGmecyQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:28=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > Pages are freed in `ceph_osdc_put_request`, trying to release them
> > this way will end badly.
>
> I don't get it. If this ends badly, why does the other
> ceph_release_page_vector() call after ceph_osdc_put_request() in that
> function not end badly?

Look at this piece:

        osd_req_op_extent_osd_data_pages(req, 0, pages, read_len,
                         offset_in_page(read_off),
                         false, false);

The last parameter is "own_pages". Ownership of these pages is NOT
transferred to the osdc request, therefore ceph_osdc_put_request()
will NOT free them, and this is really a leak bug and my patch fixes
it.

I just saw this piece of code for the first time, I have no idea. What
am I missing?

