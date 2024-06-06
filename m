Return-Path: <linux-kernel+bounces-203819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB478FE0CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B401C24C77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EA613C823;
	Thu,  6 Jun 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbeIZ23h"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028913C819
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662101; cv=none; b=H6x7Ui/BAURywaNaRrtf79uFBZSul9vmVWDlJuB2cMvnfgdQSuXA+I3dGBcl1gSG+6gBsU/caBbsAxTbI9Q72posHc8TrHtON4fznPdTlXNRfaVWGreHx8BUd7aqsyiNa07r/SrU2UPpfgttYApuUYlw64kOpca/iEZWjxI154c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662101; c=relaxed/simple;
	bh=aeK3bnvjs8VEJFtu6HdqB8LOAkT/9yDIQ2qbTFkOBF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXFkPxb5X1ahBPAnnvtS7DJKphDKXP27L0IFhtzCQiCCRZVkCqKZssMOku0yIPsAvYxpVl7JtHqKQyW7YerDviT0DIckoH0Q7skPdIPJZR5vI43d5BSoJjrgaKbS8dO3YLdKJ+T0E/cDw0UoUcZLX33xwUEn+XFYDrCFufcA2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbeIZ23h; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a1b122718so5673a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717662099; x=1718266899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHvKEz5JKdCznxSqHezsMu71OI+px6uSS61YT0rHfuU=;
        b=HbeIZ23hH4Ka6f0sKo4cmwfPcRDkIuYnzfJ4YYdcdFAdHOyVlJHRQ7Q4GwCIFGS9NI
         0zKVt0qSorWejr5JOpr9BSHR7kBSLdfnqh/4T/C7zP13ReUl4P/GOyqWnW+qCo8iucL0
         EGB6lh8oVGUTv/lIM6LlrGL4xBsQm3mwP4EcqgXURRUpbTsgyJGaVyxKzl2tnJBPKLsH
         zllNASFbBpxhLY+MGdzZqfjiNeWps8qQHAWmWUmW0Sn5obRn1M4ji++dLAHPh96iTAGA
         2kxdX0wwhJXQAIy130emN5Oom2w3OQ1VsAVVLW5MJGIw0wnQFAp7QZQZ1wALR3UdCA35
         lQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662099; x=1718266899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHvKEz5JKdCznxSqHezsMu71OI+px6uSS61YT0rHfuU=;
        b=WhpOgHTmgq1FyfUsMD46xk4uQiTpZvhJjujLay25zzexoAu5aGVZYqY3XwBOt7duPA
         XctKrvgVz1kfr0QqmgGcXboQvWuvwFNabgDDswP8MaPeBZkvwTJnQ0a2VfaNV1dfwaoH
         6QWdyiO6/txWXpQmuBiyzVMwuhe147SfXkvCeWFEImNIUwQt6Kt/Gaszke1ogvzN+Mfv
         MSWllfVkTdJpo5I4JyuzA9RWWEskgojV3cLXxzi02x+GyGqOoIH3W993aEtx7THbnKkM
         wHbzdtlycJJ0VS6BBwdeGu6FxTEtbAVgvf+kkiBkAJx53egfCsP6gSOI/ppx1nZpuE+i
         2gWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOFMbi1DTFEvd2v1yfNjiNHVHLxagCFwCHo2l/xMUAvzjDI8xFWpuxqO29HJ8CTp4d+4kyw7wt5g1J9wN8IlNTEYSQiQvw2lvi040s
X-Gm-Message-State: AOJu0Yz/rTWkp6h5MtqYj0xX1SJJ+wkiK6f9oSWj0oVU2RzOVqcgTyWZ
	gPwU149EH7nhEEoShWjow18Y+6oWS5DEIG+1mb1hc5D/NARizRY+e610RNqgLEm3+VVlP9iN4wz
	jpCk3x3Qx/vPl1RAkN+BN9ZJB+YsgQM4Yv/Zi
X-Google-Smtp-Source: AGHT+IHh2yQO2i7W4TVOkZXhb8V7bKamRBQUc7Lc+uRHNVgFKKNhugjLVTkGob22mKGuMH+YwFRJbIKAat4YiCfDe/0=
X-Received: by 2002:a05:6402:180e:b0:57a:9ea1:f92a with SMTP id
 4fb4d7f45d1cf-57aad34e850mr99772a12.7.1717662098423; Thu, 06 Jun 2024
 01:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com> <20240606-tcp_ao-tracepoints-v3-3-13621988c09f@gmail.com>
In-Reply-To: <20240606-tcp_ao-tracepoints-v3-3-13621988c09f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jun 2024 10:21:26 +0200
Message-ID: <CANn89iJyKWuZ4DtegJR99jYaSf-kbhr0gSosw_XGxjiaGT=00Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] net/tcp: Move tcp_inbound_hash() from headers
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

On Thu, Jun 6, 2024 at 2:58=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>
> While at it, unexport and make static tcp_inbound_ao_hash().
>
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

