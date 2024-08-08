Return-Path: <linux-kernel+bounces-278763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4D894B474
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CD1281B75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4FE4A28;
	Thu,  8 Aug 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YUIm9eJd"
Received: from mail-m2424.xmail.ntesmail.com (mail-m2424.xmail.ntesmail.com [45.195.24.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FC1854;
	Thu,  8 Aug 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079432; cv=none; b=fJt9iXh/bSThA8965NG3NsoBXdlkXjMQMJZq62aJzKqYLZK5pySzMuxJGBLSVnu3cczeR2TU8xOx/0do54ta/hZ1OexKHmQ7O4cRBS44NJj/s8NrUiQFK8AWDEBYv4rHdFOs+OyYDlTf8OM3ZhwzSeYzBOW19SXuEnMG9iIz8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079432; c=relaxed/simple;
	bh=dh1ak82e9XfXuV20OTVOUmhuXF7NnOZjNWRze+CvXIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eey4i0TX0EIY5WlvQ09AV0P4LtVkFtLfiKwIKROBrffsxWZNkG3a7CzRZITFWMDYaKhoMr03lj3ofvQEWt+tO0KKauZF1SQd/bWvtMGQWoxccYqoklH+vGPA5jHxS+VaExfUuc+TAdRpR3Cx2K+w1mYkkHM7MCpw2VK292VJLPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YUIm9eJd; arc=none smtp.client-ip=45.195.24.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=YUIm9eJd8vgxIDtf5OwCf7W46znutQw3GqwfC1dBeHC7zswhnuw0jGQnanPc2phYovI5/QtNqUmrFEsplTI+CJQZ6SK61eS6khTe+Uhz6aI752QJIckZMBX8CDy3MYg7H3Md/96BD0rKaCdhv3VLlShAuFvWhZBCR/qfli/t98o=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uqG3/IZXzJ43M58oVjKKr6TZYE+/bhrYky3foWhb+w8=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.49] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 8EA23A025A;
	Thu,  8 Aug 2024 09:09:54 +0800 (CST)
Message-ID: <e407b8ba-e72a-4b53-af8e-7dbb58420b07@rock-chips.com>
Date: Thu, 8 Aug 2024 09:09:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] clk: gate: export clk_gate_endisable
To: Stephen Boyd <sboyd@kernel.org>, heiko <heiko@sntech.de>,
 mturquette <mturquette@baylibre.com>, =?UTF-8?B?5p2o5Yev?=
 <kever.yang@rock-chips.com>
Cc: linux-clk <linux-clk@vger.kernel.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 huangtao <huangtao@rock-chips.com>, =?UTF-8?B?5byg5a2m5bm/?=
 <sugar.zhang@rock-chips.com>
References: <20240806073832.13568-1-zhangqing@rock-chips.com>
 <cca491b4b4f5716e634f7c0ce0c574af.sboyd@kernel.org>
 <2024080709283455745026@rock-chips.com>
 <d673b1539ad5d4abfff29900461f9209.sboyd@kernel.org>
From: zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <d673b1539ad5d4abfff29900461f9209.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhDGlZMTRlOS05CHUwaHRlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a912f89073c03a8kunm8ea23a025a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46NRw*GTI9HxRJSioDLhIy
	ORMwCiNVSlVKTElIS0xCSEJOTUhNVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhCTkk3Bg++

Hi,

在 2024/8/8 4:57, Stephen Boyd 写道:
> Quoting zhangqing@rock-chips.com (2024-08-06 18:28:34)
>> Hi，
>>
>> Some modules, which need to do workaround, need to disabled the clock directly,
>> independent of the reference count.
> We don't want clk consumers going behind the clk provider and turning it
> off and on. You'll need to figure out some other way to do this. Are
> there really other consumers besides the one changing the pin to a gpio?
> If there's only one user then it seems like clk_disable() should work?
Well, then I use other ways to workaround module problems.

-- 
张晴
瑞芯微电子股份有限公司
Rockchip Electronics Co.,Ltd
地址：福建省福州市铜盘路软件大道89号软件园A区21号楼
Add:No.21 Building, A District, No.89 Software Boulevard Fuzhou, Fujian 350003, P.R.China
Tel:+86-0591-83991906-8601
邮编：350003
E-mail:elaine.zhang@rock-chips.com
****************************************************************************
保密提示：本邮件及其附件含有机密信息，仅发送给本邮件所指特定收件人。若非该特定收件人，请勿复制、使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件或其他方式即刻告知发件人。福州瑞芯微电子有限公司拥有本邮件信息的著作权及解释权，禁止任何未经授权许可的侵权行为。

IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material in its entirety in any format. Thank you.

****************************************************************************


