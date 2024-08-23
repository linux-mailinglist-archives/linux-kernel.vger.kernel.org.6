Return-Path: <linux-kernel+bounces-298332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9195C5E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4302843A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F812139D12;
	Fri, 23 Aug 2024 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYgjOGhB"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4753E15
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396139; cv=none; b=JJNFMhKbGofZDVaAJvATloP7/ijQARIawP707br77zDQkDafVCPUb7zAF+C5zLhou1WBBETqb5bMsjahGC1tbmNtBxo1I9eUJqmnQWHz1jfbW4KwuGF0gjhegRDWvZWp5LNr+nrlMb5B5nDabXshJGdK6sVefCqII7SfWFioc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396139; c=relaxed/simple;
	bh=D0VQueHw4ULX6fOt0aSpJWUUY15BKSIWMQJH5m9D+LU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6hwJhmahLZ/FY33iR3FNZn4v5TuwDk6/f0pDMHTodwERLtYaxDqWEpg0I0r06AmbzSZtqTOpKDtsgBx9AI+umt8TqdVRPkOC0dlCkLNbmNbSq4cjCWFvO/N8rkRiR2PA1km60twf8B90Ueh6y9hMpr9uFBSDVUsn9oetvGdIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYgjOGhB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso2066811a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 23:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724396136; x=1725000936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BK1f8PAuYi1kpsTYpr7H+howMVtzb1f/JpVsw0UkYc=;
        b=xYgjOGhBDKT2Tyuf1btb+QeHDWmQ43rjOF25/uc+0oA7UL5gWqRVve49fBOQexTbm2
         zP8r3Ffz+fg0yCU1v634JDL4oQHT0OMEHV91SYzNpPtHJmYaVUOZBlgG/3GzCNAHoqWd
         rgGR9Kd2+W2SYny0Gt6AXVQvK9sR8idZTYFREdQyZUAiApZG3HlJuT0Wfa8RUW2RxQVh
         OMynlJvdu+k+XWFIMV3uc9i9AhCK+yptf3sWTHvuppGJy+hvL3wX4KZqlLXSbhvW6+sN
         /QvQqzyll/mccyL/JmzcfIzUgJf2A+72IebbEg4YyHLvbyRMZEoLxTw6sRQ3MlGbo3dM
         gHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396136; x=1725000936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BK1f8PAuYi1kpsTYpr7H+howMVtzb1f/JpVsw0UkYc=;
        b=FAcqam0gXd/vCGa9vJ5UegneUB1qB/bfZBJ5UJfaZR+LF0E3o2zu90JnWVrsWiQhEW
         LaUzGxdnGUL0qr89g6syensqsCLgLqYGg2GjR3TjYxlIwKhFqDW+Zl9mSti+6iHHIhn2
         DFpNw8n1HbmwZw7se48Cqz8Id1aC8J+EjsPRJals/OetChsLQAu0cdppwSK5BySjNZjo
         j4zAxB/zT5cCVF0wnjHdz+7erkIkuXCUC0nglLi7xjl+rciTv7b9r4XBRaXYcCayEBjN
         TZdiea4Y5UpwqP9MVwOD6LdumF/nkkVDA5h23OSXKRuB01WC9u8yhjAxuTR9yqVQjdEk
         5B5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDfCsjGWJWe9h42uY+MLhP8TMzGtYO08uY+Ou7LM7DqwhrifpHkC7T1lB4wAyvqs96HvxNuQrRWFfOEk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/LA6aEDLEACnHzzlFPVe6eiBH6U/SXOER1IKzHUUnPH2q2rz5
	kNM8Dc7xKx98Pfxnx+2CdXgxnGnBBW5s+5oS8a9yXY2FaGbgv/rsY6Ro80zMYdfVNUE+OWuQbo9
	uEo+J7XoVSVTDqR3ZlBPUzLNO02gQerDh7pci
X-Google-Smtp-Source: AGHT+IEk4GHskWYM7w/d0tb/U+0C4679DLCirKiJQiJJedT4fy/cjLhb/7gqOBCq6xDajmC608WPSWeQHCnh5HuWu6I=
X-Received: by 2002:a17:907:e8c:b0:a7a:9144:e251 with SMTP id
 a640c23a62f3a-a86a518a383mr96776966b.11.1724396135485; Thu, 22 Aug 2024
 23:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823033444.1257321-1-johunt@akamai.com> <20240823033444.1257321-2-johunt@akamai.com>
In-Reply-To: <20240823033444.1257321-2-johunt@akamai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 08:55:24 +0200
Message-ID: <CANn89iJ7uOFshDP_VE=OSKqkw_2=9iuRpHNUV_kzHhP-Xh2icg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Josh Hunt <johunt@akamai.com>, Neal Cardwell <ncardwell@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 5:34=E2=80=AFAM Josh Hunt <johunt@akamai.com> wrote=
:
>
> There have been multiple occassions where we have crashed in this path
> because packets_out suggested there were packets on the write or retransm=
it
> queues, but in fact there weren't leading to a NULL skb being dereference=
d.
> While we should fix that root cause we should also just make sure the skb
> is not NULL before dereferencing it. Also add a warn once here to capture
> some information if/when the problem case is hit again.
>
> Signed-off-by: Josh Hunt <johunt@akamai.com>

Hi Josh

We do not want a patch series of one patch, with the stack trace in
the cover letter.
Please send a standalone patch, with all the information in its changelog.

1) Add Neal Cardwell in the CC list.

2) Are you using TCP_REPAIR by any chance ?

3) Please double check your kernel has these fixes.

commit 1f85e6267caca44b30c54711652b0726fadbb131    tcp: do not send
empty skb from tcp_write_xmit()
commit 0c175da7b0378445f5ef53904247cfbfb87e0b78     tcp: prohibit
TCP_REPAIR_OPTIONS if data was already sent


Thanks.

