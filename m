Return-Path: <linux-kernel+bounces-201926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF768FC562
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F6F1F21658
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC39718F2F0;
	Wed,  5 Jun 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eKb9SgiM"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072518F2E4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574882; cv=none; b=TetOEVrgezTqwSvASMIa1YZSsslqN4DfaqYGxhsnjSs7R7tBePsCOz/vhiGBBi7P/vYAo+c/pwNm+OUBW3yjLzYcEipQsWCpnpbsGYI2YhRv5RoSQ1ZoTQJJPrmzAPMMiok7fG+SDn+2fKGf1+pIIw+EI4NjjS6Aogy/DN46xnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574882; c=relaxed/simple;
	bh=PaE7mEZfJxLBb2yt2DAyS73D75IvOfORiK3X0XZJW+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aW2cfb9qnT15m+FVr2KtJidk7Tmz7dr53EzHJqV/p7dKcaW5y5rNFbrVsBk0aXlreL3/NP2cPXlJxNgnr81zDAOsmOxDg0MW+60zz1rOHiFJkXUQEW+flx8Zb8p2nw3YYrdZWjxLrmGDNyuA6JWEPfdxrtovQA1pe1Yqo7qHsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKb9SgiM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4213a2acc59so45255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717574879; x=1718179679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrCOiRPfrbF8KgkjXf2+OjTb6u3WQ9a+GX9ZNmr2TUc=;
        b=eKb9SgiM1Ywd2b2fjnigch5afjE0A0sA+5Y+7Kxa2Ik6GFQm6MkPKA79Jf6P449FLk
         wkY5C2oA4Okd3khdhVjQ4RhEhINz8LklGcuS5CSfFJfMdOfHhPxEK/TnzPk3p7N7KVei
         6P0nm/NjadEW9M5E9wJBsIbZGCbSuL0K/Dpgo54/+8521YoHQ03NS8S12V7PQGJH0uEp
         q7R4HJeIWQ02V3hIgr7kl+rS2tJeDipyE837GUaoJmxzsvx2WwXKn+jj4ShMW3xe+4Oa
         YN1AfOk6ku8bO7ZqiOQireFUzTDZPPl9Ccl8J+9kwWddNwsIIhS8JYop0nV0X7iOuNqI
         +1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574879; x=1718179679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrCOiRPfrbF8KgkjXf2+OjTb6u3WQ9a+GX9ZNmr2TUc=;
        b=tJjuImwTwVqzfWDGewRrBRz4dOjFHVXXM2Qmxn6OzEX/SI+jLaVumv9/pyLT+bF87K
         wdlC9rbNTIKPBR6Z49Xgcw95bnPFndWMylgO6kudWjeHOvQLE9D8Qa477wJzna8AVtxd
         r4ZMnm3LVPbWzXNAQQqtW7k9MHtiE7fFmTl0lGRbu57kL7QMTJHWtNDjByuJtpn3q3L5
         BlN/ahJiaRXSLMyThQuZYfhZer0zlrPpvfrA/VX/Q3l0U4HlPXdiZpmyG8mu6I0cxOFH
         zSTzoCAIbTjofX2vq+bKax3U6nYhsKZO6g7MfZk9fuzpEq8sbGom4Ks/M2IQnNxFmc2/
         ooIg==
X-Forwarded-Encrypted: i=1; AJvYcCUjMcGo/pLwZ3nEBAkhHnheyrCSxcyEkPe+HNd9NHzzmUArLf784l7BjdjPaBqe0++sb3btU1WqZcxEKGLrhp0gTygTgK8pzD5Qcukb
X-Gm-Message-State: AOJu0YyHywlupm1PNVe25BdVSBLNt1t3BR4ofjPZKRcE9kswt86sbZbT
	WD2O7lUaxHX9KgqBGsBox8IDFCtsq1Dv4hlNJoNsGmy4HGVVwA1OPWxRcoRdP38JtSr96yLq6bb
	ysYMR6EA+7kTZxwK3Hp+uY3Qa8PQLhDrD76g/
X-Google-Smtp-Source: AGHT+IE+9uivXSD5/gDpelbCKai6RvbBA7yxMmFIucAYEXrjABgLZaNA9/zk6SuWHQzcKrc0ReHGu9NE100jrq+FnwY=
X-Received: by 2002:a05:600c:2942:b0:418:97c6:188d with SMTP id
 5b1f17b1804b1-42157e4cd5cmr1243755e9.7.1717574878367; Wed, 05 Jun 2024
 01:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com> <20240605-tcp_ao-tracepoints-v2-3-e91e161282ef@gmail.com>
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-3-e91e161282ef@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 10:07:47 +0200
Message-ID: <CANn89iLHGimJWRNcM8c=Ymec-+A3UG9rGy9Va_n7+eZ2WGHDiw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] net/tcp: Move tcp_inbound_hash() from headers
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:20=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Then we probably do not need EXPORT_SYMBOL(tcp_inbound_md5_hash); anymore ?

