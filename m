Return-Path: <linux-kernel+bounces-430647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8574B9E340D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3516F2854DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379618C004;
	Wed,  4 Dec 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfEyJ6mS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D3186E52
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296932; cv=none; b=D11r6o2Nc3Ti4v30Npd5ooHlFXFYuGCyltQW/eN8fiDCaC1EG7UxKYcm0ppEbpTQ7yLHgbY3/L61VQ8tG0R5vyi61E6GXnEiP7ccCOnB3COYTQw38+Okejt77mZniKNy5RUYsqB5oQ/TM4Kz4B9sslTvYjbTfhpFKUgFeh/DAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296932; c=relaxed/simple;
	bh=xSY1xOn03+jBYXSAmLaphxatJL1dJY7kW6ry5/VCINU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqL0SDvq1KGAlWSaia4lV/V5RDgkzb7lDEan/4B0DAMlTuwbDXYUu0X0a3y1HDSN07p797379yhs49g9931EbEnoOwZ8llHIhDUGJCAl1+2hBJ3Zj7TkgVLmqHmfq/n4ipVp4bb6fReJFyMI5jzv4Ho86pYHIVOR4WMTe1qdDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YfEyJ6mS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa609256eaeso65233566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 23:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733296929; x=1733901729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSY1xOn03+jBYXSAmLaphxatJL1dJY7kW6ry5/VCINU=;
        b=YfEyJ6mSnMpcZgTi3LviBmukSlOMQBJ9Oyl8c8tH6NsQfFSHytPgoyiSyDAQHSOb6J
         0l8PuCE6TW6FMGaWLlcwo5xnCCyPgxIFaRdqX3ZUTUQ+GhASXQdgwawGfqetxg9Yed+I
         FAchfJG9mOScwwrvtJyraVRyW/ZZrKxRk4psPM7DGL0riww1XPdNqZBNGV1ZxVUXppTE
         riZ6h6ZIHSBjss8vg4CEiBQST0iWWd0DuSop/LcvhvcKH0WBCKQyacQTQCAqpR9ruWa+
         ueupr5pLvHLc0f1iz1bYupDs6XN2yNNqk4sYFFHE+9wNOWVflGECcSi+6sE89ibA0sv5
         gOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733296929; x=1733901729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSY1xOn03+jBYXSAmLaphxatJL1dJY7kW6ry5/VCINU=;
        b=BitW9yo/HBTeqpAjwA0nSfMcPk9TiEhW4knfj7Yy0AUgYNEIXGVtpcoh9mvc1OZUWz
         4XzznWIR6uKh2OwWPoC9qh+pLM8ato4dJ3kBAWCPPVT7WTBsaG6tH7KJ7QLOwYUdTZen
         ZOrHlJDm5xf035qzZkU6NyODK479oFCfcVhzH9geQIM/sI3vqUfc7rU3vhlYEPb8myx6
         UhqJzwf49n4uoGl7EWwWMER4lbYMsmkCECG1u+Fm2YpS46cF9IXj2HKQG1Axk5uMrqR7
         eJhNZNbDnii9NiYsE8z021wr7qbg1CzSTJP4jGOISq6HUpHqp9MYAzdks4wSkaQmAq55
         X/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXPwsJxJwPziKz9eUzbzho7uM+RLlqZh2rn+vAVB/Xl18x0GgmV/U6dWJvNjRv+H1dwaIJcb1I1Jw3jUvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1pzCV0pRo/mau9vG6Db5rAeD9xpw9IcLVgImapKqXKHHqAmZ
	q1rElrNDbG8AjCUep/37JXi+oN3RQcr/+J37MH07WRnhlxtsnyof5UzplbXhQhuAB3EzfeGZUbL
	mmhPO+2ZGxtWZ7idnIf54cn48j1pL9VG1DCLt
X-Gm-Gg: ASbGncs7ONTMjo86GpVYWkbWM7653iaDNNBxGTI7XtcQ8ow4yOVDQnwkMU1o/24//r0
	L4gbokPIzFd+3hN8si7gUDMKHYOJ8VrOX
X-Google-Smtp-Source: AGHT+IGpBZTnGtesgrcNut3ToABnK+WsP7f7dWn5y/MoNcxEFWzGR5oaAQN5TfGpP+ylTh82Dl/3tpxaVRPRfDGpbp8=
X-Received: by 2002:a17:907:7758:b0:aa5:3f53:ad53 with SMTP id
 a640c23a62f3a-aa5f7d8d1dfmr405251466b.26.1733296929224; Tue, 03 Dec 2024
 23:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1733279773-32536-1-git-send-email-mengensun@tencent.com>
In-Reply-To: <1733279773-32536-1-git-send-email-mengensun@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 08:21:58 +0100
Message-ID: <CANn89i+ZtxW1HoiZaA2hB4r4+QBbif=biG6tQ1Fc2jHFPWH8Sw@mail.gmail.com>
Subject: Re: [PATCH] tcp: replace head->tstamp with head->skb_mstamp_ns in tcp_tso_should_defer()
To: mengensun88@gmail.com
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yuehongwu@tencent.com, 
	MengEn Sun <mengensun@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:36=E2=80=AFAM <mengensun88@gmail.com> wrote:
>
> From: MengEn Sun <mengensun@tencent.com>
>
> The tstamp field of sk_buff is intended to implement SO_TIMESTAMP*.
> However, the skb in the RTX queue does not have this field set.
> Using this field in tcp_tso_should_defer() can confuse readers of
> the code.
>
> Therefore, in this function, we replace tstamp with skb_mstamp_ns
> to obtain the timestamp of when a packet is sent.
>

I do not see why this patch would be needed, we have many places in
TCP using skb->tstamp just fine.

Do not be confused by unions, this would be my advice :)

