Return-Path: <linux-kernel+bounces-576134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B1EA70B74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC375170F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518DC265CD4;
	Tue, 25 Mar 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2E/lEDr1"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6C1A0BF8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934320; cv=none; b=A7HGL6sSWLRiZOMhAf59QSYLn/8jrxN0UnZlNMyXMkr3Iwmhz/ND9HA6v/mz0GLcGQ4kN6/D3RpO2ldY0HacZ0r0lynqfqcWtPGOQyDAvmiYiFulmDWlbeHyTFQzr5V6gOVgskMuJwRBdYjSbUZ8sW4AmzS7ISyTYaIxOJpPDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934320; c=relaxed/simple;
	bh=K3n6uYEP5aMssXAUsPzs++ObMser+JO2sYQISRKuyLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RPdxyK7y0m6wClzgp0jLObFVCzsRP7umOeFV3MYn7CWteGR/RFS4evOGYvl1Jwgk3/SG7I/2JCmgeQbfc2F+BDHVr/ZaxIb5V6kyk9OHZk0/hi7KU0pvPSlStcm5Zgg0gDuXw+OwB+X8FjvcSgzhX07JTWq9AaTjA3ilUnc7ZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2E/lEDr1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3015001f862so7606620a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742934317; x=1743539117; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jHfAuJ+gsHK6UjPmXC9eET8PRX5/lcYBB/XL+ivaVw=;
        b=2E/lEDr1ID1+7OJbbAG3a3OwuS1/hAhT5YBU2+DMa3tLbnW/sWXmqpzH30FNAMD9mP
         isihJPj4sELMm7d1OBC9acIT8QXL2V3jFI+D97NK4Dep/vmbpeeVNwNnvweO2bvxNn3S
         a2VfZlp2gZ/Z85eUzUP7wkXhCeuWWnRLnXd/pyks5sUeGyiX+HDJ93JbCioGKpuxFQvc
         VqWG9uZiU9XpmaB3aOc3M/4U2gi02Uf91o5zW12ebFJ8N/LiQgqzEHmlc8U9a9m4ZyFa
         Hedb6ypRDFoT0sFhiQKQySJO0pZOuf1UnrXtLrdLtWydpqsd8xXY7WtnqlGCoAKt/ZuG
         Yeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742934317; x=1743539117;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jHfAuJ+gsHK6UjPmXC9eET8PRX5/lcYBB/XL+ivaVw=;
        b=CYHY+OCpi2rSFsBvPTMt8L47TSrYyJDdOkPX0QGWtkSUVjXcuccWx6f+PRi5UYoGHH
         +4uVyh5duDCPGHW1rffruWFfR2C0Hbs4bFpCKEiYhufVZbYl4ERcmTF8gquzJ0biWVQm
         FFW9L53qtvCLWeA8DkxMjNvJ6aejSibPoaNZFCUaA8eDB2sXolF4oGF8dSGx6SbmG0b5
         fnvU07mXIlZol31sLhWLG5b1nPdRQ72dvAPcZMBwanTEhiz6JtXpH0vbr/XT6MKSXQCI
         O6YLQ1xB82q88CQ3P8PNXAOUxz7D31SRdFTlMxch25csaVxRBw7ANSp6pSgrP8D/X+aL
         iwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtL8EzNsr4wfFEbyIbpb6xLDUMOMCKZwPLeN3tLGBuNLDEoPiP1xugvWRjukYn8++fbymGPAB3deQEmtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNgMGvrytyR4AQpAgWb/Hl3wJJ0w5ZbaH/sujNztHWIzyhNju
	iGlfdodj2DcM/DU6x0q4akw+8acEV8M/R35npne/3RrxqU9s/+3NLlUEjFkr3A==
X-Gm-Gg: ASbGnctWowpawfwEkeIm6doS134QvIEc+wT411sTkDiI04sGkZ6fF1h+lkBVpSDqTQ8
	EiFwmIpMSk+w2fu+Ci2l6TdGSB3l9dFibmg88KnQ16yswsGRhaOkkovRED8Dh7t91apCO6Kctyd
	VhmTzFuke8vsAnZjcNT9qoR0f5Rmunuqdrkxt0gFvst5OfFSM0KFke6cucQ4KK15Va4TWNdfzNl
	KRursWGqM9NTOiaEXuLTnDnFTqcZ4IGIX5/IOtOOl56SHyfxzQ+z0Vew2RWLMlcuC18Cq/J6+e1
	nyiksTPT4afj9I61mPNS45Oo3xzhXBjc2eacPIDidVjEgsXjpemee60MLmyZm48mQrKYkij8FaH
	bepJpdOYcT2rEVY/G1ZBiEpuXqq+rTCdQ
X-Google-Smtp-Source: AGHT+IEdkCdnQe5BWaB3kbs17NeCm0iUUY4vmOoipeh3wSs3QX+knAUrOwzJv9++lj8+XPonZ9DdAw==
X-Received: by 2002:a17:90b:2647:b0:2fe:8902:9ecd with SMTP id 98e67ed59e1d1-3030fe7223bmr26888965a91.1.1742934317334;
        Tue, 25 Mar 2025 13:25:17 -0700 (PDT)
Received: from ynaffit-start.c.googlers.com (255.176.125.34.bc.googleusercontent.com. [34.125.176.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bf0sm14848747a91.7.2025.03.25.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:25:16 -0700 (PDT)
From: "Tiffany Y. Yang" <ynaffit@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  =?utf-8?Q?Arve_Hj?=
 =?utf-8?Q?=C3=B8nnev=C3=A5g?=
 <arve@android.com>,  Todd Kjos <tkjos@android.com>,  Martijn Coenen
 <maco@android.com>,  Joel Fernandes <joel@joelfernandes.org>,  Christian
 Brauner <brauner@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,
  Alice Ryhl <aliceryhl@google.com>,  linux-kernel@vger.kernel.org,
  kernel-team@android.com,  stable@vger.kernel.org
Subject: Re: [PATCH] binder: fix offset calculation in debug log
In-Reply-To: <20250325184902.587138-1-cmllamas@google.com> (Carlos Llamas's
	message of "Tue, 25 Mar 2025 18:49:00 +0000")
References: <20250325184902.587138-1-cmllamas@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Mar 2025 20:25:08 +0000
Message-ID: <dbx81pukx3h7.fsf@ynaffit-start.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlos Llamas <cmllamas@google.com> writes:

> The vma start address should be substracted from the buffer's user data
> address and not the other way around.
>
> Cc: Tiffany Y. Yang <ynaffit@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 162c79731448 ("binder: avoid user addresses in debug logs")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Tiffany Y. Yang <ynaffit@google.com>

> ---
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 76052006bd87..5fc2c8ee61b1 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6373,7 +6373,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
>  		seq_printf(m, " node %d", buffer->target_node->debug_id);
>  	seq_printf(m, " size %zd:%zd offset %lx\n",
>  		   buffer->data_size, buffer->offsets_size,
> -		   proc->alloc.vm_start - buffer->user_data);
> +		   buffer->user_data - proc->alloc.vm_start);
>  }
>  
>  static void print_binder_work_ilocked(struct seq_file *m,

