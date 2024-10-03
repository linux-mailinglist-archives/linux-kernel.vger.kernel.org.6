Return-Path: <linux-kernel+bounces-349488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4B98F6E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549ED1C220C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224871AC423;
	Thu,  3 Oct 2024 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="KpKctKFK"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1671ABEAB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982940; cv=none; b=luNtS8CgXEDzCtFrj5sXWKTWC6mbo1ClP0SYu1WU01FrcKJf9QhFe0E4zhk20IfHtCh4rPJHDEC3lyPjqu1pKIheZ+oZ7MjoXQNnOWgK4M2EkKZgr0BYwE1Em6N6o1fjAFVvxRS0bR8cMASvEMI9Lhd7C2Thbf/iTSdcjzGdttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982940; c=relaxed/simple;
	bh=nvgZo8v/XwYx8CMN/Kd1Zf4q3oflbE/LLAS2ci7oBH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctAAmz9+vP7AIghfbKjOBSwUqj14Y50H/1V3IAqDWP+CS8xdlJBKxzTUpJllzg3JQJtBvgFJZS/2qgmz6bCLHcW9MJWcl4jbVjj4wpSc/RobYRf/lDH/GgIqoaQLJRfAXccotkijWf8vvtdb2KsEl1ftPENkYginJTu38GVgoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=KpKctKFK; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id wMxesp4Ijg2lzwRH0sKgNN; Thu, 03 Oct 2024 19:14:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id wRGzseehX827nwRGzsBz3F; Thu, 03 Oct 2024 19:14:01 +0000
X-Authority-Analysis: v=2.4 cv=GeTcnhXL c=1 sm=1 tr=0 ts=66feecf9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=BXEf9FEPToR6foY5dqUA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8pMJywXUdYNAihC5TeN69Uh5MH5fG8t9KLIBI2MlI90=; b=KpKctKFK35P0YCMvSWT+sDdjBR
	S49MB/OwSRxhMHyKQzkm4mLkOY0yZHshVfRBf0AY0BFViLUNC08SO8w1jXjl7y+0KzB9DFdj+vbPw
	MmAGihM9RAA3YEMgGTcd6+ilQw5AKaai3h7xjfPDQQ0ANcVxXAWYkKGPpfBUM5W8wS7WdRRQ+pdAc
	JFL8R+8EWyIaw5eu45YKh8hS06cB2Yt3X2bLkTkyT5ftdpfv9Xabi3y9V9qnMIqbx9R4ZJz8hSJMu
	MMJz5IZDwQvgp7IakU5sBGIJJ9upuZllwauGX34r35lvqfIaVqM9mFR5YjNBwQUhj/nWlsq4RQm+o
	wEU8h5Uw==;
Received: from [201.172.174.147] (port=34444 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1swRGy-001ha2-1j;
	Thu, 03 Oct 2024 14:14:00 -0500
Message-ID: <a276cecb-ae71-4ae2-8c9b-362403dbc367@embeddedor.com>
Date: Thu, 3 Oct 2024 13:13:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau: Avoid -Wflex-array-member-not-at-end
 warning
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZsZLFS1CsHkKjw+C@elsanto>
 <ef5a8e6d-cb97-4872-901c-cf4bbec23be6@embeddedor.com>
 <30530165-0ea9-4f02-9d8c-e8abc9eda5a7@kernel.org>
 <035ae74b-5df5-493f-9835-02c1c30ccfcc@kernel.org>
 <45560975-7215-4205-8d3b-a01009c9b4f5@embeddedor.com>
 <e9a05386-54d8-4a18-8b16-4e871de094a4@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <e9a05386-54d8-4a18-8b16-4e871de094a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1swRGy-001ha2-1j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.174.147]:34444
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAFyv+GTnCcTEUBFEe6lEJ0P1sR3P8I8zbHJUPy4enILSkIMJnNHi8A4m2FzRRtboEsp2tDScMvAEIY89pCBb/va2RzUf+xUM0cEyHt1OB51GWGkdqI6
 6J/B+uLl3WJfLCHQpvKl3CBkeQRW7hyYhspmRB4X5KABuDPlf9CDAGTsRW29u96Ky03SuZzGfWe75o9uqG1SwGvtKPvkNN/KZ3R0oNwomrxPC8zGQwFTBl2/


> 
> Yes, it's not great, but I think it's better than having the length in two
> places.

Agreed. I'll respin. :)

Thanks
--
Gustavo

