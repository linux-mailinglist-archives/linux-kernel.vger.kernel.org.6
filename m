Return-Path: <linux-kernel+bounces-366628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF999F7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E3BB21D71
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF51F668B;
	Tue, 15 Oct 2024 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="IzUCzDB6"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F71B6D01
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023375; cv=none; b=pc+pE3DSlPUq+G5VEeH6NrlQxRroODWBRidcKE7QCcPdEWxYF9vsVKeqsTy46CZo5h83+xtaoi2o2PqdMR5xmKLzU5g7CYOmeIOXFMHTWPzf+MiHySeRojBtS08oYgczBbk29YDlZT/aJ2bdMyI+qkHLlnBkNZQswB+2rhEqT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023375; c=relaxed/simple;
	bh=tu1QoClbkObUUASz2k72n5n9x6U9Edk37FHc0RbrcK8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=OX1GvQi4Aut3cXI/ww27htOgj+8n1UWXHDm2bHe5/goEMT3+VApm1BBmFClVXx6+cJ7BxKQeLH35ECl09/1hcapoHtoIkSG8htmghCdhYJkr50jU5rLMSjnt7rCOtolfcYgtdy0EUfwnVV1S6F7xuZtnVsEnx1FsOxexXXNJuH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=IzUCzDB6; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E36A82C03CB;
	Wed, 16 Oct 2024 09:16:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729023369;
	bh=n+f8WcwPeAeJHJNpFk2AM+E9vsZVL3Pq+k16AJ57gbQ=;
	h=Date:From:Subject:To:From;
	b=IzUCzDB64DbWMlDDv05shZusOcYCAhnUoQ1ji4XpnMSx94OqTIU+mkSWA87PxYULt
	 axS4g3CZCjHsVm8KvQFyASTtuCtl6PuBPHD83W8b9dbDi3u6hG1NyPQPHTGrEoUATz
	 yzzT041ANhXvp1D8SLDoyT94SF1T5IC5BgzvkP3csPIqqKaA+PHgBXJVMiF7NaGYQc
	 EpTLnZnk35hmzjpQb4bQAacSmrxSxMCwdwI478nT5tqU76X4uUCbesvuX1mcLmbl/r
	 qzlI7+bP05PBSYYRoVACM28CWTkJ86zizBKaH2Tol30RvJ8qFJ7E+bEBoYcMvky8mM
	 8p8LiqeX8DBkA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670ecd890001>; Wed, 16 Oct 2024 09:16:09 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id AE02813ED7B;
	Wed, 16 Oct 2024 09:16:09 +1300 (NZDT)
Message-ID: <269854a8-1041-4ba6-b022-ba8ec15c6b78@alliedtelesis.co.nz>
Date: Wed, 16 Oct 2024 09:16:09 +1300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Building out of tree dtbs
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670ecd89 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=p0WdMEafAAAA:8 a=YRHvXXt1AAAA:8 a=w3Su-nGi9A_OhNgBJrUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=9bw_jnHfPby8klRCszyn:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

(resend without HTML part)

Hi,

I just noticed with the latest 6.12-rc I'm no longer able to build an 
out of tree dtb by just copying it into arch/$ARCH/boot/dts (at least 
for ARCH=mips and ARCH=arm64) and running `make my-board.dtb`. I believe 
buildroot relies on this as well[1].

Is this an intentional change? Is it too late to undo it (or provide an 
alternative way of having out of tree dts that make use of in-tree dtsi).

Thanks,
Chris

--

[1] - 
https://gitlab.com/buildroot.org/buildroot/-/blob/master/linux/linux.mk?ref_type=heads#L516


