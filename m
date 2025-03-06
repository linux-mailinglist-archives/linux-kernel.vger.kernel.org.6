Return-Path: <linux-kernel+bounces-548432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611ECA544CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E11818967AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9071FCFCA;
	Thu,  6 Mar 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kso6FgXT"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E531C7000;
	Thu,  6 Mar 2025 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249534; cv=none; b=aYcVWScPNYPX/ukwuGPD5QR1o/fLOcTF4G9LMvjezOcbyHryibXWu/gtbgWjxuTol4HsRGUz7gwBKqdoKaCYTYg6olSTrHfM7WypUxTG868c2DNEfkK4mZuiP+c4rHCTO3hM7q+HyLI0AWDHcg8wxZKkNRNMlSjZuUfrUFd56Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249534; c=relaxed/simple;
	bh=pa2pqjTzw4q5VypT9EDLTaZO/zP/qbuXj/8Mk6tgbig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8ULq3f5VeJhtpRHb1vzKC99guDsh+G8GbQJt6FxrxO4mYA6r9RrWFuOPAv7ctMiMMaudMQ+2hDD1GK+bdEaRjUFmESqdCM0/MqgxnoE6By8/B9OzWQZsK4e7HQyj7AcYbohnzsZOp8Cnts/nRGhp3o1z5sjOlCAjXfhHq+Fg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kso6FgXT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f6ae4846c7so3682387b3.1;
        Thu, 06 Mar 2025 00:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741249532; x=1741854332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l11SkgWqUPrtSyPOaTCEHvWbGMPH1FvVn4OSdWqPLcU=;
        b=kso6FgXTJOx+BlCyDR/f5GgdYVlomsXeqmM6oTlvCvYi/8ZDQ9+ZYkn8iM9aNzTNfl
         wRuErQ8JedY+8MnmBnirxA54v/lqvDUfX4u+BvnUPO98JzwYcWpuCPM/GF67N3l8GR4I
         nROGxcHt32zD3kt0uVveulrp3L8OxDD0gKhtAS8SD7+5Bc0TgSioGRlfaBBNgaIgEiAT
         WUyCgGs5U2i+bm+cERtCMMELjSfPFJHksRmxKWMnktX9zRpDDBG6mGJ70DIqobrK3eq0
         WhL/pEqpD0bKqLo2UYzFx+A6bxF7QZHNUaEA/SPKoMCCfCTNdcUT7jcPlreqIIC264dp
         MwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249532; x=1741854332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l11SkgWqUPrtSyPOaTCEHvWbGMPH1FvVn4OSdWqPLcU=;
        b=Ss7DPUJxO9V3vWeWcL1CcckUgeKjNlDgijUWnOxEWoGGT2bR1MmQS1OvMNYuoiSAuY
         Jfstr3sxYmPBF2Xp1Fe8D1IEv8HiMvi3gKWYTqFEkA8oItqSJic15+hEsyD9XURf9jXg
         mjeYD3irjjdWXB2FhHHo8YTYnlBKlW8FJcAiE///4/5GJiUmJZ8LdalenYQYbCjljMvW
         cnWoBZpYUx1HdLW7S9WnzFjjwEd3QTLYuc8KXT9vfQwxhbUyIR8g5dvotpsMNueF/rBy
         pZ7fspIy6wiVAoHA/1CqhFHce55q4aJZNVcl3WhNUDzAXUh1nSx2d6gLF/BS8zt9O4/R
         VzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUme96FlUs85KYrbgjkH52qUw0WvNjlayWjWuZfcQez1GaDz5SCiOwDngHNCEb6zsnjnnRFBw/+ZoonhRlb@vger.kernel.org, AJvYcCV4iVZoINmHcgUs6qWT9K0siFtNs36zPoBOE9NHqZvKCyPdhQMpM/7gFnnChJMVyQCMdj51nTGTMV9w@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81BWhVL1IxoCWoDKKDg4gguIXqayvvILZfzMaN2Wrjf3hL+sO
	QqGFAfX30SpttfoDnXD3SIavZjd0Q+PaPDAv6INAKqaPJHJDK2/0BKPq47nyPzDm8XhUImTaJdM
	1mWKiigF35xucCXEwCx+gZYq34VMQsg==
X-Gm-Gg: ASbGncveNSXc1IAHM79bfwvCSm+LTKDBEJSFEMamZp7ZqTTHGA7OwwjSX/rK4LXqUff
	BMCNAuBr76+gtslC3nMU26+kBAu8UdiYSoDR6Gd00NLeoQCyQ1LWwGuXlgoEYr4RsMd4YQMfh5J
	gtV1QD0KLMaCkbluE5zWZkUCer9+k=
X-Google-Smtp-Source: AGHT+IFnspkvdpJ+HPHBG/KH8TGaWDZN0+StO/ZWaAuyUTjQwZy69YzKVcuXuloS7kwM1iyp/LGVYtDT6bnacFmZ8Iw=
X-Received: by 2002:a05:690c:4885:b0:6ef:5097:5daa with SMTP id
 00721157ae682-6fda30765e7mr87697697b3.34.1741249532155; Thu, 06 Mar 2025
 00:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-spmi-v1-0-c98f561fa99f@gmail.com> <20250305-spmi-v1-2-c98f561fa99f@gmail.com>
 <f17372963b92074144b07d34f3e91ba7.sboyd@kernel.org>
In-Reply-To: <f17372963b92074144b07d34f3e91ba7.sboyd@kernel.org>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Thu, 6 Mar 2025 09:25:21 +0100
X-Gm-Features: AQ5f1JqQuLKh7WecZEc6nmQrvFQ9MPHH5tqpXbx3DWso9KKNvdQNFg8hYDfSVJo
Message-ID: <CAMT+MTREFq2_ABXZF-WsAkw9qP6eXd7gQwgFGm7fw6nBntdbyQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] spmi: add a spmi driver for Apple SoC
To: Stephen Boyd <sboyd@kernel.org>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Conor Dooley <conor+dt@kernel.org>, 
	Janne Grunau <j@jannau.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>, Sven Peter <sven@svenpeter.dev>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jean-Francois Bortolotti <jeff@borto.fr>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 23:11, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Sasha Finkelstein via B4 Relay (2025-03-05 12:26:40)
> > +       while (len_to_read < bc) {
> > +               rsp = read_reg(spmi, SPMI_RSP_REG);
> > +               i = 0;
> > +               while ((len_to_read < bc) && (i < 4)) {
> > +                       __buf[len_to_read++] = ((0xff << (8 * i)) & rsp) >>
> > +                                              (8 * i);
> > +                       i += 1;
> > +               }
>
> Is this ioread32_rep()?
>
[...]
> > +       while (i < bc) {
> > +               j = 0;
> > +               spmi_cmd = 0;
> > +               while ((j < 4) & (i < bc))
> > +                       spmi_cmd |= __buf[i++] << (j++ * 8);
>
> Is this iowrite32_rep()? Perhaps unaligned sizes have to be dealt with,
> but otherwise I suspect it would be more efficient to use
> iowrite32_rep() until the number of bytes is less than 4 and then do the
> one extra pack.

I think it would be better to leave them open-coded, io{read,write}32_rep
casts the buffer to u32 and accesses it that way, probably resulting in
unaligned accesses, and we are on arm64.

