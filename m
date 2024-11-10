Return-Path: <linux-kernel+bounces-403371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B99C34AF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7BF1F21646
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389C1531C5;
	Sun, 10 Nov 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="NAy9tZrN"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDA1531F2
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731272815; cv=none; b=Uilavst5APiv6UaQ1eNQL4Tf/I2E5wwcFnXRRx7fzcJSRDXSdvl5qvNJvhyPHRhY6/otOmzM9LkwieMKASLuS+p7mbSTnkaLtGpWHMygEgtRpSZueSi5IPGSgd/q3wDaWonOqBc2ixvCGLpxvPQbCH/WaApMBq96g/6160VM3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731272815; c=relaxed/simple;
	bh=RoImXjp7MGcwr2e4G5suORPS+HAf6mNHd56YA4Mr25Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5ZyL8DrJ14rO2JbJi21dK6DdkSuc0C6EuQ1ZhYSpUTP/ZNZvXYT7eo38/MmARb6RMAbC899gC4i0a7sruxfxmxnYSSoItKI87yG1xZjegsubH7V75dmdifZYv60dBl5JA+MOccDfpcH8nTEM3kQsDpOhkXR6x/GmkFbAgD7nas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=NAy9tZrN; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id 9dPJtRENXg2lzAF8xtx6DQ; Sun, 10 Nov 2024 21:06:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AF8wtMaDt2Zy0AF8xtJQaS; Sun, 10 Nov 2024 21:06:47 +0000
X-Authority-Analysis: v=2.4 cv=Q4EZ4J2a c=1 sm=1 tr=0 ts=67312067
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10
 a=-Klr6mLr8pg6UDE4wXQA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o0adg+1j4txtlNvaOHyqcPDOTVdpAEqtR1MV+0wO+Sw=; b=NAy9tZrNaniaQh4hyIvSgpyzDD
	V0XirQl0MX+kQO9HdMzmjwyDcuYiVYhWWBm7H0zgEbRnZhkSnVMu62462gQ5QXUpeFJiV+Y/xEdh6
	Bp6h2z+SUg1wBOadFIbo/gwBlbVEXo27RyB2RCRQlZ2fnytt0VhMYHo6zjX6ZgupvjBL8U1CPYeOr
	dxOJZu94C5VPzZAui9oiek7Jev3VBlRjoV8eKk0oPN4UCvDpwCb0pE+e702ndeRHq32NL9uVVvigE
	bKjVpDI0N62+j4AS/937s73ndjDHobyxriVuAsR2XLP8k3C9rdGpN0qrUU6DpGMYB30QW5yxRYSFZ
	VqUsM5sQ==;
Received: from [177.238.21.80] (port=43976 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tAF8v-0045Jd-02;
	Sun, 10 Nov 2024 15:06:45 -0600
Message-ID: <8bc69322-f630-4235-9ee0-501e02623dd7@embeddedor.com>
Date: Sun, 10 Nov 2024 15:06:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: Replace zero-length array with flexible array
 member
To: Thorsten Blum <thorsten.blum@linux.dev>, Lee Duncan <lduncan@suse.com>,
 Chris Leech <cleech@redhat.com>, Mike Christie
 <michael.christie@oracle.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
 open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241110151749.3311-2-thorsten.blum@linux.dev>
 <202411110336.IDRXgcR4-lkp@intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202411110336.IDRXgcR4-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tAF8v-0045Jd-02
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:43976
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGfM6HGM350L3q71zRWG2G4qgb7xsU2BetqKsm1d080zUrKLwJgMTUbdBzXIThMRG0cFseAhdtOnbXepVOpxfCN6q4D0ilspz1IngTB/JnKyORxyFX3o
 fepIbEQv4Zqkac8hxgpCw7ohqXdtEsX/1skxpfMFBNquTK63vMeHqsn1qDX38+dIRnTP/unSgf7Jl2Fxeywa0wB4y3uZP5AWPrpKPAtXDb9gkILM/oqN04iZ



>     In file included from drivers/scsi/scsi_transport_iscsi.c:23:
>>> include/scsi/scsi_bsg_iscsi.h:62:18: error: flexible array member in a struct with no named members
>        62 |         uint32_t vendor_rsp[];
>           |                  ^~~~~~~~~~

This won't be an issue in the near future, but for now just use DECLARE_FLEX_ARRAY().

Thanks
--
Gustavo


