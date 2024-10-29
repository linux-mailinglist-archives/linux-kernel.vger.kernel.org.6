Return-Path: <linux-kernel+bounces-387525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2C29B525C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB7C1C224E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9820720B;
	Tue, 29 Oct 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfIurEp/"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E21FF7CC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228542; cv=none; b=HBBSgeqis7TbpWZ7j3WBA6Y9nHXYGiPhr7pCDYc77w6Rx+MqjP/JDOhdLO2mhqK72SMbeadMeEmZAyfXwRfxOqTUSJlab45h4+tXxtri2O5o53JDYgL4Q9mCE/xkuhjIrnhkJJg1VAGH8F6Rtj35eLmz3i5rV3gpqZ0U1ZxdgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228542; c=relaxed/simple;
	bh=KjlQZ1Gv1yL4gXu1X6hUwgK6fbUlX4cKS6CmWEbCjrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyc/C/yvPWLI7Rsigz58lHgp2yBEzLmg5ba/+9C+olWYRYtfAIezC3h59PLefcAHsLAZ4tmoLxtIMrcGaSuv2qWnLoOPSwz5/pZVantyTU82V+kYo6eKIrVRmtSTnV7n4NHPcMOK2DcEAHR3jpIixxViptL6KlzLJ40ek5tJSkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VfIurEp/; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so53836531fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730228539; x=1730833339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjlQZ1Gv1yL4gXu1X6hUwgK6fbUlX4cKS6CmWEbCjrs=;
        b=VfIurEp/KD3/rCOMK/p8S5PSlK8lainQvKjjzI+8v+bX2AJfEATWYR9xjHaSTx6XZo
         fv0o2+BT+a66tDaxuot5XJCdEA2STuNtTbCbFBPJNW1XuzGVYWUfDvk9ePGS/E1wWsL/
         X9QTjUwJT/yfek7r+VcaCJBkPB0EBl7HTq9UsefyaiIay5t25rQk5KgWCXMQ1fle7NyS
         z5QqFr0JRVEhSPBZXorE+COJyJRQ5zKru8cK+qjxk4R5IKvNXcP08WmRQb90ia11DWuu
         a9JjABttiWg6nEpENZXmZUuSSB6SPMzDdcwdoNDQh2XvUqRGrkdjzmsM1w6J+pnYbwDO
         wcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730228539; x=1730833339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjlQZ1Gv1yL4gXu1X6hUwgK6fbUlX4cKS6CmWEbCjrs=;
        b=FAXMkKTo645F+4Igyf5xI9/uNFIMhoUcx3XNf2+cJP3YA6Xk5cAOH1ZHeZD/mITX/C
         NsuCnisGFnqP4TFhCPeCyBf3SgnGs8+qdxZMmuoEmnTdjl566ZbMbwGXMPSfRZcw3D5v
         jxPhffP9KkcU1+v4ZFb0UAuam1wwYudorHtL8mjr/bGOlDfC7b9ZUkviAa4MvL5cUeMK
         NJupejgqNmOMgNX6wdQmIRpboGYOAmDfrLusKfwxMrRorO9ymwitKNH/hHI6FqDeCw6X
         TvZJPGX1zm81pLbq9TF0reD1lgTEffaY458JVkJKScMIm28Ek9czmiJDtQgXjWiKbcPd
         d94A==
X-Forwarded-Encrypted: i=1; AJvYcCXoDP1F9zkOnTwLMcf2gXoyRJIiwBVCJ518u2FpXkBd9ZQ/BKu96P7DFpPJb1gY2GPGhjAze44JlMtvh2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3RLALMrEeDd7A6kaoCZk8y6MqOTQDH2MeWOgjedWnOnIL5b3
	r7s6rYMAIZg6pVDZe38m70MxAnz/pVe8VGHJGrUW0bhvfq6AWket+v35dZ9xqxFl76uzSNDw5ik
	xw7TPI3GXjVAfI3DCB6doHsEtJCkXmcLrsijtT+qDBDqGkiSVxg==
X-Google-Smtp-Source: AGHT+IGlQKynFIg/6AkltXaZedQLOizW/ZHUaW4WVMStWQrf/UL6qsSkWEP1jKmIeAetbQS4AUGF+zYaT9Jbv5qPkEE=
X-Received: by 2002:a2e:811:0:b0:2fa:bb65:801f with SMTP id
 38308e7fff4ca-2fcbdf76eaemr49678631fa.10.1730228537367; Tue, 29 Oct 2024
 12:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029182703.2698171-1-csander@purestorage.com>
In-Reply-To: <20241029182703.2698171-1-csander@purestorage.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Oct 2024 20:02:03 +0100
Message-ID: <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com>
Subject: Re: [PATCH] net: skip RPS if packet is already on target CPU
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 7:27=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> If RPS is enabled, all packets with a CPU flow hint are enqueued to the
> target CPU's input_pkt_queue and process_backlog() is scheduled on that
> CPU to dequeue and process the packets. If ARFS has already steered the
> packets to the correct CPU, this additional queuing is unnecessary and
> the spinlocks involved incur significant CPU overhead.
>
> In netif_receive_skb_internal() and netif_receive_skb_list_internal(),
> check if the CPU flow hint get_rps_cpu() returns is the current CPU. If
> so, bypass input_pkt_queue and immediately process the packet(s) on the
> current CPU.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Current implementation was a conscious choice. This has been discussed
several times.

By processing packets inline, you are actually increasing latencies of
packets queued to other cpus.

