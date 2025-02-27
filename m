Return-Path: <linux-kernel+bounces-537343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5453DA48AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0E53B0348
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FA27128E;
	Thu, 27 Feb 2025 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/9Xk2Xl"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F93271281;
	Thu, 27 Feb 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692551; cv=none; b=AmQk+mtVFzffw/6ELD1E9dI0twYDg4BqTDZ/HclSR93uZvUN5ArpeZmQPkgR1r8fSAX5fOjSqtHIzGzqqXWwy60ZVfBL805Eqz49SPgaw3vIF1cDxkcSpqBP2WPuwwisChKkaRH8sRNL1+bUb2VoWCPkWV/+yVizfnAR44lahFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692551; c=relaxed/simple;
	bh=gyoSbEUnAQzOkgkY3fwsl8u7r90ywTfp/qUn5ERW7D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rwbd5X7MB09S2QNLf0hNVQzCISz5To8A4solMC+dCzMHDsSi6ZJp4XA1tMaazUgWNvGRjfxedsy34PTsp0dDoh/fge9+ZOXxeta2wMB6BsoguPUcLQ9jHMV66i7L0yzm4sk+YqKb8QR2FLHPM9TE2PtBfsmIGDQwrUvfEuRwrQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/9Xk2Xl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so2363092a12.0;
        Thu, 27 Feb 2025 13:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740692548; x=1741297348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F7A7Tz7g2FCUPie3WKQ6N05ixy8h/zaSxwfvjnOeJGU=;
        b=O/9Xk2XlpIFayF+B6axBQFfmb/gC028gd44q05cu8Kh0JN+O0MFCe2CfSzRwW7PHXp
         QLOcwySiNSltUbHYdobLbRlymr2oEgcF1hcvKF+mdsZL+pk6i3BCjEGCeNf084hVCveh
         z3axRmnrseIpWq/iRb5oClUGB0RdMfJ90HmRwBuEhL4FjrZmcczLWY/U/O+OE9H9rJER
         3Le+wCevxKHa3MACmA9ei0bDhCkCERI258eP6YKhPlwk5Aoeh/xeKhxGfcQ7pD9hyDES
         XNAinsGvA0GjQQJbHH8ivUkxLXYY58m8ABm3LcXjsafCAWYlW7KxGTf8gZc6jNuyvwVV
         DkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692548; x=1741297348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7A7Tz7g2FCUPie3WKQ6N05ixy8h/zaSxwfvjnOeJGU=;
        b=QxS9Vj2J1GmkjKSSLlThvCEhgPWWs6L9w3zKMoYGIyGMVBr6Nr/u3qMN8Ivsimosa0
         AQ79dT6ucEf0zOY1vgAjQu6gZ6HjmBGSNf5jN7czhDlxieBWQ2meyRmGHf2Iwh9D1ewT
         jqj+Hk8GM3MIzPnV0TxqFwlPTGd9ijo/Eo1sZh75a5rKG5rEqjchTSzEAOog7OPyj4lc
         fd0ijIv4HxEd1Xzuk2GmPTC12nAfr9/nJ8iH38mOvdEuyM4KywHhiUnBjTPsugNcSgOh
         AsOqlJIwIhp5wtBBXaK5zAGnTfw/KsM390lG4Ms9WzuSZ9ddjlebTfKleGXbke4j4C+T
         MW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJd2adtwTTetz294ssLup7NkTKjhpVp/KFv4uqhgHk8u5uRq2O0LcNTg5yZk7rWpFHPvtv4Bhx/+svEDioTTY=@vger.kernel.org, AJvYcCVACf1waU8+/ASXxhDuXhWpESorTilGZcv5l0dyoQrQsFBkJP31g2snsUKNC45CGuNFHqIU1T6rZ2GRMrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCq7Im2Uq4O/oGAvB5lBT5AOiQTz/3AlcpQhisxeU5/BDhtoV
	6aT3W3Y1Dy38hc3NpUXDBtdKPK6RrxCP5AHarXDB/4+TWFsd4gdFwoq6oz0eblu8S3oVUxkZYDe
	NYEeug5S3z2SbhJaIrutohG4mc3M=
