Return-Path: <linux-kernel+bounces-271662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E331A945146
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E451C22E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED051B4C3F;
	Thu,  1 Aug 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gI3+IFcm"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E2716F8EB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531890; cv=none; b=kbWMNvuNJaENVT+UpopKa0boi3/HBYnZwXluYKlgEQIyz8oqKz5jDnKTGpKyAjb+dD+2FhtheQeFYRh4wIBx8H3NI/JEuBSgNTeDyzwBnXWiXyCikXA0XBysffvY1Et2Y9BDKzzBSW3bFEJAX4vR/2gwYggxuTizibmTXCfUfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531890; c=relaxed/simple;
	bh=da/KTlsA/T6nP+MQQcJgJpHnRuCcbVPcCXOijp5rfBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxClkENWwuhMQ/8FRzM88V55s4bdOErZegQ8/lYjSeF+B5dj5AsLy4V1nW0Y4oIB/eq5merlwxp9uixEv8RrECA1opG/c1KOxygllu2rHUedj3U4o1EaQVUAthrLnqkt6a8XHY/J/NjwqMeY/Tmn6kRIdWnNE4AiFw88sSCnqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gI3+IFcm; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39a16fab332so322155ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722531888; x=1723136688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVP6X4cx5hMdpcYhPLBw8mfjUpF4ioKmAFgeCcQFeW8=;
        b=gI3+IFcmF+/9cHU4lJH5K6uToqhgbou4zcdEAHjECSC2i2esqb9KYNvDpP4MHD+VnI
         HmKQ1bLVGK1xZlEYBbCuO7VmU5u80p4lCcRWHyPFi0KaF0X5AIBoYXiEtdVTobCXVrxD
         pzsHTeNvvhRFVZONrHCigqWlf/h2TArGsZiOnoZUODv95JImy/DL6vPLQSVtoAQWhEAE
         nh06h29JA1+IN18ok4eMFfUIA7MiP3L1jIhBPYg0PTr+TaGm0qke4/iJh/XPphTKGegJ
         cYiG2hWBo8SrqSAcP4Q4fae4C1XTY7cmx9Tz/qc/U5ysLaMB/VTb2wFwxTBG/RjQ0Wau
         bW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722531888; x=1723136688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVP6X4cx5hMdpcYhPLBw8mfjUpF4ioKmAFgeCcQFeW8=;
        b=hdJzc00a9DulXG97ray+PmwytspMRGmtDfoQ0OeYQFf9bNnchhhLTKCg0iudgzd501
         aX3nech2BSf5uwrHLRn95AZe8ACg4u0NHOcgezwTtsTo8f4hIAL1q7cdZX1y0x28Bk+G
         EQ3pBCfBBoLYTpR+Z/vawL0Nr97TjhpnELnZavtfi7h0huTY3hkYKQSs34PUrtMuUJLQ
         qgPIK0zyelOTCSlgELKrRDT+TnTlaVp+OG4317weDHqK4dZhJGYEDVT8MMsSq2Azeffc
         pHpUufY2GUT6qR18U2mkbMjQqbffKUzQ8x93nMkBgFI+sXHjneg6mpvJ1wh4q2Nki7A1
         gW2g==
X-Forwarded-Encrypted: i=1; AJvYcCUxNJliAxqFpsHFRMD4HBdA+RqGVXBaSvk+LVOjHZ7EwAcFCbr+9vt9pfqCr2HXdjKemUtqkVdYf8NKtkSe0S8oDq3Qz8NRd77L96tG
X-Gm-Message-State: AOJu0YyiEMnVNAvEXfQQ9Jp0iX6jcIW1INp0LYQMnVQQWTdZ0/339bD4
	1yaH3xfDIR4qeFlHSl8i0N7Wc/2xbs9rAr+cNyMol16D9jn2y2udnVVq84/QVqx7BtasW4Hii/8
	svI7ENK7D0C0vFC4UaHN09VThJL0qLihKqdnk
X-Google-Smtp-Source: AGHT+IEAAn0hKKVbU81NKzLk+DGvI/SWRloDwlMO36XLGrZTlziqtRQpW9ug1eZbl5h79og4+RS6qkPngb9XdfFqovg=
X-Received: by 2002:a05:6e02:164d:b0:374:a294:58bf with SMTP id
 e9e14a558f8ab-39b199e49b0mr3466655ab.10.1722531888158; Thu, 01 Aug 2024
 10:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719115018.27356-1-eric.lin@sifive.com> <172253043753.13740.1828763400860823722.git-patchwork-notify@kernel.org>
In-Reply-To: <172253043753.13740.1828763400860823722.git-patchwork-notify@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Aug 2024 10:04:36 -0700
Message-ID: <CAP-5=fV3NXkKsCP1WH0_qLRNpL+WuP8S3h1=cHaUMH5MFkVHQg@mail.gmail.com>
Subject: Re: [PATCH v2] perf arch events: Fix duplicate RISC-V SBI firmware
 event name
To: acme@kernel.org, namhyung@kernel.org
Cc: Eric Lin <eric.lin@sifive.com>, peterz@infradead.org, mingo@redhat.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, peterlin@andestech.com, dminus@andestech.com, 
	locus84@andestech.com, jisheng.teoh@starfivetech.com, inochiama@outlook.com, 
	n.shubin@yadro.com, linux-kernel@vger.kernel.org, samuel.holland@sifive.com, 
	patchwork-bot+linux-riscv@kernel.org, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 9:40=E2=80=AFAM <patchwork-bot+linux-riscv@kernel.or=
g> wrote:
>
> Hello:
>
> This patch was applied to riscv/linux.git (fixes)
> by Palmer Dabbelt <palmer@rivosinc.com>:
>
> On Fri, 19 Jul 2024 19:50:18 +0800 you wrote:
> > Currently, the RISC-V firmware JSON file has duplicate event name
> > "FW_SFENCE_VMA_RECEIVED". According to the RISC-V SBI PMU extension[1],
> > the event name should be "FW_SFENCE_VMA_ASID_SENT".
> >
> > Before this patch:
> > $ perf list
> >
> > [...]
>
> Here is the summary with links:
>   - [v2] perf arch events: Fix duplicate RISC-V SBI firmware event name
>     https://git.kernel.org/riscv/c/63ba5b0fb4f5
>
> You are awesome, thank you!

Fwiw, as this change is in tools/perf/pmu-events I was expecting it to
go through the perf-tools/perf-tools-next tree.

Thanks,
Ian

