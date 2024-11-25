Return-Path: <linux-kernel+bounces-421608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1675F9D8D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB249168A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3191CACE2;
	Mon, 25 Nov 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YAoXMW4H"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DE1C1F12
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567320; cv=none; b=uY5RpWBLNdgtC0MxnPVIMVdmMGf4wXukwXWsPxrchx2NfN8LNyQ4sqfaZnT+sd55ev6hnjAT6nciitEncsqZSjnC2azfATpvSDUl8YLLJon+KRHnDJ3lHC7kACCtAAkHtoNQROVPO1BYs/Ab/5VMH+VCmGlqkOUH85MLZx27Ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567320; c=relaxed/simple;
	bh=ReA+kPmFXMbw3eOv3VC7mKwiHlmGrg4UtjrPQsnrZ5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=N8o4r2c3iCNzaCi6OcKl3FwVJCStE+QiijNGgiQG3QJpZXAe0T2vexYGGa42DDeT4qLXjEZQLHo7nayoizl8623hYFtKLVnBeQWPNsHz6QBIloYJz1iXFo8abjhmkdPSstbuB8wi/auFFs5JfHT8gvOHaPGWAOnN7SlmAQ0ZJxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YAoXMW4H; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732567314; bh=Ww8ymWld/54PH7NEfc31bZpEi1eGB+0ujGhmZWVOR/M=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To;
	b=YAoXMW4HJ+lEZsRd/XeyFpev46ptrLpWbQNwjgUfJBSn1AMMJPJZsRLbrQoXF5SBh
	 jXa9GGi2LSJU0t5Onxsd2Oz0pvi4ZrO8GeEt9SRlLj3Wx9s27ya+QQvbFpL8l/F8RT
	 kljgMgMhCVWv6v107Thtk5v4sC/rIaOQOizpv0+8=
Received: from [IPV6:2409:875e:a030:1001:14::e66] ([2409:875e:a030:1001:14::e66])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id A74A64D4; Tue, 26 Nov 2024 04:41:52 +0800
X-QQ-mid: xmsmtpt1732567312t0aqau5o9
Message-ID: <tencent_34E779C5B2F95F0FBC11D21B2C0B4FAEA107@qq.com>
X-QQ-XMAILINFO: NR+Rloh0s0m62UlB+jwenGjsf9qdVIL04YIMRK48Zkb3FOWJ8LflXXJVp7lie/
	 y4YMVXcpyd8Bm2q9igjZLE3mR9dJO8CKgWIMB/RfW7nb/BOKZfCOcFhT8t0arN494QRJAsYN0iuv
	 WgUK/4BVY3N9Ab6hPY91Cd3+xqVvUzW4aTW7hZA4uiBNoD2xcXBHxxFCSrmfXJQw2LY978HMwx2U
	 TiMqrBoMTgMHxMQzBjfg163CUcITp2NKaGnsK4/PPqcxflEFin954xVI6fg9XEP3bbPzO7iyM44o
	 d7KErOxXwJSePUUCrXzzrOJjWZbOYBGY8F/qjHsCQwhk+kkSU/DiU3RUg1WtNekGfloxWro40e6R
	 vJdoolDzcAAWyQe/6cyGEUFqgFbn21BjXbNMy26dzhlh74C49Xud44r+KLnyELlcy6ydvx5kBV5n
	 M4MrvHQ7D/u4YU0ue7rDwnNPG1/rgv4XDwolh2eJzp5fUvTLyqpzSutg8oS0VyViGkoyDdepMjun
	 QpV5SxYclLYDK9ryu/xYxEwgYBVzvkXbSc67KBnim9RH9ITsCetusxDbhxsLknhvbmuJCrHvA1PQ
	 7hdwhGFFjAFjXsmP9oDeUf80hseAqEfhwrYLjQQAmpekM1DzO/afNVjItY0QEAnR2Jsrl3VnQxVl
	 LJhwDQV87qEArkINEgiXhFoM8b2B+K+HQgTkL5W0hNM++JtsGd6l4v/w9amVdeeYBKoayqZK3USv
	 S+ooWfUqB+q9GHoW19FCtHtNL74L2dR56m6EjOPERkRTiT/3J6zwbezbyA3M5emhMpxFwehm88vK
	 IYoHezjNbbs+8Hb4jZzFFfDRdPfwwfqCeX0mtpQTEN89UO5d8PIConoFMADkrIGbRMr9RFoFLiFL
	 BhSlMu3UO5xZ4S0TzY3E+NCvKSJ4lRP0I/wpdgRC8Td2VIhG3ze9cq/zPY5VpkgDbihUmFHt8GgB
	 Wua1QIypYd1z4L5x3KxIsYbsPlN4Wrx0gTRHbr4Q2c/aC5Cn7orKlLFR0ISUmvpwTY8Hr4CeR+KB
	 uCNBi+Iw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-OQ-MSGID: <c1b4ca83-9779-49d1-ac94-e34c1fa2e381@qq.com>
Date: Tue, 26 Nov 2024 04:41:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mempolicy: Fix decision-making issues for memory
 migration during NUMA balancing
To: Michal Hocko <mhocko@suse.com>
References: <tencent_57D6CF437AF88E48DD5C5BD872753C43280A@qq.com>
 <Z0RgoOHMRFCTM1JB@tiehlicka>
 <tencent_52B8009E65148BE7B93C42479E6E642C0409@qq.com>
 <Z0TbpP02utF1lBzJ@tiehlicka>
Cc: akpm@linux-foundation.org, dave.hansen@intel.com, gourry@gourry.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
From: Junjie Fu <fujunjie1@qq.com>
In-Reply-To: <Z0TbpP02utF1lBzJ@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On November 26, 2024 at 4:18, Michal Hocko wrote:
> On Tue 26-11-24 03:45:01, Junjie Fu wrote:
> [...]
>> I apologize for the oversight when reviewing the code regarding the process
>> of setting only the first node in the nodemask for the MPOL_PREFERRED memory
>> policy.
> 
> There is no need to apologize! Really, this code is far from
> straightforward and it is not easy to get all the loose ends together.
> What helps though, is to help reviewers with the problem statement. It
> often helps to state whether the fix is based on code review or it is
> fixing a real life or even artificial workload.

Thank you very much for your understanding and kind words. I truly 
appreciate your helpful suggestion, and I will make sure to provide more 
context and clarity for reviewers in future submissions to avoid any 
confusion.


