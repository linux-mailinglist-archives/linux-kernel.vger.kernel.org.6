Return-Path: <linux-kernel+bounces-407611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 256B49C705D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA8FB29B64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E7A1DEFF6;
	Wed, 13 Nov 2024 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCs1D/bh"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1717C7C9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502619; cv=none; b=FMl3HHrGazOq4k+y6t9t/qyYv1HfamorsTSsXFATBm/BJ4NLg1IQYXVw7TrFtx7ypsxC4luOsr94l7PWQJ3GL5XhJBBKH+ZdurZeU3RVu5sxhFYkZg2igCv/GR9srAHejYLBhhQqDG2YtZJ0rlgDvyJYzY71nWQ1x5TCmGRvswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502619; c=relaxed/simple;
	bh=nsF9FYO1giL4pYCMxHeNqsfHL3n45+fIAA7Zs0xLiDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ptz+TvkaAkH824MfAn0ecIiyUD0WuvX+GWGvapZA4ScZaNpsngQpnyONvbGEtAd/vmO3kbdYG8fmo0vwT1SMGTMvzC2ZxiQKapHAzv6Tc0SDtHYWm0cTfHNdB0Gn1DVchBDLMB6wgbhW26M6WnxmsnWzrxJpqcPYQuaxBaC21Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCs1D/bh; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53d9ff92edaso1011804e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731502616; x=1732107416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nsF9FYO1giL4pYCMxHeNqsfHL3n45+fIAA7Zs0xLiDc=;
        b=GCs1D/bh9c34xBvgDRh6x6a9Rzyj6ZOJPxezWwDd0sJOM7p80eJTuAGhhf60XBbePd
         aJlwM+7PvBoLJ3T8AeJeX6M51zyDM+L3gXdB0JVwE1ACFUKqe6bsHNE5wMjtW5RmPze4
         4ayAWbQgzGAcwTXplOfo91sLVPGnJc6qNxideFXpH5hAIk1D/vi3ovpWEaDBGNoiZoKI
         xbDQ0HFTCqwOZmZWjCkuNsbO4lt/er9avMztXRB2kkLSI9aw5yYhFE9Vdivht+9OX1We
         MojbI4skzzDgHhB6B8RrkuLWKXSlxRi2KoGP+atNzj6Z9RDeRpr+ygBpRtXppC21PAkr
         7KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502616; x=1732107416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsF9FYO1giL4pYCMxHeNqsfHL3n45+fIAA7Zs0xLiDc=;
        b=RWFIn72/Eb8535l09e0QqHXi/Tp6lF38+XFootTgMisPBhYWphB57b6EYAMJqH6Mye
         kMyGlen89xuTKmL1GnrvIWjhe7S2nBPRMvbVEiBAi/UBNS1uyx6f27njt3QLPi7rbE6r
         dn6L5mImT/Q8bUu8FB2kV8p3jC53LPMGrqzVgM8daFYLkjpkL6Spivhsr2lvoap1s0vC
         S0szIC63HP9P/wTljJL0XeWuW8trPpSxTvmA20YUpLjYCspstFWDFdII7qXkbgqR+MF1
         h2urKnK0h3SkQDOAdpaj2j3c6L924wtvGTatKkgQPywEk7LobB9MFPlltKxFUxDrrcRL
         C6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCiUoFX++wdQ5aGsRXqOJ3XR6mwD/jIN/zteSpEoo7PyFykImfxbyxj+cKbqVcfymm6+mssFvGHCWqrSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8eNt5CwmmL+JzQsmqvmqQ5Kik+NZsuexArp61Yr3RaXFqRP+
	lI51qDIKBbKu9nZCCS752wblx4RYYGKhyZxFdifYi+v0ZwcxGAbBm6GvAXD/YQ==
X-Google-Smtp-Source: AGHT+IFE3azi6MEspsez/YqVpfltyfERpgY8sGasO9+OXOeFNj/tcHahdw28SQ3NLTe9e4vnUTpPeA==
X-Received: by 2002:a05:6512:118a:b0:539:f807:ada5 with SMTP id 2adb3069b0e04-53d9a406ff4mr4258046e87.3.1731502615698;
        Wed, 13 Nov 2024 04:56:55 -0800 (PST)
Received: from google.com ([2a00:79e0:18:10:2ee5:f43:b1e7:9d47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7127sm2196125e87.149.2024.11.13.04.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:56:54 -0800 (PST)
Date: Wed, 13 Nov 2024 13:56:49 +0100
From: "Steinar H. Gunderson" <sesse@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] perf disasm: Allow configuring what disassemblers to
 use
Message-ID: <ZzSiEXgijZXkhIoP@google.com>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-4-acme@kernel.org>
 <CAP-5=fW7teKmRfGtjkvk1=PArt7M-v=CBF2EjdY0SbgdU6DtqQ@mail.gmail.com>
 <ZzI90g83cGIKSUDu@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzI90g83cGIKSUDu@x1>

On Mon, Nov 11, 2024 at 02:24:34PM -0300, Arnaldo Carvalho de Melo wrote:
> On my todo list, and here Steinar could help, is to check if we an have
> source code intermixed with the llvm based disassembler, like we have
> with the objdump based one.

I am no LLVM expert; the only time I ever touched it was for perf :-)

TBH I'm not entirely sure what functionality this is, though; I don't
think I've ever gotten perf to list source code for me, ever (in the ~15
years I've used it). I can give --line-numbers (and optionally --inlines)
to objdump and then look up the line numbers by hand with an editor,
but the actual source? Is there some way perf can attribute the samples
back to individual source code lines the way some other profilers can
(i.e., showing the source instead of instructions)?

I would assume that LLVM has some way of outputting line numbers
(presumably by parsing debug information), since llvm-objdump supports
--line-numbers, but that's perhaps not what you're asking about?

/* Steinar */

