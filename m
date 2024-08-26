Return-Path: <linux-kernel+bounces-301148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6295ECFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F64A2820DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D661442FB;
	Mon, 26 Aug 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LhswITIy"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BC914375D;
	Mon, 26 Aug 2024 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664019; cv=none; b=X5o2zMsvU4+Xo8zTFYix6Chedp5ZDLqp8b6kEN/Hx9D9h4M4Q0u+I3flbftCXJFxMrxM/c60HwSHAnw+Y/YkRtOHaANOJX/BkXFA56YqkewlJBYgX38IA5zcM9P5b36aSe+st86H9Jsf70FOqJo1t82AGIZorxYDbGhBvuXXTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664019; c=relaxed/simple;
	bh=6zrjWfovnvYVHQDbwv7GoLqzC0b6r5Yxmo9gaCadhxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKh7DHnIidiIxdiiEo8YOM2FwMpIfCKMu5Enl1ZvNpMUvltgzIv1CHs4y/G7DFMUWnS047g8BAGnkmrUtu7Ci3yLv/PExfr8jcwZARJX2JqqyyOyl2qy0YNnO2cTJLY04H0rVpX4jmwkCm0y2G+C8IdFlSTLt7nLtReEggGEVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LhswITIy; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IcuTH
	Jg1CEcLyJ6Hj7fC29x6ffUfHfVqLjTyQcDWcvg=; b=LhswITIyOB3UcVEBgYlev
	m05g4HrHJySYQ55JJTBSSo7d+qdTLj5+ZjNHVYvBsrtqwTq5BSUErMnzH5YtcS5w
	6bdNzXGpIDto5XfP/ZRpO9FRNCxeT0CB2X9+ToU58xsU3c5EOrPU/GQxbfqlZlyc
	KEiVEn6n32eTLEJqoRloK4=
Received: from localhost.localdomain (unknown [111.48.69.245])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wCHrTK_SMxmBnzbJQ--.41842S2;
	Mon, 26 Aug 2024 17:19:59 +0800 (CST)
From: soxiebing <soxiebing@163.com>
To: tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: fix snd_hda_bus_reset when single_cmd is not supported
Date: Mon, 26 Aug 2024 17:19:58 +0800
Message-Id: <20240826091958.44375-1-soxiebing@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821014238.338864-1-soxiebing@163.com>
References: <20240821014238.338864-1-soxiebing@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHrTK_SMxmBnzbJQ--.41842S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr43Cr4kWFyrKF1UZFy3twb_yoW3WFc_Gr
	WFkFWkG3yUJF48uayFg39rZrn293W7W34rJryUXryxtry8Aa90qrn5u3yvvFnrWF1Sq34Y
	yr40krna9r1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_LvttUUUUU==
X-CM-SenderInfo: 5vr0xvpelqwqqrwthudrp/1tbiRB9Fw2VOEav4EAABsl

>On Wed, 21 Aug 2024 03:42:38 +0200,
>soxiebing wrote:
>> 
>> From: songxiebing <songxiebing@kylinos.cn>
>> 
>> When an azx_get_desponse timeout occurs, ensure that bus_reset
>> can be used when fallback_to_single_cmd is not supported.
>> 
>> Signed-off-by: songxiebing <songxiebing@kylinos.cn>
>
>Why do you need to change?  Does it fix any real problem you faced?

Thanks for reply, i am testing all these days, but the problem is
still exists even if using bus reset.

The problem i encountered is that hda_call_codec_resume returned 
timeout of 120 seconds(defined CONFIG_DPM_WATCHDOG)) when doing s4, 
azx_get_response timeout occured, it is a low probability event.

To avoid exceeding 120s, can i change the count value to 3 in 
hda_set_power_state ?


