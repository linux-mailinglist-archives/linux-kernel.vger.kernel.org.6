Return-Path: <linux-kernel+bounces-430755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F185C9E3577
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BEEB23A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DEB19046E;
	Wed,  4 Dec 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RhEPhAr3"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31E192B84
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300493; cv=none; b=NxPRD+n8KpWi4yz6xuo6SSl21p67q8U2FQUBCff2vq0y+ZShp7l7TYzSOp+2eUog9OVg9jA3U2Z0RtTNKXAumm7gewFYt+Pog2/FFXiPpiQZHv0+uSKxKgWZGMgCNcqIwv3fKfAC3OZ/0r9xsPOOY9uD2UgNAWa1hD8C3toyHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300493; c=relaxed/simple;
	bh=INY9mpqFaulyLsWmDzV/MGEDnFkmp60CsqzTyDC4cGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+P0W3FhaUuSxsxK74eHsApBwO6AayHjGRHz6pezTb+EKKZDUo1sxG3Yky7JX8RWpRqrdN3YPXaRNdP+sxGl2D2ErS98PLWi7rnTLpkV1q95XBxz+IXeqZqMBcv8ggH/dN9kW+8oYKUmc7THpi/NcqkVOfcxCWzm0zmgjr4faww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RhEPhAr3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215513ea198so4753845ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733300491; x=1733905291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kk1sTvFp0qvnbFsozJPsxYQlZYVQ3TP1Z7kQcIXY9c=;
        b=RhEPhAr3lH9gBVU95tWbX/M2Bzr3qno5vsGlxa9Q/k7bnf1Ufq+BxGE1OBAx9Imy47
         61DQL4oWrIIzSsPFL/zHEz+Z43Y6caUOk07QM3SNJcc3HU0t1dgmVIZQqV3SKbPLAH5n
         JC94keM1cscktR6a7p1jeW3z4T6SUoAfoz4AJk8Aei8r+cyPnnKSkrAF+3NSp4syYJaB
         HOA29aBUPeHNOw9OmdqI0+GhhW8/FzmGwh/YnogsXbBLPUxSovpe0xNqpgZ6dr7ykQBq
         u565L/qdqDtsg/ISMtJpu3lqnY3LxbTPM+2jUPfU/kn+N0wVdZtRQoYKo5fpPW/HTqT8
         zfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300491; x=1733905291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kk1sTvFp0qvnbFsozJPsxYQlZYVQ3TP1Z7kQcIXY9c=;
        b=fYuTsK878QNYqjs+7ot78rBaI1Df4esA6VWMrfRpWJM7mhjbkfrNG66+3zl4x3VAbZ
         XNNj4RTfkatOwpaGWJkE13uAN9ldL2GiioZT5GAjphwWZlL+Vt8boVJDeYU+RW+dh84p
         Q5OPk4NS3aS8L5BeBcLylSgamrF4kPp7Tgs6A5AKy/++LhGs88KDLOqIc5ikehvLqPY/
         BTEoZbhBo45HHByD4HEjbBZynNeHiqzsTweQqCp9OpyfHuAk/EEWSLzZpsoNKRDHjlQR
         47sMfAJa6L7AX/y/SXgH/6YUfF+DrZCb9icCr+eWt+Pj+GFUp5Vto54iKXS+ZdIPt5Ha
         AOeg==
X-Forwarded-Encrypted: i=1; AJvYcCVQBb2pDxYlBUiJqvIjcmbp9VLK/n4CWUpldTEJXFf9G2AOpxARq1rVW8sgGQr1iw/4qysBtk5TUp3BpGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJ5Nzc6oC//slNtQeqDMGiiVnP9wy/FNq2tmJujoFa96LFNue
	lNjXIc2wu0YoQ+OWYlYiz3G3tYl9LX8QJyYCCNjUswbQ6Q+tHgwp5zX++n2ReJHraQsNH5bK9bQ
	i
X-Gm-Gg: ASbGncvPdIBvkjjSHySNE/cnSdgaIZFlNNfVZhWGMZ+ou1Mi5iBNi6hd7ouIE1rEBRP
	dKwZVRCCZRleMnY7Z6PKggvIZEknZokana7qIklnYlYqlGrhMJ9zH3ayChvnSP+HA+eV81uMijS
	jqeDNmG/EZm/YugcaFwrw3prK/J9J23oUsfVicNJkYR17SFrPrA8vtWRlAK6cFbEIWSqe1iV+uM
	GJUkpRZwI4b9vrwYsdtFEbDu1R8pzK2obSfZRLSovZlhpLtUn4bVqoAWp7FOCI=
X-Google-Smtp-Source: AGHT+IHauJW3oHSpYN/fZyF2uIkgp9nqj3VGAEVSKprGisc+iDmv5O+n3P6YIq2EjN0jwGqKndR22Q==
X-Received: by 2002:a17:902:f64d:b0:215:8fd3:d1b6 with SMTP id d9443c01a7336-215be6fca4fmr91701425ad.23.1733300491208;
        Wed, 04 Dec 2024 00:21:31 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21548e144b0sm84821105ad.68.2024.12.04.00.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:21:30 -0800 (PST)
Message-ID: <528036f5-cb79-4a7f-9421-5cfa17a849b7@bytedance.com>
Date: Wed, 4 Dec 2024 16:21:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 00/12] perf record: Add event action support
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 james.clark@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <Z0jPPRA8JXSrwyaC@x1>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <Z0jPPRA8JXSrwyaC@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 11/29/24 04:14, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 28, 2024 at 09:35:41PM +0800, Yang Jihong wrote:
>> In perf-record, when an event is triggered, default behavior is to
>> save sample data to perf.data. Sometimes, we may just want to do
>> some lightweight actions, such as printing a log.
> 
>> Based on this requirement, add the --action option to the event to
>> specify the behavior when the event occurs.
> 
> 'perf record' is centered on saving data to disk without processing
> events, while it has sideband events for some needs, like processing BPF
> related events (PERF_RECORD_BPF_EVENT to catch PERF_BPF_EVENT_PROG_LOAD
> and UNLOAD), doing things in a "live" way as your patchkit does seems
> more appropriate to do in 'perf trace' :-)

Ok, we can put it in "perf trace".

> 
> I'll take a look at the rest of the patch series.

Thanks for reviewing this patchset. Currently, this patchset only 
implements a print() call and only supports attaching to tracepoints. 
The functionality is relatively simple.

Eventually, we can use bpf prog to allow users to customize the sampled 
data to and the processing of the data.

we can continue to expand the functionality (for example, attaching to 
kprobe events, printing the parameters and return values ​​of the target 
function)


Thanks,
Yang

