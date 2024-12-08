Return-Path: <linux-kernel+bounces-436408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ADD9E858D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 14:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9937A28166D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB614883C;
	Sun,  8 Dec 2024 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="S6N+gtE3"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3A13B59A
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733666123; cv=none; b=IDg2VPQ331rTUk7u2KeFw5P/xX29CzBLIZm8VEn/yKp8XOlC3a/65LcdOXoLmKckawb3aw8Hefz7z9aljQCvManK/BCF+uSsXuQ38EWb91QD6ldSCkgcPJUrNWGYn73jbndQJGqJrcfjHpxNUWC9cXsouNreCnvHF7NsI5UGVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733666123; c=relaxed/simple;
	bh=oZliOEkC0ZvWc5JlqrpBQPEHcKqVJEOSPtpnDWIvozc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=VBTm8ODOc6eVDmLilDNEmAPkRw0IQjHuDfMcH6iPLo3vqjP9lKg/PVjJ7MxCusqgewFppuyUMMjQi4O6uF8sWL6Mj69A7TDPejR+OsZmpYVSV40DzC4TW5m7d7fAuqJSZZz4G5SLXXmhN7hH89p52qOw9amu/OhlCpt0dpUCbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=S6N+gtE3; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733665809; bh=BZYvJo1qCFozwUl5OiMXNjuTzLKS0lZbicCI5uzJH4Q=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=S6N+gtE3rDmWdeugiypaCxaD74gxiEFMvbTagdRP1tPE2PiGiRDiGs2hUH+zV34lO
	 /ancf8WGvGm5IO9P8FGYkicYb+3lZWPkiSrcR95mv4hWRY60Yru88w4Zjh1RuAKF8g
	 hNjV06DVRu83iyLq2Dum4ZtfCWmbnBNQnjbvgGJk=
Received: from [IPV6:2409:875e:a030:1001:14::e66] ([2409:875e:a030:1001:14::e66])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id C8790CAD; Sun, 08 Dec 2024 21:50:07 +0800
X-QQ-mid: xmsmtpt1733665807tjgkympcs
Message-ID: <tencent_C722D2FCAA87D408E78D8E452E17C6F3B906@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No6iy5gp/z4MecSTaeEqWcjw/8utYM7xr3RYG95WO4LQR4iS3BYg
	 +DN58pYutgQ5HtBkrPnE2IaXlcmzqjpOdwvWHcdyu0ipuWEd8UJ//ksdAQmyv80hmIoM0/obQROa
	 g6IO1Nlqb2VxkAl777jE+QiTum99++AdS1YjYMw/O+f3u1tHvwoeGhXENKx5ANP0Cgyc8etUaROP
	 XMFbYpV5kYR2aYVFobxU6vjLzopjhhS/yrVI0x1d8mB4JmBqY8U95qIisGwxyGJRFZZq/7ym4+XD
	 qXTqII+6OeeN0VAtyP3gmc6A1OnTfNhiWOv5Q7fLcmdKnohgt+6brQrrNYAt5yRZcdXHdaoLrFtD
	 HltqtxWehKJAIZPEHDt/7EF1hqLaTBiBrGFk6NF0U5OMhuOezWCEeOjwO79LlLK+qR/8CmlMlcAS
	 47C6KbjJmmAoa+k+NGlq3P+kOXrWJEnk/Xat65qWLuN55BrKH8atbc9r+aX+pKwgDf9+LPn36lbJ
	 tc9wc+hwMlpI326yfMIDN4HcyxiCfxAoVju8KyMUbumiVN5J5sN8ZXnOu5qoBYNbAo/b//LvymsG
	 VWiGNvnb7UpMm4s7Je8wdoZW1k0SYFKlQlQugUC1jq1EldrZcQqHr+VDx8h0Uv2bKa9nlwJ9Dr/M
	 Fa2KWHzD2TA2DYVkajPv2j+/H+rxuL10NeCRuaarktheAJI7roLUcgoa4zFIBjgHww73Mo3xAdy7
	 HhiQcD2zlEdE/pl97lRhiOK8VCgjhDmk+oM3+YMWXurBRcBRw6QMnt/cOr2HtlUE8jIZqAvEtqyV
	 0eVprEBg7A7JTV7taTazclBZ39ANZth+dhaEcIGzooRfXmmLXDTbGkt8xVGhp9BMFe3BQSqJ/sZX
	 6h8zOLdB6MLKnr3+rTC366mgm0OBXpSm6mM0wiYc9NhJ0cM5ZD/tFg6HU3Xypop7ST2yTKPUVDel
	 kGLcKv5qX2CO5eMMK5Fo8OBbb4s59f
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-OQ-MSGID: <ce9fac4b-8d1d-453b-be50-74802dbc230e@qq.com>
Date: Sun, 8 Dec 2024 21:50:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mempolicy.h: Remove unnecessary header file inclusions
To: SeongJae Park <sj@kernel.org>
References: <20241207195341.279560-1-sj@kernel.org>
From: Junjie Fu <fujunjie1@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
 gourry@gourry.net, fujunjie1@qq.com
In-Reply-To: <20241207195341.279560-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On December 8, 2024 at 3:53, SeongJae Park wrote:
> I noticed kunit UM build errors as below on mm-unstable, and git bisect points
> this patch.
> 
>      $ ./tools/testing/kunit/kunit.py run --kunitconfig ./mm/damon/tests/
>      [...]
>      fs/aio.c:525:71: error: ‘FGP_CREAT’ undeclared (first use in this function); did you mean ‘IPC_CREAT’?
>        525 |                                             FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
>            |                                                                       ^~~~~~~~~
>            |                                                                       IPC_CREAT
>      fs/aio.c:532:17: error: implicit declaration of function ‘folio_end_read’; did you mean ‘folio_test_head’? [-Werror=implicit-function-declaration]
>        532 |                 folio_end_read(folio, true);
>            |                 ^~~~~~~~~~~~~~
>            |                 folio_test_head
>      [...]
> 
> I also confirmed including pagemap.h on fs/aio.c as below fixes the issue.  I
> would like to hear you or others opinions though, since I'm not familiar with
> the inclusion routes of the file.

Including unnecessary header files in a .h file is not a good practice. 
It can lead to troublesome dependency issues in the future. However, 
based on the testing on your side, this change might cause some other 
compilation issues, as indicated in your patch. I think all these issues 
should be resolvable by including the pagemap.h in the .c files instead.



