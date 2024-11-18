Return-Path: <linux-kernel+bounces-413195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDF29D14E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1641F235C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0E1BD50D;
	Mon, 18 Nov 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SZmHrNSA"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D91AA1CF;
	Mon, 18 Nov 2024 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945673; cv=none; b=ESkPfogVxfC4r65vWpFlWtluI4J67aZSy1IcQHX35a/jImlqBWuIB7EyENTHEUqhJeMjFxtE3Rrgg7hvqzd09JyTjXnKP/ywHi8ipMQ055E4CawlnXgw1hZnN1Y7joy8PYlYmvJ4+tIhLzxwt6nPiSQYVIt8d8S12ysp8Rcgoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945673; c=relaxed/simple;
	bh=0SMGPScg1OjGEEbWukEQ6UEnHRdruCh0flCAnhLlwm4=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=WAe9MoFKCOLw8DoU63aqO0OADAhR9/Ctv6ObBahXp5F3lbMWKKFVRhSUOdDS3HeYxdrsLULfQwGPyiXCH/7fSH1MlSaBlwen6KLCkbgSEId6DOC2mLzMYCmYPhyO+MZwcpD8Leb885uRXXt2ozcD4neltUUPitFP3w/ML2Is5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SZmHrNSA; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1731945656;
	bh=0SMGPScg1OjGEEbWukEQ6UEnHRdruCh0flCAnhLlwm4=;
	h=Date:From:To:Subject:From;
	b=SZmHrNSAOq7GV74u+Cs1i88M/1ilJ/6mR48UMHfOiLMQ9KJ6ChgSzjPRNB2MSVv4G
	 HWjuL3ywCsRkxUMlE1H9LJypsuCqY1pdG2TKe0KqmkislM549gGtvpBY+XDWVeFlDk
	 2OFsdZ9xkuGxXfEabNWyGjn6kbxpRYU7IPOFhTMThC+nCdLYkccmZ7yaH5b66ad51d
	 sp8bclvYZBmgGSLKmNlhm67K+6bH5YcHIcsAFPwqMKWDTfyK4WD8rdRnfp0X9aApTg
	 1nloaPXQYovhttmk/nl8+HxLO0XHeBP0yHUWdXBYt2yinjqw7KjIHstdCC20v8smSJ
	 lUWyLyA43ulwQ==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XsXRD3tntzLkV;
	Mon, 18 Nov 2024 11:00:56 -0500 (EST)
Message-ID: <577d4fa9-4d0c-4ff1-ab2c-d4cc088e21b9@efficios.com>
Date: Mon, 18 Nov 2024 11:00:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-modules 2.12.19 and 2.13.16 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is a stable release announcement for the LTTng kernel tracer,
a kernel tracer for the Linux kernel.

The most relevant news about those releases is added support for
the Linux kernel v6.12 by LTTng-modules v2.13.16.

Detailed change logs:

2024-11-18 (Odd Socks Day) LTTng Modules 2.13.16
         * fix: mm/page_alloc: fix tracepoint mm_page_alloc_zone_locked() (v5.15.171)
         * Fix: uprobes: make uprobe_register() return struct uprobe * (v6.12)
         * Fix: silence 'non-consumed' message for non-started sessions
         * fix: writeback: Refine the show_inode_state() macro definition (v6.12)

2024-11-18 (Odd Socks Day) LTTng Modules 2.12.19
         * fix: mm/page_alloc: fix tracepoint mm_page_alloc_zone_locked() (v5.15.171)

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

