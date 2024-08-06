Return-Path: <linux-kernel+bounces-277064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB95949BC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747F51F21F37
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C4174ED0;
	Tue,  6 Aug 2024 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQidU8so"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29216EC0B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985356; cv=none; b=h/jRrSoBtog4DjMj4b7pbKA+oI8wsFfJyxpu0caX22ZBngOZKRBVm6vNQdX/KzkF8Awnki4mkzBtorjftgvzofwwy6im6vCZV/qiTxEUYHunJ3/kvJjKFjs0fQoDYXDi9ywcdKNSTxwTveHa4Wu9ccSQnQAoV3xkZqqoKsON1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985356; c=relaxed/simple;
	bh=Kflc9+5zqw92VJhJ+bmkGLCRq6Z7U1zrmWwyRiioHuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9FgPJSvyXpQgweKMIkHKt6fyAsQVHhIwWCexA4jygvAyFiGYhS4LwmQto4fP6m6q9nNmm0ZwUureVp+O5OvFvVr85P4jpO6ePoXNQiCsBBPko9WUiqDHzaQtX5DeE8ZpDBwhXkNtw37e5781dIKR7ygoVx9u8L0LVgMmrCzUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQidU8so; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722985355; x=1754521355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kflc9+5zqw92VJhJ+bmkGLCRq6Z7U1zrmWwyRiioHuI=;
  b=EQidU8sovOi1yIh6+hPIcWE6g8Y90W+k/C4qgvZ/iTYWHjrs83rJcOwe
   7o+BCxfj+/Hxo9kd6GESUhIDwYYxNY6nGLtvh0Plgm6xvJIc0PobOL0E9
   4d8HeEzq+avh3CKluymkgfroAM9SvT+OXhdEd4ReybvCY8cnsKGuO2udb
   PJssER66Bk+9QNXQNacD7MVSGpeYZ/c3txFH1+1tbcuK/fsf0Fi2SfvUi
   fp3lJgZ9k5Ml+nGhZKQnDdPTomyUZGAlgu4Ppe5z41K9UQ0NvtTsX4GVw
   LWR8R4lF1ZhnBKPBNePAnOaNO1NoKMF9TMCpRbd/PoVfG2WNjqkGe1LGr
   Q==;
X-CSE-ConnectionGUID: WyjovkMxRs+6fJ4xLqYRdQ==
X-CSE-MsgGUID: TdxhX1oAT92YEcGAeO+qXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38488230"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38488230"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 16:02:34 -0700
X-CSE-ConnectionGUID: DuGfvrq3SCue8OjUM+uRXg==
X-CSE-MsgGUID: wSUk9GpNTxCKF8CTMif23A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="57350252"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 16:02:33 -0700
Date: Tue, 6 Aug 2024 16:02:31 -0700
From: Andi Kleen <ak@linux.intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: acme@kernel.org, namhyung@kernel.org, irogers@google.com,
	peterz@infradead.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
	eranian@google.com
Subject: Re: [PATCH 7/9] perf annotate: Display the branch counter histogram
Message-ID: <ZrKrh3t_Kasf2gf8@tassilo>
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
 <20240703200356.852727-8-kan.liang@linux.intel.com>
 <Zq1K-YM4JoEQwov1@tassilo>
 <c634b005-c382-48cc-bf54-6f570687d5c0@linux.intel.com>
 <20ba40ec-7e2a-4a0d-b9d3-fe8e1256fbb8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20ba40ec-7e2a-4a0d-b9d3-fe8e1256fbb8@linux.intel.com>

> For the --stdio mode, perf should print out the abbreviation mappings in
> the header. I think the --stdio mode is the one used by other tools to
> parse the result, right? 

It's not just for tools, the humans might also not know, especially
if there are lots of events.

> The previous patch 6 (--stdio mode) does show
> everything in the header.
> 
> Is there a use-case in the TUI mode that has difficulties utilizing the
> shortcut 'B'? If yes, could you please elaborate?

No if B works in tui mode that's fine.


-Andi

