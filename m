Return-Path: <linux-kernel+bounces-519537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE45CA39DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AC63BD03F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5605F26988D;
	Tue, 18 Feb 2025 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxNc6cMg"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C60175BF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885773; cv=none; b=sP+5PYp+r8Z9r6IjN1RBXJH6rMO2RwDZEXbthmaoJyaXvlK02vvdEDEGVZDkQG3+1fdCh4WCRNkRADpJ8NziT3w6zoCSEH5MRM9cnKRWAU/mb1/kKgS35ktT4mMpnefghDBIDSwTPLkLyP76R07nyqmnlYXzyYh4kBZWxWwgN8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885773; c=relaxed/simple;
	bh=1el1r1ku6nDEmYk1WaQqya0idTEm4g/kYnaOmrEaSns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oo4ZuuthD63QtoegMTal06VCDexSCEqJlAqHSWDf4lbNsqGSAwCFLbUkQqLYAaqmZToE1S2UVh+lMRzGvdv1ibmGVPDWLyTiLKWLSgvjtzgrrD2y2Bw7+5o5/jeiB8w+3i3/Pl8PxegAnA/1M4oYfdcVJos3numn0HTFQdkmneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MxNc6cMg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb79af88afso541144866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739885770; x=1740490570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OZcDt15QGW7oHl6wgsivz4nNFlZzuuT/h8x1d+aw7I=;
        b=MxNc6cMgeYuNqngBq0HfXorOV/5dvgC/ugWn8ciQv3DLCrcnS5OsdOTlY/y4Xibi87
         jq6M2wwnjTJewvut8vGCETrlb1ZGJLweTjUMQFPUs5MgLoL4s5H9tjukEufL9Czasmpa
         WAylT1DRFTzkqh2rJtdFxYAVhvG8jIhyKwOZCtAiSesXwDUr9+JxCUIWAUCGZfa2etaJ
         17vkyzS0MjWX5nvP8zI/mqD5oGBqsEa8C9MLHGAgzzFVvoZMqKT4UfwBHIkAPKNmR2+h
         6PE0FVFiUVwiRLsRetNfhDldZS5tViTsdXN0VGG5OnYSMjNMgaf/tRsJC55Jgb7GgpCA
         AxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739885770; x=1740490570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OZcDt15QGW7oHl6wgsivz4nNFlZzuuT/h8x1d+aw7I=;
        b=kytgB/Ozz47IzKcf1o4GOq6f2oFcFiTHM9mIHBZy4rI/BeXh5szGQv18r3v60B/D2n
         Gz35sXBNejZ+qcB8SgZrBd1+soXt7++JE8y0r0r3IaM/7AZ2ggF6WmcPD9sp4CsPlFJR
         J3uSyz1dWeAyCz0ftolnOUkXUjxPrGTtSvS/WQnRz26kLKIywmH3g8ivgHepy+nwmbwB
         IOHhq6REIElajiIRNXHMsLNbDBGmvpcKSlAmeBVctQqIsHcFrEE1PBaEgcXgCQDBK2EQ
         Bnr9b1cQE68koN7a4OWKozifT13BmFxD5FmQatuojbwtHMdkr5utQ1TUGOJOit3m68ir
         3suA==
X-Forwarded-Encrypted: i=1; AJvYcCW685UrOlD9dG5TlcwWAzx6flq05YfskAmQpmdzFJScN2xZxKC2LZ3WO89S7/bTxK0Wjso8HANlbOYVkUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRIB49GzTz81xiCMN1lBAeW8p87nhcVmJb7mr1fFAmpCVxnZy
	ogHCTUahGCelvKm0VcLDKCJEyb3f2PiYBzueM1VsMwQJrYO8v5YO8faLNZslJBez/5P56AGr9qa
	0oEhc/br/TI5WV17xqdjgFpatCM6oVRB8jFP0
X-Gm-Gg: ASbGncubZZuoKrpSDIs8IALCRF5UHRQnCCHU32VYbA+s3GyLswys1qTnc3RxizistSQ
	G4CvzzGUF3GA5dP5gF9oWXeRNz4qi0UWi20fzWu7tptfZbD3MaRPFZwPYiFKQuxAE7d4FE3yo
X-Google-Smtp-Source: AGHT+IGKadZ959xikteUpLo1xqvSnX/oHQ/2ndJ1UoV7NqvtX7mJ2Og8+iF4jhhUUhHozu8b3w04Kcq/C+xHLP8AV+w=
X-Received: by 2002:a17:906:2443:b0:abb:b533:3ecb with SMTP id
 a640c23a62f3a-abbb5334582mr301097766b.17.1739885768726; Tue, 18 Feb 2025
 05:36:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218105824.34511-1-wanghai38@huawei.com>
In-Reply-To: <20250218105824.34511-1-wanghai38@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Feb 2025 14:35:57 +0100
X-Gm-Features: AWEUYZkTkYp5qWAJLLVVtJo_9aJwB7ywvIiOdhHV2BtfOisw9oMUSGlN21yY0qE
Message-ID: <CANn89iKF+LC_isruAAd+nyxgytr4LPeFTe9=ey0j=Xy5URMvkg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix error ts_recent time during three-way handshake
To: Wang Hai <wanghai38@huawei.com>
Cc: ncardwell@google.com, kuniyu@amazon.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 12:00=E2=80=AFPM Wang Hai <wanghai38@huawei.com> wr=
ote:
>
> If two ack packets from a connection enter tcp_check_req at the same time
> through different cpu, it may happen that req->ts_recent is updated with
> with a more recent time and the skb with an older time creates a new sock=
,
> which will cause the tcp_validate_incoming check to fail.
>
> cpu1                                cpu2
> tcp_check_req
>                                     tcp_check_req
> req->ts_recent =3D tmp_opt.rcv_tsval =3D t1
>                                     req->ts_recent =3D tmp_opt.rcv_tsval =
=3D t2
>
> newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> tcp_child_process
> tcp_rcv_state_process
> tcp_validate_incoming
> tcp_paws_check
> if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <=3D paws_win) // failed
>
> In tcp_check_req, restore ts_recent to this skb's to fix this bug.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  net/ipv4/tcp_minisocks.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index b089b08e9617..0208455f9eb8 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -878,6 +878,10 @@ struct sock *tcp_check_req(struct sock *sk, struct s=
k_buff *skb,
>         sock_rps_save_rxhash(child, skb);
>         tcp_synack_rtt_meas(child, req);
>         *req_stolen =3D !own_req;
> +       if (own_req && tcp_sk(child)->rx_opt.tstamp_ok &&
> +           unlikely(tcp_sk(child)->rx_opt.ts_recent !=3D tmp_opt.rcv_tsv=
al))
> +               tcp_sk(child)->rx_opt.ts_recent =3D tmp_opt.rcv_tsval;
> +
>         return inet_csk_complete_hashdance(sk, child, req, own_req);

Have you seen the comment at line 818 ?

/* TODO: We probably should defer ts_recent change once
 * we take ownership of @req.
 */

Plan was clear and explained. Why implement something else (and buggy) ?

