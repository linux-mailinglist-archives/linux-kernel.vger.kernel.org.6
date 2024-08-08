Return-Path: <linux-kernel+bounces-279499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA4C94BE15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E27B28A6B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA9118CBFE;
	Thu,  8 Aug 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVdRY6C/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983A18CBEE
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121931; cv=none; b=NKIB8varUjwlXuu8d9U2bV74pMNQ9qq8+2EN2nggr1DFsWlqMfSgCY45EvHsDxrYpn6rtzr4S82X6DDDrPF4MQ8hAfSp8fOq31FahFWhr/1zHpRKTnB9XMAf91dYrNf4kkQg1I0fTqjRp5k6q7ZBtXAKSIAVwGr6C+kHN6GyXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121931; c=relaxed/simple;
	bh=dIM5pe6dJVWepwtYqZwe6PPCHnYS8ixi+Xg2xmV2vWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k7aUR4KvJs3iXM8QeoitBAIGWblPwxEGEAMI2JOu+ZqHsjwMemlRV1PTX3Z9b/WsC5VHesuwxdr5hUJXHRONAwNNzmkaQqjyq66PaQrFJI7C6zFYayuYOq+FozEWkrCgjmS5aW3STurNb61flCvk/W5ckrcNztQWx9UrwBiYwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVdRY6C/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723121930; x=1754657930;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dIM5pe6dJVWepwtYqZwe6PPCHnYS8ixi+Xg2xmV2vWE=;
  b=IVdRY6C/oHYSD155SoCTr19zAwTrni5bkvIHkLCQ6Rh2MvNlkllTQtsx
   p/y5Xcw/9e/YCKOOCWhcBzq+ZtqugaW00gfYqejsU/4Pegen5pjDjwIkS
   RbBGjXHeg1ubJ4SHbTeBUBgKV+9+P+pL/PxFmUqNRTuJp0LAMy9Moc6WY
   mNK5eEU0WJTu5v0ZTJEPvuhc1O//WZpeZFUOWJqadNP+nVCah1TpwD6pa
   PxmzjFGXgFeOwHx1u7GDSuK7QqIV5GSRj2AnDTx6nUF3km69vboi9wcul
   zkFt9yqKob0MHSFGK6GdAZivD2tfj6AhmuJT6FRCS6XigV7dVkuQ9wxmJ
   A==;
X-CSE-ConnectionGUID: EygwaOTQRvu19gorXUPLig==
X-CSE-MsgGUID: MewLXnnpSOyACZgRnafcyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21397023"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21397023"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:58:50 -0700
X-CSE-ConnectionGUID: o/0DktMBTpGFNfilrohghg==
X-CSE-MsgGUID: 8SAfMfDZTniD2qCKQDZlRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57131628"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.150.149])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:58:45 -0700
Message-ID: <1059261e-9d1c-472e-a211-f83c313eb5c2@intel.com>
Date: Thu, 8 Aug 2024 15:58:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] perf auxtrace: Refactor
 auxtrace__evsel_is_auxtrace()
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240806204130.720977-1-leo.yan@arm.com>
 <20240806204130.720977-4-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240806204130.720977-4-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/08/24 23:41, Leo Yan wrote:
> The auxtrace__evsel_is_auxtrace() function invokes the callback
> .evsel_is_auxtrace() to check if an event is an AUX trace. In the
> low-level code, every AUX trace module provides its callback to
> compare the PMU type.
> 
> This commit refactors auxtrace__evsel_is_auxtrace() by simply
> calling evsel__is_aux_event() rather than using the callback function.
> As a result, the callback .evsel_is_auxtrace() is no longer needed, so
> the definition and implementations are removed.

evsel__is_aux_event() assumes it is on the target machine e.g.
being called from perf record.  It indirectly reads from sysfs
to find PMUs, which will not necessarily be the same a different
machine.

For example, what happens if a perf data file from one arch is
being processed on a machine from another arch.


