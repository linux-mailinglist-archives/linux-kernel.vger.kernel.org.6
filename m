Return-Path: <linux-kernel+bounces-320345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1107E97091C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729CBB216CA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B917798F;
	Sun,  8 Sep 2024 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuk/McdL"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD73E171652
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725817877; cv=none; b=q/KE6JG4FXBa54bdSSN0Dpod4BI+PhU19T1XY+tDvTREUUCQMGaCmmOcX3TpvZYhmxJsmYEPxIlPyoDWUBsQEGb7Rkt0wNAtfgTPK1n1yb49WvLKOe5Buopr0mUSIM+aH1z5ybQHYyFpnoA+cVLiA2D1y2C7IdWI8KX9t1PreJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725817877; c=relaxed/simple;
	bh=5r+ff0YUzQcAQJ9V0U+YH5TcnmTnlrUruFbqchuNxpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PptqpPV2dE8ZteqN9ly36lLdMide3qEmTPztOQxpK+JjlxgR/bIEGhOywzJVyKF8PBzMUmgldbESDfUFUoYUv6l+aUIMeueXkmRK7Ndr0o5+dHqz16fRWnMHVetfC9RPV6+odx488fvgWcKvNwTSCxSHpyfBN188NRcgz/uQjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tuk/McdL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4582a5b495cso127041cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725817874; x=1726422674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bEhFoUdG1VjEMzu3pmKnO7utKiahxhSoyhwozMhHms=;
        b=tuk/McdLTmxwCJBAjDAjwu+K4aLzx62vw70EZP6vcNdA3csk2MsCGJ0f4Nz7HUV19V
         6RMP3c8I0HYcC0CIVL9XVJT3VeM/Ja+K41uTBIOh5SIBt9PDeyNkGWqyZi7OqnAI2wmu
         4fBfOYmKq09jb5YpfO4hRgz1GFOVmCFYXKXICdiAC6slBHCD+sfZhWz2mEMRYH6c5JpP
         ZZzeWQ6KWgVKe//mPZdo62rmgc7GLw2PvZ2KbG8v7KNn1bgu9QtEzZXadEL49EOrSzUV
         zSpQNAyDQHc8pS92O0KblyQ6QpV7pBMPDqm3Msk0Y7/68BGZg5AHz5UvVwkn6v2iGtfe
         HxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725817874; x=1726422674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bEhFoUdG1VjEMzu3pmKnO7utKiahxhSoyhwozMhHms=;
        b=DAZ3I1a50p/PNzl5/17x60/fcLKgWNGaJ+B0fpNKIx1ou6wuwZe28B8s6WDi5Q/Xjw
         WBfLllPNzeghUQTYOBjj8ZXZ9jQKobT/lOHs03yxaRupAbASRoi8TUnjH26g0hUZD3xg
         khf1j+2o2yxV/fRGDhWWPHWqBD96wKtb1xLuzXl1E/nl+RKY16LCLu0zlS6nENoXYV5C
         J+5cUTbX0x2zcY71Q/ZLV6LccJvbk0dXytzFQWufUv1dGvthhruoe24WLa3Eu4mxc8v+
         oKht+jOJ3SnfC8DI1/xOPaKS2hTtwAMDXI6umg52W1hZ1HBsfrN1ET+4VR/PcG4/p0E7
         gVtA==
X-Forwarded-Encrypted: i=1; AJvYcCVzRVfxPmFUEbp8nw7PKR4Sdg4s6oUiSg/XJqJ5UoLEqYwokI20BGkK95l7AX9VEXpais/dkkE609Klw34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKmljT7BxiIGvGh9y09rF7VrcWUFzG4a0mf9Fp+guDnKB58LD
	OI3Koct8+Kl1NAbjMHK8zbYzrtQCKAddGuuJG0miyPVJSgHqKkr/b1kVLVcpdQLV3Sp+3raSKNu
	yTVKxyqzOXvSRk9ENMLrTUjuZ3BZ9YYUZmlAC
