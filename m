Return-Path: <linux-kernel+bounces-408993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D09C8621
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741162881DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94211F76D5;
	Thu, 14 Nov 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5EIOpGj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD171EBFE1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576471; cv=none; b=PSZKThrfQBGFOAVCodNWrlaRVMeJecvF6jSyTZVZ8Rrv4NRDoLo+B7NbkAOhI2J2kcsEOGswqUn0dnF2YukXUKXrwagvFnu9zdHfG+PQdYG3iIvheZ+ZjlB+JT/8IRzULrsF6AAGMfYOcPgoZ33fFxxIrXKtboxU2f2MecTKdzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576471; c=relaxed/simple;
	bh=ujXkAz4mC8eFae8g5t163fNJfEncieh1V8wdDnl/jWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8U3F4qUXvbF3JNWn6IaSBD09A8+YlL/WL5tttS927xwGGOJy/aW7ijEJkEwoVNHxx2aJw20CNIETY6z1Dnv/YUzrgxUsOgS0dL6HedMJlE+7Bh7Y8+JZG/ilVPMFGTGbOiSCUblb0zalT1M01NFhjHVfcIkrwGm0n8Wo8yYCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5EIOpGj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so369616e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731576468; x=1732181268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tq/XRI940eBi2hk73EX1Uih0B9Ig4u+u6Up8x85IdIU=;
        b=G5EIOpGjCG/41qoFPRMwoILFSSoQmWMiqblRQaeHX41FqYqFMef3bxfDbfElBgWKnI
         rglWnMmClxtPgLyZBu//NZnU9zVrXuOIUO7TI1zcOavIn/bYnqRSpbMfcRhGguJadinj
         ZA+RRpo+3sNqdr1nS86S/pSGBNvv9+ix3RfuL/7XpL/Gtyf8MYECaqzxbkqEiLuG8JyF
         fGxTjA9y7s4c+8nBPXkURFYh4FZdnQir6XVSsSEE8MSvniYHNbNOGEgEf+feiyFBTBbP
         0jAANkqId5mAtOBJTBb31swNbz4UyMZCPHYNqtGA9qCgS/+wPIRwtNi77Wt5kLkm3IDz
         ktQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576468; x=1732181268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq/XRI940eBi2hk73EX1Uih0B9Ig4u+u6Up8x85IdIU=;
        b=l7z4tO9csP1rWs0uT3kUXe5kQsQ8U86T0Y9315b1telOdBY2irytaUPiZhfbX6/z4z
         TYhlseS7wPvSd21wAs1hbOOV/tJc/CVcOoMwXm+8JKAIEOKqkXaBpKiovx9AdZN/jbQ0
         EJ04Jjn+uixEKvd9jTM6HhoRWnh62lIgfrMKffyWDZ9pB0psV/ZyfWPA8z/5hicXw0P6
         8nyG1YXIKa4wYO2RjOsnIMWPpY2Js+Wr5uH+itasab0bPnQRC99uf0P7AIYqhghpOQga
         dMnUc/vYwJGCRGWP14XZDxG8RLRRqR51drRq+Oy002zZx1Ky/0auIwyG8RUPK2+2GwrW
         6ddw==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZnfEVejN9ELuDvWXIwAyfwnosSNdhZXaBMzXYf2cFx+ZRwfE8qZfYM6hIpAEUFd8dOcr9stmzLQdkt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZOezz4HucKQFUTQCm+tVhTco+IDdsvq2Cxkpf495SJXGgfP4
	RBTfkMQfMBxIwZnN4Un25bRgCmC67L0QyfdSP0qRbqjJSR0oaApV9PJ/est80w==
X-Google-Smtp-Source: AGHT+IG1la6K1cY7jFPT3YBqPV/SUwY/alI7LxaKIjO/GRx2//v2F8HA676xWPGQaFYUqy0OpPLkDg==
X-Received: by 2002:a05:6512:2387:b0:539:8bc6:694a with SMTP id 2adb3069b0e04-53da5c776aamr660206e87.43.1731576467542;
        Thu, 14 Nov 2024 01:27:47 -0800 (PST)
Received: from google.com ([2a00:79e0:18:10:f492:7c34:9c2a:c5ee])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da653e1edsm118878e87.183.2024.11.14.01.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:27:45 -0800 (PST)
Date: Thu, 14 Nov 2024 10:27:39 +0100
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
Message-ID: <ZzXCiwDSqCMzaA17@google.com>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-4-acme@kernel.org>
 <CAP-5=fW7teKmRfGtjkvk1=PArt7M-v=CBF2EjdY0SbgdU6DtqQ@mail.gmail.com>
 <ZzI90g83cGIKSUDu@x1>
 <ZzSiEXgijZXkhIoP@google.com>
 <ZzT6fjDSUlPzUt0U@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzT6fjDSUlPzUt0U@x1>

On Wed, Nov 13, 2024 at 04:14:06PM -0300, Arnaldo Carvalho de Melo wrote:
> So, source code, automatically obtained from a debuginfod server and
> places where one can put a probe.

Mm, OK. Unfortunately I don't have any debuginfod stuff available on
this side, but I understand the desire.

I looked at the LLVM disassembler and it _does_ insert line numbers:

                  llvm_addr2line(filename, pc, &args->fileloc,
                                 (unsigned int *)&args->line_nr, false, NULL);

But this is maybe not enough? We don't have any machinery in perf to get
from the file + line number to the source ourselves? (What does capstone and
the embedded binutils disassembler do?)

> You can show just instructions or instructions + source code.
> 
> There were requests but no attempt that I know of of doing just source
> code.

TBH I'd love the latter, but I'm not going to sign up for doing it. :-)

/* Steinar */

