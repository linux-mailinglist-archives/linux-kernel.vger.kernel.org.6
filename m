Return-Path: <linux-kernel+bounces-306035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE6963846
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6631C220EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52393B796;
	Thu, 29 Aug 2024 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU9OIU2n"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275A1CA85;
	Thu, 29 Aug 2024 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899189; cv=none; b=eJrwuEdY6hLKwwdzjUz0dbpXZQxaom/mQ2vvHpC1OJkU2Aw3ynPTPYdyhi9kkI3strAbz9Nx0C9RbqIZyHSv4DDjy+Byw0wh25El7f8Na1CeRVMx6Zkc19j35Ru8W3tuSC9r3UnNwRfg0Lb6juE2C/tTgU5lyG8otRNtph8aRxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899189; c=relaxed/simple;
	bh=v+Q1Ce/5Hc9pCqD3ej9vK7hY2hUfQtYzXW+/BbTnJe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE+KQzNPpw3csw3RIbzEKJsY/eR8Gffze00VjX2CnGyLOWyU5uWKl9vAzhEUW2AqhErwIJ/7mFv/vEodhSLz6TLuQvBEyQXnftXIFu5FBYNObetjhTtXfg4gsAvrGDh0EqXW10CY6FHQJEcGJKQ/LpkpG26HBFGmxgOiYoJa9uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mU9OIU2n; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e117059666eso206904276.3;
        Wed, 28 Aug 2024 19:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724899186; x=1725503986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+Q1Ce/5Hc9pCqD3ej9vK7hY2hUfQtYzXW+/BbTnJe4=;
        b=mU9OIU2nPq0rSB7VyQgLFPqu3d5RvojC705ArSWlJCAsi7swiJE8iaBInc9+Qmm0y9
         /YgWvHE/JWGT9I039NI7o+6h252xOMt7ac+l2sYNUj7L7izuvkD4a2baVd3DG/8fGy3C
         t01Hm9zxL0JSUAs9zUYob52vPiSscH0JZTQ6Gh2CFP5eTDbzJn0Eu1VEn1wnzSahc8r4
         ivBQZQxk9H0QZRWo0jgDao8K/4+xK3rITu+baIZpX1EKlM8bh+V5/AvWWR8OUcSC6ovi
         ZoEIAE8I3pM35Rkb2oOkCDtSGqtasctrBrOXQ83c88aB8Mo0PGp4WH+NOOKttHbiGOJ9
         jjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724899186; x=1725503986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+Q1Ce/5Hc9pCqD3ej9vK7hY2hUfQtYzXW+/BbTnJe4=;
        b=Lu9ePywP2iHrjP47IHw8+U+/9R/edVHoPclHormshfJCrU+UU7bCqXH0FMrucSCWuC
         Pm22RIirHMBYASPGorMZD4XB6klb+SxI9SEg+PlE9VAb7gPf8eShTMUMTJKnXVfnxVxK
         oCkMopP7btvMidNvG1DyWYuMCmTPN3Wq/2fcSTRw/lvgfZKBGGM4QQSiHIFAzJ/RnjNJ
         ZTXMpuaEP7+Rzm8heLxgSDDYLmZl1zwtFMjm158dnZzktxA+Cy/SekgcJWrC0gQLHJ4x
         4w1A8tv4EBc5pCwjvMbMUcpZNl3hyjhYtJGQHilnU8GWcI9UqeEZ+mb1N9R+04qo7abt
         9bDg==
X-Forwarded-Encrypted: i=1; AJvYcCV91XrCkBpvAu/sDDBNa6zHy+hRAeZrvy8xhE26twt+2lYH0wl0Ck6ZVm/ydkOzwclxvT5rAwNxQDGwF2XAi8A=@vger.kernel.org, AJvYcCVCS01H2nxJGxDuIWGoM0rKWC0qAvi64Ci7JVhNSaky6w7tSY8iatK1UqvoeMGRTzYsqJT+QXfCsqA8rM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdxt+Qf22UXjTliY++mCKQXmxlwWhyv43S+EU0g5wvHxhIfUmH
	NS40cJ+ECW1ZlcrQG/8XAlgpugVs9xacdIHPU/2h+HohpwEa6QCjsVF4aYjwKFFLzFTCN7WyXYX
	2GCbKJkIcKPO9yG5tW2PEXslL8P8=
X-Google-Smtp-Source: AGHT+IFO5XaG+3uxaY1UwIm4DrrE11jSpukivu5WMVWg0urnyJddKZygxfJ8+dyeMGr/7UnxcjhuKDYBeQgL4k12y3k=
X-Received: by 2002:a05:6902:1890:b0:e1a:40da:f47f with SMTP id
 3f1490d57ef6-e1a5ae0125emr1657507276.38.1724899186474; Wed, 28 Aug 2024
 19:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828211117.9422-1-wedsonaf@gmail.com> <CANiq72mzNyZkJbPJU1i1PLC81g8CPqfTZ-oO+mAMGeo-r28xKw@mail.gmail.com>
In-Reply-To: <CANiq72mzNyZkJbPJU1i1PLC81g8CPqfTZ-oO+mAMGeo-r28xKw@mail.gmail.com>
From: Alex Gaynor <alex.gaynor@gmail.com>
Date: Wed, 28 Aug 2024 22:39:35 -0400
Message-ID: <CAFRnB2XHyDc=vWo8E0CzmHiTSJ2cs_frRdK49zEvmidhTK0BBg@mail.gmail.com>
Subject: Re: [PATCH 0/1] Retiring from the Rust for Linux project
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just wanted to echo Miguel's email.

Thank you for all of your contributions, over many years, to making
Rust for Linux what it is today. It wouldn't be here without you.

Alex

On Wed, Aug 28, 2024 at 6:20=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Aug 28, 2024 at 11:11=E2=80=AFPM Wedson Almeida Filho
> <wedsonaf@gmail.com> wrote:
> >
> > To the Rust for Linux team: thank you, you are great. It was a pleasure=
 working
> > with you all; the times we spent discussing technical issues, finding w=
ays to
> > address soundness holes, etc. were something I always enjoyed and looke=
d
> > forward to. I count myself lucky to have collaborated with such a talen=
ded and
> > friendly group.
> >
> > I wish all the success to the project.
>
> Thanks Wedson, it has been a pleasure -- I think I speak for everyone
> in the team when I say we will all miss you.
>
> Rust for Linux got where it is this quickly thanks in big part to all
> your efforts and quite a few people inherited code you started.
>
> I wish you the best of luck in whatever you decide to do.
>
> P.S. I will miss our long calls! :)
>
> Cheers,
> Miguel
>


--=20
All that is necessary for evil to succeed is for good people to do nothing.

