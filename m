Return-Path: <linux-kernel+bounces-546328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F325A4F941
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF0B1892A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8AD1FDE37;
	Wed,  5 Mar 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aRhsMa91"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECB1FDA84
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164941; cv=none; b=MYl/y4Gh27OFM/HEvM6Tf6awqiPsKchVArtbdR9Sux8EKlidF/nGvAG4WAYqFNDoFJI0m7eolYWZIO6UoI/mrpars0dVSix0+vhSJH3T6fVj+tsIkSZ3NI5OP84Pldo8y8ZBx5yEZ2GBn5Lnt+6rQHkoPGRZaYi1y2ImgsN5BPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164941; c=relaxed/simple;
	bh=1tt5ib69iMzXY4LA74Vkmxm0BW7B+0tgn09acyb+eME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP3xby5ZEt7Sz672LsKewGqqD3lPcj/elyl2nY6BTo6bU06sYEdkir7GLykL1BJZf2Njf6kjtApNa12QrT0gIprHxsjJYT1yvfz+H61GtbaOhHK7dgGemcif3cfDHZpB5Ccnrh90b4iqu92ZAGCrY+TA3r2oOFyIuRqPbbNiIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aRhsMa91; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390cf7458f5so6018256f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741164937; x=1741769737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLtjA+wzwLnIjfOlPYyCZCKUn7sRpgky3D8g389O2dg=;
        b=aRhsMa91PlBsjSkESsdzsPB/p7pXyAa+5KY9l/zHgBVDWKTrapQjxvc/DQWDPNoWbg
         AjqfEOHPYGawTeZpMz8fVf+cDK4GtNh1uU7/HgDf2xWN1zNsct/DLfkdUR7HKIo3XiFq
         hGUZIHepalt61kV0M2+Sw5uojL/zN4jP5klFtcTkRDnC3O+V3MNdtviwa2uwx7kMRhsu
         hhjS6MqRbw6SZdUUsL+dxYBBh4SEBVYcpAS71G45h/5nwOozQ0hRsmix4EKi6cALSAiK
         Jxvn0N1q+6AABRpWMPRyToDFYhjmwSqrGYQ3XQcY1Deaq+WmgGNvTg1lgTFs9EM8xAFr
         DJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741164937; x=1741769737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLtjA+wzwLnIjfOlPYyCZCKUn7sRpgky3D8g389O2dg=;
        b=S+z751fkpnWPOidECXb6yBw85JzCFSJa352khqxuLAnjri2Sn5Cg2Jm8PAxeGulSIE
         q1u+OCLLLWvf3FvsKz/lEYfzgGb49CwC+5PX1WQWlrNU4K3RQ92eI0xFI8cYHjD39Iiw
         EjpBEMMAwrKZu/kZPjf5u3NX0SZYFskqqaPxPlaYFnORU46lL+xUDuYoqP0apGKTR3PS
         WTNsXzV15OsgS4Wim82xP1UIFeAV6/sZEt9Tp6OZnGbSkm/sBiHYsRRgb7OjxWvr4sxC
         TnRmcFn+Mam2CPNmTGzsWDCNv5wt+8ksWW4zJZ1BX855tRgB6SyWkOKmpsgGRUqYn2ad
         zQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCVkDbXTqCuo4q+OhKgPBRFob4YUmi8EoOqHnB8u0ggkY0Fx+imkOEaJhAQev6ccRqYXbuN5OA8nXZ/xwng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHOrsOF1Gre4hFHMMFO7RW35T1gobp7oBTq+Pve8NI0t0ACc7
	cFQqsL1M9mvvfKA8xWIRd6wspr5AyIQ1z/fIHNNg9U5+0rgxX37VZq/qK3drW8Q=
X-Gm-Gg: ASbGnctcX2P6f9SSOE7tZ0WZ4cPjfXeDF11r2PKf2UMK9WECvtWyiD8G4EGRqMto0h1
	PZlCK43oNvvSWASqpYl1G131VIJpYuhMCZxguVY4VFJjJF3vC16/95xjzWUfPKatbwmpgWXnFF2
	AQ/6It79K3LgU+DjD2t0dsZU3EWOMl0sGqvzVyxQtMPtlOMJyMUXD2MYlMAuGvuclDULU/qEPOT
	ltvq++j+QNU2W7o6WmKSbSSizNy6X+2cKYcepojaEfekxOopelOrQqvOBCC47hUzIm6VUbMrnYj
	6b3GCxFS40LOAiMsd6ANSbJofcRUsoZg3GOw6Lg2lAQXdhE=
X-Google-Smtp-Source: AGHT+IEOjRqlCNucxZnWpFSu0mZSzPF3tEADkDKCagU2Hig2+iE7cTPN1i5PvOoBL6qL6HQEoP6zng==
X-Received: by 2002:a05:6000:186b:b0:390:e1e0:1300 with SMTP id ffacd0b85a97d-3911f75a93emr1731801f8f.33.1741164937517;
        Wed, 05 Mar 2025 00:55:37 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d17sm20007131f8f.28.2025.03.05.00.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:55:36 -0800 (PST)
Date: Wed, 5 Mar 2025 09:55:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 1/4] scanf: implicate test line in failure messages
Message-ID: <Z8gRh5wtzbpiV8JM@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-1-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-scanf-kunit-convert-v8-1-5ea50f95f83c@gmail.com>

On Fri 2025-02-14 11:19:58, Tamir Duberstein wrote:
> This improves the failure output by pointing to the failing line at the
> top level of the test.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

I like it. It helps a lot to locate the failing test.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

