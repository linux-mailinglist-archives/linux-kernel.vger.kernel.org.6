Return-Path: <linux-kernel+bounces-233703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7824191BBC2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CB01F22B16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E63D15278D;
	Fri, 28 Jun 2024 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="LTCzbc02"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3953D13FD9C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567818; cv=none; b=hnuf4b/yHu3TsPRYMHo4DyYxx6V/kUBAnmsxftyHT3BFXBSlRWGn1WhyAPcvz/Ph587hKsaijHSFkqe6soqPNiD1SK215Guq1dh6ZR51hGst9ebzXbp7JM5CQseqMbTKe1DegZAF4wMcBXnkjxj9GQF2V/j7EKIv31IYmYMcX98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567818; c=relaxed/simple;
	bh=8qzmRAVdcytlDvjKg3zIzhlsAspcHn166tJNqg286RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKnQ7lYPuZel9aSTXyD3lAPXWOSnl/WZMZEKJoekwAVVQJgj0wE6AD6CgPa5dhScIp9soRGkfMecUjfafNDeEUPE+8x5q+qhKe7nycigFy6eaeiTM93HKhg4HQSEzylmbp0RvRY1R/uavUt0T842sdWQbDrkNWGj5SJvEJiVkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=LTCzbc02; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64b101294c0so3057827b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1719567815; x=1720172615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qzmRAVdcytlDvjKg3zIzhlsAspcHn166tJNqg286RQ=;
        b=LTCzbc025NvpfeQvoNQBCYmCva6h+vhempma25LkBYT0L+nFkKfn2sR026CBn3+g9M
         y7rc5FZNOSEVWWduIf/p7umNkLLBbDQ+3dvHkY9ksCRUdPGqPp4JJ9Vn9sm17Am2vvDs
         Ct8/BP38eOEfk9CfK6R8bdowfOMvkCxcLikl95Lmi2U483q3A4mv1Z6yyJyvJFLxBnOV
         5CNytJeOcGzhFMa9Ufz6ehyUl3Jw75TcsgIsRX/3G1nGVPnv2DvhfbSD0RJxlMOo5wso
         btXueR8fxxrKzNRIiztovKH22yzY7pcfYt8qUN0Gm2GHqC3Lo4T1fGspptOjVKV6itnZ
         q6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567815; x=1720172615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qzmRAVdcytlDvjKg3zIzhlsAspcHn166tJNqg286RQ=;
        b=iKpmJqNzGihoPwMP/560W39JCeRU6TX7Cf/yIefhoHcF/HIoqm188NGbHeX3FBUbjQ
         S9fEkfUfpS/jJd6qdnfv+mZF/z8bGKfx+BJ638fwtSoqeIZFgUHkLBersh2/OEpFjz1X
         DBHzwA4a6kOkMVsMjZxIG7KaMj1C/2kvZMjY47untbMa7GLe39EpfDrudiMZcN2r3NeR
         X6E1k1utulgUNS7PwS7QiAEolRTWKhtQGHmsC12v5kgCSXfTN7bze0wAVONjUegq9lFr
         1Zhqu+V2mb1kPt9sYaAGDaCEKgR9zPm9XQaPQw38FBVY3Er1ce/6rxzXLkNu06GRomys
         pAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpp/eQ9Yh0hLPg3erIthn1i95wFGwR1DCfNLhOLtfhBRQuz6npXpX8vGN1t8HCgc3LbmjvvTOUxHoYBBd2k0FpV2Ze/fWH5NnunMCl
X-Gm-Message-State: AOJu0YydlxqcDIeDEcgcxLz7ry6Cv1bAtB1wenpRqRMUI3lS7Fm6nGYW
	sCoMkqFCJcREdqoXTPWOaXU3cPf2HiguoinbGQIWehd3e2FjL/HGtkq7zH3ZH4+K7Z7RH/5SWwd
	fSHE=
X-Google-Smtp-Source: AGHT+IGjxw6hijZQcPBkWii0JIEvlWc1PO0VmNQL1LjNsF09X9r4CgchAJ+2VqDZXbM2AeHn6IQMpQ==
X-Received: by 2002:a81:9282:0:b0:64a:9fc7:3b1a with SMTP id 00721157ae682-64a9fc73e27mr19564817b3.33.1719567815030;
        Fri, 28 Jun 2024 02:43:35 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9ba5a8e1sm2728267b3.93.2024.06.28.02.43.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 02:43:34 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfef5980a69so407517276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:43:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVC8ZmyIuk50PNDhEwX7p9rm+qWAZZ1z9tO6KN6vpe27OMgOqQzVarzuzCVoJVCERFAoWs3fxpUTUdB/IIAxbn+qRPDUBPgTVc++Pqb
