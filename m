Return-Path: <linux-kernel+bounces-253830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7993278E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F544B24C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C876C19AD93;
	Tue, 16 Jul 2024 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QePZ5VZn"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCD1991A4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136829; cv=none; b=OL0xDIo25CfRtmGx5580KP2J9K9QrSBz8ng0QANTapv3gMnK3uEnZpGxP5Vq9VDnv0F0iQ1KEfozIgV/Dk9Doph9gHuuxGCUXJH3ACjju9K0wMFMhaBUPf9YaPrA2hzDWryXds/4YMx3jOIBMbrM6TIvRkUhpTDGqLax1dfG88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136829; c=relaxed/simple;
	bh=F58GozdUKArNO0YBXAKBv4/LUo2VIkWG9yLAJkk+NUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqKIX3bkodeWyvtwSmDPXkytzvtJ5FlUkbYVC0Q0WVB04BGmZRtji36PURjXQ82mJTdSMFfqxyV/Ld3Fx3XS3xH+c0TeA1Yer7Lz7H+//Mp6cW0SO/MD60gA9cPmOcx2nCPUauezxee2DSNoIuMsZrhJOPHq0WeQCBm4z2cYvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QePZ5VZn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb67f59805so185515ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721136827; x=1721741627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiEVpCnl1fW9Re114XQTxpk9OjUT0iHxZmwQLd+uqbU=;
        b=QePZ5VZn2ZbszAXOCPC8NQbCfQt2vzZJvY5j3jC1072DSeN8SAb99tohEk18tMZaXS
         tV1fuC+P956s2Jp50Wzrb0pZ8aknIDZu+zxzqhZtc8TlKs+RtOqN22bg1VL4perkW1Gv
         ZtUE6i6l2764wcAhpI09V4TlJyryw8zWwwDVlum7qJg2X0oRWSGy4qonAdIxM/XxX+rf
         gYvu6VcgrzwzQbaf5NateQW7L7QnoM0tedCXQRihcF0kvXxgH0U12onexBZAC8WV0GXl
         aRFzt4k6y59tG/XHOY3G89VpAKFErqgVZivWPaaQyBe3qshGob1JWvib/eXNqoNJtlyJ
         /R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136827; x=1721741627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiEVpCnl1fW9Re114XQTxpk9OjUT0iHxZmwQLd+uqbU=;
        b=K5UG1ZFlizdx6jL2JFt9tQl34LeamnvchIVGuuzegznviJztoA6RZz4f7d2nWMdRi6
         EhNMna5qLVbrWtX6UbF2zk+fBYvMLPEDA1SipDAqyxlr3NwbXC3ipT8kiuyez0VbDxd1
         heXfns6E+Alja4cL63gk9kLEIvxC2fWLTyp/UfhuMy1FkYETI7mW6gdomiS4DxUZu4pZ
         wG8JHPB5MEaBinF5kzTZrRcsop5YTkYZRg2ikru7nHLUbeyCcXuKJMFd6PUpZw/SDQDC
         hDoQNvMSQK7tRb1YfsjoLzj/TciQ8cUHz9vl81RggB5tp2Bzday+Va3d5fcGochfohfW
         MRxg==
X-Forwarded-Encrypted: i=1; AJvYcCVD121DmFZagVEaD5xbAS0UuIMosl/TrJj5Luscc6XWzj3UvtWWE0Th4/1pqq5swuBXepUnTXpAzdoDuMraE6QPhGFaYONPK0wEoQEU
X-Gm-Message-State: AOJu0YxMS48EUhFKd8ZCi//EAp4JhmPSoNKC7vXg9Yt5/T7L6Wi+QRnB
	SLQDHMuRdqZp860jmc/9JDx2ArDm7CMTP5e9uBGeZrXwFeXcZN60qMqJuITXZyn0biFih4W6AaR
	MT1wIAuzUa80qOxEH3o9axCTw2ABvONaZkhRB
X-Google-Smtp-Source: AGHT+IEP+u5GtQoC6Lj8z1CEEquWLTp8ZGZ24FO5mM285ePjpp8DQWKKcurPu/Vr94TE1b+70Is/54GL50akMx85sGs=
X-Received: by 2002:a17:902:d48d:b0:1fb:d79:fe1f with SMTP id
 d9443c01a7336-1fc3c7dafadmr3136135ad.24.1721136826554; Tue, 16 Jul 2024
 06:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716074340.968909-1-nichen@iscas.ac.cn>
In-Reply-To: <20240716074340.968909-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jul 2024 06:33:34 -0700
Message-ID: <CAP-5=fXn_0oudWiVgJ7pgi7GW65HrNOVaAg71c+JjfDnkK1cAw@mail.gmail.com>
Subject: Re: [PATCH] perf daemon: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:46=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Replace a comma between expression statements by a semicolon.
>
> Fixes: 2d6914cd59ff ("perf daemon: Add 'signal' command")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index de76bbc50bfb..18f7f417ba11 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -1433,7 +1433,7 @@ static int __cmd_signal(struct daemon *daemon, stru=
ct option parent_options[],
>         }
>
>         memset(&cmd, 0, sizeof(cmd));
> -       cmd.signal.cmd =3D CMD_SIGNAL,
> +       cmd.signal.cmd =3D CMD_SIGNAL;
>         cmd.signal.sig =3D SIGUSR2;
>         strncpy(cmd.signal.name, name, sizeof(cmd.signal.name) - 1);
>
> --
> 2.25.1
>

