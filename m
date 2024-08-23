Return-Path: <linux-kernel+bounces-299377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B7095D3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8DE284FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A36318C334;
	Fri, 23 Aug 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUEBoGCm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091A189B93
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432020; cv=none; b=heTfda6plgs0l2ziaf73gXTHs2MjEmFn5aP8Lw4lTpvsQK1lyPy19gvYz6QgU1gzO5QKRveAFUBbhmxyOSRrN88FMmXVWU4MPkrmvPJIL5j9hiXET/4U1puRQFH9T9fNqP4eDNW7NQqLP8bS2y5zoWYkqTx4q3EjY9rLUcdqe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432020; c=relaxed/simple;
	bh=aDkpA7sHahzJz4O9pRbiLPc1/ZZRyODcWl1oN47eeaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ8hyRErfU21kG5NIjs+FJpzVpYInNd9ffZeKu1idABYtZWUlhU6kYFL+Uh2nNnjywFhdJAYGDIX4nFV+G54Slh6J28r+nDwe75aVCymMJ8jjRQpi5wtn2+95duM6M2fZnDWXaRLuMl+U8eiSXDBEgwXFl1Fbw5DP8r26UH9w1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUEBoGCm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201fed75b38so3295ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724432018; x=1725036818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9vuB8hri5qT5waMZfq5Z57S5cjCFURsSroxNeC6uFQ=;
        b=jUEBoGCmo1ATKxg8bLoiaa9qbp/CZBSmHZfB0zk0ryqlEe46ZuChP94ToJwrnnVtXQ
         m9Ho8NSWnaqICh7BqxFdK0x1pSk2fKb8kzV/4Mq+ZPbSrcQuvu2d4VqyFKhxrDVAQ3CM
         4vrH+ZAWzPyLmMJB8dO88lswBIhi5E0Z4PBZgF6ycLTkx9T+q3ZG1lc2crqt7cPDaMF8
         TysftK+/xEH7EuPdr+44GrHLVLYSzsPTBfg/6T4on0BowVidgFukATNv4mesY2J/c+ra
         kNlyCwhvW7/teQNRi27Aw2JPlBtwTqcCuysoSbnwcdkXidLkyi+nQTj3bpW3hw/BO9Uk
         JNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432018; x=1725036818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9vuB8hri5qT5waMZfq5Z57S5cjCFURsSroxNeC6uFQ=;
        b=MYe3//p2fo11RLGbkPbEYjjk8lh0kEUqBh6U0ctqF+cwvvJJQ8/Q0lriMjpYx9z2yT
         f7Wj6PCHwYi2Im1XWWW73wYM13bfIW9xbLkgz2tgKDboUktOgQBbEC+Yw/4MtwCAQzrD
         ph+bAda9PR8mfpKGbr9xB674Uv5wB7VrsV5PgMxrFYZaowK0tMnBwXNe2bupgT9FaFcb
         QfVuK/mPaQouLmwexRxcugQc5lwCyOFpobn/CZQGqNb7XbO5gYfJYZeDu8W4NkW8kvZT
         sUM3nAubHf+HTQ9NH4/czrumy9B7Ngj5oGiUYUXWtWpCzYtDcou3IrA5YBJEhafxkoPz
         m5AA==
X-Gm-Message-State: AOJu0Yzoensa+XJ8tuyMpy6fElPLRwrtYxoLYDUIzlxFdU5kQNrc7lKE
	tsukcyMaJGnxU1ufIIK1+k6SKZAzQDd0xftV0dYE/aR6O11QLaEpWIZsrphI2Q==
X-Google-Smtp-Source: AGHT+IFANpB3IAM/PQyhB7gp4T27UHfGZDu+u0nU1K65J/w+iVbYyN/ffreaJCEYq84wnORw5ooKPQ==
X-Received: by 2002:a17:902:e84f:b0:201:cdd1:b65d with SMTP id d9443c01a7336-2039a253467mr3509205ad.28.1724432015199;
        Fri, 23 Aug 2024 09:53:35 -0700 (PDT)
Received: from google.com (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b2048fsm4349250a91.54.2024.08.23.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:53:34 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:53:29 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Kris Van Hees <kris.van.hees@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Nick Alcock <nick.alcock@oracle.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [PATCH v8 2/4] kbuild: generate offset range data for builtin
 modules
Message-ID: <20240823165329.GA3911831@google.com>
References: <20240821040700.1919317-1-kris.van.hees@oracle.com>
 <20240822181942.2626536-1-kris.van.hees@oracle.com>
 <20240822181942.2626536-3-kris.van.hees@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822181942.2626536-3-kris.van.hees@oracle.com>

Hi Kris,

On Thu, Aug 22, 2024 at 02:19:39PM -0400, Kris Van Hees wrote:
> diff --git a/scripts/generate_builtin_ranges.awk b/scripts/generate_builtin_ranges.awk
> new file mode 100755
> index 000000000000..68df05fd3036
> --- /dev/null
> +++ b/scripts/generate_builtin_ranges.awk
> @@ -0,0 +1,505 @@
> +#!/usr/bin/gawk -f
> +# SPDX-License-Identifier: GPL-2.0
> +# generate_builtin_ranges.awk: Generate address range data for builtin modules
> +# Written by Kris Van Hees <kris.van.hees@oracle.com>
> +#
> +# Usage: generate_builtin_ranges.awk modules.builtin vmlinux.map \
> +#		vmlinux.o.map > modules.builtin.ranges
> +#
> +
> +# Return the module name(s) (if any) associated with the given object.
> +#
> +# If we have seen this object before, return information from the cache.
> +# Otherwise, retrieve it from the corresponding .cmd file.
> +#
> +function get_module_info(fn, mod, obj, s) {
> +	if (fn in omod)
> +		return omod[fn];
> +
> +	if (match(fn, /\/[^/]+$/) == 0)
> +		return "";
> +
> +	obj = fn;
> +	mod = "";
> +	fn = substr(fn, 1, RSTART) "." substr(fn, RSTART + 1) ".cmd";
> +	if (getline s <fn == 1) {
> +		if (match(s, /DKBUILD_MODFILE=['"]+[^'"]+/) > 0) {
> +			mod = substr(s, RSTART + 16, RLENGTH - 16);
> +			gsub(/['"]/, "", mod);
> +		}
> +	}

This doesn't work with built-in Rust modules because there's no
-DKBUILD_MODFILE flag passed to the compiler. The .cmd files do have
RUST_MODFILE set though, so presumably you could match that too?

Sami

