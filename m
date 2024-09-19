Return-Path: <linux-kernel+bounces-333736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6EE97CD1D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2C01F24CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568A91A256F;
	Thu, 19 Sep 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEJYoNfW"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3419F49D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767378; cv=none; b=m6icunVzX/5MxVzrhx7v+aSfBWPzY18NTdz5eFPg7IBH3ol4vV2k7pBYNGfFkNBb4FBUAvLt8267jJXP8t+rwaAglQatOq2z1ggxMajdIH8bLVH2Hz0roOcu+JOSqaWJDGavvNCZV8padJLeFVe/fUBtRcZebpo0UYviKzj9wlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767378; c=relaxed/simple;
	bh=NGZ4cEDKAvn7ZD3WWvdQS9L8ilhpi9slNO1H0XzN1CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnLAa0o4IRAVzZoutA1HAbw/IkEg09RTE7rYErVFu8U1qPlaHbBGMwIHwy3pVrS3J3If1FkynMm5vOI8w+ZhDmwRPH9rfowsDQyklReZs6PinBcwEeGkoGrTxbCR4GzwdDWb8gJD4hqjrZrp0gg/Xt/4U1ppu2GqVTf5EfTQdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEJYoNfW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4582b71df40so18621cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726767376; x=1727372176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks6hub/TdeqrDb2IvtnQkOnVrN63/vk43ZHL/AB1aig=;
        b=NEJYoNfWV7a9Hl3br8hvbvBChQgdnje6D61a4fFF27DqOLBa5p8WWkUrXqIYdIrOai
         8zX3mhni3zKdaq4rglczz0/fHPsvCTO7fU/ngvm6gD7g/pYzK+2x+kV9a+a2MBiwlQ/e
         2abTIyE+3jdfMJBBH0qvWkfJ1TPcIZuyfNwY4NkXZp25z7EGRpk2h4KWfS3JiDkFGYiF
         lMM/Cy8wk1lanIarJ6k+zT6C3TYXflS/NBfCB9pxtSQL7Sewzi1d47k/9GnYQf2QihzR
         XSHQL7TJIhz3TM9jCmOhE9+eUK7sTGMFSvnHbSvQAT7avExeH4fCJI6THQHW7ZcVTpID
         Q+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726767376; x=1727372176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks6hub/TdeqrDb2IvtnQkOnVrN63/vk43ZHL/AB1aig=;
        b=n/ZKHuixuy7OLo/w+RTTEYStj8LWsIaF1yF/ZHn3JooteTPSocyiwmDUQHEkj3jpGw
         iYzfMW5BhF6L8P5A5N57vBrV/plt1T7nTT1TrgP+UWVon8pElSY+TewhnFaSSaLzRWem
         yMS7SLzjfJZVZvparlfzsE0AMCtwehRGbELlydN6tciFhA61w5uaLpy7t+nNKi6eTXLW
         0MYZ2wW4qKgmXNlVNZcHHVuDX+WLQm1qkkVr8/6aEUD84e2rc589KvOwSvfMKEVylMlk
         tstjYEvag4KM49e7m7mNIu9PKQ3ug/aDwghb9toThUUNjJLUClfVk1MiS29rgjzinwc0
         7vvA==
X-Forwarded-Encrypted: i=1; AJvYcCWbxrHIunFZ7F7dCUnSngLgW1mTwm83cs9jt2qmsw+b+fsC+POU1KcNGQHYuFqT3+EFcHUEq5X4YZEJeoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBvBdBWhrYRFsgeDa1v3rJdlYdu+Co+Ry87ksJhVkdly2c3A6
	r0DagAEKayGcIDkGPXTMmfOzKhsO4OIIdumTTQSZLqK8RSV0T7keT3QvUkXMecDYrszzPrNSXp6
	Tkecg8pYTIsMgbnGYvm8hly9M0zXncfmUlZfm
X-Google-Smtp-Source: AGHT+IGxyDPePzXZ5vLroJBfqbgC30jhg2JJV1is2MmAXIBPxoPSMK7odDR6y9hFSTUVM8bALQXxpktoCrqpSIiFWqs=
X-Received: by 2002:a05:622a:24b:b0:456:7501:7c4d with SMTP id
 d75a77b69052e-45b1960caf0mr3575561cf.9.1726767375970; Thu, 19 Sep 2024
 10:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910190822.2407606-1-johunt@akamai.com> <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
In-Reply-To: <5632e043-bdba-4d75-bc7e-bf58014492fd@redhat.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 19 Sep 2024 13:35:55 -0400
Message-ID: <CADVnQykS-wON1C1f8EMEF=fJ5skzE_vnuus-mVOtLfdswwcvmg@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Josh Hunt <johunt@akamai.com>, edumazet@google.com, davem@davemloft.net, 
	kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 5:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/10/24 21:08, Josh Hunt wrote:
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 2aac11e7e1cc..196c148fce8a 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2434,9 +2434,26 @@ static inline s64 tcp_rto_delta_us(const struct =
sock *sk)
> >   {
> >       const struct sk_buff *skb =3D tcp_rtx_queue_head(sk);
> >       u32 rto =3D inet_csk(sk)->icsk_rto;
> > -     u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jiffies_to_=
usecs(rto);
> >
> > -     return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> > +     if (likely(skb)) {
> > +             u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jif=
fies_to_usecs(rto);
> > +
> > +             return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> > +     } else {
> > +             WARN_ONCE(1,
> > +                     "rtx queue emtpy: "
> > +                     "out:%u sacked:%u lost:%u retrans:%u "
> > +                     "tlp_high_seq:%u sk_state:%u ca_state:%u "
> > +                     "advmss:%u mss_cache:%u pmtu:%u\n",
> > +                     tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> > +                     tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> > +                     tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> > +                     inet_csk(sk)->icsk_ca_state,
> > +                     tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> > +                     inet_csk(sk)->icsk_pmtu_cookie);
>
> As the underlying issue here share the same root cause as the one
> covered by the WARN_ONCE() in tcp_send_loss_probe(), I'm wondering if it
> would make sense do move the info dumping in a common helper, so that we
> get the verbose warning on either cases.

That's a good idea. It would be nice to move the info dumping into a
common helper and use it from both tcp_rto_delta_us() and
tcp_send_loss_probe(), if Josh is open to that.

Thanks,
neal

