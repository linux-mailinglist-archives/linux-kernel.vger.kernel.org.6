Return-Path: <linux-kernel+bounces-413367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4002A9D1831
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4721B25A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1C1E102E;
	Mon, 18 Nov 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cmFfEex3"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5161E0E01
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954603; cv=none; b=guYsXWmeMz2rDp4Opw44KZk2LHyIIoE8ZCxhv0A03AYNw0B5jVUBWDG6iknKGjN61f9qNTzjlTZTTPSNR6I3mWvu1vrsSz3AbqpSuYtr9Pnpi5RlOtbXV5sXVE/U4xvKa8NBztGySjjC8g6/CvWRk+kSxMaXv4TKkr4aNGY4CdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954603; c=relaxed/simple;
	bh=S5Qt9qS6QLVBwhpt3kD373BYFKzAK/2DH3wvxC89m54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFzAAds4YVEB7Rz32EvVTcafDMgMenMBSgACc/zxoCYShfIL4IdhXlo1F4dQoGojf9Q0GbUTAc+V+eGhfJ7Nl5nJM+0b2t5KnN+W0HIVEn+lwkQDUR9JVW308PIeuArqma0V0Ehw+2fDi65htuWKCasD+GJPiPnrmFNf/sZmIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cmFfEex3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso13873566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731954599; x=1732559399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I59dkoh0V3qfBXYRyrpc9kFXQj8ZHogw+uWNVlQrPH8=;
        b=cmFfEex3uZdALeRI4NusC/uztzy11toQEFMVREN7fwyuUkbsbgm+kBoj+p/17+u5Gl
         d0jUCjj9wEDJ5M2fwGGsGb011b4xUdqme0LIngGIVRlBLdWg58DLav+N8SsiVwK7M3AD
         pGLG42ws9QU0oRYl+xs3K/KXqMnUv2xwll+vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731954599; x=1732559399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I59dkoh0V3qfBXYRyrpc9kFXQj8ZHogw+uWNVlQrPH8=;
        b=ApRykTQHTPD6v5WkpfPqoFOCts5QtfZR8bnuy4alJ9iEHmABwuCV+vWbtIZqTy9R5S
         jiPZ4/q0Cc4kcqSzMkHRS5yqgvQ2l1dmUXxoqEws4qgt/lxeTlK8AxSMquGCgpkfceFQ
         SvYJhRkmqI0y6/18mYL/jFIQeJFkU0Zs9+e3t41U1sCY1LnB+jSlrlDIZUpcs8VQA4tQ
         7CM4sPVJnzCN3+DiVmalx+lIYmfUKmUSGFrM5xy/nNT6PYL9EWXo/3GHN4czpO7kAfvH
         FieorUJBrWSs3oaarTjc9p8MUBpSshrVqah4EndjbyjSnKqGPUWp1CUKs7n5zRbYyUoy
         TOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWVYc1N89S3TRctZlu/kxNtHXSFI5WfPXWpgdwOF27wzGogcJJ08vUNBauDVx9MQmquuO9p3S0khCabLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwezgyqsFeIuqHkjbCknyPuRwGwT+V1c17uI/380/7QXp/COR
	6z4mT645BzGtmqgmY8J0OhRCzJ4qCYJ1hFTxRbSf0rsVoEO4Q/MAhzb/eBXS9j0MoGkyjppQDLW
	m59BZew==
X-Google-Smtp-Source: AGHT+IG7x/AVecNbnPFoyv5HHgTuP5h5clVXb0nEVuJQyhIVDKScx/EmSpjIb/icFrW7UMvxV2W8Pw==
X-Received: by 2002:a17:906:fe41:b0:a9a:8034:3644 with SMTP id a640c23a62f3a-aa4834239aemr1295675466b.14.1731954599526;
        Mon, 18 Nov 2024 10:29:59 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd74fsm561862966b.94.2024.11.18.10.29.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 10:29:58 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso10357666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:29:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXA6F/yTMULg+JbKX3HOQDvEby/X27blSY0N5vpIo6KpD8nOe61yuANpzR0j2N3aD9pEvBdjuPuH5QujjY=@vger.kernel.org
X-Received: by 2002:a17:907:5ca:b0:aa1:e050:89 with SMTP id
 a640c23a62f3a-aa483482130mr1297287466b.25.1731954598521; Mon, 18 Nov 2024
 10:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-vfs-netfs-7df3b2479ea4@brauner>
In-Reply-To: <20241115-vfs-netfs-7df3b2479ea4@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Nov 2024 10:29:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCHJc--j0mLyOsWQ1Qhk0f5zq+sBdiK7wp9wmFHV=Q2g@mail.gmail.com>
Message-ID: <CAHk-=wjCHJc--j0mLyOsWQ1Qhk0f5zq+sBdiK7wp9wmFHV=Q2g@mail.gmail.com>
Subject: Re: [GIT PULL] vfs netfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 06:00, Christian Brauner <brauner@kernel.org> wrote:
>
> A pidfs patch ended up in the branch and I didn't notice it. I decided
> to leave it in here instead of rebasing the whole branch.

What happened here?

Not only isn't there a pidfs patch in here, it also doesn't have the
afs patches you claim it has, because all of those came in long ago in
commit a5f24c795513: "Pull vfs fixes from Christian Brauner".

So I've pulled this, but your pull request was all wonky because you
used some odd base commit.

              Linus

