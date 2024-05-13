Return-Path: <linux-kernel+bounces-177945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F38C468D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4501281106
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C42C190;
	Mon, 13 May 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCZ4omha"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B22575B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623009; cv=none; b=avL8Ncujm5TmKShffNtelnfCVzsBzJ38eL63Rdj5qdbPrHz5W+xucG4JH6ju1OuX0DY5rZ/SmbrHnFdBRW5YP7BEyPPbKPChkEoB6DuRsdmn8H5+mGmUZ/Ct8S1s6HjBH7rTnawA4gyjMTlD5BVMlbnt4HA/kt1lOb39Rwjgj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623009; c=relaxed/simple;
	bh=esfXbRwG7qnZ3qAY6JPB8814C04V6QeKv2dosLof97U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmGumX6ujkcWhTu9WKx5K//r6Z3BJc208CtUKvJIwSIBCh/JdCWDP4qxz4TwjobKmqsyb3HL5tU+LXXZALRAMvE0fnWo94gTHc/uEG5Fk/Yu5oRtvR7WjAH9JNfzpqjOyFsNOzTjojMhEH10w2SjccxdFhIt3wI5KmfiOww4xUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCZ4omha; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36c6dd950d8so376985ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715623007; x=1716227807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+nmjk1LDFBE4TkVCYE04wzt6Q9H4iHrzCOkGg1jBPM=;
        b=aCZ4omha5JLJqTgq1JzgLJOWv6S+UXufMgIS27HbcJ999/l8OjKM+zEYtPoHTbFQKU
         TaWoyR3CrJEmts3cGYTzLnixBjQeehhRteUnmhAXZh9eI543bbp1+o6lXiHw2hG59jOj
         t/3l/K5Goeg4exvkUCO2sb1T/YFIY5LaaEdiZnaGMnzU9uIMSMFYbfAln7SmqzVrQlFx
         5jL4mHl9OHFYgUmcJlSEKfhe6nEhm42Lo78dLuioeZywtDcqphzRQ+HBWdYwgHEc+g/Q
         dwx8l8dxiCzm8d2xZ+OIhhfxVP+1b+NxB4RSHkCcLT72BJEGj+UB3Y40MbAitt008CNA
         1dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715623007; x=1716227807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+nmjk1LDFBE4TkVCYE04wzt6Q9H4iHrzCOkGg1jBPM=;
        b=tl2nQfly5uXNCnB7ulVnVl0+HfrYj/Wh8KSjAvceArFsHIWX5HSEUxvUdfLMqxA4lt
         1V0Vj9Gf8dbE7RBI8BdKDa8isnK5U6WfNPZcMwIGR8+uYaj9EEvO3PJAdBGGyeYRp8gb
         RGA+fUYTd7jjaR1A0rLVg15fCkeuo9c1vK7XQ+fGPmdjMxy4B5im4lWoihrBCv3HGzEM
         CNIdpBTFRuJb8cgr8wajJii2YqDvvn24hzzis4uZeOGtTUBNbvDHR2JDl6r/ngWW0igL
         Hk1tybPjjLmSAGn7p8jqABUY73Ck8XljM3axsOFAI8zj3Ryr0uvXC2+ZKeLEUnGQogc7
         IWPg==
X-Forwarded-Encrypted: i=1; AJvYcCWInhFZvOTS/uoEyU2O77f/HPAXqV6kHRFBpGLEU8WxdYCjbJ/Yk2q6U1cIOJa9KYkcF4IKzZLE/Rl/iNk1jSf7TDQ28977zQ94YN3Z
X-Gm-Message-State: AOJu0YwXmVa2flaE/EA+B/RZXSJii7JlMtT0mbVO4b+MVA5aDHPOzjeh
	ceUXOyA9Pbn7LC/ThG8re2jFqLM/2LaAEakeRrAcAgXsH9C5JwQGof8TcCXM2clkIHHW8SlgW3I
	9L0hRBWax2uBt66MeGlyJzOqzTeMBCkPhh6oQ
X-Google-Smtp-Source: AGHT+IHQqf1Asv5Fry6t+LsqPl/T7ZSHAG6ZEvWvp2yUvjQx3nMQtPqsrIwcnCAZGf+XZ8lCBBfjus9anmnZBNnigZo=
X-Received: by 2002:a05:6e02:1a8f:b0:36c:2c6b:ba8c with SMTP id
 e9e14a558f8ab-36cccab3700mr4390215ab.17.1715623006561; Mon, 13 May 2024
 10:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513074910.1660373-1-yangjihong@bytedance.com>
In-Reply-To: <20240513074910.1660373-1-yangjihong@bytedance.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 10:56:35 -0700
Message-ID: <CAP-5=fW0EE+Wix_Z2o2DxTcOzm89hgsujt9e+MZi9GpRn1OuPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf build: Specify libtraceevent dir to rpath for
 asan/msan build on 64-bit
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:49=E2=80=AFAM Yang Jihong <yangjihong@bytedance.=
com> wrote:
>
> This patchset is for asan build issues. For detailed discussion, see:
> https://lore.kernel.org/all/CAP-5=3DfXJAu8OO_Gaw45Hx3uq6N8VQBNFhqcUy3Zm2v=
KT-TDSOQ@mail.gmail.com/
> https://lore.kernel.org/all/CAP-5=3DfXYH4JnfQH98vPRttViBfYAWGA-aoGXO7q+R_=
Wt8AqFSw@mail.gmail.com/
>
> Yang Jihong (2):
>   perf build: Specify libtraceevent dir to rpath for asan/msan build
>   perf build: Add libtraceevent lib64 to -L directory & rpath on 64-bit

Great, thanks!
Tested-by: Ian Rogers <irogers@google.com>

>  tools/perf/Makefile.config | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> --
> 2.25.1
>

