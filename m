Return-Path: <linux-kernel+bounces-405229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAAD9C4ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9250028958D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC88208962;
	Tue, 12 Nov 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dteLER5Z"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C65234
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393465; cv=none; b=NhGSvaxSZuqKdWiiB5EHEwCSmPPBFqkdJ5femIjqK5SAzxXSnxP0SRoVp6IcEaYuPUsWwZ2lZHWW9dCBT4XItZK9toPnr2q8ZWNiU6PBQilCPTzRis3nxqcfoKHC9fPa69eMp9q33l0NwcPnNV0R/COMFnmAXDkDarGIfdY4Xug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393465; c=relaxed/simple;
	bh=DIhoDMs+ocERMPWwoBsCd61ryEJMxq66Wo/FyZ7XV6U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=blJvf4i9Z4+pPQRpuogSnACpLkTF9lAQzjcuNPUWrQ2K1/TLU6UobXFeP9lXQeQlNiGroY/wtZVPiOi8Ldevz05wy7Rr/sKmROPLDaEDgvOX8KNnDl+1caGLnOT8+OEfSlWnTufvItdezBqgouYZlvKWYvhP9GMDa6e5bJ1seJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dteLER5Z; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from graphene.canonical.com (1.general.amurray.uk.vpn [10.172.193.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D87FC3F1E0;
	Tue, 12 Nov 2024 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731393454;
	bh=GKUKx7XUX9NIQn1HWD9NcfpALG4TSgUzvapWP/4X8Ok=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type;
	b=dteLER5ZEWCoo7LZPCZX1d2E0jXEllQcd1l3Nj4mr2E5bFemED5bJzyF+vbfpxvr5
	 EQhJDnJhWhm2cdll7NG+7XYOhxyQssBkExhhs7pkEYBqGc3LXHeo16lxFbH/+QPl+H
	 sYJrWvVHLsShqj9b2owPIHqsLY0l48lJfkMZ7V8AwtYEI3spQEIzgA74Z9OApCtW/Z
	 jJZucXJHuNXQaApFd6JNpptfjh1zInyL9tmQvXPtSINlkfrZe7Vohxq7OEHs9T6Zk/
	 fREDfiQ/9yQyUvq3G95jpxUAdburKeykUg4GOTJo2xjlCBcqWHtggk0CBNi2pQ50A2
	 nBNQ2zHzrI/bw==
From: Alex Murray <alex.murray@canonical.com>
To: dave.hansen@linux.intel.com
Cc: bp@alien8.de,linux-kernel@vger.kernel.org,tglx@linutronix.de,x86@kernel.org
Subject: Re: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode
 to be a vulnerability
In-Reply-To: <20241107170630.2A92B8D3@davehans-spike.ostc.intel.com>
Date: Tue, 12 Nov 2024 17:07:27 +1030
Message-ID: <87v7wtvty0.fsf@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> 
> == Microcode Revision Discussion ==
> 
> The microcode versions in the table were generated from the Intel
> microcode git repo:
>
>  	29f82f7429c ("microcode-20241029 Release")

This upstream microcode release only contained an update for a
functional issue[1] - not any fixes for security issues. So it would not
really be correct to say a machine running the previous microcode
revision is vulnerable. As such, should the table of microcode revisions
only be generated from the upstream microcode releases that contain
fixes for security issues? 

ie.

> +{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xb7, .steppings = 0x0002, .driver_data = 0x12b }

should ideally be:

> +{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xb7, .steppings = 0x0002, .driver_data = 0x129 }

to correspond with the previous microcode release that contained actual
security fixes. 


[1] https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20241029

