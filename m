Return-Path: <linux-kernel+bounces-260084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA9E93A2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09DC1C226CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF05154BFE;
	Tue, 23 Jul 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPN1AZ3V"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ACE139D1A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745167; cv=none; b=oZNbUzZE+dy+SGe0WDM3XfAwOnhr2P0ry/3EIofNXzKib3Q1++8ZloHX1fJM8z7K32Z4N/aPjKi73WLxpezYmxe1I0xEsaS0LEWrdJbMwcP8UpZtDe/IuF9JjdS2kOHltB/odrdTF81VbU5fy5lOKT3gzxXowTYG1pNDEzm0d5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745167; c=relaxed/simple;
	bh=M8QPdNoErhvseqN1OJfQLnvZ1KG36wzCI2ty/tnPpuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6YY8uk1Kr6BsCc6bjU6OAFM7F+j28/6r2ITtCgOeEQWcnuB/4GlyavACtugHftfhFlPFN5WrNrp2r5fBtglhGq5EYdgE9rWxQIXBsHmgE2kEHkz9pqGQNXZP23cn3IAOFvhIFegHT2UDI6DZx1VmoGz1MHFOYxIA+Cj4F+nrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPN1AZ3V; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso17558a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721745164; x=1722349964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/3luC+b74oek9g0LUsZq7rzlOWeW8aiRXZj5lINnDU=;
        b=sPN1AZ3Vbsk5hcuPqFEpKZAh5F5mb6ok4ZoCTgMgl7Vid0Wdv3mAahWMm1oMS5+ht5
         tZGHGDKsm4d38bMuvXCM2ywwhnMNc2+BXYJpzQ8F6/o/k4/EloJa3tlYMZb4bpv/jsVo
         DQbhYgsEmGyUdh3KK6MGAJLjWGwsN+EfS0NusDDpCIW0cquKepJ2G0sVj4s/gitXRgjq
         aU5+ROcyZN/4Va2knTO2k58WQfJMJ0sWLMffaocCH4o8Brd8nDrTKJKAJjn3avrdAasu
         iC/dXog4Fx9Vf88Bny8mNwvfjd+69j8JI8YDP7SHVq2tSqDYO9AHFm1f/g9BjJ9eMwTX
         snlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745164; x=1722349964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/3luC+b74oek9g0LUsZq7rzlOWeW8aiRXZj5lINnDU=;
        b=K0uMnqrR1Qbo0xRlRecvqfXszZokyc+uY9qBNCsj2Q33chskztus6OUGQMu8WJBiPV
         /XFsATNXQuvxE4owytORkRc5J6HrYz5AANnUhWYBmomB+LqfPBci+MBflLw8FocH3z1c
         H8EEcVo0nAJUYCJ42IDeejIZIoCl+jHsCDxrTFNSYAv5ZHRn8oL/C6PWmIkKiO/5qE3P
         79Rx+Mz/3jPzGjDpnlQ8olWBM46uBzYakOIxLWl4qW87Afu6IYxujnWjgnYFnuXnY9zN
         MfW7meD2vMDLDLdMU2KK3roTlLaLcwTR5qXjpzbOn3LO2iZMW4rBANhDjg9u6m3Z3LoC
         CAGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAG2B2J9AZ1tmX2DCNefGvewR5SWT337LGHDGb/ZPfnorAlpegtPV03OJ0/N9/tgjKvMHtUiUFJ3Yzep3PwV0ylCJevdyC9BV0k3a5
X-Gm-Message-State: AOJu0YzbqYJSG6OnaR+5L/b8Zb2LKOthzZFkWQiVAD076BuVRRyyNDXk
	l8e2td4OjJW+E2lzh/no3qHcND2JPRs3be9lVTeinlkB6pea5FA1s5H3HORKH2v3UG5eJio2d7R
	xKjroYsvToeXGbSTKA9c9aHe6a617fi2PZWZz
X-Google-Smtp-Source: AGHT+IHryeGRcNZLCDA8qms03eeDbKTz45Mz5TYFlQKLM2GscLleFt9jBQNlP1av7H7byqMt6vKBSbp+d8N3aZr3M4I=
X-Received: by 2002:a05:6402:5254:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5a456a63b69mr546528a12.4.1721745164063; Tue, 23 Jul 2024
 07:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-2-d653f85639f6@kernel.org>
In-Reply-To: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-2-d653f85639f6@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 16:32:29 +0200
Message-ID: <CANn89iKOa8YKYjz4jVN0R+3qCpcALTAJ_8W+pd+022jAMT+Zjw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] tcp: limit wake-up for crossed SYN cases to SYN-ACK
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jerry Chu <hkchu@google.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:34=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> sk->sk_socket will be assigned in case of marginal crossed SYN, but also
> in other cases, e.g.
>
>  - With TCP Fast Open, if the connection got accept()'ed before
>    receiving the 3rd ACK ;
>
>  - With MPTCP, when accepting additional subflows to an existing MPTCP
>    connection.
>
> In these cases, the switch to TCP_ESTABLISHED is done when receiving the
> 3rd ACK, without the SYN flag then.
>
> To properly restrict the wake-up to crossed SYN cases, it is then
> required to also limit the check to packets containing the SYN-ACK
> flags.
>
> While at it, also update the attached comment: sk->sk_sleep has been
> removed in 2010, and replaced by sk->sk_wq in commit 43815482370c ("net:
> sock_def_readable() and friends RCU conversion").
>
> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - The above 'Fixes' tag should correspond to the commit introducing the
>    possibility to have sk->sk_socket being set there in other cases than
>    the crossed SYN one. But I might have missed other cases. Maybe
>    1da177e4c3f4 ("Linux-2.6.12-rc2") might be safer? On the other hand,
>    I don't think this wake-up was causing any visible issue, apart from
>    not being needed.

This seems a net-next candidate to me ?

