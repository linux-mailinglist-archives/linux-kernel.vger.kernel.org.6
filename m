Return-Path: <linux-kernel+bounces-264119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2D593DF19
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1651C21830
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDCF53362;
	Sat, 27 Jul 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj12ER0B"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9051B86CD
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078545; cv=none; b=LlWYWBpqb7P/WmvIpwkWqwQ41KHO0cix7eBt8SRrKbFXu5UZoKZqInmcjHdPPai7I+eCkKbTI/Qvv2kKIdysotEVj7tpIol+gwZKGJSXnMj4VEXCnuHnQsl2AB8PZog/Z+Jigvttz8/dcB6k+P+ZQoHTTDDfbLlG4c+T1nRWEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078545; c=relaxed/simple;
	bh=dyGA8AZ76ZW0HaObW7gN6aW+eUP6r9Fonmffm6ZPj2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPZcw776AOezvtNphvE7JdLQ1gyjFOAf8IPwMKOdq1hAM3e+m0+3G//2/nN4Seoyd9ta7rNKqUORKHVhgoXaJF1aKA2kUoPTjT8QSwspPFeNW2nb2nIBmij+HCCiYA60HBYtY8skyx0S/j5WmWVu9mkI4npL1m6DAVhgIhmV6ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj12ER0B; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e026a2238d8so493968276.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722078543; x=1722683343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyGA8AZ76ZW0HaObW7gN6aW+eUP6r9Fonmffm6ZPj2k=;
        b=Uj12ER0BliD+1gFHD3mpwH2WmpPbfbazpIUxQbum3Vu172KqN3HfDmo1M8Lc/QwmIj
         e0naM3d+VEhF/gU+XPv2LzukE3D0DFM6va0ylSBWGNXCvoIgupG34DZVI3oerPYMs5xu
         mppV43jIiuv5SDG1wNwUEY57mpwWaVeqGTMF1try6nka55xJzaH2dKh9EqK4R12A2MhZ
         okatPJYJCUsr2DTEE/vy3mgSBuXFHqKrOTzsifyCq/VE3RXm4/qJzVmUQ5lgVU6Y/E+O
         xXdQqKBtE7YrSHJms3PmyiENSwqWCXmjlHScjsl9130X1VUXujib/o7+7fsWqF/7MWzW
         KXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722078543; x=1722683343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyGA8AZ76ZW0HaObW7gN6aW+eUP6r9Fonmffm6ZPj2k=;
        b=Z2FXXFUFONAGXwFwb4eyazoWg2YGBC57Vkc5Li8Ums0xhBDTDtdOf6VK/rimJZ4Fcg
         oyh8vXgDGF8n40siy17wKYIc+wGMdbW2WQR9Z38y9q350xH9Vz+AoBG8OLontPPaZohP
         IVMxQbdmo2bJi9gJ7GJ1jnL7Q2BbqycCPaO4nsU0TO+KW9myvKVMsnF6mX6v+dygJdJA
         MYjdVB3VKJeXIeMHk2EdnEkYw4Ggh4ICIcu2BbA+gJfuOJYlgSlh8R8PRH/VUiDmivhj
         hD5+sZm6PICdgyMWTGtkdG5uEhhZqmpeQkShdLNd9AWGLTGSKHDUmUngTpfru+zLAuS+
         9XQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIUdObgIWhB+/hGWJsgSGYfYIFsePu9kR735E9/2GXiUdJRLB+BpRRn+zT/hMsOayn+bw/olgJcfPsjXXkseKzWM0C64UjycczdCmT
X-Gm-Message-State: AOJu0YxDrwAUbaaQ+NlI4y83gTTwNoMkk4wlrJZ6XAw5Y33SG55Lwj0n
	IUy1U5ScBNpFN+ab5LLpVObpzrN6xrmodIV3Mk7TKa78TAW4jxCx+xlaw6gFLCe2VWQYVO2vdGL
	qBkTs+z86XLN876TWiBE/QJ337xY=
X-Google-Smtp-Source: AGHT+IE4cUNs4fbYBQXXFf7cmgW5NJUB50nK5n8y91z/Rt1CbICJX8KXJISgkM7W+4dH01efPZcByAtB5rIvEKGZHAk=
X-Received: by 2002:a25:bcc5:0:b0:e0b:46b5:2247 with SMTP id
 3f1490d57ef6-e0b5449c832mr2386720276.12.1722078542865; Sat, 27 Jul 2024
 04:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-3-flintglass@gmail.com>
 <CAKEwX=NCm9t9Y6z8bWQ788_wnhQsGN0frroTabNpHStxGnJOqw@mail.gmail.com>
 <CAPpodddd2SAVj3JmDHOz+xdaAc4nPT49_yHqnPCtcFSWqJk1=A@mail.gmail.com>
 <9ac88791-54e2-4f7c-9171-5a1d44e01657@linux.dev> <CAPpoddcw7BD13ME8xG5TP=kKV=5t_JCxA0DW3t7C5o1wkC5tfg@mail.gmail.com>
 <CAKEwX=OBzr7ozLrvGso9HFtGBdged1XZYxGgV1cVwDaiOeaZtg@mail.gmail.com>
In-Reply-To: <CAKEwX=OBzr7ozLrvGso9HFtGBdged1XZYxGgV1cVwDaiOeaZtg@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Sat, 27 Jul 2024 20:08:52 +0900
Message-ID: <CAPpoddcyHUC42X=nvtT1_MmHLP8Oomw83GqYTy8NytF_z5JkPw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: zswap: fix global shrinker error handling logic
To: Nhat Pham <nphamcs@gmail.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8827=E6=97=A5(=E5=9C=9F) 3:01 Nhat Pham <nphamcs@gmail=
.com>:
>
> On Fri, Jul 26, 2024 at 1:54=E2=80=AFAM Takero Funaki <flintglass@gmail.c=
om> wrote:
> >
> > Yes, the `++progress` counts both error and success as an iteration
> > progress for valid memcgs (not writeback amount). Incrementing only on
> > success will overly increment failures counter if there is only one
> > memcg, one from writeback failure and one from tree walk ends, the
> > worker aborts on 8 failures instead of 16.
> > `++candidates;` would be better? replacing the name and fixing commit
> > messages for v4.
>
> How about `attempt` or `attempted`? Naming is hard :)

Thanks. Rewriting with `attempts` in align with the `failures` counter.

