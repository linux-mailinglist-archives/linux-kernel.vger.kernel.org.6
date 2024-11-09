Return-Path: <linux-kernel+bounces-402910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBE79C2E58
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 17:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B7C1C20D54
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4CE1990A7;
	Sat,  9 Nov 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cAujAS4W"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4041B146A71
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731168126; cv=none; b=i82kOKq1NDimfufPZbmxPHAKZR0rD8r26U/IZWc5fqNW7RTlHwNPu1cabcrBQsLPBOxxyIBg31f14eQQf2rcGzlR0FZb2muI/ixCZhtRPbeYh+qIRD5Rh3Et42JG6+79jcb+gAGrnaznpdNmN/1Axm+fxwiJIukgycU+jqQeZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731168126; c=relaxed/simple;
	bh=Mdw7nV2n3qzbMl/zDyw5h7iY4qvDK6FLlPdyCOxLxHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/5yeW0VscRDlrsCKxr5wqlX9le8oHCXdVFr7a3q6t7j6d01ezR44EwaDFd7TQLGKeKF6NRYuPNzXCIAjdUCA11rBszWpJFTMufFJa1YV0wY9Vpc5jT5d6FM3OG1FRpGWAHDNxBV8PUE+5akIqfdiLoWoDh3rEuPQEzZpChbLvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cAujAS4W; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mdw7nV2n3qzbMl/zDyw5h7iY4qvDK6FLlPdyCOxLxHw=; b=cAujAS4WPGTjUjlTgbuVpwYoYt
	r/XKYZ5f2SYY9jyXqV/h+on29M9Eiak+eltf/JZG+KSjsJy8sMglD9cZWmCeEWoXZqgmxSLab44/W
	D6vIEoxBTAaRa3kuGbB5bgIcR6YKI+h8KhSZ37jWDUoboLIM7L9AtTumQm28sm86LvubxDeqyQJXB
	TIJHBxjpersRdCJCpr5YvxxkMy6g0Z3MwtfcoIgiLFYl9XtsCK1m2ONUbj/O5gZHx7dfR+87qom8h
	P0EsNfgzdNLBoGvUGGY1cwh+zdjpHzPDuDywVYXEhPGSIrk6BUDKAdSDG9PpxPI+yFEy0Dzfc2JVY
	LiA8WDvQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t9nuM-004lrl-5y; Sat, 09 Nov 2024 17:01:54 +0100
Message-ID: <bafcc246-78ec-4b4b-a7f1-fd35f0c073eb@igalia.com>
Date: Sun, 10 Nov 2024 01:01:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched_ext: add a missing rcu_read_lock/unlock pair at
 scx_select_cpu_dfl()
To: arighi@nvidia.com
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, changwoo@igalia.com
References: <20241109062905.204434-1-changwoo@igalia.com>
 <Zy9n1qhuraDfHV7e@gpd3>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <Zy9n1qhuraDfHV7e@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 24. 11. 9. 22:47, Andrea Righi wrote:
> Thanks for catching this! I'm wondering why we didn't hit this in our
> CI... I'll investigate.

Yes, that's what I am also curious about. I triggered the warning
on a 2-socket virtual machine using virtme-ng.

Regards,
Changwoo Min

