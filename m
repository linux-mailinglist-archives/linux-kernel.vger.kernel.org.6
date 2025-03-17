Return-Path: <linux-kernel+bounces-564809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC22A65B22
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9053A9658
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3DC1B042C;
	Mon, 17 Mar 2025 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vW0OR4Wa"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0401AF0B7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233303; cv=none; b=Xldw1TFvwjg96baJb/HKBAKHiIt1w1EG+2rchcniqLiLE6usA6Ib8+vTYeA03FLJrs7BuLViedSDmP/iwSoatdpny5Zq1BV//P++HptX/A9DDW4rqttZKyu2ci7ExrKrd438FpxNRwaoLAqt/1Iv80boxT8n1nWM3T2VyjfT46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233303; c=relaxed/simple;
	bh=2iXPJWP1z9o/7gPaz4x1Vr+Hj0p7KnhZyY2cxs4UCsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWlcj0/JuBhiIHeRpWQzAlFyJLqO+nNmZevjowkWW73VVupczwUuL5cIqODNbEGwTQs4mOYzbIuyTxTApXUliRmB8icERzV95MW7ALnL/UrExoElCKLIwC6eGR1eUnTO7RD1H7+Bn3SgNbkaie9b5hu6RdTGsyXHTCBEqfgS1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vW0OR4Wa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2242ac37caeso14465ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742233301; x=1742838101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lATWno+kXyCA9gXnRwZCNyfTyGMjQkkcrd7sBrYiKLI=;
        b=vW0OR4WatDseN5WLlNtePnXOb50TBD2PMs85uEiD1+9aXoUuBM0SkCePQQrACHt1Gy
         NRGrUAhGtwVRDbsZOWYHpZpZpg6U6vU7U+BSW07BFGjlCrfG58vi6NHR2C4Lwte2eCe5
         c1FVYxZy0N2BmSrzzOVI2pEPoF+0aX8lh21IFf3hmAn94BqVffskvyXdqZ2rN8JLtn23
         kdL+WPCN7FIIOc6as/q7/J+5MJt7U77ckzLlerj0N9MnxPAnImveFYs6TKQSolSfi87o
         musXaB9kNE6TaqvW/5y0onRqigVmw0MW+wtXgq9lZ8fl9Pwu+RjlzMx3nDphIKsZWFcg
         QKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233301; x=1742838101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lATWno+kXyCA9gXnRwZCNyfTyGMjQkkcrd7sBrYiKLI=;
        b=KvGduIdfkiWZxn15FzyFw7dTMYettuXvV9+6NhLBXumqIr66cMAGpwphJW/QiA52IQ
         dcR9gMPIOHghuOPc1D8R8hV8t65zFlD0QFhprdf7jXqZgYF4S5VuqoHmHj1jaLWk3NmW
         MIUo7+T+4ZU0p4Zzcl2aCGLr0TrAEHsD0Vj3tqf58n1konX6/vH32d7DtFQi4Ync0UDX
         7DaNnee+mCG8vH80FUBDm/5WzBqY52DndnLsCyasWx3GDjuVeEV4EIsDiiV/35zivdrT
         +ZD8x4W2eGvoHeVNIQdl9/QzRlpVi9CbZXNgHYh8oZW1p+RmkR8hmaLRrX9JuUSR6gRv
         cOvg==
X-Forwarded-Encrypted: i=1; AJvYcCXvhe152dab+AFNIMzsPLcnNO8gdPwBZO5b+MX1T/BN3JqpxktxBEEJd0BF6YSgovL99X6yOJnh5tjW6H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLuaEfPf8+Nn9/WWlUqjPLQF4xnjBCUF4Jww+1IF+rHyGnVMLx
	eA/TgmglneB3ySuLkiG7oyA3sF1VM+qFUrW+pnBA4ca0FZLT1aUjGpSaZ0H3oMrHUV4ZFfeBuGu
	7roD/zqLaalf8Bn41rWMkHB3Vx4I3UJr/Ns8I
X-Gm-Gg: ASbGncsiAjwFl6fNaw0QTBy2POnA0vOdD8+NNOIEUycfqnmk779KXR/KUtKPEKUhZq/
	o6olOti3iDfqxVtmUeUsO5RDURzMg5H2UojZXuiikIbxCI6TueqHF1zJryZBLh3dlL4CP4+53x2
	Vt0r2ucKVU6CLTw/rdMYPKd2hLlccBXCj2JIJevomw6Vr1/9QTNk2udZw=
X-Google-Smtp-Source: AGHT+IEIYL1jMu8c/jZPzJq8IxeFMMI6ydO9iAjEFwdH+QT2RkBXanYn5Iiy1WmvDd0rwttzDUNtIxDCZsUPBlHf5ow=
X-Received: by 2002:a17:902:d54d:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-2262e5a2abfmr16435ad.10.1742233300634; Mon, 17 Mar 2025
 10:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312203141.285263-1-acme@kernel.org>
In-Reply-To: <20250312203141.285263-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 10:41:28 -0700
X-Gm-Features: AQ5f1Jrzf0iH9xyr2lt31DxMP4FCuxmnry8MXMkcFEW3VWFnxM4d5NLukHGmsTU
Message-ID: <CAP-5=fVp48KUB5sawBp-6t5DyzGqDfxtXReSSTQ-LDXFKMAvzQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] perf python binding fixes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:31=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi Namhyung,
>
>         So this simplifies it greatly, it almost ends up as a one-liner,
> but there is an improvement as well to mark the event as consumed to
> then parse its sample, because the copy of the whole event was done all
> along.
>
>         This is brittle, as the header size can be bigger, than the
> space we use and in that case we fail to parse the event by bounds
> checking it.
>
>         Supporting larger event payloads can be done on top of this,
> possibly by deferring consuming the event in the ring buffer by parsing
> it all instead of having pre-allocated space, measurements need to be
> made to see whats best. I'd say leave this for when it proves necessary.
>
>         With this series I managed to run it for a long time without
> crashes and 'top' says it doesn't seem to be leaking anything, as its
> memory usage stays the same for as long as I looked.
>
>         Please consider applying to perf-tools-next,
>
> Best regards
>
> P.S.: In other news, the syscalltbl series from Ian built on all my
> containers, I'm now trying to go over it patch by patch.
>
> Arnaldo Carvalho de Melo (6):
>   perf python: Fixup description of sample.id event member
>   perf python: Remove some unused macros (_PyUnicode_FromString(arg), etc=
)
>   perf python tracepoint.py: Change the COMM using setproctitle if availa=
ble
>   perf python: Decrement the refcount of just created event on failure
>   perf python: Don't keep a raw_data pointer to consumed ring buffer spac=
e
>   perf python: Check if there is space to copy all the event

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

