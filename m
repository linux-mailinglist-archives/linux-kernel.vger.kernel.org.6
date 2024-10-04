Return-Path: <linux-kernel+bounces-351366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD4991014
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9281F273FA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3CE1E105F;
	Fri,  4 Oct 2024 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NMvq8+dr"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029C1E1C02
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071645; cv=none; b=IFpdwyOIQdh1/7L/bgm/ahNoh2stig3XuJ9dICEC3sV4mFE6pH86hyVPXsxrsA7SdrslYMpny5KjvNTXWXqKm+hdzEyvjuCwt/Q+V87FOCVdaS9zVOiczeBwxls3hwOXJKjSwbw0W/5KVssffkD4muqMowHwa8e6rGf9dPFRS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071645; c=relaxed/simple;
	bh=yr1t1az1fkPrbfZmPqn86xgCIBPXbCa19mAD4HFmjIM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=bHWllwiMuivkdIi/rhjkdVNbWHPe4jhrh0XgOPEVCvUuS//LplQtus0M12Ul50rEBXiN+mFSpsUZOk48tjTM13+SRPpVVof/9X5ajA7R6ArlY8DN1t41+M8/xSRBY0fgjpGZJD/U/6PF8aeDPzzdJwxhz+6Y5nxdYyeeI02WiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NMvq8+dr; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728071641;
	bh=yr1t1az1fkPrbfZmPqn86xgCIBPXbCa19mAD4HFmjIM=;
	h=Date:From:To:Cc:Subject:From;
	b=NMvq8+drbdLjlqeWhKFVim9TbbihnWtMgEHmGa/djhNYlxMyQ6lDCS70VmYNxs2A4
	 EiLQYDfFkn5p5CMErh+Ar9LZggBZzO30qhq/bmwya0K6GMu26VRsWiXM5ed7ve17ER
	 CQNZEnX7kPHAYzrrgE0nxGYCOJ3kb37Gjm6Y6CK96EuMmi5i+eJMYEgp9eL0phmcpU
	 +x8+vJ/V7d6QZYNjgjaZl8XA/VIxU0JUlzOqOAOARQLP3o5H3Mh+PIjkBcRrgGG4IX
	 0yRms5NpIS09aLP6mYdkKHcrwFKeYxq/7/wpYxGgtED2yLOq9CO2CiCmve/FcJFt1V
	 ioNiBLH37RzaQ==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKzkx4kVxzNbN;
	Fri,  4 Oct 2024 15:54:01 -0400 (EDT)
Message-ID: <3b749585-1286-4a4e-acd0-1534b60172da@efficios.com>
Date: Fri, 4 Oct 2024 15:52:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, paulmck <paulmck@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Hazard pointer enabled refcount prototype
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

After our discussion at KR2024, I've created a prototype adding hazard pointer
dereference support to refcount.h:

https://github.com/compudj/linux-dev/commit/234523dc9be90f1bc9221bf2d430c9187ac61528

Branch: https://github.com/compudj/linux-dev/tree/hp-6.11-refcount

It allows dereferencing a pointer to a refcount and incrementing the refcount,
without relying on RCU.

A good candidate for this would be the "usblp" driver which is using a static mutex
for existence guarantees. Introducing a refcount as first field of struct usblp
should do the trick.

I am not entirely sure if this kind of use-case justifies introducing hazard pointers
though, as this can be done just as well with RCU. I'll let you be the judge on this.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

