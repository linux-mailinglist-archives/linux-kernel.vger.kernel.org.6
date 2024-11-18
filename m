Return-Path: <linux-kernel+bounces-412664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D69D0C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB450283210
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E39192B94;
	Mon, 18 Nov 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ST7l5n1O"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919A193081
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923492; cv=none; b=A9p9oAqIOAF4K1OsDGZHni1PXrVSo1FCIwfOSIY2ReRevH9Ws/WcQro0r0cn01EVYjy+xN4FZghnzx3b6LWkTWmtBPOQynvx/rnOFhbJ7+dcNQQ/3iJx4Icd9VRWQEL705TyAtejKZnJQPKRG0FUexDq3LUq05tSRGnCONWbGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923492; c=relaxed/simple;
	bh=BHFAH68eYvi3PdLtlyTXk9KTdXAKA9Zj/AnZkMlrDvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKkMMXHIPMVmygmJj4jtTBqE8shYf3txEz73MjgFpiwYaAR1qx3eVXAvXidrRqd2Qbsl6CbI/ZFQ++qqVr3yQzUioLjWkcasYjJyxoSsEi3mWj83Up5CwSqYOq6SJUhC/Im4Mdjn5b4qKXSolheIPbkKVV+UzMJOKDoPybpnaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ST7l5n1O; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f2b95775so1604918e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731923489; x=1732528289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9GTB33TPyEs/YX3y0tXNN3wmTVS6LNkgjt3Ay0YqbHU=;
        b=ST7l5n1O694Da8p27g+hEh9OGSWJMpbH+FpmGg+Th1p0TEv3wppApbJelzuOgA+bzK
         F0ihqdBFEEuGHDgeBaYAGWx479UydCbHOvfJtSDd59UfhMG2cyBxVzwM8OvvyuEqiM3I
         2ucchR0P63IV/yxaTw/+0yVJOY5JuDsQ9ka+iUNa98u5z4if/l1ZGnuCVLc84XyykTwi
         0ERQM0SP/Vc+FkyPE8xOXGwiA2aWdyw+M0NpLoLKJhmOKwLsRjjxG41rKcQxm9vGF3jI
         uuo1bQsvmz5Et3TkLuNTZg+wf24xZ+wq/nBfpdGreSQfe9+BGaoCdrC06jVIfTHDWT1z
         /Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731923489; x=1732528289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GTB33TPyEs/YX3y0tXNN3wmTVS6LNkgjt3Ay0YqbHU=;
        b=ACRV9n2g1HmR/uqEZzWnmSn3pfhl1pjGhG9DcKWPzcOXVQrlGjmGbtfI8Hi++q+YuD
         YIzdykJYTslaAK8QzXFo9ltwzJnzLVfcopGtzvlqLhsHCbWfwmkaiZIX3H9b5j3hL1VZ
         gU/gIy4S+aGcIaO/bja68Klt0j8ONNJKY7M0Dlh9xIi7vUS/7ZjQ80Ugg2RjMHNyMjWN
         phFnXuiL+qtYwO15uW2f074Jwk61LA2lefMkDXu0DsFXwGsmSQ2n48Egk0jXuullYSXU
         Vq60E6Vlh8K+jbL3NpLhbfa4bPyttIcb0Je9n94qU1B5pP87dtPOIRX+nl9oEqoUc/oQ
         qOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZsdSlQBT0LcUQSG0bNiJbtzie6pJSAkIEdkU2R7+6NMDr+4rybiEo9HUJT5y9/OfcVwrtVo9XMI+0IxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1Bo6fkKYCdZUG2N/mxS/kqX3L1NWcA8jDZ3oDoiM/mTkDBie
	T31AcbRQQ3+qObsIycE/g7l+8NrMp8ulfAg+QazpuhZNtLXtHSE6fCkCJEmhbNI=
X-Google-Smtp-Source: AGHT+IFAGUjndOgOu4hfcbEbyo+d40bHeTZfpu3+OXzaO4JvBg5zuhrDkKC8GbHnOfHVv82NwlCBjA==
X-Received: by 2002:a05:6512:2248:b0:530:ab68:25c5 with SMTP id 2adb3069b0e04-53dab294790mr6474092e87.2.1731923488726;
        Mon, 18 Nov 2024 01:51:28 -0800 (PST)
Received: from localhost (109-81-88-120.rct.o2.cz. [109.81.88.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e08af80sm520753166b.205.2024.11.18.01.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:51:28 -0800 (PST)
Date: Mon, 18 Nov 2024 10:51:27 +0100
From: Michal Hocko <mhocko@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Nysal Jan K.A." <nysal@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev@lists.ozlabs.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] sched/membarrier: Fix redundant load of
 membarrier_state
Message-ID: <ZzsOH7nO7okC9f4O@tiehlicka>
References: <20241007053936.833392-1-nysal@linux.ibm.com>
 <20241029055133.121418-1-nysal@linux.ibm.com>
 <ZzsDEvJn-vauz9gE@tiehlicka>
 <20241118092517.GE39245@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118092517.GE39245@noisy.programming.kicks-ass.net>

On Mon 18-11-24 10:25:17, Peter Zijlstra wrote:
> On Mon, Nov 18, 2024 at 10:04:18AM +0100, Michal Hocko wrote:
> > I do not see this patch staged in any tree (e.g. linux-next). Is this on
> > its way to be merged?
> 
> I only now found it -- it doesn't look super urgent. I'll get it into a
> git tree after -rc1.

Thanks!

-- 
Michal Hocko
SUSE Labs

