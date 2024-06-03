Return-Path: <linux-kernel+bounces-199448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54218D8755
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700951F21DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDAC136E3B;
	Mon,  3 Jun 2024 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oj+s7Ufy"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4911369A3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432333; cv=none; b=F5HZP2/9cM0VZnX+3XVmKL5/QttuKqJ4+0Mrn5slo2OAY+K8hKFDPygMZgq+vC4xUysss1wjz95g4kpRQTW8P8S5dHpgT7WsQRnDb2Px5NwV9wtYtlqrVY/siNkXZEkmpbTryoAjyEypV14E6JCOqFsLeNYxAjk1xundKN8mN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432333; c=relaxed/simple;
	bh=w9a2/atiiKAlAmz2KZIcZv+9KetM5M2FFUgSgR3Onnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIiXDnBP7ISJGZAzhZD3JX2WB3WcJYr484CdZ+umxccs72lIX715tvdrXzdU8kFjk4Nm7Oep0zPNJXkKdHxvaxTRQTjnrUcxeB6cnHkWG6RZ9zFQMQuNaRxJP51Hp/mJliLJRwCVpgYxbxCzOiwlpy0XwbNLyvrxAc53kddiuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oj+s7Ufy; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43dfe020675so1921cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717432331; x=1718037131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1p+tR727HW3fVvv0/DGxXta4E0+P8XXbCMMa/xAMnU=;
        b=Oj+s7UfyvIf91N5RfpRkcaxtFvceoYvkLaJPQ+L4I/nS4TOXinQ+50V7EolwkqJCD3
         ovFgtGuxHVVG19iOlm8ZTOw0RSx+T2NJ8vLWENLrVjmc39zPJbalE2wUueppWh27T9g0
         +a2jwG/U6WG0Qyc5nZtAv6EnADdR+gUDuV3wE74019HiktAiORZvF/mFvSZy/Ba7ehC0
         j7sPrJuKocc3AhMyfq1LXlcKiYgs83hlwdgpmAzRsLEOYQSxJBLNG4AMYUYoJtlhqSTK
         KsISTAViADO7vFfHMwAh15Kl818xXa6BjNqA+G68tWbDalQ+GAQFODS8d3M5ZLy/jUXc
         XxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432331; x=1718037131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1p+tR727HW3fVvv0/DGxXta4E0+P8XXbCMMa/xAMnU=;
        b=LI15SLDC2iTJ5wqNPPJ+JiCVExXIwzq4rZQRLwZLGwUY0du5K/QqFrpQWO11AJfbUy
         FUhxiGYXKRfTBSDAiu445gZOnCYvAHoU/e2U1F+RIwE5uBKyOxd85MuoWTw+j0KT0eHt
         ie12RHHZhH9v1AeXhFSVjRSY5TLTNCny5PeRSIWD15xJe9N/1cc86ottOpsPfhtkkw2E
         IIL/CoNyPDUztTthBpH7d2XlhgmPQ0gf/fyajkAw4XjQY5QTNYzhnvDo5SWed0ngxTCP
         kVk5uxcIMXDGeerJ2WDbXvFAFgh+CzjA/LcLZ1K4fPNb0zeD1YItnp3R3nv1rzMTWjc3
         5QXw==
X-Forwarded-Encrypted: i=1; AJvYcCVUoTbwFdTpn+k2IMS9OiXTVgzBzxVu3UAt7DUbSILUjS6/Dp6nTSG3bOqm5ZFicHaCfwHq+ZMpWLKQ+8owxaI9qTewfVrpY5vx6rd9
X-Gm-Message-State: AOJu0Yxugan5ZBii36PzZjltt/Pofo30rZEQV48B97f3zvGFy1FLbsYW
	aBv9bpNpmh2boj7MiN6r7BstZD5jO5E9C4ggdpBsJec0dcYjom/AJnuOuIdEf5v3jcdKnh4vQNT
	JFrbL08sBmGnmnGQU18g8ak1h5Q+1VFrJS3HC
X-Google-Smtp-Source: AGHT+IGjvGTOJJN5aIMZuCRwYSL9PxNrA6CXhpvYTHYYyP2QVJ2qoVuj6u5cb0dQGA8tj+JOqm1Lj1JKYauPf20NupA=
X-Received: by 2002:a05:622a:4248:b0:43e:1124:3c4c with SMTP id
 d75a77b69052e-43ffe081457mr5570481cf.28.1717432330598; Mon, 03 Jun 2024
 09:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602000709.213116-1-linux@treblig.org>
In-Reply-To: <20240602000709.213116-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 09:31:58 -0700
Message-ID: <CAP-5=fXaaDZPL44Nar9uR94QvqgiYaaDjEpM1rb1mgiU69178A@mail.gmail.com>
Subject: Re: [PATCH] perf hisi-ptt: remove unused struct 'hisi_ptt_queue'
To: linux@treblig.org
Cc: yangyicong@hisilicon.com, jonathan.cameron@huawei.com, 
	peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 5:07=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> 'hisi_ptt_queue' has been unused since the original
> commit 5e91e57e6809 ("perf auxtrace arm64: Add support for parsing
> HiSilicon PCIe Trace packet").
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Hi/thanks David,

Reviewed-by: Ian Rogers <irogers@google.com>

Ian

> ---
>  tools/perf/util/hisi-ptt.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> index 52d0ce302ca0..37ea987017f6 100644
> --- a/tools/perf/util/hisi-ptt.c
> +++ b/tools/perf/util/hisi-ptt.c
> @@ -35,11 +35,6 @@ struct hisi_ptt {
>         u32 pmu_type;
>  };
>
> -struct hisi_ptt_queue {
> -       struct hisi_ptt *ptt;
> -       struct auxtrace_buffer *buffer;
> -};
> -
>  static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *=
buf)
>  {
>         uint32_t head =3D *(uint32_t *)buf;
> --
> 2.45.1
>

