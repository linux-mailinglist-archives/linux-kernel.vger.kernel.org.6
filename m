Return-Path: <linux-kernel+bounces-566266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E8A675AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6028518943D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2382520D518;
	Tue, 18 Mar 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbCa+sL5"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D342070
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306075; cv=none; b=ZJqJrfjS2KAtbSPhgkW2Oyt8Y1bxrxgQ5940v2QPcQuQRX18ot0K6ak4uqaI9XSjihsdD2qyHRtsYhOgm60VRJBCfFhIvoiDVu5W9H//9NmviXAKHv4uMSpeArAy9xeA8W/j56tqiAaJAEl7M32eSe99WzdHmtqqD33axaLzYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306075; c=relaxed/simple;
	bh=FZJxF3es5BIDps490hCgMC0MYWSSIG5zvQTQ5I6k1sw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uA0TqQELDdjtZl7iK8ag+hpBPwiZa/5qwTUmw+M2gMlKSDsohKccLv+HK1Fq2zaswU43gvApRcX6C8Jkc8XBQJMlKwQS549mFJU+1LVv9EzZZ3XxStGBf/o6Tsft4MCxKmmRnYLOX06VC6PAV3p2GLgrLws8zUxcV8hbSRKodGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbCa+sL5; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so815022066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742306068; x=1742910868; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4N+RoRVKrkgErqDIBsHzbOVyaMumGSJKm0xiBl/1i8=;
        b=fbCa+sL5vRmaijxJ56BTHt3EepBZ9hGoWDiEKkcaBHNSXGkEXlu7AORV7kfVawPIeP
         jOm7eyEv7yGaUL+1P9x657mvkfOJiX/RfLj2yMLRUx543l76KnaljIgXUsQdUPMWrB6F
         Flty+KusQrBhAWH4F38jephAZRqvDmWxcun8oCTpmM0DgAbDvaTWANaKKWTzHhFf1o/9
         xNhFAMPxagxd/eMrr6cgflzHO8bq+Ej2Ws6X6GWFRHFGtzqu8BA5x2ujng/pWubTt+A2
         jsKDMnp5xDhmi1WhhJO6g6zq6mPmCXdQt+TvnDclJe9Gs0CH4ibvSe7TljLB+yyNalC3
         +ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306068; x=1742910868;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4N+RoRVKrkgErqDIBsHzbOVyaMumGSJKm0xiBl/1i8=;
        b=nphfxrP6S5ECjrGDHy68RiaWv7YIeB48bZPUGB+jT2PnSxjggN1pnOMVAfJysyvmP5
         h1LCfhyB2SLQzJDbCIxpm/uW33p7rqMVp8zbN2hJcg1dQD3cAnIpHdCizNy+DKbU/jgh
         536BUmw6RbkPKTYAPJBzEO1iFEe8KAdiyz66IPQiY960/CLleJxPggo9NySNcu4TTXGE
         g5Wt8lErnZqAj+u+82YjQ67WTXij8dRJUMryPBJNZSKi4EJvMwr+xSawhdoaaMcylMGI
         /yQLpNzb94gC+VkO/c2LLpUTT3H3q7dxwxvCAHu94khkMLBA8inOx/sXY/QbMgQrd/1S
         cvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjBt03PHj3oQkad6XKpQ/O25YW1BP4QiLzT7KbWf3UVpPztbZbVE4EuHz5sIVRs4wrk+3kqmXV0Y1X8CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdsUsV2r70+LVNjJ6j5V051ggcjg+3gGK+zmN5cPjBhDvKjrnG
	71HG5mlyLJPrp+l4spJM5pbOdUxjpmITLDnvgIGYrOWKLhWg5BAsa2nfa5y0BzucK0ef4Zr9AWs
	zr3aDmgbqKbwKhPJk2wwWVuAXj986CG/VEwM=
X-Gm-Gg: ASbGnctfqAw1+lMbi59d/Rad/Myyw6bRumRpW2jWNvuXKI4RVAu/nq2pEnZOK1EAMue
	3HUoCljJns7m9iW7xktRM5K9UY/QlQ8yujKKiuSpqCAwtabryOvTgfgNp6d5cVKmuAXaXxgEkkU
	jW7/uzLn+uMOxv5TJv/3OrWgs8gQs=
X-Google-Smtp-Source: AGHT+IFkAiSbgL/Co7hIOF61hc0ta3+alk1pxUpdKt2kRY62kg4GgnZXfeEN/9wTHjUlOkOCKnDgq/tKtbsOva+fHt0=
X-Received: by 2002:a17:906:f043:b0:ac3:4139:9346 with SMTP id
 a640c23a62f3a-ac38d366faemr438888566b.9.1742306068192; Tue, 18 Mar 2025
 06:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ying chen <yc1082463@gmail.com>
Date: Tue, 18 Mar 2025 21:54:17 +0800
X-Gm-Features: AQ5f1JrGo44FnV--OyoZekpiiwfEBVbWWKx_ju66tg7yfHewLkyumyn5U5rCwsw
Message-ID: <CAN2Y7hwHWFpVRL3ZTSmKn2CGtixDBdszxofE4DSUx0rAOeK41g@mail.gmail.com>
Subject: [bug report, 6.1.52] /proc/loadavg shows incorrect values
To: "mingo@redhat.com" <mingo@redhat.com>, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

In our production environment, "cat /proc/loadavg" shows incorrect
huge values. The kernel version is 6.1.52. So far, at least four such
cases have been found. It seems to be a kernel bug.

~$ cat /proc/loadavg
4294967392.49 4294967395.80 4294967395.83 87/16100 2341720

top output is below:

top - 21:12:13 up 191 days, 20:50,  1 user,  load average:
4294967397.45, 4294967396.82, 4294967396.15
Tasks: 2388 total,   3 running, 1208 sleeping,   0 stopped,   0 zombie
%Cpu(s): 27.9 us,  6.7 sy,  0.0 ni, 57.3 id,  0.5 wa,  1.7 hi,  5.8 si,  0.0 st
KiB Mem : 99966995+total, 56704217+free, 22655678+used, 20607096+buff/cache
KiB Swap:        0 total,        0 free,        0 used. 68817177+avail Mem

