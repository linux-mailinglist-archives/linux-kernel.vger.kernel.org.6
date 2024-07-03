Return-Path: <linux-kernel+bounces-238702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7B924E06
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1A81C248E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3303D9460;
	Wed,  3 Jul 2024 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="mN/2PAQA"
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC706646
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719975623; cv=none; b=PzJmAIH0NJe4j4wvMAHM2gNf6k4WLH2zrkK0k7tFy8EhQRQlOQLJ3L2R0h7Ua5q1oGsLs2zG7bapDz8K8F5Y3iZOvWprpEHANuH6y2KN976KOIFLUqVt+y99Jj1rlOoBxalG+EzRAMtFNpuOTRYPEqwbLBssd8JxinYqrAPaE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719975623; c=relaxed/simple;
	bh=iCFIOhW5lnjgtFKwkDYm6xpY/Y7Mj41SNlHO4W4X41w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTyKo3aMp0pObYej/8ZXzirWmaEiz2Bh5Y91l023CQwKAr3KPgofzmmApTEgRxYygoie8Y936teTsZNHh+jAPaZuXKAM70svb3WdM7EBu0e01i1VPA2r3BbGubqYsI6lLyyGZiP1bSO2q9sfFgX18XyPNxg3YumEnSLi2xrtgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=mN/2PAQA; arc=none smtp.client-ip=140.205.0.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719975611; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=P+C0daa435INGy0pEFmfOh6lcoVPvbnkFjVy2wpj8xY=;
	b=mN/2PAQAHZPZVvXdvRQvszCCIjg0wIoT6quS01lvwtGk0SQAK1cwfJ9Prl2YeemU8xmqsZ0wVSYfMlqW7Hqz8q6fkr8zFcxUf+D4F1IhU95o0IQQJI5kZjgp/J0VcqgCEHhttdaRVaHZ1Ipkk6NOcahIjQWrMcNPyQ53dxGCNuU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070021158;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.YFq31XI_1719974678;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.YFq31XI_1719974678)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 10:44:38 +0800
Date: Wed, 03 Jul 2024 10:44:38 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: Xin Li <xin@zytor.com>
Cc:  <linux-kernel@vger.kernel.org>,
  "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
  "Thomas Gleixner" <tglx@linutronix.de>,
  "Ingo Molnar" <mingo@redhat.com>,
  "Borislav Petkov" <bp@alien8.de>,
  "Dave Hansen" <dave.hansen@linux.intel.com>,
   <x86@kernel.org>,
  "H. Peter Anvin" <hpa@zytor.com>,
  "Xin Li" <xin3.li@intel.com>,
  "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
  "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
  "Paolo Bonzini" <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] x86/fred: Always install system interrupt handler
 into IDT
Message-ID: <20240703024438.GA76553@k08j02272.eu95sqa>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
 <2f632ef59c8c9cc27c3702bc2d286496ed298d65.1718972598.git.houwenlong.hwl@antgroup.com>
 <dca1635b-1e08-4dbb-9dbb-335cbdcf9b9d@zytor.com>
 <20240628093656.GA103025@k08j02272.eu95sqa>
 <c0ec7712-c538-4cd1-ada2-d0120c662ce8@zytor.com>
 <c2548e16-7251-4d1c-87a2-f1c09be83e3e@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2548e16-7251-4d1c-87a2-f1c09be83e3e@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jul 03, 2024 at 01:16:29AM +0800, Xin Li wrote:
> On 6/28/2024 8:18 AM, Xin Li wrote:
> >On 6/28/2024 2:36 AM, Hou Wenlong wrote:
> >>Hi Xin,
> >>
> >>It seems preferable to parse the FRED command line and disable FRED
> >>early instead of using this method. As mentioned in my cover letter, I
> >>initially attempted to fix the problem this way (by parsing the command
> >>line in cpu_parse_early_param()). Should I send a new patch for it, or
> >>will you be covering it in your work to enable FRED early?
> >>
> >
> >I have done it in my patches that enables FRED early, but if you want,
> >you can post it, because you're a key contributor in this work.
> >
> 
> Please let me know if you want to do it.
> 
Hi Xin,

Sorry for forgetting to reply. I think it would be better for the fix to
be covered in your work.

Thanks!

> Thanks!
>     Xin

