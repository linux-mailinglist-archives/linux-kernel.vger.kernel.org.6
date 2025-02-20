Return-Path: <linux-kernel+bounces-522871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D353A3CF72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9957D189259B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4031C5D77;
	Thu, 20 Feb 2025 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UWvQV8jC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCB63A9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740019540; cv=none; b=gGlIGKKMCAflurLx0pvGUzDTVomIwYtY7NSctS1y9okVbuIX82JLxqhR88jW6JfbTMaQSnQLPwzzPvZlYSCx96VEss1N6oChoroDguYsJaSo2Ub7C1lN24kZqM8VnDNRLBEC4jIqGiDX04SZvCLgQ7pyW8U0vLKgFWN4EPWTUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740019540; c=relaxed/simple;
	bh=FwKCf7NcHbE+wwInEarHAeiSJNgDjsARI31fiu93V9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O66H3oGqInPaSN2eXD/g2bZlP/2+AVxvBjVPiYQyBVIoz/eVCpnHG8jV8gNVs5PzBtXm05/XY+ONonxiS6hLrkL6s+0/2bFhER5IiCWcvhbtV/kiPCd7WgkIjB+UsO0zIin/87iu/9zsTfJrsR1F65rW86vfxslu08Ck8NfIr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UWvQV8jC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d132f16dso6263935ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740019538; x=1740624338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UI8er1QIo11ePodvaUDFPqSlfWIt+uqTGczwGI9wUfM=;
        b=UWvQV8jCdv36FX2zNipfPBTErqMu1f1ALlGOALLnopxSgMkNt0wapRFyyxk6HWiQQJ
         7SqjoUNxREnhQbWkW6zynsIYtzMXA25rWMyntfKhSdicfN7oAcV3uk1az/aykELM/kNP
         FwzNpfhcTOK+yz15EDv4GKrvYTSZ1XkpP6z9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740019538; x=1740624338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI8er1QIo11ePodvaUDFPqSlfWIt+uqTGczwGI9wUfM=;
        b=UDtz3gR0cqEroLcDB1fOPfFQR61jqwzVDWnlY0oEVCQ/cO6+U4svU4t0pbVWr6J7ie
         Ew5FPIUAxnYPzbK4lm+b8K2Vgmf+EEXjZwtevmd66g8LoU2liLNYIMYPg0gZ0hiebk9O
         VKCCTFUO7n4AQzrSgTX64+JyhCGRhkN0k3Edi3jeF21mzMDrAtRqY9MAQVKxVQOotX0W
         /FSsCf22fgzVU+ax5fIjBhNd/AGrP3T72QX/HiLj6pT+GdDxAlDGaDFOJZyvkDIsa1Gx
         naIamUsbUgHnkKAAmfdTj50OqGHoc1IrHw81Kx3VATKG5rddGJtafqGuSELdbk6HK2h1
         a3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUO+QFjO1IDFOHDpL1hB3zi8G7Wy0ciMMqjfCWf1ttSXKAB9Dls0T6GHO7WAhmbiSHKsqyhU90mxKyuKRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPMoMNrb+XxqSO8/h9W+Z+3b2r0djZTPpLbBxMQ4Xrq34foaUh
	kDE+MWw0ENw2mmV0BcdAGatbPt6V/hhQaZjI7Ub3RPN1ahMCzgYc4glm8JyKDA==
X-Gm-Gg: ASbGncu2/Pbj6O7FFqiZ8kH0vf7CY/069x/KqFuBWSUaU/pLL1LgUGxnFqqMR/CjUOy
	zrRvYXrWN1u5JjvZ5gvGCJ5+2hAwHIsAgtMal952kn50xwWPuwvMc58NMfg4uPY40BzquIOkvuc
	qS0sLWLRBYeB43voHRiaUuXF20s17h4a+F9oPbveyWvklRSIO+v5efdpmZOpX3WuuAjz8isnHLr
	XlzNGFhLETlYqoAarQod0Zl40UZw1Agq3pOaBC0LU5wF4RwxZnITcWC7//NYgBmpX5ekIEdh0GL
	yqrXm8RxU937V9fEZkc=
X-Google-Smtp-Source: AGHT+IFDlx5KS4ERMHSoSvJOSTfsI+ROnGGUQ7neAcy4HyNLIs5qvkj/0mus3Vbm0DhOcw8QgKSbjQ==
X-Received: by 2002:a05:6a20:3942:b0:1ee:69aa:b665 with SMTP id adf61e73a8af0-1eed4ff478amr10713321637.29.1740019538668;
        Wed, 19 Feb 2025 18:45:38 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:9c92:f424:750b:8e42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ade415b35c6sm8018927a12.18.2025.02.19.18.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 18:45:38 -0800 (PST)
Date: Thu, 20 Feb 2025 11:45:30 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Waiman Long <llong@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Lance Yang <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Yongliang Gao <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
Message-ID: <20250220-112040-neomutt-senozhatsky@chromium.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
 <20250219112308.5d905680@gandalf.local.home>
 <0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
 <20250219152435.35077ac3@gandalf.local.home>
 <20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>

On (25/02/20 08:09), Masami Hiramatsu wrote:
> So something like this?
> 
> unsigned int	block_flags;
> union {
> 	struct mutex	*mutex;
> 	struct rwsem	+rwsem;
> 	struct rtmutex	*rtmutex;
> } blocked_on;
> 
> enum {
> 	BLOCKED_ON_MUTEX;
> 	BLOCKED_ON_RWSEM;
> 	BLOCKED_ON_RTMUTEX;
> 	BLOCKED_ON_IO;
> } block_reason;

I totally like this and always wanted to have something simlar,
something for all "sleepable" synchronization primitives, lightweight
enough (memory and CPU usage wise) to run on consumer devices.  I was
thinking of a rhashtable where each entry represents "sleepable"
primitive with a "owner" pointer and a list of "blocked on" tasks.
But I'm sure you'll have a better idea.

If I may add a couple of "wishes", can we also add:
- completions (so that things like wait_for_completion and
  synchronize srcu get covered)
- wait on bit (so that things like lock_buffer and so on get covered)