X-Google-Smtp-Source: AGHT+IEOmi4QVMnTYRCyZA03/o+i+47LI48BqRn8t22XjrtzKxRBL1fxmkCl0t4agKxYPlbUM/KBq+JqJoPUqgVA0c4=
X-Received: by 2002:ac8:5714:0:b0:456:796b:2fe5 with SMTP id
 d75a77b69052e-4582147fdcamr2673891cf.9.1725817874117; Sun, 08 Sep 2024
 10:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906231700.2097588-1-johunt@akamai.com>
In-Reply-To: <20240906231700.2097588-1-johunt@akamai.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 8 Sep 2024 13:50:54 -0400
Message-ID: <CADVnQynX0yWQA1mqWCueo-yZ1WxTkRAJ9nLjkGAne0QbeM1iZg@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Josh Hunt <johunt@akamai.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:17=E2=80=AFPM Josh Hunt <johunt@akamai.com> wrote:
>
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
> Signed-off-by: Josh Hunt <johunt@akamai.com>

Since this is targeted to the net branch to fix crashes at least as
far back as 5.4, AFAICT it would be good to have a Fixes: footer, so
maintainers know how far back in stable release history to apply the
fix.

I'd suggest pointing to this linux/v4.13 commit:

Fixes: e1a10ef7fa87 ("tcp: introduce tcp_rto_delta_us() helper for
xmit timer fix")

The bug actually predates that commit (the code before that already
assumed tcp_write_queue_head() was non-NULL in tcp_rearm_rto() if
packets_out is non-zero). But that commit is the first point at which
tcp_rto_delta_us() exists as a function and so it's straightforward to
apply the patch (albeit with some conflicts in earlier kernels). And
that commit is far enough back to imply that the fix should be
backported to all "longterm" releases listed at
https://www.kernel.org/ ...

> ---
>
> v2: Removed cover letter and added context from original cover letter to
>     commit msg.
>
>  include/net/tcp.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2aac11e7e1cc..19ea6ed87880 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2433,10 +2433,19 @@ void tcp_plb_update_state_upon_rto(struct sock *s=
k, struct tcp_plb_state *plb);
>  static inline s64 tcp_rto_delta_us(const struct sock *sk)
>  {
>         const struct sk_buff *skb =3D tcp_rtx_queue_head(sk);
> -       u32 rto =3D inet_csk(sk)->icsk_rto;
> -       u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jiffies_to_=
usecs(rto);
> +       u32 rto =3D jiffies_to_usecs(inet_csk(sk)->icsk_rto);
> +
> +       if (likely(skb)) {
> +               u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + rto=
;
> +
> +               return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> +       } else {
> +               WARN_ONCE(1,
> +                       "rtx queue emtpy: inflight %u tlp_high_seq %u sta=
te %u\n",
> +                       tcp_sk(sk)->packets_out, tcp_sk(sk)->tlp_high_seq=
, sk->sk_state);
> +               return rto;
> +       }
>
> -       return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
>  }
>
>  /*
> --

IMHO it would be nice to have the WARN_ONCE print more information, to
help debug these cases. This seems like some sort of packet counting
bug, so IMHO it would be nice to have more information about packet
counts and MTU/MSS (since MTU/MSS changes force recalculation of
packet counts for skbs and the scoreboard, and have thus been a
traditional source of packet-counting bugs). Perhaps something like
the following (compiled but not tested):

+               WARN_ONCE(1,
+                         "rtx queue empty: "
+                         "out:%u sacked:%u lost:%u retrans:%u "
+                         "tlp_high_seq:%u sk_state:%u ca_state:%u "
+                         "advmss:%u mss_cache:%u pmtu:%u\n",
+                         tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
+                         tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
+                         tcp_sk(sk)->tlp_high_seq, sk->sk_state,
+                         inet_csk(sk)->icsk_ca_state,
+                         tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
+                         inet_csk(sk)->icsk_pmtu_cookie);

Thanks!

neal

