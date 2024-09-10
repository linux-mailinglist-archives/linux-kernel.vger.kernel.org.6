Return-Path: <linux-kernel+bounces-323771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F6974339
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A76C1C26090
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065851A706B;
	Tue, 10 Sep 2024 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arjqmhjc"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D919412D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995516; cv=none; b=iDiplXB9X3Nob9kvK1k0MfCNckLkN8yoWI7xYy+QBHFNAb16S/qYiyshVnTAHWSOv4LIEv37nwlw+K23Ncjn3S7q2Sv2JthzLQMXS6k1NYu8Iym3+IcHZybu3LLdg97csRrcQ8hb1ys2B7GhGsAEV3sw6z2Ea/HqK0OnYa2OHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995516; c=relaxed/simple;
	bh=mIMhRZ6m5nTlpwmibRtqYWodOnSO15Fy1y0J8ExRiKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYDzrLdCGlP8cQXffy9C5zB/oDb4rfTJED1x7QpICOUacpJAp8INY1WVAWJ47wIoFvBnzDaCNyv/YWdkjugiIqFshufthpS0KEpyIjiNXdGH0kO/HcK+aNC+rgL+gTAKD29TYhBMhydTJRcxgHAOD0Z2YS1zDbptr7yxM0n2ALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=arjqmhjc; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4581cec6079so400171cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725995514; x=1726600314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g36iS5ARBfGSoilszGwF7tYYZ7uIBHDxPm13BMwIyaA=;
        b=arjqmhjcs5Gx3YvOGDpv4NsY/RhknnA6FmcmdgMfvEUGfPYZD9uM7raDL5gk8vmJ3V
         yKz4UzTTSGUC7T5DEG7vguGjsX6yVBJvENskWHAKSe6pbEM4pZLgBLoMJQXlLkMrsuvZ
         ZgILSk2x8TwC8GySJYXVf6RINNrFi5171GMcjKQJQB1dlzusUA+bhNdwoBYEDETPdu1/
         WOLs3qkFGQC9L/4EUPpLC2/EapberTLax24a0pRMTh2FDyVTxWGXddg6uFkwE3K8Fkk1
         d6yLBqwBiK3MWprHjv58OwS6yYbMW4/483fJwQQirbbquVEDRjx/TCJOcxKWJ8+KfzYM
         IlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995514; x=1726600314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g36iS5ARBfGSoilszGwF7tYYZ7uIBHDxPm13BMwIyaA=;
        b=BCSMZw7AB09gej+iR6jLDbmXBOWUVyE+GFWn39MxVxAwFPPp8XgR1oOOpaLhgnzC8D
         Dg0piomCCjKFQ2n/60DAvM8QlmNvrfGFgeVRTclZZ8ofPkyQ22gGeytuUBOfJlWmh4mj
         Joikoo+XZxLEIXHd+Eb1YrYRAtJNNrJWS9JDlHgoUjA9t3DR5PePxPrAm6jxtxXDfgYs
         yB3JHZnyuib132K1wOgmeCVPozibLrV2y4Vqd+sZewpQrS5OnUES++iASuoYlTLO54oo
         cvm/cSFwje3OPItL/CUW8UpLjMfj2JIW7yHDZ5m7n7eItbdu8Oyv2P77SMYr/lRZ4LUH
         enpw==
X-Forwarded-Encrypted: i=1; AJvYcCVATWjKqoR9sL4eetnZyjy3oCT5JopMvM5HfeZqnE1Ur7U/KB68616egX8uFXik0vF/ePwdKenEakhvjM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7G1usALw+qngwpBfQU8GiLOSAR4bQ8QYqrm60EHLA5ZkqcV9F
	sIbJMA+fyf4P7TNp4exG2et3tCDM2eej81fc3tZ6cavxJ/Sy7vuQWcyijYJmKy1qp2a1T4Zd7xV
	GZvJgGS9IfmgmtYjcl/sQuTFQKX36On3gFVFc
X-Google-Smtp-Source: AGHT+IEmZx11ZjrcWERI/eT7YtKdxu6uNPDnDLc4QryLGLC7Gm6d76yQ/ef5SduyGaJl79jZ+F1z7h9dYn9zIt0ofbI=
X-Received: by 2002:ac8:53c3:0:b0:456:7ec0:39a9 with SMTP id
 d75a77b69052e-4584f50ba39mr336141cf.5.1725995513451; Tue, 10 Sep 2024
 12:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910190822.2407606-1-johunt@akamai.com>
