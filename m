Return-Path: <linux-kernel+bounces-320470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56685970ACE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC327B20B4C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 00:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1671AD55;
	Mon,  9 Sep 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TW78uOL3"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC4193
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725841850; cv=none; b=Xo1FBT5GP4wP/1IPz/QN08iITnfSdDnUbrP/5g83A9claZKMNTiDTsBiGNvxR1oBy4qt5mW7BNIuISd8EGNhcWPCZ8XOuoN0yNqSVmdWoPc6OLNAimKNymEaNeKG4XU363U7XBg2OjbkY38hW0PcJKwtuqtFJna4Ex0siX/sFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725841850; c=relaxed/simple;
	bh=wPV8YEoYLGqTx9bO1llFaMyCiCsTU5XfDU4kupMd/c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bu6q2iCIBZ0PWM1JjO1wN/a70Zz+WNh7kQ60NSaCoPLH7l85jJsvxzWB+/3+8sHplnqGnKY7Ol8RpVPXIf8Qg5xPjk1eW983nKR/0yT7P0GDmpFWwJhGSCOKJ/5hDf+yNLKua/qKepYbKe1GAbjYvTZP4JIFftO4xDLwTSXhTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TW78uOL3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20546b8e754so261585ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 17:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725841848; x=1726446648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJjhNLbpnc53C/tv3mczouRD8+CJs7f+bOzNSZ5DZtA=;
        b=TW78uOL3GeTLI+Hxjui4q3GiWM5unwxfp0CbM7cgFCkzqhf5JVL3rk9eQOTHCF47Y5
         NXEzcMmUX6rfCV38Iv0lVQOeOGFY3CuH/DfT+SaSNS81+r2eTEtsx9+ArPSPduWSJwWC
         SVFumkZzfhudHieEDWSsH4z+uL9+g4Q6JYsav6LylfpBIa/nqtyB+w+n57UG3COrypw+
         jMCSstM5n9bHDMozwIC5suAmmaAHUU+KJ6+HO0sQ43X2eq0KtzULt3D+yr2Ap0HVfPWC
         qi3XnU4GpfluU0Iyk7ANcPNjNhx5+AHH2/rGSY7kz4/l59klmDBMqpguFGSMU9gz27l7
         cK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725841848; x=1726446648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJjhNLbpnc53C/tv3mczouRD8+CJs7f+bOzNSZ5DZtA=;
        b=DEaWm4LItlaWA+NQuusYRukvx2d1Q631SkQ78R3CgK0UqDZwIIjBPoW757N0G/wY19
         yIIj8g3baDmyNcBxrRdNln8s60Dl4IaolJvJ74qzS/qKhNiPSKYV7hu+o/gqgjB5BcID
         LAXSzQFSjdsXdsWpUeu+sMBLjQIWe52wa/fBvn07oFfFLTOVPuzIMWZjBl6tnbdrFPln
         LkxahAh6cegKhmuJKmSRrWxsaXCBRZ1mrY8Fs6VQlHyVA98guWUngAM95Bwr3MejkiPP
         wTxmA1Y2ezZrA2TvGD0XGIl+JDCvAhjw1e9OnaykCzkYNot4SaXoAZG3YNeGsNM+Rp8J
         OXyw==
X-Forwarded-Encrypted: i=1; AJvYcCWs7vopy2Jq1Zn9/51yGRt56C0jjAoYu59VGozsuoldGn7KxD43OO+1fIqbyNBh5fWaBZIEkZhedgA7+K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDxgjVgHAS7V6Gs1zVi+vsDrah6lua0wUSr+wgK49P2eRYuZUH
	ThpYn5rMw3/iZrRm3M9hT5EukHCZG91BGDM2EA2QvOdTTdLP3KcN8mCN4BkRbz0F6lldq9T85wo
	k7DhNwTSUq5VaHPlHlW5ZTUlA0XehRIJ3qK+O
X-Google-Smtp-Source: AGHT+IGowZzSEmTKRevgtTKEx/JN1+vLY4SrQ8bcDLX5CnwXX5QhslEZ/rC448FW8Ec5061Ba82Z65wAVG0P2JfReNo=
X-Received: by 2002:a17:902:c401:b0:1eb:3f4f:6f02 with SMTP id
 d9443c01a7336-2070a839333mr3341795ad.12.1725841847501; Sun, 08 Sep 2024
 17:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907131006.18510-1-algonell@gmail.com>
In-Reply-To: <20240907131006.18510-1-algonell@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 8 Sep 2024 17:30:36 -0700
Message-ID: <CAP-5=fUW1z++JdFHke8X8Ou-grBRK_8rYPgd+CNjVLB9iZ5csA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix a typo
To: Andrew Kreimer <algonell@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 6:10=E2=80=AFAM Andrew Kreimer <algonell@gmail.com> =
wrote:
>
> Fix a typo in comments.
>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
> index b2a368ae295a..0854d3cd9f6a 100644
> --- a/tools/perf/builtin-help.c
> +++ b/tools/perf/builtin-help.c
> @@ -417,7 +417,7 @@ static void open_html(const char *path)
>  static int show_html_page(const char *perf_cmd)
>  {
>         const char *page =3D cmd_to_page(perf_cmd);
> -       char *page_path; /* it leaks but we exec bellow */
> +       char *page_path; /* it leaks but we exec below */
>
>         if (get_html_page_path(&page_path, page) < 0)
>                 return -1;
> --
> 2.46.0
>

