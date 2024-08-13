Return-Path: <linux-kernel+bounces-285145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F29509CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C161286535
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D611A0AFF;
	Tue, 13 Aug 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0aOVX3Hz"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E41A0AE6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565112; cv=none; b=RHsazke0cC9b5Kd8opIpmqSH0VeSn3oOU1/0HuSr/G1cC7hri+kw7qydWiTIJDlejMZHW+5i8SKhdPRuCEOT9VkqLU2phsY5iNzPDUNWOv9Z+1GVkMzPakzg7nMmJoIpj+rwZLmEg/iCH+dRYy9Wnpd+DTxDH5nNkon+ZVB6eHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565112; c=relaxed/simple;
	bh=dsnEFrXQEe30129gATA65SKh4tPfceYgp5NXlRzsf+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWRzdSUFs0zcq2enheJ6OFtYd5/L11swU+R1QBtFCOUjbep86U0P2w/DQQCijwC1LYK28c4RTMiDU2S88NuHzGFCotVktPOYCe/iwjvgj74p4YQCnMoGW/vcqXIp1ZkMUYB04NjBVxo/SIFuyrhnA/wSzy8G3ae8Kcxqd53JcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0aOVX3Hz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-200aa53d6d2so113295ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723565110; x=1724169910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYWzJyvpTQNIlST/TNx5IAt/1qpwACIOgkuhkXZEt38=;
        b=0aOVX3Hz9czVpRqT+ewLN0sKVAbXC/UdzZGHVoKKPJcF3N2vatmszAPxh/udHq2iwi
         cNVfZ7z/Ip8807GXyVpmUTl972pvJeCqvQ6ubOm4Hkd4rSS6d03FMKMDTdO/nl/4LWXH
         gq01qezG0fcrEmM+LzYrE8ygvcZU2W6b/hdwvdwrf5eenHcbjSZVy17zEhTHljWZUmD0
         TnQ67n/eKYeAye45uqX5QP8JPmcAgQY7gwczoyc6hJmRDm8VEl+XgihZr6kg0he+pgtV
         ww1MFggGvTjLeCB0jLb/xEq1fVWbOUEg5NrQIKoQ7OlBDyJg84P24NzNt+7vM5UpUzvT
         LsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565110; x=1724169910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYWzJyvpTQNIlST/TNx5IAt/1qpwACIOgkuhkXZEt38=;
        b=SnawdlTGJdelXmwqY6aFTfLu2XkvqDsepwBkRiU2FFbhwKdfs8BVhAWfX6rNzibCzC
         BRSUf7TYTAAG4phPrE7QH/+Y4QoG3meKmHkg/2fWQ0g1TuvfbdGpeG97BXpwGEJSPJFz
         1hJCoQcg9waqi9GVsXTtDE9H+OQyyfMn0sp81LWwjc66k5jLBlPhMRI8oMSFEPkj9T2I
         v8OHX/6+u8fU9I0loRlcMQfFc2/wfganCqPBmHtcwgo10NfTqKlzm7nrPuNwYaXsOAPM
         UM9+cEueB9heIsLhN3nIPMp2cMJGjq90Q35lZeQWJieCVWuvMpz3G+PM0s6ZXBZjUSeS
         x+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNn7UNIhg29tunSNG0Zk0DtutCJ7eEulLLBRbiHLYRzPfrGbhm3GzmufYXDSHUmvhLOmqOl5K0xFBpACfvPcapcCl3K3E20cf9jkY7
X-Gm-Message-State: AOJu0YyvUXqiCcGPqImohiEAqzKrM/2lq7aXNuOhjiygBR1PBS5q4ihj
	ZLHstDC37aCLYx4KGhdXfL+GFe9VDmB8FM9ZAL2gIpQT3xAK3LRtUTnBMkLtyWx+knAftqWdYpI
	pPn8N3J/Ga0QnFKHa4uICuc5k/WJDb0XY2KpZ7Ib81e9VrsjK4wAo
X-Google-Smtp-Source: AGHT+IEub4FIB+lio4i4nkw8sW+gRiszAfxdnYj0Bw1TMl0dWkbkwnfXacTcpG2yDl8Cz2lsKatOfYpP8MFyLU5J8so=
X-Received: by 2002:a17:902:c40c:b0:1f3:3ede:9b0 with SMTP id
 d9443c01a7336-201ccba5f3fmr1740695ad.10.1723565110178; Tue, 13 Aug 2024
 09:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813040613.882075-1-irogers@google.com> <ZrtzTTHim_vGX1ma@x1>
In-Reply-To: <ZrtzTTHim_vGX1ma@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 09:04:57 -0700
Message-ID: <CAP-5=fUA8T9B2RvXg-Hpj_fHXmwB18ah6Krm3qm5ULH-M04Lqw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:53=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Aug 12, 2024 at 09:06:12PM -0700, Ian Rogers wrote:
> > lock__parse calls disasm_line__parse passing
> > &ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
> > lock__delete.
> >
> > Found with lock/leak sanitizer.

Ooops, I meant address/leak sanitizer.

> Applied both patches to perf-tools-next.

Thanks, could you fix the commit message.

Thanks,
Ian

> Thanks,
>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/disasm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 22289003e16d..226d2181f694 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -566,6 +566,7 @@ static void lock__delete(struct ins_operands *ops)
> >               ins_ops__delete(ops->locked.ops);
> >
> >       zfree(&ops->locked.ops);
> > +     zfree(&ops->locked.ins.name);
> >       zfree(&ops->target.raw);
> >       zfree(&ops->target.name);
> >  }
> > --
> > 2.46.0.76.ge559c4bf1a-goog