In-Reply-To: <20240910190822.2407606-1-johunt@akamai.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 10 Sep 2024 15:11:37 -0400
Message-ID: <CADVnQy=xv_qy77nZK2wVjxdKjsiBa+k5B4LhgF4mSR-v1R200A@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Josh Hunt <johunt@akamai.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 3:08=E2=80=AFPM Josh Hunt <johunt@akamai.com> wrote=
:
>
> We have some machines running stock Ubuntu 20.04.6 which is their 5.4.0-1=
74-generic
> kernel that are running ceph and recently hit a null ptr dereference in
> tcp_rearm_rto(). Initially hitting it from the TLP path, but then later w=
e also
> saw it getting hit from the RACK case as well. Here are examples of the o=
ops
> messages we saw in each of those cases:
...
> The NULL ptr deref is coming from tcp_rto_delta_us() attempting to pull a=
n skb
> off the head of the retransmit queue and then dereferencing that skb to g=
et the
> skb_mstamp_ns value via tcp_skb_timestamp_us(skb).
>
> The crash is the same one that was reported a # of years ago here:
> https://lore.kernel.org/netdev/86c0f836-9a7c-438b-d81a-839be45f1f58@gmail=
.com/T/#t
>
> and the kernel we're running has the fix which was added to resolve this =
issue.
>
> Unfortunately we've been unsuccessful so far in reproducing this problem =
in the
> lab and do not have the luxury of pushing out a new kernel to try and tes=
t if
> newer kernels resolve this issue at the moment. I realize this is a repor=
t
> against both an Ubuntu kernel and also an older 5.4 kernel. I have report=
ed this
> issue to Ubuntu here: https://bugs.launchpad.net/ubuntu/+source/linux/+bu=
g/2077657
> however I feel like since this issue has possibly cropped up again it mak=
es
> sense to build in some protection in this path (even on the latest kernel
> versions) since the code in question just blindly assumes there's a valid=
 skb
> without testing if it's NULL b/f it looks at the timestamp.
>
> Given we have seen crashes in this path before and now this case it seems=
 like
> we should protect ourselves for when packets_out accounting is incorrect.
> While we should fix that root cause we should also just make sure the skb
> is not NULL before dereferencing it. Also add a warn once here to capture
> some information if/when the problem case is hit again.
>
> Fixes: e1a10ef7fa87 ("tcp: introduce tcp_rto_delta_us() helper for xmit t=
imer fix")
> Signed-off-by: Josh Hunt <johunt@akamai.com>
> ---
>
> v3: Added fixes tag and more packet accounting info as requested by Neal =
Cardwell.
>     Also updated rto calcs to reflect original code.
> v2: Removed cover letter and added context from original cover letter to
>     commit msg.
>
>  include/net/tcp.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2aac11e7e1cc..196c148fce8a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2434,9 +2434,26 @@ static inline s64 tcp_rto_delta_us(const struct so=
ck *sk)
>  {
>         const struct sk_buff *skb =3D tcp_rtx_queue_head(sk);
>         u32 rto =3D inet_csk(sk)->icsk_rto;
> -       u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jiffies_to_=
usecs(rto);
>
> -       return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> +       if (likely(skb)) {
> +               u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jif=
fies_to_usecs(rto);
> +
> +               return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> +       } else {
> +               WARN_ONCE(1,
> +                       "rtx queue emtpy: "
> +                       "out:%u sacked:%u lost:%u retrans:%u "
> +                       "tlp_high_seq:%u sk_state:%u ca_state:%u "
> +                       "advmss:%u mss_cache:%u pmtu:%u\n",
> +                       tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> +                       tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> +                       tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> +                       inet_csk(sk)->icsk_ca_state,
> +                       tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> +                       inet_csk(sk)->icsk_pmtu_cookie);
> +               return jiffies_to_usecs(rto);
> +       }
> +
>  }

Looks good to me. Thanks, Josh!

Acked-by: Neal Cardwell <ncardwell@google.com>

neal

