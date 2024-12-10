Return-Path: <linux-kernel+bounces-439907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26D69EB5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110B7281750
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4E41BFE0D;
	Tue, 10 Dec 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sD1sQ5NL"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B21A0711
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847172; cv=none; b=iI20T+Mt0ROS3RkS1lrH94gC7N2hvJe+rRnI5fFEV3Iw+bBTNfzVz6JbXa6DNmy6BGs1I8hpaY2NRBCW8H8Kq2K0V8QeKPyP1j++uJFzzyJby+XwdJthzBfiK0Hp61rXJDlCZIgJs8f6YdwI3rgMi6+aAPDp+yzbhfD29W6lilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847172; c=relaxed/simple;
	bh=IEEi6Rs914XyJs+OK5nkfUNZ57Kyhb85U4z8bcFbL2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svK2VSQMspFxpCXSq8JwkinIi5x/DrY76LOZyzg+qBhJmrjnHsOJfVqXaIcPtn+9jL9hQEm9tGaMx3IIsz2j3QDiQAm5FUqwpEzE072wpXkGxq5mchztPxN10BvyQEo6HKcGMRqxUqFJfXcd/Tu4fKin/iCm8+U4ujAQnjOYvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sD1sQ5NL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3ea065b79so4396919a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733847169; x=1734451969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEEi6Rs914XyJs+OK5nkfUNZ57Kyhb85U4z8bcFbL2o=;
        b=sD1sQ5NLqBqIHikLU1Jxpgt5cxV/2vSow+crbeVGudUxrSIppwpDDugwUdWm4dAXr2
         BRmQZgRePiaoPTBwN7lrMMu60aR8Yl/PSPTQJkizhJDQYrMUZaqGlQKWfrgiUHYk96cU
         yV7Scumy2/jGwUMmQAJDKppYsCXDMSYcKBt+QBfkDgKVJPraF0Jroux0o4McnEEbx8WF
         hDx+C7UIZndQ009CTGICrxdig1N1XUiudj15HRcovqAuklY8EG+3IGGIyw9bSZFajqj1
         xV0Tv+cesK3VIW/VKGQBaRVf02UMd2sabcMXlZ2w8aALbx9hBKy52iSZ+BUeZGAnwdcX
         2niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847169; x=1734451969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEEi6Rs914XyJs+OK5nkfUNZ57Kyhb85U4z8bcFbL2o=;
        b=gM1urx/Gmj7bqLaI1yLD/7s5IQIVy0MPEwlh7DZEZpR0blvBkQhID7Q2QJEm8GWYMM
         LDAqjBQNZ0gf1inBHHiOP7U7g6IcFY+iNTVGLivAjQpF2WyM2ahwY/B1VQl+NOvmCO4w
         up5IJQgF06kQeDdTx6lQd3RNC3RTj6PbAIL89xdPFblyO0UdNyIiX15J23TMcyMlOInE
         iZEajZ55KnHaXerAsUOYTLARD/erfgxOgE2n7x0AWw9OIx2Er7yUQ0DJ+O1j/Zi06Ddw
         d/PRa2jxc68uhOMdawBPrhg5aa22o/No4EqObEPBpATpCYw+CLOqhJu8h9CGrk0crzCc
         1yow==
X-Forwarded-Encrypted: i=1; AJvYcCWv2T/RPZ+XxfowXtJLM6MmO4bZFyqeLNS72/u5etWjIWsf+JBrAuq9LWxeb8iPoXzok+VPyOCxDUuepJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLUO8wgfp2ja42C9vpvHMz47VyiOTYE9rZBqxf4vvJ0yBmbo6
	ha7aZExi0gPJ8YqWqaPcFsdDU6zbcaKCufV0FjsLg/I2FI2iF9sFzuqly3pdAu+q+CSMHr9zJc5
	lzFOsdwmchKn8aVG9gUP8/A/DvGoJTjINPsQI
X-Gm-Gg: ASbGncv2OwNMI+/h58k1JnpKXgwQAfyvcHNMYMb1FafKEqp0H6L6uO0iSCEAQCDmgXA
	2Pyk5Gel759tGcOqHx6tmJEyitwF+fp7+CdA=
X-Google-Smtp-Source: AGHT+IFC/KNyJLyHI2/ye5Ac84Q8Z6BtOd46kGclCv+WlL7f+aQgPRnclsq5M6vaWLh6SgB/Z9DJNBgT1+mVN6Bg9Lc=
X-Received: by 2002:a05:6402:1e90:b0:5d0:d610:caa2 with SMTP id
 4fb4d7f45d1cf-5d4185fe2aamr6068148a12.26.1733847168800; Tue, 10 Dec 2024
 08:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1fMaHkRf8cfubuE@xiberoa>
In-Reply-To: <Z1fMaHkRf8cfubuE@xiberoa>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Dec 2024 17:12:37 +0100
Message-ID: <CANn89iLgWc6vZZo0tD0XVg0zY-T-eUjKj4r=O_B3QARjFB755Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] splice: do not checksum AF_UNIX sockets
To: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Michal Luczaj <mhal@rbox.co>, David Howells <dhowells@redhat.com>, 
	linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com, 
	David.Laight@aculab.com, jdamato@fastly.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:06=E2=80=AFAM Frederik Deweerdt
<deweerdt.lkml@gmail.com> wrote:
>
> When `skb_splice_from_iter` was introduced, it inadvertently added
> checksumming for AF_UNIX sockets. This resulted in significant
> slowdowns, for example when using sendfile over unix sockets.
>
> Using the test code in [1] in my test setup (2G single core qemu),
> the client receives a 1000M file in:
> - without the patch: 1482ms (+/- 36ms)
> - with the patch: 652.5ms (+/- 22.9ms)
>
> This commit addresses the issue by marking checksumming as unnecessary in
> `unix_stream_sendmsg`
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff =
for MSG_SPLICE_PAGES")
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

