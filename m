Return-Path: <linux-kernel+bounces-537640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438A9A48E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CD7188F01D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F217A2FE;
	Fri, 28 Feb 2025 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVZlB3+b"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CE276D33;
	Fri, 28 Feb 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709505; cv=none; b=kVPxjvAw1a2hUcUD/ZukuW+lyI/S9YWlVQj7QdoIzmIpI7h+s+OKbxHqDCg4OSa6/26QXfvG3gmIn2ZiB+XMM7rI4GHDSx4Q3MPlZ+fXzi7+ZeebO9azoIabhIe2Yvc6WJ7RG1+K/0hUzsuwIWNnrxrULaPUSlv2wKzTs1o/1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709505; c=relaxed/simple;
	bh=TH8GhiewyAoHOD6iRuesAFPW40a34FfeI1owzcTXXm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rk6dR2wHRqUlJ+cAKZmfKM/iWFAE/T42jqERUyNhxN5bEN6Fazdu5TYLyLv7P/iIfzDa5iKiJHTChux1BJ7m6BU5u/MV3SvyCz3L7x8xfnfk8nFH/vLcI+UxAy8/1kuele5n/vDmPYZrxlvGz43YIBDKHXtwieRVw9MaKOZguJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVZlB3+b; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so1820618a12.3;
        Thu, 27 Feb 2025 18:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740709502; x=1741314302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HOiFb2uaZTM/Hc5eDFna0HdsQUy4+S1apmiGNsTq08Y=;
        b=RVZlB3+bgByvH7jV91p//4N7lsiEjjV24s5qCO6gK0LWbapy7rtCCdWdxpkHhebeqJ
         ap4Bio/wdO1hkDfN5f9mRsTKeDKe4cBAdIR5Gnh/dmAn/to+md4SxdZY0EgOv+NNu6pO
         l7Qp3RtpjQevsseskpnVYq79lJHnWno+99BhmdazU0eegiXWyC4XZFrzLDWge9YuVaq9
         F5NoCgdnkhNCGaxyON5PWeNsbqvxd7ADLC+oef0oVV7Qe1qkUs5J/bEcZIdhQv005Dfh
         8srTKkVix+xGMdii16NdcOv8uX0Uw2Wm13uocqPPtTeccXcbsZzwA9QFzMspWexchJdd
         Njlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740709502; x=1741314302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOiFb2uaZTM/Hc5eDFna0HdsQUy4+S1apmiGNsTq08Y=;
        b=pdU0sYomY1126zqMecxF5AbHhr19j4GZ0kC1QLL7osFZFH2nDvIv5sMNkM71MtusrO
         uuyW29zXKf08m9wY1fid+evJAoV5SLh5DjnNhupTp+NDEZ1pgdOEr9d7YBgYp8iWmdEw
         uO2O8INm0jwjRb79vgPSNhKSVLls+t5idmT08URWrRPvQnU73CCAlhWUa4xWL8/ico/8
         KYgyN47RNHm1KVgb8H0H6gp2dirS+F5usuPX8ju26MWLudLQB6CNGZDYwNJHbq3xzJwn
         MhzCBTZXr9mmevkxNcXQ6Z7I47pzt5e0wv5i9TGhvTHa7YCnN+H5o0CJZmt7yGsz8Apw
         oeGA==
X-Forwarded-Encrypted: i=1; AJvYcCWWGpQNX+8PQDIG2YOtkPF6haoyZ8Wb8TJtHJkPpAxzDcWOACA9B1eYtxHHpVFmwlUT6uGVSc3PcFYiZBY8eNM=@vger.kernel.org, AJvYcCX+Ddu8KS6JEWgz2lJr0QsdDfC85PeBGTqZe1+5jFov8l3HnHjq/F/O5Zf3JWhvWFpbhcrS2fngFC+baCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfDKe28+eecxPxp4d/7zvwf3J+DKZMMzrVHBmUQEj5fMg2ng3s
	f3A4V1J2siCl2FEZpqceCSYIK7Qn7NVtW3C+9Kj1ijhURwTUftzuAuRtPD76hetq7aIj5VGN+p3
	u4u4kgc5HZTcCgiT4i1YT/51OTRE=
X-Gm-Gg: ASbGncueNPjoZCfy7F4aVnTVohaRPi0SaJVKTG3+ptZdLYSQMiDPHcvNCWh56scTunF
	ubwr6jb3ZmVwlp71gIddRafFXxh9m7PSEhWQD6V7uUS/TJG3yZPmj17uuG0JOaW3VVXYvwQLkgO
	tdzDRrHA==
X-Google-Smtp-Source: AGHT+IG8P/Rf7Nhp6ubr6y0mJxpSoaHQ23pNLudbTvjrOGOm94lBjX0PH2uiYGY5ebcGSTw2itPEiP8WYWZIYVpcOo8=
X-Received: by 2002:a05:6402:1ecf:b0:5e4:ce6e:388b with SMTP id
 4fb4d7f45d1cf-5e4d6ac54a7mr3056695a12.6.1740709502364; Thu, 27 Feb 2025
 18:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com>
 <Z7OrKX3zzjrzZdyz@pollux> <CAPM=9tyu84z4Xk5X0fykO3Dazby2UqRgwtN4woNKe4Z2yMyDZg@mail.gmail.com>
 <D80AK2CLL4AZ.1G6R7OBHOF08O@nvidia.com> <Z7xg8uArPlr2gQBU@pollux>
 <D81L5PE1SPWC.O56MB6SRS0XK@nvidia.com> <CAPM=9tw=8WtR9093EThr0aY6yTYtef9SBgjN5S1xZUXaWN8aWQ@mail.gmail.com>
 <d9c7e8ff4b32f06650b2ad4e3b993d217b286aa9.camel@nvidia.com>
In-Reply-To: <d9c7e8ff4b32f06650b2ad4e3b993d217b286aa9.camel@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 28 Feb 2025 12:24:50 +1000
X-Gm-Features: AQ5f1Jo9MDruhrTr2qymJBq8i--oaJMjPPjA2VFHO726289NAQO1EfWzdBHtnOI
Message-ID: <CAPM=9txa5Uo0qC-5OqNOcrWaGNjJEr8+J+ug0C3e6fMk9t18Zg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice implementation
To: Timur Tabi <ttabi@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
	"nouveau-bounces@lists.freedesktop.org" <nouveau-bounces@lists.freedesktop.org>, John Hubbard <jhubbard@nvidia.com>, 
	"gary@garyguo.net" <gary@garyguo.net>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "dakr@kernel.org" <dakr@kernel.org>, 
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, 
	"joel@joelfernandes.org" <joel@joelfernandes.org>, Ben Skeggs <bskeggs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Feb 2025 at 11:49, Timur Tabi <ttabi@nvidia.com> wrote:
>
> On Fri, 2025-02-28 at 07:37 +1000, Dave Airlie wrote:
> > I've tried to retrofit checking 0xffffffff to drivers a lot, I'd
> > prefer not to. Drivers getting stuck in wait for clear bits for ever.
>
> That's what read_poll_timeout() is for.  I'm surprised Nouveau doesn't use it.

That doesn't handle the PCIE returns 0xffffffff case at all, which is
the thing we most want to handle, it also uses the CPU timer whereas
nouveau's wait infrastructure uses the GPU timer usually (though that
could be changed).

Dave.

