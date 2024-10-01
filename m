Return-Path: <linux-kernel+bounces-345970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBAD98BD99
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44011F21713
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2277F1C462B;
	Tue,  1 Oct 2024 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mc3CRff/"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A691C3F18
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789352; cv=none; b=EfM52ei0tKnqBBKkFqVA1IL8MU5ZfptnDyhnXB2zcZolapp4u5eNOgAGnjF1wH75EVPVRqZWp1UxK+nN+5+d1oVSTvHwj4VI6bbDEdonktuS1Sgh8pExRcQjIv/hSDMBmUqMYWI4mpRYfZkzJr3Dq4d9gPd09cGJQmg8mNtMH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789352; c=relaxed/simple;
	bh=3N5Oa4iBwWJMrHwO1iOZ5iDlia5jS2rBTR6Q024+txc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiqEKXTwyEDiRMc+J53lPcr5M6duPp1pdufiFkDg8VMFbXl/z4HyOBwpuxS3EFf8PyUaLxtDnNhnLFIpBml3N+aRYrPUTOKnUgZGHEYQhkWNtHNOukephNErvcgNIrfgCRQqfST/XoL3SKtTJCs8LoFAomUwpe6LgWFE3SHyazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mc3CRff/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c88d7c8dbaso2274414a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727789349; x=1728394149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLR5rUKxjnbtEIA0BFW4FvjL4OXH+X5CXBSSE//MCSI=;
        b=mc3CRff/BmHH4Il1Jq8zQCpWYssJHOeDuuWk6h+MCnSuh40j8HVwVzShZMUjCc4Sdv
         wMiHh+ODBvoLc0UB77pxKL6NmIx8ifPwgdlZcwpSeJTxCazDPL68Xg9WXFl0I8O234N/
         k26Vz07sJw8Br3S6/hZAMAYWzu8Y7rxwGg7ShcdyH9yclGX/PSfchE4nHeH8qRYxK5wz
         S8mbzxqrQU/OHKL+bWKSfUmY5iko0NH59risMzFB4m7yRXrmdKGpNyjMwT7n7waXq8de
         7G8YTvMCmJt8UWtUFG6wvMPbnkIkl31L5O5eNqsnuM/yDcfUOa6Js2+aOVQ2sznh9ULP
         Plsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789349; x=1728394149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLR5rUKxjnbtEIA0BFW4FvjL4OXH+X5CXBSSE//MCSI=;
        b=Wojkynjeyt9E9h70+ONYUk24IPulgUvK0Q2rXQtB4SPaHeFs8pwgT0evlQrMJIWi+d
         d501tidgvLrGeBrchk/63Ov9uSt8Jsvq+S2AtwEbau1mEgafqSstoszpMUTzB/v5nUdy
         lZDCJQfrU7/urrjlLSNXHw5p8sVnHJWKb1+smFn+G38tHbYqzJMpgntA3CbxD5zIaqgM
         7ODAcbvt/8jETV4FHOSmKmI8HNOKvecZFNoIAA5OeGqbUmq0xvfP+IqKJZL1oUFL6apf
         fZSEaPYFbXu+YuM0wEULaaykCBhJgwBQVAdC3VumIX+lHyWMo8Iw52h6S/HG6pZEG0gp
         rFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfYbaogdC+6QcunLzctfpIO45/tYbqudJVufxGLKPQ8fY3a8caHSWYe5qIoYvFiHnrxTLZ1WbMc1fl1r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNISNmqAJgMAq5e9JXQm6Xx/ETeYdRo/3xWrp8L85HnFwaWlc
	62RmV7TuJ7QPH/NRoxclHDddXgqAfPFO3r5jyAItdr972qNeADGCDwLvql58QedWV27ay3qpFz0
	L9BaQ5rHtm1QatOtOBvnsMmKqnI1511BhavDX
X-Google-Smtp-Source: AGHT+IEMUuCHddG9Vk6YID/f1XHxwlEJTI1pb6l0JQq2CQQDsu5DKwV1+Y7fOfCRHUcILD/kINc6pUMJQz+zJkjsiGY=
X-Received: by 2002:a05:6402:26c8:b0:5c5:cb49:2f28 with SMTP id
 4fb4d7f45d1cf-5c8824ccdf2mr22823763a12.4.1727789348992; Tue, 01 Oct 2024
 06:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001132702.3122709-1-dhowells@redhat.com> <20241001132702.3122709-2-dhowells@redhat.com>
In-Reply-To: <20241001132702.3122709-2-dhowells@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 15:28:57 +0200
Message-ID: <CANn89iKp47BVt0uGEbCuhEhYvMDy=6+cpp5PQTNQewPWxr_vyg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] rxrpc: Fix a race between socket set up and I/O
 thread creation
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	yuxuanzhe@outlook.com, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:27=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> In rxrpc_open_socket(), it sets up the socket and then sets up the I/O
> thread that will handle it.  This is a problem, however, as there's a gap
> between the two phases in which a packet may come into rxrpc_encap_rcv()
> from the UDP packet but we oops when trying to wake the not-yet created I=
/O
> thread.
>
> As a quick fix, just make rxrpc_encap_rcv() discard the packet if there's
> no I/O thread yet.
>
> A better, but more intrusive fix would perhaps be to rearrange things suc=
h
> that the socket creation is done by the I/O thread.
>
> Fixes: a275da62e8c1 ("rxrpc: Create a per-local endpoint receive queue an=
d I/O thread")
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

