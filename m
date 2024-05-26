Return-Path: <linux-kernel+bounces-189885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488B08CF683
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 00:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BCB1F2186B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F3513174B;
	Sun, 26 May 2024 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cg/QW6ul"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42304C15D
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716761907; cv=none; b=aJ40SlQ7HePqwuhL9YAWDUYuXmQEuVna4SJUo5ZLew1+1lvCuiGbR7eu0sdyP/gHkxmNlvn6fp+jgi18cjRJj8pTr0IWmsJDQNM19/VRKYQus1bmZbt8qHT2mH1EcXJMxd/KvNdSEP029U+sxXxQcp1XOkl6w34RgEtggVrJMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716761907; c=relaxed/simple;
	bh=9/5fvB1xIJ+i5TilG/M81YbF603J1R2/aMxePAVS4cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSUZnHg+XsTeOmq395IwEsn5YCmETKzk/joKYNm5RMvBYlvvsoOPLY51ODWXQ2XavszByugFEZG5oNhgLbkF6jYDBeTqpSf4YrZeH/Dt7HUkwOtqkhJmv9TmJbXh1jrnDn3tuVUCs2WHU2ufv++nVpmiDC9uaZQXWFeNJeXvHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cg/QW6ul; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-578517cab9eso3069691a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716761903; x=1717366703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xsGP6ce4iO5NvkiHy+c8mQVrB3Pa/X5QqzVEb03Zcb4=;
        b=cg/QW6ulr+MlarYiJGAEw0UbS51he/wh1dYvod6jcysXDw+K+de1bw+kqkTM5NIXzE
         frSn73scOXqEXLWaagu9Nx09QApapGBa1WdnneDNFyFtD5RnUE2EI2gSrC3zgkTBzB8f
         /JvzHc87/tDnRTb0pKuJxwAqxyAZIP1hCFAeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716761903; x=1717366703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsGP6ce4iO5NvkiHy+c8mQVrB3Pa/X5QqzVEb03Zcb4=;
        b=oIpAy5kWjYGRpQbhpMERWjQdnDE+lLP2PyBbO0zPrNy/yiavSQaxFxnPA2qbvdq/yj
         +8rcvoHSQ3+BIKikf4KMEDD0NpTbx2nmYJKI+J++8UgSHQ1jKzP4iqoz3CtLABdI63Bl
         svgv1b9d6gmrmaRPxCsDzgW3CR6TxntzUWTjre/BERlkTL32Rx0RRuKnFUf2VsRMaW9E
         kmkCLoCruY8xXKblt0Apai7okS9EnbynVezOHc9uxGE+llsyjNP0E9R1awHAVFzcPyOT
         Idx43lAEq5TUz43XFzziUs3OEevZwDbkOQ0uuxxG8t9bkUEdQ+RcXNPwp4ET57zSRGkl
         hctg==
X-Gm-Message-State: AOJu0YxBSRlkT6n4WkX+q5zCRyHquXWZBqaHrcdZ0/Nb+UZzT3mo1yDo
	6v9suTWpKNI37HTD/2pLTwPxsE1azkW0zg/pJjiHam4OlabB5sfP2wx2WY+M4qlzk+vWifBxQVY
	+v1B7ow==
X-Google-Smtp-Source: AGHT+IFPQXBqhigR8TTJek69DnAQ5BGgsJgjUcdlsOK6v6eSh5aAf0044nSdU5LUVOjPg9+5TzZjTg==
X-Received: by 2002:a50:8e43:0:b0:579:d01a:938b with SMTP id 4fb4d7f45d1cf-579d01a955fmr1242613a12.35.1716761903388;
        Sun, 26 May 2024 15:18:23 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d0b02625sm1048892a12.9.2024.05.26.15.18.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 15:18:21 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6303e13ffeso8085766b.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 15:18:21 -0700 (PDT)
X-Received: by 2002:a17:906:c0d3:b0:a59:c2c3:bb45 with SMTP id
 a640c23a62f3a-a6265112b00mr547196366b.56.1716761901487; Sun, 26 May 2024
 15:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <h23suk5s4hhkf7prhkzxp6a4kmhpgqxyl6ioski5cg7ciihxmj@j4zif6l6dqxc>
 <CAHk-=whMS56xLhb7cAmTri2sXtGxK_zKWhZVX87YzjwAfVqTqQ@mail.gmail.com> <i4zl55yyhky74ouig4h6z2mleb3ruwp24xbt5wyb4eod6exja2@uwyxbll63j3v>
In-Reply-To: <i4zl55yyhky74ouig4h6z2mleb3ruwp24xbt5wyb4eod6exja2@uwyxbll63j3v>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 May 2024 15:18:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifUy3a7q94VYU7_nhLgA9y9gdo8cGuwMPyVtX=Ektp4Q@mail.gmail.com>
Message-ID: <CAHk-=wifUy3a7q94VYU7_nhLgA9y9gdo8cGuwMPyVtX=Ektp4Q@mail.gmail.com>
Subject: Re: [GIT PULL] header fix for riscv build failure
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 May 2024 at 14:57, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> >  (a) it's unsigned, and I really don't pull from unsigned sources any more
>
> I thought it'd be fine since it's a one liner - I'll fix that

Oh, I certainly considered just making an exception for it being
trivial, and if that had been the only issue, I would have just
grumbled and done that.

But since I felt the oneliner fix was paired with a commit that needed
rewriting anyway...

               Linus

