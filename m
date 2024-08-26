Return-Path: <linux-kernel+bounces-302097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460495F9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33B51F223BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9008B1993B9;
	Mon, 26 Aug 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqEyBJDU"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C0199397
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700967; cv=none; b=GJjqR6iAIfz0aXmtN398rSI0xc1oJtQvfbIX0nXSuN7tpeMhpRImtBgGVKQmM/WTHfCRAmoq/UtvDPrRzO58pNlzvVPXTttKjVNrNEgemqDDc0TCjyLhrbjpTu841SOAb8Z7SCXcUJyFX9/ZIl0Ldz/wJWJ0fNq2SdNOOUCzrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700967; c=relaxed/simple;
	bh=Z8CkV/fhCDXiv5mn77KoUU4Qgbc4ZCHCxa7szgfyB/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIG143efvFfX5h2eyhAXq60xhj1dqKIj2pxIYvSBjvF150Q1Rjt9od761FnvfFfJft2vX7EUB4dsRwNjEK7iyD3/WtLWWLL2gUNxDSczOhPBgYhZvh9Nb6L/qAik4ZbGbLzn612fXcR3oblDK48dTniK8gcI4YxDQqBXLqksWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqEyBJDU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8677ae5a35so453777166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724700964; x=1725305764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24/d++V0Ue74kmJqvS/DavXrN79WZ4nLqogv72kXKno=;
        b=KqEyBJDUWEfwxwggKkrS8qT460qgdml3xWa3AoqEMnPQ7AUH+Te9kS+sc6d6eFMKoh
         W89oIPVXxMPaKQMa55+L81IsOOLqKsGYgAQWzwEbQBZDpSr3okWgSFnVpa6OiZoDedEp
         +a42d57bHtmVDEPz13u7uF4tZuCLE4J8NGsGRVmiqIwyv4MvgFXNPSl2JVjOQPP5UQJP
         WXLDEhzJqFjzrnhHLiF4qIn+mUlEa0GzPQvT6zlvG630tRadwkfJiP52N3LMou4rIObX
         7Hbe2HiPC6qG9RxY6vHemS1LJ+YrBisF/DYw5EPIWw+zQ2Y5ITyCSpjO91Jo8z1pcjr1
         h0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724700964; x=1725305764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24/d++V0Ue74kmJqvS/DavXrN79WZ4nLqogv72kXKno=;
        b=E3m/3bCxxCAAGfJaqUXC9Vdxu+2Dp3q/6wifKrEREFPXDRzzyPrRoED6uzy/2AD01u
         0xIOfwkLe/QpzCw75wack6nZcfaZ6lDJQDqGySbBiPHrjwPKZ3KrEn+/w7MtS9AF0Iu4
         LSKMyT8AvSlCi1x3pevD7iiNMSPmpGpevInJLndBQLgF4JzG6/ME/a5zJd5da/4I4x5D
         y1OhxqKQ7S4Zem5RCiz+LiwWynDcaZpMZjPtpVh5fP1OQXTGASIkHwnt5amugUeBK/Qg
         DC+MLQ66wbSZxnSuEGZdkR0IIOLtPg3hb3ENJq9dKp6jNxd7he+DOGtZSdJWwJT8I7LA
         A+ww==
X-Forwarded-Encrypted: i=1; AJvYcCUW5wEZzHjHee8z1FbKdk7szMm37MyhivZW+ygl3ucai5qq79dJF2CoFEgFjfLhEYzyq+fnEO0zd32GmTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVgnMS/pkQJGRc7TDXr7KD7ymz3DCOJjEmmWDJcdNk08EPGwG
	W+QLaBLmUMjX82hD+7RVd8tyODg7AowNhd80Za4TddYlMvKL2M88EE+5nA==
X-Google-Smtp-Source: AGHT+IEfycb5iiZymuS6/A5r7fPYBasvja3rpLa03Kr7wKm7iGMzy70e6xac0xoZKfX+K0CcjGzenw==
X-Received: by 2002:a17:907:3f88:b0:a86:74fa:6a6f with SMTP id a640c23a62f3a-a86e39d5140mr38126566b.23.1724700964028;
        Mon, 26 Aug 2024 12:36:04 -0700 (PDT)
Received: from andrea ([2a01:5a8:300:22d3:89b9:c5da:b451:c905])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d448sm11026366b.126.2024.08.26.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:36:03 -0700 (PDT)
Date: Mon, 26 Aug 2024 22:35:59 +0300
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH -fixes] drivers: perf: Fix smp_processor_id() use in
 preemptible code
Message-ID: <ZszZHycX31dGeP4O@andrea>
References: <20240826165210.124696-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826165210.124696-1-alexghiti@rivosinc.com>

On Mon, Aug 26, 2024 at 06:52:10PM +0200, Alexandre Ghiti wrote:
> As reported in [1], the use of smp_processor_id() in
> pmu_sbi_device_probe() must be protected by disabling the preemption, so
> simple use get_cpu()/put_cpu() instead.

  simply


> Reported-by: Nam Cao <namcao@linutronix.de>

Reported-by: Andrea Parri <parri.andrea@gmail.com>


> Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@linutronix.de/ [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Tested-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

