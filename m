Return-Path: <linux-kernel+bounces-421433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D199D8B37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D911624E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA71B5EBC;
	Mon, 25 Nov 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1xV3PQQ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD531B3954
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555270; cv=none; b=VRYtacb0D88SeWCIy6aWtPM3gVEPV+8aau1oGY98dQup0pxmvTimYkhg4+A2RlZI0VByMmRJgkypck9bDH67bauPm9HisLdBur1qvGcedti7UfWTfT/dvSKWTwd7pQFISN8Abu0zKhYYkdsivaSrAbLXcrDSb64KAuSr321W8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555270; c=relaxed/simple;
	bh=m3/iAzIgsowRcITVnk6YRp3O9dmQmSDokm8GQOG0oM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMYgNANNiCE5AgagkL+EETJXFxkVlS8ZVoCvfW2Zo2ld+vZKg+9xGLWbCZ1mMZQDjXJKRE0rYbb5VJax7wbzEQyYyO10hviizQ5zxIK8xPZKCO1tfv3z/j68Mnj3wjo+H3SAoier51+KUGOMRRGoacGUozqSzIAtQXfVfUQilMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1xV3PQQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso285475666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732555266; x=1733160066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ctakrf+fNNjc3IsvGkVd9NzV1eWDoDmK5LQ7oZOQ0rY=;
        b=N1xV3PQQDb5F282x4TQlJvFj+I/KrL5qb+CY2TOnafLsrWwU3ViGcanu9lhZ4/MUPL
         cWFe0bk0GN9xJZe8Xwl3nGYm0EYhceBTIh0StJqGqZENBUaO8gAUAUzXomdS4vMW0zVM
         kRi2JRzDAN3+6Ug5zj6ejy01zm2D1yfH2apwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732555266; x=1733160066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctakrf+fNNjc3IsvGkVd9NzV1eWDoDmK5LQ7oZOQ0rY=;
        b=Znpq7yo8o4Q1taVEd4PpM89y+14Duu13TZCTPQy9ekP+u0tZpS5Ooup1KYuYa7way2
         Ri05puCJVUKu4NkaTyIKydrGTNIbxp0J4rndIV+JH2Ojk5oMKBmYPJ9OWXfaHJ513iMg
         KVNsdMD7cp9JnkWaFZTQIqmoZPenbuBdGDPvyruWrz4OA5Y+jvomXGQaDetuzZgx2am9
         U94niS2Ul5SgLTxt7XMrb3fION8Gb8Azas4+nQqrg0XfvFxK1sbOrCEq3N+HH2aTREGI
         OhH6zKWOIqAfALfVCbJJUoK6YqEGQZ2BRn9pvK3oYDJsgKxHlXbzGooxwkrP/BsJmNts
         Ja8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9/CZnHzKnKGUUUcxTy9Hlabr44tf7e4oDlVUDH9zC3Y7Iwk9qNaxx9D6Sjyo4806mQd95vtx5j0OZTjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjjn2T6jWGrrsOTKlSekbYtU7rpXXUl3sIw5uKE83jACCUJALA
	PgBo+XjcXO5RrK7ILqvhpynSmkWS/ZMI/LRmo0R+tdvR6MrbqrMi8Z/APiJsIkG/gN29/xJi0Rt
	auSsQ5w==
X-Gm-Gg: ASbGncsrHLv/QLwiRLq4OEEungrOE1CL8cq10jJgHCtForSqskyHPcFCAcfDQRo2BN2
	MMwb7Ve01CLUQVZf1Q/iGG5elNE5uM6dQJMgXmEH45BOmP9c4cdKW3jYBysq8Ajo+kbUUzFnOgB
	9ug8fVMG+YlPhEEKERr8bEjU0U3XKRKTz8jsjAHRzyWIovfphCjfjNafzF1eQICGRFR2+cJ2maN
	VBBQ4KOjJxH0Fdt5oNPvJFO3eh+zIIEzsl5S/CcPJimVIl7v8y9Oye2X2h3QDPBqW4O+aDbpL0i
	xdE8J8DsSCGSPyLi6hg4cBni
X-Google-Smtp-Source: AGHT+IEizBqz9VUYoRdlLQTNVoFV0pS+tXXD+ebdevlYzNSMdvW2ZCgSWpC56xno+lH2MCcThfbuPw==
X-Received: by 2002:a17:907:7639:b0:a9e:b610:409c with SMTP id a640c23a62f3a-aa509d3fd55mr1181821966b.48.1732555266279;
        Mon, 25 Nov 2024 09:21:06 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa550ae2fbesm165980866b.24.2024.11.25.09.21.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 09:21:05 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfadf851e2so6177288a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:21:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVv2k7chdrvEo64AFRxqaYm7qAHLJe8ICs5ICg+NXTveAqQ34xQ5JtxzRbmAiZ3gr67BcL/fHHdrDF9+ik=@vger.kernel.org
X-Received: by 2002:a17:906:32c9:b0:aa5:1da6:d4f2 with SMTP id
 a640c23a62f3a-aa51da6d53fmr886897066b.22.1732555265360; Mon, 25 Nov 2024
 09:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
 <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
 <ac800b7930c473f2653d9bdc5be0781a08d8bb58.camel@gmx.de> <yq7byjaea3rfrfbttc6ngwnajiqvxl6xdhscyfmroraq2lr7bj@fvd4t2clnhz3>
In-Reply-To: <yq7byjaea3rfrfbttc6ngwnajiqvxl6xdhscyfmroraq2lr7bj@fvd4t2clnhz3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Nov 2024 09:20:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whhfJ=O8bdt5ismSxS-fX30VvcZL6FbnEhZ9xu=FvOO9g@mail.gmail.com>
Message-ID: <CAHk-=whhfJ=O8bdt5ismSxS-fX30VvcZL6FbnEhZ9xu=FvOO9g@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 6.13
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Mike Galbraith <efault@gmx.de>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 06:08, Benjamin Tissoires <bentiss@kernel.org> wrote:
>
> Please tell me if you want me to send the revert or if you'll just apply
> it yourself.

I might as well just revert it myself since I see the problem on my machine.

          Linus