X-Gm-Gg: ASbGnct5zKwqza8t/VXaSO9uisXWmiNRRYPqipcnJu97SVeoLePw9fljAI7QZGPYquL
	OydDnhvBhHMohyOTbNYIT/pd+fIkoK4w2tbAc7jpmj+BAAH9hbURYKyNBw5RbqXnLbMOwM/3A9y
	exylVeDw==
X-Google-Smtp-Source: AGHT+IEyUR259zBhUCHDJy65pOw87s0pkKQrEtcK41k9OYzWAulpVoau3ShqRLX/t8YhweziRQmpCp+v5WFZxhtaqsM=
X-Received: by 2002:a17:906:f59f:b0:aae:fb7c:50df with SMTP id
 a640c23a62f3a-abf265e903emr103365066b.36.1740692547826; Thu, 27 Feb 2025
 13:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f062199-8d69-48a2-baa6-abb755479a16@nvidia.com>
 <Z73rP4secPlUMIoS@cassiopeiae> <20250225210228.GA1801922@joelnvbox>
 <20250225225756.GA4959@nvidia.com> <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com> <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com> <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com> <2025022644-fleshed-petite-a944@gregkh> <D82UB3V6NZ55.3OEPPW2W8MFZV@nvidia.com>
In-Reply-To: <D82UB3V6NZ55.3OEPPW2W8MFZV@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 28 Feb 2025 07:42:15 +1000
X-Gm-Features: AQ5f1JrLTmtHkCd1E06gAqOr7bQnTtzsccZk8EDXt2lxV9P7KCyAhTQQP23iQ0Q
Message-ID: <CAPM=9txrRFOb6Uzm=e0S6Tfxmskm4zwAZgsWnkvCzxN=XCZ6Vw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice implementation
To: John Hubbard <jhubbard@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Danilo Krummrich <dakr@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, Gary Guo <gary@garyguo.net>, 
	Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ben Skeggs <bskeggs@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 11:34, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On Wed Feb 26, 2025 at 5:02 PM PST, Greg KH wrote:
> > On Wed, Feb 26, 2025 at 07:47:30PM -0400, Jason Gunthorpe wrote:
> >> The way misc device works you can't unload the module until all the
> >> FDs are closed and the misc code directly handles races with opening
> >> new FDs while modules are unloading. It is quite a different scheme
> >> than discussed in this thread.
> >
> > And I would argue that is it the _right_ scheme to be following overall
> > here.  Removing modules with in-flight devices/drivers is to me is odd,
> > and only good for developers doing work, not for real systems, right?
>
> Right...I think. I'm not experienced with misc, but I do know that the
> "run driver code after driver release" is very, very concerning.
>
> I'm quite new to drivers/gpu/drm, so this is the first time I've learned
> about this DRM behavior...

> >
> > Yes, networking did add that functionality to allow modules to be
> > unloaded with network connections open, and I'm guessing RDMA followed
> > that, but really, why?
> >
> > What is the requirement that means that you have to do this for function
> > pointers?  I can understand the disconnect issue between devices and
> > drivers and open file handles (or sockets), as that is a normal thing,
> > but not removing code from the system, that is not normal.
> >
>
> I really hope that this "run after release" is something that Rust for
> Linux drivers, and in particular, the gpu/nova*, gpu/drm/nova* drivers,
> can *leave behind*.
>
> DRM may have had ${reasons} for this approach, but this nova effort is
> rebuilding from the ground up. So we should avoid just blindly following
> this aspect of the original DRM design.
>

nova is just a drm driver, it's not a rewrite of the drm subsystem,
that sort of effort would entail a much larger commitment.

DRM has reasons for doing what drm does, that is a separate discussion
of how a rust driver fits into the DRM. The rust code has to conform
to the C expectations for the subsystems they are fitting into.

The drm has spent years moving things to devm/drmm type constructs,
adding hotplug with the unplug mechanisms, but it's a long journey and
certainly not something nova would want to wait to reconstruct from
scratch.

Dave.

