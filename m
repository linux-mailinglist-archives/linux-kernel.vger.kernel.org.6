Return-Path: <linux-kernel+bounces-201577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8E8FC03B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12BE283937
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC5114E2D9;
	Tue,  4 Jun 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eajNF/Lw"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCFAD535
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717545385; cv=none; b=oaqnkUXqe9osps5LzCbLH71YHiFKN0PC4rlCL9BCzVxTYT0SM/J+8agyfUSZTVnqdXfaZ//ketB10I5vcc5dgEDUKw8L8eCSNEkiDcieU+RUfUXt2NcJocr41td5nuWSqGTsm2gIn4IybuiJFYai7v/uh6cHIfihS6JZctIDSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717545385; c=relaxed/simple;
	bh=TQDBpazXtL7P7vfaFUKrnxPRdMREw43QjkUoNFPN8Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyKzx8JYazZST73VNeRnetw0WDErAErAOKmn6YSKa3wS8qhvR/YB81VsiOBVcQdcxwp1MCbAou5sqpbaBGYKdaMC+34hwFpiw8FJlG32E+ZUPvYECv9pfbWA5roplgtuK5XwUelQ9Olov6gw1kDrKYNZnQ/lwunidoj3gcO4n1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eajNF/Lw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4400cc0dad1so206351cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717545382; x=1718150182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQDBpazXtL7P7vfaFUKrnxPRdMREw43QjkUoNFPN8Q0=;
        b=eajNF/Lw4fPk00VEMJrhOJqiZ534jWfVCRTCtmeKZcIR2OdHpeXLJBwM9wNosONp1V
         Z8l9jwq3S/GQSJ0sFwHli0Y2iuFJZHAECO7BNbMWt6uNNLZHMQzoI1mrZldI7qE9eGEc
         miLa/tX6BaanUuEY2RRGKwsIKwC0IP0WUgqq92GW8RTSaDdbyXiVlUuXD8DEDP9a/Frn
         S5m7dnkotlg7h38DbWOV8n4iwpWZPKEBv9967Khb9ABb9MfiCmHAk6dOGdrc94Bp0ZOY
         8ZQq+hFu6vL6E9BwAgxAeVYVTRd7xpgtmqml316xoSJ3iBx3V6ls149d9pSHzoinSv+2
         NkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717545382; x=1718150182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQDBpazXtL7P7vfaFUKrnxPRdMREw43QjkUoNFPN8Q0=;
        b=iEtxtGUb51K/N7xjshdUMTxIHkPMgdD/x+yJCSBlfW6IKFi7YIBuQ4XN+2lTz6DSJc
         W3BEu4EafrbfdeF4I2I1SX0sGq7GRiyjTfP9F2WwmdK8FLu1tqQUKy1keWChZMLUv7oF
         umytc0kk+qdWI7cy1aY/FKBlfRJX2Sheu7hOU5USayW1z9SYqheDK4E3U7W/w9zFJnMx
         rBGJCPvhsBMHH3b5DOVsmWVrHQF1a58flPtAOIy1xSG3bpz0NWfzuIU2yvsZA8XGNJOO
         osYM9rB3REHSG4anSlCjXYByxCGnB2PkRYAVFoFmHIsM9L3XbuIOGkeB8LAF9NgzxJol
         KmOg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1aTJtZqs8dtWZjy5esMHp/owTz9CoPBkz1YT1xB1RWVKEKe+orAm4+3LHVRrkYSrEIgGFVX9Yrw1BdbEIFIMGPZJardfT7R8B1j7
X-Gm-Message-State: AOJu0YxkaYPWC7qXBVHzFcdEEXpFPza+vPM+FXAnLBo94vdrQynh9a7e
	5znfKL0PXObBaSx7IVbWtNKEaRn5n3jWb6lPKTzoOJLPHBtdifEXhDOt99kOlsTkRAbH30fAYeO
	Wd+QCZ+W8OdwRHiUcoiCqyVwc+UbqEQGpxOVY
X-Google-Smtp-Source: AGHT+IE7jVrq+XPHLOmdbV911cJ7yqYS46OpFpLOzmxK/XDmyVz6lMYhO+C3jlfog4c7DjT1BrzvmlTw38+e2WrgbEg=
X-Received: by 2002:ac8:6907:0:b0:43f:ec8f:71f4 with SMTP id
 d75a77b69052e-4402cdd5845mr378781cf.5.1717545382324; Tue, 04 Jun 2024
 16:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <20240529064327.4080674-4-weilin.wang@intel.com> <CAM9d7cgSwZ3PU3H9VNvxQakocEZ_CQEqB9M1o3xTMdJ7F1sufQ@mail.gmail.com>
 <CO6PR11MB56357F58D99B17CD08671A26EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjbHzgfW2fKQkZ2=gtEMD9N5wG4xaWgPU+N-YvmfhXviQ@mail.gmail.com>
 <CO6PR11MB563511F1A6165F0F4B30C4DFEEF82@CO6PR11MB5635.namprd11.prod.outlook.com>
 <Zl-WCEhhxBtiGGhn@google.com> <CAP-5=fW41UxUDO-FSymMX_R5nEJDnV7FOjfhW5=XGCVj=TSYKQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW41UxUDO-FSymMX_R5nEJDnV7FOjfhW5=XGCVj=TSYKQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Jun 2024 16:56:10 -0700
Message-ID: <CAP-5=fXtGcoXebwqMOqadK6Hkgx6Wa06UaNa3Ji9jrcW+9BWrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Wang, Weilin" <weilin.wang@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:41=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Jun 4, 2024 at 3:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> > Hmm.. I don't know if other metric already dealt with the scale like wi=
th
> > RAPL events.. If not, I think it's reasonable to add that to the metric
> > calculation.
> >
> > Ian, what do you think?
>
> Tbh, I don't understand the conversation and it looks like we're in
> the weeds. In metrics the scale/unit from the event aren't used - that
> is all events in a metric are the unscaled quantities unless something
> is broken.

As I understand the problem is that the retirement latencies are an
average and so fractional, assigning these to a u64 count loses the
fractional part. In the future we hope that the retirement latencies
will be directly read from an evsel. Should we scale up and then scale
down the retirement latency to avoid losing say 3 decimal places of
precision by multiplying and dividing by 1000? As the metrics read
unscaled values we'd need to change the formula. I'd prefer we didn't
do that and generally avoid making the retirement latency evsels
further special. So I think for now that means losing precision. We
can at least avoid some of the worst rounding by using "rint" when we
read the latency.

Thanks,
Ian

