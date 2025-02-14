Return-Path: <linux-kernel+bounces-515032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D6A35EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5491894364
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35773264A7B;
	Fri, 14 Feb 2025 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Ytw8eBJa"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE664263C9F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539216; cv=none; b=cOIepR/yMk1MVeHAu1dAps2WH77q2p8uR7P1Y7KGI9pOEuXcj/p1kczuaXxgWeDdba75bclN9H1QpVViuMJeFABw7+HnRA+kvW/dhnfRQtJ36StFkSZ9bjdDIM6mqstRCmOxe98uwISIuf7f3TfqF9ZYyJHTASyOz0uTIfgKvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539216; c=relaxed/simple;
	bh=LJDfth7mwVclpXHFDxPtqz2sjNg3HySlIQhTKo6hMgI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=GQc7D731T7tcadBwIlYZsHvY4V25BwVSkuxrOYdhDoM+9bo3yqQK1cfnPTsdf94/GxytdE7WKDL7fDRwBj5KRNYwsUevh7D/4dXgNTT/gST5lJoDyDgYUCkd2LnYJrHShC+Rgct7x2PwdBYlz19Jj28xnvbAPicK3caJPd0A+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Ytw8eBJa; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f441791e40so2985136a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1739539214; x=1740144014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6r8x3zxj8rfgJpz/X4WBbZ2ZvxPjPV23GP7TSjrfJWc=;
        b=Ytw8eBJaENW6FyauHVDqaV63jq9DBVDga4bJfhF8hk0B3vqQt1o9VZMcbV1m3u4Da7
         KMOF/+k7UUBWeWqEu0yMFNjaJgeX9EHmF68TPqjPwmr97Prl+xmvHYRogGHfadoBsGN5
         7KQKqELt3z0X7+nVNfm95YFStiaVi4368qUTF0N4GdlRs/Kua3KDabrYSrFnBes7DGK9
         CZ62Frck3tJsMVuY6jvesP2pvqpQ68I617S60xoLPU16sVPvnzrAv8vrrcQp82RImAOY
         7w8IXCEd7YVJUTc948ngtJ5C59PPUKcJsl7UZ3w1X+aPzexleUFjhIIJo4E9T6nmyO8v
         t4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539214; x=1740144014;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r8x3zxj8rfgJpz/X4WBbZ2ZvxPjPV23GP7TSjrfJWc=;
        b=LXCz9/cge2S7f+G90gUkm6N9ecpidXbrf5HgPxUlpgF+OQAKZYv3eJr2L2iuN7XjSx
         YE71p6AvnwN0koYz0E68WGejriAe83XkgIh4eV8ZGdtMiAe78H69bAOMU55IzVNNvR60
         wwhD3UxvWNSEePQnAR5VZ3fv/YWtIm8SnzERknlv8vnbuFLRc56IybfPk93xpKxxCaq+
         iYifCYQfsoGzuT3arTmKo0XqPoViiQ3TcS41IyDjKZmytqRe/pwsyiBT+DkBZiUDm7i2
         dQ2+Xj4nYujAEo/AQTxF5H6MLSmZUXCiD6HsRwK8REzwOpAXpeRQ1i0DCQs41wRWjeWB
         hYTg==
X-Forwarded-Encrypted: i=1; AJvYcCVfdwSgXe1m8JzC4TfUOhW5siSURwWyNS6EkclBeJ1dW+Hxpy/ejhCXbaISAFySbGhmYhkBhFYxozKprno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxurmhoLHLf2bZmEu5LQKUYF1tq9jmazS4EvSASJHAth5QW3p
	DuUB2NuDq5QucIYF3LmZr4ryx0YYO/s7qE8xiv6UZCOhUWaySkBZwQri//RQ24rg3tLITnJOFPg
	H
X-Gm-Gg: ASbGncvLOXA5hRSFK0n3/iKvPhQ2AcAixyFNxYVkdBvN1hk3pWUZ7ENa+OcYJVzfjKP
	mfTqANNdnr9vxGlbQYZ/v83TFf5qO0fAm7qWRQcOGWYNtSq1AnmD1AltdpZS013XPqlk75Q7eEF
	r6ZcQ0ZbGO81a4BlOHz6pkHYHuDZO/OWKlo9QA2hopbP7SNXspLDqHnVMk4mDL4CeyPT0RqqIAL
	qy2lUTkHpN3T+H8FM8DM5pKpvPc0N9iuUkxXDJvihI8bpzyyV2raJxpB8gSUwAz1JmtFgc73gTB
	ZrVcBB1M/A92
X-Google-Smtp-Source: AGHT+IFAu9PBC3XJNgx4mWEdV9pMcuKKbaayr4w8bIyWW5djqyfxrKy7LSzRf+42OO9NVLq/OxD9yA==
X-Received: by 2002:a17:90a:d88c:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2fbf5bf82e9mr17025020a91.13.1739539213982;
        Fri, 14 Feb 2025 05:20:13 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad726bsm2958481a91.28.2025.02.14.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:20:13 -0800 (PST)
Date: Fri, 14 Feb 2025 05:20:13 -0800 (PST)
X-Google-Original-Date: Fri, 14 Feb 2025 05:20:11 PST (-0800)
Subject:     Re: linux-next: duplicate patch in the jc_docs tree
In-Reply-To: <20250214161032.1ef4902e@canb.auug.org.au>
CC: corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
  linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-60a3c06c-7d2b-4fee-9012-6ed036e756ba@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 13 Feb 2025 21:10:32 PST (-0800), Stephen Rothwell wrote:
> Hi all,
>
> The following commit is also in the risc-v-fixes tree as a different
> commit (but the same patch):
>
>   b48e0f696b71 ("Documentation: riscv: Remove KPROBES_ON_FTRACE")
>
> This is commit
>
>   ccc71244f95c ("Documentation: riscv: Remove KPROBES_ON_FTRACE")
>
> in the risc-v-fixes tree.

Sorry about that, I dropped it from the RISC-V tree.

>
> -- 
> Cheers,
> Stephen Rothwell