X-Received: by 2002:a25:b183:0:b0:e03:5edd:99b5 with SMTP id
 3f1490d57ef6-e035edd9b77mr753201276.4.1719567813979; Fri, 28 Jun 2024
 02:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <97eadcba7cabe56f0f4b4d753bd3d53f8540ef4b.camel@pengutronix.de>
 <CAAObsKAQ=pWQ8MR1W7WwK1nVEeiCFNC3k+NZKsu4Fkts-_+zWg@mail.gmail.com>
 <CAPj87rO7zyDsqUWnkF0pZeNFnNK2UnAVJy4RmB3jmPkKQ+zbEw@mail.gmail.com>
 <CAAObsKBm3D_3ctFyK-rfpM-PU6ox1yoaMA1EES9yR-nRmU4rYw@mail.gmail.com>
 <CAAObsKAt563VNzDcF4rGkWPcxBPzKcq=Hj5RY6K20FWR43nvUQ@mail.gmail.com>
 <ZnvDJVeT3rz-hnv9@phenom.ffwll.local> <7cee6b78bc2375d9b014f9671b0d72ae65eba73c.camel@pengutronix.de>
 <CAPj87rPB=N2vJ-5C7xXORYstK3=TpX+jZ7mCr7oxY2wpXeaTTQ@mail.gmail.com>
 <ZnxVWrFJKbVO8PZ0@phenom.ffwll.local> <CAPj87rPnA1eKR_b7gAhDiMZRcVt8xPS9xnsscqVQ_a_qO_tD4A@mail.gmail.com>
In-Reply-To: <CAPj87rPnA1eKR_b7gAhDiMZRcVt8xPS9xnsscqVQ_a_qO_tD4A@mail.gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 28 Jun 2024 11:43:23 +0200
X-Gmail-Original-Message-ID: <CAAObsKATM0hQ=XTzTTucArBzSnVEu-CfdkUU4c6UVHd1+G5-gw@mail.gmail.com>
Message-ID: <CAAObsKATM0hQ=XTzTTucArBzSnVEu-CfdkUU4c6UVHd1+G5-gw@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
To: Daniel Stone <daniel@fooishbar.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Oded Gabbay <ogabbay@kernel.org>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Daniel Stone <daniels@collabora.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 9:26=E2=80=AFPM Daniel Stone <daniel@fooishbar.org>=
 wrote:
>
> On Wed, 26 Jun 2024 at 18:52, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Wed, Jun 26, 2024 at 11:39:01AM +0100, Daniel Stone wrote:
> > > On Wed, 26 Jun 2024 at 09:28, Lucas Stach <l.stach@pengutronix.de> wr=
ote:
> > > > So we are kind of stuck here between breaking one or the other use-
> > > > case. I'm leaning heavily into the direction of just fixing Mesa, s=
o we
> > > > can specify the type of screen we need at creation time to avoid th=
e
> > > > renderonly issue, porting this change as far back as reasonably
> > > > possible and file old userspace into shit-happens.
> > >
> > > Yeah, honestly this sounds like the best solution to me too.
> >
> > Yeah mesa sounds kinda broken here ...
> >
> > What might work in the kernel is if you publish a fake 3d engine that's
> > too new for broken mesa, if that's enough to make it fail to bind? And =
if
> > mesa still happily binds against that, then yeah it's probably too brok=
en
> > and we need etnaviv-v2 (as a drm driver uapi name, I think that's what
> > mesa filters?) for anything new (including the NN-only ones).
> >
> > I would still try to avoid that, but just in case someone screams about
> > regressions.

Thanks everybody for chiming in.

> It's not just etnaviv, it's literally every Mesa driver which works
> with decoupled render/display. So that would be etnaviv-v2,
> panfrost-v2, panthor-v2, v3d-v2, powervr-v2, ... albeit those don't
> tend to have multiple instances.

TBH, I think VeriSilicon is the only IP vendor that has recycled a
render-only IP into a compute-only IP.

That is why I liked the approach of conditionally creating an accel
node, as it neatly reflects that reality.

> Anyway, I'm still leaning towards the answer being: this is not an
> etnaviv regression caused by NPU, it's a longstanding generic Mesa
> issue for which the answer is to fix the known fragility.

My understanding of the consensus so far is that Mesa should be fixed
so that Gallium drivers can fail at screen init if the device doesn't
support some new usage flags that we would be adding.

If for some reason that doesn't work, we would be looking at having
etnaviv use a different kind of driver name, such as etnaviv-npu or
etnaviv-compute.

Did I get it right?

Thanks,

Tomeu

