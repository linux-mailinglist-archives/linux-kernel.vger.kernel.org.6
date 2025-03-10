Return-Path: <linux-kernel+bounces-553448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468F6A589D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16F57A4189
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCFA3987D;
	Mon, 10 Mar 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XD9oYYf6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDAB35971
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741568059; cv=none; b=aMb2I7TQrOJRZFb0vuA7wKKi1+o2zDqvXuhDfzHYgOOdkKjoJMhKE2PEYcSf3LsOotMqaYuco75jX5qxH85f0ihFqMhA4FDYGRFo8JzjityRI9w6g9f5LrTCOzelOzprgdC4K2mW27vsc2K0F+20hFwrQ0QNoPxGXDW5v6/2ZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741568059; c=relaxed/simple;
	bh=iSQLpVMsIsF42btYevLSgmgUVjd7EV3WeUzrQzgqFG8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NwPEudDlSLfc4f6xbql89nMWZmZXyuo6/trE2GXmFrbUpsXYxmz7Kpah9ZypuIV88VHk5b2ku+nW2gxxL6BGqNZZb/1PKCKEAwNaXThA+1/3ZTZQaGdmIaluw1lyz1C1djs7dV9p4cwAw0MJko4UHMtxKG18Q52jTcFN2prnPkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XD9oYYf6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2242aca53efso161375ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 17:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741568058; x=1742172858; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5n3y6GQQXHK2s5iDRhzje5ofrtSUT2yyh7T1pq/Mk4=;
        b=XD9oYYf6rL/ejnF4c3xW8chuPnx1adKdwG6Zxp0Emvu48HdQdMGgmtxSVyV2lPb6+h
         gdZkTpdK90U/h6wqKuv+RN5jZRUamL5I+jOPT+VEzE5p/4/xYWOeAUe6M9SMmRstf8pD
         /7WxXeMwBAJ64lwaqewpw8nOwpPWrPUjnfDfWIGULEx1IuDy56LJZKqqXVeGMVdtB8Yy
         KeC6xHnZgmqUPO02/QuYO3F+g98T17r8elEdjSbgfOWwVWN468yA0nVV+NVxNG+NulrW
         e3H9hRtPmGblNEKWhM/nAqoBfw9ZXEHmGg9FyiKEM0n5B7SgPfG8nOPfOZVbbA63gQBY
         CbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741568058; x=1742172858;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5n3y6GQQXHK2s5iDRhzje5ofrtSUT2yyh7T1pq/Mk4=;
        b=W5V/jjMSHOc0deEFBAMRifcJcv23LH76f9WMjY7Od1qm+A4VgOnOW79PwX8jb+A6ud
         FzUM+D5GOklivig2jnGURWs/2LRHKbDMZNfRnKPtdx+9xdkAAc2+UJ6fv4EtDWctimRm
         QSaX9lQ/0LC5I8TwsKDnyT6MN2KDrBaPsE4TDho1iFnTMRt0wrlcANXAhg0uh3KOmyg+
         yzh7dlNYA1irti/k3N2vwK1WWmHg34Y5CN5sX8/RjkE18KFGKoRx78b9uT/fUiRi26/3
         rWHQrGR/ZeJxwz2ltDQKBfyU/o4o2TDiQ6gVRwu02t9eSoYEcBthob3GdFVWOuncQiXl
         UzDg==
X-Forwarded-Encrypted: i=1; AJvYcCWkm81QvAXlcyWWzK1DE799oJA70WvDD/cf5cbyjW5eZtFvyvhz55I2SwgfjDscNg3VcKCayI1MDHJ2m5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWu3vSvG1eybQ0aNKetzl0qwEn4GFu7ZDvKkEuyyqzCesMJpAc
	jfKBW5iRyBp7zcvUxC3/HgYHa8aLmCg4Hrq6WEHYkBADF5gWPZDFaLCit5EG9Q==
X-Gm-Gg: ASbGncsVAhjPQG+pruypNBf5saVTgsscsVT9ygKtXmlYXhhGrMKjWmqbTDBosE+HfGm
	vyss7UoeO8Bj8AYtulOM2K3/KCp+7E7cm5rYhnzrL8x7yAOTuhYSSBkHedbVHJLmKVP4iTLhafF
	OdJd+2geppSNdcCaQ3L3YvI4R8/dFib1HfT5r36N1sXLp12kMQ48zVdoAqmckdcdpODu9l8MHc0
	+4Wj4rAaICTyEd6UlKAqemcGxhVI73Dm5A05BmWxrcy276YPMO6038pXw51d2vI03V3/0e6YeJX
	I1onGbdZHz2+rh+jmTt0pq0J9+TRRMue78IcR634DLtrdp0WqLXFMQ3IP6Riw5+XJUp1yGcUQ/e
	3uo29bizeEz9diDR6Q4pfhYaf7dsnoP1D+PSzB38=
X-Google-Smtp-Source: AGHT+IFro0CpV48daho0xd6hGe6kreSPTXBpv7NkAJm8JjpVMpboHTVNKokQNgcCzxNaMDN6kqzbFw==
X-Received: by 2002:a17:902:e5c8:b0:21f:3e29:9cd4 with SMTP id d9443c01a7336-225416ae73cmr2795565ad.20.1741568057350;
        Sun, 09 Mar 2025 17:54:17 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:ee55:e440:a203:909f] ([2a00:79e0:2eb0:8:ee55:e440:a203:909f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddfc7sm65423905ad.22.2025.03.09.17.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:54:16 -0700 (PDT)
Date: Sun, 9 Mar 2025 17:54:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Martin Liu <liumartin@google.com>
cc: Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] mm/page_alloc: Add trace event for totalreserve_pages
 calculation
In-Reply-To: <20250308034606.2036033-4-liumartin@google.com>
Message-ID: <273ca5ee-c01b-83d3-6bbd-21ec4401e78b@google.com>
References: <20250308034606.2036033-1-liumartin@google.com> <20250308034606.2036033-4-liumartin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 8 Mar 2025, Martin Liu wrote:

> This commit introduces a new trace event,
> `mm_calculate_totalreserve_pages`, which reports the new reserve value
> at the exact time when it takes effect.
> 
> The `totalreserve_pages` value represents the total amount of memory
> reserved across all zones and nodes in the system. This reserved memory
> is crucial for ensuring that critical kernel operations have access to
> sufficient memory, even under memory pressure.
> 
> By tracing the `totalreserve_pages` value, developers can gain insights
> that how the total reserved memory changes over time.
> 
> Signed-off-by: Martin Liu <liumartin@google.com>

Acked-by: David Rientjes <rientjes@google.com>

