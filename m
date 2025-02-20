Return-Path: <linux-kernel+bounces-522924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C211A3D024
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63049189AC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CE517A2E2;
	Thu, 20 Feb 2025 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DRmyN/G3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05285223
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023182; cv=none; b=ZHG3ThgOTisvUiBPrXEz/XpUQiUKX1cqwarDi/3Vh9KZpdRv2wWSorMyPOrexLX8sAPRQq+Cfdh8J8VvzLbzw0lDZM0whFY/NCV9VeVkPJJ2AXyLLIkjdJCrdrcWYU/LeENoD2amBy5COQYL11kYAk60G2uuxercJDxajmi1rG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023182; c=relaxed/simple;
	bh=v61AFjpDXcyTkVnA2iQK+5cFf069FOB2MLAEQBuOmOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9/ESAuA8DTjY8Ij/QjxdeeGL7Y+NGHD+aQykMlg8LkdvFsF1sieh5T6LK1SZkMtr6+xEFnDF3gIRi8ZWWvrfYUkQNocXY5b8cxkpZD4tWv4XjPrCdUl//i/nlWF97eeHeypKlUq0/M+HnpjWoXX7ey1Fx8Pyw2mmHkvn4PAcRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DRmyN/G3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22128b7d587so7437075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740023180; x=1740627980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2N6Vo3BjC8cjbedrup5kAjr+iXGaEHlGRCNSZOiJaiU=;
        b=DRmyN/G3XBRBtGVF2AGH4I0LRIQRrn8lCLG8QLNNxk/ZXcOodYPMkKxMo5f9HgAWNz
         2rrQclxkCCE2pLLjbwK4QIAiWhfizUJ9mmYCdMiy7Bpq2gKr/K0PbXYrtsFXteP4QtiG
         92FsvoHYQx9QdZiTU4vTcX9pqJRUfquN9T7n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740023180; x=1740627980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2N6Vo3BjC8cjbedrup5kAjr+iXGaEHlGRCNSZOiJaiU=;
        b=FauhaibF1G+RQpNBryQFb+5AF0/dZVYACBc54pytqTwnBLxDsRRmAIRNgFL3ue7Rz6
         WXvocJ7uIoZpmfvZB18dI/b0YrB962A1AAyiGBLWoRWiptJKaPT92S51F4w6OyCgoN3i
         nxg0Utu9PV8aGLtbUJ3R2b3KodtZZv2JnxJwFUQ/Z5PqhlbNoYu4KGxUf0dg8GEvGwQf
         FymVxr/f3o5MmkoeQI39rifadrbfsVZeVWiOhoUcMufnYFThpoUtQtsNGUOx/sO+C1eb
         qMDCOLhz7eDngeHtszQVJmuyGzw8RrNqNEuSj/gOe2VI6ZRF5m9N04FFp5bhSNsezTbu
         Z+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/9VABO858Du7Fhey5Revl42fv8zmEOp50TDze1zz9T4dDz74Nifftc8S2ZsOCmv+hIx6IUURNk8IV7Og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznw0Yej3EsUAyYeFsT4KYBV2RKyzhdz8IIDTOywfgYYFyxI7hU
	awOGQ4DWy6fiDPpkHZUD0ZAvappel8nA0LqHULuxsx/esk5StTW1HulaByONBA==
X-Gm-Gg: ASbGnctY8nrYDa7EnMlB6hs5vdcKsVYO1nqHB+IMRJS6PDgRCOJPOwqbkmdWdG/rkG4
	sVY3yO+gN/Dvtlc29YTZUKg4rGVDt+IySFPXvf5Lqqq2GGvOZm9/PJ3TAqRWO9FMrL+P4UOl7Ow
	ZgAbtf+yOBTkQa10cf0XLdzLXu02+NlFfTJMlWXvuvmANKiyWvxhFsshoW7OChHrsQDICxybM1N
	yQAI1pSzJFK06wW1bpSQMnmmpsXMhLHE9N+yOR0L1Rrw504ZqqhYVrk6KuU3uFCY3MrhQmEZtMo
	NTcJiLQb37Pp6Ma4YxM=
X-Google-Smtp-Source: AGHT+IHB+hn/L0fEfNlGb2/XE7SC5QLRRitRuRyyFIWkWyZLBCzgNJdSIKXKZViGkkxBYujGouPDmg==
X-Received: by 2002:a17:902:eb83:b0:220:d078:eb28 with SMTP id d9443c01a7336-221711d1730mr102109175ad.48.1740023180102;
        Wed, 19 Feb 2025 19:46:20 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:9c92:f424:750b:8e42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d6fa9b75sm110397885ad.199.2025.02.19.19.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 19:46:19 -0800 (PST)
Date: Thu, 20 Feb 2025 12:46:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Waiman Long <llong@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Lance Yang <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Yongliang Gao <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org, 
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
 <20250220-112040-neomutt-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-112040-neomutt-senozhatsky@chromium.org>

On (25/02/20 11:45), Sergey Senozhatsky wrote:
> If I may add a couple of "wishes", can we also add:
> 
> - completions

Actually, no, this doesn't make sense, sorry for the noise.


